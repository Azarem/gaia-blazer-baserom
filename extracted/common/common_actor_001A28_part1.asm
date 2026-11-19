?BANK 00

?INCLUDE 'common_actor_001A28_part2'
?INCLUDE 'common_actor_001A28_part4'
?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'
?INCLUDE 'engine_routines_001D3B'
?INCLUDE 'lib_010000'
?INCLUDE 'lib_0161CE'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!joy_pressed                    0322
!joy_block_mask                 0326
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_anim                 0380
!player_actor                   039C
!return_active                  03FB
!actor_list_tail                06A6
!player_level_bcd               1B6A
!switch_owner_table             7F0483
!tile_type_map                  7F8000

---------------------------------------------

code_001512 {
    LDA $0464
    BEQ loc_00151A
    STZ $joy_pressed

  loc_00151A:
    LDA $0439
    BNE loc_001524
    LDA $1B5E
    BNE loc_00152F

  loc_001524:
    LDY $player_actor
    LDA #$C000
    TRB $joy_pressed
    BRA loc_00155F

  loc_00152F:
    JSR $&code_0018A1
    PHX 
    DEC 
    ASL 
    TAX 
    LDA $@lib_0161CE.word_0161CE, X
    CMP $player_level_bcd
    BEQ loc_001547
    BCC loc_001547
    LDA #$8000
    TRB $joy_pressed

  loc_001547:
    PLX 
    LDY $player_actor
    LDA $001E, Y
    SEC 
    SBC #$0014
    CMP #$0010
    BCC loc_001577
    LDA $joy_pressed
    AND #$8000
    BNE loc_001578

  loc_00155F:
    LDA $0016, Y
    BIT #$0400
    BNE loc_00157F
    PHX 
    LDA $001E, Y
    ASL 
    TAX 
    LDA $@word_001588, X
    PLX 
    AND $joy_pressed
    BEQ loc_001578

  loc_001577:
    RTL 

  loc_001578:
    LDA #$&loc_001A65
    STA $0018, Y
    RTL 

  loc_00157F:
    LDA #$&loc_001A65
    STA $0018, Y
    COP [91]
    RTL 
}
---------------------------------------------

word_001588 [
  #$0400   ;00
  #$0800   ;01
  #$0200   ;02
  #$0100   ;03
  #$0400   ;04
  #$0800   ;05
  #$0800   ;06
  #$0400   ;07
  #$0200   ;08
  #$0100   ;09
  #$0100   ;0A
  #$0200   ;0B
  #$0100   ;0C
  #$0200   ;0D
  #$0200   ;0E
  #$0100   ;0F
  #$0400   ;10
  #$0800   ;11
  #$0800   ;12
  #$0400   ;13
  #$0000   ;14
  #$0000   ;15
  #$0000   ;16
  #$0000   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$0000   ;1C
  #$0000   ;1D
  #$0000   ;1E
  #$0000   ;1F
  #$0000   ;20
  #$0000   ;21
  #$0000   ;22
  #$0000   ;23
  #$0100   ;24
  #$0100   ;25
  #$0200   ;26
  #$0200   ;27
  #$0400   ;28
  #$0400   ;29
  #$0800   ;2A
  #$0800   ;2B
]
---------------------------------------------

code_0015E0 {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    PHX 
    LDX $player_actor
    JSR $&code_00169C
    BCC loc_001630
    LDA $0004, X
    PHA 
    LDA $0006, X
    PHA 
    LDA $03D4
    STA $0004, X
    LDA $03D6
    STA $0006, X
    JSL $@engine_000000.code_000F28
    LDA $0004, X
    STA $03D4
    CLC 
    ADC $0000, X
    STA $0000, X
    LDA $0006, X
    STA $03D6
    CLC 
    ADC $0002, X
    STA $0002, X
    PLA 
    STA $0006, X
    PLA 
    STA $0004, X
    BRA loc_001633

  loc_001630:
    JSR $&code_001733

  loc_001633:
    LDA $joy_block_mask
    BIT #$0F00
    BNE loc_001657
    LDA $03D4
    BNE loc_001649
    LDA $0000, X
    AND #$FFFE
    STA $0000, X

  loc_001649:
    LDA $03D6
    BNE loc_001657
    LDA $0002, X
    AND #$FFFE
    STA $0002, X

  loc_001657:
    STZ $03D4
    STZ $03D6
    LDA $0000, X
    STA $player_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $0002, X
    STA $player_y
    LSR 
    LSR 
    LSR 
    LSR 
    DEC 
    STA $player_tile_y
    LDY $039E
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
    LDA $001E, X
    ASL 
    TAX 
    LDA $&data_00F9F7.word_00FAD7, X
    CLC 
    ADC $0002, Y
    STA $0002, Y
    JSL $@lib_010000.code_010000
    PLX 
    RTL 
}

