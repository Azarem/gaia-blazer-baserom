#!/usr/bin/env node
/**
 * SPC700 Disassembler for the Soul Blazer N-SPC Sound Engine.
 *
 * Usage: node scripts/disasm-spc700.mjs [-o docs/audio/spc-disassembly.md]
 *
 * Extracts the SPC engine binary from the extracted ASM hex data and disassembles it.
 * Produces annotated markdown output with known labels, data regions, and IoG comparisons.
 */

import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';

// ─── SPC700 Instruction Table ──────────────────────────────────────────────
const OPCODES = new Array(256).fill(null);
function op(code, mnemonic, mode, size) {
  OPCODES[code] = { mnemonic, mode, size };
}

op(0x00, 'NOP', 'imp', 1);
op(0x01, 'TCALL 0', 'imp', 1);
op(0x02, 'SET1', 'dpBit0', 2);
op(0x03, 'BBS', 'dpBitRel0', 3);
op(0x04, 'OR', 'dpA', 2);
op(0x05, 'OR', 'absA', 3);
op(0x06, 'OR', 'indXA', 1);
op(0x07, 'OR', 'indXdpA', 2);
op(0x08, 'OR', 'immA', 2);
op(0x09, 'OR', 'dpDp', 3);
op(0x0A, 'OR1', 'absBit', 3);
op(0x0B, 'ASL', 'dp', 2);
op(0x0C, 'ASL', 'abs', 3);
op(0x0D, 'PUSH', 'PSW', 1);
op(0x0E, 'TSET1', 'abs', 3);
op(0x0F, 'BRK', 'imp', 1);
op(0x10, 'BPL', 'rel', 2);
op(0x11, 'TCALL 1', 'imp', 1);
op(0x12, 'CLR1', 'dpBit0', 2);
op(0x13, 'BBC', 'dpBitRel0', 3);
op(0x14, 'OR', 'dpXA', 2);
op(0x15, 'OR', 'absXA', 3);
op(0x16, 'OR', 'absYA', 3);
op(0x17, 'OR', 'indYdpA', 2);
op(0x18, 'OR', 'dpImm', 3);
op(0x19, 'OR', 'XindYind', 1);
op(0x1A, 'DECW', 'dp', 2);
op(0x1B, 'ASL', 'dpX', 2);
op(0x1C, 'ASL', 'A', 1);
op(0x1D, 'DEC', 'X', 1);
op(0x1E, 'CMP', 'absX', 3);
op(0x1F, 'JMP', 'absXind', 3);
op(0x20, 'CLRP', 'imp', 1);
op(0x21, 'TCALL 2', 'imp', 1);
op(0x22, 'SET1', 'dpBit1', 2);
op(0x23, 'BBS', 'dpBitRel1', 3);
op(0x24, 'AND', 'dpA', 2);
op(0x25, 'AND', 'absA', 3);
op(0x26, 'AND', 'indXA', 1);
op(0x27, 'AND', 'indXdpA', 2);
op(0x28, 'AND', 'immA', 2);
op(0x29, 'AND', 'dpDp', 3);
op(0x2A, 'OR1', 'absNotBit', 3);
op(0x2B, 'ROL', 'dp', 2);
op(0x2C, 'ROL', 'abs', 3);
op(0x2D, 'PUSH', 'A', 1);
op(0x2E, 'CBNE', 'dpRel', 3);
op(0x2F, 'BRA', 'rel', 2);
op(0x30, 'BMI', 'rel', 2);
op(0x31, 'TCALL 3', 'imp', 1);
op(0x32, 'CLR1', 'dpBit1', 2);
op(0x33, 'BBC', 'dpBitRel1', 3);
op(0x34, 'AND', 'dpXA', 2);
op(0x35, 'AND', 'absXA', 3);
op(0x36, 'AND', 'absYA', 3);
op(0x37, 'AND', 'indYdpA', 2);
op(0x38, 'AND', 'dpImm', 3);
op(0x39, 'AND', 'XindYind', 1);
op(0x3A, 'INCW', 'dp', 2);
op(0x3B, 'ROL', 'dpX', 2);
op(0x3C, 'ROL', 'A', 1);
op(0x3D, 'INC', 'X', 1);
op(0x3E, 'CMP', 'dpX', 2);
op(0x3F, 'CALL', 'abs', 3);
op(0x40, 'SETP', 'imp', 1);
op(0x41, 'TCALL 4', 'imp', 1);
op(0x42, 'SET1', 'dpBit2', 2);
op(0x43, 'BBS', 'dpBitRel2', 3);
op(0x44, 'EOR', 'dpA', 2);
op(0x45, 'EOR', 'absA', 3);
op(0x46, 'EOR', 'indXA', 1);
op(0x47, 'EOR', 'indXdpA', 2);
op(0x48, 'EOR', 'immA', 2);
op(0x49, 'EOR', 'dpDp', 3);
op(0x4A, 'AND1', 'absBit', 3);
op(0x4B, 'LSR', 'dp', 2);
op(0x4C, 'LSR', 'abs', 3);
op(0x4D, 'PUSH', 'X', 1);
op(0x4E, 'TCLR1', 'abs', 3);
op(0x4F, 'PCALL', 'upage', 2);
op(0x50, 'BVC', 'rel', 2);
op(0x51, 'TCALL 5', 'imp', 1);
op(0x52, 'CLR1', 'dpBit2', 2);
op(0x53, 'BBC', 'dpBitRel2', 3);
op(0x54, 'EOR', 'dpXA', 2);
op(0x55, 'EOR', 'absXA', 3);
op(0x56, 'EOR', 'absYA', 3);
op(0x57, 'EOR', 'indYdpA', 2);
op(0x58, 'EOR', 'dpImm', 3);
op(0x59, 'EOR', 'XindYind', 1);
op(0x5A, 'CMPW', 'dpYA', 2);
op(0x5B, 'LSR', 'dpX', 2);
op(0x5C, 'LSR', 'A', 1);
op(0x5D, 'MOV', 'XA', 1);
op(0x5E, 'CMP', 'absY', 3);
op(0x5F, 'JMP', 'abs', 3);
op(0x60, 'CLRC', 'imp', 1);
op(0x61, 'TCALL 6', 'imp', 1);
op(0x62, 'SET1', 'dpBit3', 2);
op(0x63, 'BBS', 'dpBitRel3', 3);
op(0x64, 'CMP', 'dpA', 2);
op(0x65, 'CMP', 'absA', 3);
op(0x66, 'CMP', 'indXA', 1);
op(0x67, 'CMP', 'indXdpA', 2);
op(0x68, 'CMP', 'immA', 2);
op(0x69, 'CMP', 'dpDp', 3);
op(0x6A, 'AND1', 'absNotBit', 3);
op(0x6B, 'ROR', 'dp', 2);
op(0x6C, 'ROR', 'abs', 3);
op(0x6D, 'PUSH', 'Y', 1);
op(0x6E, 'DBNZ', 'dpRel', 3);
op(0x6F, 'RET', 'imp', 1);
op(0x70, 'BVS', 'rel', 2);
op(0x71, 'TCALL 7', 'imp', 1);
op(0x72, 'CLR1', 'dpBit3', 2);
op(0x73, 'BBC', 'dpBitRel3', 3);
op(0x74, 'CMP', 'dpXA', 2);
op(0x75, 'CMP', 'absXA', 3);
op(0x76, 'CMP', 'absYA', 3);
op(0x77, 'CMP', 'indYdpA', 2);
op(0x78, 'CMP', 'dpImm', 3);
op(0x79, 'CMP', 'XindYind', 1);
op(0x7A, 'ADDW', 'dpYA', 2);
op(0x7B, 'ROR', 'dpX', 2);
op(0x7C, 'ROR', 'A', 1);
op(0x7D, 'MOV', 'AX', 1);
op(0x7E, 'CMP', 'dpY', 2);
op(0x7F, 'RETI', 'imp', 1);
op(0x80, 'SETC', 'imp', 1);
op(0x81, 'TCALL 8', 'imp', 1);
op(0x82, 'SET1', 'dpBit4', 2);
op(0x83, 'BBS', 'dpBitRel4', 3);
op(0x84, 'ADC', 'dpA', 2);
op(0x85, 'ADC', 'absA', 3);
op(0x86, 'ADC', 'indXA', 1);
op(0x87, 'ADC', 'indXdpA', 2);
op(0x88, 'ADC', 'immA', 2);
op(0x89, 'ADC', 'dpDp', 3);
op(0x8A, 'EOR1', 'absBit', 3);
op(0x8B, 'DEC', 'dp', 2);
op(0x8C, 'DEC', 'abs', 3);
op(0x8D, 'MOV', 'immY', 2);
op(0x8E, 'POP', 'PSW', 1);
op(0x8F, 'MOV', 'dpImm', 3);
op(0x90, 'BCC', 'rel', 2);
op(0x91, 'TCALL 9', 'imp', 1);
op(0x92, 'CLR1', 'dpBit4', 2);
op(0x93, 'BBC', 'dpBitRel4', 3);
op(0x94, 'ADC', 'dpXA', 2);
op(0x95, 'ADC', 'absXA', 3);
op(0x96, 'ADC', 'absYA', 3);
op(0x97, 'ADC', 'indYdpA', 2);
op(0x98, 'ADC', 'dpImm', 3);
op(0x99, 'ADC', 'XindYind', 1);
op(0x9A, 'SUBW', 'dpYA', 2);
op(0x9B, 'DEC', 'dpX', 2);
op(0x9C, 'DEC', 'A', 1);
op(0x9D, 'MOV', 'XSP', 1);
op(0x9E, 'DIV', 'YAX', 1);
op(0x9F, 'XCN', 'A', 1);
op(0xA0, 'EI', 'imp', 1);
op(0xA1, 'TCALL 10', 'imp', 1);
op(0xA2, 'SET1', 'dpBit5', 2);
op(0xA3, 'BBS', 'dpBitRel5', 3);
op(0xA4, 'SBC', 'dpA', 2);
op(0xA5, 'SBC', 'absA', 3);
op(0xA6, 'SBC', 'indXA', 1);
op(0xA7, 'SBC', 'indXdpA', 2);
op(0xA8, 'SBC', 'immA', 2);
op(0xA9, 'SBC', 'dpDp', 3);
op(0xAA, 'MOV1', 'absBitC', 3);
op(0xAB, 'INC', 'dp', 2);
op(0xAC, 'INC', 'abs', 3);
op(0xAD, 'CMP', 'immY', 2);
op(0xAE, 'POP', 'A', 1);
op(0xAF, 'MOV', 'Xind_inc_A', 1);
op(0xB0, 'BCS', 'rel', 2);
op(0xB1, 'TCALL 11', 'imp', 1);
op(0xB2, 'CLR1', 'dpBit5', 2);
op(0xB3, 'BBC', 'dpBitRel5', 3);
op(0xB4, 'SBC', 'dpXA', 2);
op(0xB5, 'SBC', 'absXA', 3);
op(0xB6, 'SBC', 'absYA', 3);
op(0xB7, 'SBC', 'indYdpA', 2);
op(0xB8, 'SBC', 'dpImm', 3);
op(0xB9, 'SBC', 'XindYind', 1);
op(0xBA, 'MOVW', 'dpYA_read', 2);
op(0xBB, 'INC', 'dpX', 2);
op(0xBC, 'INC', 'A', 1);
op(0xBD, 'MOV', 'SPX', 1);
op(0xBE, 'DAS', 'A', 1);
op(0xBF, 'MOV', 'A_Xind_inc', 1);
op(0xC0, 'DI', 'imp', 1);
op(0xC1, 'TCALL 12', 'imp', 1);
op(0xC2, 'SET1', 'dpBit6', 2);
op(0xC3, 'BBS', 'dpBitRel6', 3);
op(0xC4, 'MOV', 'st_dpA', 2);
op(0xC5, 'MOV', 'st_absA', 3);
op(0xC6, 'MOV', 'st_indXA', 1);
op(0xC7, 'MOV', 'st_indXdpA', 2);
op(0xC8, 'CMP', 'immX', 2);
op(0xC9, 'MOV', 'absX', 3);
op(0xCA, 'MOV1', 'absBit_C', 3);
op(0xCB, 'MOV', 'dpY', 2);
op(0xCC, 'MOV', 'absY', 3);
op(0xCD, 'MOV', 'immX', 2);
op(0xCE, 'POP', 'X', 1);
op(0xCF, 'MUL', 'YA', 1);
op(0xD0, 'BNE', 'rel', 2);
op(0xD1, 'TCALL 13', 'imp', 1);
op(0xD2, 'CLR1', 'dpBit6', 2);
op(0xD3, 'BBC', 'dpBitRel6', 3);
op(0xD4, 'MOV', 'dpXA', 2);
op(0xD5, 'MOV', 'st_absXA', 3);
op(0xD6, 'MOV', 'st_absYA', 3);
op(0xD7, 'MOV', 'st_indYdpA', 2);
op(0xD8, 'MOV', 'dpX_store', 2);
op(0xD9, 'MOV', 'dpYX', 2);
op(0xDA, 'MOVW', 'dpYA_write', 2);
op(0xDB, 'MOV', 'dpXY', 2);
op(0xDC, 'DEC', 'Y', 1);
op(0xDD, 'MOV', 'AY', 1);
op(0xDE, 'CBNE', 'dpXRel', 3);
op(0xDF, 'DAA', 'A', 1);
op(0xE0, 'CLRV', 'imp', 1);
op(0xE1, 'TCALL 14', 'imp', 1);
op(0xE2, 'SET1', 'dpBit7', 2);
op(0xE3, 'BBS', 'dpBitRel7', 3);
op(0xE4, 'MOV', 'Adp', 2);
op(0xE5, 'MOV', 'Aabs', 3);
op(0xE6, 'MOV', 'A_Xind', 1);
op(0xE7, 'MOV', 'A_indXdp', 2);
op(0xE8, 'MOV', 'immA', 2);
op(0xE9, 'MOV', 'Xabs', 3);
op(0xEA, 'NOT1', 'absBit', 3);
op(0xEB, 'MOV', 'Ydp', 2);
op(0xEC, 'MOV', 'Yabs', 3);
op(0xED, 'NOTC', 'imp', 1);
op(0xEE, 'POP', 'Y', 1);
op(0xEF, 'SLEEP', 'imp', 1);
op(0xF0, 'BEQ', 'rel', 2);
op(0xF1, 'TCALL 15', 'imp', 1);
op(0xF2, 'CLR1', 'dpBit7', 2);
op(0xF3, 'BBC', 'dpBitRel7', 3);
op(0xF4, 'MOV', 'Adp_X', 2);
op(0xF5, 'MOV', 'AabsX', 3);
op(0xF6, 'MOV', 'AabsY', 3);
op(0xF7, 'MOV', 'A_indYdp', 2);
op(0xF8, 'MOV', 'Xdp', 2);
op(0xF9, 'MOV', 'Xdp_Y', 2);
op(0xFA, 'MOV', 'dpDp', 3);
op(0xFB, 'MOV', 'Ydp_X', 2);
op(0xFC, 'INC', 'Y', 1);
op(0xFD, 'MOV', 'YA', 1);
op(0xFE, 'DBNZ', 'Yrel', 2);
op(0xFF, 'STOP', 'imp', 1);

