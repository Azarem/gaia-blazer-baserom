/**
 * Names Merge
 *
 * Applies a JSON list of label renames / additions to `us/names/bankNN.json` and carries the
 * rename through every file that mentions the old label, so a rename never needs an ad-hoc script.
 *
 * Spec (JSON array; `row` and `note` are free text for the audit trail and are ignored):
 *   [
 *     { "address": 49863,    "old": "loc_00C2C7", "new": "BossRewardFindScene", "row": "R-I051-3" },
 *     { "address": 49875,    "old": "loc_00C2D3", "new": "BossRewardCheckClaimed" },
 *     { "address": 244008,   "old": null,         "new": "SomeNewLabel" }
 *   ]
 *
 *   address  ROM file offset as a plain integer: the `; {n}` line-tracking number of the part's first instruction
 *            (`npm run extract:lt`), which is also the key in the names files. Bank = floor(address / 65536)
 *            picks `bankNN.json`.
 *   old      the label the extracted .asm prints at that address now (the current names value, or an auto label
 *            such as `loc_00C2C7`). null = brand-new name, nothing to rewrite. The source is the .asm files,
 *            never blocks.json / files.json.
 *   new      the new label (identifier, unused everywhere).
 *
 * What it does (all or nothing: any error aborts with nothing written):
 *   - names value at the address        -> replaced (rename)
 *   - no names entry, old is auto label -> entry added (add)
 *   - names already holds `new`         -> unchanged (re-applying a spec is safe)
 *   - a rename of `X` also rewrites references to `X_value` (the cut-out value of an `Extract` post-process record)
 *     to `<new>_value`; that label is derived by the extractor, so it follows its record
 *   - a missing bankNN.json is created and imported in src/names.ts
 *   - notes/{blockNotes,partNotes,comments}: part-note / block-note keys and note text are rewritten (keys stay in their bank)
 *   - us/*.json (blocks, files, transforms, overrides...), baserom/ and docs/: whole-word replacement
 *   - NOT touched: extracted/ (regenerate it), plans/, rebuilt/, jp/, other repositories (gaia-core docs,
 *     gaia-knowledge corpus copies)
 *
 * Workflow:
 *   1. `npm run extract` (or extract:lt) so the old labels can be validated against extracted/
 *   2. write the spec, e.g. plans/extracted-audit/renames/apply-I065_names.json
 *   3. `npm run names -- <spec.json> --dry-run`, read the report, then without --dry-run
 *   4. `npm run extract:lt` and `npm run rebuild` (the checksum must not change)
 */

import { readFileSync, writeFileSync, existsSync, readdirSync, mkdirSync } from 'fs';
import { join, resolve, relative, sep } from 'path';
import { loadJsonFile, serializeJson, bankFileName, TOP_LABEL, SUB_LABEL } from './notes-common.ts';

export interface NamesOptions {
    dryRun?: boolean;
}

export interface NamesResult {
    ok: boolean;
    errors: string[];
    warnings: string[];
    filesChanged: string[];
}

interface SpecEntry { address: number | string; old: string | null; new: string; row?: string; note?: string }
type OpKind = 'add' | 'rename' | 'unchanged';
interface Op { kind: OpKind; address: number; bank: number; old: string | null; name: string; index: number; shadowed?: string }

const IDENT = /^[A-Za-z_][A-Za-z0-9_]*$/;
const TEXT_EXT = /\.(asm|md|json|txt|mdc)$/i;
const SKIP_DIRS = new Set(['node_modules', '.git', 'dist', 'extracted', 'extracted-jp', 'plans', 'temp', 'artifacts', 'rebuilt', 'archived']);

function parseAddress(v: unknown): number | null {
    if (typeof v === 'number') return Number.isInteger(v) && v >= 0 ? v : null;
    if (typeof v !== 'string') return null;
    const t = v.trim();
    return /^\d+$/.test(t) ? parseInt(t, 10) : null;
}

function walk(dir: string, accept: (path: string) => boolean, out: string[], skipDir: (path: string, name: string) => boolean) {
    if (!existsSync(dir)) return;
    for (const e of readdirSync(dir, { withFileTypes: true })) {
        const p = join(dir, e.name);
        if (e.isDirectory()) {
            if (SKIP_DIRS.has(e.name) || skipDir(p, e.name)) continue;
            walk(p, accept, out, skipDir);
        } else if (accept(p)) out.push(p);
    }
}

