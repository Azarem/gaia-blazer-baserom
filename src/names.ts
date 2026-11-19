/**
 * US ROM names, split by ROM bank.
 *
 * Each `us/names/bankNN.json` maps decimal ROM addresses to label names,
 * where NN is the two-digit hex bank (bank = floor(address / 65536)).
 *
 * Unlike `notes/`, names are required to extract and rebuild the ROM, so they
 * must be bundled into the published package. That rules out filesystem
 * discovery: every bank file is imported explicitly here and merged into the
 * flat address -> name dictionary the engine expects.
 *
 * Do not edit by hand: `npm run names -- <spec.json>` adds / renames names and,
 * for a bank that has no file yet, creates `us/names/bankNN.json` and adds the
 * import and array entry below.
 */
import bank00 from '../us/names/bank00.json' with { type: 'json' };
import bank02 from '../us/names/bank02.json' with { type: 'json' };

const bankNames: Record<string, string>[] = [
    bank00,
    bank02,
];

export const names: Record<string, string> = Object.assign({}, ...bankNames);