// ─── Format operand (reused from IOG disassembler) ────────────────────────
function formatOperand(mode, bytes, pc) {
  const b1 = bytes[0], b2 = bytes[1];
  const w = b1 | (b2 << 8);
  const rel = (off) => {
    const target = (pc + (off > 127 ? off - 256 : off)) & 0xFFFF;
    return '$' + target.toString(16).padStart(4, '0');
  };
  if (mode === 'imp' || mode === 'A' || mode === 'X' || mode === 'Y' ||
      mode === 'PSW' || mode === 'YA' || mode === 'YAX' || mode === 'SP' ||
      mode === 'XSP' || mode === 'SPX' || mode === 'XA' || mode === 'AX' ||
      mode === 'AY' || mode === 'XindYind' || mode === 'indXA' || mode === 'st_indXA' ||
      mode === 'A_Xind' || mode === 'Xind_inc_A' || mode === 'A_Xind_inc') {
    const names = {
      'XA': 'X, A', 'AX': 'A, X', 'AY': 'A, Y', 'XSP': 'X, SP', 'SPX': 'SP, X',
      'YAX': 'YA', 'XindYind': '(X), (Y)', 'indXA': 'A, (X)', 'st_indXA': '(X), A',
      'A_Xind': 'A, (X)', 'Xind_inc_A': '(X)+, A', 'A_Xind_inc': 'A, (X)+',
    };
    return names[mode] || '';
  }
  if (mode === 'immA') return 'A, #$' + b1.toString(16).padStart(2, '0');
  if (mode === 'immX') return 'X, #$' + b1.toString(16).padStart(2, '0');
  if (mode === 'immY') return 'Y, #$' + b1.toString(16).padStart(2, '0');
  if (mode === 'dpA') return 'A, $' + b1.toString(16).padStart(2, '0');
  if (mode === 'Adp') return 'A, $' + b1.toString(16).padStart(2, '0');
  if (mode === 'Adp_X') return 'A, $' + b1.toString(16).padStart(2, '0') + '+X';
  if (mode === 'dpXA') return '$' + b1.toString(16).padStart(2, '0') + '+X, A';
  if (mode === 'dpYA') return '$' + b1.toString(16).padStart(2, '0') + '+Y, A';
  if (mode === 'dpX') return '$' + b1.toString(16).padStart(2, '0') + '+X';
  if (mode === 'dpY') return '$' + b1.toString(16).padStart(2, '0') + ', Y';
  if (mode === 'dpX_store') return '$' + b1.toString(16).padStart(2, '0') + ', X';
  if (mode === 'dpYX') return '$' + b1.toString(16).padStart(2, '0') + '+Y, X';
  if (mode === 'dpXY') return '$' + b1.toString(16).padStart(2, '0') + '+X, Y';
  if (mode === 'dp') return '$' + b1.toString(16).padStart(2, '0');
  if (mode === 'Ydp') return 'Y, $' + b1.toString(16).padStart(2, '0');
  if (mode === 'Ydp_X') return 'Y, $' + b1.toString(16).padStart(2, '0') + '+X';
  if (mode === 'Xdp') return 'X, $' + b1.toString(16).padStart(2, '0');
  if (mode === 'Xdp_Y') return 'X, $' + b1.toString(16).padStart(2, '0') + '+Y';
  if (mode === 'abs') return '$' + w.toString(16).padStart(4, '0');
  if (mode === 'absA') return 'A, $' + w.toString(16).padStart(4, '0');
  if (mode === 'Aabs') return 'A, $' + w.toString(16).padStart(4, '0');
  if (mode === 'absX') return '$' + w.toString(16).padStart(4, '0') + ', X';
  if (mode === 'Xabs') return 'X, $' + w.toString(16).padStart(4, '0');
  if (mode === 'absY') return '$' + w.toString(16).padStart(4, '0') + ', Y';
  if (mode === 'Yabs') return 'Y, $' + w.toString(16).padStart(4, '0');
  if (mode === 'absXA') return 'A, $' + w.toString(16).padStart(4, '0') + '+X';
  if (mode === 'AabsX') return 'A, $' + w.toString(16).padStart(4, '0') + '+X';
  if (mode === 'absYA') return 'A, $' + w.toString(16).padStart(4, '0') + '+Y';
  if (mode === 'AabsY') return 'A, $' + w.toString(16).padStart(4, '0') + '+Y';
  if (mode === 'absXind') return '[$' + w.toString(16).padStart(4, '0') + '+X]';
  if (mode === 'indXdpA' || mode === 'A_indXdp') return 'A, [$' + b1.toString(16).padStart(2, '0') + '+X]';
  if (mode === 'indYdpA' || mode === 'A_indYdp') return 'A, [$' + b1.toString(16).padStart(2, '0') + ']+Y';
  if (mode === 'st_dpA') return '$' + b1.toString(16).padStart(2, '0') + ', A';
  if (mode === 'st_absA') return '$' + w.toString(16).padStart(4, '0') + ', A';
  if (mode === 'st_indXA') return '(X), A';
  if (mode === 'st_indXdpA') return '[$' + b1.toString(16).padStart(2, '0') + '+X], A';
  if (mode === 'st_absXA') return '$' + w.toString(16).padStart(4, '0') + '+X, A';
  if (mode === 'st_absYA') return '$' + w.toString(16).padStart(4, '0') + '+Y, A';
  if (mode === 'st_indYdpA') return '[$' + b1.toString(16).padStart(2, '0') + ']+Y, A';
  if (mode === 'dpDp') return '$' + b2.toString(16).padStart(2, '0') + ', $' + b1.toString(16).padStart(2, '0');
  if (mode === 'dpImm') return '$' + b2.toString(16).padStart(2, '0') + ', #$' + b1.toString(16).padStart(2, '0');
  if (mode === 'dpYA_read') return 'YA, $' + b1.toString(16).padStart(2, '0');
  if (mode === 'dpYA_write') return '$' + b1.toString(16).padStart(2, '0') + ', YA';
  if (mode === 'rel') return rel(b1);
  if (mode === 'Yrel') return 'Y, ' + rel(b1);
  if (mode === 'dpRel') return '$' + b1.toString(16).padStart(2, '0') + ', ' + rel(b2);
  if (mode === 'dpXRel') return '$' + b1.toString(16).padStart(2, '0') + '+X, ' + rel(b2);
  if (mode === 'upage') return '$' + (0xFF00 | b1).toString(16);
  if (mode === 'absBit' || mode === 'absBitC' || mode === 'absBit_C' || mode === 'absNotBit') {
    const addr = w & 0x1FFF;
    const bit = (w >> 13) & 7;
    const prefix = mode === 'absNotBit' ? '/' : '';
    if (mode === 'absBitC') return 'C, ' + prefix + '$' + addr.toString(16).padStart(4, '0') + '.' + bit;
    if (mode === 'absBit_C') return prefix + '$' + addr.toString(16).padStart(4, '0') + '.' + bit + ', C';
    return prefix + '$' + addr.toString(16).padStart(4, '0') + '.' + bit;
  }
  for (let b = 0; b < 8; b++) {
    if (mode === 'dpBit' + b) return '$' + b1.toString(16).padStart(2, '0') + '.' + b;
    if (mode === 'dpBitRel' + b) return '$' + b1.toString(16).padStart(2, '0') + '.' + b + ', ' + rel(b2);
  }
  return '?mode=' + mode;
}

