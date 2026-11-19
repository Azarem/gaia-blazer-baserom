/**
 * Swaps the first and second byte of every 2-byte pair in a tileset file.
 *
 * Usage:
 *   node scripts/swap-tileset-bytes.ts <input.set> [output.set]
 *
 * If no output path is given, the file is overwritten in place.
 *
 * Example:
 *   node scripts/swap-tileset-bytes.ts extracted/system/tileset_0ED5DB.set
 */

import fs from 'fs';
import path from 'path';

const inputPath = process.argv[2];
const outputPath = process.argv[3] ?? inputPath;

if (!inputPath) {
    console.error('Usage: node scripts/swap-tileset-bytes.ts <input.set> [output.set]');
    process.exit(1);
}

const resolved = path.resolve(inputPath);
if (!fs.existsSync(resolved)) {
    console.error(`File not found: ${resolved}`);
    process.exit(1);
}

const data = fs.readFileSync(resolved);

if (data.length % 2 !== 0) {
    console.error(`File size (${data.length} bytes) is not a multiple of 2 — cannot swap pairs.`);
    process.exit(1);
}

const swapped = Buffer.alloc(data.length);
for (let i = 0; i < data.length; i += 2) {
    swapped[i] = data[i + 1];
    swapped[i + 1] = data[i];
}

const resolvedOutput = path.resolve(outputPath);
fs.writeFileSync(resolvedOutput, swapped);

console.log(`Swapped ${data.length / 2} byte pairs in ${path.basename(resolved)}`);
if (resolvedOutput !== resolved) {
    console.log(`Output written to: ${resolvedOutput}`);
} else {
    console.log('File overwritten in place.');
}
