import { fileURLToPath } from 'url';
import { dirname, join, resolve } from 'path';
import { existsSync, readdirSync, readFileSync } from 'fs';
import { createHash } from 'crypto';
import { DbBlock, DbFile, DbGroup, DbStringType, DbStruct, CopDef, DbFileType, saveFileAsText } from '@gaialabs/core';
import { DbRootUtils } from '@gaialabs/core';
import type { DbAddressingMode, DbConfig, DbGameRomModule } from '@gaialabs/core';
import { snes } from '@gaialabs/core';
import { merge } from './merge.ts';
import { mergeCheckCli, pruneNotes } from './merge-check.ts';
import { applyNames, checkNames } from './names-merge.ts';
import { assertExtractComplete, extractWithSweep } from './extract-state.ts';

const __pkgRoot = join(dirname(fileURLToPath(import.meta.url)), '..');

import config from '../us/config.json' with { type: 'json' };
import blocks from '../us/blocks.json' with { type: 'json' };
import copdef from '../us/copdef.json' with { type: 'json' };
import files from '../us/files.json' with { type: 'json' };
import groups from '../us/groups.json' with { type: 'json' };
import labels from '../us/labels.json' with { type: 'json' };
import mnemonics from '../us/mnemonics.json' with { type: 'json' };
import overrides from '../us/overrides.json' with { type: 'json' };
import rewrites from '../us/rewrites.json' with { type: 'json' };
import strings from '../us/stringTypes.json' with { type: 'json' };
import structs from '../us/structs.json' with { type: 'json' };
import transforms from '../us/transforms.json' with { type: 'json' };
import fileTypes from '../us/fileTypes.json' with { type: 'json' };
import types from '../us/types.json' with { type: 'json' };
import { names } from './names.ts';

import configJP from '../jp/config.json' with { type: 'json' };
import blocksJP from '../jp/blocks.json' with { type: 'json' };
import copdefJP from '../jp/copdef.json' with { type: 'json' };
import filesJP from '../jp/files.json' with { type: 'json' };
import groupsJP from '../jp/groups.json' with { type: 'json' };
import labelsJP from '../jp/labels.json' with { type: 'json' };
import mnemonicsJP from '../jp/mnemonics.json' with { type: 'json' };
import overridesJP from '../jp/overrides.json' with { type: 'json' };
import rewritesJP from '../jp/rewrites.json' with { type: 'json' };
import stringsJP from '../jp/stringTypes.json' with { type: 'json' };
import structsJP from '../jp/structs.json' with { type: 'json' };
import transformsJP from '../jp/transforms.json' with { type: 'json' };
import fileTypesJP from '../jp/fileTypes.json' with { type: 'json' };

function loadNotesDir(subdir: string): Record<string, string> {
    const dir = join(__pkgRoot, 'notes', subdir);
    if (!existsSync(dir)) return {};

    const merged: Record<string, string> = {};
    for (const file of readdirSync(dir)) {
        if (!file.endsWith('.json')) continue;
        const data = JSON.parse(readFileSync(join(dir, file), 'utf-8'));
        Object.assign(merged, data);
    }
    return merged;
}

const localNotes = {
    comments: loadNotesDir('comments'),
    blockNotes: loadNotesDir('blockNotes'),
    partNotes: loadNotesDir('partNotes')
};

export const db : DbGameRomModule = {
    mnemonics: { ...snes.vectors, ...mnemonics },
    overrides: overrides as unknown as Record<string, Record<string, number>>,
    rewrites,
    blocks: blocks as unknown as Record<string, Record<string, Partial<DbBlock>>>,
    copdef: copdef as unknown as Record<string, Partial<CopDef>>,
    files: files as unknown as Record<string, Record<string, Record<string, Partial<DbFile>>>>,
    groups: groups as unknown as Record<string, Partial<DbGroup>>,
    labels,
    strings: strings as unknown as Record<string, Partial<DbStringType>>,
    structs: structs as unknown as Record<string, DbStruct>,
    transforms,
    config: config as unknown as DbConfig,
    fileTypes: fileTypes as unknown as Record<string, Partial<DbFileType>>,
    addrModes: snes.addressingModes as unknown as Record<string, Partial<DbAddressingMode>>,
    headers: snes.headers,
    names,
    types,
    comments: localNotes.comments,
    blockNotes: localNotes.blockNotes,
    partNotes: localNotes.partNotes
};

export const jp : DbGameRomModule = {
    mnemonics: { ...snes.vectors, ...mnemonicsJP },
    overrides: overridesJP as unknown as Record<string, Record<string, number>>,
    rewrites: rewritesJP,
    blocks: blocksJP as unknown as Record<string, Record<string, Partial<DbBlock>>>,
    copdef: copdefJP as unknown as Record<string, Partial<CopDef>>,
    files: filesJP as unknown as Record<string, Record<string, Record<string, Partial<DbFile>>>>,
    groups: groupsJP as unknown as Record<string, Partial<DbGroup>>,
    labels: labelsJP,
    strings: stringsJP as unknown as Record<string, Partial<DbStringType>>,
    structs: structsJP as unknown as Record<string, DbStruct>,
    transforms: transformsJP,
    config: configJP as unknown as DbConfig,
    fileTypes: fileTypesJP as unknown as Record<string, Partial<DbFileType>>,
    addrModes: snes.addressingModes as unknown as Record<string, Partial<DbAddressingMode>>,
    headers: snes.headers
};

