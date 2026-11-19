/**
 * `npm run merge -- --check [--bank NN]` and `npm run merge -- --prune <orphans.json> [--dry-run]`
 *
 * --check   read-only audit of notes/ against the line-tracked extraction (`npm run extract:lt`):
 *   1. comment keys: exactly one extracted line carries `; {key}`; the key is in the bank file floor(key / 65536) says
 *   2. part-note keys: a label (top-level or sub-label) of an extracted file, or the old name of a transform rename rule
 *   3. block-note keys: a file under extracted/ that is also a block in blocks.json / files.json, in the block's bank
 *   4. a key lives in one bank file only, per kind
 *   5. bank rules per extracted file: `?BANK` agrees with blocks.json / files.json; no entry and no `?BANK` = bank guessed
 *   6. the transform guard (src/transform-guard.ts) applied to the stored notes
 *   Exit 1 on any error, 0 with warnings only.
 *
 * --prune   removes keys the check reports as orphans (or one copy of a duplicated key) and nothing else.
 *   { "comments": ["47052"], "partNotes": ["loc_03B928"], "blockNotes": ["cop_handlers_flags", "bank13:CreditPositionLookup"] }
 *   A key that the check does not report is refused, so a live note cannot be deleted. Facts that an orphan still
 *   carries are moved first with a normal merge spec.
 */

import { existsSync, readFileSync, readdirSync } from 'fs';
import { join, relative, sep } from 'path';
import {
    bankFileName, bankFromDirective, blockNameOfFile, detectBankDetailed, listAsmFiles, loadDbBankLookup, loadDbStartLookup,
    loadNamesBankLookup, saveJsonFile, TAG,
} from './notes-common.ts';
import { collectLabels } from './merge.ts';
import { TransformGuard } from './transform-guard.ts';
import { readExtractState } from './extract-state.ts';

export type NoteKind = 'blockNotes' | 'partNotes' | 'comments';
export const NOTE_KINDS: NoteKind[] = ['blockNotes', 'partNotes', 'comments'];

export interface Orphan { kind: NoteKind; key: string; bank: number }
export interface Duplicate { kind: NoteKind; key: string; banks: number[] }

export interface CheckResult {
    /** Set when the check cannot run at all (no tagged tree); nothing else is filled in. */
    fatal: string | null;
    errors: string[];
    warnings: string[];
    orphans: Orphan[];
    duplicates: Duplicate[];
    stored: Record<NoteKind, number>;
    files: number;
}

interface StoredFile {
    bank: number;
    path: string;
    data: Record<string, string>;
    /** 1-based line of each key in the JSON file. */
    keyLines: Map<string, number>;
}

interface AsmFile {
    rel: string;
    name: string;
    lines: string[];
    labels: Map<string, number[]>;
}

const hex2 = (bank: number) => bank.toString(16).toUpperCase().padStart(2, '0');
const bankLabel = (bank: number) => `bank${hex2(bank)}`;

function loadStored(projectRoot: string, kind: NoteKind, errors: string[]): StoredFile[] {
    const dir = join(projectRoot, 'notes', kind);
    const out: StoredFile[] = [];
    if (!existsSync(dir)) return out;
    for (const f of readdirSync(dir).sort()) {
        const m = f.match(/^bank([0-9A-Fa-f]{2})\.json$/);
        if (!m) continue;
        const path = join(dir, f);
        const text = readFileSync(path, 'utf-8');
        let data: Record<string, string>;
        try {
            data = JSON.parse(text);
        } catch (e) {
            errors.push(`notes/${kind}/${f}: not valid JSON (${(e as Error).message})`);
            continue;
        }
        const keyLines = new Map<string, number>();
        text.split(/\r?\n/).forEach((line, i) => {
            const k = line.match(/^\s*("(?:[^"\\]|\\.)*")\s*:/);
            if (!k) return;
            try { const key = JSON.parse(k[1]) as string; if (!keyLines.has(key)) keyLines.set(key, i + 1); } catch { /* not a key line */ }
        });
        out.push({ bank: parseInt(m[1], 16), path, data, keyLines });
    }
    return out;
}

