/**
 * Verification of a regroup (`npm run blocks`): extract and rebuild the project twice in a scratch folder,
 * once with the blocks as they are and once with the blocks as the spec would leave them, and compare.
 * Nothing in the project is touched: the scratch folder lives under the system temp directory and is removed.
 *
 * Checks (all comparisons are between the two scratch trees, never against the source ROM):
 *
 *   text      every label (top-level and sub-label) has the same text before and after. The comparison ignores the
 *             part-note lines, the `block.` qualifier of cross-file references and the padding before trailing `;`
 *             comments (the extractor aligns them by printed width), all of which legitimately change
 *             when a label changes file; the `; {address}` tags are part of the text, so a label that moved to
 *             another address would be caught as well. Label set equal: no label lost, none created.
 *   rebuild   the "after" tree assembles (an undefined reference, a duplicate label, a relative branch that no longer
 *             reaches, a bank that overflows all stop the rebuild); the ROM size and SHA-1 are reported for both builds.
 *   includes  every `?INCLUDE` names an existing block or asset, and every cross-file reference has its `?INCLUDE`
 *             (a gap that the "before" tree already had is only a warning), and `block.label` qualifiers name the
 *             block that holds the label.
 *   banks     the 2-byte references (`&`, `$&`, JSR/JMP, branches) that were guaranteed to stay in one bank before
 *             (same file, or two blocks pinned to the same bank) still are, and a block that is the target of a
 *             cross-file 2-byte reference keeps its bank pin. The `?BANK` of a non-movable block is the bank of its
 *             first part, so this also catches a part moved into a block of another bank.
 */

import { mkdtempSync, rmSync, existsSync } from 'fs';
import { tmpdir } from 'os';
import { join } from 'path';
import { createHash } from 'crypto';
import { DbRootUtils } from '@gaialabs/core';
import type { DbGameRomModule } from '@gaialabs/core';
import { canonicalUnitText, listAssetNames, loadAsmTree } from './asm-index.ts';
import type { AsmTree } from './asm-index.ts';
import config from '../us/config.json' with { type: 'json' };

export type BlocksFile = Record<string, Record<string, any>>;

export interface Snapshot {
    blocks: BlocksFile;
    transforms: Record<string, unknown>;
    blockNotes: Record<string, string>;
}

export interface VerifyReport {
    errors: string[];
    warnings: string[];
    info: string[];
    /** Labels of the "before" tree (used by the caller for collision checks and text rewrites). */
    beforeLabels: Set<string>;
}

const bankShift = config.memoryMode === 'Lo' ? 15 : 16;
const SHOW = 8;

/** Placement of every block: `bank` is the bank a non-movable block is pinned to, null for a movable block. */
export function placementOf(blocks: BlocksFile): Map<string, { movable: boolean; bank: number | null }> {
    const out = new Map<string, { movable: boolean; bank: number | null }>();
    for (const group of Object.values(blocks)) {
        for (const [name, b] of Object.entries(group)) {
            const parts = Object.values<any>(b.parts ?? {});
            const first = parts.reduce((m, p) => (m === null || (p.order ?? p.start) < (m.order ?? m.start) ? p : m), null as any);
            out.set(name, { movable: b.movable === true, bank: b.movable === true || !first ? null : first.start >> bankShift });
        }
    }
    return out;
}

async function quiet<T>(fn: () => Promise<T>): Promise<T> {
    const saved = { log: console.log, warn: console.warn, info: console.info };
    console.log = console.warn = console.info = () => {};
    try { return await fn(); } finally { console.log = saved.log; console.warn = saved.warn; console.info = saved.info; }
}

function moduleOf(db: DbGameRomModule, s: Snapshot): DbGameRomModule {
    return {
        ...db,
        blocks: structuredClone(s.blocks) as DbGameRomModule['blocks'],
        transforms: structuredClone(s.transforms) as DbGameRomModule['transforms'],
        blockNotes: { ...s.blockNotes },
        config: { ...db.config, emitLineTracking: true },
    };
}

interface Build { tree: AsmTree; assets: Set<string>; rom: { sha1: string; size: number } | null; failure: string | null }

