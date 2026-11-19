?BANK 02

?INCLUDE 'data_00F9F7'
?INCLUDE 'data_048000'
?INCLUDE 'engine_000000'
?INCLUDE 'engine_0029EC'
?INCLUDE 'lib_0118FC_part10'
?INCLUDE 'lib_0118FC_part11'
?INCLUDE 'lib_0118FC_part12'
?INCLUDE 'lib_0118FC_part13'
?INCLUDE 'lib_0118FC_part2'
?INCLUDE 'lib_0118FC_part3'
?INCLUDE 'lib_0118FC_part4'
?INCLUDE 'lib_0118FC_part5'
?INCLUDE 'lib_0118FC_part6'
?INCLUDE 'lib_0118FC_part7'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_0118FC_part9'
?INCLUDE 'lib_0273D4'
?INCLUDE 'lib_0273EB'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027781_part1'
?INCLUDE 'lib_shared_012390'
?INCLUDE 'lib_shared_012416'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131B7'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'meta_tables_008000'

!frame_counter                  0312
!joy_pressed                    0322
!joy_release_latch              032A
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!player_actor                   039C
!vram_upload_flags              03B8
!actor_list_tail                06A6
!inventory                      1B1E
!player_hp                      1B88
!player_max_hp                  1B8A
!INIDISP                        2100
!BG2SC                          2108
!BG12NBA                        210B
!W12SEL                         2123
!TM                             212C
!CGADSUB                        2131
!S_bg3_tilemap_buffer           7000
!tile_type_map                  7F8000

---------------------------------------------

code_0118FC {
    LDA $0323
    BIT #$20
    BEQ loc_011906
    BRL loc_011B97

  loc_011906:
    BIT #$80
    BEQ loc_01190D
    BRL loc_0119D8

  loc_01190D:
    BIT #$0F
    BNE loc_011918
    LDA $joy_pressed
    BIT #$80
    BNE loc_011919

  loc_011918:
    RTL 

  loc_011919:
    LDA $player_hp
    LDX #$1B6C
    JSL $@lib_0118FC_part10.code_013215
    LDA $player_max_hp
    LDX #$1B6E
    JSL $@lib_0118FC_part10.code_013215
    LDA $1B72
    PHA 
    CMP #$0C
    BCC loc_01193A
    LDA #$0C
    STA $1B72

  loc_01193A:
    LDA $1B76
    PHA 
    CMP #$0C
    BCC loc_011947
    LDA #$0C
    STA $1B76

  loc_011947:
    LDY #$&lib_0118FC_part11.asciistring_014571
    JSL $@lib_shared_012769.code_012769
    PLA 
    STA $1B76
    PLA 
    STA $1B72
    BRK #$07
    JSL $@lib_shared_0131B7.code_0131B7

  loc_01195C:
    JSR $&code_0119A8
    BIT #$80
    BNE loc_01195C
    REP #$20

  loc_011965:
    JSR $&code_0119A8
    BIT #$CF80
    BEQ loc_011965
    SEP #$20
    LDY #$&lib_0118FC_part11.asciistring_014624
    JSL $@lib_shared_012769.code_012769
    JSR $&code_0119B7
    REP #$20

  loc_01197B:
    JSR $&code_0119A8
    BIT #$CF80
    BNE loc_01197B

  loc_011983:
    JSR $&code_0119A8
    BIT #$CF80
    BEQ loc_011983
    LDA #$C0C0
    TRB $joy_release_latch
    STZ $joy_pressed
    SEP #$20
    BRK #$07
    JSR $&lib_0118FC_part3.code_012350
    LDA #$1F
    STA $0332
    JSL $@lib_0118FC_part6.code_012659
    JSR $&code_0119A8
    RTL 
}

code_0119A8 {
    JSL $@lib_shared_0131B7.code_0131B7
    LDX $frame_counter
    DEX 
    STX $frame_counter
    LDA $joy_pressed
    RTS 
}

