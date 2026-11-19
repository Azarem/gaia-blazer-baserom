?BANK 00

?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_0029EC'
?INCLUDE 'engine_002EC0'
?INCLUDE 'engine_003005'
?INCLUDE 'engine_0065A7'
?INCLUDE 'engine_006B7F'
?INCLUDE 'lib_010000'
?INCLUDE 'lib_010069'
?INCLUDE 'lib_01010B'
?INCLUDE 'lib_01020E_part2'
?INCLUDE 'lib_0109D6'
?INCLUDE 'lib_0109D6_part3'
?INCLUDE 'lib_010EA9_part1'
?INCLUDE 'lib_010EEA'
?INCLUDE 'lib_011695'
?INCLUDE 'lib_01185E'
?INCLUDE 'lib_0118FC'
?INCLUDE 'lib_0118FC_part6'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_0133A6_part3'
?INCLUDE 'lib_013ADA'
?INCLUDE 'lib_027223'
?INCLUDE 'lib_027572'
?INCLUDE 'lib_027614'
?INCLUDE 'lib_027781_part2'
?INCLUDE 'lib_027912'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131B7'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'meta_tables_008000'
?INCLUDE 'table_0099B4'

!frame_counter                  0312
!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!joy_pressed                    0322
!joy_block_mask                 0326
!joy_release_latch              032A
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_pages                0343
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!scroll_bg3_x                   0386
!scroll_bg3_y                   0388
!player_actor                   039C
!tile_dma_pending               03B6
!vram_upload_flags              03B8
!vram_strip_src                 03DD
!vram_strip_dest                03DF
!vram_strip_pending             03E1
!transition_type                03E3
!return_active                  03FB
!return_area                    03FD
!return_scene                   03FF
!return_x                       0401
!return_y                       0403
!oam_buffer                     0486
!actor_list_tail                06A6
!actor_list_head                06A8
!tile_dma_list                  1A06
!player_hp                      1B88
!player_max_hp                  1B8A
!location_id                    1C6A
!vram_write_queue               1C7B
!OAMADDL                        2102
!BG1HOFS                        210D
!BG1VOFS                        210E
!BG3HOFS                        2111
!BG3VOFS                        2112
!VMADDL                         2116
!VMADDH                         2117
!VMDATAL                        2118
!CGADD                          2121
!COLDATA                        2132
!APUIO2                         2142
!MDMAEN                         420B
!HDMAEN                         420C
!HVBJOY                         4212
!JOY1L                          4218
!JOY2H                          421B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305
!DMAP1                          4310
!BBAD1                          4311
!A1T1L                          4312
!A1B1                           4314
!DAS1L                          4315
!DMAP2                          4320
!BBAD2                          4321
!A1T2L                          4322
!A1B2                           4324
!DAS2L                          4325
!coldata_buffer                 7F0200
!tile_type_map                  7F8000

---------------------------------------------

emulation_mode_reset_000000 {
    SEI 
    CLD 
    CLC 
    XCE 
    REP #$30
    LDA #$0000
    TCD 
    LDA #$1FFF
    TCS 
    SEP #$20
    LDA #$01
    PHA 
    PLB 
    JSL $@lib_0133A6_part3.code_0139AC
    JSL $@lib_013ADA.code_013ADA
    JSL $@lib_027912.code_027912
    JSL $@lib_027781_part2.code_0276EE
    LDX #$000C
    STX $scene_next
    JSL $@lib_0118FC_part8.code_0131A2
    JSL $@lib_027781_part2.code_027781

  loc_000032:
    JSL $@lib_shared_0131B7.code_0131B7
    JSL $@lib_027781_part2.code_027781
    LDA $location_id
    SEC 
    SBC #$10
    CMP #$03
    BCC loc_00008F
    LDA $return_active
    BNE loc_0000AA
    JSL $@lib_0118FC.code_0118FC
    JSL $@lib_027572.code_027572
    JSL $@lib_0118FC_part8.code_0131AE
    JSL $@lib_0109D6.code_0109D6
    JSL $@lib_01185E.code_01185E
    JSL $@code_0005A6
    JSL $@code_0005C4
    JSL $@code_000A34
    JSL $@code_000DF4
    JSL $@engine_003005.code_003005
    JSL $@lib_010069.code_010069
    JSL $@lib_01010B.code_01010B
    JSL $@code_0006EE
    JSL $@lib_0118FC_part6.code_012659
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.code_027223
    JSL $@lib_0118FC_part8.code_0131A2
    BRA loc_000032

  loc_00008F:
    JSL $@lib_0118FC_part8.code_0131AE
    JSL $@lib_01185E.code_01185E
    JSL $@code_0005A6
    JSL $@code_0005C4
    JSL $@code_0006EE
    JSL $@lib_0118FC_part8.code_0131A2
    BRL loc_000032

  loc_0000AA:
    JSL $@lib_0118FC_part8.code_0131AE
    JSL $@lib_010EA9_part1.code_010EA9
    JSL $@lib_01185E.code_01185E
    STZ $0323
    JSL $@code_0005A6
    JSL $@code_0005C4
    JSL $@code_0006EE
    JSL $@lib_0118FC_part6.code_012659
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.code_027223
    JSL $@lib_0118FC_part8.code_0131A2
    JSL $@lib_shared_0131B7.code_0131B7
    JSL $@lib_0118FC_part8.code_0131AE

  loc_0000DD:
    JSL $@code_0001BE
    LDX $return_active
    BMI loc_0000DD
    STZ $return_active
    STZ $03FC
    LDA $player_max_hp
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $043B
    STA $043B
    LDA #$78
    JSL $@lib_shared_012769.code_013140
    LDA #$80
    STA $transition_type
    LDA $return_area
    STA $area_next
    LDA $return_scene
    STA $scene_next
    REP #$20
    LDA $return_x
    STA $warp_dest_x
    LDA $return_y
    STA $warp_dest_y
    SEP #$20
    JSL $@lib_0118FC_part8.code_0131A2
    BRL loc_000032
}

code_000127 {
    PHB 
    PHA 
    XBA 
    PHA 
    PHX 
    PHY 
    JSL $@lib_0118FC_part8.code_0131AE
    INC $03A6
    JSL $@lib_01185E.code_01185E
    JSL $@code_0005A6
    JSL $@code_0005C4
    JSL $@lib_010000.code_010000
    JSL $@lib_010069.code_010069
    JSL $@lib_01010B.code_01010B
    JSL $@code_0006EE
    LDA $0462
    BNE loc_00015D
    JSL $@lib_0118FC_part6.code_012659
    JSL $@lib_011695.code_011695

  loc_00015D:
    JSL $@lib_027223.code_027223
    STZ $03A6
    JSL $@lib_0118FC_part8.code_0131A2
    JSL $@lib_shared_0131B7.code_0131B7
    PLY 
    PLX 
    PLA 
    XBA 
    PLA 
    PLB 
    RTL 
}

code_000173 {
    PHB 
    PHA 
    XBA 
    PHA 
    PHX 
    PHY 
    LDA #$01
    PHA 
    PLB 
    INC $03A6
    JSL $@lib_01185E.code_01185E
    JSL $@code_0005A6
    JSL $@code_0005C4
    JSL $@lib_010069.code_010069
    JSL $@lib_01010B.code_01010B
    JSL $@code_0006EE
    JSL $@lib_0118FC_part6.code_012659
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.code_027223
    JSL $@lib_010EEA.code_010EEA
    JSL $@lib_0118FC_part8.code_0131A2
    JSL $@lib_shared_0131B7.code_0131B7
    JSL $@lib_0118FC_part8.code_0131AE
    STZ $03A6
    PLY 
    PLX 
    PLA 
    XBA 
    PLA 
    PLB 
    RTL 
}

