/**
 * Audit report: `npm run audit`
 *
 * Read-only. Reads the extracted tree (`extracted/`, plain or line-tracked), `us/blocks.json` and `notes/`, and reports
 *
 *   - coverage per group and per block: block note, part notes (top-level labels and sub-labels), inline comments
 *     per instruction, auto-named labels still left (`code_0064F8`, `loc_006512`, ... see AUTO_LABEL)
 *   - the cross-file reference matrix: group -> group, file -> file, and the labels and files with the highest fan-in
 *   - consistency findings: blocks without a file, files without a block, labels defined twice, `block.label`
 *     references whose block does not define the label, `?INCLUDE` closure gaps, unexpected lines
 *
 * Usage:
 *   npm run audit                          summary tables (groups, fan-in, group matrix, findings)
 *   npm run audit -- --blocks              one row per block (add --group=<name> to filter)
 *   npm run audit -- --block=<name>        one block in detail (labels with note / auto-name state, include and reference counts)
 *   npm run audit -- --matrix              file -> file reference pairs (sorted by count; --top=N, default 40)
 *   npm run audit -- --top=N               rows in the fan-in and matrix tables (default 25)
 *   npm run audit -- --json=<path>         also write the full report as JSON (the only thing it ever writes)
 *
 * It never changes notes, names, blocks or the extracted tree. Run `npm run extract:lt` (or `extract`) first: the
 * report is only as fresh as the tree.
 */

import { existsSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from 'fs';
import { dirname, join, resolve } from 'path';
import { AUTO_LABEL, loadAsmTree, listAssetNames } from './asm-index.ts';
import type { AsmFile, AsmTree } from './asm-index.ts';
import { readExtractState } from './extract-state.ts';
import { loadJsonFile } from './notes-common.ts';
import config from '../us/config.json' with { type: 'json' };

export interface AuditOptions {
    group?: string;
    block?: string;
    blocks?: boolean;
    matrix?: boolean;
    top?: number;
    json?: string;
}

interface BlockDef {
    group: string;
    name: string;
    movable: boolean;
    order: number | null;
    scene: string | null;
    parts: number;
    start: number;
    end: number;
}

export interface BlockStats {
    name: string;
    group: string;
    scene: string | null;
    movable: boolean;
    order: number | null;
    parts: number;
    start: number;
    bank: number;
    bytes: number;
    lines: number;
    instructions: number;
    commented: number;
    topLabels: number;
    codeLabels: number;
    subLabels: number;
    autoTop: number;
    autoSub: number;
    blockNote: boolean;
    partNotesTop: number;
    partNotesSub: number;
    refsOut: number;
    refsIn: number;
    filesOut: number;
    filesIn: number;
    includes: number;
}

interface FanInLabel { label: string; file: string; refs: number; files: number }
interface FanInFile { file: string; group: string; refs: number; files: number; labels: number }
interface Pair { from: string; to: string; refs: number; labels: number; short: number; long: number; bank: number; rel: number }

const pct = (n: number, d: number) => (d === 0 ? '   -' : `${((100 * n) / d).toFixed(1)}%`.padStart(5));
const pad = (v: string | number, n: number) => String(v).padStart(n);
const bankShift = config.memoryMode === 'Lo' ? 15 : 16;

function readBlockDefs(projectRoot: string): BlockDef[] {
    const raw = JSON.parse(readFileSync(join(projectRoot, 'us', 'blocks.json'), 'utf-8')) as Record<string, Record<string, any>>;
    const defs: BlockDef[] = [];
    for (const [group, blocks] of Object.entries(raw)) {
        for (const [name, b] of Object.entries(blocks)) {
            const parts: Array<{ start: number; end: number }> = b.parts ? Object.values(b.parts) : [b];
            defs.push({
                group,
                name,
                movable: b.movable === true,
                order: typeof b.order === 'number' ? b.order : null,
                scene: typeof b.scene === 'string' ? b.scene : null,
                parts: parts.length,
                start: Math.min(...parts.map(p => p.start)),
                end: Math.max(...parts.map(p => p.end)),
            });
        }
    }
    return defs;
}

function loadNotes(projectRoot: string, kind: string): Record<string, string> {
    const dir = join(projectRoot, 'notes', kind);
    const merged: Record<string, string> = {};
    if (!existsSync(dir)) return merged;
    for (const f of readdirSync(dir)) if (/^bank[0-9A-Fa-f]{2}\.json$/.test(f)) Object.assign(merged, loadJsonFile(join(dir, f)));
    return merged;
}

export function runAudit(projectRoot: string, options: AuditOptions): boolean {
    const extractedDir = join(projectRoot, 'extracted');
    const state = readExtractState(extractedDir);
    if (state === null) console.warn('! extracted/ has no .extract-state.json marker; run `npm run extract:lt` for a trustworthy tree.');
    else if (state.status !== 'complete') { console.error(`extracted/ is incomplete (.extract-state.json says '${state.status}'); run npm run extract:lt`); return false; }

    const tree = loadAsmTree(extractedDir);
    if (tree.files.size === 0) { console.error('extracted/ has no .asm files; run npm run extract:lt'); return false; }

    const defs = readBlockDefs(projectRoot);
    const blockNotes = loadNotes(projectRoot, 'blockNotes');
    const partNotes = loadNotes(projectRoot, 'partNotes');
    const defByName = new Map(defs.map(d => [d.name, d]));

    // ------------------------------------------------------------------ per-block statistics
    const refsOut = new Map<string, number>(), refsIn = new Map<string, number>();
    const outFiles = new Map<string, Set<string>>(), inFiles = new Map<string, Set<string>>();
    const labelFan = new Map<string, { refs: number; from: Set<string> }>();
    const fileFan = new Map<string, { refs: number; from: Set<string>; labels: Set<string> }>();
    const pairs = new Map<string, { refs: number; labels: Set<string>; short: number; long: number; bank: number; rel: number }>();
    let internalRefs = 0;
    for (const r of tree.refs) {
        if (r.fileName === r.toFile) { internalRefs++; continue; }
        refsOut.set(r.fileName, (refsOut.get(r.fileName) ?? 0) + 1);
        refsIn.set(r.toFile, (refsIn.get(r.toFile) ?? 0) + 1);
        (outFiles.get(r.fileName) ?? outFiles.set(r.fileName, new Set()).get(r.fileName)!).add(r.toFile);
        (inFiles.get(r.toFile) ?? inFiles.set(r.toFile, new Set()).get(r.toFile)!).add(r.fileName);
        const lf = labelFan.get(r.to) ?? labelFan.set(r.to, { refs: 0, from: new Set() }).get(r.to)!;
        lf.refs++; lf.from.add(r.fileName);
        const ff = fileFan.get(r.toFile) ?? fileFan.set(r.toFile, { refs: 0, from: new Set(), labels: new Set() }).get(r.toFile)!;
        ff.refs++; ff.from.add(r.fileName); ff.labels.add(r.to);
        const key = `${r.fileName}\u0000${r.toFile}`;
        const p = pairs.get(key) ?? pairs.set(key, { refs: 0, labels: new Set(), short: 0, long: 0, bank: 0, rel: 0 }).get(key)!;
        p.refs++; p.labels.add(r.to); p[r.form]++;
    }

    const stats: BlockStats[] = [];
    for (const file of tree.files.values()) {
        const def = defByName.get(file.name);
        const group = def?.group ?? file.group;
        let instructions = 0, commented = 0, codeLabels = 0, subLabels = 0, autoTop = 0, autoSub = 0, pnTop = 0, pnSub = 0;
        for (const u of file.units) {
            instructions += u.instructions; commented += u.commented;
            if (u.kind === 'code') codeLabels++;
            if (AUTO_LABEL.test(u.label)) autoTop++;
            if (partNotes[u.label] !== undefined) pnTop++;
            subLabels += u.subLabels.length;
            for (const s of u.subLabels) { if (AUTO_LABEL.test(s)) autoSub++; if (partNotes[s] !== undefined) pnSub++; }
        }
        stats.push({
            name: file.name,
            group,
            scene: def?.scene ?? (file.scene || null),
            movable: def?.movable ?? false,
            order: def?.order ?? null,
            parts: def?.parts ?? 0,
            start: def?.start ?? -1,
            bank: def ? def.start >> bankShift : -1,
            bytes: def ? def.end - def.start : 0,
            lines: file.lines,
            instructions,
            commented,
            topLabels: file.units.length,
            codeLabels,
            subLabels,
            autoTop,
            autoSub,
            blockNote: blockNotes[file.name] !== undefined,
            partNotesTop: pnTop,
            partNotesSub: pnSub,
            refsOut: refsOut.get(file.name) ?? 0,
            refsIn: refsIn.get(file.name) ?? 0,
            filesOut: outFiles.get(file.name)?.size ?? 0,
            filesIn: inFiles.get(file.name)?.size ?? 0,
            includes: file.includes.length,
        });
    }
    stats.sort((a, b) => a.group.localeCompare(b.group) || a.start - b.start || a.name.localeCompare(b.name));

    const groupNames = [...new Set(stats.map(s => s.group))];
    const byGroup = new Map<string, BlockStats[]>(groupNames.map(g => [g, stats.filter(s => s.group === g)]));
    const total = (list: BlockStats[]) => list.reduce((a, s) => ({
        blocks: a.blocks + 1, lines: a.lines + s.lines, instructions: a.instructions + s.instructions, commented: a.commented + s.commented,
        topLabels: a.topLabels + s.topLabels, subLabels: a.subLabels + s.subLabels, autoTop: a.autoTop + s.autoTop, autoSub: a.autoSub + s.autoSub,
        blockNotes: a.blockNotes + (s.blockNote ? 1 : 0), partNotesTop: a.partNotesTop + s.partNotesTop, partNotesSub: a.partNotesSub + s.partNotesSub,
        parts: a.parts + s.parts, refsOut: a.refsOut + s.refsOut, refsIn: a.refsIn + s.refsIn, movable: a.movable + (s.movable ? 1 : 0),
    }), { blocks: 0, lines: 0, instructions: 0, commented: 0, topLabels: 0, subLabels: 0, autoTop: 0, autoSub: 0, blockNotes: 0, partNotesTop: 0, partNotesSub: 0, parts: 0, refsOut: 0, refsIn: 0, movable: 0 });
    const totals = total(stats);

    // ------------------------------------------------------------------ findings
    const findings: string[] = [];
    const filesWithoutDef = [...tree.files.values()].filter(f => !defByName.has(f.name)).map(f => f.name);
    const defsWithoutFile = defs.filter(d => !tree.files.has(d.name)).map(d => d.name);
    if (defsWithoutFile.length) findings.push(`${defsWithoutFile.length} block(s) of blocks.json have no extracted file (stale tree?): ${defsWithoutFile.slice(0, 5).join(', ')}${defsWithoutFile.length > 5 ? ', ...' : ''}`);
    if (filesWithoutDef.length) findings.push(`${filesWithoutDef.length} extracted .asm file(s) are not blocks of blocks.json: ${filesWithoutDef.slice(0, 5).join(', ')}${filesWithoutDef.length > 5 ? ', ...' : ''}`);
    for (const [label, where] of tree.duplicates) findings.push(`label '${label}' is defined in ${where.join(' and ')}`);
    const odd = [...tree.files.values()].filter(f => f.oddLines.length);
    if (odd.length) findings.push(`${odd.length} file(s) have unexpected column-0 lines, first: ${odd[0].rel}: ${odd[0].oddLines[0].slice(0, 60)}`);
    const assetNames = listAssetNames(extractedDir);
    const missingInclude = new Set<string>();
    for (const f of tree.files.values()) for (const inc of f.includes) if (!tree.files.has(inc) && !assetNames.has(inc)) missingInclude.add(`${f.name} -> ${inc}`);
    if (missingInclude.size) findings.push(`${missingInclude.size} ?INCLUDE target(s) do not exist: ${[...missingInclude].slice(0, 3).join('; ')}`);
    const qualifierBad = tree.refs.filter(r => r.qualifier !== null && r.qualifier !== r.toFile);
    if (qualifierBad.length) findings.push(`${qualifierBad.length} qualified reference(s) name the wrong block, first: ${qualifierBad[0].qualifier}.${qualifierBad[0].to} in ${qualifierBad[0].fileName} (label is in ${qualifierBad[0].toFile})`);
    const closureGaps = new Set<string>();
    for (const r of tree.refs) {
        if (r.fileName === r.toFile) continue;
        if (!tree.files.get(r.fileName)!.includes.includes(r.toFile)) closureGaps.add(`${r.fileName} -> ${r.toFile}`);
    }
    if (closureGaps.size) findings.push(`${closureGaps.size} file pair(s) reference each other without an ?INCLUDE, first: ${[...closureGaps][0]}`);

    const unpinned = new Map<string, number>();
    for (const r of tree.refs) {
        if (r.fileName === r.toFile || (r.form !== 'short' && r.form !== 'rel')) continue;
        if (defByName.get(r.toFile)?.movable) unpinned.set(r.toFile, (unpinned.get(r.toFile) ?? 0) + 1);
    }
    if (unpinned.size) findings.push(`2-byte references from other files target movable block(s), whose bank is chosen by the packer (bank-base hazard R-2): ${[...unpinned].map(([b, n]) => `${b} (${n})`).join(', ')}`);

    // ------------------------------------------------------------------ fan-in and matrices
    const top = options.top ?? 25;
    const fanLabels: FanInLabel[] = [...labelFan.entries()]
        .map(([label, v]) => ({ label, file: tree.labels.get(label)!.file, refs: v.refs, files: v.from.size }))
        .sort((a, b) => b.refs - a.refs || a.label.localeCompare(b.label));
    const fanFiles: FanInFile[] = [...fileFan.entries()]
        .map(([file, v]) => ({ file, group: tree.files.get(file)!.group, refs: v.refs, files: v.from.size, labels: v.labels.size }))
        .sort((a, b) => b.refs - a.refs || a.file.localeCompare(b.file));
    const filePairs: Pair[] = [...pairs.entries()]
        .map(([k, v]) => { const [from, to] = k.split('\u0000'); return { from, to, refs: v.refs, labels: v.labels.size, short: v.short, long: v.long, bank: v.bank, rel: v.rel }; })
        .sort((a, b) => b.refs - a.refs || a.from.localeCompare(b.from) || a.to.localeCompare(b.to));
    const groupOf = (file: string) => tree.files.get(file)?.group ?? '?';
    const groupMatrix = new Map<string, Map<string, number>>();
    for (const r of tree.refs) {
        if (r.fileName === r.toFile) continue;
        const a = groupOf(r.fileName), b = groupOf(r.toFile);
        const row = groupMatrix.get(a) ?? groupMatrix.set(a, new Map()).get(a)!;
        row.set(b, (row.get(b) ?? 0) + 1);
    }
    const crossRefs = tree.refs.length - internalRefs;

    // ------------------------------------------------------------------ print
    const out: string[] = [];
    const modeText = state ? state.mode : 'unknown';
    out.push(`Audit of ${extractedDir} (${tree.files.size} .asm files, ${modeText} extraction; blocks.json: ${defs.length} blocks in ${groupNames.length} groups)`);
    out.push('');

    const header = ['group', 'blocks', 'lines', 'instr', 'top', 'sub', 'auto%', 'bnote', 'pnote%', 'comm%', 'refs out', 'refs in'];
    const rows: string[][] = [header];
    const rowOf = (name: string, list: BlockStats[]) => {
        const t = total(list);
        return [name, String(t.blocks), String(t.lines), String(t.instructions), String(t.topLabels), String(t.subLabels),
            pct(t.autoTop + t.autoSub, t.topLabels + t.subLabels).trim(), `${t.blockNotes}/${t.blocks}`,
            pct(t.partNotesTop + t.partNotesSub, t.topLabels + t.subLabels).trim(), pct(t.commented, t.instructions).trim(), String(t.refsOut), String(t.refsIn)];
    };
    for (const g of groupNames) rows.push(rowOf(g, byGroup.get(g)!));
    rows.push(rowOf('TOTAL', stats));
    out.push('Coverage by group (auto% = auto-named labels / all labels; pnote% = labels with a part note; comm% = commented instructions)');
    out.push(...formatTable(rows, [0]));
    out.push('');
    out.push(`Labels: ${totals.topLabels} top-level + ${totals.subLabels} sub = ${totals.topLabels + totals.subLabels}; auto-named ${totals.autoTop} + ${totals.autoSub} = ${totals.autoTop + totals.autoSub}; named ${totals.topLabels + totals.subLabels - totals.autoTop - totals.autoSub}`);
    out.push(`Notes: ${totals.blockNotes} block notes, ${totals.partNotesTop + totals.partNotesSub} part notes on extracted labels (${Object.keys(partNotes).length} stored), ${Object.keys(loadNotes(projectRoot, 'comments')).length} stored comments, ${totals.commented} commented instructions of ${totals.instructions}`);
    out.push(`Blocks: ${totals.blocks} (${totals.movable} movable), ${totals.parts} parts in blocks.json`);
    out.push(`References: ${tree.refs.length} (${internalRefs} inside a file, ${crossRefs} across files in ${filePairs.length} file pairs)`);
    out.push('');

    out.push(`Top ${top} fan-in labels (references from other files)`);
    out.push(...formatTable([['label', 'file', 'refs', 'files'], ...fanLabels.slice(0, top).map(l => [l.label, l.file, String(l.refs), String(l.files)])], [0, 1]));
    out.push('');
    out.push(`Top ${top} fan-in files`);
    out.push(...formatTable([['file', 'group', 'refs', 'files', 'labels'], ...fanFiles.slice(0, top).map(f => [f.file, f.group, String(f.refs), String(f.files), String(f.labels)])], [0, 1]));
    out.push('');

    const mHeader = ['from \\ to', ...groupNames];
    const mRows: string[][] = [mHeader];
    for (const a of groupNames) mRows.push([a, ...groupNames.map(b => { const n = groupMatrix.get(a)?.get(b) ?? 0; return n ? String(n) : '.'; })]);
    out.push('Cross-file references, group -> group (rows reference columns; diagonal = between two files of the same group)');
    out.push(...formatTable(mRows, [0]));
    out.push('');

    if (options.matrix) {
        const n = options.top ?? 40;
        out.push(`Top ${n} file -> file reference pairs (of ${filePairs.length})`);
        out.push(...formatTable([['from', 'to', 'refs', 'labels', 'short', 'long', 'bank', 'rel'], ...filePairs.slice(0, n).map(p => [p.from, p.to, String(p.refs), String(p.labels), String(p.short), String(p.long), String(p.bank), String(p.rel)])], [0, 1]));
        out.push('');
    }

    if (options.blocks) {
        const list = stats.filter(s => !options.group || s.group === options.group);
        out.push(`Blocks${options.group ? ` of group ${options.group}` : ''} (${list.length})`);
        out.push(...formatTable([['block', 'group', 'mov', 'bank', 'lines', 'instr', 'top', 'sub', 'auto', 'bnote', 'pnote', 'comm', 'out', 'in'],
            ...list.map(s => [s.name, s.group, s.movable ? 'y' : '', s.bank >= 0 ? s.bank.toString(16).toUpperCase().padStart(2, '0') : '?', String(s.lines), String(s.instructions),
                String(s.topLabels), String(s.subLabels), String(s.autoTop + s.autoSub), s.blockNote ? 'y' : '', `${s.partNotesTop + s.partNotesSub}`, String(s.commented), String(s.refsOut), String(s.refsIn)])], [0, 1]));
        out.push('');
    }

    if (options.block) printBlock(out, options.block, tree, stats, partNotes, defByName, filePairs);

    out.push(findings.length ? `Findings (${findings.length})` : 'Findings: none');
    for (const f of findings) out.push(`  - ${f}`);
    console.log(out.join('\n'));

    if (options.block && !tree.files.has(options.block)) { console.error(`\nblock '${options.block}' has no extracted file`); return false; }

    if (options.json) {
        const path = resolve(options.json);
        mkdirSync(dirname(path), { recursive: true });
        writeFileSync(path, JSON.stringify({
            extractedDir, mode: modeText, files: tree.files.size, blocksJson: defs.length,
            totals, groups: groupNames.map(g => ({ group: g, ...total(byGroup.get(g)!) })),
            blocks: stats, fanInLabels: fanLabels, fanInFiles: fanFiles, filePairs,
            groupMatrix: Object.fromEntries([...groupMatrix.entries()].map(([k, v]) => [k, Object.fromEntries(v)])),
            internalRefs, crossFileRefs: crossRefs, findings,
        }, null, 2) + '\n', 'utf-8');
        console.log(`\nWrote ${path}`);
    }
    return true;
}

function printBlock(out: string[], name: string, tree: AsmTree, stats: BlockStats[], partNotes: Record<string, string>, defByName: Map<string, BlockDef>, pairs: Pair[]): void {
    const file: AsmFile | undefined = tree.files.get(name);
    const s = stats.find(x => x.name === name);
    if (!file || !s) { out.push(`Block '${name}': no extracted file`, ''); return; }
    const def = defByName.get(name);
    out.push(`Block ${name} (${file.rel})`);
    out.push(`  group ${s.group}${s.scene ? `, scene ${s.scene}` : ''}, ${s.movable ? 'movable' : `pinned to bank ${s.bank.toString(16).toUpperCase().padStart(2, '0')}`}${s.order !== null ? `, order ${s.order}` : ''}, ${s.parts} part(s), ${def ? `${def.end - def.start} bytes (offset ${def.start}..${def.end})` : 'not in blocks.json'}`);
    out.push(`  block note: ${s.blockNote ? 'yes' : 'no'}; ${s.lines} lines, ${s.instructions} instructions, ${s.commented} commented; includes ${s.includes}; refs out ${s.refsOut} (${s.filesOut} files), in ${s.refsIn} (${s.filesIn} files)`);
    const fan = new Map<string, number>();
    for (const r of tree.refs) if (r.toFile === name && r.fileName !== name) fan.set(r.to, (fan.get(r.to) ?? 0) + 1);
    out.push(...formatTable([['label', 'kind', 'auto', 'note', 'instr', 'comm', 'subs', 'refs in'],
        ...file.units.map(u => [u.label, u.kind, AUTO_LABEL.test(u.label) ? 'y' : '', partNotes[u.label] !== undefined ? 'y' : '', String(u.instructions), String(u.commented), String(u.subLabels.length), String((fan.get(u.label) ?? 0) + u.subLabels.reduce((a, l) => a + (fan.get(l) ?? 0), 0))])], [0, 1]).map(l => '  ' + l));
    const outPairs = pairs.filter(p => p.from === name).slice(0, 8), inPairs = pairs.filter(p => p.to === name).slice(0, 8);
    if (outPairs.length) out.push('  references out: ' + outPairs.map(p => `${p.to} (${p.refs})`).join(', '));
    if (inPairs.length) out.push('  referenced by:  ' + inPairs.map(p => `${p.from} (${p.refs})`).join(', '));
    out.push('');
}

/** Left-align the columns listed in `left`, right-align the rest; two spaces between columns. */
function formatTable(rows: string[][], left: number[]): string[] {
    const widths = rows[0].map((_, c) => Math.max(...rows.map(r => (r[c] ?? '').length)));
    const render = (r: string[]) => r.map((v, c) => (left.includes(c) ? v.padEnd(widths[c]) : pad(v, widths[c]))).join('  ').trimEnd();
    const lines = rows.map(render);
    lines.splice(1, 0, widths.map(w => '-'.repeat(w)).join('  '));
    return lines;
}
