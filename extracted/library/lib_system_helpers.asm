; System helpers of bank 02: the HDMA channel queue, the NMI and vblank switches with the screen-on step, and the boot PPU layout (file offsets 71774-71931, 78198-78280 and 80602-80678, SNES $02:985E-$98FB, $02:B176-$B1C8 and $02:BADA-$BB26).
; 
; The parts are ResetHdmaQueue, QueueHdmaIndirect, QueueHdmaDirect, EnableDisplayAndNmi, ForceBlankNmiOff, EnableNmi, DisableNmi, WaitVBlank and ApplyBootPpuLayout. EnableDisplayAndNmi (called by lib_menus) joined the NMI and vblank switches it belongs with; ApplyBootPpuLayout (called by engine_boot_main_loop at boot, after InitHardwareAndClearWram) joined as the other PPU-setup routine (it was the one-routine file lib_013ADA; it could not stay in the loader file and InitHardwareAndClearWram could not leave it, OQ-I042-7). The sections below keep the notes of the parts: the queue and the switches, then the boot layout.
; 
; HDMA channel queue and the NMI and vblank switches (file offsets 71774-71931 and 78220-78280, SNES $02:985E-$98FB and $02:B18C-$B1C8, bank 02).
; 
; === HDMA CHANNEL QUEUE ===
; HDMA channels 4-7 are handed out one per call within a frame; channels 0-2 are used by the NMI for OAM, CGRAM and VRAM transfers (HandleVBlank, engine_vblank_nmi). State lives in the direct page: dp$42 is the pending channel mask (the NMI copies it to HDMAEN), dp$44 the bit of the next free channel ($10 first), dp$46 the offset of that channel's register block from $4300 ($40 first, so channel 4 = $4340) and dp$48 is set to $6000 and never read. ResetHdmaQueue empties the queue at the start of every work phase. QueueHdmaDirect and QueueHdmaIndirect program the next channel; both are entered by long call with M = 8 and X = 16, take A.low = bank, B = PPU register index ($00-$3F, the low byte of the $21xx register) and Y = table address (load them with LDA #reg, XBA, LDA #bank, LDY #addr) and finish in the shared tail WriteHdmaChannelRegisters. HdmaDmapByRegister, indexed by the register number, supplies the DMA mode byte (one register, a register pair or the same register twice).
; Indirect mode (DMAP or $40) sets both the table bank A1Bn and the indirect data bank DASBn to the bank given, so the table and the data it points to share one bank; every caller passes $7E and a WRAM table at $7800 or $7000. Direct mode reads the table as is (ROM tables gv_hdma_title_bgmode_006A86 and gv_hdma_gradient_table_01B284 or WRAM).
; There is no overflow guard: the fourth call shifts $80 out of dp$44 and the carry that ADC #$10 then adds (there is no CLC) makes dp$46 = $81; a fifth call per frame would write $4381-$4387, which is not a DMA channel (OQ-I009-9).
; 
; === NMI AND VBLANK ===
; nmi_enabled ($03D2) is non-zero while the frame code runs with NMI on: EnableNmi increments it, EnableDisplayAndNmi increments it, DisableNmi and ForceBlankNmiOff zero it. The text renderer's input wait (lib_text_render.WaitFrameReadButtons) tests it: with NMI on it waits for the vblank, with NMI off it runs a whole sub-frame instead (RunSubFrame). WaitVBlank is the only wait for a vblank; when NMI is on, HandleVBlank runs inside it.
; 
; === NOTES ===
; - The extractor decoded ResetHdmaQueue with M = 16 (LDA #$8510 and MVP) until the M override at 71774; the real code is the 16 bytes shown now (OQ-I005-7).
; - ForceBlankNmiOff, EnableNmi and DisableNmi are the NMI switches of the main loop and the scene change; their call sites are in engine_boot_main_loop, lib_menus, lib_boot_and_scene_init and engine_spawn_lairs_death_drops.
; 
; Default PPU layout written at boot (file offsets 80602-80678, SNES $02:BADA-$BB26, bank 02).
; 
; === MODEL ===
; ApplyBootPpuLayout runs once, right after InitHardwareAndClearWram (engine_boot_main_loop BootGame). InitHardwareAndClearWram zeroes every PPU register; this routine then sets the layout that the title screen and the first scenes expect before any scene profile is applied: Mode 1 with BG3 priority, BG1 map at VRAM word $6000 (BG1SC $63, 64x64), BG2 map at $7000 (BG2SC $73), BG3 map at $5800 (BG3SC $58), BG1 and BG2 characters at word 0, BG3 characters at $4000, windows 1 on every layer with the window spanning columns 0-255, CGWSEL = $82 and the main screen TM = $07 (BG1, BG2 and BG3).
; 
; === NOTES ===
; - The values are the ones a scene profile computes later (ApplySceneProfile), so the boot layout only matters until the first scene is loaded.
---------------------------------------------

?BANK 02

!nmi_enabled                    03D2
!INIDISP                        2100
!OBJSEL                         2101
!BGMODE                         2105
!BG1SC                          2107
!BG2SC                          2108
!BG3SC                          2109
!BG12NBA                        210B
!BG34NBA                        210C
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!WH0                            2126
!WH1                            2127
!WH2                            2128
!WH3                            2129
!TM                             212C
!CGWSEL                         2130
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
; When: once at the start of every work phase (RunMainLoop, RunReducedLoop, RunReturnLoop and the three sub-frame runners: 6 call sites, all in engine_boot_main_loop).
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
; When: 14 call sites (player and world actors, the soul code in lib_hdma_window_effects and lib_hdma_window_effects); tables are ROM (gv_hdma_title_bgmode_006A86, gv_hdma_gradient_table_01B284) or WRAM.
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

; Waits for a vblank, then turns on NMI and the screen at full brightness.
; 
; When: RunEquipmentMenu, after the first page is printed.
; Sees: the menu appears.
; Why: the screen stays blanked while VRAM is being filled and is switched on in a vblank.
; In: long call; M = 8 is set inside.
; Out: WaitVBlank, NMITIMEN = $A1, INIDISP = $0F, nmi_enabled += 1; P restored.
; Clobbers: A.

EnableDisplayAndNmi {
    PHP 
    SEP #$20
    JSL $@WaitVBlank
    LDA #$A1
    STA $NMITIMEN
    LDA #$0F
    STA $INIDISP
    INC $nmi_enabled
    PLP 
    RTL 
}
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
; When: 12 call sites: the end of every work phase in engine_boot_main_loop (8), RunEquipmentMenu, RunTalkInteraction, lib_boot_and_scene_init and engine_spawn_lairs_death_drops.
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

  WaitVBlankLoop:
    LDA $RDNMI
    BPL WaitVBlankLoop
    LDA $RDNMI
    PLA 
    PLP 
    RTL 
}
---------------------------------------------