code_0001BE {
    PHB 
    PHA 
    XBA 
    PHA 
    PHX 
    PHY 
    LDA #$01
    PHA 
    PLB 
    INC $03A6
    JSL $@lib_01185E.code_01185E
    JSL $@code_0005A6
    JSL $@code_0005C4
    JSL $@lib_010069.code_010069
    JSL $@lib_01010B.code_01010B
    JSL $@code_0006EE
    JSL $@lib_0118FC_part6.code_012659
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.code_027223
    JSL $@lib_0118FC_part8.code_0131A2
    JSL $@lib_shared_0131B7.code_0131B7
    JSL $@lib_0118FC_part8.code_0131AE
    STZ $03A6
    PLY 
    PLX 
    PLA 
    XBA 
    PLA 
    PLB 
    RTL 
}
---------------------------------------------

code_000205 {
    LDA $JOY2H
    BIT #$20
    BEQ loc_000210
    JSR $&code_00022B
    RTS 

  loc_000210:
    LDA $JOY2H
    BIT #$80
    BEQ loc_000223
    LDA #$1E

  loc_000219:
    PHA 
    JSL $@lib_shared_0131B7.code_0131B7
    PLA 
    DEC 
    BNE loc_000219
    RTS 

  loc_000223:
    BIT #$40
    BEQ loc_00022A
    JSR $&code_000271

  loc_00022A:
    RTS 
}

code_00022B {
    LDA #$00
    JSR $&code_000240
    LDA #$03
    JSR $&code_000240
    LDA #$04
    JSR $&code_000240
    LDA #$1F
    JSR $&code_000240
    RTS 
}

code_000240 {
    PHB 
    PHA 
    PLB 
    LDX #$8000

  loc_000246:
    LDA $0000, X
    CMP #$02
    BNE loc_00026C
    LDA $0001, X
    CMP #$01
    BNE loc_00026C
    LDA $0002, X
    CMP #$AA
    BNE loc_00026C
    LDY $0003, X
    BPL loc_00026C
    PHX 
    LDX #$040A
    STX $03F3
    JSL $@lib_shared_012769.code_012C27
    PLX 

  loc_00026C:
    INX 
    BNE loc_000246
    PLB 
    RTS 
}

code_000271 {
    LDA $area_current
    JSR $&code_0002FC
    STA $1F06
    LDA $area_current
    JSR $&code_000300
    STA $1F07
    LDA $scene_current
    JSR $&code_0002FC
    STA $1F09
    LDA $scene_current
    JSR $&code_000300
    STA $1F0A
    LDA $location_id
    JSR $&code_0002FC
    STA $1F0C
    LDA $location_id
    JSR $&code_000300
    STA $1F0D
    LDA $player_tile_x
    JSR $&code_0002FC
    STA $1F0F
    LDA $player_tile_x
    JSR $&code_000300
    STA $1F10
    LDA $player_x
    JSR $&code_000300
    STA $1F12
    LDA $player_tile_y
    JSR $&code_0002FC
    STA $1F14
    LDA $player_tile_y
    JSR $&code_000300
    STA $1F15
    LDA $player_y
    JSR $&code_000300
    STA $1F17
    LDA $1F00
    JSR $&code_0002FC
    STA $1F19
    LDA $1F00
    JSR $&code_000300
    STA $1F1A
    LDY #$1F02
    JSL $@lib_shared_012769.code_012769
    LDA #$01
    STA $vram_upload_flags
    RTS 
}

code_0002FC {
    LSR 
    LSR 
    LSR 
    LSR 
}

code_000300 {
    REP #$20
    AND #$000F
    TAX 
    LDA $@binary_00030D, X
    SEP #$20
    RTS 
}
---------------------------------------------

binary_00030D #30313233343536373839414243444546
---------------------------------------------

code_00031D {
    LDA $0484
    BNE loc_000323
    RTS 

  loc_000323:
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    XBA 
    LDA #$0A
    JSL $@lib_shared_0131D1.code_0131D1
    PHA 
    LDA $0484
    AND #$0F
    CLC 
    ADC $01, S
    JSL $@lib_0109D6_part3.code_0120F9
    PLA 
    STZ $0484
    RTS 
}
---------------------------------------------

native_mode_nmi_000342 {
    PHP 
    PHB 
    REP #$30
    PHA 
    PHX 
    PHY 
    SEP #$20
    REP #$10
    CLD 
    LDA #$01
    PHA 
    PLB 
    STZ $HDMAEN
    JSR $&code_0003C5
    JSR $&code_0003EA
    JSR $&code_000421
    JSR $&code_00046E
    JSR $&code_0004C8
    JSR $&code_0004E5
    JSR $&code_000543
    JSR $&code_00058B
    JSL $@engine_006B7F.code_006B7F

  loc_000371:
    LDA $HVBJOY
    ROR 
    BCS loc_000371
    LDA $42
    STA $HDMAEN
    REP #$30
    INC $frame_counter
    LDA $0468
    BNE loc_0003AA
    LDA $JOY1L
    XBA 
    LSR 
    AND #$2000
    ORA $JOY1L
    PHA 
    LDA $joy_block_mask
    EOR #$FFFF
    AND $01, S
    STA $joy_pressed
    PLA 
    EOR #$FFFF
    ORA $joy_release_latch
    STA $joy_release_latch
    AND $joy_pressed

  loc_0003AA:
    STA $joy_pressed
    LDA $frame_counter
    LSR 
    LDA #$0000
    BCS loc_0003BC
    LDA $0398
    STZ $0398

  loc_0003BC:
    STA $APUIO2
    PLY 
    PLX 
    PLA 
    PLB 
    PLP 
    RTI 
}

code_0003C5 {
    LDX #$0000
    STX $OAMADDL
    STZ $DMAP0
    LDA #$04
    STA $BBAD0
    LDX #$0486
    STX $A1T0L
    LDA #$00
    STA $A1B0
    LDX #$0220
    STX $DAS0L
    LDA #$01
    STA $MDMAEN
    RTS 
}

code_0003EA {
    STZ $CGADD
    STZ $DMAP1
    LDA #$22
    STA $BBAD1
    LDX #$0000
    STX $A1T1L
    LDA #$7F
    STA $A1B1
    LDX #$0200
    STX $DAS1L
    LDA #$02
    STA $MDMAEN
    LDA $coldata_buffer
    STA $COLDATA
    LDA $7F0201
    STA $COLDATA
    LDA $7F0202
    STA $COLDATA
    RTS 
}

code_000421 {
    LDA $1C7C
    BEQ loc_000427
    RTS 

  loc_000427:
    LDA $vram_upload_flags
    BNE loc_00042D
    RTS 

  loc_00042D:
    BIT #$02
    BNE loc_000442
    LDX #$5800
    STX $VMADDL
    LDX #$7000
    STX $A1T2L
    STZ $vram_upload_flags
    BRA loc_000453

  loc_000442:
    LDX #$5C00
    STX $VMADDL
    LDX #$7800
    STX $A1T2L
    LDA #$02
    TRB $vram_upload_flags

  loc_000453:
    LDA #$01
    STA $DMAP2
    LDA #$18
    STA $BBAD2
    LDA #$7F
    STA $A1B2
    LDX #$0800
    STX $DAS2L
    LDA #$04
    STA $MDMAEN
    RTS 
}

