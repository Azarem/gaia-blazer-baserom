/**
 * Notes Merge
 *
 * Applies a JSON edit spec straight to the `notes/` JSON files: block notes,
 * part notes and inline comments can each be set, replaced or removed. The spec
 * says what to write and where, so the .asm is never touched. This is the only
 * supported way to change notes and comments (names: `npm run names`).
 *
 * The extracted .asm is only READ, to validate the spec before anything is
 * written: every label must exist exactly once, every comment address must
 * exist (and match an optional "expect" guard), every file must exist. One bad
 * entry aborts the whole run with nothing written.
 *
 * Workflow:
 *   1. `npm run extract:lt`                      (labels + address tags to validate against)
 *   2. Write an edit spec (JSON), e.g. plans/extracted-audit/edits/I021.json
 *   3. `npm run merge -- <spec.json> [--dry-run]`  validate, write notes/*.json, verify
 *   4. `npm run extract:lt`                      the extractor re-reads notes/ -> check the output
 *
 * Spec format (paths relative to extracted/):
 *   {
 *     "system/engine/smooth_follow.asm": {
 *       "blockNote": "text, \n separates lines"  | ["line", "line"] | null,
 *       "partNotes": { "LabelName": "text" | [lines] | null },
 *       "comments":  {
 *         "59011": "inline comment",
 *         "59015": { "text": "comment", "expect": "LDA $0A" },
 *         "59018": { "text": "new text", "expectOld": "substring of the stored comment" },
 *         "59020": null
 *       }
 *     }
 *   }
 *
 * Partial edits: instead of the full text, a note may be { "edit": [ { "find": "...", "with": "..." } ] }
 * (optionally "until": "..." to replace a whole section); see applyEditOps.
 *
 * Where each entry lands:
 *   - block note  -> notes/blockNotes/bankNN.json, key = file name without .asm
 *   - part note   -> notes/partNotes/bankNN.json,  key = label (bank = the file's bank, or the
 *                    bank that already holds that label, so a note is never duplicated)
 *   - comment     -> notes/comments/bankNN.json,   key = decimal address (bank = address / 65536)
 *
 * Because the .asm is not edited, `extracted/` is stale until the next extract.
 */

import { readFileSync, existsSync, readdirSync } from 'fs';
import { join, resolve, relative, sep } from 'path';
import {
    detectBank, loadNamesBankLookup, loadDbBankLookup, loadJsonFile, saveJsonFile, bankFileName,
    TOP_LABEL, SUB_LABEL, TAG, normalizeNote, noteIsEmpty, loadTransformPatterns, resolveAsmPath,
    type NoteValue, type CommentValue, type FileEdit,
} from './notes-common.ts';
import { TransformGuard, type FileMeasure } from './transform-guard.ts';

export interface MergeOptions {
    dryRun?: boolean;
}

export interface MergeResult {
    ok: boolean;
    errors: string[];
    warnings: string[];
    notesFilesChanged: string[];
}

type Kind = 'blockNotes' | 'partNotes' | 'comments';
const KINDS: Kind[] = ['blockNotes', 'partNotes', 'comments'];

interface Counts { set: number; updated: number; removed: number; unchanged: number }
const newCounts = (): Counts => ({ set: 0, updated: 0, removed: 0, unchanged: 0 });

/** In-memory copy of every notes/<kind>/bankNN.json, with a key -> bank index. */
class NoteStore {
    banks = new Map<number, Record<string, string>>();
    original = new Map<number, Record<string, string>>();
    index = new Map<string, number>();
    dir: string;

    constructor(dir: string) {
        this.dir = dir;
        if (!existsSync(dir)) return;
        for (const f of readdirSync(dir)) {
            const m = f.match(/^bank([0-9A-Fa-f]{2})\.json$/);
            if (!m) continue;
            const bank = parseInt(m[1], 16);
            const data = loadJsonFile(join(dir, f));
            this.banks.set(bank, data);
            this.original.set(bank, { ...data });
            for (const k of Object.keys(data)) if (!this.index.has(k)) this.index.set(k, bank);
        }
    }