code_00169C {
    LDA $0000, X
    STA $player_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $0002, X
    STA $player_y
    LSR 
    LSR 
    LSR 
    LSR 
    DEC 
    STA $player_tile_y
    CLC 
    LDY $03D8
    BNE loc_0016BE
    RTS 

  loc_0016BE:
    LDA $03A6
    BEQ loc_0016C4
    RTS 

  loc_0016C4:
    LDA $0000, X
    CLC 
    ADC #$000F
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    SEP #$20
    PHB 
    LDA $03DA
    PHA 
    PLB 

  loc_0016E3:
    LDA $0000, Y
    INC 
    BEQ loc_001725
    LDA $16
    CMP $0000, Y
    BCC loc_001719
    LDA $player_tile_x
    CMP $0001, Y
    BCS loc_001719
    LDA $18
    CMP $0002, Y
    BCC loc_001719
    LDA $player_tile_y
    CMP $0003, Y
    BCS loc_001719
    REP #$20
    LDA $0004, Y
    BEQ loc_001711
    STA $03D4

  loc_001711:
    LDA $0006, Y
    BEQ loc_001719
    STA $03D6

  loc_001719:
    REP #$20
    TYA 
    CLC 
    ADC #$0008
    TAY 
    SEP #$20
    BRA loc_0016E3

  loc_001725:
    REP #$20
    PLB 
    SEC 
    LDA $03D4
    ORA $03D6
    BNE loc_001732
    CLC 

  loc_001732:
    RTS 
}

code_001733 {
    LDA $0016, X
    BIT #$0004
    BNE loc_00173C
    RTS 

  loc_00173C:
    JSR $&code_001892
    BCC loc_001742
    RTS 

  loc_001742:
    AND #$00FF
    BEQ loc_001754
    DEC 
    BEQ loc_0017A1
    DEC 
    BNE loc_001750
    BRL loc_0017EA

  loc_001750:
    BRL loc_00183E

  loc_001753:
    RTS 

  loc_001754:
    LDA $joy_pressed
    BIT #$0800
    BNE loc_00175D
    RTS 

  loc_00175D:
    TXY 
    LDA $0000, X
    AND #$000F
    BEQ loc_00178E
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    AND #$00FC
    BEQ loc_001790
    JSL $@lib_027462_part2.code_02731A
    LDA $tile_type_map, X
    AND #$00FC
    BEQ loc_001795

  loc_00178E:
    TYX 
    RTS 

  loc_001790:
    LDA #$FFFE
    BRA loc_001798

  loc_001795:
    LDA #$0002

  loc_001798:
    TYX 
    CLC 
    ADC $0000, X
    STA $0000, X
    RTS 

  loc_0017A1:
    LDA $joy_pressed
    BIT #$0400
    BNE loc_0017AA
    RTS 

  loc_0017AA:
    TXY 
    LDA $0000, X
    AND #$000F
    BEQ loc_0017D7
    LDA $0000, X
    STA $16
    LDA $0002, X
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    AND #$00F3
    BEQ loc_0017D9
    JSL $@lib_027462_part2.code_02731A
    LDA $tile_type_map, X
    AND #$00F3
    BEQ loc_0017DE

  loc_0017D7:
    TYX 
    RTS 

  loc_0017D9:
    LDA #$FFFE
    BRA loc_0017E1

  loc_0017DE:
    LDA #$0002

  loc_0017E1:
    TYX 
    CLC 
    ADC $0000, X
    STA $0000, X
    RTS 

  loc_0017EA:
    LDA $joy_pressed
    BIT #$0100
    BNE loc_0017F3
    RTS 

  loc_0017F3:
    TXY 
    LDA $0002, X
    AND #$000F
    BEQ loc_00182B
    LDA $0000, X
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    AND #$00F5
    BEQ loc_00182D
    JSL $@lib_027462_part2.code_027331
    LDA $tile_type_map, X
    AND #$00F5
    BEQ loc_001832

  loc_00182B:
    TYX 
    RTS 

  loc_00182D:
    LDA #$FFFE
    BRA loc_001835

  loc_001832:
    LDA #$0002

  loc_001835:
    TYX 
    CLC 
    ADC $0002, X
    STA $0002, X
    RTS 

  loc_00183E:
    LDA $joy_pressed
    BIT #$0200
    BNE loc_001847
    RTS 

  loc_001847:
    TXY 
    LDA $0002, X
    AND #$000F
    BEQ loc_00187F
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    AND #$00FA
    BEQ loc_001881
    JSL $@lib_027462_part2.code_027331
    LDA $tile_type_map, X
    AND #$00FA
    BEQ loc_001886

  loc_00187F:
    TYX 
    RTS 

  loc_001881:
    LDA #$FFFE
    BRA loc_001889

  loc_001886:
    LDA #$0002

  loc_001889:
    TYX 
    CLC 
    ADC $0002, X
    STA $0002, X
    RTS 
}

