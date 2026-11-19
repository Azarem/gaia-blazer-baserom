/**
 * Extraction hygiene: a stale-file sweep instead of deleting the output folder, and a completeness marker.
 *
 * `npm run extract` used to start with `rm -rf extracted/*`. When any process held a directory open
 * ("Device or resource busy") that step deleted part of the tree and then skipped the extraction.
 * The extractor overwrites every file it writes, so nothing needs to be deleted first:
 *
 *   1. `.extract-state.json` is written with status `running` before the first file.
 *   2. The extractor runs and overwrites its output.
 *   3. Every file older than the start of the run was not written by this run (a block that no longer
 *      exists, a renamed file) and is removed. Empty directories stay.
 *   4. The marker is rewritten with status `complete`.
 *
 * `rebuild` refuses a tree whose marker says `running` (an interrupted or still running extraction).
 * A missing marker (a tree from before the marker existed) is only a warning.
 *
 * The marker starts with a dot: the engine's directory listing gives such a name no extension and
 * `applyFolder` skips entries without one, so the marker never reaches the ROM build.
 */
import { existsSync, mkdirSync, readFileSync, readdirSync, rmSync, statSync, writeFileSync } from 'fs';
import { basename, join, relative, resolve } from 'path';

export const EXTRACT_STATE_FILE = '.extract-state.json';

export type ExtractMode = 'tagged' | 'plain';

export interface ExtractState {
    status: 'running' | 'complete';
    mode: ExtractMode;
    startedAt: string;
    /** Number of files in the tree when the run finished (the marker itself is not counted). */
    files?: number;
    finishedAt?: string;
}

export interface SweepResult {
    /** Files removed because this run did not write them. */
    removed: string[];
    /** Files left in the tree (written by this run), the marker excluded. */
    kept: number;
}

function stateFilePath(dir: string): string {
    return join(dir, EXTRACT_STATE_FILE);
}

export function writeExtractState(dir: string, state: ExtractState): void {
    mkdirSync(dir, { recursive: true });
    writeFileSync(stateFilePath(dir), JSON.stringify(state, null, 2), 'utf-8');
}

/** The marker of a tree: `null` when there is none, an error when it cannot be read. */
export function readExtractState(dir: string): ExtractState | null {
    const path = stateFilePath(dir);
    if (!existsSync(path)) return null;
    try {
        return JSON.parse(readFileSync(path, 'utf-8')) as ExtractState;
    } catch (error) {
        throw new Error(`${basename(resolve(dir))}/${EXTRACT_STATE_FILE} cannot be read (${(error as Error).message}); extract the tree again`);
    }
}

/**
 * Delete every file under `dir` whose modification time is before `startMs`, except the marker.
 * Directories are never deleted. Refuses to sweep when the run wrote nothing (a failed or empty
 * extraction must not empty the tree).
 */
export function sweepStaleFiles(dir: string, startMs: number): SweepResult {
    const stale: string[] = [];
    let kept = 0;

    const walk = (current: string): void => {
        for (const entry of readdirSync(current, { withFileTypes: true })) {
            const full = join(current, entry.name);
            if (entry.isDirectory()) { walk(full); continue; }
            if (!entry.isFile()) continue;
            if (current === dir && entry.name === EXTRACT_STATE_FILE) continue;
            if (statSync(full).mtimeMs < startMs) stale.push(full);
            else kept++;
        }
    };
    walk(dir);

    if (kept === 0) {
        throw new Error(`refusing to sweep ${dir}: the extraction wrote no file in this run (${stale.length} older files left untouched)`);
    }
    for (const path of stale) rmSync(path, { force: true, maxRetries: 10, retryDelay: 200 });

    return { removed: stale.map(p => relative(dir, p).split('\\').join('/')), kept };
}

/**
 * Run an extraction into `dir` under the marker protocol. `run` writes the files. The marker stays
 * `running` when `run` throws, so a following rebuild refuses the partial tree.
 */
export async function extractWithSweep(dir: string, mode: ExtractMode, run: () => Promise<void>): Promise<SweepResult> {
    const start = Date.now();
    const startedAt = new Date(start).toISOString();
    writeExtractState(dir, { status: 'running', mode, startedAt });

    await run();

    const result = sweepStaleFiles(dir, start);
    const shown = result.removed.slice(0, 20);
    for (const rel of shown) console.log(`  stale: ${rel}`);
    if (result.removed.length > shown.length) console.log(`  ... and ${result.removed.length - shown.length} more`);
    console.log(`stale files removed: ${result.removed.length}`);

    writeExtractState(dir, { status: 'complete', mode, startedAt, files: result.kept, finishedAt: new Date().toISOString() });
    return result;
}

/**
 * Refuse an incomplete tree. `extractCommand` names the npm script that recreates the tree.
 * A missing marker only prints a warning.
 */
export function assertExtractComplete(dir: string, extractCommand: string): void {
    const state = readExtractState(dir);
    const label = `${basename(resolve(dir))}/`;
    if (state === null) {
        console.warn(`Warning: ${label} has no ${EXTRACT_STATE_FILE} (extracted before the marker existed); completeness is not checked.`);
        return;
    }
    if (state.status !== 'complete') {
        throw new Error(`${label} is incomplete (${EXTRACT_STATE_FILE} says '${state.status}'); run ${extractCommand}`);
    }
}