    get(key: string): string | undefined {
        const bank = this.index.get(key);
        return bank === undefined ? undefined : this.banks.get(bank)![key];
    }

    bankOf(key: string): number | undefined {
        return this.index.get(key);
    }

    set(key: string, bank: number, value: string) {
        if (!this.banks.has(bank)) { this.banks.set(bank, {}); this.original.set(bank, {}); }
        this.banks.get(bank)![key] = value;
        this.index.set(key, bank);
    }

    remove(key: string) {
        const bank = this.index.get(key);
        if (bank === undefined) return;
        delete this.banks.get(bank)![key];
        this.index.delete(key);
    }

    /** Banks whose content differs from what was loaded. */
    dirtyBanks(): number[] {
        const out: number[] = [];
        for (const [bank, data] of this.banks) {
            const orig = this.original.get(bank)!;
            const a = Object.keys(data), b = Object.keys(orig);
            if (a.length !== b.length || a.some(k => data[k] !== orig[k])) out.push(bank);
        }
        return out.sort((x, y) => x - y);
    }

    pathFor(bank: number): string {
        return join(this.dir, bankFileName(bank));
    }
}

function suggest(names: string[], wanted: string): string {
    const w = wanted.toLowerCase();
    const hits = names.filter(n => n.toLowerCase().includes(w) || w.includes(n.toLowerCase())).slice(0, 5);
    return hits.length > 0 ? ` Did you mean: ${hits.join(', ')}?` : '';
}

/** Labels (top-level parts and indented sub-labels) in an extracted file, with their line numbers. */
export function collectLabels(lines: string[]): Map<string, number[]> {
    const labels = new Map<string, number[]>();
    lines.forEach((line, i) => {
        if (/^[?!]/.test(line)) return;
        const m = line.match(TOP_LABEL) || line.match(SUB_LABEL);
        if (!m) return;
        if (!labels.has(m[1])) labels.set(m[1], []);
        labels.get(m[1])!.push(i + 1);
    });
    return labels;
}

/** Address tag -> source lines (extract:lt output). */
export function collectTags(lines: string[]): Map<string, number[]> {
    const tags = new Map<string, number[]>();
    lines.forEach((line, i) => {
        const m = line.match(TAG);
        if (!m) return;
        if (!tags.has(m[1])) tags.set(m[1], []);
        tags.get(m[1])!.push(i);
    });
    return tags;
}

function tally(c: Counts, existed: boolean, changed: boolean, removing: boolean) {
    if (removing) { if (existed) c.removed++; else c.unchanged++; return; }
    if (!changed) c.unchanged++;
    else if (existed) c.updated++;
    else c.set++;
}

function fmt(c: Counts): string {
    return `+${c.set} ~${c.updated} -${c.removed} =${c.unchanged}`;
}

/**
 * Partial edit of an EXISTING note, so a long note does not have to be pasted again to change a sentence:
 *   "blockNote": { "edit": [ { "find": "old text", "with": "new text" },
 *                            { "find": "=== SECTION", "until": "=== NEXT", "with": "replacement section\n\n" } ] }
 * `find` must occur exactly once in the stored note. With `until`, everything from the start of `find` up to
 * (not including) the first `until` after it is replaced. `with` may be a string or an array of lines; "" deletes.
 */
interface NoteTextEdit { find: string; until?: string; with: string | string[] }
interface NoteEditOps { edit: NoteTextEdit[] }

function isEditOps(v: unknown): v is NoteEditOps {
    return v !== null && typeof v === 'object' && !Array.isArray(v) && Array.isArray((v as NoteEditOps).edit);
}

