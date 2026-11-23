/**
 * Blocks Merge: `npm run blocks`
 *
 * Regroups the code of `us/blocks.json` from a JSON spec, so that merging blocks, moving a part, renaming a block and
 * setting `scene` / `group` / `order` / `movable` never needs an ad-hoc script. `blocks.json`, `transforms.json`, the
 * block-note keys under `notes/blockNotes/` and the text that mentions a renamed block change together, all or nothing.
 * Labels, part notes, comments and names are never touched (they are keyed by label or address, which a regroup keeps).
 *
 * Spec: a JSON array of operations, applied in order (each sees the result of the one before). `row` and `note` are
 * free text for the audit trail and ignored.
 *
 *   { "op": "merge", "blocks": ["lib_0100", "lib_0101"], "into": "lib_0100" }
 *       All parts of the listed blocks become one block `into` (one of them, or a new name). Properties (`movable`,
 *       `order`, `scene`) and the group must agree between the blocks, or be set in the op (`movable`, `order`, `scene`,
 *       `group`; `null` removes). Block notes: at most one block may have one, or give `"notes": "join"` to concatenate
 *       them in the listed order. `transforms.json` lists are concatenated. Whole-word mentions of the absorbed block
 *       names in notes/ text, docs/, baserom/ and us/*.json are rewritten to `into`, as for a rename.
 *       Not re-appliable (the merged blocks are gone).
 *
 *   { "op": "move-part", "parts": ["code_012345"], "to": "lib_0100" }
 *       Moves parts (by part name) into another block. `"from"` is optional (checked when given). `to` may be a new block:
 *       add `"create": { "group": "library", "scene": "...", "movable": true, "order": -1 }` (group required).
 *       A block cannot be emptied by it (merge it away instead). Re-appliable (a part already in `to` is unchanged).
 *
 *   { "op": "rename", "block": "lib_0100", "to": "text_renderer" }
 *       Renames a block: blocks.json key, transforms.json key, block-note key, and the whole-word mentions in notes/ text,
 *       docs/, baserom/ and us/*.json. If the old name is also a label of the code (a part with the same name as its block),
 *       the text is left alone and a warning says so: rename the label with `npm run names` first (it rewrites the block
 *       key too). A file under baserom/ named after the block must be renamed by hand. Re-appliable.
 *
 *   { "op": "set", "blocks": ["a", "b"], "scene": "engine", "group": "system", "order": 3, "movable": true }
 *       Sets properties on one block (`"block"`) or several (`"blocks"`); `null` removes `scene` and `order`; `movable: false`
 *       removes the property. `group` moves the block to another top-level key of blocks.json (an unknown group needs
 *       `"createGroup": true`). Re-appliable.
 *
 * Validation, before anything is written (one error aborts everything):
 *   - structure: no part crosses a bank, no two parts overlap, a non-movable block lies in one bank and every block fits one
 *     bank, block and part names are unique and do not collide with each other or with files.json, identifiers are valid
 *   - the blocks as they would be extracted and rebuilt are compared with the current ones in a scratch folder
 *     (src/blocks-verify.ts): the text of every label unchanged, no label lost or created, the project still rebuilds
 *     (0 undefined references), `?INCLUDE` closure consistent, 2-byte references keep their bank guarantee
 *   - a new block name is not already a label of the code
 *
 * Flags: `--dry-run` (everything above, nothing written).
 *
 * Workflow:
 *   1. `npm run extract:lt` (the report and later notes work from a fresh tree)
 *   2. write the spec, e.g. plans/extracted-audit/edits/I010_blocks.json
 *   3. `npm run blocks -- <spec.json> --dry-run`, read the report, then without --dry-run
 *   4. `npm run extract:lt`, `npm run rebuild`, `npm run merge -- --check`, `npm run names -- --check`
 */

import { readFileSync, writeFileSync, existsSync, readdirSync, mkdirSync } from 'fs';
import { join, resolve, relative, sep } from 'path';
import type { DbGameRomModule } from '@gaialabs/core';
import { bankFileName, loadJsonFile, serializeJson } from './notes-common.ts';
import { replaceWords } from './asm-index.ts';
import { verifyRegroup } from './blocks-verify.ts';
import type { BlocksFile, Snapshot } from './blocks-verify.ts';
import config from '../us/config.json' with { type: 'json' };

export interface BlocksOptions { dryRun?: boolean }
export interface BlocksResult { ok: boolean; errors: string[]; warnings: string[]; filesChanged: string[] }

type Raw = Record<string, unknown>;
const IDENT = /^[A-Za-z_][A-Za-z0-9_]*$/;
const PATH_PART = /^[A-Za-z0-9_]+$/;
const TEXT_EXT = /\.(asm|md|json|txt|mdc)$/i;
const SKIP_DIRS = new Set(['node_modules', '.git', 'dist', 'extracted', 'extracted-jp', 'plans', 'temp', 'artifacts', 'rebuilt', 'archived']);
const bankShift = config.memoryMode === 'Lo' ? 15 : 16;
const PAGE = 1 << bankShift;
const PROP_ORDER = ['scene', 'movable', 'order', 'base', 'postProcess'];