/** blocks.json parts (and whole blocks) as address ranges, for the hint on an orphan comment key. */
function loadRanges(dbDir: string): Array<{ block: string; part?: string; start: number; end: number; type: string }> {
    const out: Array<{ block: string; part?: string; start: number; end: number; type: string }> = [];
    const path = join(dbDir, 'blocks.json');
    if (!existsSync(path)) return out;
    try {
        const groups = JSON.parse(readFileSync(path, 'utf-8'));
        for (const group of Object.values<any>(groups)) {
            for (const [block, entry] of Object.entries<any>(group)) {
                if (entry?.parts && typeof entry.parts === 'object') {
                    for (const [part, p] of Object.entries<any>(entry.parts)) {
                        if (typeof p?.start === 'number' && typeof p?.end === 'number') out.push({ block, part, start: p.start, end: p.end, type: String(p.type ?? '') });
                    }
                } else if (typeof entry?.start === 'number' && typeof entry?.end === 'number') {
                    out.push({ block, start: entry.start, end: entry.end, type: String(entry.type ?? '') });
                }
            }
        }
    } catch { /* no hint */ }
    return out;
}

function loadNameAddresses(namesDir: string): Map<number, string> {
    const out = new Map<number, string>();
    if (!existsSync(namesDir)) return out;
    for (const f of readdirSync(namesDir)) {
        if (!/^bank[0-9A-Fa-f]{2}\.json$/.test(f)) continue;
        try {
            const data = JSON.parse(readFileSync(join(namesDir, f), 'utf-8')) as Record<string, string>;
            for (const [addr, name] of Object.entries(data)) out.set(parseInt(addr, 10), name);
        } catch { /* ignore */ }
    }
    return out;
}