code_00046E {
    LDA $scroll_bg3_x
    STA $BG3HOFS
    STZ $BG3HOFS
    LDA $scroll_bg3_y
    STA $BG3VOFS
    STZ $BG3VOFS
    LDA $03DB
    BNE loc_000498
    LDX #$0000
    LDY #$0000
    JSR $&code_0004AB
    LDX #$0004
    LDY #$0002
    JSR $&code_0004AB
    RTS 

  loc_000498:
    LDX #$0004
    LDY #$0000
    JSR $&code_0004AB
    LDX #$0000
    LDY #$0002
    JSR $&code_0004AB
    RTS 
}

code_0004AB {
    LDA $scroll_bg1_x, X
    STA $BG1HOFS, Y
    LDA $033B, X
    AND #$03
    STA $BG1HOFS, Y
    LDA $scroll_bg1_y, X
    STA $BG1VOFS, Y
    LDA $033D, X
    AND #$03
    STA $BG1VOFS, Y
    RTS 
}

code_0004C8 {
    LDX #$3000
    STX $32
    LDX #$3102
    STX $35
    JSL $@lib_01020E_part2.code_01057D
    LDX #$3204
    STX $32
    LDX #$3306
    STX $35
    JSL $@lib_01020E_part2.code_01057D
    RTS 
}

code_0004E5 {
    LDA $tile_dma_pending
    BNE loc_0004EB
    RTS 

  loc_0004EB:
    LDA #$18
    STA $BBAD2
    LDA #$01
    STA $DMAP2
    LDY #$0000
    LDX #$2000
    STX $VMADDL
    JSR $&code_000524
    LDX #$0000

  loc_000504:
    LDY $tile_dma_list, X
    BEQ loc_000514
    INC $1A07, X
    INC $1A07, X
    INX 
    INX 
    INX 
    BRA loc_000504

  loc_000514:
    LDY #$0000
    LDX #$2100
    STX $VMADDL
    JSR $&code_000524
    STZ $tile_dma_pending
    RTS 
}

code_000524 {
    LDX $tile_dma_list, Y
    BEQ loc_000542
    STX $A1T2L
    LDA $1A08, Y
    STA $A1B2
    LDX #$0040
    STX $DAS2L
    LDA #$04
    STA $MDMAEN
    INY 
    INY 
    INY 
    BRA code_000524

  loc_000542:
    RTS 
}

code_000543 {
    LDA $vram_strip_pending
    BNE loc_000549
    RTS 

  loc_000549:
    LDA #$01
    STA $DMAP2
    LDA #$18
    STA $BBAD2
    LDX $vram_strip_src
    STX $A1T2L
    LDA #$7F
    STA $A1B2
    LDX #$0040
    STX $DAS2L
    LDX $vram_strip_dest
    STX $VMADDL
    LDA #$04
    STA $MDMAEN
    LDX #$0040
    STX $DAS2L
    LDA $vram_strip_dest
    STA $VMADDL
    LDA $03E0
    INC 
    STA $VMADDH
    LDA #$04
    STA $MDMAEN
    STZ $vram_strip_pending
    RTS 
}

code_00058B {
    REP #$20
    TSX 
    LDA #$1C7A
    TCS 

  loc_000592:
    PLA 
    BEQ loc_00059E
    STA $VMADDL
    PLA 
    STA $VMDATAL
    BRA loc_000592

  loc_00059E:
    TXS 
    STZ $vram_write_queue
    SEP #$20
    RTS 
}
---------------------------------------------

native_mode_irq_0005A5 {
    RTI 
}

code_0005A6 {
    PHP 
    PHB 
    PEI ($38)
    PEI ($39)
    REP #$20
    STZ $1F00
    LDA $actor_list_tail
    PEA $&code_0005BB-1
    PEA $&code_0009BF-1
    RTS 
}

code_0005BB {
    PLX 
    STX $39
    PLX 
    STX $38
    PLB 
    PLP 
    RTL 
}

code_0005C4 {
    PHP 
    REP #$20
    LDA $actor_list_head
    LDY #$0000

  loc_0005CD:
    TAX 
    BNE loc_0005D3
    BRL loc_00067A

  loc_0005D3:
    LDA $0000, X
    SEC 
    SBC $0008, X
    SEC 
    SBC $scroll_bg1_x
    CMP #$0100
    BCC loc_0005F8
    BMI loc_0005E8
    BRL loc_00066B

  loc_0005E8:
    LDA $0000, X
    CLC 
    ADC $000C, X
    SEC 
    SBC $scroll_bg1_x
    CMP #$0100
    BCS loc_00066B

  loc_0005F8:
    LDA $0002, X
    SEC 
    SBC $000A, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$00E0
    BCC loc_00061A
    BPL loc_00066B
    LDA $0002, X
    CLC 
    ADC $000E, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$00E0
    BCS loc_00066B

  loc_00061A:
    LDA $0016, X
    BIT #$2000
    BNE loc_00065C
    LDA $001A, X
    BIT #$0080
    BNE loc_00065C
    BIT #$6000
    BEQ loc_000639
    BIT #$4000
    BNE loc_000645
    LDA #$01FE
    BRA loc_00064C

  loc_000639:
    LDA $0002, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$0100
    BCC loc_000648

  loc_000645:
    LDA #$00FF

  loc_000648:
    EOR #$00FF
    ASL 

  loc_00064C:
    CMP #$0200
    BCS loc_00064C
    STA $1900, Y
    TXA 
    STA $1902, Y
    INY 
    INY 
    INY 
    INY 

  loc_00065C:
    LDA $0016, X
    AND #$7FFF
    STA $0016, X
    LDA $003C, X
    BRL loc_0005CD

  loc_00066B:
    LDA $0016, X
    ORA #$8000
    STA $0016, X
    LDA $003C, X
    BRL loc_0005CD

  loc_00067A:
    LDA #$FFFF
    STA $1900, Y
    LDA #$0486
    STA $02
    TSC 
    STA $00
    LDA #$18FF
    TCS 

  loc_00068C:
    PLX 
    BMI loc_0006C6
    LDY $0100, X
    BNE loc_0006AE
    LDA $02
    STA $0100, X
    TAY 
    PLA 
    STA $0000, Y
    LDA #$0000
    STA $0002, Y
    LDA $02
    CLC 
    ADC #$0004
    STA $02
    BRA loc_00068C

  loc_0006AE:
    LDA $02
    STA $0100, X
    TAX 
    PLA 
    STA $0000, X
    TYA 
    STA $0002, X
    LDA $02
    CLC 
    ADC #$0004
    STA $02
    BRA loc_00068C

  loc_0006C6:
    LDA #$00FF
    TCS 
    LDX #$0000
    BRA loc_0006D1

  loc_0006CF:
    PHA 
    PLA 

  loc_0006D1:
    PLY 
    BEQ loc_0006D1
    BMI loc_0006E6

  loc_0006D6:
    LDA $0000, Y
    STA $1900, X
    INX 
    INX 
    LDA $0002, Y
    BEQ loc_0006CF
    TAY 
    BRA loc_0006D6

  loc_0006E6:
    STZ $1900, X
    LDA $00
    TCS 
    PLP 
    RTL 
}