const ALLOWED: Record<string, string[]> = {
    'merge': ['op', 'blocks', 'into', 'group', 'scene', 'order', 'movable', 'notes', 'createGroup', 'row', 'note'],
    'move-part': ['op', 'part', 'parts', 'from', 'to', 'create', 'row', 'note'],
    'rename': ['op', 'block', 'to', 'row', 'note'],
    'set': ['op', 'block', 'blocks', 'scene', 'group', 'order', 'movable', 'createGroup', 'row', 'note'],
};

interface Work {
    blocks: BlocksFile;
    transforms: Record<string, any>;
    notes: Map<string, string>;
    renames: Map<string, string>;
    touched: Set<string>;
    sortedGroups: Set<string>;
    log: string[];
    changed: boolean;
}

// ---------------------------------------------------------------------------------------------------------------- helpers

const eolOf = (text: string) => (text.includes('\r\n') ? '\r\n' : '\n');
const withEol = (text: string, eol: string) => (eol === '\r\n' ? text.replace(/\r?\n/g, '\r\n') : text);
const minStart = (b: any) => Math.min(...Object.values<any>(b.parts).map(p => p.start));
const bankOfStart = (n: number) => Math.floor(n / 65536);

function groupOf(w: Work, block: string): string | null {
    for (const [g, blocks] of Object.entries(w.blocks)) if (block in blocks) return g;
    return null;
}

function partOwner(w: Work): Map<string, string> {
    const m = new Map<string, string>();
    for (const blocks of Object.values(w.blocks)) for (const [name, b] of Object.entries(blocks)) for (const p of Object.keys(b.parts)) m.set(p, name);
    return m;
}

function isSorted(blocks: Record<string, any>): boolean {
    let prev = -1;
    for (const b of Object.values(blocks)) { const s = minStart(b); if (s < prev) return false; prev = s; }
    return true;
}

/** `blocks.json` in the format the project keeps it: 4-space indent, one line per part, block properties before `parts`. */
export function serializeBlocks(blocks: BlocksFile): string {
    const q = JSON.stringify;
    const rank = (k: string) => { const i = PROP_ORDER.indexOf(k); return i < 0 ? PROP_ORDER.length : i; };
    const lines: string[] = ['{'];
    const groups = Object.entries(blocks);
    groups.forEach(([group, members], gi) => {
        lines.push(`    ${q(group)}: {`);
        const entries = Object.entries(members);
        entries.forEach(([name, b], bi) => {
            lines.push(`        ${q(name)}: {`);
            for (const [k, v] of Object.entries(b).filter(([k]) => k !== 'parts').sort((x, y) => rank(x[0]) - rank(y[0]))) lines.push(`            ${q(k)}: ${q(v)},`);
            lines.push('            "parts": {');
            const parts = Object.entries<any>(b.parts);
            parts.forEach(([pn, p], pi) => {
                lines.push(`                ${q(pn)}: { ${Object.entries(p).map(([k, v]) => `${q(k)}: ${q(v)}`).join(', ')} }${pi < parts.length - 1 ? ',' : ''}`);
            });
            lines.push('            }');
            lines.push(`        }${bi < entries.length - 1 ? ',' : ''}`);
        });
        lines.push(`    }${gi < groups.length - 1 ? ',' : ''}`);
    });
    lines.push('}');
    return lines.join('\n') + '\n';
}

function walk(dir: string, out: string[], skip: (p: string) => boolean): void {
    if (!existsSync(dir)) return;
    for (const e of readdirSync(dir, { withFileTypes: true })) {
        const p = join(dir, e.name);
        if (e.isDirectory()) { if (!SKIP_DIRS.has(e.name) && !skip(p)) walk(p, out, skip); }
        else if (TEXT_EXT.test(e.name)) out.push(p);
    }
}

function loadNoteBanks(projectRoot: string, kind: string): Map<number, Record<string, string>> {
    const dir = join(projectRoot, 'notes', kind);
    const out = new Map<number, Record<string, string>>();
    if (!existsSync(dir)) return out;
    for (const f of readdirSync(dir)) {
        const m = f.match(/^bank([0-9A-Fa-f]{2})\.json$/);
        if (m) out.set(parseInt(m[1], 16), loadJsonFile(join(dir, f)));
    }
    return out;
}

// ---------------------------------------------------------------------------------------------------------------- structure rules

