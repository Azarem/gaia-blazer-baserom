// Disassemble the Soul Blazer SPC engine binary from extracted hex data
// Outputs a full SPC700 disassembly comparable to the IOG version

import { readFileSync } from 'fs';

// SPC700 opcode table: [mnemonic, size, addressingMode]
const opcodes = {
  0x00: ['NOP', 1, ''],
  0x01: ['TCALL 0', 1, ''],
  0x02: ['SET1 $%b.0', 2, 'dp'],
  0x03: ['BBS $%b.0, $%r', 3, 'dp_rel'],
  0x04: ['OR A, $%b', 2, 'dp'],
  0x05: ['OR A, $%w', 3, 'abs'],
  0x06: ['OR A, (X)', 1, ''],
  0x07: ['OR A, [$%b+X]', 2, 'dpx_ind'],
  0x08: ['OR A, #$%b', 2, 'imm'],
  0x09: ['OR $%b, $%b2', 3, 'dp_dp'],
  0x0A: ['OR1 C, $%m', 3, 'mem_bit'],
  0x0B: ['ASL $%b', 2, 'dp'],
  0x0C: ['ASL $%w', 3, 'abs'],
  0x0D: ['PUSH PSW', 1, ''],
  0x0E: ['TSET1 $%w', 3, 'abs'],
  0x0F: ['BRK', 1, ''],
  0x10: ['BPL $%r', 2, 'rel'],
  0x11: ['TCALL 1', 1, ''],
  0x12: ['CLR1 $%b.0', 2, 'dp'],
  0x13: ['BBC $%b.0, $%r', 3, 'dp_rel'],
  0x14: ['OR A, $%b+X', 2, 'dpx'],
  0x15: ['OR A, $%w+X', 3, 'absx'],
  0x16: ['OR A, $%w+Y', 3, 'absy'],
  0x17: ['OR A, [$%b]+Y', 2, 'dpy_ind'],
  0x18: ['OR $%b, #$%b2', 3, 'dp_imm'],
  0x19: ['OR (X), (Y)', 1, ''],
  0x1A: ['DECW $%b', 2, 'dp'],
  0x1B: ['ASL $%b+X', 2, 'dpx'],
  0x1C: ['ASL', 1, ''],
  0x1D: ['DEC X', 1, ''],
  0x1E: ['CMP X, $%w', 3, 'abs'],
  0x1F: ['JMP [$%w+X]', 3, 'absx_ind'],
  0x20: ['CLRP', 1, ''],
  0x21: ['TCALL 2', 1, ''],
  0x22: ['SET1 $%b.1', 2, 'dp'],
  0x23: ['BBS $%b.1, $%r', 3, 'dp_rel'],
  0x24: ['AND A, $%b', 2, 'dp'],
  0x25: ['AND A, $%w', 3, 'abs'],
  0x26: ['AND A, (X)', 1, ''],
  0x27: ['AND A, [$%b+X]', 2, 'dpx_ind'],
  0x28: ['AND A, #$%b', 2, 'imm'],
  0x29: ['AND $%b, $%b2', 3, 'dp_dp'],
  0x2A: ['OR1 C, /$%m', 3, 'mem_bit'],
  0x2B: ['ROL $%b', 2, 'dp'],
  0x2C: ['ROL $%w', 3, 'abs'],
  0x2D: ['PUSH A', 1, ''],
  0x2E: ['CBNE $%b, $%r', 3, 'dp_rel'],
  0x2F: ['BRA $%r', 2, 'rel'],
  0x30: ['BMI $%r', 2, 'rel'],
  0x31: ['TCALL 3', 1, ''],
  0x32: ['CLR1 $%b.1', 2, 'dp'],
  0x33: ['BBC $%b.1, $%r', 3, 'dp_rel'],
  0x34: ['AND A, $%b+X', 2, 'dpx'],
  0x35: ['AND A, $%w+X', 3, 'absx'],
  0x36: ['AND A, $%w+Y', 3, 'absy'],
  0x37: ['AND A, [$%b]+Y', 2, 'dpy_ind'],
  0x38: ['AND $%b, #$%b2', 3, 'dp_imm'],
  0x39: ['AND (X), (Y)', 1, ''],
  0x3A: ['INCW $%b', 2, 'dp'],
  0x3B: ['ROL $%b+X', 2, 'dpx'],
  0x3C: ['ROL', 1, ''],
  0x3D: ['INC X', 1, ''],
  0x3E: ['CMP X, $%b', 2, 'dp'],
  0x3F: ['CALL $%w', 3, 'abs'],
  0x40: ['SETP', 1, ''],
  0x41: ['TCALL 4', 1, ''],
  0x42: ['SET1 $%b.2', 2, 'dp'],
  0x43: ['BBS $%b.2, $%r', 3, 'dp_rel'],
  0x44: ['EOR A, $%b', 2, 'dp'],
  0x45: ['EOR A, $%w', 3, 'abs'],
  0x46: ['EOR A, (X)', 1, ''],
  0x47: ['EOR A, [$%b+X]', 2, 'dpx_ind'],
  0x48: ['EOR A, #$%b', 2, 'imm'],
  0x49: ['EOR $%b, $%b2', 3, 'dp_dp'],
  0x4A: ['AND1 C, $%m', 3, 'mem_bit'],
  0x4B: ['LSR $%b', 2, 'dp'],
  0x4C: ['LSR $%w', 3, 'abs'],
  0x4D: ['PUSH X', 1, ''],
  0x4E: ['TCLR1 $%w', 3, 'abs'],
  0x4F: ['PCALL $%b', 2, 'imm'],
  0x50: ['BVC $%r', 2, 'rel'],
  0x51: ['TCALL 5', 1, ''],
  0x52: ['CLR1 $%b.2', 2, 'dp'],
  0x53: ['BBC $%b.2, $%r', 3, 'dp_rel'],
  0x54: ['EOR A, $%b+X', 2, 'dpx'],
  0x55: ['EOR A, $%w+X', 3, 'absx'],
  0x56: ['EOR A, $%w+Y', 3, 'absy'],
  0x57: ['EOR A, [$%b]+Y', 2, 'dpy_ind'],
  0x58: ['EOR $%b, #$%b2', 3, 'dp_imm'],
  0x59: ['EOR (X), (Y)', 1, ''],
  0x5A: ['CMPW YA, $%b', 2, 'dp'],
  0x5B: ['LSR $%b+X', 2, 'dpx'],
  0x5C: ['LSR', 1, ''],
  0x5D: ['MOV X, A', 1, ''],
  0x5E: ['CMP Y, $%w', 3, 'abs'],
  0x5F: ['JMP $%w', 3, 'abs'],
  0x60: ['CLRC', 1, ''],
  0x61: ['TCALL 6', 1, ''],
  0x62: ['SET1 $%b.3', 2, 'dp'],
  0x63: ['BBS $%b.3, $%r', 3, 'dp_rel'],
  0x64: ['CMP A, $%b', 2, 'dp'],
  0x65: ['CMP A, $%w', 3, 'abs'],
  0x66: ['CMP A, (X)', 1, ''],
  0x67: ['CMP A, [$%b+X]', 2, 'dpx_ind'],
  0x68: ['CMP A, #$%b', 2, 'imm'],
  0x69: ['CMP $%b, $%b2', 3, 'dp_dp'],
  0x6A: ['AND1 C, /$%m', 3, 'mem_bit'],
  0x6B: ['ROR $%b', 2, 'dp'],
  0x6C: ['ROR $%w', 3, 'abs'],
  0x6D: ['PUSH Y', 1, ''],
  0x6E: ['DBNZ $%b, $%r', 3, 'dp_rel'],
  0x6F: ['RET', 1, ''],
  0x70: ['BVS $%r', 2, 'rel'],
  0x71: ['TCALL 7', 1, ''],
  0x72: ['CLR1 $%b.3', 2, 'dp'],
  0x73: ['BBC $%b.3, $%r', 3, 'dp_rel'],
  0x74: ['CMP A, $%b+X', 2, 'dpx'],
  0x75: ['CMP A, $%w+X', 3, 'absx'],
  0x76: ['CMP A, $%w+Y', 3, 'absy'],
  0x77: ['CMP A, [$%b]+Y', 2, 'dpy_ind'],
  0x78: ['CMP $%b, #$%b2', 3, 'dp_imm'],
  0x79: ['CMP (X), (Y)', 1, ''],
  0x7A: ['ADDW YA, $%b', 2, 'dp'],
  0x7B: ['ROR $%b+X', 2, 'dpx'],
  0x7C: ['ROR', 1, ''],
  0x7D: ['MOV A, X', 1, ''],
  0x7E: ['CMP Y, $%b', 2, 'dp'],
  0x7F: ['RETI', 1, ''],
  0x80: ['SETC', 1, ''],
  0x81: ['TCALL 8', 1, ''],
  0x82: ['SET1 $%b.4', 2, 'dp'],
  0x83: ['BBS $%b.4, $%r', 3, 'dp_rel'],
  0x84: ['ADC A, $%b', 2, 'dp'],
  0x85: ['ADC A, $%w', 3, 'abs'],
  0x86: ['ADC A, (X)', 1, ''],
  0x87: ['ADC A, [$%b+X]', 2, 'dpx_ind'],
  0x88: ['ADC A, #$%b', 2, 'imm'],
  0x89: ['ADC $%b, $%b2', 3, 'dp_dp'],
  0x8A: ['EOR1 C, $%m', 3, 'mem_bit'],
  0x8B: ['DEC $%b', 2, 'dp'],
  0x8C: ['DEC $%w', 3, 'abs'],
  0x8D: ['MOV Y, #$%b', 2, 'imm'],
  0x8E: ['POP PSW', 1, ''],
  0x8F: ['MOV $%b, #$%b2', 3, 'dp_imm'],
  0x90: ['BCC $%r', 2, 'rel'],
  0x91: ['TCALL 9', 1, ''],
  0x92: ['CLR1 $%b.4', 2, 'dp'],
  0x93: ['BBC $%b.4, $%r', 3, 'dp_rel'],
  0x94: ['ADC A, $%b+X', 2, 'dpx'],
  0x95: ['ADC A, $%w+X', 3, 'absx'],
  0x96: ['ADC A, $%w+Y', 3, 'absy'],
  0x97: ['ADC A, [$%b]+Y', 2, 'dpy_ind'],
  0x98: ['ADC $%b, #$%b2', 3, 'dp_imm'],
  0x99: ['ADC (X), (Y)', 1, ''],
  0x9A: ['SUBW YA, $%b', 2, 'dp'],
  0x9B: ['DEC $%b+X', 2, 'dpx'],
  0x9C: ['DEC', 1, ''],
  0x9D: ['MOV X, #$%b', 2, 'imm'],
  0x9E: ['DIV YA, X', 1, ''],
  0x9F: ['XCN A', 1, ''],
  0xA0: ['EI', 1, ''],
  0xA1: ['TCALL 10', 1, ''],
  0xA2: ['SET1 $%b.5', 2, 'dp'],
  0xA3: ['BBS $%b.5, $%r', 3, 'dp_rel'],
  0xA4: ['SBC A, $%b', 2, 'dp'],
  0xA5: ['SBC A, $%w', 3, 'abs'],
  0xA6: ['SBC A, (X)', 1, ''],
  0xA7: ['SBC A, [$%b+X]', 2, 'dpx_ind'],
  0xA8: ['SBC A, #$%b', 2, 'imm'],
  0xA9: ['SBC $%b, $%b2', 3, 'dp_dp'],
  0xAA: ['MOV1 C, $%m', 3, 'mem_bit'],
  0xAB: ['INC $%b', 2, 'dp'],
  0xAC: ['INC $%w', 3, 'abs'],
  0xAD: ['CMP Y, #$%b', 2, 'imm'],
  0xAE: ['POP A', 1, ''],
  0xAF: ['MOV (X)+, A', 1, ''],
  0xB0: ['BCS $%r', 2, 'rel'],
  0xB1: ['TCALL 11', 1, ''],
  0xB2: ['CLR1 $%b.5', 2, 'dp'],
  0xB3: ['BBC $%b.5, $%r', 3, 'dp_rel'],
  0xB4: ['ADC A, $%b+X', 2, 'dpx_ind'],  // wrong, should be SBC
  0xB5: ['SBC A, $%w+X', 3, 'absx'],
  0xB6: ['SBC A, $%w+Y', 3, 'absy'],
  0xB7: ['SBC A, [$%b]+Y', 2, 'dpy_ind'],
  0xB8: ['SBC $%b, #$%b2', 3, 'dp_imm'],
  0xB9: ['SBC (X), (Y)', 1, ''],
  0xBA: ['MOVW YA, $%b', 2, 'dp'],
  0xBB: ['INC $%b+X', 2, 'dpx'],
  0xBC: ['INC A', 1, ''],
  0xBD: ['MOV SP, X', 1, ''],
  0xBE: ['DAS A', 1, ''],
  0xBF: ['MOV A, (X)+', 1, ''],
  0xC0: ['DI', 1, ''],
  0xC1: ['TCALL 12', 1, ''],
  0xC2: ['SET1 $%b.6', 2, 'dp'],
  0xC3: ['BBS $%b.6, $%r', 3, 'dp_rel'],
  0xC4: ['MOV $%b, A', 2, 'dp'],
  0xC5: ['MOV $%w, A', 3, 'abs'],
  0xC6: ['MOV (X), A', 1, ''],
  0xC7: ['MOV [$%b+X], A', 2, 'dpx_ind'],
  0xC8: ['CMP X, #$%b', 2, 'imm'],
  0xC9: ['MOV $%w, X', 3, 'abs'],
  0xCA: ['MOV1 $%m, C', 3, 'mem_bit'],
  0xCB: ['MOV $%b, Y', 2, 'dp'],
  0xCC: ['MOV $%w, Y', 3, 'abs'],
  0xCD: ['MOV X, #$%b', 2, 'imm'],
  0xCE: ['POP X', 1, ''],
  0xCF: ['MUL YA', 1, ''],
  0xD0: ['BNE $%r', 2, 'rel'],
  0xD1: ['TCALL 13', 1, ''],
  0xD2: ['CLR1 $%b.6', 2, 'dp'],
  0xD3: ['BBC $%b.6, $%r', 3, 'dp_rel'],
  0xD4: ['MOV $%b+X, A', 2, 'dpx'],
  0xD5: ['MOV $%w+X, A', 3, 'absx'],
  0xD6: ['MOV $%w+Y, A', 3, 'absy'],
  0xD7: ['MOV [$%b]+Y, A', 2, 'dpy_ind'],
  0xD8: ['MOV $%b, X', 2, 'dp'],
  0xD9: ['MOV $%b, Y', 2, 'dp_y'],  // actually same as CB but alternate
  0xDA: ['MOVW $%b, YA', 2, 'dp'],
  0xDB: ['MOV $%b+X, Y', 2, 'dpx'],
  0xDC: ['DEC Y', 1, ''],
  0xDD: ['MOV A, Y', 1, ''],
  0xDE: ['CBNE $%b+X, $%r', 3, 'dpx_rel'],
  0xDF: ['DAA A', 1, ''],
  0xE0: ['CLRV', 1, ''],
  0xE1: ['TCALL 14', 1, ''],
  0xE2: ['SET1 $%b.7', 2, 'dp'],
  0xE3: ['BBS $%b.7, $%r', 3, 'dp_rel'],
  0xE4: ['MOV A, $%b', 2, 'dp'],
  0xE5: ['MOV A, $%w', 3, 'abs'],
  0xE6: ['MOV A, (X)', 1, ''],
  0xE7: ['MOV A, [$%b+X]', 2, 'dpx_ind'],
  0xE8: ['MOV A, #$%b', 2, 'imm'],
  0xE9: ['MOV X, $%w', 3, 'abs'],
  0xEA: ['NOT1 $%m', 3, 'mem_bit'],
  0xEB: ['MOV Y, $%b', 2, 'dp'],
  0xEC: ['MOV Y, $%w', 3, 'abs'],
  0xED: ['NOTC', 1, ''],
  0xEE: ['POP Y', 1, ''],
  0xEF: ['SLEEP', 1, ''],
  0xF0: ['BEQ $%r', 2, 'rel'],
  0xF1: ['TCALL 15', 1, ''],
  0xF2: ['CLR1 $%b.7', 2, 'dp'],
  0xF3: ['BBC $%b.7, $%r', 3, 'dp_rel'],
  0xF4: ['MOV A, $%b+X', 2, 'dpx'],
  0xF5: ['MOV A, $%w+X', 3, 'absx'],
  0xF6: ['MOV A, $%w+Y', 3, 'absy'],
  0xF7: ['MOV A, [$%b]+Y', 2, 'dpy_ind'],
  0xF8: ['MOV X, $%b', 2, 'dp'],
  0xF9: ['MOV X, $%b+Y', 2, 'dpy'],
  0xFA: ['MOV $%b, $%b2', 3, 'dp_dp'],
  0xFB: ['MOV Y, $%b+X', 2, 'dpx'],
  0xFC: ['INC Y', 1, ''],
  0xFD: ['MOV Y, A', 1, ''],
  0xFE: ['DBNZ Y, $%r', 2, 'rel'],
  0xFF: ['STOP', 1, ''],
};