code_0119B7 {
    LDA $1B82
    LDY #$&lib_0118FC_part11.asciistring_014636

  loc_0119BD:
    LSR 
    PHA 
    BCC loc_0119C7
    PHY 
    JSL $@lib_shared_012769.code_012769
    PLY 

  loc_0119C7:
    REP #$20
    TYA 
    CLC 
    ADC #$0015
    TAY 
    SEP #$20
    PLA 
    CPY #$&lib_0118FC_part12.asciistring_01469F
    BNE loc_0119BD
    RTS 

  loc_0119D8:
    JSL $@lib_0118FC_part8.code_0131AE
    JSR $&code_0119E4
    JSL $@lib_0118FC_part8.code_0131A2
    RTL 
}

code_0119E4 {
    JSL $@lib_0273D4.code_0273D4
    BCC loc_0119EB
    RTS 

  loc_0119EB:
    PHP 
    REP #$20
    LDY $player_actor
    AND #$00FF
    BEQ loc_011A43
    DEC 
    BNE loc_0119FC
    BRL loc_011AA7

  loc_0119FC:
    DEC 
    BNE loc_011A02
    BRL loc_011A05

  loc_011A02:
    BRL loc_011A26

  loc_011A05:
    LDA #$0002
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0008
    STA $18
    JSR $&code_011AC4
    BCC loc_011A24
    BRL loc_011AF9

  loc_011A24:
    PLP 
    RTS 

  loc_011A26:
    LDA #$0003
    STA $00
    LDA $0000, Y
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0008
    STA $18
    JSR $&code_011AC4
    BCC loc_011A41
    BRL loc_011AF9

  loc_011A41:
    PLP 
    RTS 

  loc_011A43:
    LDA #$0000
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0008
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0010
    STA $18
    JSR $&code_011AC4
    BCC loc_011A62
    BRL loc_011AF9

  loc_011A62:
    PHX 
    LDX $player_actor
    LDA $0000, X
    AND #$FFF0
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    AND #$FFF0
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    PLX 
    AND #$000F
    CMP #$0006
    BNE loc_011AA5
    LDA $0000, Y
    CLC 
    ADC #$0008
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0020
    STA $18
    JSR $&code_011AC4
    BCC loc_011AA5
    BRL loc_011AF9

  loc_011AA5:
    PLP 
    RTS 

  loc_011AA7:
    LDA #$0001
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0008
    STA $16
    LDA $0002, Y
    STA $18
    JSR $&code_011AC4
    BCC loc_011AC2
    BRL loc_011AF9

  loc_011AC2:
    PLP 
    RTS 
}

code_011AC4 {
    LDA $actor_list_tail

  loc_011AC7:
    TAX 
    BEQ loc_011AF5
    LDA $0016, X
    BIT #$0040
    BEQ loc_011AF0
    LDA $16
    SEC 
    SBC $0000, X
    CMP $0010, X
    BEQ loc_011ADF
    BCS loc_011AF0

  loc_011ADF:
    LDA $18
    SEC 
    SBC $0002, X
    CLC 
    ADC $0012, X
    CMP $0012, X
    BEQ loc_011AF7
    BCC loc_011AF7

  loc_011AF0:
    LDA $003E, X
    BRA loc_011AC7

  loc_011AF5:
    CLC 
    RTS 

  loc_011AF7:
    SEC 
    RTS 

  loc_011AF9:
    LDA $0030, X
    BEQ code_011B5A
    LDA $0016, X
    BIT #$0008
    BNE loc_011B1D
    SEP #$20
    LDA #$02
    PHA 
    PEA $&code_011B5A-1
    LDY $0038, X
    LDA $&meta_tables_008000+D, Y
    PHA 
    LDY $0030, X
    DEY 
    PHY 
    REP #$20
    RTL 

  loc_011B1D:
    PHX 
    LDY #$1A1E
    LDA #$003F
    MVN #$01, #$01
    PLX 
    PHX 
    JSR $&code_011B5C
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    SEP #$20
    LDA #$02
    PHA 
    PEA $&code_011B50-1
    LDY $0038, X
    LDA $&meta_tables_008000+D, Y
    PHA 
    LDY $0030, X
    DEY 
    PHY 
    REP #$20
    RTL 
}

code_011B50 {
    LDX #$1A1E
    PLY 
    LDA #$003F
    MVN #$01, #$01
}

code_011B5A {
    PLP 
    RTS 
}