async function build(projectRoot: string, db: DbGameRomModule, s: Snapshot, dir: string): Promise<Build> {
    const romPath = process.env.ROM_PATH ?? join(projectRoot, 'rebuilt', 'Soul Blazer (USA).sfc');
    const extracted = join(dir, 'extracted');
    await quiet(async () => DbRootUtils.extractAllContent(DbRootUtils.fromGameModule(moduleOf(db, s)), romPath, extracted));
    const tree = loadAsmTree(extracted);
    const assets = listAssetNames(extracted);
    let rom: Build['rom'] = null;
    let failure: string | null = null;
    try {
        const baserom = join(projectRoot, 'baserom');
        const inputs = existsSync(baserom) ? [extracted, baserom] : [extracted];
        const out = await quiet(async () => DbRootUtils.rebuildAllContent(DbRootUtils.fromGameModule(moduleOf(db, s)), inputs, join(dir, 'rebuilt.smc')));
        rom = { sha1: createHash('sha1').update(out.romData).digest('hex'), size: out.romData.length };
    } catch (error) {
        failure = error instanceof Error ? error.message : String(error);
    }
    return { tree, assets, rom, failure };
}

function sample(list: string[], n = SHOW): string {
    return list.slice(0, n).join('; ') + (list.length > n ? `; ... (+${list.length - n})` : '');
}

function closureGaps(tree: AsmTree): Set<string> {
    const gaps = new Set<string>();
    for (const r of tree.refs) {
        if (r.fileName !== r.toFile && !tree.files.get(r.fileName)!.includes.includes(r.toFile)) gaps.add(`${r.fileName} -> ${r.toFile}`);
    }
    return gaps;
}