const escapeRe = (s: string) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

/** `npm run names -- --check`: every key in the right bank file, files sorted, no duplicate address or name. */
export function checkNames(projectRoot: string): boolean {
    const namesDir = join(projectRoot, 'us', 'names');
    const seenAddr = new Map<number, string>(), seenName = new Map<string, string>();
    let problems = 0;
    const bad = (msg: string) => { console.error(`  X ${msg}`); problems++; };
    for (const f of readdirSync(namesDir).sort()) {
        const m = f.match(/^bank([0-9A-Fa-f]{2})\.json$/);
        if (!m) { bad(`${f}: not a bankNN.json file`); continue; }
        const bank = parseInt(m[1], 16);
        const data = loadJsonFile(join(namesDir, f));
        const keys = Object.keys(data);
        // Both pure-LF and pure-CRLF files are accepted (Windows checkouts with core.autocrlf produce CRLF); mixed endings are not.
        const onDisk = readFileSync(join(namesDir, f), 'utf-8');
        const canonical = serializeJson(data);
        if (onDisk !== canonical && onDisk !== canonical.replace(/\n/g, '\r\n')) bad(`${f}: not sorted / formatted like the tool writes it`);
        for (const k of keys) {
            const addr = parseInt(k, 10);
            if (!/^\d+$/.test(k)) { bad(`${f}: key '${k}' is not a decimal address`); continue; }
            if (Math.floor(addr / 65536) !== bank) bad(`${f}: ${k} ("${data[k]}") belongs in ${bankFileName(Math.floor(addr / 65536))}`);
            if (seenAddr.has(addr)) bad(`duplicate address ${k} in ${seenAddr.get(addr)} and ${f}`);
            if (seenName.has(data[k])) bad(`duplicate name "${data[k]}" at ${seenName.get(data[k])} and ${k}`);
            seenAddr.set(addr, f);
            seenName.set(data[k], k);
        }
    }
    const namesTs = readFileSync(join(projectRoot, 'src', 'names.ts'), 'utf-8');
    for (const f of readdirSync(namesDir)) {
        const m = f.match(/^(bank[0-9A-Fa-f]{2})\.json$/);
        if (m && !namesTs.includes(`'../us/names/${f}'`)) bad(`${f} is not imported in src/names.ts`);
    }
    console.log(problems === 0 ? `Names check: OK (${seenAddr.size} names)` : `Names check: ${problems} problem(s)`);
    return problems === 0;
}