code_011B5C {
    PHP 
    SEP #$20
    LDY $001E, X
    LDA #$06
    JSL $@lib_0118FC_part9.code_0131E8
    XBA 
    LDA #$06
    JSL $@lib_shared_0131D1.code_0131D1
    STA $01
    LDA $00
    BEQ loc_011B93
    DEC 
    BEQ loc_011B91
    DEC 
    BEQ loc_011B84
    LDA $001D, X
    BIT #$40
    BNE loc_011B8F
    BRA loc_011B8B

  loc_011B84:
    LDA $001D, X
    BIT #$40
    BEQ loc_011B8F

  loc_011B8B:
    JSL $@lib_0273EB.code_0273EB

  loc_011B8F:
    INC $01

  loc_011B91:
    INC $01

  loc_011B93:
    LDA $01
    PLP 
    RTS 

  loc_011B97:
    STZ $42
    JSL $@lib_shared_0131B7.code_0131B7
    LDA #$80
    STA $INIDISP
    LDA #$5C
    STA $BG2SC
    LDA #$20
    STA $BG12NBA
    LDA #$06
    STA $TM
    STZ $CGADSUB
    STZ $W12SEL
    LDX $scroll_bg1_x
    STX $045A
    LDX $scroll_bg1_y
    STX $045C
    LDX $scroll_bg2_x
    STX $045E
    LDX $scroll_bg2_y
    STX $0460
    LDX #$0000
    STX $scroll_bg1_x
    STX $scroll_bg1_y
    STX $scroll_bg2_x
    STX $scroll_bg2_y
    STZ $042F
    LDA $1B62
    STA $0435
    JSR $&lib_0118FC_part4.code_0123EA
    JSR $&lib_shared_012416.code_012416
    JSR $&lib_shared_012416.code_01243D
    JSR $&lib_shared_012390.code_012390
    JSL $@lib_shared_0131B7.code_0131B7
    BRK #$07
    JSR $&code_011C7B
    LDA #$C0
    TRB $032B
    STZ $0323
    JSL $@lib_shared_0131B7.code_0131B7
    LDX $045A
    STX $scroll_bg1_x
    LDX $045C
    STX $scroll_bg1_y
    LDX $045E
    STX $scroll_bg2_x
    LDX $0460
    STX $scroll_bg2_y
    LDA #$80
    STA $INIDISP
    LDA $03C2
    STA $BG2SC
    STZ $BG12NBA
    LDA $03C0
    STA $TM
    LDA $03C1
    STA $CGADSUB
    LDA $03C3
    STA $W12SEL
    JSL $@lib_0118FC_part5.code_012463
    JSR $&lib_0118FC_part4.code_012400
    JSL $@lib_0118FC_part5.code_01249C
    LDA $1B62
    CMP $0435
    BEQ loc_011C5D
    JSL $@engine_0029EC.code_002C7D
    STZ $0433
    STZ $0434

  loc_011C5D:
    JSL $@lib_027781_part1.code_0273F9
    JSR $&lib_0118FC_part3.code_012350
    LDA #$1F
    STA $0332
    JSL $@lib_shared_0131B7.code_0131B7
    JSL $@engine_000000.code_000127
    JSL $@lib_shared_0131B7.code_0131B7
    LDA #$0F
    STA $INIDISP
    RTL 
}