code_0006EE {
    PHB 
    PHP 
    SEP #$20
    REP #$30
    LDA #$1A06
    STA $04
    STZ $tile_dma_list
    STZ $02
    LDA $scroll_bg1_x
    SEC 
    SBC #$0010
    STA $52
    LDA $scroll_bg1_y
    SEC 
    SBC #$0010
    STA $54
    LDA #$0686
    STA $4C
    LDA #$0004
    STA $4E
    TSC 
    STA $00
    LDA #$0685
    TCS 
    LDX #$0010
    LDA #$E080

  loc_000727:
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    DEX 
    BNE loc_000727
    LDA $00
    TCS 
    LDX #$0000
    TXY 

  loc_000741:
    LDA $1900, X
    BEQ loc_000752
    INX 
    INX 
    PHX 
    TAX 
    JSR $&code_000761
    PLX 
    BCS loc_00075E
    BRA loc_000741

  loc_000752:
    SEP #$20
    LDA $00

  loc_000756:
    LSR 
    LSR 
    DEC $4E
    BNE loc_000756
    STA ($4C)

  loc_00075E:
    PLP 
    PLB 
    RTL 
}

code_000761 {
    PHB 
    PHX 
    SEP #$20
    LDA $0024, X
    PHA 
    PLB 
    REP #$20
    LDA $0000, X
    SEC 
    SBC $0008, X
    SEC 
    SBC $52
    STA $16
    LDA $0002, X
    SEC 
    SBC $000A, X
    SEC 
    SBC $54
    STA $18
    LDA $001C, X
    STA $50
    STZ $06
    LDA $0016, X
    BIT #$0800
    BEQ loc_0007A6
    LDA $0026, X
    BMI loc_00079E
    LSR 
    BCS loc_0007A6
    BRL loc_000827

  loc_00079E:
    LSR 
    BCS loc_0007A6
    LDA #$0E00
    STA $06

  loc_0007A6:
    LDA $001A, X
    BPL loc_0007AE
    BRL loc_000832

  loc_0007AE:
    LDA $0028, X
    TAX 
    LDA $0000, X
    INX 
    INX 
    STA $0C

  loc_0007B9:
    LDA $50
    ASL 
    LDA $0003, X
    BCC loc_0007C2
    XBA 

  loc_0007C2:
    AND #$00FF
    CLC 
    ADC $18
    CMP #$00F0
    BCS loc_00082A
    SBC #$0010
    STA $0487, Y
    LDA $0005, X
    EOR $50
    ORA $06
    STA $0488, Y
    LDA $50
    ASL 
    ASL 
    LDA $0001, X
    BCC loc_0007E7
    XBA 

  loc_0007E7:
    AND #$00FF
    CLC 
    ADC $16
    CMP #$0110
    BCS loc_00082A
    SBC #$000F
    SEP #$20
    STA $oam_buffer, Y
    XBA 
    LSR 
    ROR $00
    LDA $0000, X
    LSR 
    ROR $00
    DEC $4E
    BNE loc_000812
    LDA $00
    STA ($4C)
    INC $4C
    LDA #$04
    STA $4E

  loc_000812:
    REP #$20
    INY 
    INY 
    INY 
    INY 
    CPY #$0200
    BEQ loc_000827

  loc_00081D:
    TXA 
    CLC 
    ADC #$0007
    TAX 
    DEC $0C
    BNE loc_0007B9

  loc_000827:
    PLX 
    PLB 
    RTS 

  loc_00082A:
    LDA #$E080
    STA $oam_buffer, Y
    BRA loc_00081D

  loc_000832:
    LDA $0034, X
    STA $1A02
    LDA $002C, X
    STA $1A04
    LDA $0028, X
    TAX 
    LDA $0000, X
    INX 
    INX 
    STA $0C
    INC $tile_dma_pending

  loc_00084C:
    LDA $50
    ASL 
    LDA $0003, X
    BCC loc_000855
    XBA 

  loc_000855:
    AND #$00FF
    CLC 
    ADC $18
    CMP #$00F0
    BCC loc_000863
    BRL loc_0008EB

  loc_000863:
    SBC #$0010
    STA $0487, Y
    LDA $0005, X
    EOR $50
    ORA $06
    PHA 
    AND #$01FF
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    ADC $1A02
    STA ($04)
    INC $04
    INC $04
    LDA $1A04
    STA ($04)
    INC $04
    PLA 
    AND #$FE00
    ORA $02
    INC $02
    INC $02
    STA $0488, Y
    LDA $50
    ASL 
    ASL 
    LDA $0001, X
    BCC loc_0008A0
    XBA 

  loc_0008A0:
    AND #$00FF
    CLC 
    ADC $16
    CMP #$0110
    BCS loc_0008EB
    SBC #$000F
    SEP #$20
    STA $oam_buffer, Y
    XBA 
    LSR 
    ROR $00
    LDA $0000, X
    LSR 
    ROR $00
    DEC $4E
    BNE loc_0008CB
    LDA $00
    STA ($4C)
    INC $4C
    LDA #$04
    STA $4E

  loc_0008CB:
    REP #$20
    INY 
    INY 
    INY 
    INY 
    CPY #$0200
    BEQ loc_0008E3

  loc_0008D6:
    TXA 
    CLC 
    ADC #$0007
    TAX 
    DEC $0C
    BEQ loc_0008E3
    BRL loc_00084C

  loc_0008E3:
    LDA #$0000
    STA ($04)
    PLX 
    PLB 
    RTS 

  loc_0008EB:
    LDA #$E080
    STA $oam_buffer, Y
    BRA loc_0008D6
}

code_0008F3 {
    PHB 
    SEP #$20
    LDA $0024, X
    PHA 
    PLB 
    REP #$20
    LDA $001E, X
    ASL 
    CLC 
    ADC $0022, X
    TAY 
    LDA $0020, X
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $0000, Y
    TAY 
    LDA $0000, Y
    BPL loc_000919
    BRL loc_0009B0

  loc_000919:
    STA $0014, X
    LDA $001C, X
    ROL 
    BPL loc_00092B
    LDA #$0000
    SEC 
    SBC $0002, Y
    BRA loc_00092E

  loc_00092B:
    LDA $0002, Y

  loc_00092E:
    STA $0004, X
    LDA $001C, X
    BPL loc_00093F
    LDA #$0000
    SEC 
    SBC $0004, Y
    BRA loc_000942

  loc_00093F:
    LDA $0004, Y

  loc_000942:
    STA $0006, X
    LDA $0006, Y
    TAY 
    CLC 
    ADC #$000C
    STA $0028, X
    LDA $001C, X
    ROL 
    PHP 
    BPL loc_00096D
    LDA $0002, Y
    SEC 
    SBC $0008, Y
    STA $0008, X
    LDA $0000, Y
    CLC 
    ADC $0008, Y
    STA $000C, X
    BRA loc_000979

  loc_00096D:
    LDA $0000, Y
    STA $0008, X
    LDA $0002, Y
    STA $000C, X

  loc_000979:
    PLP 
    BCC loc_000992
    LDA $0006, Y
    CLC 
    ADC $000A, Y
    STA $000A, X
    LDA $0004, Y
    SEC 
    SBC $000A, Y
    STA $000E, X
    BRA loc_00099E

  loc_000992:
    LDA $0004, Y
    STA $000A, X
    LDA $0006, Y
    STA $000E, X

  loc_00099E:
    LDA $0008, Y
    STA $0010, X
    LDA $000A, Y
    STA $0012, X
    INC $0020, X
    CLC 
    PLB 
    RTL 

  loc_0009B0:
    STZ $0020, X
    STZ $0004, X
    STZ $0006, X
    SEC 
    PLB 
    RTL 
}

