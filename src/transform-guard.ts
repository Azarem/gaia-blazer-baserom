/**
 * Transform guard for notes and comments.
 *
 * `us/transforms.json` rewrites the generated text of a block with regular expressions. The block notes,
 * part notes and inline comments are inside that text when the rules run, so a note can stop a rule from
 * matching (and change the ROM), or be rewritten by it. This module finds those cases before `merge` writes
 * a note and when `merge --check` audits the stored ones. It reads the extracted `.asm`, which is the text
 * AFTER the rules ran: a rule that fired is gone from it, so the guard only has work for rules that did not
 * fire (a rule that is not tolerant of a comment or tag, an unused rule) and for the cases that do not
 * depend on the text at all (label-spanning rules, renames, literal rewrites).
 *
 * What it guards, per transform block (block name = file name without `.asm` / `.sprite`):
 *
 *   1. Comments on a line that sits inside a span of a multi-line rule (a key with `\s`, `\r` or `\n`).
 *      The span is found in the tail-free view of the file (every line without its `;` tail). The comment
 *      is simulated in the plain build (`instr ; text`) and in the tagged build (`instr ; {n} text`);
 *      the comment is refused when the rule matches fewer sites afterwards.
 *   2. Part notes on a label that a multi-line key names with definition syntax (`name\s\[`, `name \[`,
 *      `name\s\{`): a note between two labels of a label-spanning rule stops it, or is moved by it.
 *   3. Rename rules (key and value are plain identifiers, `sub_0B9CE8` -> `sub2_0B9CE8`): the extracted file
 *      prints the new name, the engine looks the part note up under the old one. `aliasFor` translates.
 *   4. Literal rewrites (a plain-literal key whose value differs, e.g. `$8000` -> `$0080` in
 *      `combat_collision`): a note, part note or comment of the block that contains the literal is rewritten
 *      by the rule too, so it is refused.
 *
 * Blocks that are not in `blocks.json` / `files.json` (dead keys) are ignored.
 */

import { existsSync, readFileSync } from 'fs';
import { join } from 'path';
import { TAG } from './notes-common.ts';

export interface TransformRule {
    /** 1-based position in the block's rule list (the number the extractor's warnings use). */
    index: number;
    key: string;
    value: string;
    regex: RegExp | null;
    /** The key contains `\s`, `\r`, `\n` or a line break: it can match across lines. */
    multiLine: boolean;
    /** The key as plain text when it has no regex syntax (after un-escaping), else null. */
    literal: string | null;
    /** The rule changes a literal into something else (`literal` is set and the value differs). */
    rewritesLiteral: boolean;
    /** Labels the key names with definition syntax (`label\s\[`). */
    labels: string[];
    /** Rename rule: the key (old name) and value (new name) are plain identifiers. */
    renameFrom?: string;
    renameTo?: string;
}