code_011C7B {
    JSR $&lib_0118FC_part3.code_012350
    LDY #$&lib_0118FC_part12.asciistring_01469F
    JSL $@lib_shared_012769.code_012769
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_0118FC_part8.code_0131A2
    JSL $@lib_0118FC_part7.code_013176
    JSR $&code_011F18
    LDA #$02
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    LDX #$048A
    LDA #$00
    XBA 
    LDA #$04

  loc_011CAF:
    JSR $&lib_0118FC_part2.code_012138
    BCC loc_011CB7
    BRL loc_011D44

  loc_011CB7:
    CMP #$00
    BEQ loc_011CC3
    DEC 
    BEQ loc_011CE4
    DEC 
    BEQ loc_011D05
    BRA loc_011D23

  loc_011CC3:
    LDA #$08
    LDY #$1B1E
    JSR $&code_011DA3
    BCS loc_011CD3
    STA $1B5E
    JSR $&code_011EED

  loc_011CD3:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M
    JSL $@lib_shared_012769.code_012769
    LDX #$048A
    LDA #$00
    XBA 
    LDA #$04
    BRA loc_011CAF

  loc_011CE4:
    LDA #$08
    LDY #$1B26
    JSR $&code_011DA3
    BCS loc_011CF4
    STA $1B60
    JSR $&code_011EED

  loc_011CF4:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M
    JSL $@lib_shared_012769.code_012769
    LDX #$050A
    LDA #$01
    XBA 
    LDA #$04
    BRA loc_011CAF

  loc_011D05:
    LDA #$08
    LDY #$1B2E
    JSR $&code_011DA3
    BCS loc_011D12
    STA $1B62

  loc_011D12:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M
    JSL $@lib_shared_012769.code_012769
    LDX #$058A
    LDA #$02
    XBA 
    LDA #$04
    BRA loc_011CAF

  loc_011D23:
    LDA #$28
    LDY #$1B36
    JSR $&code_011FF2
    BCS loc_011D30
    STA $1B64

  loc_011D30:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M
    JSL $@lib_shared_012769.code_012769
    LDX #$060A
    LDA #$03
    XBA 
    LDA #$04
    BRL loc_011CAF

  loc_011D42:
    CLC 
    RTS 

  loc_011D44:
    SEC 
    RTS 
}

code_011D46 {
    PHX 
    PHY 
    JSR $&lib_0118FC_part3.code_012370
    LDY #$&lib_0118FC_part12.asciistring_01469F
    JSL $@lib_shared_012769.code_012769
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    JSR $&lib_shared_012416.code_01243D
    JSR $&code_011F18
    LDA #$02
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    PLY 
    PLX 
    RTS 
}

code_011D76 {
    PHX 
    PHY 
    LDY #$&lib_0118FC_part12.asciistring_014701
    JSL $@lib_shared_012769.code_012769
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    JSR $&lib_0118FC_part5.code_012450
    JSR $&code_011FD3
    LDA #$02
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    PLY 
    PLX 
    RTS 
}

code_011DA3 {
    STA $03C4
    STY $0056
    STZ $03C6
    JSR $&code_011EAB
    LDX #$0000
    TXY 

  loc_011DB3:
    LDA ($56), Y
    BMI loc_011DC6
    INY 
    CPY $03C4
    BNE loc_011DB3
    LDY #$0000
    LDA ($56), Y
    ORA #$80
    STA ($56), Y

  loc_011DC6:
    JSR $&code_011F18
    JSL $@lib_shared_0131B7.code_0131B7
    PHY 
    REP #$20
    LDA ($56), Y
    AND #$007F
    PHA 
    BEQ loc_011DEF
    LDY #$&lib_0118FC_part13.asciistring_01553E
    CMP #$0009
    BCC loc_011DEB
    LDY #$&lib_0118FC_part13.asciistring_015558
    CMP #$0011
    BCC loc_011DEB
    LDY #$&lib_0118FC_part13.asciistring_01556B

  loc_011DEB:
    JSL $@lib_shared_012769.code_012769

  loc_011DEF:
    PLA 
    ASL 
    TAX 
    LDA $@lib_0118FC_part13.asciistring_list_015572, X
    TAY 
    SEP #$20
    JSL $@lib_shared_012769.code_012769
    PLY 

  loc_011DFE:
    JSR $&lib_shared_012769.code_013169
    BEQ loc_011E0B
    JSR $&code_011ECF
    JSR $&code_011F18
    BRA loc_011DFE

  loc_011E0B:
    JSR $&lib_shared_012769.code_013169
    LSR 
    BCS loc_011E57
    LSR 
    BCS loc_011E6A
    LSR 
    BCS loc_011E7A
    LSR 
    BCS loc_011E88
    LSR 
    LSR 
    LSR 
    BCS loc_011E2A
    LSR 
    BCS loc_011E2A
    JSR $&code_011ECF
    JSR $&code_011F18
    BRA loc_011E0B

  loc_011E2A:
    BRK #$18
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    JSR $&code_011F18
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    LDA ($56), Y
    AND #$7F
    CLC 
    RTS 
}