// ─── Known Labels ──────────────────────────────────────────────────────────
const LABELS = {
  0x0400: 'EngineEntry',
  0x0407: 'ZeroFillLoop',
  0x0436: 'MainLoop',
  0x0440: 'DSPOutputLoop',
  0x0460: 'WaitTimer0',
  0x0479: 'SequenceTickCheck',
  0x0495: 'PortDataUpdate',
  0x049D: 'SFXOnlyProcess',
  0x04B6: 'ReadPortData',
  0x04C3: 'NoteDispatch',
  0x052D: 'PitchCalcEntry',
  0x05B0: 'WriteDSPGuarded',
  0x05B8: 'WriteDSP',
  0x05BD: 'ReadPhraseWord',
  0x05CB: 'HandleFadeIn',
  0x05D4: 'InitSampleEndPtr',
  0x05E8: 'StopAllChannels',
  0x05FE: 'SetEchoBit6',
  0x0601: 'HandleBootHandshake',
  0x0609: 'DispatchCommand',
  0x061A: 'PlaySong',
  0x0645: 'UpdateEnableMask',
  0x064D: 'ResetAllChannels',
  0x0683: 'ProcessSequenceTick',
  0x06A1: 'PhraseListLoop',
  0x06BF: 'LoadPattern',
  0x06F0: 'ChannelTickLoop',
  0x0701: 'ChannelReadByte',
  0x0723: 'HandleNote',
  0x0745: 'HandleOpcode',
  0x074E: 'HandleNotePlay',
  0x0763: 'HandleGateTimer',
  0x076F: 'PostChannelProcess',
  0x07B0: 'PerChannelEffects',
  0x07C3: 'OpcodeDispatch',
  0x07D5: 'ReadTrackByte',
  0x07DF: 'Handler_E0_SetInstrument',
  0x0849: 'Handler_E1_Pan',
  0x0857: 'Handler_E2_PanFade',
  0x0870: 'Handler_E3_Vibrato',
  0x087C: 'Handler_E4_VibratoOff',
  0x0897: 'Handler_E5_MainVolume',
  0x08A1: 'Handler_E6_VolumeFade',
  0x08B3: 'Handler_E7_Tempo',
  0x08BC: 'Handler_E8_TempoFade',
  0x08CE: 'Handler_E9_GlobalTranspose',
  0x08D1: 'Handler_EA_PerVoiceTranspose',
  0x08D5: 'Handler_EB_Tremolo',
  0x08E1: 'Handler_EC_ADSRAttack',
  0x08E4: 'Handler_F1_ADSROverride',
  0x08E8: 'Handler_F2_PitchEnvelope',
  0x08FE: 'Handler_F3_PitchEnvOff',
  0x0902: 'Handler_ED_ChannelVolume',
  0x090B: 'Handler_EE_ChannelVolFade',
  0x0887: 'Handler_F0_AmplMod',
  0x0924: 'Handler_F4_Tuning',
  0x0928: 'Handler_EF_Subcommand',
  0x094C: 'Handler_F5_EchoOn',
  0x095F: 'Handler_F8_SubroutineCall',
  0x0980: 'Handler_F6_EchoOff',
  0x0987: 'Handler_F7_EchoFIR',
  0x09A9: 'VolumeControlUpdate',
  0x09EB: 'Handler_FA_Conditional',
  0x09F5: 'PitchSlideProcess',
  0x0A05: 'Handler_F9_LoopReturn',
  0x0A2D: 'CopyCurrentPitch',
  0x0A38: 'SignedDivide16',
  0x0A4A: 'SignedMultiplyApply',
  0x0AA5: 'PerChannelEffectMain',
  0x0AFA: 'VibratoTremoloUpdate',
  0x0B38: 'EnvelopeApply',
  0x0B5C: 'GateTimerProcess',
  0x0B69: 'ScanAheadSetup',
  0x0B76: 'ScanAheadLoop',
  0x0BC4: 'PitchBendProcess',
  0x0BDD: 'PitchUpdateAndVolume',
  0x0C10: 'VolumeCalcCore',
  0x0C34: 'SFXChannelProcess',
  0x0C95: 'PitchBendApply',
  0x0CAB: 'FinalPitchWrite',
  0x0CB3: 'TremoloVolumeCalc',
  0x0CC0: 'TremoloMultiply',
  0x0CCB: 'VolumeOutputPipeline',
  0x0DA0: 'SFXHandler',
  0x0E0A: 'SFXProcessChannel8',
  0x0E14: 'SFXInitChannel',
  0x0E4B: 'SFXStopChannel',
  0x0E79: 'SFXChannelTick',
  0x0EAA: 'SFXPlaybackLoop',
  0x0EB0: 'SFXReadByte',
  0x0F06: 'BootHandshake',
  0x0F32: 'BootLoadData',
};