/** Structural rules of blocks.json. Messages are stable so that errors the project already has can be told from new ones. */
function validateStructure(blocks: BlocksFile, fileNames: ReadonlySet<string>): string[] {
    const errors: string[] = [];
    const blockOwner = new Map<string, string>();
    const partOwnerMap = new Map<string, string>();
    const spans: Array<{ start: number; end: number; part: string; block: string }> = [];
    for (const [group, members] of Object.entries(blocks)) {
        if (!PATH_PART.test(group)) errors.push(`group '${group}' is not a valid folder name`);
        for (const [name, b] of Object.entries<any>(members)) {
            if (!IDENT.test(name)) errors.push(`block '${name}' is not a valid identifier`);
            if (blockOwner.has(name)) errors.push(`block '${name}' exists in groups '${blockOwner.get(name)}' and '${group}'`);
            blockOwner.set(name, group);
            if (fileNames.has(name)) errors.push(`block '${name}' has the name of a file in files.json`);
            if (b.scene !== undefined && (typeof b.scene !== 'string' || !PATH_PART.test(b.scene))) errors.push(`block '${name}': scene must be a folder name`);
            if (b.order !== undefined && !Number.isInteger(b.order)) errors.push(`block '${name}': order must be an integer`);
            const parts = Object.entries<any>(b.parts ?? {});
            if (parts.length === 0) { errors.push(`block '${name}' has no parts`); continue; }
            const banks = new Set<number>();
            let bytes = 0;
            for (const [pn, p] of parts) {
                if (!IDENT.test(pn)) errors.push(`part '${pn}' (block '${name}') is not a valid identifier`);
                if (partOwnerMap.has(pn)) errors.push(`part '${pn}' is in blocks '${partOwnerMap.get(pn)}' and '${name}'`);
                partOwnerMap.set(pn, name);
                if (!Number.isInteger(p.start) || !Number.isInteger(p.end) || p.start >= p.end) { errors.push(`part '${pn}' has an invalid range ${p.start}..${p.end}`); continue; }
                if (p.start >> bankShift !== (p.end - 1) >> bankShift) errors.push(`part '${pn}' (${p.start}..${p.end}) crosses a bank boundary`);
                banks.add(p.start >> bankShift);
                bytes += p.end - p.start;
                spans.push({ start: p.start, end: p.end, part: pn, block: name });
            }
            if (b.movable !== true && banks.size > 1) errors.push(`block '${name}' is not movable but its parts lie in ${banks.size} banks (${[...banks].map(x => x.toString(16)).join(', ')})`);
            if (bytes > PAGE) errors.push(`block '${name}' is ${bytes} bytes, more than one bank (${PAGE})`);
        }
    }
    for (const [part, block] of partOwnerMap) {
        const owner = blockOwner.get(part);
        if (owner !== undefined && part !== block) errors.push(`part '${part}' (block '${block}') has the name of the block '${part}'`);
    }
    spans.sort((a, b) => a.start - b.start || a.end - b.end);
    for (let i = 1; i < spans.length; i++) {
        if (spans[i].start < spans[i - 1].end) errors.push(`parts '${spans[i - 1].part}' (${spans[i - 1].block}) and '${spans[i].part}' (${spans[i].block}) overlap`);
    }
    return errors;
}

// ---------------------------------------------------------------------------------------------------------------- operations

function check(spec: Raw, where: string, errors: string[]): boolean {
    const op = spec.op;
    if (typeof op !== 'string' || !(op in ALLOWED)) { errors.push(`${where}: 'op' must be one of ${Object.keys(ALLOWED).join(', ')}`); return false; }
    for (const k of Object.keys(spec)) if (!ALLOWED[op].includes(k)) { errors.push(`${where}: unknown key '${k}' for '${op}'`); return false; }
    return true;
}

function strList(v: unknown): string[] | null {
    return Array.isArray(v) && v.length > 0 && v.every(x => typeof x === 'string') ? (v as string[]) : null;
}

function ensureGroup(w: Work, group: string, create: boolean, where: string, errors: string[]): boolean {
    if (typeof group !== 'string' || !PATH_PART.test(group)) { errors.push(`${where}: group '${group}' is not a valid folder name`); return false; }
    if (group in w.blocks) return true;
    if (!create) { errors.push(`${where}: group '${group}' does not exist in blocks.json (add "createGroup": true to create it)`); return false; }
    w.blocks[group] = {};
    w.sortedGroups.add(group);
    w.log.push(`  new group ${group}`);
    return true;
}

function applyProps(target: any, spec: Raw, where: string, errors: string[]): void {
    if ('scene' in spec) {
        const v = spec.scene;
        if (v === null) delete target.scene;
        else if (typeof v === 'string' && PATH_PART.test(v)) target.scene = v;
        else errors.push(`${where}: 'scene' must be a folder name or null`);
    }
    if ('order' in spec) {
        const v = spec.order;
        if (v === null) delete target.order;
        else if (Number.isInteger(v)) target.order = v;
        else errors.push(`${where}: 'order' must be an integer or null`);
    }
    if ('movable' in spec) {
        const v = spec.movable;
        if (v === true) target.movable = true;
        else if (v === false || v === null) delete target.movable;
        else errors.push(`${where}: 'movable' must be true or false`);
    }
}