code_011E44 {
    BRK #$07
    JSR $&code_011EBD
    JSR $&code_011F18
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    SEC 
    RTS 

  loc_011E57:
    TYA 
    CLC 
    ADC #$04
    CMP $03C4
    BCC loc_011E63
    BRL loc_011DC6

  loc_011E63:
    TYX 
    INY 
    INY 
    INY 
    INY 
    BRA loc_011E91

  loc_011E6A:
    TYA 
    SEC 
    SBC #$04
    BPL loc_011E73
    BRL loc_011DC6

  loc_011E73:
    TYX 
    DEY 
    DEY 
    DEY 
    DEY 
    BRA loc_011E91

  loc_011E7A:
    TYA 
    INC 
    CMP $03C4
    BCC loc_011E84
    BRL loc_011DC6

  loc_011E84:
    TYX 
    INY 
    BRA loc_011E91

  loc_011E88:
    TYA 
    DEC 
    BPL loc_011E8F
    BRL loc_011DC6

  loc_011E8F:
    TYX 
    DEY 

  loc_011E91:
    BRK #$07
    PHY 
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    TXY 
    LDA ($56), Y
    AND #$7F
    STA ($56), Y
    STZ $03C6
    PLY 
    JSR $&code_011ECF
    BRL loc_011DC6
}

code_011EAB {
    LDX #$0000
    TXY 

  loc_011EAF:
    LDA ($56), Y
    STA $7F0403, X
    INY 
    INX 
    CPX $03C4
    BNE loc_011EAF
    RTS 
}

code_011EBD {
    LDX #$0000
    TXY 

  loc_011EC1:
    LDA $7F0403, X
    STA ($56), Y
    INY 
    INX 
    CPX $03C4
    BNE loc_011EC1
    RTS 
}

code_011ECF {
    LDA $03C6
    AND #$1F
    CMP #$18
    BCC loc_011EDE
    LDA ($56), Y
    AND #$7F
    BRA loc_011EE2

  loc_011EDE:
    LDA ($56), Y
    ORA #$80

  loc_011EE2:
    STA ($56), Y
    INC $03C6
    LDA #$01
    TSB $vram_upload_flags
    RTS 
}

code_011EED {
    LDX $1B5E
    LDA $@lib_0118FC_part13.binary_0161AC, X
    STA $1B70
    LDA $@lib_0118FC_part13.binary_0161AC+11, X
    STA $1B74
    LDX $1B60
    LDA $@lib_0118FC_part13.binary_0161AC, X
    CLC 
    ADC $1B70
    STA $1B70
    LDA $@lib_0118FC_part13.binary_0161AC+11, X
    CLC 
    ADC $1B74
    STA $1B74
    RTS 
}

code_011F18 {
    PHP 
    PHY 
    REP #$20
    LDX #$0000

  loc_011F1F:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_00F9F7.word_00F9F7, X
    TAY 
    PLX 
    LDA $inventory, X
    JSR $&code_011F67
    INX 
    CPX #$0008
    BNE loc_011F1F
    LDX #$0000

  loc_011F37:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_00F9F7.word_00FA07, X
    TAY 
    PLX 
    LDA $1B26, X
    JSR $&code_011F67
    INX 
    CPX #$0008
    BNE loc_011F37
    LDX #$0000

  loc_011F4F:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_00F9F7.word_00FA17, X
    TAY 
    PLX 
    LDA $1B2E, X
    JSR $&code_011F67
    INX 
    CPX #$0008
    BNE loc_011F4F
    PLY 
    PLP 
    RTS 
}