// ─── Data Regions ──────────────────────────────────────────────────────────
const DATA_REGIONS = [
  { start: 0x0A54, end: 0x0A8A, name: 'HandlerAddrTable',
    desc: 'N-SPC opcode handler addresses (27 valid entries × u16 = 54 bytes, $E0–$FA; $FB–$FF overlap with ParamCountTable)' },
  { start: 0x0A8A, end: 0x0AAA, name: 'ParamCountTable',
    desc: 'N-SPC opcode param counts (32 bytes, for opcodes $E0–$FF; first 10 bytes overlap HandlerAddrTable entries $FB–$FF)' },
  { start: 0x0CE9, end: 0x0CFB, name: 'PitchInterpolation',
    desc: 'Pitch interpolation curve (18 bytes, quarter-sine shape)' },
  { start: 0x0CFB, end: 0x0D3E, name: 'VibratoSineTable',
    desc: 'Vibrato/tremolo sine wave LUT (67 bytes — unique to Soul Blazer, not in IoG)' },
  { start: 0x0D3E, end: 0x0D56, name: 'EnvelopeCurve',
    desc: 'ADSR envelope curve table (24 bytes)' },
  { start: 0x0D56, end: 0x0D6C, name: 'EnvelopeConfig',
    desc: 'Envelope config / FIR coefficients (22 bytes)' },
  { start: 0x0D6C, end: 0x0D72, name: 'DSPRegTable',
    desc: 'DSP register number table for channel output (6 bytes)' },
  { start: 0x0D72, end: 0x0D8C, name: 'FreqTable',
    desc: 'Frequency table (13 × u16 = 26 bytes, C through C+)' },
  { start: 0x0D8C, end: 0x0D9C, name: 'OctaveShiftTable',
    desc: 'Octave shift lookup (16 bytes)' },
  { start: 0x0D9C, end: 0x0DA0, name: 'SFXInitData',
    desc: 'SFX init data / padding (4 bytes)' },
  { start: 0x0F3A, end: 0x0F47, name: 'DSPRegInitAndBoot',
    desc: 'DSP register init values and boot tail (13 bytes)' },
];