code_0009BC {
    LDA $003E, X
}

code_0009BF {
    TAX 
    BEQ loc_000A33
    INC $1F00
    LDA $0016, X
    BIT #$0800
    BEQ loc_0009F9
    LDA $0026, X
    BPL loc_0009E1
    INC $0026, X
    BPL loc_0009F0
    LDA $001A, X
    BIT #$0040
    BEQ loc_0009F9
    BRA code_0009BC

  loc_0009E1:
    DEC $0026, X
    BEQ loc_0009F0
    LDA $001A, X
    BIT #$0040
    BEQ loc_0009F9
    BRA code_0009BC

  loc_0009F0:
    LDA $0016, X
    AND #$F7FF
    STA $0016, X

  loc_0009F9:
    LDA $03A6
    BEQ loc_000A06
    LDA $0016, X
    BIT #$0010
    BEQ code_0009BC

  loc_000A06:
    DEC $0014, X
    BPL code_000A22
    STZ $0014, X
    SEP #$20
    LDA #$00
    PHA 
    PEA $&code_000A22-1
    LDA $0036, X
    PHA 
    REP #$20
    LDA $0018, X
    DEC 
    PHA 
    RTL 
}

code_000A22 {
    LDA $0016, X
    BIT #$1000
    BEQ loc_000A2E
    JSL $@code_000F28

  loc_000A2E:
    JSR $&code_00129A
    BRA code_0009BC

  loc_000A33:
    RTS 
}

code_000A34 {
    PHP 
    PHB 
    REP #$20
    LDX $player_actor
    LDA $0016, X
    BIT #$0400
    BEQ loc_000A46
    BRL loc_000AEF

  loc_000A46:
    LDX #$0000

  loc_000A49:
    LDY $1900, X
    BNE loc_000A51
    BRL loc_000AEF

  loc_000A51:
    INX 
    INX 
    LDA $0016, Y
    BIT #$0080
    BEQ loc_000A49
    BIT #$0D00
    BNE loc_000A49
    PHX 
    SEP #$20
    LDA $0024, Y
    PHA 
    PLB 
    REP #$20
    LDX #$0000
    STY $3E

  loc_000A6F:
    LDY $3E
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    STA $00
    LDA $0002, Y
    CLC 
    ADC $000E, Y
    STA $02
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    STA $04
    LDA $0000, Y
    CLC 
    ADC $000C, Y
    STA $06

  loc_000A95:
    LDY $1900, X
    BEQ loc_000AEB
    INX 
    INX 
    LDA $0016, Y
    BIT #$EEC0
    BNE loc_000A95
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    CMP $06
    BCS loc_000A95
    LDA $0000, Y
    CLC 
    ADC $000C, Y
    CMP $04
    BCC loc_000A95
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    CMP $02
    BCS loc_000A95
    LDA $0002, Y
    CLC 
    ADC $000E, Y
    CMP $00
    BCC loc_000A95
    JSR $&code_000D55
    BCC loc_000A6F
    PHX 
    LDX $3E
    LDA $0016, X
    BIT #$0020
    BNE loc_000AE5
    JSR $&code_000AF2
    BRA loc_000AE8

  loc_000AE5:
    JSR $&code_000C67

  loc_000AE8:
    PLX 
    BRA loc_000A6F

  loc_000AEB:
    PLX 
    BRL loc_000A49

  loc_000AEF:
    PLB 
    PLP 
    RTL 
}

code_000AF2 {
    LDX $player_actor
    LDA $001E, X
    CMP #$0024
    BCC loc_000AFE
    RTS 

  loc_000AFE:
    LDA $0016, Y
    BIT #$0002
    BEQ loc_000B09

  loc_000B06:
    BRK #$4C
    RTS 

  loc_000B09:
    LDA $1B5E
    CMP #$0008
    BEQ loc_000B62
    LDA $1B5E
    CMP #$0002
    BNE loc_000B3E
    CPY $039A
    BEQ loc_000B3E
    LDA $001A, Y
    BIT #$0E00
    BEQ loc_000B62
    LDA $001A, Y
    ORA #$0040
    STA $001A, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    LDA #$00B4
    STA $0026, Y

  loc_000B3E:
    LDA $001A, Y
    BIT #$0800
    BNE loc_000B51
    BIT #$0400
    BNE loc_000B5A
    BIT #$0200
    BEQ loc_000B62
    RTS 

  loc_000B51:
    LDA $1B5E
    CMP #$0006
    BEQ loc_000B62
    RTS 

  loc_000B5A:
    LDA $1B5E
    CMP #$0005
    BNE loc_000B06

  loc_000B62:
    LDA $1B5E
    CMP #$0003
    BNE loc_000B77
    CPY $039A
    BEQ loc_000B77
    LDA $frame_counter
    AND #$000F
    BEQ loc_000BE7

  loc_000B77:
    SEP #$20
    LDX $0038, Y
    LDA $@meta_tables_008000+1, X
    STA $00
    LDA $1B8C
    SEC 
    SBC $00
    BEQ loc_000B8C
    BCS loc_000B8E

  loc_000B8C:
    LDA #$01

  loc_000B8E:
    STA $00
    LDA $1B64
    CMP #$37
    BEQ loc_000B9B
    CMP #$35
    BNE loc_000B9D

  loc_000B9B:
    ASL $00

  loc_000B9D:
    LDA $0025, Y
    SEC 
    SBC $00
    BCC loc_000BE7
    BEQ loc_000BE7

  loc_000BA7:
    STA $0025, Y
    REP #$20
    CPY $039A
    BEQ loc_000BC0
    LDX $player_actor
    LDA $001E, X
    SEC 
    SBC #$0020
    CMP #$0004
    BCC loc_000BCB

  loc_000BC0:
    LDA $001A, Y
    AND #$FFBF
    STA $001A, Y
    BRA loc_000BD4

  loc_000BCB:
    LDA $001A, Y
    ORA #$0040
    STA $001A, Y

  loc_000BD4:
    LDA #$FFF8
    STA $0026, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    BRK #$42
    BRA loc_000C44

  loc_000BE7:
    REP #$20
    LDA $001A, Y
    BIT #$0100
    SEP #$20
    BEQ loc_000BF7
    LDA #$01
    BRA loc_000BA7

  loc_000BF7:
    LDA #$^engine_0029EC.code_002A10
    STA $0036, Y
    LDA #$00
    STA $0025, Y
    REP #$20
    LDA #$&engine_0029EC.code_002A10
    STA $0018, Y
    LDA #$0000
    STA $0014, Y
    LDA $0016, Y
    ORA #$0400
    STA $0016, Y
    LDX $0038, Y
    LDA $@meta_tables_008000+3, X
    JSL $@lib_027614.code_027687
    LDA #$0002
    TSB $0332
    LDA $1B5E
    CMP #$0007
    BNE loc_000C42
    LDA $player_hp
    CMP $player_max_hp
    BEQ loc_000C42
    INC $player_hp
    LDA #$0004
    TSB $0332

  loc_000C42:
    BRK #$43

  loc_000C44:
    LDA $0016, Y
    BIT #$0001
    BEQ loc_000C4D
    RTS 

  loc_000C4D:
    SEP #$20
    LDA $0025, Y
    STA $0336
    LDX $0038, Y
    LDA $@meta_tables_008000+2, X
    STA $0338
    LDA #$80
    STA $0330
    REP #$20
    RTS 
}