function opSet(w: Work, spec: Raw, where: string, errors: string[], warnings: string[]): void {
    const names = spec.blocks !== undefined ? strList(spec.blocks) : typeof spec.block === 'string' ? [spec.block] : null;
    if ((spec.blocks !== undefined) === (spec.block !== undefined) || names === null) { errors.push(`${where}: give 'block' (a name) or 'blocks' (a list of names)`); return; }
    if (!['scene', 'group', 'order', 'movable'].some(k => k in spec)) { errors.push(`${where}: nothing to set (scene, group, order or movable)`); return; }
    if ('group' in spec && !ensureGroup(w, spec.group as string, spec.createGroup === true, where, errors)) return;
    for (const name of names) {
        const g = groupOf(w, name);
        if (g === null) { errors.push(`${where}: block '${name}' does not exist`); continue; }
        const block = w.blocks[g][name];
        const before = JSON.stringify(block);
        const probe: any = { ...block };
        applyProps(probe, spec, where, errors);
        let newGroup = g;
        if ('group' in spec && spec.group !== g) newGroup = spec.group as string;
        if (JSON.stringify(probe) === before && newGroup === g) { w.log.push(`  =set      ${name} (unchanged)`); continue; }
        if (probe.movable === true && block.movable !== true && w.transforms[name]?.length) warnings.push(`${where}: '${name}' has transforms.json rules`);
        w.blocks[g][name] = probe;
        if (newGroup !== g) {
            delete w.blocks[g][name];
            w.blocks[newGroup][name] = probe;
            w.touched.add(newGroup);
        }
        w.touched.add(g);
        w.changed = true;
        const diff = ['scene', 'order', 'movable'].filter(k => JSON.stringify(block[k]) !== JSON.stringify(probe[k])).map(k => `${k} ${block[k] === undefined ? '-' : JSON.stringify(block[k])} -> ${probe[k] === undefined ? '-' : JSON.stringify(probe[k])}`);
        if (newGroup !== g) diff.unshift(`group ${g} -> ${newGroup}`);
        w.log.push(`  set      ${name}: ${diff.join(', ')}`);
    }
}

function opRename(w: Work, spec: Raw, where: string, errors: string[], fileNames: ReadonlySet<string>): void {
    const from = spec.block, to = spec.to;
    if (typeof from !== 'string' || typeof to !== 'string') { errors.push(`${where}: 'block' and 'to' must be names`); return; }
    if (!IDENT.test(to)) { errors.push(`${where}: '${to}' is not a valid identifier`); return; }
    const g = groupOf(w, from);
    if (g === null) {
        if (groupOf(w, to) !== null) { w.log.push(`  =rename   ${from} -> ${to} (already done)`); return; }
        errors.push(`${where}: block '${from}' does not exist`); return;
    }
    if (from === to) { errors.push(`${where}: block and 'to' are both '${from}'`); return; }
    if (groupOf(w, to) !== null) { errors.push(`${where}: a block named '${to}' already exists`); return; }
    if (partOwner(w).has(to)) { errors.push(`${where}: '${to}' is already the name of a part`); return; }
    if (fileNames.has(to)) { errors.push(`${where}: '${to}' is the name of a file in files.json`); return; }
    const members = w.blocks[g];
    const rebuilt: Record<string, any> = {};
    for (const [k, v] of Object.entries(members)) rebuilt[k === from ? to : k] = v;
    w.blocks[g] = rebuilt;
    if (w.transforms[from] !== undefined) { w.transforms[to] = w.transforms[from]; delete w.transforms[from]; }
    if (w.notes.has(from)) { w.notes.set(to, w.notes.get(from)!); w.notes.delete(from); }
    recordNameChange(w, from, to);
    w.changed = true;
    w.log.push(`  rename   ${from} -> ${to}`);
}

/** Text that names `from` (a renamed block, or a block a merge absorbed) must name `to`; chains collapse (A -> B, B -> C gives A -> C). */
function recordNameChange(w: Work, from: string, to: string): void {
    for (const [o, n] of w.renames) if (n === from) w.renames.set(o, to);
    w.renames.set(from, to);
}