function isDataRegion(addr) {
  for (const r of DATA_REGIONS) {
    if (addr >= r.start && addr < r.end) return r;
  }
  return null;
}

// ─── Extract binary from ASM hex data ──────────────────────────────────────
const asmFile = readFileSync('./extracted/system/chunk_0FAA49.asm', 'utf8');
const blockStart = asmFile.indexOf('spc_0FF14E [');
const blockEnd = asmFile.indexOf(']', blockStart);
const blockText = asmFile.substring(blockStart, blockEnd);

const hexLines = [];
const regex = /#([0-9A-Fa-f]+)\s+;/g;
let match;
while ((match = regex.exec(blockText)) !== null) {
  hexLines.push(match[1]);
}

let allHex = hexLines.join('');
const allBytes = [];
for (let i = 0; i < allHex.length; i += 2) {
  allBytes.push(parseInt(allHex.substring(i, i + 2), 16));
}

const codeSize = allBytes[0] | (allBytes[1] << 8);
const baseAddr = allBytes[2] | (allBytes[3] << 8);
const codeBytes = allBytes.slice(4, 4 + codeSize);

const START = baseAddr;
const END = baseAddr + codeSize;

// Build an ARAM-indexed buffer
const aram = new Uint8Array(0x10000);
for (let i = 0; i < codeBytes.length; i++) {
  aram[START + i] = codeBytes[i];
}

