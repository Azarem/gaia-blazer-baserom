; HDMA channel queue and the NMI and vblank switches (file offsets 71774-71931 and 78220-78280, SNES $02:985E-$98FB and $02:B18C-$B1C8, bank 02).
; 
; === HDMA CHANNEL QUEUE ===
; HDMA channels 4-7 are handed out one per call within a frame; channels 0-2 are used by the NMI for OAM, CGRAM and VRAM transfers (HandleVBlank, engine_vblank_nmi). State lives in the direct page: dp$42 is the pending channel mask (the NMI copies it to HDMAEN), dp$44 the bit of the next free channel ($10 first), dp$46 the offset of that channel's register block from $4300 ($40 first, so channel 4 = $4340) and dp$48 is set to $6000 and never read. ResetHdmaQueue empties the queue at the start of every work phase. QueueHdmaDirect and QueueHdmaIndirect program the next channel; both are entered by long call with M = 8 and X = 16, take A.low = bank, B = PPU register index ($00-$3F, the low byte of the $21xx register) and Y = table address (load them with LDA #reg, XBA, LDA #bank, LDY #addr) and finish in the shared tail WriteHdmaChannelRegisters. HdmaDmapByRegister, indexed by the register number, supplies the DMA mode byte (one register, a register pair or the same register twice).
; Indirect mode (DMAP or $40) sets both the table bank A1Bn and the indirect data bank DASBn to the bank given, so the table and the data it points to share one bank; every caller passes $7E and a WRAM table at $7800 or $7000. Direct mode reads the table as is (ROM tables binary_006A86 and binary_01B284 or WRAM).
; There is no overflow guard: the fourth call shifts $80 out of dp$44 and the carry that ADC #$10 then adds (there is no CLC) makes dp$46 = $81; a fifth call per frame would write $4381-$4387, which is not a DMA channel (OQ-I009-9).
; 
; === NMI AND VBLANK ===
; nmi_enabled ($03D2) is non-zero while the frame code runs with NMI on: EnableNmi increments it, EnableDisplayAndNmi (lib_menus) increments it, DisableNmi and ForceBlankNmiOff zero it. The text renderer's input wait (lib_text_render.WaitFrameReadButtons) tests it: with NMI on it waits for the vblank, with NMI off it runs a whole sub-frame instead (RunSubFrame). WaitVBlank is the only wait for a vblank; when NMI is on, HandleVBlank runs inside it.
; 
; === NOTES ===
; - The extractor decoded ResetHdmaQueue with M = 16 (LDA #$8510 and MVP) until the M override at 71774; the real code is the 16 bytes shown now (OQ-I005-7).
; - ForceBlankNmiOff, EnableNmi and DisableNmi are the NMI switches of the main loop and the scene change; their call sites are in engine_boot_main_loop, lib_menus, lib_scene_change_init and engine_spawn_lairs_death_drops.
---------------------------------------------

?BANK 02

!nmi_enabled                    03D2
!INIDISP                        2100
!NMITIMEN                       4200
!RDNMI                          4210
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DASB0                          4307

---------------------------------------------

; Empties the HDMA channel queue for the coming frame.
; 
; When: once at the start of every work phase (RunMainLoop, RunReducedLoop, the two scene-change paths and the sub-frame wrapper: 6 call sites).
; Sees: nothing by itself; HDMA effects stop unless an actor queues its channel again this frame.
; Why: HDMA is a per-frame effect: whoever wants a scanline effect queues a channel in every frame and the NMI enables exactly the queued channels (HDMAEN = dp$42).
; In: long call; M = 8, X = 16 (the M override at 71774 makes the extractor decode it that way).
; Out: dp$42 = 0 (pending mask), dp$44 = $10 (bit of channel 4), dp$46 = $40 (offset of $4340 from $4300), dp$48 = $6000 (never read).
; Clobbers: A, X.

ResetHdmaQueue {
    STZ $42
    LDA #$10              ; Queue state: dp$44 = bit of the next free channel ($10 = channel 4), dp$46 = offset of its register block from $4300 ($40 = $4340), dp$48 = $6000 (written, never read)
    STA $44
    LDA #$40
    STA $46
    LDX #$6000
    STX $48
    RTL 
}
---------------------------------------------

; Programs the next free HDMA channel (4-7) for an indirect table and enables it.
; 
; When: 10 call sites in world actors (every caller passes bank $7E and a WRAM table at $7800 or $7000).
; Sees: the scanline effect of the calling actor appears from the next frame's NMI on (HDMAEN gets the channel bit).
; Why: the queue lets several actors share channels 4-7 without knowing which is free.
; In: long call; M = 8, X = 16; A.low = bank of the table and of the data it points to, B = PPU register index ($00-$3F), Y = table address.
; Out: DMAPn = HdmaDmapByRegister[reg] or $40, BBADn = reg, A1TnL/H = Y, A1Bn = DASBn = bank; dp$42 or= dp$44, dp$44 shifted left, dp$46 += $10 (plus the carry of the shift). No guard against a fifth call (OQ-I009-9).
; Clobbers: A (low = bank, B = 0); P, X and Y are restored.

QueueHdmaIndirect {
    PHP 
    PHX 
    SEP #$20
    PHA 
    LDA #$00
    XBA 
    PHA 
    TAX 
    LDA $@HdmaDmapByRegister, X ; DMAP mode byte of this PPU register (X = register index, B was cleared above)
    LDX $46
    ORA #$40              ; Indirect mode (bit 6): the table holds pointers to the data
    STA $DMAP0, X
    LDA $02, S            ; The bank pushed by the caller (below the register index): table bank and indirect data bank
    STA $DASB0, X
    BRA WriteHdmaChannelRegisters
}

---------------------------------------------
; Programs the next free HDMA channel (4-7) for a direct table and enables it.
; 
; When: 14 call sites (player and world actors, the soul code in lib_011695 and lib_0116C3); tables are ROM (binary_006A86, binary_01B284) or WRAM.
; Sees: as QueueHdmaIndirect.
; Why: same queue as the indirect entry; direct mode needs no data bank.
; In: as QueueHdmaIndirect (the bank is the table's bank).
; Out: as QueueHdmaIndirect with DMAPn = HdmaDmapByRegister[reg] and no DASBn.
; Clobbers: as QueueHdmaIndirect.

QueueHdmaDirect {
    PHP 
    PHX 
    SEP #$20
    PHA 
    LDA #$00
    XBA 
    PHA 
    TAX 
    LDA $@HdmaDmapByRegister, X
    LDX $46
    STA $DMAP0, X

; Shared tail of the two queue entries: writes the channel registers and advances the queue.
; 
; When: QueueHdmaDirect falls into it; QueueHdmaIndirect reaches it with BRA.
; Sees: n/a (called only from the two entries).
; Why: the two entries differ only in DMAP and DASBn, the rest is identical.
; In: stack: register index (top), then bank; X = dp$46 (the channel's register offset), Y = table address.
; Out: BBADn = register index, A1TnL/H = Y, A1Bn = bank, dp$42 or= dp$44, dp$44 shifted left, dp$46 += $10 plus carry; PLX and PLP of the entry, RTL. The carry of ASL dp$44 is not cleared first (see the block note).
; Clobbers: A.

  WriteHdmaChannelRegisters:
    PLA 
    STA $BBAD0, X
    REP #$20
    TYA 
    STA $A1T0L, X
    SEP #$20
    PLA 
    STA $A1B0, X
    LDA $44
    TSB $42
    ASL $44
    LDA $46
    ADC #$10              ; +$10 per channel, plus the carry of the ASL above: no CLC, so after the fourth call dp$46 becomes $81 (OQ-I009-9)
    STA $46
    PLX 
    PLP 
    RTL 
}
---------------------------------------------

; The DMAP byte for each PPU register, 64 bytes indexed by the low byte of the register address ($2100-$213F).
; 
; When: QueueHdmaDirect and QueueHdmaIndirect read it with the register index.
; Sees: n/a (data).
; Why: an HDMA channel must be told how many bytes go to the register per line; scroll, matrix and palette registers take a byte twice, address registers take a pair.
; In: n/a (data). Index = register number.
; Out: n/a. 0 = one register ($2105-$210C, $2115, $211A, $2121 and the rest), 1 = register pair ($2102/3, $2116/7, $2118/9), 2 = the same register written twice ($2104, $210D-$2114, $211B-$2120, $2122); $80 or more for registers that are read ($2134-$213F: $80, $2138 $82, $2139/A $81, $213B-$213D $82). No caller queues a read register.
; Clobbers: n/a.

HdmaDmapByRegister #00000101020000000000000000020202020202020200010101010002020202020200020000000000000000000000000000000000808080808281818282828080
---------------------------------------------

; Blanks the screen and turns NMI off.
; 
; When: the scene-change code, before it rebuilds VRAM (counterpart of EnableDisplayAndNmi).
; Sees: the screen goes black.
; Why: VRAM can only be written freely in forced blank, and an NMI during the rewrite would run the frame uploads.
; In: long call; M = 8 is set inside (P restored).
; Out: waits for a vblank (WaitVBlank), NMITIMEN = $01 (NMI off, auto-joypad on), INIDISP = $80 (forced blank), nmi_enabled = 0.
; Clobbers: A (P restored).

ForceBlankNmiOff {
    PHP 
    SEP #$20
    JSL $@WaitVBlank
    LDA #$01              ; NMITIMEN = 1: NMI off, auto-joypad read on
    STA $NMITIMEN
    LDA #$80
    STA $INIDISP
    STZ $nmi_enabled
    PLP 
    RTL 
}
---------------------------------------------

; Turns NMI on and counts the section.
; 
; When: 12 call sites: the end of every work phase in engine_boot_main_loop (8), RunEquipmentMenu, RunTalkInteraction, lib_scene_change_init and engine_spawn_lairs_death_drops.
; Sees: the next vblank runs HandleVBlank, which uploads what the work phase prepared.
; Why: the work phase runs with NMI off (DisableNmi), so this call is what lets the frame's results reach the screen.
; In: long call; M = 8.
; Out: reads RDNMI first (clears a vblank flag that is still set, so no NMI fires at once), NMITIMEN = $A1 (NMI, V-IRQ mode bit 5 which never fires because the I flag stays set, and auto-joypad), nmi_enabled += 1.
; Clobbers: A.

EnableNmi {
    LDA $RDNMI            ; Reading RDNMI clears a pending vblank flag, so enabling NMI below does not fire one at once
    LDA #$A1              ; $A1: NMI (bit 7), V-IRQ mode (bit 5, masked by the I flag), auto-joypad (bit 0)
    STA $NMITIMEN
    INC $nmi_enabled
    RTL 
}

---------------------------------------------
; Turns NMI off (the auto-joypad read stays on).
; 
; When: 9 call sites: after the menu step of every main-loop frame and in the other loops of engine_boot_main_loop (7), RunTalkInteraction (around the NPC talk script) and engine_spawn_lairs_death_drops.
; Sees: n/a.
; Why: the work phase moves the stack pointer in the sort and OAM code and must not be interrupted (OQ-I005-20).
; In: long call; M = 8.
; Out: NMITIMEN = $01, nmi_enabled = 0.
; Clobbers: A.

DisableNmi {
    LDA #$01
    STA $NMITIMEN
    STZ $nmi_enabled
    RTL 
}
---------------------------------------------

; Waits until the next vblank starts (when NMI is on, HandleVBlank runs inside the wait).
; 
; When: the first step of every main-loop frame and every wait of the menus, the status screen and the scene change.
; Sees: one frame passes.
; Why: the only frame wait in the game; code that polls RDNMI itself does not exist.
; In: long call; any M (set to 8 inside, P restored).
; Out: returns just after the vblank flag was seen.
; Clobbers: none (A and P are saved).

WaitVBlank {
    PHP 
    SEP #$20
    PHA 
    LDA $RDNMI            ; Discard a vblank flag left from an earlier frame, then wait for a new one

  loc_0131BE:
    LDA $RDNMI
    BPL loc_0131BE
    LDA $RDNMI
    PLA 
    PLP 
    RTL 
}