export async function extract(romPath: string, outPath: string, options?: string[]) {
    if (!romPath) romPath = process.env.ROM_PATH ?? './rebuilt/Soul Blazer (USA).sfc';
    if (!outPath) outPath = './extracted';

    const dbRoot = DbRootUtils.fromGameModule(db);

    const tagged = options?.includes('linetracking') ?? false;
    if (tagged) dbRoot.config.emitLineTracking = true;

    // No `rm -rf` of the output folder: every file is overwritten, files this run did not write are swept afterwards
    // and `.extract-state.json` tells `rebuild` whether the tree is complete (src/extract-state.ts).
    await extractWithSweep(outPath, tagged ? 'tagged' : 'plain', () => DbRootUtils.extractAllContent(dbRoot, romPath, outPath));
}

export async function extractJP(romPath: string, outPath: string) {
    if (!romPath) romPath = process.env.ROM_PATH_JP!;
    if (!outPath) outPath = './extracted-jp';

    const dbRoot = DbRootUtils.fromGameModule(jp);

    await extractWithSweep(outPath, 'plain', () => DbRootUtils.extractAllContent(dbRoot, romPath, outPath));
}

export async function rebuild(inPath: string, outPath: string, baseRomPath: string) {
    if (!inPath) inPath = './extracted';
    if (!outPath) outPath = './rebuilt';
    if (!baseRomPath) baseRomPath = join(__pkgRoot, 'baserom');

    assertExtractComplete(inPath, 'npm run extract');

    const dbRoot = DbRootUtils.fromGameModule(db);

    const romPath = `${outPath}/GaiaLabs-Blazer.smc`;
    const outData = await DbRootUtils.rebuildAllContent(dbRoot, [inPath, baseRomPath], romPath);

    console.log(`ROM: ${resolve(romPath)}`);
    console.log(`SHA-1: ${createHash('sha1').update(outData.romData).digest('hex')}`);
    console.log(`Size: ${outData.romData.length} bytes, checksum: ${outData.header.checksum}`);

    const layoutJson = JSON.stringify(outData.files
        .sort((a, b) => a.location - b.location)
        .map(file => (
            { name: file.name, type: file.type.name, compressed: file.compressed, location: file.location, size: file.size }
        ))
    , null, 2);
    await saveFileAsText(join(outPath, 'layout.json'), layoutJson);
}

// CLI handler - only execute when run directly (not when imported as a module)
const isMainModule = resolve(process.argv[1] || '') === fileURLToPath(import.meta.url);

if (isMainModule) {
    const command = process.argv[2];
    const args = process.argv.slice(3);

    const flags: string[] = [];
    //--key=value options keep the case of the value (paths); they are not flags.
    const values: Record<string, string> = {};
    for (let index = 0; index < args.length; index++) {
        const arg = args[index];
        const valueMatch = /^--([A-Za-z][A-Za-z0-9-]*)=(.*)$/.exec(arg);
        if (valueMatch) {
            values[valueMatch[1].toLowerCase()] = valueMatch[2];
            args.splice(index, 1);
            index--;
            continue;
        }
        if (arg.startsWith('--')) {
            flags.push(arg.slice(2).toLowerCase());
            args.splice(index, 1);
            index--;
        }
    }

    (async () => {
        try {
            switch (command) {
                case 'extract':
                    console.log('Starting ROM extraction...');
                    console.log('ROM Path:', args[0]);
                    console.log('Output Path:', args[1] || './extracted');
                    await extract(args[0], args[1], flags);
                    console.log('ROM extraction completed successfully!');
                    break;
                case 'extract-jp':
                    console.log('Starting ROM extraction...');
                    console.log('ROM Path:', args[0]);
                    console.log('Output Path:', args[1] || './extracted-jp');
                    await extractJP(args[0], args[1]);
                    console.log('ROM extraction completed successfully!');
                    break;
                case 'rebuild':
                    console.log('Starting ROM rebuild...');
                    await rebuild(args[0], args[1], args[2]);
                    console.log('ROM rebuild completed successfully!');
                    break;
                case 'merge': {
                    if (flags.includes('check')) {
                        // `--bank NN` (the number is left in args) or `--bank=NN`
                        const bankArg = values['bank'] ?? (flags.includes('bank') ? args[0] : undefined);
                        if (!mergeCheckCli(__pkgRoot, bankArg)) process.exit(1);
                        break;
                    }
                    if (flags.includes('prune')) {
                        if (args.length === 0) {
                            console.error('Usage: merge --prune <orphans.json> [--dry-run]');
                            process.exit(1);
                        }
                        const pruneResult = pruneNotes(__pkgRoot, args[0], {
                            dryRun: flags.includes('dry-run') || flags.includes('dryrun'),
                        });
                        if (!pruneResult.ok) process.exit(1);
                        break;
                    }
                    if (args.length === 0) {
                        console.error('Usage: merge <spec.json> [--dry-run] | merge --check [--bank NN] | merge --prune <orphans.json> [--dry-run]');
                        process.exit(1);
                    }
                    const mergeResult = merge(__pkgRoot, args[0], {
                        dryRun: flags.includes('dry-run') || flags.includes('dryrun'),
                    });
                    if (!mergeResult.ok) process.exit(1);
                    break;
                }
                case 'names': {
                    if (flags.includes('check')) {
                        if (!checkNames(__pkgRoot)) process.exit(1);
                        break;
                    }
                    if (args.length === 0) {
                        console.error('Usage: names <spec.json> [--dry-run] | names --check');
                        process.exit(1);
                    }
                    const namesResult = applyNames(__pkgRoot, args[0], {
                        dryRun: flags.includes('dry-run') || flags.includes('dryrun'),
                    });
                    if (!namesResult.ok) process.exit(1);
                    break;
                }
                default:
                    console.error('Unknown command:', command);
                    console.log('Available commands: extract, extract-jp, rebuild, merge, names');
                    process.exit(1);
            }
        } catch (error) {
            console.error('Error:', error);
            process.exit(1);
        }
    })();
}
