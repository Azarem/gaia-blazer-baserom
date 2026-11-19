?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0109D6_part1'
?INCLUDE 'lib_0109D6_part3'
?INCLUDE 'lib_0109D6_part4'
?INCLUDE 'lib_0109D6_part5'
?INCLUDE 'lib_027348'
?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_0273D4'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_0276A5'
?INCLUDE 'lib_shared_01112A'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_016246'
?INCLUDE 'table_00A9DE'
?INCLUDE 'table_00AC96'
?INCLUDE 'table_00B69A'

!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!player_actor                   039C
!transition_type                03E3
!return_active                  03FB
!return_area                    03FD
!return_scene                   03FF
!return_x                       0401
!return_y                       0403
!location_id                    1C6A
!tile_type_map                  7F8000

---------------------------------------------

code_0109D6 {
    LDA $player_x
    ORA $player_y
    AND #$0F
    BNE loc_010A15
    REP #$20
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA $7E8000, X
    CMP #$FE
    BNE loc_010A09
    LDA $0458
    BNE loc_010A28
    JSL $@code_010C25
    BRA loc_010A1B

  loc_010A09:
    JSL $@code_010B9B
    BCS loc_010A1B
    JSL $@code_010A29
    BCS loc_010A1B

  loc_010A15:
    JSL $@code_010AF2
    BCC loc_010A28

  loc_010A1B:
    REP #$20
    LDX $player_actor
    STZ $0004, X
    STZ $0006, X
    SEP #$20

  loc_010A28:
    RTL 
}

code_010A29 {
    JSL $@lib_0273D4.code_0273D4
    BCS loc_010A5A
    CMP #$00
    BNE loc_010A5A
    LDX $03AE

  loc_010A36:
    LDA $&table_00A9DE, X
    CMP #$FF
    BEQ loc_010A5A
    LDA $player_tile_x
    CMP $&table_00A9DE, X
    BNE loc_010A4D
    LDA $player_tile_y
    CMP $&table_00A9DE+1, X
    BEQ loc_010A5C

  loc_010A4D:
    REP #$20
    TXA 
    CLC 
    ADC #$0006
    TAX 
    SEP #$20
    BRL loc_010A36

  loc_010A5A:
    CLC 
    RTL 

  loc_010A5C:
    TXY 
    REP #$20
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0020
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA $7E8000, X
    CMP #$FB
    BNE loc_010A5A
    TYX 
    LDA #$00
    XBA 
    LDA $&table_00A9DE+2, X
    AND #$7F
    LDY #$1A7E
    JSL $@lib_0273A2.code_0273A2
    BCS loc_010A5A
    JSL $@lib_027348.code_027348
    BRK #$15
    LDA $&table_00A9DE+2, X
    BMI loc_010AA0
    LDA #$FC
    JSL $@lib_0109D6_part1.code_0106F1
    BRA loc_010AA6

  loc_010AA0:
    LDA #$FC
    JSL $@lib_0109D6_part1.code_0107AC

  loc_010AA6:
    LDA #$1E
    JSL $@lib_shared_012769.code_013140
    LDA $&table_00A9DE+3, X
    STA $03C8
    STZ $03C9
    BEQ loc_010ACA
    CMP #$FF
    BEQ loc_010AD3
    JSL $@lib_0109D6_part3.code_0120F9
    LDY #$&lib_0109D6_part4.asciistring_016216
    JSL $@lib_shared_012769.code_012C27
    BRK #$9E
    SEC 
    RTL 

  loc_010ACA:
    LDY #$&lib_0109D6_part4.asciistring_016232
    JSL $@lib_shared_012769.code_012C27
    SEC 
    RTL 

  loc_010AD3:
    REP #$20
    LDA $&table_00A9DE+4, X
    STA $03C8
    JSL $@lib_0276A5.code_0276A5
    LDA #$0010
    TSB $0332
    SEP #$20
    LDY #$&lib_shared_016246.asciistring_016246
    JSL $@lib_shared_012769.code_012C27
    BRK #$8D
    SEC 
    RTL 
}

code_010AF2 {
    PHP 
    LDX $03B2
    BEQ loc_010B23

  loc_010AF8:
    LDA $&table_00AC96, X
    CMP #$FF
    BEQ loc_010B23
    LDA $player_tile_x
    SEC 
    SBC $&table_00AC96, X
    CMP $&table_00AC96+2, X
    BCS loc_010B17
    LDA $player_tile_y
    SEC 
    SBC $&table_00AC96+1, X
    CMP $&table_00AC96+3, X
    BCC loc_010B26

  loc_010B17:
    REP #$20
    TXA 
    CLC 
    ADC #$000B
    TAX 
    SEP #$20
    BRA loc_010AF8

  loc_010B23:
    PLP 
    CLC 
    RTL 

  loc_010B26:
    REP #$20
    LDA $&table_00AC96, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $00
    LDA $&table_00AC96+1, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$0010
    STA $02
    LDA $&table_00AC96+2, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    SEC 
    SBC #$000F
    STA $04
    LDA $&table_00AC96+3, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    SEC 
    SBC #$000F
    STA $06
    LDA $player_x
    SEC 
    SBC $00
    CMP $04
    BCS loc_010B23
    LDA $player_y
    SEC 
    SBC $02
    CMP $06
    BCS loc_010B23
    SEP #$20
    LDA $&table_00AC96+4, X
    STA $area_next
    LDA $&table_00AC96+5, X
    STA $scene_next
    LDA $&table_00AC96+6, X
    STA $warp_dest_anim
    LDY $&table_00AC96+7, X
    STY $warp_dest_x
    LDY $&table_00AC96+9, X
    STY $warp_dest_y
    PLP 
    SEC 
    RTL 
}