code_001892 {
    LDY $001E, X
    CPY #$002C
    BCS loc_00189F
    LDA $&data_00F9F7.binary_00FAAB, Y
    CLC 
    RTS 

  loc_00189F:
    SEC 
    RTS 
}

code_0018A1 {
    PHX 
    PHA 
    LDY $player_actor
    LDA $001E, Y
    CMP #$0004
    BCS loc_0018E8
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0008
    STA $16
    LDA $0002, Y
    CLC 
    ADC #$0008
    STA $18
    LDA $actor_list_tail
    BRA loc_0018CA

  loc_0018C7:
    LDA $003E, X

  loc_0018CA:
    TAX 
    BEQ loc_0018E8
    LDA $0016, X
    BMI loc_0018C7
    BIT #$4000
    BEQ loc_0018C7
    LDA $001E, X
    SEC 
    SBC #$0004
    CMP #$0003
    BCS loc_0018C7
    JSR $&code_0018EB
    BRA loc_0018C7

  loc_0018E8:
    PLA 
    PLX 
    RTS 
}

code_0018EB {
    LDA $00
    BEQ loc_001923
    DEC 
    BEQ loc_0018F8
    DEC 
    BEQ loc_00194E
    BRL loc_001979

  loc_0018F8:
    LDA $0002, X
    CMP $18
    BCC loc_001900
    RTS 

  loc_001900:
    LDA $16
    SEC 
    SBC $0000, X
    CMP #$0011
    BCC loc_00190C
    RTS 

  loc_00190C:
    LDA $001E, X
    CMP #$0006
    BEQ loc_00191F
    CMP #$0005
    BEQ loc_00191C
    INC $0002, X

  loc_00191C:
    INC $0002, X

  loc_00191F:
    INC $0002, X
    RTS 

  loc_001923:
    LDA $0002, X
    CMP $18
    BCS loc_00192B
    RTS 

  loc_00192B:
    LDA $16
    SEC 
    SBC $0000, X
    CMP #$0011
    BCC loc_001937
    RTS 

  loc_001937:
    LDA $001E, X
    CMP #$0006
    BEQ loc_00194A
    CMP #$0005
    BEQ loc_001947
    DEC $0002, X

  loc_001947:
    DEC $0002, X

  loc_00194A:
    DEC $0002, X
    RTS 

  loc_00194E:
    LDA $0000, X
    CMP $16
    BCC loc_001956
    RTS 

  loc_001956:
    LDA $18
    SEC 
    SBC $0002, X
    CMP #$0011
    BCC loc_001962
    RTS 

  loc_001962:
    LDA $001E, X
    CMP #$0006
    BEQ loc_001975
    CMP #$0005
    BEQ loc_001972
    INC $0000, X

  loc_001972:
    INC $0000, X

  loc_001975:
    INC $0000, X
    RTS 

  loc_001979:
    LDA $0000, X
    CMP $16
    BCS loc_001981
    RTS 

  loc_001981:
    LDA $18
    SEC 
    SBC $0002, X
    CMP #$0011
    BCC loc_00198D
    RTS 

  loc_00198D:
    LDA $001E, X
    CMP #$0006
    BEQ loc_0019A0
    CMP #$0005
    BEQ loc_00199D
    DEC $0000, X

  loc_00199D:
    DEC $0000, X

  loc_0019A0:
    DEC $0000, X
    RTS 
}