function applyEditOps(current: string | undefined, ops: NoteEditOps, what: string, err: (msg: string) => void): string | null {
    if (current === undefined) { err(`${what}: has no existing note to edit; give the full text instead`); return null; }
    let text = current;
    for (const [i, op] of ops.edit.entries()) {
        const where = `${what} edit #${i + 1}`;
        if (typeof op?.find !== 'string' || op.find === '') { err(`${where}: 'find' must be a non-empty string`); return null; }
        if (op.with === undefined) { err(`${where}: 'with' is missing`); return null; }
        const count = text.split(op.find).length - 1;
        if (count !== 1) { err(`${where}: 'find' occurs ${count} times (need exactly 1): ${JSON.stringify(op.find.slice(0, 60))}`); return null; }
        const start = text.indexOf(op.find);
        let end = start + op.find.length;
        if (op.until !== undefined) {
            const u = text.indexOf(op.until, end);
            if (op.until === '' || u < 0) { err(`${where}: 'until' text not found after 'find': ${JSON.stringify(op.until.slice(0, 60))}`); return null; }
            end = u;
        }
        const repl = Array.isArray(op.with) ? op.with.join('\n') : op.with;
        text = text.slice(0, start) + repl + text.slice(end);
    }
    return text;
}

export function merge(projectRoot: string, specPath: string, options: MergeOptions = {}): MergeResult {
    const result: MergeResult = { ok: false, errors: [], warnings: [], notesFilesChanged: [] };

    const specAbs = resolve(specPath);
    if (!existsSync(specAbs)) {
        result.errors.push(`spec file not found: ${specPath}`);
        return report(result);
    }
    let spec: Record<string, FileEdit>;
    try {
        spec = JSON.parse(readFileSync(specAbs, 'utf-8'));
    } catch (e) {
        result.errors.push(`spec is not valid JSON: ${e}`);
        return report(result);
    }
    for (const k of Object.keys(spec)) {
        if (k.startsWith('$') || k.startsWith('_')) delete spec[k]; // metadata keys
    }

    const notesDir = join(projectRoot, 'notes');
    const stores: Record<Kind, NoteStore> = {
        blockNotes: new NoteStore(join(notesDir, 'blockNotes')),
        partNotes: new NoteStore(join(notesDir, 'partNotes')),
        comments: new NoteStore(join(notesDir, 'comments')),
    };
    const namesLookup = loadNamesBankLookup(join(projectRoot, 'us', 'names'));
    const dbLookup = loadDbBankLookup(join(projectRoot, 'us'));
    const transformPatterns = loadTransformPatterns(projectRoot);
    // Notes sit inside the text that transforms.json rewrites: see src/transform-guard.ts.
    const guard = TransformGuard.load(projectRoot, dbLookup);

    // What the notes JSON must contain afterwards (null = absent); checked again after the write.
    const expected: Record<Kind, Map<string, string | null>> = {
        blockNotes: new Map(), partNotes: new Map(), comments: new Map(),
    };
    const claimed: Record<Kind, Map<string, string>> = {
        blockNotes: new Map(), partNotes: new Map(), comments: new Map(),
    };

    for (const [fileKey, edit] of Object.entries(spec)) {
        const abs = resolveAsmPath(projectRoot, fileKey);
        if (!abs) { result.errors.push(`${fileKey}: not an .asm file under extracted/`); continue; }
        if (!existsSync(abs)) { result.errors.push(`${fileKey}: file does not exist (run npm run extract:lt?)`); continue; }
        let badKey = false;
        for (const k of Object.keys(edit)) {
            if (!['blockNote', 'partNotes', 'comments'].includes(k)) {
                result.errors.push(`${fileKey}: unknown key '${k}' (expected blockNote, partNotes, comments)`);
                badKey = true;
            }
        }
        if (badKey) continue;

        const label = relative(join(projectRoot, 'extracted'), abs).split(sep).join('/');
        const lines = readFileSync(abs, 'utf-8').split(/\r?\n/);
        // block name = file name without .asm; sprite maps are written as <block>.sprite.asm
        const baseName = label.split('/').pop()!.replace(/\.asm$/, '').replace(/\.sprite$/, '');
        // Bank: ?BANK, else the block's start in blocks.json / files.json, else labels, tags and names.
        const fileBank = detectBank(lines, baseName, namesLookup, dbLookup);
        const err = (msg: string) => result.errors.push(`${label}: ${msg}`);
        const warn = (msg: string) => result.warnings.push(`${label}: ${msg}`);
        const blockGuard = guard.block(baseName);
        let measured: FileMeasure | undefined;
        const measure = (): FileMeasure => (measured ??= blockGuard!.measure(lines));

        const claim = (kind: Kind, key: string): boolean => {
            const prev = claimed[kind].get(key);
            if (prev !== undefined) {
                err(`${kind} '${key}' is also set by ${prev} in this spec`);
                return false;
            }
            claimed[kind].set(key, label);
            return true;
        };

        const cBlock = newCounts(), cPart = newCounts(), cComment = newCounts();

        // ---- block note ----
        let blockValue: NoteValue | undefined = edit.blockNote;
        if (blockValue !== undefined && claim('blockNotes', baseName)) {
            if (isEditOps(blockValue)) {
                const r = applyEditOps(stores.blockNotes.get(baseName), blockValue, 'block note', err);
                blockValue = r === null ? undefined : r;
            }
        } else blockValue = undefined;
        if (blockValue !== undefined) {
            const removing = noteIsEmpty(blockValue);
            if (!removing && fileBank === null) {
                err('block note: cannot determine the ROM bank of this file');
            } else {
                const store = stores.blockNotes;
                const cur = store.get(baseName);
                if (removing) {
                    tally(cBlock, cur !== undefined, false, true);
                    store.remove(baseName);
                    expected.blockNotes.set(baseName, null);
                } else {
                    const text = normalizeNote(blockValue as string | string[]);
                    for (const m of blockGuard?.checkLiteral(text, 'block note') ?? []) err(m);
                    const bank = store.bankOf(baseName) ?? fileBank!;
                    tally(cBlock, cur !== undefined, cur !== text, false);
                    store.set(baseName, bank, text);
                    expected.blockNotes.set(baseName, text);
                }
            }
        }

        // ---- part notes ----
        const labels = collectLabels(lines);
        for (const [name, rawValue] of Object.entries(edit.partNotes ?? {} as Record<string, NoteValue>)) {
            let value: NoteValue = rawValue;
            const hits = labels.get(name);
            if (!hits) {
                err(`label '${name}' not found.${suggest([...labels.keys()], name)}`);
                continue;
            }
            if (hits.length > 1) {
                err(`label '${name}' appears ${hits.length} times (lines ${hits.join(', ')}); ambiguous`);
                continue;
            }
            // A label that a multi-line transform rule spans cannot take a note (it would stop or move the rule).
            // (Removing a note is always allowed.)
            const removingNote = !isEditOps(rawValue) && noteIsEmpty(rawValue);
            const spanned = removingNote ? null : blockGuard?.checkPartNoteLabel(name, label);
            if (spanned) { result.errors.push(spanned); continue; }
            // A label that a rename rule produces is stored under the name the engine looks up (the old name).
            const storeKey = blockGuard?.aliasFor(name) ?? name;
            if (storeKey !== name) {
                warn(`part note '${name}' is stored under '${storeKey}': a transform rule of block '${baseName}' renames '${storeKey}' to '${name}' after the notes are placed`);
            }
            if (!claim('partNotes', storeKey)) continue;

            const store = stores.partNotes;
            const cur = store.get(storeKey);
            if (isEditOps(value)) {
                const r = applyEditOps(cur, value, `part note '${name}'`, err);
                if (r === null) continue;
                value = r;
            }
            if (noteIsEmpty(value)) {
                tally(cPart, cur !== undefined, false, true);
                store.remove(storeKey);
                expected.partNotes.set(storeKey, null);
                continue;
            }
            if (fileBank === null && store.bankOf(storeKey) === undefined) {
                err(`part note '${name}': cannot determine the ROM bank of this file`);
                continue;
            }
            const text = normalizeNote(value as string | string[]);
            for (const m of blockGuard?.checkLiteral(text, `part note '${name}'`) ?? []) err(m);
            const existingBank = store.bankOf(storeKey);
            if (existingBank !== undefined && fileBank !== null && existingBank !== fileBank) {
                warn(`part note '${name}' already lives in bank${existingBank.toString(16).toUpperCase().padStart(2, '0')} ` +
                    `but the file resolves to bank${fileBank.toString(16).toUpperCase().padStart(2, '0')}; keeping the existing bank`);
            }
            const bank = existingBank ?? fileBank!;
            tally(cPart, cur !== undefined, cur !== text, false);
            store.set(storeKey, bank, text);
            expected.partNotes.set(storeKey, text);
        }

        // ---- comments ----
        const tags = collectTags(lines);
        for (const [addr, raw] of Object.entries(edit.comments ?? {} as Record<string, CommentValue>)) {
            if (!/^\d+$/.test(addr)) { err(`comment key '${addr}' must be a decimal address`); continue; }
            let text: string | null;
            let expect: string | undefined;
            let expectOld: string | undefined;
            if (raw !== null && typeof raw === 'object') { text = raw.text ?? null; expect = raw.expect; expectOld = raw.expectOld; }
            else text = raw;
            if (text !== null) text = text.trim();
            if (text === '') text = null;

            const stored = stores.comments.get(addr);
            const hits = tags.get(addr);
            if (!hits) {
                // A line that already carries a comment prints no `; {address}` tag, so it cannot be located in the
                // .asm. It can still be replaced or removed when the spec names a substring of the stored comment
                // (`expectOld`): the stored text is the guard.
                if (stored !== undefined && expectOld !== undefined) {
                    if (!stored.toLowerCase().includes(expectOld.toLowerCase())) {
                        err(`comment {${addr}}: expectOld '${expectOld}' not found in the stored comment '${stored}'`);
                        continue;
                    }
                    if (expect !== undefined) warn(`comment {${addr}}: 'expect' is ignored for a line that already has a comment (no tag to locate it); use expectOld`);
                } else {
                    err(`comment {${addr}}: address tag not found` +
                        (tags.size === 0 ? ' (file has no ; {address} tags; run `npm run extract:lt` first)'
                            : stored !== undefined ? ' (the line already has a comment, so no tag is printed: add "expectOld": "<substring of the stored comment>" to replace or remove it)' : ''));
                    continue;
                }
            } else {
                if (hits.length > 1) {
                    err(`comment {${addr}}: tag appears on ${hits.length} lines (${hits.map(h => h + 1).join(', ')}); ambiguous`);
                    continue;
                }
                if (expectOld !== undefined) {
                    err(`comment {${addr}}: expectOld given, but the line has no comment (it prints a tag); use expect`);
                    continue;
                }
                const line = lines[hits[0]];
                const tagMatch = line.match(TAG)!;
                const codePart = line.slice(0, tagMatch.index!).trim();
                if (expect !== undefined && !codePart.toLowerCase().includes(expect.toLowerCase())) {
                    err(`comment {${addr}}: expected '${expect}' on line ${hits[0] + 1} but found '${codePart}'`);
                    continue;
                }
            }
            if (text !== null) {
                if (/[\r\n]/.test(text)) { err(`comment {${addr}}: must be a single line`); continue; }
                if (/\{\d+\}/.test(text)) { err(`comment {${addr}}: must not contain a {digits} tag`); continue; }
                if (text.length > 160) warn(`comment {${addr}}: ${text.length} chars; consider moving detail to a part note`);
                if (blockGuard) {
                    for (const m of blockGuard.checkLiteral(text, `comment {${addr}}`)) err(m);
                    if (hits && hits.length === 1) {
                        for (const m of blockGuard.checkComment(measure(), hits[0], addr, text, label)) result.errors.push(m);
                    }
                }
                for (const re of transformPatterns) {
                    re.lastIndex = 0;
                    if (re.test(text)) {
                        warn(`comment {${addr}}: text matches a transforms.json pattern (${re.source.slice(0, 50)}...); extraction may rewrite it`);
                        break;
                    }
                }
            }
            if (!claim('comments', addr)) continue;

            const store = stores.comments;
            const cur = store.get(addr);
            if (text === null) {
                tally(cComment, cur !== undefined, false, true);
                store.remove(addr);
                expected.comments.set(addr, null);
            } else {
                const bank = Math.floor(parseInt(addr, 10) / 65536);
                tally(cComment, cur !== undefined, cur !== text, false);
                store.set(addr, bank, text);
                expected.comments.set(addr, text);
            }
        }

        console.log(`${label}: block ${fmt(cBlock)}, parts ${fmt(cPart)}, comments ${fmt(cComment)}   (+new ~updated -removed =unchanged)`);
    }

    if (result.errors.length > 0) {
        console.log('\nNothing written (fix the errors and re-run).');
        return report(result);
    }

    // ---- write ----
    for (const kind of KINDS) {
        const store = stores[kind];
        for (const bank of store.dirtyBanks()) {
            const path = store.pathFor(bank);
            result.notesFilesChanged.push(relative(projectRoot, path).split(sep).join('/'));
            if (!options.dryRun) saveJsonFile(path, store.banks.get(bank)!);
        }
    }

    if (options.dryRun) {
        console.log(`\n[DRY RUN] ${result.notesFilesChanged.length} notes file(s) would change; nothing written.`);
        for (const f of result.notesFilesChanged) console.log(`  ${f}`);
        result.ok = true;
        return report(result);
    }
    console.log(`\nWrote ${result.notesFilesChanged.length} notes file(s):`);
    for (const f of result.notesFilesChanged) console.log(`  ${f}`);

    // ---- verify against disk ----
    for (const kind of KINDS) {
        const onDisk = new NoteStore(join(notesDir, kind));
        const seen = new Map<string, number>();
        for (const [key, want] of expected[kind]) {
            const got = onDisk.get(key);
            if (want === null) {
                if (got !== undefined) result.errors.push(`verify: ${kind} '${key}' still present on disk`);
            } else if (got !== want) {
                result.errors.push(`verify: ${kind} '${key}' on disk does not match the spec`);
            }
            if (want !== null) seen.set(key, (seen.get(key) ?? 0) + 1);
        }
        // A key must live in exactly one bank file.
        const counts = new Map<string, number>();
        for (const data of onDisk.banks.values()) for (const k of Object.keys(data)) counts.set(k, (counts.get(k) ?? 0) + 1);
        for (const key of seen.keys()) {
            if ((counts.get(key) ?? 0) > 1) result.errors.push(`verify: ${kind} '${key}' exists in more than one bank file`);
        }
    }

    result.ok = result.errors.length === 0;
    if (result.ok) console.log('\nNext: npm run extract:lt  (the extractor re-reads notes/; check the output)');
    return report(result);
}

function report(result: MergeResult): MergeResult {
    if (result.warnings.length > 0) {
        console.log('\nWarnings:');
        for (const w of result.warnings) console.log(`  ! ${w}`);
    }
    if (result.errors.length > 0) {
        console.log('\nErrors:');
        for (const e of result.errors) console.log(`  X ${e}`);
    } else if (result.ok) {
        console.log('\nOK');
    }
    return result;
}