export function runCheck(projectRoot: string, options: { bank?: number } = {}): CheckResult {
    const result: CheckResult = {
        fatal: null, errors: [], warnings: [], orphans: [], duplicates: [],
        stored: { blockNotes: 0, partNotes: 0, comments: 0 }, files: 0,
    };
    const error = (msg: string) => result.errors.push(msg);
    const warn = (msg: string) => result.warnings.push(msg);
    const inFilter = (bank: number) => options.bank === undefined || options.bank === bank;

    // ---- the tree ----
    const extractedDir = join(projectRoot, 'extracted');
    try {
        const state = readExtractState(extractedDir);
        if (state !== null && state.status !== 'complete') {
            result.fatal = `extracted/ is incomplete (.extract-state.json says '${state.status}'); run npm run extract:lt`;
            return result;
        }
        if (state !== null && state.mode === 'plain') {
            result.fatal = 'extracted/ has no address tags; run npm run extract:lt';
            return result;
        }
    } catch (e) {
        result.fatal = (e as Error).message;
        return result;
    }

    const asm: AsmFile[] = [];
    const tagIndex = new Map<string, Array<{ file: AsmFile; line: number }>>();
    const labelIndex = new Map<string, Array<{ file: AsmFile; line: number }>>();
    const filesByName = new Map<string, AsmFile[]>();
    for (const abs of listAsmFiles(extractedDir)) {
        const lines = readFileSync(abs, 'utf-8').split(/\r?\n/);
        const file: AsmFile = {
            rel: relative(extractedDir, abs).split(sep).join('/'),
            name: blockNameOfFile(abs),
            lines,
            labels: collectLabels(lines),
        };
        asm.push(file);
        lines.forEach((line, i) => {
            const m = line.match(TAG);
            if (!m) return;
            if (!tagIndex.has(m[1])) tagIndex.set(m[1], []);
            tagIndex.get(m[1])!.push({ file, line: i + 1 });
        });
        for (const [label, at] of file.labels) {
            if (!labelIndex.has(label)) labelIndex.set(label, []);
            labelIndex.get(label)!.push({ file, line: at[0] });
        }
        if (!filesByName.has(file.name)) filesByName.set(file.name, []);
        filesByName.get(file.name)!.push(file);
    }
    result.files = asm.length;
    if (tagIndex.size === 0) {
        result.fatal = 'extracted/ has no address tags; run npm run extract:lt';
        return result;
    }

    const dbDir = join(projectRoot, 'us');
    const dbStart = loadDbStartLookup(dbDir);
    const dbBank = loadDbBankLookup(dbDir);
    const namesBank = loadNamesBankLookup(join(dbDir, 'names'));
    const nameAt = loadNameAddresses(join(dbDir, 'names'));
    const ranges = loadRanges(dbDir);
    const guard = TransformGuard.load(projectRoot, dbStart);

    const stored: Record<NoteKind, StoredFile[]> = {
        blockNotes: loadStored(projectRoot, 'blockNotes', result.errors),
        partNotes: loadStored(projectRoot, 'partNotes', result.errors),
        comments: loadStored(projectRoot, 'comments', result.errors),
    };
    for (const kind of NOTE_KINDS) for (const f of stored[kind]) result.stored[kind] += Object.keys(f.data).length;

    const fileBank = (file: AsmFile): number | null => detectBankDetailed(file.lines, file.name, namesBank, dbBank)?.bank ?? null;

    // The file a part note or comment belongs to, for the guard step.
    const filesOfLabel = (label: string) => (labelIndex.get(label) ?? []).map(x => x.file);

    // ---- check 4: a key lives in one bank file per kind ----
    for (const kind of NOTE_KINDS) {
        const where = new Map<string, number[]>();
        for (const f of stored[kind]) for (const k of Object.keys(f.data)) {
            if (!where.has(k)) where.set(k, []);
            where.get(k)!.push(f.bank);
        }
        for (const [key, banks] of where) {
            if (banks.length < 2) continue;
            if (options.bank !== undefined && !banks.includes(options.bank)) continue;
            result.duplicates.push({ kind, key, banks: banks.slice().sort((a, b) => a - b) });
            const places = banks.map(b => {
                const f = stored[kind].find(s => s.bank === b)!;
                return `${bankLabel(b)}.json:${f.keyLines.get(key) ?? '?'}`;
            });
            let hint = '';
            if (kind === 'blockNotes') {
                const start = dbStart.get(key);
                if (start !== undefined) hint = `; the block starts at ${start} (bank ${hex2(Math.floor(start / 65536))})`;
            } else if (kind === 'comments' && /^\d+$/.test(key)) {
                hint = `; the address is in bank ${hex2(Math.floor(parseInt(key, 10) / 65536))}`;
            }
            error(`${kind} '${key}' is in ${places.join(' and ')}${hint}`);
        }
    }

    // ---- check 1: comments ----
    for (const f of stored.comments) {
        if (!inFilter(f.bank)) continue;
        for (const key of Object.keys(f.data)) {
            const where = `comments ${bankLabel(f.bank)} '${key}'`;
            if (!/^\d+$/.test(key)) { error(`${where}: key is not a decimal address`); continue; }
            const addr = parseInt(key, 10);
            if (Math.floor(addr / 65536) !== f.bank) {
                error(`${where}: key is in ${bankLabel(f.bank)} but floor(${key} / 65536) is ${hex2(Math.floor(addr / 65536))}`);
            }
            const hits = tagIndex.get(key);
            if (!hits) {
                const r = ranges.find(x => addr >= x.start && addr < x.end);
                const hint = r
                    ? ` (address is inside block '${r.block}'${r.part ? ` part '${r.part}'` : ''}, offset +${addr - r.start}, type ${r.type || 'unknown'}${r.type && r.type !== 'Code' ? ': a data part prints no instruction line' : ''})`
                    : ' (no block of blocks.json covers the address)';
                error(`${where}: no instruction line carries tag {${key}}${hint}`);
                result.orphans.push({ kind: 'comments', key, bank: f.bank });
            } else if (hits.length > 1) {
                error(`${where}: tag appears on ${hits.length} lines (${hits.map(h => `${h.file.rel}:${h.line}`).join(', ')})`);
            }
        }
    }

    // ---- check 2: part notes ----
    for (const f of stored.partNotes) {
        if (!inFilter(f.bank)) continue;
        for (const key of Object.keys(f.data)) {
            const where = `partNotes ${bankLabel(f.bank)} '${key}'`;
            const at = labelIndex.get(key);
            if (!at) {
                // The old name of a rename rule: the file prints the new name, the engine finds the note under the old one.
                let alias = false;
                for (const block of guard.blockNames) {
                    const bg = guard.block(block)!;
                    if (!bg.isRenamedFrom(key)) continue;
                    const rule = bg.rules.find(r => r.renameFrom === key)!;
                    if ((filesByName.get(block) ?? []).some(file => file.labels.has(rule.renameTo!))) { alias = true; break; }
                }
                if (alias) continue;
                let hint = '';
                const hexTail = key.match(/_([0-9A-Fa-f]{6})$/);
                if (hexTail) {
                    const address = parseInt(hexTail[1], 16);
                    const name = nameAt.get(address);
                    if (name) {
                        const printed = labelIndex.get(name)?.[0];
                        hint = `; names maps ${address} to '${name}'${printed ? `, printed in ${printed.file.rel}:${printed.line}` : ''}`;
                    }
                }
                error(`${where}: no label '${key}' in any extracted file${hint}`);
                result.orphans.push({ kind: 'partNotes', key, bank: f.bank });
                continue;
            }
            const resolved = fileBank(at[0].file);
            if (resolved !== null && resolved !== f.bank) {
                warn(`${where}: stored in ${bankLabel(f.bank)} but ${at[0].file.rel} resolves to ${bankLabel(resolved)}`);
            }
        }
    }

    // ---- check 3: block notes ----
    for (const f of stored.blockNotes) {
        if (!inFilter(f.bank)) continue;
        for (const key of Object.keys(f.data)) {
            const where = `blockNotes ${bankLabel(f.bank)} '${key}'`;
            const files = filesByName.get(key);
            const start = dbStart.get(key);
            if (!files) {
                error(`${where}: no extracted file${start === undefined ? ' and no blocks.json entry' : ' (the block exists in blocks.json / files.json)'}`);
                result.orphans.push({ kind: 'blockNotes', key, bank: f.bank });
                continue;
            }
            if (start === undefined) { error(`${where}: ${files[0].rel} has no blocks.json / files.json entry`); continue; }
            const bank = Math.floor(start / 65536);
            if (bank !== f.bank) error(`${where}: stored in ${bankLabel(f.bank)} but the block starts at ${start} (bank ${hex2(bank)})`);
        }
    }

    // ---- check 5: bank rules per extracted file ----
    for (const file of asm) {
        const declared = file.lines.map(l => l.match(/^\?BANK\s+([0-9A-Fa-f]+)/)).find(m => m !== null);
        const db = dbBank.get(file.name);
        const resolved = detectBankDetailed(file.lines, file.name, namesBank, dbBank);
        if (options.bank !== undefined && resolved?.bank !== options.bank) continue;
        if (declared && db !== undefined && bankFromDirective(declared[1]) !== db) {
            error(`${file.rel}: ?BANK ${declared[1].toUpperCase()} differs from the bank of the block in blocks.json / files.json (${hex2(db)})`);
        }
        if (!declared && db === undefined) {
            warn(resolved
                ? `${file.rel}: no blocks.json / files.json entry and no ?BANK: bank ${hex2(resolved.bank)} guessed by strategy S${resolved.strategy}`
                : `${file.rel}: no blocks.json / files.json entry, no ?BANK, and no strategy finds a bank`);
        }
    }

    // ---- check 6: the transform guard on the stored notes ----
    for (const f of stored.blockNotes) {
        if (!inFilter(f.bank)) continue;
        for (const [key, text] of Object.entries(f.data)) {
            const bg = guard.block(key);
            if (!bg || !filesByName.has(key)) continue;
            for (const m of bg.checkLiteral(text, `blockNotes ${bankLabel(f.bank)} '${key}'`)) error(m);
        }
    }
    for (const f of stored.partNotes) {
        if (!inFilter(f.bank)) continue;
        for (const [key, text] of Object.entries(f.data)) {
            for (const file of filesOfLabel(key)) {
                const bg = guard.block(file.name);
                if (!bg) continue;
                const where = `partNotes ${bankLabel(f.bank)}`;
                const spanned = bg.checkPartNoteLabel(key, `${where} (${file.rel})`);
                if (spanned) error(spanned);
                for (const m of bg.checkLiteral(text, `${where} '${key}' (${file.rel})`)) error(m);
            }
        }
    }
    for (const f of stored.comments) {
        if (!inFilter(f.bank)) continue;
        for (const [key, text] of Object.entries(f.data)) {
            const hits = tagIndex.get(key);
            if (!hits || hits.length !== 1) continue;
            const bg = guard.block(hits[0].file.name);
            if (!bg) continue;
            for (const m of bg.checkLiteral(text, `comments ${bankLabel(f.bank)} '${key}' (${hits[0].file.rel}:${hits[0].line})`)) error(m);
        }
    }
    for (const file of asm) {
        const bg = guard.block(file.name);
        if (!bg || !bg.hasMultiLine) continue;
        const resolved = fileBank(file);
        if (options.bank !== undefined && resolved !== options.bank) continue;
        for (const site of bg.blockedSites(bg.measure(file.lines))) {
            const span = `lines ${site.first + 1}-${site.last + 1}`;
            const key = `${site.rule.key.slice(0, 50)}...`;
            if (site.taggedOnly) {
                warn(`${file.rel}: multi-line transform rule #${site.rule.index} of block '${bg.block}' (${key}) matches the plain text at ${span} but not the text with its tags: the tagged build does not apply it`);
            } else {
                for (const c of site.commented) {
                    error(`${file.rel}: comment {${c.address}}: line ${c.line + 1} is inside the multi-line transform rule #${site.rule.index} of block '${bg.block}' (${key}); the rule matches the plain text at ${span} but not the text as extracted, so a comment blocks it`);
                }
            }
        }
    }

    return result;
}