code_0019A4 {
    COP [91]
    LDA $warp_dest_anim
    BEQ loc_0019AC
    RTL 

  loc_0019AC:
    PHX 
    LDA $0405
    ASL 
    TAX 
    LDA $switch_owner_table, X
    PLX 
    TAY 
    BNE loc_0019BB
    RTL 

  loc_0019BB:
    LDA $0000, X
    SEC 
    SBC $0000, Y
    BMI loc_0019E3
    STA $16
    LDA $0002, X
    SEC 
    SBC $0002, Y
    BMI loc_0019D7
    STA $18
    CMP $16
    BCS loc_001A10
    BRA loc_001A0B

  loc_0019D7:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCS loc_001A06
    BRA loc_001A0B

  loc_0019E3:
    EOR #$FFFF
    INC 
    STA $16
    LDA $0002, X
    SEC 
    SBC $0002, Y
    BMI loc_0019FA
    STA $18
    CMP $16
    BCS loc_001A10
    BRA loc_001A15

  loc_0019FA:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCS loc_001A06
    BRA loc_001A15

  loc_001A06:
    LDA #$0000
    BRA loc_001A18

  loc_001A0B:
    LDA #$0002
    BRA loc_001A18

  loc_001A10:
    LDA #$0001
    BRA loc_001A18

  loc_001A15:
    LDA #$0003

  loc_001A18:
    STA $001E, X
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    STZ $0014, X
    COP [91]
    RTL 
}