export function applyNames(projectRoot: string, specPath: string, options: NamesOptions = {}): NamesResult {
    const result: NamesResult = { ok: false, errors: [], warnings: [], filesChanged: [] };
    const fail = (msg: string) => { result.errors.push(msg); };

    // ---------------------------------------------------------------- spec
    const specAbs = resolve(specPath);
    if (!existsSync(specAbs)) { fail(`spec file not found: ${specPath}`); return report(result, options); }
    let raw: unknown;
    try { raw = JSON.parse(readFileSync(specAbs, 'utf-8')); } catch (e) { fail(`spec is not valid JSON: ${e}`); return report(result, options); }
    if (!Array.isArray(raw)) { fail('spec must be a JSON array of { address, old, new } objects'); return report(result, options); }
    const entries = raw as SpecEntry[];

    // ---------------------------------------------------------------- current state
    const namesDir = join(projectRoot, 'us', 'names');
    const nameBanks = new Map<number, Record<string, string>>();      // bank -> data (mutable copy)
    const nameAt = new Map<number, string>();                         // address -> name
    const nameOwner = new Map<string, number>();                      // name -> address
    for (const f of existsSync(namesDir) ? readdirSync(namesDir) : []) {
        const m = f.match(/^bank([0-9A-Fa-f]{2})\.json$/);
        if (!m) continue;
        const data = loadJsonFile(join(namesDir, f));
        nameBanks.set(parseInt(m[1], 16), data);
        for (const [k, v] of Object.entries(data)) { nameAt.set(parseInt(k, 10), v); nameOwner.set(v, parseInt(k, 10)); }
    }

    // labels defined in extracted/ (and the block names it includes with `?INCLUDE 'name'`)
    const extractedDir = join(projectRoot, 'extracted');
    const asmFiles: string[] = [];
    walk(extractedDir, p => p.endsWith('.asm'), asmFiles, () => false);
    if (asmFiles.length === 0) fail('extracted/ is empty: run `npm run extract` first (old labels are validated against it)');
    const extractedLabels = new Set<string>();
    for (const f of asmFiles) {
        for (const line of readFileSync(f, 'utf-8').split(/\r?\n/)) {
            const inc = line.match(/^\?INCLUDE\s+'([^']+)'/);
            if (inc) { extractedLabels.add(inc[1]); continue; }
            if (/^[?!;]/.test(line)) continue;
            const m = line.match(TOP_LABEL) || line.match(SUB_LABEL);
            if (m) extractedLabels.add(m[1]);
        }
    }

    // ---------------------------------------------------------------- classify entries
    const ops: Op[] = [];
    const seenAddr = new Set<number>(), seenOld = new Set<string>(), seenNew = new Set<string>();
    entries.forEach((e, i) => {
        const where = `entry #${i + 1}${e && typeof e === 'object' && (e as SpecEntry).row ? ` (${(e as SpecEntry).row})` : ''}`;
        if (e === null || typeof e !== 'object' || Array.isArray(e)) { fail(`${where}: must be an object`); return; }
        for (const k of Object.keys(e)) if (!['address', 'old', 'new', 'row', 'note'].includes(k)) { fail(`${where}: unknown key '${k}'`); return; }
        const address = parseAddress(e.address);
        if (address === null) { fail(`${where}: 'address' must be a non-negative integer (the \`; {n}\` line-tracking number)`); return; }
        if (address >= 0x1000000) { fail(`${where}: address ${address} is outside the 24-bit ROM space`); return; }
        if (typeof e.new !== 'string' || !IDENT.test(e.new)) { fail(`${where}: 'new' must be an identifier (letters, digits, _)`); return; }
        if (e.old !== null && e.old !== undefined && (typeof e.old !== 'string' || !IDENT.test(e.old))) { fail(`${where}: 'old' must be an identifier or null`); return; }
        const old = e.old ?? null;
        if (old === e.new) { fail(`${where}: old and new are both '${old}'`); return; }
        const bank = Math.floor(address / 65536);
        if (seenAddr.has(address)) { fail(`${where}: address ${address} appears twice`); return; }
        seenAddr.add(address);
        if (seenNew.has(e.new)) { fail(`${where}: new name '${e.new}' appears twice`); return; }
        seenNew.add(e.new);
        if (old !== null) {
            if (seenOld.has(old)) { fail(`${where}: old name '${old}' appears twice`); return; }
            seenOld.add(old);
        }

        const cur = nameAt.get(address);
        if (cur === e.new) { ops.push({ kind: 'unchanged', address, bank, old, name: e.new, index: i }); return; }
        if (cur !== undefined) {
            if (old !== cur) {
                // A part label of blocks.json that sits on the same address wins over the names entry in the
                // extraction: the asm prints `old`, while references may use `cur`. Rename both to the new name.
                if (old !== null && extractedLabels.has(old)) {
                    ops.push({ kind: 'rename', address, bank, old, name: e.new, index: i, shadowed: cur });
                    return;
                }
                fail(`${where}: address ${address} is named '${cur}' in us/names, not '${old}'`); return;
            }
            ops.push({ kind: 'rename', address, bank, old, name: e.new, index: i });
            return;
        }
        if (old === null) { ops.push({ kind: 'add', address, bank, old, name: e.new, index: i }); return; }
        if (!extractedLabels.has(old)) { fail(`${where}: old label '${old}' is not defined in extracted/ (stale extraction, or a typo; address ${address})`); return; }
        const suffix = old.match(/_([0-9A-Fa-f]{6})$/);
        if (suffix && parseInt(suffix[1], 16) !== address) {
            result.warnings.push(`${where}: '${old}' encodes address ${parseInt(suffix[1], 16)} but the spec says ${address}`);
        }
        ops.push({ kind: 'add', address, bank, old, name: e.new, index: i });
    });

    // ---------------------------------------------------------------- collisions
    const freed = new Set<string>(ops.map(o => o.old).filter((v): v is string => v !== null));
    for (const o of ops) if (o.kind === 'rename') freed.add(o.old!);
    for (const o of ops) {
        if (o.kind === 'unchanged') continue;
        const holder = nameOwner.get(o.name);
        if (holder !== undefined && !freed.has(o.name)) fail(`'${o.name}' is already the name at address ${holder}`);
        else if (extractedLabels.has(o.name) && !freed.has(o.name)) fail(`'${o.name}' is already a label in extracted/`);
    }

    const refOps = ops.filter(o => o.kind !== 'unchanged' && o.old !== null);
    const byOld = new Map(refOps.map(o => [o.old!, o.name]));
    for (const o of refOps) if (o.shadowed && !byOld.has(o.shadowed)) byOld.set(o.shadowed, o.name);

    // Derived labels: the `Extract` post-process (scene_actors) cuts the value out of each record and names it
    // `<record label>_value`. That label has no address of its own, so it follows its record: carry it along.
    for (const o of refOps) {
        const derivedOld = `${o.old}_value`, derivedNew = `${o.name}_value`;
        if (!extractedLabels.has(derivedOld) || byOld.has(derivedOld)) continue;
        if (extractedLabels.has(derivedNew)) { fail(`derived label '${derivedNew}' (from '${derivedOld}') is already in use`); continue; }
        byOld.set(derivedOld, derivedNew);
    }

    // ---------------------------------------------------------------- plan: names files
    const writes = new Map<string, string>();       // absolute path -> content
    const newBanks: number[] = [];
    const changedNames = new Set<number>();
    for (const o of ops) {
        if (o.kind === 'add' || o.kind === 'rename') {
            if (!nameBanks.has(o.bank)) { nameBanks.set(o.bank, {}); newBanks.push(o.bank); }
            nameBanks.get(o.bank)![String(o.address)] = o.name;
            changedNames.add(o.bank);
        }
    }
    for (const bank of changedNames) {
        // keep the line ending the bank file already has (CRLF stays CRLF); a new file gets LF
        const bankPath = join(namesDir, bankFileName(bank));
        const bankText = serializeJson(nameBanks.get(bank)!);
        writes.set(bankPath, existsSync(bankPath) && readFileSync(bankPath, 'utf-8').includes('\r\n') ? bankText.replace(/\n/g, '\r\n') : bankText);
    }
    if (newBanks.length > 0) {
        const namesTs = join(projectRoot, 'src', 'names.ts');
        let t = readFileSync(namesTs, 'utf-8');
        const eol = t.includes('\r\n') ? '\r\n' : '\n';
        for (const bank of newBanks.sort((a, b) => a - b)) {
            const id = `bank${bank.toString(16).toUpperCase().padStart(2, '0')}`;
            const imports = [...t.matchAll(/^import bank\w+ from .*$/gm)];
            const last = imports[imports.length - 1];
            if (!last) { fail('src/names.ts: no `import bankNN` line found to extend'); break; }
            const at = last.index! + last[0].length;
            t = t.slice(0, at) + `${eol}import ${id} from '../us/names/${id}.json' with { type: 'json' };` + t.slice(at);
            const arr = t.match(/(const bankNames[^=]*=\s*\[[\s\S]*?)(\r?\n\];)/);
            if (!arr) { fail('src/names.ts: bankNames array not found'); break; }
            t = t.replace(arr[1] + arr[2], `${arr[1]}${eol}    ${id},${arr[2]}`);
        }
        writes.set(namesTs, t);
    }

    // ---------------------------------------------------------------- plan: references
    const perFile: Array<[string, number]> = [];
    if (byOld.size > 0 && result.errors.length === 0) {
        const alt = [...byOld.keys()].sort((a, b) => b.length - a.length).map(escapeRe).join('|');
        const reText = new RegExp(`(?<![A-Za-z0-9_])(${alt})(?![A-Za-z0-9_])`, 'g');
        // raw JSON text: a label can directly follow a literal \n escape
        const reJsonRaw = new RegExp(`(?:(?<![A-Za-z0-9_])|(?<=\\\\n))(${alt})(?![A-Za-z0-9_])`, 'g');
        const rewrite = (s: string, re: RegExp): [string, number] => {
            let n = 0;
            re.lastIndex = 0;
            const out = s.replace(re, (_m, g1: string) => { n++; return byOld.get(g1)!; });
            return [out, n];
        };

        // notes/: parsed, so keys move with the label and escapes are not an issue
        for (const kind of ['blockNotes', 'partNotes', 'comments']) {
            const dir = join(projectRoot, 'notes', kind);
            if (!existsSync(dir)) continue;
            const files = readdirSync(dir).filter(f => /^bank[0-9A-Fa-f]{2}\.json$/.test(f));
            const allKeys = new Set<string>();
            const loaded = files.map(f => ({ f, data: loadJsonFile(join(dir, f)) }));
            for (const { data } of loaded) for (const k of Object.keys(data)) allKeys.add(k);
            for (const { f, data } of loaded) {
                let n = 0;
                const out: Record<string, string> = {};
                for (const [k, v] of Object.entries(data)) {
                    const nk = kind === 'comments' ? k : (byOld.get(k) ?? k);
                    if (nk !== k) {
                        n++;
                        if (allKeys.has(nk)) { fail(`notes/${kind}/${f}: '${nk}' already has a note; merge the notes of '${k}' and '${nk}' by hand first (npm run merge)`); }
                    }
                    const [nv, c] = rewrite(v, reText);
                    n += c;
                    out[nk] = nv;
                }
                if (n > 0) {
                    const p = join(dir, f);
                    writes.set(p, serializeJson(out));
                    perFile.push([relative(projectRoot, p).split(sep).join('/'), n]);
                }
            }
        }

        // plain text files
        const files: string[] = [];
        const accept = (p: string) => TEXT_EXT.test(p);
        const skipNames = (p: string) => resolve(p) === resolve(namesDir);
        for (const d of ['baserom', 'us', 'docs']) walk(join(projectRoot, d), accept, files, skipNames);
        for (const f of files) {
            const text = readFileSync(f, 'utf-8');
            const [out, n] = rewrite(text, f.toLowerCase().endsWith('.json') ? reJsonRaw : reText);
            if (n > 0) {
                writes.set(f, out);
                perFile.push([relative(projectRoot, f).split(sep).join('/'), n]);
            }
        }
    }

    // ---------------------------------------------------------------- report / write
    const counts = { add: 0, rename: 0, unchanged: 0 };
    for (const o of ops) counts[o.kind]++;
    console.log(`Names: ${entries.length} entries: +${counts.add} added, ~${counts.rename} renamed, =${counts.unchanged} unchanged`);
    for (const o of ops) {
        if (o.kind === 'unchanged') continue;
        console.log(`  ${o.kind.padEnd(6)} ${bankFileName(o.bank)} ${String(o.address).padStart(8)}  ${o.old ?? '(new)'} -> ${o.name}`);
    }
    for (const [f, n] of perFile.sort((a, b) => a[0].localeCompare(b[0]))) console.log(`  ${String(n).padStart(5)} ref  ${f}`);
    if (newBanks.length > 0) console.log(`  new bank file(s): ${newBanks.map(bankFileName).join(', ')} (imported in src/names.ts)`);

    if (result.errors.length > 0) return report(result, options);

    for (const p of writes.keys()) result.filesChanged.push(relative(projectRoot, p).split(sep).join('/'));
    if (!options.dryRun) {
        for (const [p, content] of writes) {
            mkdirSync(join(p, '..'), { recursive: true });
            writeFileSync(p, content, 'utf-8');
        }
    }
    result.ok = true;
    return report(result, options);
}

function report(result: NamesResult, options: NamesOptions): NamesResult {
    for (const w of result.warnings) console.warn(`  ! ${w}`);
    if (result.errors.length > 0) {
        console.error('\nNothing written (fix the errors and re-run).\n\nErrors:');
        for (const e of result.errors) console.error(`  X ${e}`);
        return result;
    }
    if (options.dryRun) console.log(`\n[DRY RUN] ${result.filesChanged.length} file(s) would change; nothing written.`);
    else if (result.filesChanged.length > 0) console.log(`\nWrote ${result.filesChanged.length} file(s).\n\nNext: npm run extract:lt, check the output, then npm run rebuild (checksum must not change).\nSentences that call the OLD name wrong or misleading now read oddly: fix them with npm run merge.`);
    else console.log('\nNothing to change.');
    return result;
}