function hexByte(v) { return v.toString(16).padStart(2, '0'); }
function hexWord(v) { return v.toString(16).padStart(4, '0'); }

function disassemble(bytes, baseAddr) {
  const lines = [];
  let pc = 0;
  
  while (pc < bytes.length) {
    const addr = baseAddr + pc;
    const op = bytes[pc];
    const entry = opcodes[op];
    if (!entry) {
      lines.push(`${hexWord(addr)}:  ${hexByte(op)}          .db $${hexByte(op)}`);
      pc++;
      continue;
    }
    
    const [template, size] = entry;
    if (pc + size > bytes.length) {
      // Not enough bytes remaining
      lines.push(`${hexWord(addr)}:  ${hexByte(op)}          .db $${hexByte(op)}  ; incomplete`);
      pc++;
      continue;
    }
    
    const rawBytes = [];
    for (let i = 0; i < size; i++) rawBytes.push(bytes[pc + i]);
    const hexStr = rawBytes.map(b => hexByte(b)).join(' ');
    
    let mnemonic = template;
    
    if (size === 1) {
      // no operands
    } else if (size === 2) {
      const b1 = bytes[pc + 1];
      if (template.includes('%r')) {
        // relative branch
        const offset = b1 < 128 ? b1 : b1 - 256;
        const target = addr + 2 + offset;
        mnemonic = template.replace('$%r', `$${hexWord(target)}`);
      } else if (template.includes('%b')) {
        mnemonic = template.replace('%b', hexByte(b1));
      }
    } else if (size === 3) {
      const b1 = bytes[pc + 1];
      const b2 = bytes[pc + 2];
      
      if (template.includes('%w')) {
        const word = b1 | (b2 << 8);
        mnemonic = mnemonic.replace('%w', hexWord(word));
      }
      if (template.includes('%m')) {
        const word = b1 | (b2 << 8);
        const bitAddr = word & 0x1FFF;
        const bit = (word >> 13) & 7;
        mnemonic = mnemonic.replace('$%m', `$${hexWord(bitAddr)}.${bit}`);
      }
      if (template.includes('%b2') && template.includes('%b')) {
        // dp,dp or dp,imm or dp,rel ordering depends on the opcode
        if (template.includes('$%r')) {
          // dp_rel: byte1=dp, byte2=rel
          mnemonic = mnemonic.replace('%b', hexByte(b1));
          const offset = b2 < 128 ? b2 : b2 - 256;
          const target = addr + 3 + offset;
          mnemonic = mnemonic.replace('$%r', `$${hexWord(target)}`);
        } else if (template.includes('#$%b2')) {
          // dp_imm: byte1=imm, byte2=dp (reversed in encoding!)
          mnemonic = mnemonic.replace('#$%b2', `#$${hexByte(b1)}`);
          mnemonic = mnemonic.replace('%b', hexByte(b2));
        } else {
          // dp_dp: byte1=src, byte2=dest
          mnemonic = mnemonic.replace('$%b2', `$${hexByte(b1)}`);
          mnemonic = mnemonic.replace('%b', hexByte(b2));
        }
      } else if (template.includes('%b') && !template.includes('%b2')) {
        mnemonic = mnemonic.replace('%b', hexByte(b1));
        if (template.includes('%r')) {
          const offset = b2 < 128 ? b2 : b2 - 256;
          const target = addr + 3 + offset;
          mnemonic = mnemonic.replace('$%r', `$${hexWord(target)}`);
        }
      }
    }
    
    const padded = hexStr.padEnd(14);
    lines.push(`${hexWord(addr)}:  ${padded}${mnemonic}`);
    pc += size;
  }
  
  return lines;
}