function opMerge(w: Work, spec: Raw, where: string, errors: string[], warnings: string[], fileNames: ReadonlySet<string>): void {
    const names = strList(spec.blocks);
    const into = spec.into;
    if (names === null || names.length < 2 || new Set(names).size !== names.length) { errors.push(`${where}: 'blocks' must list at least two different block names`); return; }
    if (typeof into !== 'string' || !IDENT.test(into)) { errors.push(`${where}: 'into' must be a block name (one of 'blocks' or a new name)`); return; }
    if (spec.notes !== undefined && spec.notes !== 'join') { errors.push(`${where}: 'notes' can only be "join"`); return; }
    const groups = names.map(n => groupOf(w, n));
    const missing = names.filter((_, i) => groups[i] === null);
    if (missing.length) { errors.push(`${where}: block(s) not found: ${missing.join(', ')} (a merge cannot be applied twice)`); return; }
    if (!names.includes(into)) {
        if (groupOf(w, into) !== null) { errors.push(`${where}: a block named '${into}' already exists and is not in 'blocks'`); return; }
        if (partOwner(w).has(into)) { errors.push(`${where}: '${into}' is already the name of a part`); return; }
        if (fileNames.has(into)) { errors.push(`${where}: '${into}' is the name of a file in files.json`); return; }
    }
    const defs = names.map((n, i) => w.blocks[groups[i]!][n]);

    // properties: the blocks agree, or the op decides
    const result: any = {};
    const propKeys = new Set<string>(defs.flatMap(d => Object.keys(d).filter(k => k !== 'parts')));
    for (const key of propKeys) {
        const values = defs.map(d => (d[key] === undefined ? undefined : JSON.stringify(d[key])));
        if (new Set(values).size > 1 && !(key in spec)) {
            errors.push(`${where}: the blocks disagree on '${key}' (${names.map((n, i) => `${n}=${values[i] ?? '-'}`).join(', ')}); set it in the op`);
            continue;
        }
        if (defs[0][key] !== undefined) result[key] = defs[0][key];
        else { const d = defs.find(x => x[key] !== undefined); if (d) result[key] = d[key]; }
    }
    applyProps(result, spec, where, errors);
    let group = groups[0]!;
    if ('group' in spec) {
        if (!ensureGroup(w, spec.group as string, spec.createGroup === true, where, errors)) return;
        group = spec.group as string;
    } else if (new Set(groups).size > 1) {
        errors.push(`${where}: the blocks are in different groups (${[...new Set(groups)].join(', ')}); set 'group' in the op`);
    }
    if (errors.length) return;

    // notes and transforms
    const noted = names.filter(n => w.notes.has(n));
    let note: string | undefined;
    if (noted.length > 1 && spec.notes !== 'join') { errors.push(`${where}: ${noted.length} of the blocks have a block note (${noted.join(', ')}); give "notes": "join" or combine them first with npm run merge`); return; }
    if (noted.length) note = noted.map(n => w.notes.get(n)!).join('\n\n');
    const rules = names.flatMap(n => (Array.isArray(w.transforms[n]) ? w.transforms[n] : []));
    if (rules.length) warnings.push(`${where}: ${rules.length} transforms.json rule(s) of the merged blocks now apply to the whole new block`);

    // apply
    const parts: Record<string, any> = {};
    for (const d of defs) Object.assign(parts, d.parts);
    const sorted = Object.fromEntries(Object.entries(parts).sort((a, b) => (a[1].order ?? a[1].start) - (b[1].order ?? b[1].start)));
    for (let i = 0; i < names.length; i++) {
        delete w.blocks[groups[i]!][names[i]];
        w.touched.add(groups[i]!);
        delete w.transforms[names[i]];
        w.notes.delete(names[i]);
        if (names[i] !== into) recordNameChange(w, names[i], into);
    }
    w.blocks[group][into] = { ...result, parts: sorted };
    w.touched.add(group);
    if (rules.length) w.transforms[into] = rules;
    if (note !== undefined) w.notes.set(into, note);
    w.changed = true;
    w.log.push(`  merge    ${names.join(' + ')} -> ${into} (${Object.keys(parts).length} parts, group ${group})`);
}