code_001A28 {
    STX $player_actor
    COP [A9] ( #$3000, #7F )
    COP [84] ( @common_actor_001A28_part4.code_002F56 )
    LDA $return_active
    BEQ loc_001A3D
    BRL code_0019A4

  loc_001A3D:
    COP [84] ( @common_actor_001A28_part2.code_001FE0 )
    LDA $0016, Y
    AND #$CF7F
    ORA #$0310
    STA $0016, Y
    STY $03A0
    COP [84] ( @code_001512 )
    COP [85] ( @code_0015E0 )
    COP [85] ( @common_actor_001A28_part2.code_001FCF )
    STY $039E
    COP [91]

  loc_001A65:
    LDA $0016, X
    BIT #$0400
    BEQ loc_001A70
    BRL engine_routines_001D3B.loc_001ED3

  loc_001A70:
    LDA $0439
    BNE loc_001A7A
    LDA $1B5E
    BNE loc_001ACD

  loc_001A7A:
    LDA $joy_pressed
    BIT #$0030
    BNE loc_001A9E
    EOR #$FFFF
    XBA 
    LSR 
    BCS loc_001A8C
    BRL engine_routines_001D3B.code_001E0D

  loc_001A8C:
    LSR 
    BCS loc_001A92
    BRL engine_routines_001D3B.code_001DEF

  loc_001A92:
    LSR 
    BCS loc_001A98
    BRL engine_routines_001D3B.code_001DD1

  loc_001A98:
    LSR 
    BCS loc_001A9E
    BRL engine_routines_001D3B.code_001DB3

  loc_001A9E:
    PHX 
    LDA $001E, X
    ASL 
    CLC 
    ADC $001E, X
    ASL 
    ASL 
    TAX 
    LDA $joy_pressed
    INX 
    INX 
    XBA 
    LSR 
    BCS loc_001AC4
    INX 
    INX 
    LSR 
    BCS loc_001AC4
    INX 
    INX 
    LSR 
    BCS loc_001AC4
    INX 
    INX 
    LSR 
    BCS loc_001AC4
    INX 
    INX 

  loc_001AC4:
    LDA $@code_list_001B2B, X
    PLX 
    DEC 
    PHA 
    CLC 
    RTS 

  loc_001ACD:
    LDA $joy_pressed
    BIT #$8030
    BNE loc_001AEE
    XBA 
    LSR 
    BCC loc_001ADC
    BRL engine_routines_001D3B.code_001E0D

  loc_001ADC:
    LSR 
    BCC loc_001AE2
    BRL engine_routines_001D3B.code_001DEF

  loc_001AE2:
    LSR 
    BCC loc_001AE8
    BRL engine_routines_001D3B.code_001DD1

  loc_001AE8:
    LSR 
    BCC loc_001AEE
    BRL engine_routines_001D3B.code_001DB3

  loc_001AEE:
    PHX 
    LDA $001E, X
    ASL 
    CLC 
    ADC $001E, X
    ASL 
    ASL 
    TAX 
    LDA $joy_pressed
    BIT #$8000
    BNE loc_001B19
    INX 
    INX 
    XBA 
    LSR 
    BCS loc_001B19
    INX 
    INX 
    LSR 
    BCS loc_001B19
    INX 
    INX 
    LSR 
    BCS loc_001B19
    INX 
    INX 
    LSR 
    BCS loc_001B19
    INX 
    INX 

  loc_001B19:
    CLC 
    LDA $joy_pressed
    BIT #$0030
    BNE loc_001B23
    SEC 

  loc_001B23:
    LDA $@code_list_001B2B, X
    PLX 
    DEC 
    PHA 
    RTS 
}
---------------------------------------------

code_list_001B2B [
  &engine_routines_001D3B.code_001F1B   ;00
  &engine_routines_001D3B.code_001EB7   ;01
  &engine_routines_001D3B.code_001E8D   ;02
  &engine_routines_001D3B.code_001DD1   ;03
  &engine_routines_001D3B.code_001E2B   ;04
  &engine_routines_001D3B.code_001D59   ;05
  &engine_routines_001D3B.code_001EFB   ;06
  &engine_routines_001D3B.code_001EA9   ;07
  &engine_routines_001D3B.code_001E7F   ;08
  &engine_routines_001D3B.code_001E55   ;09
  &engine_routines_001D3B.code_001DB3   ;0A
  &engine_routines_001D3B.code_001D3B   ;0B
  &engine_routines_001D3B.code_001F3B   ;0C
  &engine_routines_001D3B.code_001EC5   ;0D
  &engine_routines_001D3B.code_001DEF   ;0E
  &engine_routines_001D3B.code_001E63   ;0F
  &engine_routines_001D3B.code_001E39   ;10
  &engine_routines_001D3B.code_001D77   ;11
  &engine_routines_001D3B.code_001F5B   ;12
  &engine_routines_001D3B.code_001E0D   ;13
  &engine_routines_001D3B.code_001E9B   ;14
  &engine_routines_001D3B.code_001E71   ;15
  &engine_routines_001D3B.code_001E47   ;16
  &engine_routines_001D3B.code_001D95   ;17
  &engine_routines_001D3B.code_001F1B   ;18
  &engine_routines_001D3B.code_001EB7   ;19
  &engine_routines_001D3B.code_001E8D   ;1A
  &engine_routines_001D3B.code_001DD1   ;1B
  &engine_routines_001D3B.code_001E2B   ;1C
  &engine_routines_001D3B.code_001D59   ;1D
  &engine_routines_001D3B.code_001F1B   ;1E
  &engine_routines_001D3B.code_001EB7   ;1F
  &engine_routines_001D3B.code_001E8D   ;20
  &engine_routines_001D3B.code_001DD1   ;21
  &engine_routines_001D3B.code_001E2B   ;22
  &engine_routines_001D3B.code_001D59   ;23
  &engine_routines_001D3B.code_001EFB   ;24
  &engine_routines_001D3B.code_001EA9   ;25
  &engine_routines_001D3B.code_001E7F   ;26
  &engine_routines_001D3B.code_001E55   ;27
  &engine_routines_001D3B.code_001DB3   ;28
  &engine_routines_001D3B.code_001D3B   ;29
  &engine_routines_001D3B.code_001EFB   ;2A
  &engine_routines_001D3B.code_001EA9   ;2B
  &engine_routines_001D3B.code_001E7F   ;2C
  &engine_routines_001D3B.code_001E55   ;2D
  &engine_routines_001D3B.code_001DB3   ;2E
  &engine_routines_001D3B.code_001D3B   ;2F
  &engine_routines_001D3B.code_001F3B   ;30
  &engine_routines_001D3B.code_001EC5   ;31
  &engine_routines_001D3B.code_001DEF   ;32
  &engine_routines_001D3B.code_001E63   ;33
  &engine_routines_001D3B.code_001E39   ;34
  &engine_routines_001D3B.code_001D77   ;35
  &engine_routines_001D3B.code_001F3B   ;36
  &engine_routines_001D3B.code_001EC5   ;37
  &engine_routines_001D3B.code_001DEF   ;38
  &engine_routines_001D3B.code_001E63   ;39
  &engine_routines_001D3B.code_001E39   ;3A
  &engine_routines_001D3B.code_001D77   ;3B
  &engine_routines_001D3B.code_001F5B   ;3C
  &engine_routines_001D3B.code_001E0D   ;3D
  &engine_routines_001D3B.code_001E9B   ;3E
  &engine_routines_001D3B.code_001E71   ;3F
  &engine_routines_001D3B.code_001E47   ;40
  &engine_routines_001D3B.code_001D95   ;41
  &engine_routines_001D3B.code_001F5B   ;42
  &engine_routines_001D3B.code_001E0D   ;43
  &engine_routines_001D3B.code_001E9B   ;44
  &engine_routines_001D3B.code_001E71   ;45
  &engine_routines_001D3B.code_001E47   ;46
  &engine_routines_001D3B.code_001D95   ;47
  &engine_routines_001D3B.code_001F1B   ;48
  &engine_routines_001D3B.code_001EB7   ;49
  &engine_routines_001D3B.code_001E8D   ;4A
  &engine_routines_001D3B.code_001DD1   ;4B
  &engine_routines_001D3B.code_001E2B   ;4C
  &engine_routines_001D3B.code_001D59   ;4D
  &engine_routines_001D3B.code_001F1B   ;4E
  &engine_routines_001D3B.code_001EB7   ;4F
  &engine_routines_001D3B.code_001E8D   ;50
  &engine_routines_001D3B.code_001DD1   ;51
  &engine_routines_001D3B.code_001E2B   ;52
  &engine_routines_001D3B.code_001D59   ;53
  &engine_routines_001D3B.code_001EFB   ;54
  &engine_routines_001D3B.code_001EA9   ;55
  &engine_routines_001D3B.code_001E7F   ;56
  &engine_routines_001D3B.code_001E55   ;57
  &engine_routines_001D3B.code_001DB3   ;58
  &engine_routines_001D3B.code_001D3B   ;59
  &engine_routines_001D3B.code_001EFB   ;5A
  &engine_routines_001D3B.code_001EA9   ;5B
  &engine_routines_001D3B.code_001E7F   ;5C
  &engine_routines_001D3B.code_001E55   ;5D
  &engine_routines_001D3B.code_001DB3   ;5E
  &engine_routines_001D3B.code_001D3B   ;5F
  &engine_routines_001D3B.code_001F3B   ;60
  &engine_routines_001D3B.code_001EC5   ;61
  &engine_routines_001D3B.code_001DEF   ;62
  &engine_routines_001D3B.code_001E63   ;63
  &engine_routines_001D3B.code_001E39   ;64
  &engine_routines_001D3B.code_001D77   ;65
  &engine_routines_001D3B.code_001F3B   ;66
  &engine_routines_001D3B.code_001EC5   ;67
  &engine_routines_001D3B.code_001DEF   ;68
  &engine_routines_001D3B.code_001E63   ;69
  &engine_routines_001D3B.code_001E39   ;6A
  &engine_routines_001D3B.code_001D77   ;6B
  &engine_routines_001D3B.code_001F5B   ;6C
  &engine_routines_001D3B.code_001E0D   ;6D
  &engine_routines_001D3B.code_001E9B   ;6E
  &engine_routines_001D3B.code_001E71   ;6F
  &engine_routines_001D3B.code_001E47   ;70
  &engine_routines_001D3B.code_001D95   ;71
  &engine_routines_001D3B.code_001F5B   ;72
  &engine_routines_001D3B.code_001E0D   ;73
  &engine_routines_001D3B.code_001E9B   ;74
  &engine_routines_001D3B.code_001E71   ;75
  &engine_routines_001D3B.code_001E47   ;76
  &engine_routines_001D3B.code_001D95   ;77
  &engine_routines_001D3B.code_001D3B   ;78
  &engine_routines_001D3B.code_001D3B   ;79
  &engine_routines_001D3B.code_001D3B   ;7A
  &engine_routines_001D3B.code_001D3B   ;7B
  &engine_routines_001D3B.code_001D3B   ;7C
  &engine_routines_001D3B.code_001D3B   ;7D
  &engine_routines_001D3B.code_001D3B   ;7E
  &engine_routines_001D3B.code_001D3B   ;7F
  &engine_routines_001D3B.code_001D3B   ;80
  &engine_routines_001D3B.code_001D3B   ;81
  &engine_routines_001D3B.code_001D3B   ;82
  &engine_routines_001D3B.code_001D3B   ;83
  &engine_routines_001D3B.code_001D3B   ;84
  &engine_routines_001D3B.code_001D3B   ;85
  &engine_routines_001D3B.code_001D3B   ;86
  &engine_routines_001D3B.code_001D3B   ;87
  &engine_routines_001D3B.code_001D3B   ;88
  &engine_routines_001D3B.code_001D3B   ;89
  &engine_routines_001D3B.code_001D3B   ;8A
  &engine_routines_001D3B.code_001D3B   ;8B
  &engine_routines_001D3B.code_001D3B   ;8C
  &engine_routines_001D3B.code_001D3B   ;8D
  &engine_routines_001D3B.code_001D3B   ;8E
  &engine_routines_001D3B.code_001D3B   ;8F
  &engine_routines_001D3B.code_001D3B   ;90
  &engine_routines_001D3B.code_001D3B   ;91
  &engine_routines_001D3B.code_001D3B   ;92
  &engine_routines_001D3B.code_001D3B   ;93
  &engine_routines_001D3B.code_001D3B   ;94
  &engine_routines_001D3B.code_001D3B   ;95
  &engine_routines_001D3B.code_001D3B   ;96
  &engine_routines_001D3B.code_001D3B   ;97
  &engine_routines_001D3B.code_001D3B   ;98
  &engine_routines_001D3B.code_001D3B   ;99
  &engine_routines_001D3B.code_001D3B   ;9A
  &engine_routines_001D3B.code_001D3B   ;9B
  &engine_routines_001D3B.code_001D3B   ;9C
  &engine_routines_001D3B.code_001D3B   ;9D
  &engine_routines_001D3B.code_001D3B   ;9E
  &engine_routines_001D3B.code_001D3B   ;9F
  &engine_routines_001D3B.code_001D3B   ;A0
  &engine_routines_001D3B.code_001D3B   ;A1
  &engine_routines_001D3B.code_001D3B   ;A2
  &engine_routines_001D3B.code_001D3B   ;A3
  &engine_routines_001D3B.code_001D3B   ;A4
  &engine_routines_001D3B.code_001D3B   ;A5
  &engine_routines_001D3B.code_001D3B   ;A6
  &engine_routines_001D3B.code_001D3B   ;A7
  &engine_routines_001D3B.code_001D3B   ;A8
  &engine_routines_001D3B.code_001D3B   ;A9
  &engine_routines_001D3B.code_001D3B   ;AA
  &engine_routines_001D3B.code_001D3B   ;AB
  &engine_routines_001D3B.code_001D3B   ;AC
  &engine_routines_001D3B.code_001D3B   ;AD
  &engine_routines_001D3B.code_001D3B   ;AE
  &engine_routines_001D3B.code_001D3B   ;AF
  &engine_routines_001D3B.code_001D3B   ;B0
  &engine_routines_001D3B.code_001D3B   ;B1
  &engine_routines_001D3B.code_001D3B   ;B2
  &engine_routines_001D3B.code_001D3B   ;B3
  &engine_routines_001D3B.code_001D3B   ;B4
  &engine_routines_001D3B.code_001D3B   ;B5
  &engine_routines_001D3B.code_001D3B   ;B6
  &engine_routines_001D3B.code_001D3B   ;B7
  &engine_routines_001D3B.code_001D3B   ;B8
  &engine_routines_001D3B.code_001D3B   ;B9
  &engine_routines_001D3B.code_001D3B   ;BA
  &engine_routines_001D3B.code_001D3B   ;BB
  &engine_routines_001D3B.code_001D3B   ;BC
  &engine_routines_001D3B.code_001D3B   ;BD
  &engine_routines_001D3B.code_001D3B   ;BE
  &engine_routines_001D3B.code_001D3B   ;BF
  &engine_routines_001D3B.code_001F1B   ;C0
  &engine_routines_001D3B.code_001EB7   ;C1
  &engine_routines_001D3B.code_001E8D   ;C2
  &engine_routines_001D3B.code_001DD1   ;C3
  &engine_routines_001D3B.code_001E2B   ;C4
  &engine_routines_001D3B.code_001D59   ;C5
  &engine_routines_001D3B.code_001EFB   ;C6
  &engine_routines_001D3B.code_001EA9   ;C7
  &engine_routines_001D3B.code_001E7F   ;C8
  &engine_routines_001D3B.code_001E55   ;C9
  &engine_routines_001D3B.code_001DB3   ;CA
  &engine_routines_001D3B.code_001D3B   ;CB
  &engine_routines_001D3B.code_001F3B   ;CC
  &engine_routines_001D3B.code_001EC5   ;CD
  &engine_routines_001D3B.code_001DEF   ;CE
  &engine_routines_001D3B.code_001E63   ;CF
  &engine_routines_001D3B.code_001E39   ;D0
  &engine_routines_001D3B.code_001D77   ;D1
  &engine_routines_001D3B.code_001F5B   ;D2
  &engine_routines_001D3B.code_001E0D   ;D3
  &engine_routines_001D3B.code_001E9B   ;D4
  &engine_routines_001D3B.code_001E71   ;D5
  &engine_routines_001D3B.code_001E47   ;D6
  &engine_routines_001D3B.code_001D95   ;D7
  &engine_routines_001D3B.code_001F5B   ;D8
  &engine_routines_001D3B.code_001E0D   ;D9
  &engine_routines_001D3B.code_001E9B   ;DA
  &engine_routines_001D3B.code_001E71   ;DB
  &engine_routines_001D3B.code_001E47   ;DC
  &engine_routines_001D3B.code_001D95   ;DD
  &engine_routines_001D3B.code_001F5B   ;DE
  &engine_routines_001D3B.code_001E0D   ;DF
  &engine_routines_001D3B.code_001E9B   ;E0
  &engine_routines_001D3B.code_001E71   ;E1
  &engine_routines_001D3B.code_001E47   ;E2
  &engine_routines_001D3B.code_001D95   ;E3
  &engine_routines_001D3B.code_001F3B   ;E4
  &engine_routines_001D3B.code_001EC5   ;E5
  &engine_routines_001D3B.code_001DEF   ;E6
  &engine_routines_001D3B.code_001E63   ;E7
  &engine_routines_001D3B.code_001E39   ;E8
  &engine_routines_001D3B.code_001D77   ;E9
  &engine_routines_001D3B.code_001F3B   ;EA
  &engine_routines_001D3B.code_001EC5   ;EB
  &engine_routines_001D3B.code_001DEF   ;EC
  &engine_routines_001D3B.code_001E63   ;ED
  &engine_routines_001D3B.code_001E39   ;EE
  &engine_routines_001D3B.code_001D77   ;EF
  &engine_routines_001D3B.code_001F1B   ;F0
  &engine_routines_001D3B.code_001EB7   ;F1
  &engine_routines_001D3B.code_001E8D   ;F2
  &engine_routines_001D3B.code_001DD1   ;F3
  &engine_routines_001D3B.code_001E2B   ;F4
  &engine_routines_001D3B.code_001D59   ;F5
  &engine_routines_001D3B.code_001F1B   ;F6
  &engine_routines_001D3B.code_001EB7   ;F7
  &engine_routines_001D3B.code_001E8D   ;F8
  &engine_routines_001D3B.code_001DD1   ;F9
  &engine_routines_001D3B.code_001E2B   ;FA
  &engine_routines_001D3B.code_001D59   ;FB
  &engine_routines_001D3B.code_001EFB   ;FC
  &engine_routines_001D3B.code_001EA9   ;FD
  &engine_routines_001D3B.code_001E7F   ;FE
  &engine_routines_001D3B.code_001E55   ;FF
  &engine_routines_001D3B.code_001DB3   ;100
  &engine_routines_001D3B.code_001D3B   ;101
  &engine_routines_001D3B.code_001EFB   ;102
  &engine_routines_001D3B.code_001EA9   ;103
  &engine_routines_001D3B.code_001E7F   ;104
  &engine_routines_001D3B.code_001E55   ;105
  &engine_routines_001D3B.code_001DB3   ;106
  &engine_routines_001D3B.code_001D3B   ;107
]