code_000C67 {
    LDA $0016, Y
    BIT #$0002
    BEQ loc_000C72

  loc_000C6F:
    BRK #$4C
    RTS 

  loc_000C72:
    LDA $0030, X
    CMP #$00FF
    BEQ loc_000C95
    LDA $1B62
    CMP #$0018
    BEQ loc_000CA4
    CPY $039A
    BEQ loc_000C6F
    LDA $001A, Y
    BIT #$0A00
    BEQ loc_000C90
    RTS 

  loc_000C90:
    BIT #$0400
    BNE loc_000C6F

  loc_000C95:
    SEP #$20
    LDA $0025, Y
    SEC 
    SBC $0030, X
    BCC loc_000CEC
    BEQ loc_000CEC
    BRA loc_000CCB

  loc_000CA4:
    SEP #$20
    LDX $0038, Y
    LDA $@meta_tables_008000+1, X
    STA $00
    LDA $1B70
    CLC 
    ADC $1B72
    SEC 
    SBC $00
    BEQ loc_000CBD
    BCS loc_000CBF

  loc_000CBD:
    LDA #$01

  loc_000CBF:
    STA $00
    LDA $0025, Y
    SEC 
    SBC $00
    BCC loc_000CEC
    BEQ loc_000CEC

  loc_000CCB:
    STA $0025, Y
    REP #$20
    LDA #$FFF8
    STA $0026, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    LDA $001A, Y
    AND #$FFBF
    STA $001A, Y
    BRK #$42
    BRA loc_000D32

  loc_000CEC:
    REP #$20
    LDA $001A, Y
    BIT #$0100
    SEP #$20
    BEQ loc_000CFC
    LDA #$01
    BRA loc_000CCB

  loc_000CFC:
    SEP #$20
    LDA #$^engine_0029EC.code_002A10
    STA $0036, Y
    LDA #$00
    STA $0025, Y
    REP #$20
    LDA #$&engine_0029EC.code_002A10
    STA $0018, Y
    LDA #$0000
    STA $0014, Y
    LDA $0016, Y
    ORA #$0400
    STA $0016, Y
    LDX $0038, Y
    LDA $@meta_tables_008000+3, X
    JSL $@lib_027614.code_027687
    LDA #$0002
    TSB $0332
    BRK #$43

  loc_000D32:
    LDA $0016, Y
    BIT #$0001
    BEQ loc_000D3B
    RTS 

  loc_000D3B:
    SEP #$20
    LDA $0025, Y
    STA $0336
    LDX $0038, Y
    LDA $@meta_tables_008000+2, X
    STA $0338
    LDA #$80
    STA $0330
    REP #$20
    RTS 
}

code_000D55 {
    PHX 
    PHY 
    TYX 
    LDY $3E
    LDA $0002, X
    SEC 
    SBC $000A, X
    STA $00
    LDA $0002, X
    CLC 
    ADC $000E, X
    STA $02
    LDA $0000, X
    SEC 
    SBC $0008, X
    STA $04
    LDA $0000, X
    CLC 
    ADC $000C, X
    STA $06
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    STA $08
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    STA $0A
    LDX $0028, Y
    LDA $0000, X
    STA $0C
    INX 
    INX 

  loc_000D9A:
    LDA $0000, X
    LSR 
    BCC loc_000DA5
    LDA #$000F
    BRA loc_000DA8

  loc_000DA5:
    LDA #$0007

  loc_000DA8:
    PHA 
    LDA $001C, Y
    ASL 
    ASL 
    LDA $0001, X
    BCC loc_000DB4
    XBA 

  loc_000DB4:
    AND #$00FF
    CLC 
    ADC $08
    CMP $06
    BCS loc_000DE5
    CLC 
    ADC $01, S
    CMP $04
    BCC loc_000DE5
    LDA $001C, Y
    ASL 
    LDA $0003, X
    BCC loc_000DCF
    XBA 

  loc_000DCF:
    AND #$00FF
    CLC 
    ADC $0A
    CMP $02
    BCS loc_000DE5
    CLC 
    ADC $01, S
    CMP $00
    BCC loc_000DE5
    PLA 
    PLY 
    PLX 
    SEC 
    RTS 

  loc_000DE5:
    PLA 
    TXA 
    CLC 
    ADC #$0007
    TAX 
    DEC $0C
    BNE loc_000D9A
    PLY 
    PLX 
    CLC 
    RTS 
}

code_000DF4 {
    PHP 
    REP #$30
    LDA $042D
    BNE loc_000E5F
    LDY $player_actor
    LDA $0000, Y
    CLC 
    ADC #$0005
    STA $16
    CLC 
    ADC #$0007
    STA $1A
    LDA $0002, Y
    SEC 
    SBC #$0004
    STA $1C
    SEC 
    SBC #$0008
    STA $18
    LDA $0016, Y
    BIT #$0400
    BNE loc_000E5F
    BIT #$0800
    BNE loc_000E61
    LDY #$0000

  loc_000E2D:
    LDX $1900, Y
    BEQ loc_000E5F
    INY 
    INY 
    LDA $0016, X
    BIT #$25C0
    BNE loc_000E2D
    LDA $0000, X
    CMP $1A
    BCS loc_000E2D
    CLC 
    ADC $0010, X
    CMP $16
    BCC loc_000E2D
    LDA $0002, X
    CMP $18
    BCC loc_000E2D
    SEC 
    SBC $0012, X
    CMP $1C
    BCS loc_000E2D
    JSR $&code_000E9D
    BCS loc_000E2D

  loc_000E5F:
    PLP 
    RTL 

  loc_000E61:
    LDY #$0000

  loc_000E64:
    LDX $1900, Y
    BEQ loc_000E9B
    INY 
    INY 
    LDA $0016, X
    BIT #$25C0
    BNE loc_000E64
    BIT #$4000
    BEQ loc_000E64
    LDA $0000, X
    CMP $1A
    BCS loc_000E64
    CLC 
    ADC $0010, X
    CMP $16
    BCC loc_000E64
    LDA $0002, X
    CMP $18
    BCC loc_000E64
    SEC 
    SBC $0012, X
    CMP $1C
    BCS loc_000E64
    JSR $&code_000E9D
    BCS loc_000E64

  loc_000E9B:
    PLP 
    RTL 
}