// ─── First pass: collect branch/call targets ───────────────────────────────
const targets = new Set();
const visited = new Set();

function firstPass(start) {
  const queue = [start];
  while (queue.length > 0) {
    let pc = queue.shift();
    while (pc >= START && pc < END) {
      if (visited.has(pc)) break;
      if (isDataRegion(pc)) break;
      visited.add(pc);
      const opByte = aram[pc];
      const info = OPCODES[opByte];
      if (!info) break;
      const { size, mode, mnemonic } = info;
      const nextPc = pc + size;
      const b1 = size >= 2 ? aram[pc + 1] : 0;
      const b2 = size >= 3 ? aram[pc + 2] : 0;
      if (mode === 'rel' || mode === 'Yrel') {
        const off = b1 > 127 ? b1 - 256 : b1;
        targets.add((nextPc + off) & 0xFFFF);
      }
      if (mode === 'dpRel' || mode === 'dpXRel') {
        const off = b2 > 127 ? b2 - 256 : b2;
        targets.add((nextPc + off) & 0xFFFF);
      }
      for (let bit = 0; bit < 8; bit++) {
        if (mode === 'dpBitRel' + bit) {
          const off = b2 > 127 ? b2 - 256 : b2;
          targets.add((nextPc + off) & 0xFFFF);
        }
      }
      if (mode === 'abs' && (mnemonic === 'CALL' || mnemonic === 'JMP')) {
        const w = b1 | (b2 << 8);
        targets.add(w);
        if (mnemonic === 'CALL') queue.push(w);
      }
      if (mnemonic === 'RET' || mnemonic === 'RETI' || mnemonic === 'STOP' || mnemonic === 'SLEEP') break;
      if (mnemonic === 'JMP') {
        if (mode === 'abs') queue.push(b1 | (b2 << 8));
        break;
      }
      if (mode === 'rel' || mode === 'Yrel') {
        const off = b1 > 127 ? b1 - 256 : b1;
        queue.push((nextPc + off) & 0xFFFF);
      }
      if (mode === 'dpRel' || mode === 'dpXRel') {
        const off = b2 > 127 ? b2 - 256 : b2;
        queue.push((nextPc + off) & 0xFFFF);
      }
      pc = nextPc;
    }
  }
}