code_010B9B {
    LDX $03AC

  loc_010B9E:
    LDA $&table_00B69A, X
    CMP #$FF
    BEQ loc_010C23
    CMP $player_tile_x
    BNE loc_010C1C
    LDA $&table_00B69A+1, X
    CMP $player_tile_y
    BNE loc_010C1C
    LDA $&table_00B69A+3, X
    XBA 
    LDA $&table_00B69A+2, X
    LDY #$1A9E
    JSL $@lib_0273A2.code_0273A2
    BCC loc_010C23
    REP #$20
    LDA $&table_00B69A+2, X
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$&data_00BA0D
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_00BA0D
    SEP #$20
    LDA $03A8
    CLC 
    ADC #$02
    STA $1C6E
    JSR $&lib_shared_01112A.code_01112A
    LDA #$01
    STA $1C75
    INC $1C6C
    LDA #$23

  loc_010BF2:
    JSL $@engine_000000.code_000173
    DEC 
    BNE loc_010BF2
    STZ $1C6C
    REP #$20
    LDX $03AA
    LDA $03A8
    EOR #$0001
    STA $03A8
    BEQ loc_010C0E
    INX 
    INX 

  loc_010C0E:
    LDA $&table_00B69A, X
    SEC 
    SBC #$&table_00B69A
    STA $03AC
    SEP #$20
    SEC 
    RTL 

  loc_010C1C:
    INX 
    INX 
    INX 
    INX 
    BRL loc_010B9E

  loc_010C23:
    CLC 
    RTL 
}

code_010C25 {
    STX $00
    LDX #$0000
    TXY 

  loc_010C2B:
    LDA $&data_00BA0D, X
    CMP #$FF
    BEQ loc_010C57
    LDA $&data_00BA0D+B, X
    CMP $location_id
    BNE loc_010C4A
    LDA $&data_00BA0D+C, X
    CMP $player_tile_x
    BNE loc_010C4A
    LDA $&data_00BA0D+D, X
    CMP $player_tile_y
    BEQ loc_010C58

  loc_010C4A:
    REP #$20
    TXA 
    CLC 
    ADC #$0020
    TAX 
    SEP #$20
    INY 
    BRA loc_010C2B

  loc_010C57:
    RTL 

  loc_010C58:
    LDA $0456
    BEQ loc_010C60
    DEC $0456

  loc_010C60:
    PHX 
    LDA $&data_00BA0D+8, X
    PHP 
    LDX $00
    LDA #$FF
    STA $7E8000, X
    PLP 
    BEQ loc_010C74
    STA $7EC000, X

  loc_010C74:
    PLX 
    LDA $&data_00BA0D+E, X
    ORA $&data_00BA0D+F, X
    BNE loc_010C80
    BRL loc_010D18

  loc_010C80:
    PHX 
    LDA $&data_00BA0D+A, X
    ORA #$80
    TYX 
    STA $7F0203, X
    REP #$20
    TYA 
    LDY #$1ADE
    JSL $@lib_027348.code_027348
    LDY #$1A9E
    JSL $@lib_027348.code_027348
    SEP #$20
    PLX 
    LDA $&data_00BA0D, X
    CMP $location_id
    BNE loc_010CFD
    REP #$20
    LDA $&data_00BA0D+E, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_00BA0D+F, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    PHX 
    TXA 
    CLC 
    ADC #$&data_00BA0D
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_00BA0D
    PLX 
    SEP #$20
    LDA $&data_00BA0D+8, X
    BEQ loc_010CFA
    LSR 
    BCC loc_010CE1
    JSR $&lib_shared_01112A.code_01125E
    BRA loc_010CE4

  loc_010CE1:
    JSR $&lib_shared_01112A.code_0111CB

  loc_010CE4:
    BRK #$94
    JSL $@engine_000000.code_000173
    LDA #$01
    STA $1C75
    LDA #$23

  loc_010CF1:
    JSL $@engine_000000.code_000173
    DEC 
    BNE loc_010CF1
    BRA loc_010D03

  loc_010CFA:
    JSR $&lib_shared_01112A.code_0111CB

  loc_010CFD:
    JSL $@engine_000000.code_000173
    BRK #$94

  loc_010D03:
    LDA #$01
    STA $1C75
    INC $1C6C
    LDA #$23

  loc_010D0D:
    JSL $@engine_000000.code_000173
    DEC 
    BNE loc_010D0D
    STZ $1C6C
    RTL 

  loc_010D18:
    PHX 
    LDA $&data_00BA0D+A, X
    ORA #$C0
    TYX 
    STA $7F0203, X
    PLX 
    LDA $&data_00BA0D, X
    CMP $location_id
    BNE loc_010D54
    REP #$20
    LDA $&data_00BA0D+2, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_00BA0D+3, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA #$01
    STA $tile_type_map, X
    BRA loc_010CFD

  loc_010D54:
    BRK #$98
    LDA $area_current
    STA $return_area
    LDA $scene_current
    STA $return_scene
    LDA $&data_00BA0D+1D, X
    STA $warp_dest_anim
    REP #$20
    LDA $player_x
    STA $return_x
    LDA $player_y
    SEC 
    SBC #$0010
    STA $return_y
    LDA $&data_00BA0D+2, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $warp_dest_x
    LDA $&data_00BA0D+3, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $warp_dest_y
    LDA $&data_00BA0D, X
    AND #$00FF
    ASL 
    TAX 
    SEP #$20
    LDA #$80
    STA $transition_type
    LDA $@lib_0109D6_part5.word_01762C, X
    STA $area_next
    LDA $@lib_0109D6_part5.word_01762C+1, X
    STA $scene_next
    LDA #$20
    STA $03B4
    STY $0405
    INC $return_active
    RTL 
}