const IDENT = /^[A-Za-z_]\w*$/;
const LABEL_IN_KEY = /([A-Za-z_]\w*)(?:\\s[+*]?| )\\[\[{]/g;

/** Plain text of a regex key, or null when the key uses regex syntax. */
export function literalOfKey(key: string): string | null {
    let out = '';
    for (let i = 0; i < key.length; i++) {
        const ch = key[i];
        if (ch === '\\') {
            const next = key[i + 1];
            if (next === undefined) return null;
            if (/[A-Za-z0-9]/.test(next)) return null; // \s \d \r \n \b ... are not literals
            out += next;
            i++;
        } else if ('^$.*+?()[]{}|'.includes(ch)) {
            return null;
        } else {
            out += ch;
        }
    }
    return out === '' ? null : out;
}

/** The replacement text when it is plain (`$$` is a literal `$`), null when it uses `$1`, `$&` and friends. */
function plainValue(value: string): string | null {
    const unescaped = value.replace(/\$\$/g, '\u0000');
    if (/\$[0-9&`'<]/.test(unescaped)) return null;
    return unescaped.replace(/\u0000/g, '$');
}

export function parseRule(index: number, key: string, value: string): TransformRule {
    let regex: RegExp | null = null;
    try { regex = new RegExp(key, 'g'); } catch { regex = null; }

    const multiLine = /\\[srn]/.test(key) || /[\r\n]/.test(key);
    const literal = literalOfKey(key);
    const plain = plainValue(value);
    const rewritesLiteral = literal !== null && !/[\r\n]/.test(literal) && (plain === null || plain !== literal);

    const labels: string[] = [];
    if (multiLine) {
        for (const m of key.matchAll(LABEL_IN_KEY)) if (!labels.includes(m[1])) labels.push(m[1]);
    }

    const rule: TransformRule = { index, key, value, regex, multiLine, literal, rewritesLiteral, labels };
    if (IDENT.test(key) && IDENT.test(value) && key !== value) {
        rule.renameFrom = key;
        rule.renameTo = value;
    }
    return rule;
}

/** Number of non-overlapping matches of `re` in `text`, and the line span (first, last line index) of each. */
function matchSpans(text: string, re: RegExp, lineStarts: number[]): Array<[number, number]> {
    const spans: Array<[number, number]> = [];
    const fresh = new RegExp(re.source, re.flags.includes('g') ? re.flags : re.flags + 'g');
    const lineOf = (offset: number): number => {
        let lo = 0, hi = lineStarts.length - 1;
        while (lo < hi) {
            const mid = (lo + hi + 1) >> 1;
            if (lineStarts[mid] <= offset) lo = mid; else hi = mid - 1;
        }
        return lo;
    };
    for (const m of text.matchAll(fresh)) {
        if (m[0].length === 0) continue;
        const start = m.index!;
        const end = start + m[0].length - 1;
        spans.push([lineOf(start), lineOf(end)]);
    }
    return spans;
}

function joinWithStarts(lines: string[]): { text: string; starts: number[] } {
    const starts: number[] = [];
    let pos = 0;
    for (const line of lines) {
        starts.push(pos);
        pos += line.length + 1;
    }
    return { text: lines.join('\n'), starts };
}

/** A line without its `;` tail (comment, tag, note text). */
export function stripTail(line: string): string {
    return line.replace(/\s*;.*$/, '');
}

/** The line the extractor prints for an instruction with a comment (writer.ts: pad to 25, ` ;`, ` {n}` when tagged, ` text`). */
export function commentedLine(line: string, address: string, text: string, tagged: boolean): string {
    const code = stripTail(line).trimEnd();
    return code.padEnd(25, ' ') + ' ;' + (tagged ? ` {${address}}` : '') + ' ' + text;
}

/** One multi-line rule measured on one extracted file. */
export interface RuleMeasure {
    rule: TransformRule;
    /** Sites the key matches in the file as extracted (tagged text, comments included). */
    raw: Array<[number, number]>;
    /** Sites the key matches with every `;` tail removed (what the plain build sees without comments). */
    plain: Array<[number, number]>;
}

export interface FileMeasure {
    lines: string[];
    plainLines: string[];
    rules: RuleMeasure[];
}

export class BlockGuard {
    readonly block: string;
    readonly rules: TransformRule[];
    private readonly aliasToKey = new Map<string, string>();
    private readonly keyNames = new Set<string>();

    constructor(block: string, rules: TransformRule[]) {
        this.block = block;
        this.rules = rules;
        for (const r of rules) {
            if (r.renameFrom && r.renameTo) {
                this.aliasToKey.set(r.renameTo, r.renameFrom);
                this.keyNames.add(r.renameFrom);
            }
        }
    }

    get hasMultiLine(): boolean { return this.rules.some(r => r.multiLine && r.regex !== null); }
    get hasLiteralRewrite(): boolean { return this.rules.some(r => r.rewritesLiteral); }
    get hasAny(): boolean { return this.hasMultiLine || this.hasLiteralRewrite || this.aliasToKey.size > 0 || this.rules.some(r => r.labels.length > 0); }

    /** The key a part note must be stored under when `label` is the new name of a rename rule; undefined otherwise. */
    aliasFor(label: string): string | undefined {
        return this.aliasToKey.get(label);
    }

    /** True when `key` is the old name of a rename rule (a stored part-note key that is valid although no label prints it). */
    isRenamedFrom(key: string): boolean {
        return this.keyNames.has(key);
    }

    /** Message when `label` is spanned by a multi-line rule, else null. */
    checkPartNoteLabel(label: string, where: string): string | null {
        for (const r of this.rules) {
            if (r.multiLine && r.labels.includes(label)) {
                return `${where}: part note '${label}': the label is spanned by the multi-line transform rule #${r.index} of block '${this.block}' (${r.key.slice(0, 50)}...); a note line between the labels stops the match and changes the ROM.`;
            }
        }
        return null;
    }

    /** Messages for note text that a literal rewrite would change. */
    checkLiteral(text: string, what: string): string[] {
        const out: string[] = [];
        for (const r of this.rules) {
            if (!r.rewritesLiteral || r.literal === null) continue;
            if (text.includes(r.literal)) {
                out.push(`${what}: text contains '${r.literal}', which transform rule #${r.index} of block '${this.block}' rewrites to '${plainValue(r.value) ?? r.value}' everywhere in the block (notes and comments included); write the value the build produces, or avoid the literal.`);
            }
        }
        return out;
    }

    /** Measure every multi-line rule on an extracted file. */
    measure(lines: string[]): FileMeasure {
        const plainLines = lines.map(stripTail);
        const rawJoined = joinWithStarts(lines);
        const plainJoined = joinWithStarts(plainLines);
        const rules: RuleMeasure[] = [];
        for (const rule of this.rules) {
            if (!rule.multiLine || rule.regex === null) continue;
            rules.push({
                rule,
                raw: matchSpans(rawJoined.text, rule.regex, rawJoined.starts),
                plain: matchSpans(plainJoined.text, rule.regex, plainJoined.starts),
            });
        }
        return { lines, plainLines, rules };
    }

    /**
     * Messages for a comment that would be set on `lineIndex` (0-based) of the file measured in `measure`.
     * `address` is the `{n}` of the line. Empty when no multi-line rule loses a site.
     */
    checkComment(measure: FileMeasure, lineIndex: number, address: string, text: string, where: string): string[] {
        const out: string[] = [];
        for (const m of measure.rules) {
            const inRaw = m.raw.some(([a, b]) => lineIndex >= a && lineIndex <= b);
            const inPlain = m.plain.some(([a, b]) => lineIndex >= a && lineIndex <= b);
            if (!inRaw && !inPlain) continue;

            const broken: string[] = [];
            if (inRaw) {
                const lines = measure.lines.slice();
                lines[lineIndex] = commentedLine(lines[lineIndex], address, text, true);
                const j = joinWithStarts(lines);
                if (matchSpans(j.text, m.rule.regex!, j.starts).length < m.raw.length) broken.push('tagged');
            }
            if (inPlain) {
                const lines = measure.plainLines.slice();
                lines[lineIndex] = commentedLine(lines[lineIndex], address, text, false);
                const j = joinWithStarts(lines);
                if (matchSpans(j.text, m.rule.regex!, j.starts).length < m.plain.length) broken.push('plain');
            }
            if (broken.length > 0) {
                out.push(`${where}: comment {${address}}: line ${lineIndex + 1} is inside the multi-line transform rule #${m.rule.index} of block '${this.block}' (${m.rule.key.slice(0, 50)}...); the ${broken.join(' and ')} build would not apply the rule. Put the text in a part note on an unguarded label, or make the rule tag-tolerant.`);
            }
        }
        return out;
    }

    /**
     * Audit of the comments already stored: a rule that matches the tail-free text of a span but not the text as
     * extracted is blocked by what sits on the span's lines. Returns the blocked sites with the tagged, commented lines on them.
     */
    blockedSites(measure: FileMeasure): Array<{ rule: TransformRule; first: number; last: number; commented: Array<{ line: number; address: string }>; taggedOnly: boolean }> {
        const out: Array<{ rule: TransformRule; first: number; last: number; commented: Array<{ line: number; address: string }>; taggedOnly: boolean }> = [];
        for (const m of measure.rules) {
            if (m.plain.length <= m.raw.length) continue;
            const rawKeys = new Set(m.raw.map(([a, b]) => `${a}:${b}`));
            for (const [a, b] of m.plain) {
                if (rawKeys.has(`${a}:${b}`)) continue;
                const commented: Array<{ line: number; address: string }> = [];
                for (let i = a; i <= b; i++) {
                    const tag = measure.lines[i].match(TAG);
                    if (!tag) continue;
                    const afterTag = measure.lines[i].slice(measure.lines[i].indexOf(tag[0]) + tag[0].length).trim();
                    if (afterTag !== '') commented.push({ line: i, address: tag[1] });
                }
                out.push({ rule: m.rule, first: a, last: b, commented, taggedOnly: commented.length === 0 });
            }
        }
        return out;
    }
}

export class TransformGuard {
    private readonly blocks = new Map<string, BlockGuard>();

    constructor(rulesByBlock: Record<string, Array<{ key: string; value: string }>>, knownBlocks?: { has(name: string): boolean }) {
        for (const [block, rules] of Object.entries(rulesByBlock)) {
            if (knownBlocks && !knownBlocks.has(block)) continue; // dead key: the block does not exist
            const parsed = rules
                .map((r, i) => parseRule(i + 1, r.key ?? '', r.value ?? ''))
                .filter(r => r.key !== '');
            const guard = new BlockGuard(block, parsed);
            if (guard.hasAny) this.blocks.set(block, guard);
        }
    }

    static load(projectRoot: string, knownBlocks?: { has(name: string): boolean }): TransformGuard {
        const path = join(projectRoot, 'us', 'transforms.json');
        if (!existsSync(path)) return new TransformGuard({}, knownBlocks);
        let json: Record<string, Array<{ key: string; value: string }>> = {};
        try { json = JSON.parse(readFileSync(path, 'utf-8')); } catch { /* an unreadable file guards nothing */ }
        return new TransformGuard(json, knownBlocks);
    }

    block(name: string): BlockGuard | undefined {
        return this.blocks.get(name);
    }

    get blockNames(): string[] {
        return [...this.blocks.keys()];
    }
}