export async function verifyRegroup(projectRoot: string, db: DbGameRomModule, before: Snapshot, after: Snapshot): Promise<VerifyReport> {
    const report: VerifyReport = { errors: [], warnings: [], info: [], beforeLabels: new Set() };
    const scratch = mkdtempSync(join(tmpdir(), 'gaia-blocks-'));
    try {
        let b: Build, a: Build;
        try {
            b = await build(projectRoot, db, before, join(scratch, 'before'));
        } catch (error) {
            report.errors.push(`the current blocks do not extract (${error instanceof Error ? error.message : error}); fix the project before regrouping`);
            return report;
        }
        if (b.failure) { report.errors.push(`the current blocks do not rebuild (${b.failure}); fix the project before regrouping`); return report; }
        report.beforeLabels = new Set(b.tree.labels.keys());
        try {
            a = await build(projectRoot, db, after, join(scratch, 'after'));
        } catch (error) {
            report.errors.push(`extraction with the new blocks failed: ${error instanceof Error ? error.message : error}`);
            return report;
        }

        // ---------------------------------------------------------------- rebuild
        if (a.failure) report.errors.push(`rebuild with the new blocks failed: ${a.failure.split(/\r?\n/)[0]}`);
        else if (b.rom && a.rom) {
            const same = a.rom.sha1 === b.rom.sha1;
            report.info.push(`rebuild: OK, ${a.rom.size} bytes, SHA-1 ${a.rom.sha1.slice(0, 12)}... (${same ? 'identical to the current build' : `current build ${b.rom.sha1.slice(0, 12)}..., ${b.rom.size} bytes`})`);
            if (!same) report.warnings.push('the rebuilt ROM bytes change (the packer places blocks by size, so a regroup may move code inside a bank; verify at runtime). A rename or a scene/order change alone must not do this.');
        }

        // ---------------------------------------------------------------- label sets and text
        for (const [label, files] of a.tree.duplicates) report.errors.push(`label '${label}' is defined in ${files.join(' and ')} after the change`);
        const lost = [...b.tree.labels.keys()].filter(l => !a.tree.labels.has(l));
        const gained = [...a.tree.labels.keys()].filter(l => !b.tree.labels.has(l));
        if (lost.length) report.errors.push(`${lost.length} label(s) disappear: ${sample(lost)}`);
        if (gained.length) report.errors.push(`${gained.length} label(s) appear: ${sample(gained)}`);

        const names = new Set<string>([...b.tree.files.keys(), ...a.tree.files.keys()]);
        const none = new Map<string, string>();
        const textOf = (tree: AsmTree) => {
            const m = new Map<string, string>();
            for (const f of tree.files.values()) for (const u of f.units) m.set(u.label, canonicalUnitText(u, names, none));
            return m;
        };
        const tb = textOf(b.tree), ta = textOf(a.tree);
        const different: string[] = [];
        let firstDiff: string | null = null;
        let compared = 0;
        for (const [label, text] of tb) {
            const other = ta.get(label);
            if (other === undefined) continue;
            compared++;
            if (other !== text) {
                different.push(label);
                if (firstDiff === null) {
                    const x = text.split('\n'), y = other.split('\n');
                    let i = 0;
                    while (i < x.length && i < y.length && x[i] === y[i]) i++;
                    firstDiff = `first difference in ${label}, line ${i + 1}: '${(x[i] ?? '(end)').trim()}' became '${(y[i] ?? '(end)').trim()}'`;
                }
            }
        }
        if (different.length) report.errors.push(`the text of ${different.length} label(s) changes: ${sample(different)}; ${firstDiff}`);
        report.info.push(`text: ${compared} top-level labels compared, ${compared - different.length} identical; ${b.tree.labels.size} labels before, ${a.tree.labels.size} after`);

        // ---------------------------------------------------------------- includes and qualifiers
        const dangling = new Set<string>();
        for (const f of a.tree.files.values()) for (const inc of f.includes) if (!a.tree.files.has(inc) && !a.assets.has(inc)) dangling.add(`${f.name} -> ${inc}`);
        if (dangling.size) report.errors.push(`${dangling.size} ?INCLUDE target(s) do not exist: ${sample([...dangling])}`);
        const badQualifier = a.tree.refs.filter(r => r.qualifier !== null && r.qualifier !== r.toFile).map(r => `${r.fileName}: ${r.qualifier}.${r.to}`);
        if (badQualifier.length) report.errors.push(`${badQualifier.length} qualified reference(s) name the wrong block: ${sample(badQualifier)}`);
        const gapsBefore = closureGaps(b.tree), gapsAfter = closureGaps(a.tree);
        if (gapsAfter.size > gapsBefore.size) report.errors.push(`?INCLUDE closure: ${gapsAfter.size} file pair(s) reference each other without an ?INCLUDE (${gapsBefore.size} before): ${sample([...gapsAfter])}`);
        else if (gapsAfter.size > 0) report.warnings.push(`?INCLUDE closure: ${gapsAfter.size} file pair(s) reference each other without an ?INCLUDE (already so before): ${sample([...gapsAfter])}`);
        const incBefore = new Set([...b.tree.files.values()].flatMap(f => f.includes.map(i => `${f.name}>${i}`)));
        const incAfter = new Set([...a.tree.files.values()].flatMap(f => f.includes.map(i => `${f.name}>${i}`)));
        const crossBefore = b.tree.refs.filter(r => r.fileName !== r.toFile).length, crossAfter = a.tree.refs.filter(r => r.fileName !== r.toFile).length;
        report.info.push(`files: ${b.tree.files.size} -> ${a.tree.files.size}; ?INCLUDE lines ${incBefore.size} -> ${incAfter.size}; cross-file references ${crossBefore} -> ${crossAfter} (of ${b.tree.refs.length} -> ${a.tree.refs.length})`);

        // ---------------------------------------------------------------- bank pins for 2-byte references
        const pinBefore = placementOf(before.blocks), pinAfter = placementOf(after.blocks);
        const fixed = (m: Map<string, { movable: boolean; bank: number | null }>, file: string) => m.get(file)?.bank ?? null;
        const broken = new Map<string, string>();
        const pinLost = new Map<string, string>();
        let checked = 0;
        for (const r of b.tree.refs) {
            if (r.form !== 'short' && r.form !== 'rel') continue;
            const sf = a.tree.labels.get(r.fromLabel)?.file, tf = a.tree.labels.get(r.to)?.file;
            if (sf === undefined || tf === undefined) continue;
            const s0 = fixed(pinBefore, r.fileName), t0 = fixed(pinBefore, r.toFile);
            const sameBefore = r.fileName === r.toFile || (s0 !== null && s0 === t0);
            if (sameBefore) {
                checked++;
                const sameAfter = sf === tf || (fixed(pinAfter, sf) !== null && fixed(pinAfter, sf) === fixed(pinAfter, tf));
                if (!sameAfter) broken.set(`${r.fromLabel} -> ${r.to}`, `${r.fromLabel} (in ${sf}) -> ${r.to} (in ${tf})`);
            } else if (r.fileName !== r.toFile && t0 !== null) {
                checked++;
                if (fixed(pinAfter, tf) !== t0) pinLost.set(r.to, `${r.to} (in ${tf}, pinned to bank ${t0} before)`);
            }
        }
        if (broken.size) report.errors.push(`${broken.size} 2-byte reference(s) were guaranteed to stay in one bank (same file, or both blocks pinned to the same bank) and no longer are: ${sample([...broken.values()], 4)}`);
        if (pinLost.size) report.errors.push(`${pinLost.size} label(s) that other files reach with a 2-byte reference lose their bank pin: ${sample([...pinLost.values()], 4)}`);
        report.info.push(`banks: ${checked} 2-byte references with a bank guarantee checked, ${broken.size + pinLost.size} broken`);
    } finally {
        try { rmSync(scratch, { recursive: true, force: true, maxRetries: 5, retryDelay: 200 }); } catch { /* temp dir cleanup is best effort */ }
    }
    return report;
}