firstPass(START);

const autoLabels = {};
for (const addr of targets) {
  if (addr >= START && addr < END && !LABELS[addr]) {
    autoLabels[addr] = 'loc_' + addr.toString(16).padStart(4, '0');
  }
}
const allLabels = { ...LABELS, ...autoLabels };

// ─── Second pass: generate output ──────────────────────────────────────────
const lines = [];
lines.push('# Soul Blazer SPC700 Sound Engine — Full Disassembly');
lines.push('');
lines.push('```');
lines.push('; Soul Blazer N-SPC Sound Engine');
lines.push('; ARAM $' + START.toString(16).padStart(4, '0') + '–$' + (END - 1).toString(16).padStart(4, '0') + ' (' + codeSize + ' bytes)');
lines.push('; Execution entry: $0400');
lines.push('; Disassembled from spc_0FF14E in chunk_0FAA49.asm');
lines.push('');

const FREQ_NOTES = ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B','C+'];

let pc = START;
const shownData = new Set();
while (pc < END) {
  const dataRegion = isDataRegion(pc);
  if (dataRegion && !shownData.has(dataRegion.name)) {
    shownData.add(dataRegion.name);
    lines.push('');
    lines.push('; ═══════════════════════════════════════════════════════════');
    lines.push('; ' + dataRegion.name + ': ' + dataRegion.desc);
    lines.push('; ═══════════════════════════════════════════════════════════');

    if (dataRegion.name === 'FreqTable') {
      for (let i = 0; i < 13; i++) {
        const addr = dataRegion.start + i * 2;
        const val = aram[addr] | (aram[addr + 1] << 8);
        lines.push(addr.toString(16).padStart(4, '0') + ':  .dw $' + val.toString(16).padStart(4, '0') +
          '        ; ' + FREQ_NOTES[i].padEnd(3) + ' = ' + val);
      }
    } else if (dataRegion.name === 'HandlerAddrTable') {
      const opcNames = [
        'E0:SetInstrument','E1:Pan','E2:PanFade','E3:Vibrato','E4:VibratoOff',
        'E5:MainVolume','E6:VolumeFade','E7:Tempo','E8:TempoFade','E9:GlobalTranspose',
        'EA:PerVoiceTransp','EB:Tremolo','EC:ADSRAttack','ED:ChannelVol','EE:ChanVolFade',
        'EF:Subcommand','F0:AmplMod','F1:ADSROverride','F2:PitchEnv','F3:PitchEnvOff',
        'F4:Tuning','F5:EchoOn','F6:EchoOff','F7:EchoFIR','F8:SubroutineCall',
        'F9:LoopReturn','FA:Conditional',
      ];
      for (let i = 0; i < 27; i++) {
        const addr = dataRegion.start + i * 2;
        const val = aram[addr] | (aram[addr + 1] << 8);
        lines.push(addr.toString(16).padStart(4, '0') + ':  .dw $' + val.toString(16).padStart(4, '0') +
          '        ; $' + opcNames[i]);
      }
    } else {
      for (let a = dataRegion.start; a < dataRegion.end; a += 16) {
        let hex = '';
        for (let j = 0; j < 16 && a + j < dataRegion.end; j++) {
          hex += aram[a + j].toString(16).padStart(2, '0') + ' ';
        }
        lines.push(a.toString(16).padStart(4, '0') + ':  .db ' + hex.trimEnd());
      }
    }
    pc = dataRegion.end;
    continue;
  }

  if (allLabels[pc]) {
    lines.push('');
    lines.push(allLabels[pc] + ':');
  }

  const opByte = aram[pc];
  const info = OPCODES[opByte];
  if (!info) {
    lines.push(pc.toString(16).padStart(4, '0') + ':  .db $' + opByte.toString(16).padStart(2, '0') + '            ; unknown');
    pc++;
    continue;
  }

  const { mnemonic, mode, size } = info;
  const bytes = [];
  for (let i = 1; i < size; i++) bytes.push(aram[pc + i]);

  const operand = formatOperand(mode, bytes, pc + size);
  const hexBytes = [];
  for (let i = 0; i < size; i++) hexBytes.push(aram[pc + i].toString(16).padStart(2, '0'));
  const hexStr = hexBytes.join(' ').padEnd(12);

  const addrStr = pc.toString(16).padStart(4, '0');
  const instrStr = (mnemonic + ' ' + operand).trimEnd();
  lines.push(addrStr + ':  ' + hexStr + instrStr);

  pc += size;
}

lines.push('```');

const output = lines.join('\n');
mkdirSync('./docs/audio', { recursive: true });
const outPath = process.argv.includes('-o') ? process.argv[process.argv.indexOf('-o') + 1] : './docs/audio/spc-disassembly.md';
writeFileSync(outPath, output);
console.log('Wrote ' + lines.length + ' lines to ' + outPath);
console.log('Code range: $' + START.toString(16) + '-$' + (END - 1).toString(16) + ' (' + codeSize + ' bytes)');
console.log('Labels: ' + Object.keys(allLabels).length + ' (' + Object.keys(LABELS).length + ' named + ' + Object.keys(autoLabels).length + ' auto)');