export function printCheck(result: CheckResult, bank?: number): void {
    if (result.fatal) { console.error(result.fatal); return; }
    if (result.warnings.length > 0) {
        console.log(`Warnings (${result.warnings.length}):`);
        for (const w of result.warnings) console.log(`  ! ${w}`);
        console.log('');
    }
    if (result.errors.length > 0) {
        console.log(`Errors (${result.errors.length}):`);
        for (const e of result.errors) console.log(`  X ${e}`);
        console.log('');
    }
    const byKind = (kind: NoteKind) => result.orphans.filter(o => o.kind === kind).length;
    console.log(`Checked${bank !== undefined ? ` bank ${hex2(bank)} of` : ''} ${result.stored.comments} comments, ${result.stored.partNotes} part notes and ${result.stored.blockNotes} block notes against ${result.files} extracted files.`);
    console.log(`Errors: ${result.errors.length}. Warnings: ${result.warnings.length}. Orphans: ${result.orphans.length} (comments ${byKind('comments')}, part notes ${byKind('partNotes')}, block notes ${byKind('blockNotes')}). Duplicate keys: ${result.duplicates.length}.`);
    console.log(result.errors.length === 0 ? 'OK' : 'FAILED');
}

/** `merge --check`: returns true when there is no error. */
export function mergeCheckCli(projectRoot: string, bankArg?: string): boolean {
    let bank: number | undefined;
    if (bankArg !== undefined) {
        if (!/^[0-9A-Fa-f]{1,2}$/.test(bankArg)) { console.error(`--bank expects a two-digit hex bank number, got '${bankArg}'`); return false; }
        bank = parseInt(bankArg, 16);
    }
    const result = runCheck(projectRoot, { bank });
    printCheck(result, bank);
    return result.fatal === null && result.errors.length === 0;
}