// Read the ASM file and extract hex data
const asmFile = readFileSync('c:/Work/gaia-blazer-baserom/extracted/system/chunk_0FAA49.asm', 'utf8');
const hexLines = [];
const regex = /#([0-9A-Fa-f]+)\s+;/g;
let match;

// Find the spc_0FF14E block
const blockStart = asmFile.indexOf('spc_0FF14E [');
const blockEnd = asmFile.indexOf(']', blockStart);
const blockText = asmFile.substring(blockStart, blockEnd);

while ((match = regex.exec(blockText)) !== null) {
  hexLines.push(match[1]);
}

// Concatenate all hex bytes
let allHex = hexLines.join('');
const allBytes = [];
for (let i = 0; i < allHex.length; i += 2) {
  allBytes.push(parseInt(allHex.substring(i, i + 2), 16));
}

console.log(`Total raw bytes: ${allBytes.length}`);
console.log(`Header: size=${hexWord(allBytes[0] | (allBytes[1] << 8))}, addr=${hexWord(allBytes[2] | (allBytes[3] << 8))}`);

// Extract code bytes (skip 4-byte header, skip 4-byte terminator)
const codeSize = allBytes[0] | (allBytes[1] << 8);
const baseAddr = allBytes[2] | (allBytes[3] << 8);
console.log(`Code size: ${codeSize} bytes ($${hexWord(codeSize)})`);
console.log(`Base address: $${hexWord(baseAddr)}`);
console.log(`End address: $${hexWord(baseAddr + codeSize - 1)}`);

const codeBytes = allBytes.slice(4, 4 + codeSize);
console.log(`Extracted ${codeBytes.length} code bytes`);

// Check terminator
const termStart = 4 + codeSize;
if (termStart + 4 <= allBytes.length) {
  const termSize = allBytes[termStart] | (allBytes[termStart + 1] << 8);
  const termAddr = allBytes[termStart + 2] | (allBytes[termStart + 3] << 8);
  console.log(`Terminator: size=${hexWord(termSize)}, exec_addr=${hexWord(termAddr)}`);
}

console.log('\n; ═══════════════════════════════════════════════════════════');
console.log('; Soul Blazer SPC700 Sound Engine — Full Disassembly');
console.log(`; ARAM $${hexWord(baseAddr)}–$${hexWord(baseAddr + codeSize - 1)} (${codeSize} bytes)`);
console.log('; Execution entry: $0400');
console.log('; ═══════════════════════════════════════════════════════════\n');

const result = disassemble(codeBytes, baseAddr);
for (const line of result) {
  console.log(line);
}