; Writes the default PPU layout.
; 
; When: once at boot, after InitHardwareAndClearWram.
; Sees: nothing yet; the screen is still in forced blank.
; Why: the register reset leaves every layer off; this gives the title screen its layers and map bases.
; In: JSL; M = 8.
; Out: OBJSEL = $01, BGMODE = $09, BG1SC = $63, BG2SC = $73, BG3SC = $58, BG12NBA = 0, BG34NBA = 4, W12SEL = W34SEL = WOBJSEL = $33, WH0-WH3 (window 1 over columns 0-255), CGWSEL = $82, TM = $07.
; Clobbers: A.

ApplyBootPpuLayout {
    SEP #$20
    LDA #$01
    STA $OBJSEL
    LDA #$09
    STA $BGMODE
    LDA #$63
    STA $BG1SC
    LDA #$73
    STA $BG2SC
    LDA #$58
    STA $BG3SC
    LDA #$00
    STA $BG12NBA
    LDA #$04
    STA $BG34NBA
    LDA #$33
    STA $W12SEL
    STA $W34SEL
    STA $WOBJSEL
    LDA #$00
    STA $WH0
    LDA #$FF
    STA $WH1
    LDA #$00
    STA $WH2
    STA $WH3
    LDA #$82
    STA $CGWSEL
    LDA #$07
    STA $TM
    RTL 
}