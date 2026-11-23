/**
 * Index of an extracted `.asm` tree: files, top-level labels ("units"), sub-labels, includes and the
 * references between labels. Shared by the two read/regroup tools:
 *
 *   npm run audit   coverage and the cross-file reference matrix   (src/audit.ts)
 *   npm run blocks  merge / move / rename / set on blocks.json     (src/blocks-edit.ts, src/blocks-verify.ts)
 *
 * It only reads text. The format it understands is what the extractor writes (see `BlockWriter.generateAsm`):
 *
 *   ; block note lines                      (only when the block has a note)
 *   ---------------------------------------------
 *   ?BANK 03                                (non-movable blocks only)
 *   ?INCLUDE 'other_block'                  (one per block this file references)
 *   !mnemonic                      1A5E     (WRAM names the file uses)
 *   ---------------------------------------------      <- one separator before every part
 *   ; part note lines                       (column 0, directly above the label)
 *   code_018353 {                           (top-level label: `{` code, `[` table, `#` `|` ` ~ data)
 *       COP [14] ( #$0006, &code_01835A ) ; {99155}     (instruction, optional `; {address}` tag, optional comment)
 *     loc_006512:                           (sub-label, two spaces)
 *   }
 *
 * Labels live in one flat namespace across all files. A reference to a label of another file is written
 * `block.label` (for example `engine_0026F3.code_0026F3`), except when the label is the block's own name.
 */

import { readFileSync, readdirSync, existsSync } from 'fs';
import { join, relative, sep } from 'path';
import { listAsmFiles } from './notes-common.ts';

export type LabelKind = 'code' | 'table' | 'data';

/** How a reference reaches its target: `short` = 2-byte offset (`&`, `$&`, JSR/JMP/absolute), `long` = 3-byte (`@`, `$@`, JSL/JML), `bank` = bank byte (`^`), `rel` = relative branch. */
export type RefForm = 'short' | 'long' | 'bank' | 'rel';

export interface AsmUnit {
    label: string;
    kind: LabelKind;
    fileName: string;
    /** Column-0 `; ...` lines directly above the label (the part note). */
    leading: string[];
    /** Label line and everything up to the next top-level label (blank lines dropped). */
    body: string[];
    subLabels: string[];
    instructions: number;
    /** Instruction lines that carry a comment (the `; {address}` tag alone does not count). */
    commented: number;
}

export interface AsmFile {
    /** Block name: file name without `.asm` (and without `.sprite`). */
    name: string;
    /** Path relative to the tree root, with `/` separators. */
    rel: string;
    group: string;
    /** Sub-folder below the group (the block's `scene`), or `''`. */
    scene: string;
    includes: string[];
    units: AsmUnit[];
    lines: number;
    /** The file starts with a block note (column-0 `;` lines before the first separator). */
    hasBlockNoteText: boolean;
    bank: number | null;
    /** Column-0 lines that are neither label, directive, comment, separator nor the closing `}` / `]` of a label. */
    oddLines: string[];
}

export interface AsmRef {
    fileName: string;
    fromLabel: string;
    to: string;
    toFile: string;
    form: RefForm;
    /** The `block` of a `block.label` reference, or null when the reference was written bare. */
    qualifier: string | null;
}

export interface LabelInfo {
    file: string;
    /** The top-level label whose unit contains this label (itself for a top-level label). */
    top: string;
    sub: boolean;
    kind: LabelKind;
}

export interface AsmTree {
    root: string;
    files: Map<string, AsmFile>;
    labels: Map<string, LabelInfo>;
    refs: AsmRef[];
    /** Labels defined twice (the flat namespace allows each once): `label -> [file, file]`. */
    duplicates: Map<string, string[]>;
}