code_000E9D {
    LDA $0016, X
    BIT #$4000
    BNE loc_000F22
    LDA $1B60
    CMP #$000E
    BNE loc_000EC3
    SEP #$20
    LDY $0038, X
    LDA $&meta_tables_008000, Y
    LSR 
    CLC 
    ADC $&meta_tables_008000, Y
    CMP $1B8E
    BCS loc_000EC3
    BRK #$0C
    BRA loc_000F20

  loc_000EC3:
    SEP #$20
    LDY $0038, X
    LDA $&meta_tables_008000, Y
    DEC 
    SEC 
    SBC $1B8E
    BCS loc_000ED4
    LDA #$00

  loc_000ED4:
    STA $00
    LDA $1B64
    CMP #$37
    BEQ loc_000EE1
    CMP #$36
    BNE loc_000EE3

  loc_000EE1:
    LSR $00

  loc_000EE3:
    LDA $00
    BNE loc_000EE8
    INC 

  loc_000EE8:
    PHA 
    LDA $player_hp
    SEC 
    SBC $01, S
    BPL loc_000EF3
    LDA #$00

  loc_000EF3:
    STA $player_hp
    PLA 
    REP #$20
    LDA #$0004
    TSB $0332
    LDX $player_actor
    LDA $1B60
    CMP #$000D
    BNE loc_000F0F
    LDA #$FFC0
    BRA loc_000F12

  loc_000F0F:
    LDA #$FFE0

  loc_000F12:
    STA $0026, X
    BRK #$04
    LDA $0016, X
    ORA #$0800
    STA $0016, X

  loc_000F20:
    CLC 
    RTS 

  loc_000F22:
    JSL $@engine_002EC0.code_002F0A
    SEC 
    RTS 
}

code_000F28 {
    LDA $0010, X
    ORA $0012, X
    AND #$0008
    BNE loc_000F52
    LDA $0004, X
    BEQ loc_000F42
    BMI loc_000F3F
    JSR $&code_000F56
    BRA loc_000F42

  loc_000F3F:
    JSR $&code_000FFF

  loc_000F42:
    LDA $0006, X
    BEQ loc_000F51
    BMI loc_000F4E
    JSR $&code_0010AF
    BRA loc_000F51

  loc_000F4E:
    JSR $&code_001154

  loc_000F51:
    RTL 

  loc_000F52:
    JSR $&code_001208
    RTL 
}

code_000F56 {
    PHP 
    LDA $0000, X
    CLC 
    ADC $0010, X
    SEC 
    SBC #$0010
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    SEC 
    SBC $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    STA $1C
    LDA $0002, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_000F8E:
    JSR $&code_001256
    CMP #$0A
    BEQ loc_000FE4
    INC $18
    DEC $0C
    BNE loc_000F8E
    LDA $00
    STA $18
    JSR $&code_001256
    CMP #$0A
    BEQ loc_000FE4
    LDA $1C
    STA $18
    INC $16

  loc_000FAC:
    JSR $&code_001256
    BCS loc_000FFC
    CMP #$0F
    BEQ loc_000FE4
    CMP #$05
    BEQ loc_000FE4
    CMP #$06
    BEQ loc_000FE4
    INC $18
    DEC $0E
    BNE loc_000FAC
    LDA $00
    STA $18
    JSR $&code_001256
    BCS loc_000FFC
    CMP #$0F
    BEQ loc_000FE4
    CMP #$05
    BEQ loc_000FE4
    CMP #$06
    BEQ loc_000FE4
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_000FE4:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_000FEE:
    LDA $0000, X
    AND #$FFF0
    STA $0000, X
    STZ $0004, X
    SEC 
    RTS 

  loc_000FFC:
    PLP 
    BRA loc_000FEE
}

code_000FFF {
    PHP 
    LDA $0004, X
    CLC 
    ADC $0000, X
    EOR $0000, X
    AND #$FFF0
    BEQ loc_001088
    LDA $0000, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    SEC 
    SBC $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    STA $1C
    LDA $0002, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_00103E:
    JSR $&code_001256
    CMP #$05
    BEQ loc_001094
    INC $18
    DEC $0C
    BNE loc_00103E
    LDA $00
    STA $18
    JSR $&code_001256
    CMP #$05
    BEQ loc_001094
    LDA $1C
    STA $18
    DEC $16

  loc_00105C:
    JSR $&code_001256
    BCS loc_0010AC
    CMP #$0F
    BEQ loc_001094
    CMP #$0A
    BEQ loc_001094
    CMP #$06
    BEQ loc_001094
    INC $18
    DEC $0E
    BNE loc_00105C
    LDA $00
    STA $18
    JSR $&code_001256
    BCS loc_0010AC
    CMP #$0F
    BEQ loc_001094
    CMP #$0A
    BEQ loc_001094
    CMP #$06
    BEQ loc_001094

  loc_001088:
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_001094:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_00109E:
    LDA $0000, X
    AND #$FFF0
    STA $0000, X
    STZ $0004, X
    SEC 
    RTS 

  loc_0010AC:
    PLP 
    BRA loc_00109E
}

code_0010AF {
    PHP 
    LDA $0002, X
    SEC 
    SBC #$0010
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    LDA $0000, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    STA $1A
    LDA $0000, X
    CLC 
    ADC $0010, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0010, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_0010E3:
    JSR $&code_001256
    CMP #$0C
    BEQ loc_001139
    INC $16
    DEC $0C
    BNE loc_0010E3
    LDA $00
    STA $16
    JSR $&code_001256
    CMP #$0C
    BEQ loc_001139
    LDA $1A
    STA $16
    INC $18

  loc_001101:
    JSR $&code_001256
    BCS loc_001151
    CMP #$0F
    BEQ loc_001139
    CMP #$03
    BEQ loc_001139
    CMP #$06
    BEQ loc_001139
    INC $16
    DEC $0E
    BNE loc_001101
    LDA $00
    STA $16
    JSR $&code_001256
    BCS loc_001151
    CMP #$0F
    BEQ loc_001139
    CMP #$03
    BEQ loc_001139
    CMP #$06
    BEQ loc_001139
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_001139:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_001143:
    LDA $0002, X
    AND #$FFF0
    STA $0002, X
    STZ $0006, X
    SEC 
    RTS 

  loc_001151:
    PLP 
    BRA loc_001143
}

code_001154 {
    PHP 
    LDA $0006, X
    CLC 
    ADC $0002, X
    EOR $0002, X
    AND #$FFF0
    BEQ loc_0011E1
    LDA $0002, X
    SEC 
    SBC $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    LDA $0000, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    STA $1A
    LDA $0000, X
    CLC 
    ADC $0010, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0010, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_001197:
    JSR $&code_001256
    CMP #$03
    BEQ loc_0011ED
    INC $16
    DEC $0C
    BNE loc_001197
    LDA $00
    STA $16
    JSR $&code_001256
    CMP #$03
    BEQ loc_0011ED
    LDA $1A
    STA $16
    DEC $18

  loc_0011B5:
    JSR $&code_001256
    BCS loc_001205
    CMP #$0F
    BEQ loc_0011ED
    CMP #$0C
    BEQ loc_0011ED
    CMP #$06
    BEQ loc_0011ED
    INC $16
    DEC $0E
    BNE loc_0011B5
    LDA $00
    STA $16
    JSR $&code_001256
    BCS loc_001205
    CMP #$0F
    BEQ loc_0011ED
    CMP #$0C
    BEQ loc_0011ED
    CMP #$06
    BEQ loc_0011ED

  loc_0011E1:
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_0011ED:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_0011F7:
    LDA $0002, X
    AND #$FFF0
    STA $0002, X
    STZ $0006, X
    SEC 
    RTS 

  loc_001205:
    PLP 
    BRA loc_0011F7
}