code_011F67 {
    PHB 
    PHX 
    XBA 
    TAX 
    SEP #$20
    PHP 
    LDA #$7F
    PHA 
    PLB 
    PLP 
    BMI loc_011F85
    LDA #$00
    STA $S_bg3_tilemap_buffer, Y
    STA $7002, Y
    STA $7040, Y
    STA $7042, Y
    BRA loc_011FAA

  loc_011F85:
    LDA #$2A
    STA $S_bg3_tilemap_buffer, Y
    STA $7002, Y
    STA $7040, Y
    STA $7042, Y
    LDA $7001, Y
    ORA #$0C
    STA $7001, Y
    EOR #$40
    STA $7003, Y
    EOR #$C0
    STA $7041, Y
    EOR #$40
    STA $7043, Y

  loc_011FAA:
    REP #$20
    XBA 
    AND #$007F
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $@data_048000.unk17_048800, X
    STA $7800, Y
    LDA $@data_048000.unk17_048800+2, X
    STA $7802, Y
    LDA $@data_048000.unk17_048800+4, X
    STA $7840, Y
    LDA $@data_048000.unk17_048800+6, X
    STA $7842, Y
    PLX 
    PLB 
    RTS 
}

code_011FD3 {
    PHP 
    PHY 
    REP #$20
    LDX #$0000

  loc_011FDA:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_00F9F7.word_00FA27, X
    TAY 
    PLX 
    LDA $1B36, X
    JSR $&code_011F67
    INX 
    CPX #$0028
    BNE loc_011FDA
    PLY 
    PLP 
    RTS 
}

code_011FF2 {
    STA $03C4
    STY $0056
    STZ $03C6
    JSR $&code_011EAB
    LDX #$0000
    TXY 

  loc_012002:
    LDA ($56), Y
    BMI loc_012015
    INY 
    CPY $03C4
    BNE loc_012002
    LDY #$0000
    LDA ($56), Y
    ORA #$80
    STA ($56), Y

  loc_012015:
    JSR $&code_011FD3
    JSL $@lib_shared_0131B7.code_0131B7
    PHY 
    REP #$20
    LDA ($56), Y
    AND #$007F
    BEQ loc_01202F
    PHA 
    LDY #$&lib_0118FC_part13.asciistring_01556B
    JSL $@lib_shared_012769.code_012769
    PLA 

  loc_01202F:
    ASL 
    TAX 
    LDA $@lib_0118FC_part13.asciistring_list_015572, X
    TAY 
    SEP #$20
    JSL $@lib_shared_012769.code_012769
    PLY 

  loc_01203D:
    JSR $&lib_shared_012769.code_013169
    BEQ loc_01204A
    JSR $&code_011ECF
    JSR $&code_011FD3
    BRA loc_01203D

  loc_01204A:
    JSR $&lib_shared_012769.code_013169
    LSR 
    BCS loc_0120C8
    LSR 
    BCC loc_012056
    BRL loc_0120D6

  loc_012056:
    LSR 
    BCS loc_012099
    LSR 
    BCS loc_0120B2
    LSR 
    LSR 
    LSR 
    BCS loc_01206C
    LSR 
    BCS loc_01206C
    JSR $&code_011ECF
    JSR $&code_011FD3
    BRA loc_01204A

  loc_01206C:
    BRK #$18
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    JSR $&code_011FD3
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    LDA ($56), Y
    AND #$7F
    CLC 
    RTS 
}

code_012086 {
    BRK #$07
    JSR $&code_011EBD
    JSR $&code_011FD3
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_shared_0131B7.code_0131B7
    SEC 
    RTS 

  loc_012099:
    TYA 
    CLC 
    ADC #$0A
    CMP $03C4
    BCC loc_0120A5
    BRL loc_012015

  loc_0120A5:
    TYX 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    BRA loc_0120DF

  loc_0120B2:
    TYA 
    SEC 
    SBC #$0A
    BPL loc_0120BB
    BRL loc_012015

  loc_0120BB:
    TYX 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    BRA loc_0120DF

  loc_0120C8:
    TYA 
    INC 
    CMP $03C4
    BCC loc_0120D2
    BRL loc_012015

  loc_0120D2:
    TYX 
    INY 
    BRA loc_0120DF

  loc_0120D6:
    TYA 
    DEC 
    BPL loc_0120DD
    BRL loc_012015

  loc_0120DD:
    TYX 
    DEY 

  loc_0120DF:
    BRK #$07
    PHY 
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    TXY 
    LDA ($56), Y
    AND #$7F
    STA ($56), Y
    STZ $03C6
    PLY 
    JSR $&code_011ECF
    BRL loc_012015
}