// ---------------------------------------------------------------------------------------------------------------

export interface PruneResult { ok: boolean; written: boolean; removed: Array<{ kind: NoteKind; key: string; bank: number }>; errors: string[] }

/** `merge --prune <orphans.json> [--dry-run]`. */
export function pruneNotes(projectRoot: string, specPath: string, options: { dryRun?: boolean } = {}): PruneResult {
    const result: PruneResult = { ok: false, written: false, removed: [], errors: [] };
    const fail = (msg: string) => { result.errors.push(msg); };

    if (!existsSync(specPath)) { fail(`orphans file not found: ${specPath}`); return finish(result); }
    let spec: Record<string, unknown>;
    try { spec = JSON.parse(readFileSync(specPath, 'utf-8')); } catch (e) { fail(`orphans file is not valid JSON: ${e}`); return finish(result); }
    for (const k of Object.keys(spec)) {
        if (k.startsWith('_') || k.startsWith('$')) { delete spec[k]; continue; }
        if (!(NOTE_KINDS as string[]).includes(k)) fail(`unknown key '${k}' (expected comments, partNotes, blockNotes)`);
        else if (!Array.isArray(spec[k]) || (spec[k] as unknown[]).some(v => typeof v !== 'string')) fail(`'${k}' must be an array of strings`);
    }
    if (result.errors.length > 0) return finish(result);

    const check = runCheck(projectRoot);
    if (check.fatal) { fail(check.fatal); return finish(result); }

    const stored: Record<NoteKind, StoredFile[]> = { blockNotes: [], partNotes: [], comments: [] };
    const loadErrors: string[] = [];
    for (const kind of NOTE_KINDS) stored[kind] = loadStored(projectRoot, kind, loadErrors);
    for (const e of loadErrors) fail(e);
    if (result.errors.length > 0) return finish(result);

    // Plan first: nothing is written when one key is refused.
    const toRemove: Array<{ kind: NoteKind; key: string; bank: number }> = [];
    for (const kind of NOTE_KINDS) {
        const wanted = (spec[kind] as string[] | undefined) ?? [];
        for (const raw of wanted) {
            const bankMatch = raw.match(/^bank([0-9A-Fa-f]{2}):(.+)$/);
            const key = bankMatch ? bankMatch[2] : raw;
            const copies = stored[kind].filter(f => key in f.data).map(f => f.bank);
            const what = `${kind} '${raw}'`;
            if (copies.length === 0) { fail(`${what}: no such key in notes/${kind}`); continue; }
            let bank: number;
            if (bankMatch) {
                bank = parseInt(bankMatch[1], 16);
                if (!copies.includes(bank)) { fail(`${what}: the key is not in ${bankLabel(bank)}.json (it is in ${copies.map(bankLabel).join(', ')})`); continue; }
            } else if (copies.length > 1) {
                fail(`${what}: the key is in ${copies.map(b => bankLabel(b) + '.json').join(' and ')}; write 'bankNN:${key}' to name the copy to remove`);
                continue;
            } else bank = copies[0];

            if (toRemove.some(r => r.kind === kind && r.key === key && r.bank === bank)) { fail(`${what}: listed twice`); continue; }
            const isOrphan = check.orphans.some(o => o.kind === kind && o.key === key && o.bank === bank);
            const remainingCopies = copies.filter(b => b !== bank && !toRemove.some(r => r.kind === kind && r.key === key && r.bank === b));
            if (!isOrphan && remainingCopies.length === 0) {
                fail(`${what}: refused: the check does not report it as an orphan (or as one copy of a duplicated key), so it is a live note`);
                continue;
            }
            toRemove.push({ kind, key, bank });
        }
    }
    if (result.errors.length > 0) return finish(result);

    for (const r of toRemove) console.log(`${options.dryRun ? '[DRY RUN] would remove' : 'remove'} ${r.kind} ${bankLabel(r.bank)} '${r.key}'`);
    result.removed = toRemove;
    if (options.dryRun) {
        console.log(`\n[DRY RUN] ${toRemove.length} key(s) would be removed; nothing written.`);
        result.ok = true;
        return finish(result);
    }

    // ---- write, then verify against the disk ----
    const touched = new Set<StoredFile>();
    for (const r of toRemove) {
        const file = stored[r.kind].find(f => f.bank === r.bank)!;
        delete file.data[r.key];
        touched.add(file);
    }
    for (const file of touched) saveJsonFile(file.path, file.data);
    result.written = true;

    for (const kind of NOTE_KINDS) {
        const after = loadStored(projectRoot, kind, result.errors);
        for (const r of toRemove.filter(x => x.kind === kind)) {
            const f = after.find(a => a.bank === r.bank);
            if (f && r.key in f.data) fail(`verify: ${kind} '${r.key}' is still in ${bankLabel(r.bank)}.json`);
        }
        // Nothing else changed: every other key is still there.
        for (const file of stored[kind]) {
            const now = after.find(a => a.bank === file.bank);
            if (!now) { if (Object.keys(file.data).length > 0) fail(`verify: notes/${kind}/${bankFileName(file.bank)} disappeared`); continue; }
            for (const k of Object.keys(file.data)) if (!(k in now.data) || now.data[k] !== file.data[k]) fail(`verify: ${kind} '${k}' in ${bankLabel(file.bank)}.json changed`);
        }
    }

    console.log(`\nRemoved ${toRemove.length} key(s):`);
    for (const file of touched) console.log(`  ${relative(projectRoot, file.path).split(sep).join('/')}`);

    const again = runCheck(projectRoot);
    console.log(`\nCheck after prune: ${again.errors.length} error(s), ${again.warnings.length} warning(s), ${again.orphans.length} orphan(s), ${again.duplicates.length} duplicate key(s).`);

    result.ok = result.errors.length === 0;
    return finish(result);
}

function finish(result: PruneResult): PruneResult {
    if (result.errors.length > 0) {
        console.log('\nErrors:');
        for (const e of result.errors) console.log(`  X ${e}`);
        console.log(result.written ? '\nThe notes files were written but the verification failed (see above).' : '\nNothing written (fix the errors and re-run).');
    } else if (result.ok) {
        console.log('\nOK');
    }
    return result;
}