code_001208 {
    LDA $0004, X
    ORA $0004, X
    BEQ loc_001243
    LDA $0000, X
    CLC 
    ADC $0004, X
    SEC 
    SBC #$0004
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    CLC 
    ADC $0006, X
    SEC 
    SBC #$0004
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    JSR $&code_001256
    CMP #$000F
    BEQ loc_001245
    LDA $0016, X
    AND #$FFFB
    STA $0016, X

  loc_001243:
    CLC 
    RTS 

  loc_001245:
    STZ $0004, X
    STZ $0006, X
    LDA $0016, X
    ORA #$0004
    STA $0016, X
    SEC 
    RTS 
}

code_001256 {
    PHP 
    PHX 
    REP #$20
    LDA $18
    ASL 
    ASL 
    ASL 
    ASL 
    PHA 
    SEP #$20
    LDA $map_width_pages
    JSL $@lib_shared_0131D1.code_0131D1
    STA $02, S
    LDA $16
    AND #$0F
    CLC 
    ADC $01, S
    STA $01, S
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $02, S
    STA $02, S
    PLX 
    CPX #$4000
    BCS loc_001294
    LDA $tile_type_map, X
    BIT #$F0
    BNE loc_001294
    AND #$0F
    PLX 
    PLP 
    CLC 
    RTS 

  loc_001294:
    LDA #$0F
    PLX 
    PLP 
    SEC 
    RTS 
}

code_00129A {
    LDA $0000, X
    CLC 
    ADC $0004, X
    STA $0000, X
    LDA $0002, X
    CLC 
    ADC $0006, X
    STA $0002, X
    RTS 
}
---------------------------------------------

code_0012AF {
    PHP 
    REP #$20
    LDX #$1800
    STX $4A
    LDA #$0800

  loc_0012BA:
    STA $0000, X
    INX 
    INX 
    CLC 
    ADC #$0040
    CPX #$1880
    BNE loc_0012BA
    LDX #$0800
    STX $actor_list_tail
    LDA #$0000
    TAX 

  loc_0012D2:
    STA $0800, X
    INX 
    INX 
    CPX #$1000
    BNE loc_0012D2
    PLP 
    RTL 
}

code_0012DE {
    PHP 
    REP #$20
    LDA $03BA
    ASL 
    TAX 
    LDA $&meta_tables_008000, X
    SEC 
    SBC #$&meta_tables_008000
    STA $03B0
    SEP #$20
    LDX #$0000

  loc_0012F5:
    LDA $&table_0099B4, X
    BMI loc_001312
    CMP $area_current
    BNE loc_00130C
    LDA $&table_0099B4+1, X
    CMP $scene_current
    BNE loc_00130C
    JSR $&code_001314
    BRA loc_001312

  loc_00130C:
    INX 
    INX 
    INX 
    INX 
    BRA loc_0012F5

  loc_001312:
    PLP 
    RTL 
}

code_001314 {
    LDA #$01
    STA $2B
    REP #$20
    LDA $&table_0099B4+2, X
    STA $29
    JSL $@engine_0065A7.code_00668A
    BRA loc_00133C

  loc_001325:
    LDA [$29]
    AND #$00FF
    CMP #$00FF
    BNE loc_001330
    RTS 

  loc_001330:
    JSL $@engine_0065A7.code_00668A
    TYA 
    STA $003E, X
    TXA 
    STA $003C, Y

  loc_00133C:
    STY $actor_list_head
    TYX 
    LDA $29
    STA $003A, X
    CLC 
    ADC #$0004
    STA $29
    JSL $@code_0013AB
    LDA $0016, X
    BIT #$0080
    BEQ loc_001325
    LDA $warp_dest_x
    ORA $warp_dest_y
    BEQ loc_001399
    LDA $warp_dest_x
    STA $0000, X
    LDA $warp_dest_y
    CLC 
    ADC #$0010
    STA $0002, X
    LDA $warp_dest_anim
    STA $001E, X
    STZ $0020, X
    JSL $@code_0008F3
    STZ $0014, X
    LDA $warp_dest_x
    STZ $warp_dest_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $warp_dest_y
    STZ $warp_dest_y
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_y

  loc_001399:
    LDA $0000, X
    STA $player_x
    LDA $0002, X
    STA $player_y
    STX $player_actor
    BRL loc_001325
}

code_0013AB {
    TXY 
    LDX $003A, Y
    LDA $010000, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $0000, Y
    LDA $010001, X
    PHA 
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$0010
    STA $0002, Y
    PLA 
    AND #$C100
    ORA $0372
    STA $001C, Y
    SEP #$20
    LDA $010003, X
    XBA 
    LDA #$0E
    JSL $@lib_shared_0131D1.code_0131D1
    REP #$20
    CLC 
    ADC $03B0
    TAX 
    STA $0038, Y
    SEP #$20
    LDA $&meta_tables_008000+2, X
    STA $0025, Y
    LDA $&meta_tables_008000+5, X
    STA $001E, Y
    LDA $&meta_tables_008000+A, X
    STA $0024, Y
    LDA $&meta_tables_008000+D, X
    STA $0036, Y
    REP #$20
    LDA $&meta_tables_008000+6, X
    ORA #$8000
    STA $0016, Y
    LDA $&meta_tables_008000+8, X
    STA $0022, Y
    LDA $&meta_tables_008000+B, X
    STA $0018, Y
    TYX 
    LDA $0016, X
    BIT #$0040
    BNE loc_001441
    BIT #$2000
    BEQ loc_001441
    LDA #$0010
    STA $000C, X
    STA $000A, X
    STZ $0008, X
    STZ $000E, X
    BRA loc_001445

  loc_001441:
    JSL $@code_0008F3

  loc_001445:
    STZ $0014, X
    STZ $0004, X
    STZ $0006, X
    RTL 
}

code_00144F {
    PHP 
    PHX 
    PHY 
    REP #$20
    PHX 
    LDA $7F0203, X
    STA $00
    LDA $&data_00BA0D+C, Y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_00BA0D+D, Y
    AND #$00FF
    INC 
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    TYX 
    PHX 
    LDX $actor_list_head
    JSR $&engine_0065A7.code_006662
    PLX 
    LDA #$A000
    STA $0016, Y
    PLA 
    STA $0034, Y
    LDA $16
    STA $0000, Y
    LDA $18
    STA $0002, Y
    LDA $&data_00BA0D+16, X
    ORA #$0100
    ORA $0372
    STA $001C, Y
    STA $0030, Y
    LDA $&data_00BA0D+10, X
    STA $0018, Y
    SEP #$20
    LDA $&data_00BA0D+12, X
    STA $0036, Y
    LDA $00
    STA $002E, Y
    STA $002F, Y
    REP #$20
    LDA $&data_00BA0D+14, X
    AND #$00FF
    STA $0026, Y
    SEP #$20
    LDA $&data_00BA0D+15, X
    XBA 
    LDA #$0E
    JSL $@lib_shared_0131D1.code_0131D1
    REP #$20
    CLC 
    ADC $03B0
    STA $0038, Y
    TAX 
    SEP #$20
    LDA $&meta_tables_008000+2, X
    STA $0025, Y
    LDA $&meta_tables_008000+5, X
    STA $001E, Y
    LDA $&meta_tables_008000+A, X
    STA $0024, Y
    REP #$20
    LDA $&meta_tables_008000+8, X
    STA $0022, Y
    LDA #$0010
    STA $0010, Y
    STA $0012, Y
    STA $000C, Y
    STA $000A, Y
    LDA #$0000
    STA $0008, Y
    STA $000E, Y
    STA $0032, Y
    PLY 
    PLX 
    PLP 
    RTL 
}