function opMovePart(w: Work, spec: Raw, where: string, errors: string[], warnings: string[], fileNames: ReadonlySet<string>): void {
    const parts = spec.parts !== undefined ? strList(spec.parts) : typeof spec.part === 'string' ? [spec.part] : null;
    if ((spec.parts !== undefined) === (spec.part !== undefined) || parts === null) { errors.push(`${where}: give 'part' (a name) or 'parts' (a list of names)`); return; }
    const to = spec.to;
    if (typeof to !== 'string' || !IDENT.test(to)) { errors.push(`${where}: 'to' must be a block name`); return; }
    if (spec.from !== undefined && typeof spec.from !== 'string') { errors.push(`${where}: 'from' must be a block name`); return; }
    const owners = partOwner(w);
    for (const p of parts) if (!owners.has(p)) { errors.push(`${where}: part '${p}' does not exist`); return; }
    if (spec.from !== undefined) for (const p of parts) if (owners.get(p) !== spec.from && owners.get(p) !== to) { errors.push(`${where}: part '${p}' is in '${owners.get(p)}', not in '${spec.from}'`); return; }
    if (parts.every(p => owners.get(p) === to)) { w.log.push(`  =move     ${parts.join(', ')} -> ${to} (already done)`); return; }
    if (parts.some(p => owners.get(p) === to)) { errors.push(`${where}: some of the parts are already in '${to}' and some are not`); return; }

    let dg = groupOf(w, to);
    let created = false;
    if (dg === null) {
        const c = spec.create;
        if (c === undefined || typeof c !== 'object' || c === null || Array.isArray(c)) { errors.push(`${where}: block '${to}' does not exist (add "create": { "group": ... } to make it)`); return; }
        const cr = c as Raw;
        for (const k of Object.keys(cr)) if (!['group', 'scene', 'order', 'movable', 'createGroup'].includes(k)) { errors.push(`${where}: unknown key '${k}' in 'create'`); return; }
        if (typeof cr.group !== 'string') { errors.push(`${where}: 'create' needs a 'group'`); return; }
        if (owners.has(to) || fileNames.has(to)) { errors.push(`${where}: '${to}' is already the name of a part or a file`); return; }
        if (!ensureGroup(w, cr.group, cr.createGroup === true, where, errors)) return;
        const fresh: any = {};
        applyProps(fresh, cr, where, errors);
        if (errors.length) return;
        fresh.parts = {};
        w.blocks[cr.group][to] = fresh;
        dg = cr.group;
        created = true;
    }
    const dest = w.blocks[dg][to];
    const sources = new Map<string, string[]>();
    for (const p of parts) { const s = owners.get(p)!; sources.set(s, [...(sources.get(s) ?? []), p]); }
    for (const [s, moved] of sources) {
        if (moved.length >= Object.keys(w.blocks[groupOf(w, s)!][s].parts).length) {
            errors.push(`${where}: moving ${moved.join(', ')} would leave '${s}' without parts (merge the blocks instead)`);
            if (created) delete w.blocks[dg][to];
            return;
        }
        if (w.transforms[s]?.length) warnings.push(`${where}: '${s}' has transforms.json rules and loses part(s)`);
    }
    if (w.transforms[to]?.length) warnings.push(`${where}: '${to}' has transforms.json rules and gains part(s)`);
    for (const p of parts) {
        const s = owners.get(p)!;
        const sg = groupOf(w, s)!;
        dest.parts[p] = w.blocks[sg][s].parts[p];
        delete w.blocks[sg][s].parts[p];
        w.touched.add(sg);
    }
    dest.parts = Object.fromEntries(Object.entries<any>(dest.parts).sort((a, b) => (a[1].order ?? a[1].start) - (b[1].order ?? b[1].start)));
    w.touched.add(dg);
    w.changed = true;
    w.log.push(`  move     ${parts.join(', ')} -> ${to}${created ? ' (new block)' : ''} from ${[...sources.keys()].join(', ')}`);
}

// ---------------------------------------------------------------------------------------------------------------- command