const SEPARATOR = /^-{5,}\s*$/;
const TOP = /^(\w+)\s+([\[{#`~|])/;
const SUB = /^\s{2}(\w+):\s*(?:;.*)?$/;
const INSTRUCTION = /^\s+([A-Z]{3})(?:\s|$)/;
const TAG_ONLY = /;\s*\{\d+\}\s*$/;
const TAG_AT = /;\s*\{\d+\}\s*(.*)$/;
const IDENT_TOKEN = /(?<![A-Za-z0-9_.])([&@^]?)([A-Za-z_][A-Za-z0-9_]*)(?:\.([A-Za-z_][A-Za-z0-9_]*))?/g;
const BRANCHES = new Set(['BRA', 'BRL', 'BCC', 'BCS', 'BEQ', 'BNE', 'BMI', 'BPL', 'BVC', 'BVS', 'PER']);
const LONG_JUMPS = new Set(['JSL', 'JML']);

/** An auto-generated label: lower-case prefix and a six-digit file offset (`code_0064F8`, `loc_006512`, `unk2_009B39`). */
export const AUTO_LABEL = /^[a-z][a-z0-9_]*_[0-9A-F]{6}$/;

export function kindOf(marker: string): LabelKind {
    return marker === '{' ? 'code' : marker === '[' ? 'table' : 'data';
}

/** Parse one extracted file. References are resolved later (they need the label set of the whole tree). */
export function parseAsmFile(text: string, name: string, rel: string): AsmFile {
    const lines = text.split(/\r?\n/);
    const segs = rel.split('/');
    const file: AsmFile = {
        name,
        rel,
        group: segs.length > 1 ? segs[0] : '',
        scene: segs.length > 2 ? segs.slice(1, -1).join('/') : '',
        includes: [],
        units: [],
        lines: lines.length,
        hasBlockNoteText: false,
        bank: null,
        oddLines: [],
    };

    let leading: string[] = [];
    let current: AsmUnit | null = null;
    let seenSeparator = false;
    let seenUnit = false;

    for (const raw of lines) {
        const line = raw.replace(/\s+$/, '');
        if (line === '') continue;
        if (SEPARATOR.test(line)) { leading = []; seenSeparator = true; continue; }
        if (line.startsWith('?')) {
            const inc = line.match(/^\?INCLUDE\s+'([^']+)'/);
            if (inc) file.includes.push(inc[1]);
            const bank = line.match(/^\?BANK\s+([0-9A-Fa-f]+)/);
            if (bank) file.bank = parseInt(bank[1], 16);
            continue;
        }
        if (line.startsWith('!')) continue;
        if (line.startsWith(';')) {
            if (!seenSeparator && !seenUnit) file.hasBlockNoteText = true;
            leading.push(line);
            continue;
        }
        const top = /^\s/.test(line) ? null : line.match(TOP);
        if (top) {
            current = { label: top[1], kind: kindOf(top[2]), fileName: name, leading, body: [line], subLabels: [], instructions: 0, commented: 0 };
            leading = [];
            file.units.push(current);
            seenUnit = true;
            continue;
        }
        if (!current) { file.oddLines.push(line); continue; }
        current.body.push(line);
        if (!/^\s/.test(line)) {
            if (!/^[}\]]/.test(line)) file.oddLines.push(line);
            continue;
        }
        const sub = line.match(SUB);
        if (sub) { current.subLabels.push(sub[1]); continue; }
        if (INSTRUCTION.test(line)) {
            current.instructions++;
            const tagged = line.match(TAG_AT);
            const comment = tagged ? tagged[1] : (line.includes(';') ? line.slice(line.indexOf(';') + 1) : '');
            if (comment.trim() !== '' && !TAG_ONLY.test(line)) current.commented++;
        }
    }
    return file;
}

/** The instruction mnemonic of a body line (`LDA`, `COP`), or null (data records, sub-labels). */
function mnemonicOf(line: string): string | null {
    const m = line.match(INSTRUCTION);
    return m ? m[1] : null;
}

function stripTail(line: string): string {
    const i = line.indexOf(';');
    return i < 0 ? line : line.slice(0, i);
}

/** All label references of one unit body line that name a label of `labels`. */
function refsOfLine(line: string, labels: ReadonlyMap<string, LabelInfo>, strip: boolean, emit: (label: string, form: RefForm, qualifier: string | null) => void): void {
    const code = strip ? stripTail(line) : line;
    const mnem = mnemonicOf(code);
    IDENT_TOKEN.lastIndex = 0;
    let m: RegExpExecArray | null;
    while ((m = IDENT_TOKEN.exec(code)) !== null) {
        const sigil = m[1];
        const qualifier = m[3] !== undefined ? m[2] : null;
        const label = m[3] !== undefined ? m[3] : m[2];
        if (mnem !== null && m.index === code.indexOf(mnem) && !sigil && qualifier === null) continue; // the mnemonic itself
        if (!labels.has(label)) continue;
        let form: RefForm;
        if (sigil === '@') form = 'long';
        else if (sigil === '^') form = 'bank';
        else if (sigil === '&') form = 'short';
        else if (mnem && LONG_JUMPS.has(mnem)) form = 'long';
        else if (mnem && BRANCHES.has(mnem)) form = 'rel';
        else form = 'short';
        emit(label, form, qualifier);
    }
}

/** Parse every `.asm` file under `dir` and resolve the references between labels. */
export function loadAsmTree(dir: string): AsmTree {
    const files = new Map<string, AsmFile>();
    const labels = new Map<string, LabelInfo>();
    const duplicates = new Map<string, string[]>();

    for (const path of listAsmFiles(dir)) {
        const rel = relative(dir, path).split(sep).join('/');
        const name = rel.split('/').pop()!.replace(/\.asm$/, '').replace(/\.sprite$/, '');
        const file = parseAsmFile(readFileSync(path, 'utf-8'), name, rel);
        files.set(name, file);
    }

    const define = (label: string, info: LabelInfo) => {
        const prev = labels.get(label);
        if (prev) {
            const list = duplicates.get(label) ?? [prev.file];
            list.push(info.file);
            duplicates.set(label, list);
            return;
        }
        labels.set(label, info);
    };
    for (const file of files.values()) {
        for (const unit of file.units) {
            define(unit.label, { file: file.name, top: unit.label, sub: false, kind: unit.kind });
            for (const sub of unit.subLabels) define(sub, { file: file.name, top: unit.label, sub: true, kind: unit.kind });
        }
    }

    const refs: AsmRef[] = [];
    for (const file of files.values()) {
        for (const unit of file.units) {
            // the label line itself matters for data parts: strings carry `[JMP:&block.label]` commands
            for (let i = 0; i < unit.body.length; i++) {
                const line = i === 0 ? unit.body[0].slice(unit.label.length) : unit.body[i];
                refsOfLine(line, labels, i > 0, (label, form, qualifier) => {
                    refs.push({ fileName: file.name, fromLabel: unit.label, to: label, toFile: labels.get(label)!.file, form, qualifier });
                });
            }
        }
    }
    return { root: dir, files, labels, refs, duplicates };
}

/** Whole-word replacement map applied to text: every key found as a complete identifier becomes its value. */
export function replaceWords(text: string, map: ReadonlyMap<string, string>): string {
    if (map.size === 0) return text;
    const alt = [...map.keys()].sort((a, b) => b.length - a.length).map(s => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|');
    const re = new RegExp(`(?<![A-Za-z0-9_])(${alt})(?![A-Za-z0-9_])`, 'g');
    return text.replace(re, (_m, g1: string) => map.get(g1)!);
}

/**
 * The text of a unit as it is compared before and after a regroup: part-note lines excluded, the `block.` qualifier of
 * cross-file references removed (it changes when a label changes file), names mapped back to the old block names.
 */
export function canonicalUnitText(unit: AsmUnit, blockNames: ReadonlySet<string>, nameMap: ReadonlyMap<string, string>): string {
    let text = unit.body.join('\n');
    text = text.replace(/(?<![A-Za-z0-9_.])([A-Za-z_]\w*)\.([A-Za-z_]\w*)/g, (m, block: string, label: string) => (blockNames.has(block) ? label : m));
    // the extractor aligns trailing comments to a column that depends on the printed width (a `block.` qualifier widens it)
    text = text.replace(/[ \t]+;/g, ' ;');
    return replaceWords(text, nameMap);
}

/** Every non-asm file name (without extension) of a tree: binary assets are `?INCLUDE` targets too. */
export function listAssetNames(dir: string): Set<string> {
    const out = new Set<string>();
    const walk = (current: string) => {
        if (!existsSync(current)) return;
        for (const entry of readdirSync(current, { withFileTypes: true })) {
            if (entry.isDirectory()) walk(join(current, entry.name));
            else if (entry.isFile() && !entry.name.startsWith('.')) out.add(entry.name.replace(/\.[^.]+$/, '').replace(/\.sprite$/, ''));
        }
    };
    walk(dir);
    return out;
}
