; Title-screen Mode 7 hook and the save-slot (file select) menu (file offsets 27519-28199, SNES $00:EB7F-$EE27, bank 00).
; 
; === MODE 7 (UpdateTitleMode7) ===
; HandleVBlank calls UpdateTitleMode7 on every NMI, after FlushVramWriteQueue (engine_vblank_nmi). It acts only when location_id is $10 and returns at once otherwise. The Mode 7 state lives in WRAM: centre m7x_shadow/m7y_shadow ($046A, $046C), scale m7_scale ($0480, written by gv_front_end) and angle m7_angle ($047E, an 8-bit table index; nothing in extracted/ writes it, so the angle is 0 unless a block copy sets it, OQ-I024-4). BuildRotationMatrix builds A = scale * cos, B = scale * sin, C = -scale * sin and D = scale * cos with the PPU multiplier (Mode7Multiply16x8: M7A, a 16-bit scale, times the signed table byte in M7B; the product's middle and high bytes MPYM/MPYH are the result); the tables are SineTableTail (cos) and SineTable (sin), $40 entries apart, a quarter turn of 256 steps. The results go to m7_matrix_a-d ($0476-$047C). WriteMode7Matrix then writes the shadows (m7a_shadow-m7d_shadow, m7x_shadow, m7y_shadow, $046E-$0474 and $046A-$046C) to M7A-M7D, M7X and M7Y (each write-twice register gets the low byte, then the high byte), and UpdateTitleMode7 copies the new matrix into the shadows, so the PPU always shows the matrix of the previous NMI. RefreshTitleMatrixAlt and BuildRotationMatrixAlt (an alternative matrix routine) have no caller (OQ-I006-6).
; 
; === FILE SELECT ===
; EnterFileSelect is reached by BRL from gv_front_end. It calls lib_01232B.code_01232B, draws the menu and continues in HandleFileSelectChoice (COP 1B). DrawSaveSlotMenu prints the heading (gv_title_texts.SaveSlotMenuText), then checks the four slots at $700000 + n * $400: lib_save_system.ComputeSlotChecksum computes the checksum of the slot into dp$16/$18 and compares it with the words at +$3FA and +$3FC. A valid main block is copied over its backup mirror at +$1000 ($3FE bytes, MVN); an invalid one is restored from the backup and checked again; a slot that is valid in neither is not listed. For every listed slot the menu line is filled from the save block ($1B92 + offset: five fields into $0447-$044E, $1B6A + offset into $0450, $1B90 + offset into $0452) and printed with lib_text_render.PrintTextString. If no slot is valid the last-used slot word $701FFE is set to 0. HandleFileSelectChoice starts the cursor at $701FFE (slot 0-3, else 0), asks lib_0118FC_part2.ChooseMenuRowAtTable, and treats an answer of 4 as a second prompt (probably erase: it stores the slot offset into the first word of the main and backup blocks and switches the palette word $7F0006 from $7FFF to $03FF while it runs, OQ-I024-5). Any slot 0-3 is stored in save_slot, loaded with lib_save_system.LoadGameFromSlot and the game warps: scene_next = 1 when the load reports carry (inferred: no valid save, a new game) or the word at $1B90 of the loaded save otherwise, with warp_dest_anim = 1 and the player at x $70, y $60.
---------------------------------------------

?BANK 00

?INCLUDE 'data_engine_tables'
?INCLUDE 'gv_title_texts'
?INCLUDE 'lib_0118FC_part2'
?INCLUDE 'lib_01232B'
?INCLUDE 'lib_save_system'
?INCLUDE 'lib_text_render'

!scene_next                     0318
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!save_slot                      03A4
!reload_menu_gfx                0454
!m7x_shadow                     046A
!m7y_shadow                     046C
!m7a_shadow                     046E
!m7b_shadow                     0470
!m7c_shadow                     0472
!m7d_shadow                     0474
!m7_matrix_a                    0476
!m7_matrix_b                    0478
!m7_matrix_c                    047A
!m7_matrix_d                    047C
!m7_angle                       047E
!m7_scale                       0480
!saved_scene                    1B90
!location_id                    1C6A
!M7A                            211B
!M7B                            211C
!M7C                            211D
!M7D                            211E
!M7X                            211F
!M7Y                            2120
!MPYL                           2134
!MPYM                           2135

---------------------------------------------

; NMI hook that drives the title screen's Mode 7 background.
; 
; When: every NMI (HandleVBlank, JSL after FlushVramWriteQueue), but only does work when location_id = $10.
; Sees: the zooming Mode 7 picture behind the title.
; Why: the background must change in vblank, the only time the PPU registers can be written safely.
; In: location_id, the Mode 7 variables ($046A-$0480).
; Out: BuildRotationMatrix, WriteMode7Matrix (previous frame's matrix to the PPU), then m7_matrix_a-d copied into the shadows.
; Clobbers: A, X, Y, dp$00-$02 (the NMI handler saves the registers).

UpdateTitleMode7 {
    LDA $location_id      ; Acts only while location_id = $10 (the title scene)
    CMP #$10
    BNE loc_006BA4
    JSR $&BuildRotationMatrix
    JSR $&WriteMode7Matrix ; The registers get the shadows of the previous NMI; the new matrix is copied into them below, so the PPU lags one frame
    LDX $m7_matrix_a
    STX $m7a_shadow
    LDX $m7_matrix_b
    STX $m7b_shadow
    LDX $m7_matrix_c
    STX $m7c_shadow
    LDX $m7_matrix_d
    STX $m7d_shadow

  loc_006BA4:
    RTL 
}

---------------------------------------------
; Unreferenced: runs BuildRotationMatrixAlt and falls through into WriteMode7Matrix (no RTS of its own). Probably an older title routine (OQ-I006-6).

RefreshTitleMatrixAlt {
    JSR $&BuildRotationMatrixAlt
}

---------------------------------------------
; Writes the Mode 7 shadows to the PPU.
; 
; When: once per NMI from UpdateTitleMode7 (and from RefreshTitleMatrixAlt).
; Sees: the title background takes the new matrix and centre.
; Why: M7A-M7D and M7X/M7Y are write-twice registers, so each value needs two stores.
; In: m7a_shadow-m7d_shadow ($046E-$0474), m7x_shadow, m7y_shadow. Out: M7A-M7D, M7X, M7Y written (low byte, then high byte). Clobbers: A (8-bit accesses, M = 16 saved by the caller).

WriteMode7Matrix {
    LDA $m7a_shadow
    STA $M7A
    LDA $046F             ; High byte of the shadow: M7A-M7D, M7X and M7Y are write-twice registers (low byte, then high byte)
    STA $M7A
    LDA $m7b_shadow
    STA $M7B
    LDA $0471
    STA $M7B
    LDA $m7c_shadow
    STA $M7C
    LDA $0473
    STA $M7C
    LDA $m7d_shadow
    STA $M7D
    LDA $0475
    STA $M7D
    LDA $m7x_shadow
    STA $M7X
    LDA $046B
    STA $M7X
    LDA $m7y_shadow
    STA $M7Y
    LDA $046D
    STA $M7Y
    RTS 
}

---------------------------------------------
; Computes the Mode 7 matrix from the angle and the scale.
; 
; When: every NMI in location $10, from UpdateTitleMode7.
; Sees: the title picture zooms (scale) and could rotate (angle, OQ-I024-4).
; Why: the PPU needs A, B, C, D = scale * (cos, sin, -sin, cos).
; In: m7_angle (8-bit table index), m7_scale (16-bit).
; Out: m7_matrix_a = scale * SineTableTail[angle], m7_matrix_b = scale * SineTable[angle], m7_matrix_c = scale * -SineTable[angle], m7_matrix_d = m7_matrix_a's formula again; each is the middle and high byte of the 24-bit product.
; Clobbers: A, X, Y, dp$00-$02; X and Y become 16-bit.

BuildRotationMatrix {
    SEP #$10
    LDX $m7_angle
    REP #$10
    LDY $m7_scale
    STY $00
    XBA 
    LDA $@data_engine_tables.SineTableTail, X ; SineTableTail = cosine table indexed by the angle; SineTable is the sine table, $40 entries (a quarter of 256) apart
    STA $02
    JSR $&Mode7Multiply16x8
    LDY $MPYM             ; MPYM: the middle and high bytes of the 24-bit product ($2135-$2136) = scale * table byte / 256
    STY $m7_matrix_a
    LDY $m7_scale
    STY $00
    XBA 
    LDA $@data_engine_tables.SineTable, X
    STA $02
    JSR $&Mode7Multiply16x8
    LDY $MPYM
    STY $m7_matrix_b
    LDY $m7_scale
    STY $00
    XBA 
    LDA $@data_engine_tables.SineTable, X
    EOR #$FF              ; Negate the sine byte: matrix C = -scale * sin
    INC 
    STA $02
    JSR $&Mode7Multiply16x8
    LDY $MPYM
    STY $m7_matrix_c
    LDY $m7_scale
    STY $00
    XBA 
    LDA $@data_engine_tables.SineTableTail, X
    STA $02
    JSR $&Mode7Multiply16x8
    LDY $MPYM
    STY $m7_matrix_d
    RTS 
}

---------------------------------------------
; Unreferenced alternative to BuildRotationMatrix: it scales (index/4 + $41) * 2 with the PPU multiplier into m7a_shadow and m7d_shadow, and builds the shadows B and C from the sine byte (C negated). Only RefreshTitleMatrixAlt calls it (OQ-I006-6).

BuildRotationMatrixAlt {
    REP #$20
    TXA 
    XBA 
    LSR 
    LSR 
    CLC 
    ADC #$0041
    ASL 
    PHA 
    SEP #$20
    STA $M7A
    XBA 
    STA $M7A
    LDA $@data_engine_tables.SineTableTail, X
    STA $M7B
    STA $M7B
    REP #$20
    LDA $MPYM
    STA $m7a_shadow
    STA $m7d_shadow
    PLA 
    SEP #$20
    STA $M7A
    XBA 
    STA $M7A
    LDA $@data_engine_tables.SineTable, X
    STA $M7B
    STA $M7B
    REP #$20
    LDA $MPYM
    STA $m7b_shadow
    EOR #$FFFF
    INC 
    STA $m7c_shadow
    SEP #$20
    RTS 
}

---------------------------------------------
; Multiplies a 16-bit value by a signed byte with the PPU multiplier.
; 
; When: four times per BuildRotationMatrix.
; Sees: nothing.
; Why: the SNES multiplier at MPYL/MPYM/MPYH is the cheapest 16x8 multiply.
; In: dp$00-$01 = 16-bit factor (written to M7A), dp$02 = signed byte (written twice to M7B).
; Out: dp$00/$01 = low and middle byte of the product; the caller reads MPYM:MPYH from the PPU.
; Clobbers: A; P preserved.

Mode7Multiply16x8 {
    PHP 
    SEP #$20
    LDA $00
    STA $M7A
    LDA $01
    STA $M7A
    LDA $02
    STA $M7B              ; The multiplier takes M7A (16-bit) times the last byte written to M7B (signed 8-bit)
    STA $M7B
    LDA $MPYL
    STA $00
    LDA $MPYM
    STA $01
    PLP 
    RTS 

; Opens the save-slot menu from the title.
; 
; When: BRL from gv_front_end when the player chooses to load.
; Sees: the list of saved games.
; Why: the menu is one actor step; the choice is handled one frame later.
; In: X = title actor. Out: lib_01232B.code_01232B, DrawSaveSlotMenu, then COP 1B continues at HandleFileSelectChoice after one frame.
; Clobbers: A, Y; X restored.

  EnterFileSelect:
    PHX 
    JSL $@lib_01232B.code_01232B
    JSR $&DrawSaveSlotMenu
    PLX 
    COP [1B] ( &HandleFileSelectChoice, #$0001 )
}

---------------------------------------------
; Reads the slot choice and starts the game from the chosen slot.
; 
; When: one frame after EnterFileSelect, and again after each pass of the second prompt.
; Sees: a cursor on the last used slot; picking a slot starts the game at the start position (x $70, y $60); the second prompt turns the palette word $7F0006 to $03FF.
; Why: slot loading and the second prompt are one routine so the menu can redraw between them.
; In: $701FFE = last slot. Out: save_slot = choice, lib_save_system.LoadGameFromSlot loads it, scene_next = 1 (carry: inferred new game) or the word $1B90, warp_dest_anim = 1, warp_dest_x = $70, warp_dest_y = $60, $0445 = 0, $0454 + 1, COP 91. Prompt answer 4 (probably erase, OQ-I024-5): the slot offset is written to the first word of the main and backup blocks and the menu is redrawn.
; Clobbers: A, X, Y; X restored (PHX/PLX).

HandleFileSelectChoice {
    PHX 
    LDA $701FFE           ; Last used slot (0-3, anything else becomes 0): the cursor starts there
    CMP #$0004
    BCC loc_006CDD
    LDA #$0000

  loc_006CDD:
    XBA 
    CLC 
    ADC #$0005
    BRA loc_006CE7

  loc_006CE4:
    LDA #$0005

  loc_006CE7:
    JSL $@lib_0118FC_part2.ChooseMenuRowAtTable ; Menu choice: carry set asks again from slot 0; an answer of 4 opens the second prompt (probably erase, OQ-I024-5)
    BCS loc_006CE4
    AND #$00FF
    CMP #$0004
    BNE loc_006D20
    LDA #$03FF
    STA $7F0006           ; $7F0006 = cgram_buffer + 6 (colour 3) = $03FF while the second prompt runs, $7FFF again afterwards
    LDA #$0004
    JSL $@lib_0118FC_part2.ChooseMenuRowAtTable
    BCS loc_006D14
    AND #$00FF
    XBA 
    ASL 
    ASL 
    TAX 
    STA $700000, X        ; Slot offset (slot x $400) stored over the first word of the slot and of its backup at +$1000
    STA $701000, X

  loc_006D14:
    LDA #$7FFF
    STA $7F0006
    JSR $&DrawSaveSlotMenu
    BRA loc_006CE4

  loc_006D20:
    STA $save_slot        ; Chosen slot 0-3
    JSL $@lib_save_system.LoadGameFromSlot ; Load the chosen slot (lib_save_system); carry set is treated below as 'no valid save' (inferred)
    PLX 
    LDA #$0001
    BCS loc_006D30        ; Carry set: scene_next = 1, else the word at $1B90 of the loaded save
    LDA $saved_scene

  loc_006D30:
    STA $scene_next
    LDA #$0001
    STA $warp_dest_anim
    LDA #$0070
    STA $warp_dest_x
    LDA #$0060
    STA $warp_dest_y
    STZ $0445
    INC $reload_menu_gfx
    COP [91]
    RTL 
}

---------------------------------------------
; Draws the save-slot menu and repairs the slots it finds damaged.
; 
; When: EnterFileSelect, and after the second prompt.
; Sees: up to four saved games with their summary line; empty or damaged slots do not appear.
; Why: the main block of each slot has a backup mirror (+$1000); opening the menu refreshes whichever is good.
; In: none. Out: slot text printed through lib_text_render.PrintTextString; main and backup blocks synchronised; $701FFE = 0 when no slot is valid; save_slot = 0.
; Clobbers: A, X, Y, dp$16, $18 and the callees' scratch.

DrawSaveSlotMenu {
    LDY #$&gv_title_texts.SaveSlotMenuText
    JSL $@lib_text_render.PrintTextString
    STZ $save_slot
    LDX #$0000
    LDY #$&gv_title_texts.SaveSlotLineTemplates
    LDA #$0000
    PHA 

  loc_006D62:
    JSL $@lib_save_system.ComputeSlotChecksum
    LDA $16
    CMP $7003FA, X        ; Checksum words at +$3FA and +$3FC of the slot block ($700000 + slot x $400); ComputeSlotChecksum left the computed sum in $16/$18
    BNE loc_006D8B
    LDA $18
    CMP $7003FC, X
    BNE loc_006D8B
    PHX 
    PHY 
    PHB 
    TXY 
    TYA 
    CLC 
    ADC #$1000
    TAY 
    LDA #$03FD
    MVN #$70, #$70        ; Main block is valid: copy $3FE bytes (A = $03FD) over the backup mirror at +$1000
    PLB 
    PLY 
    PLX 
    BRA loc_006DB2

  loc_006D8B:
    PHX 
    PHY 
    PHB 
    TXY 
    TXA 
    CLC 
    ADC #$1000
    TAX 
    LDA #$03FD
    MVN #$70, #$70        ; Main block failed its checksum: copy the backup mirror (+$1000) over it, then check again
    PLB 
    PLY 
    PLX 
    JSL $@lib_save_system.ComputeSlotChecksum
    LDA $16
    CMP $7003FA, X
    BNE loc_006E06
    LDA $18
    CMP $7003FC, X
    BNE loc_006E06

  loc_006DB2:
    PHY 
    PHX 
    TXA 
    SEC 
    SBC #$1A5E
    PHA 
    CLC 
    ADC #$1B92
    TAX 
    LDA $700200, X
    STA $0447
    LDA $700202, X
    STA $0449
    LDA $700204, X
    STA $044B
    LDA $700206, X
    STA $044D
    LDA $700207, X
    STA $044E
    LDA $01, S
    CLC 
    ADC #$1B6A
    TAX 
    LDA $700200, X
    STA $0450
    PLA 
    CLC 
    ADC #$1B90
    TAX 
    LDA $700200, X
    STA $0452
    JSL $@lib_text_render.PrintTextString
    PLX 
    PLY 
    PLA 
    INC 
    PHA 

  loc_006E06:
    INC $save_slot
    TXA 
    CLC 
    ADC #$0400
    TAX 
    TYA 
    CLC 
    ADC #$0014
    TAY 
    CPX #$1000            ; Four slots at $400 steps ($0000, $0400, $0800, $0C00)
    BEQ loc_006E1D
    BRL loc_006D62

  loc_006E1D:
    STZ $save_slot
    PLA 
    BNE loc_006E27
    STA $701FFE           ; No valid slot found: the last-used slot word is reset to 0

  loc_006E27:
    RTS 
}