export async function applyBlocks(projectRoot: string, specPath: string, options: BlocksOptions, db: DbGameRomModule): Promise<BlocksResult> {
    const result: BlocksResult = { ok: false, errors: [], warnings: [], filesChanged: [] };
    const errors = result.errors, warnings = result.warnings;

    // ------------------------------------------------------------------ spec
    const specAbs = resolve(specPath);
    if (!existsSync(specAbs)) { errors.push(`spec file not found: ${specPath}`); return report(result, options); }
    let raw: unknown;
    try { raw = JSON.parse(readFileSync(specAbs, 'utf-8')); } catch (e) { errors.push(`spec is not valid JSON: ${e}`); return report(result, options); }
    if (!Array.isArray(raw)) { errors.push('spec must be a JSON array of operations ({ "op": "merge" | "move-part" | "rename" | "set", ... })'); return report(result, options); }

    // ------------------------------------------------------------------ current state
    const blocksPath = join(projectRoot, 'us', 'blocks.json');
    const blocksText = readFileSync(blocksPath, 'utf-8');
    const blocksEol = eolOf(blocksText);
    const current = JSON.parse(blocksText) as BlocksFile;
    if (withEol(serializeBlocks(current), blocksEol) !== blocksText) warnings.push('us/blocks.json is not in the canonical format; the tool will rewrite it in that format');
    const transformsPath = join(projectRoot, 'us', 'transforms.json');
    const transformsText = existsSync(transformsPath) ? readFileSync(transformsPath, 'utf-8') : '{}';
    const currentTransforms = JSON.parse(transformsText) as Record<string, any>;

    const noteBanks = loadNoteBanks(projectRoot, 'blockNotes');
    const noteText = new Map<string, string>();
    const noteBankOf = new Map<string, number>();
    for (const [bank, data] of noteBanks) for (const [k, v] of Object.entries(data)) { noteText.set(k, v); noteBankOf.set(k, bank); }

    const fileNames = new Set<string>();
    const filesJsonPath = join(projectRoot, 'us', 'files.json');
    if (existsSync(filesJsonPath)) {
        const files = JSON.parse(readFileSync(filesJsonPath, 'utf-8')) as Record<string, Record<string, Record<string, unknown>>>;
        for (const scenes of Object.values(files)) for (const scene of Object.values(scenes)) for (const name of Object.keys(scene)) fileNames.add(name);
    }

    const w: Work = {
        blocks: structuredClone(current),
        transforms: structuredClone(currentTransforms),
        notes: new Map(noteText),
        renames: new Map(),
        touched: new Set(),
        sortedGroups: new Set(Object.entries(current).filter(([, m]) => isSorted(m)).map(([g]) => g)),
        log: [],
        changed: false,
    };

    // ------------------------------------------------------------------ operations
    raw.forEach((entry, i) => {
        if (errors.length > 0) return;
        const where = `operation #${i + 1}${entry && typeof entry === 'object' && (entry as Raw).row ? ` (${(entry as Raw).row})` : ''}`;
        if (entry === null || typeof entry !== 'object' || Array.isArray(entry)) { errors.push(`${where}: must be an object`); return; }
        const spec = entry as Raw;
        if (!check(spec, where, errors)) return;
        switch (spec.op) {
            case 'set': opSet(w, spec, where, errors, warnings); break;
            case 'rename': opRename(w, spec, where, errors, fileNames); break;
            case 'merge': opMerge(w, spec, where, errors, warnings, fileNames); break;
            case 'move-part': opMovePart(w, spec, where, errors, warnings, fileNames); break;
        }
    });
    console.log(`Blocks: ${raw.length} operation(s)`);
    for (const l of w.log) console.log(l);
    if (errors.length > 0) return report(result, options);

    // sorted groups stay sorted (new blocks go to their place by offset); emptied groups disappear
    for (const g of w.touched) {
        if (!(g in w.blocks)) continue;
        if (Object.keys(w.blocks[g]).length === 0) { delete w.blocks[g]; console.log(`  group ${g} is now empty and removed`); continue; }
        if (w.sortedGroups.has(g)) w.blocks[g] = Object.fromEntries(Object.entries<any>(w.blocks[g]).sort((a, b) => minStart(a[1]) - minStart(b[1])));
    }

    if (!w.changed) { console.log('\nNothing to change.'); result.ok = true; return result; }

    // ------------------------------------------------------------------ structure
    const before = new Set(validateStructure(current, fileNames));
    for (const e of validateStructure(w.blocks, fileNames)) (before.has(e) ? warnings : errors).push(before.has(e) ? `already so before: ${e}` : e);
    for (const key of Object.keys(w.transforms)) {
        if (w.transforms[key]?.length && groupOf(w, key) === null) errors.push(`transforms.json has rules for '${key}', which is not a block`);
    }
    if (errors.length > 0) return report(result, options);

    // ------------------------------------------------------------------ block notes: the key follows the block, and lives in the bank of the block's first byte
    const noteKeyBank = (key: string): number => {
        const g = groupOf(w, key);
        return g === null ? (noteBankOf.get(key) ?? 0) : bankOfStart(minStart(w.blocks[g][key]));
    };

    // ------------------------------------------------------------------ verification (scratch extract + rebuild, before and after)
    const snap = (blocks: BlocksFile, transforms: Record<string, any>, notes: Map<string, string>): Snapshot => ({ blocks, transforms, blockNotes: Object.fromEntries(notes) });
    const verify = await verifyRegroup(projectRoot, db, snap(current, currentTransforms, noteText), snap(w.blocks, w.transforms, w.notes));
    for (const e of verify.errors) errors.push(e);
    for (const x of verify.warnings) warnings.push(x);
    for (const l of verify.info) console.log(`  verify   ${l}`);
    if (errors.length > 0) return report(result, options);

    // a new block name must not be a label (unless the label is the block's own first part, as in meta_tables_008000)
    const oldNames = new Set(Object.values(current).flatMap(m => Object.keys(m)));
    const owners = partOwner(w);
    for (const g of Object.keys(w.blocks)) for (const name of Object.keys(w.blocks[g])) {
        if (!oldNames.has(name) && verify.beforeLabels.has(name) && owners.get(name) !== name) errors.push(`'${name}' is a label of the code; a block of that name shadows it in the assembler`);
    }
    if (errors.length > 0) return report(result, options);

    // ------------------------------------------------------------------ plan the writes
    const writes = new Map<string, string>();
    const perFile: Array<[string, number]> = [];
    const rel = (p: string) => relative(projectRoot, p).split(sep).join('/');

    if (JSON.stringify(w.blocks) !== JSON.stringify(current) || withEol(serializeBlocks(w.blocks), blocksEol) !== blocksText) writes.set(blocksPath, withEol(serializeBlocks(w.blocks), blocksEol));
    if (JSON.stringify(w.transforms) !== JSON.stringify(currentTransforms)) writes.set(transformsPath, withEol(JSON.stringify(w.transforms, null, 4) + '\n', eolOf(transformsText)));

    // text that mentions a renamed block (names that are also labels are left alone)
    const textMap = new Map<string, string>();
    for (const [o, n] of w.renames) {
        if (verify.beforeLabels.has(o) || owners.has(o)) { warnings.push(`'${o}' is also a label of the code: text that mentions it was left unchanged (rename the label with npm run names)`); continue; }
        textMap.set(o, n);
    }

    // notes/: block-note keys move with the block (and into the bank of its first byte); all three tiers get the text rewrite
    const noteEol = (bank: number, kind: string) => { const p = join(projectRoot, 'notes', kind, bankFileName(bank)); return existsSync(p) ? eolOf(readFileSync(p, 'utf-8')) : '\n'; };
    const newBanks = new Map<number, Record<string, string>>();
    for (const [key, text] of w.notes) {
        const bank = noteKeyBank(key);
        const data = newBanks.get(bank) ?? newBanks.set(bank, {}).get(bank)!;
        data[key] = replaceWords(text, textMap);
    }
    for (const bank of new Set([...noteBanks.keys(), ...newBanks.keys()])) {
        const next = newBanks.get(bank) ?? {};
        const prev = noteBanks.get(bank) ?? {};
        if (JSON.stringify(Object.entries(next).sort()) === JSON.stringify(Object.entries(prev).sort())) continue;
        const p = join(projectRoot, 'notes', 'blockNotes', bankFileName(bank));
        writes.set(p, withEol(serializeJson(next), noteEol(bank, 'blockNotes')));
        perFile.push([rel(p), Object.keys(next).length]);
    }
    if (textMap.size > 0) {
        for (const kind of ['partNotes', 'comments']) {
            for (const [bank, data] of loadNoteBanks(projectRoot, kind)) {
                let n = 0;
                const out: Record<string, string> = {};
                for (const [k, v] of Object.entries(data)) { const nv = replaceWords(v, textMap); if (nv !== v) n++; out[k] = nv; }
                if (n > 0) {
                    const p = join(projectRoot, 'notes', kind, bankFileName(bank));
                    writes.set(p, withEol(serializeJson(out), noteEol(bank, kind)));
                    perFile.push([rel(p), n]);
                }
            }
        }
        const files: string[] = [];
        const skip = (p: string) => resolve(p) === join(projectRoot, 'us', 'names');
        for (const d of ['baserom', 'us', 'docs']) walk(join(projectRoot, d), files, skip);
        for (const f of files) {
            if (resolve(f) === resolve(blocksPath) || resolve(f) === resolve(transformsPath)) continue;
            const text = readFileSync(f, 'utf-8');
            const out = replaceWords(text, textMap);
            if (out !== text) { writes.set(f, out); perFile.push([rel(f), 1]); }
        }
        if (existsSync(join(projectRoot, 'baserom'))) {
            const stale: string[] = [];
            const all: string[] = [];
            walk(join(projectRoot, 'baserom'), all, () => false);
            for (const f of all) if (textMap.has(f.split(/[\\/]/).pop()!.replace(/\.[^.]+$/, '').replace(/\.patch$/, ''))) stale.push(rel(f));
            for (const s of stale) warnings.push(`${s} is named after a renamed block: rename the file by hand`);
        }
    }

    for (const p of writes.keys()) result.filesChanged.push(rel(p));
    for (const [f, n] of perFile.sort((a, b) => a[0].localeCompare(b[0]))) console.log(`  ${String(n).padStart(5)} note/text  ${f}`);
    if (errors.length > 0) return report(result, options);

    if (!options.dryRun) {
        for (const [p, content] of writes) {
            mkdirSync(join(p, '..'), { recursive: true });
            writeFileSync(p, content, 'utf-8');
        }
    }
    result.ok = true;
    return report(result, options);
}

function report(result: BlocksResult, options: BlocksOptions): BlocksResult {
    for (const w of result.warnings) console.warn(`  ! ${w}`);
    if (result.errors.length > 0) {
        console.error('\nNothing written (fix the errors and re-run).\n\nErrors:');
        for (const e of result.errors) console.error(`  X ${e}`);
        return result;
    }
    if (options.dryRun) console.log(`\n[DRY RUN] ${result.filesChanged.length} file(s) would change; nothing written.`);
    else if (result.filesChanged.length > 0) console.log(`\nWrote ${result.filesChanged.length} file(s): ${result.filesChanged.join(', ')}\n\nNext: npm run extract:lt, npm run rebuild, npm run merge -- --check, npm run names -- --check.`);
    else console.log('\nNothing to change.');
    return result;
}
