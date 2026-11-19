?BANK 02

?INCLUDE 'asset_list_028000'
?INCLUDE 'common_shared_0FEEA6'
?INCLUDE 'lib_0133A6_part1'
?INCLUDE 'lib_0133A6_part2'
?INCLUDE 'lib_0133A6_part4'
?INCLUDE 'lib_shared_0131D1'

!area_current                   0314
!scene_current                  0316
!map_width_px                   0342
!map_height_px                  0344
!location_id                    1C6A
!INIDISP                        2100
!OBJSEL                         2101
!OAMADDL                        2102
!OAMADDH                        2103
!BGMODE                         2105
!MOSAIC                         2106
!BG1SC                          2107
!BG2SC                          2108
!BG3SC                          2109
!BG4SC                          210A
!BG12NBA                        210B
!BG34NBA                        210C
!BG1HOFS                        210D
!BG1VOFS                        210E
!BG2HOFS                        210F
!BG2VOFS                        2110
!BG3HOFS                        2111
!BG3VOFS                        2112
!BG4HOFS                        2113
!BG4VOFS                        2114
!VMAIN                          2115
!VMADDL                         2116
!VMADDH                         2117
!VMDATAL                        2118
!VMDATAH                        2119
!M7SEL                          211A
!M7A                            211B
!M7B                            211C
!M7C                            211D
!M7D                            211E
!M7X                            211F
!M7Y                            2120
!CGADD                          2121
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!WH0                            2126
!WH1                            2127
!WH2                            2128
!WH3                            2129
!WBGLOG                         212A
!WOBJLOG                        212B
!TM                             212C
!TS                             212D
!TMW                            212E
!TSW                            212F
!CGWSEL                         2130
!CGADSUB                        2131
!COLDATA                        2132
!SETINI                         2133
!APUIO0                         2140
!NMITIMEN                       4200
!WRIO                           4201
!WRMPYA                         4202
!WRMPYB                         4203
!WRDIVL                         4204
!WRDIVH                         4205
!WRDIVB                         4206
!HTIMEL                         4207
!HTIMEH                         4208
!VTIMEL                         4209
!VTIMEH                         420A
!MDMAEN                         420B
!HDMAEN                         420C
!MEMSEL                         420D
!cgram_buffer                   7F0000

---------------------------------------------

code_013272 {
    PHP 
    PHB 
    PHX 
    PHY 
    REP #$10
    SEP #$20
    LDA #$7E
    PHA 
    PLB 
    LDX #$0100
    STX $1F
    STX $21
    LDA #$20

  loc_013287:
    STA ($1F)
    INC $1F
    BNE loc_013287
    LDA #$EF
    STA $1F
    LDA #$80
    STA $1E
    LDX $25
    LDY $23

  loc_013299:
    LDA [$29]
    AND $1E
    PHA 
    LSR $1E
    BCC loc_0132AA
    ROR $1E
    INC $29
    BNE loc_0132AA
    INC $2A

  loc_0132AA:
    PLA 
    BEQ loc_0132BD
    JSR $&code_0132E2
    STA $0000, X
    INX 
    STA ($1F)
    INC $1F
    DEY 
    BNE loc_013299
    BRA loc_0132DD

  loc_0132BD:
    JSR $&code_0132E2
    STA $21
    JSR $&code_01333F
    INC 
    INC 

  loc_0132C7:
    XBA 
    LDA ($21)
    INC $21
    STA ($1F)
    INC $1F
    STA $0000, X
    INX 
    DEY 
    BEQ loc_0132DD
    XBA 
    DEC 
    BNE loc_0132C7
    BRA loc_013299

  loc_0132DD:
    PLY 
    PLX 
    PLB 
    PLP 
    RTL 
}

code_0132E2 {
    LDA $1E
    BMI loc_013329
    ASL 
    BMI loc_013322
    ASL 
    BMI loc_01331B
    ASL 
    BMI loc_013314
    ASL 
    BMI loc_01330D
    ASL 
    BMI loc_013306
    ASL 
    BMI loc_0132FF
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013332

  loc_0132FF:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013333

  loc_013306:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013334

  loc_01330D:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013335

  loc_013314:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013336

  loc_01331B:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013337

  loc_013322:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013338

  loc_013329:
    LDA [$29]
    REP #$20
    INC $29
    SEP #$20
    RTS 

  loc_013332:
    ASL 

  loc_013333:
    ASL 

  loc_013334:
    ASL 

  loc_013335:
    ASL 

  loc_013336:
    ASL 

  loc_013337:
    ASL 

  loc_013338:
    ASL 
    INC $29
    XBA 
    SEP #$20
    RTS 
}

code_01333F {
    LDA $1E
    CMP #$10
    BCC loc_013361
    LSR 
    LSR 
    LSR 
    LSR 
    STA $1E
    XBA 
    LDA [$29]
    XBA 
    REP #$20
    LSR 
    BCS loc_01335B
    LSR 
    BCS loc_01335B
    LSR 
    BCS loc_01335B
    LSR 

  loc_01335B:
    SEP #$20
    XBA 
    AND #$0F
    RTS 

  loc_013361:
    LSR 
    BCS loc_013392
    LSR 
    BCS loc_013385
    LSR 
    BCS loc_013379
    LDA #$80
    STA $1E
    LDA [$29]
    REP #$20
    INC $29
    SEP #$20
    AND #$0F
    RTS 

  loc_013379:
    LDA #$40
    STA $1E
    REP #$20
    LDA [$29]
    XBA 
    ASL 
    BRA loc_01339E

  loc_013385:
    LDA #$20
    STA $1E
    REP #$20
    LDA [$29]
    XBA 
    ASL 
    ASL 
    BRA loc_01339E

  loc_013392:
    LDA #$10
    STA $1E
    REP #$20
    LDA [$29]
    XBA 
    ASL 
    ASL 
    ASL 

  loc_01339E:
    INC $29
    SEP #$20
    XBA 
    AND #$0F
    RTS 
}

code_0133A6 {
    PHP 
    SEP #$20
    REP #$10
    JSR $&code_0133FF

  loc_0133AE:
    JSR $&code_01393F
    CMP #$00
    BEQ loc_0133FD
    BIT #$80
    BEQ loc_0133BE
    JSR $&code_01343F
    BRA loc_0133AE

  loc_0133BE:
    BIT #$40
    BEQ loc_0133C7
    JSR $&code_013532
    BRA loc_0133AE

  loc_0133C7:
    BIT #$20
    BEQ loc_0133D0
    JSR $&code_013571
    BRA loc_0133AE

  loc_0133D0:
    BIT #$10
    BEQ loc_0133D9
    JSR $&code_01362B
    BRA loc_0133AE

  loc_0133D9:
    BIT #$08
    BEQ loc_0133E2
    JSR $&code_013759
    BRA loc_0133AE

  loc_0133E2:
    BIT #$04
    BEQ loc_0133EB
    JSR $&code_013894
    BRA loc_0133AE

  loc_0133EB:
    BIT #$02
    BEQ loc_0133F4
    JSR $&code_01389E
    BRA loc_0133AE

  loc_0133F4:
    BIT #$01
    BEQ loc_0133AE
    JSR $&code_0138FB
    BRA loc_0133AE

  loc_0133FD:
    PLP 
    RTL 
}

code_0133FF {
    LDY #$0000

  loc_013402:
    LDA [$2F], Y
    INY 
    XBA 
    LDA [$2F], Y
    INY 
    CMP $scene_current
    BNE loc_013415
    XBA 
    CMP $area_current
    BNE loc_013415
    RTS 

  loc_013415:
    JSR $&code_01393F
    CMP #$00
    BEQ loc_013402
    ASL 
    BCS loc_013437
    ASL 
    BCS loc_013437
    ASL 
    BCS loc_013436
    ASL 
    BCS loc_013439
    ASL 
    BCS loc_01343C
    ASL 
    BCS loc_01343A
    ASL 
    BCS loc_013438
    ASL 
    BCS loc_013437
    BRA loc_0134AA

  loc_013436:
    INY 

  loc_013437:
    INY 

  loc_013438:
    INY 

  loc_013439:
    INY 

  loc_01343A:
    INY 
    INY 

  loc_01343C:
    INY 
    BRA loc_013415
}

code_01343F {
    LDA $03B4
    BIT #$08
    BEQ loc_01344D
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_01344D:
    PHP 
    REP #$20
    JSR $&code_01393F
    XBA 
    STA $00
    JSR $&code_01393F
    XBA 
    ASL 
    STA $02
    JSR $&code_01393F
    PHA 
    XBA 
    CLC 
    ADC #$0000
    STA $VMADDL
    LDX #$0029
    JSR $&code_013731
    LDA $01, S
    BEQ loc_013484
    CMP #$0010
    BEQ loc_01348E
    CMP #$0020
    BEQ loc_013498
    CMP #$0030
    BEQ loc_0134A2
    BRA loc_0134AD

  loc_013484:
    LDX #$0407
    JSR $&code_013983
    BCS loc_0134B9
    BRA loc_0134AA

  loc_01348E:
    LDX #$040A
    JSR $&code_013983
    BCS loc_0134B9
    BRA loc_0134AA

  loc_013498:
    LDX #$040D
    JSR $&code_013983
    BCS loc_0134B9
    BRA loc_0134AA

  loc_0134A2:
    LDX #$0410
    JSR $&code_013983
    BCS loc_0134B9

  loc_0134AA:
    PLA 
    PLP 
    RTS 

  loc_0134AD:
    STZ $0407
    STZ $040A
    STZ $040D
    STZ $0410

  loc_0134B9:
    ASL $00
    BCC loc_0134F0
    PLA 
    CMP #$00FF
    BEQ loc_0134D4
    PHY 
    LDY $00

  loc_0134C6:
    LDA [$29], Y
    STA $VMDATAL
    INY 
    INY 
    CPY $02
    BNE loc_0134C6
    PLY 
    PLP 
    RTS 

  loc_0134D4:
    LDX #$0000
    STX $VMADDL
    PHY 
    SEP #$20
    LDY #$0000

  loc_0134E0:
    LDA [$29], Y
    STA $VMDATAH
    INY 
    CPY #$4000
    BNE loc_0134E0
    REP #$20
    PLY 
    PLP 
    RTS 

  loc_0134F0:
    LDA [$29]
    STA $23
    INC $29
    INC $29
    LDX #$6000
    STX $25
    JSL $@code_013272
    PLA 
    CMP #$00FF
    BEQ loc_013518
    LDX $00

  loc_013509:
    LDA $7E6000, X
    STA $VMDATAL
    INX 
    INX 
    CPX $02
    BNE loc_013509
    PLP 
    RTS 

  loc_013518:
    LDX #$0000
    STX $VMADDL
    SEP #$20
    LDX #$0000

  loc_013523:
    LDA $7E6000, X
    STA $VMDATAH
    INX 
    CPX #$4000
    BNE loc_013523
    PLP 
    RTS 
}

code_013532 {
    LDA $03B4
    BIT #$04
    BEQ loc_013540
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013540:
    PHP 
    REP #$20
    JSR $&code_01393F
    ASL 
    STA $00
    JSR $&code_01393F
    ASL 
    STA $02
    JSR $&code_01393F
    ASL 
    STA $04
    LDX #$0029
    JSR $&code_013731
    PHY 
    LDY $00
    LDX $04

  loc_013560:
    LDA [$29], Y
    STA $cgram_buffer, X
    INY 
    INY 
    INX 
    INX 
    CPY $02
    BNE loc_013560
    PLY 
    PLP 
    RTS 
}

code_013571 {
    LDA $03B4
    BIT #$02
    BEQ loc_013580
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013580:
    PHP 
    REP #$20
    JSR $&code_01393F
    XBA 
    STA $06
    AND #$7FFF
    LSR 
    LSR 
    STA $00
    JSR $&code_01393F
    XBA 
    LSR 
    LSR 
    STA $02
    JSR $&code_01393F
    XBA 
    LSR 
    LSR 
    STA $04
    JSR $&code_01393F
    PHA 
    LDX #$0029
    JSR $&code_013731
    LDA $01, S
    CMP #$0001
    BEQ loc_0135B8
    CMP #$0002
    BEQ loc_0135C2
    BRA loc_0135CD

  loc_0135B8:
    LDX #$0413
    JSR $&code_013983
    BCS loc_0135D3
    BRA loc_0135CA

  loc_0135C2:
    LDX #$0416
    JSR $&code_013983
    BCS loc_0135D3

  loc_0135CA:
    PLA 
    PLP 
    RTS 

  loc_0135CD:
    STZ $0413
    STZ $0416

  loc_0135D3:
    LDA $06
    BPL loc_0135EE
    LDA #$6000
    STA $2C
    PHY 
    LDY #$0000

  loc_0135E0:
    LDA [$29], Y
    STA [$2C], Y
    INY 
    INY 
    CPY #$0800
    BNE loc_0135E0
    PLY 
    BRA loc_0135FF

  loc_0135EE:
    LDA [$29]
    STA $23
    INC $29
    INC $29
    LDX #$6000
    STX $25
    JSL $@code_013272

  loc_0135FF:
    PLA 
    LDX #$2000
    JSR $&code_01360E
    LDX #$2800
    JSR $&code_01360E
    PLP 
    RTS 
}

code_01360E {
    LSR 
    BCC loc_01362A
    PHA 
    PHY 
    STX $2C
    LDX $00
    LDY $04

  loc_013619:
    LDA $7E6000, X
    XBA 
    STA [$2C], Y
    INX 
    INX 
    INY 
    INY 
    CPX $02
    BNE loc_013619
    PLY 
    PLA 

  loc_01362A:
    RTS 
}

code_01362B {
    LDA $03B4
    BIT #$01
    BEQ loc_013637
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013637:
    PHP 
    REP #$20
    JSR $&code_01393F
    STA $04
    LDX #$0029
    JSR $&code_013731
    LDA $04
    CMP #$0001
    BEQ loc_01365B
    CMP #$0002
    BNE loc_013665
    LDX #$041C
    JSR $&code_013983
    BCS loc_01366B
    PLP 
    RTS 

  loc_01365B:
    LDX #$0419
    JSR $&code_013983
    BCS loc_01366B
    PLP 
    RTS 

  loc_013665:
    STZ $0419
    STZ $041C

  loc_01366B:
    LDA [$29]
    INC $29
    AND #$00FF
    XBA 
    STA $00
    LDA [$29]
    INC $29
    AND #$00FF
    XBA 
    STA $02
    SEP #$20
    LDA $01
    XBA 
    LDA $03
    JSL $@lib_shared_0131D1.code_0131D1
    REP #$20
    XBA 
    STA $23
    LDA $03
    BMI loc_01369B
    LDA [$29]
    STA $23
    INC $29
    INC $29

  loc_01369B:
    LDA $04
    AND #$FF7F
    BNE loc_0136A7
    JSR $&code_0136EA
    BRA loc_0136B7

  loc_0136A7:
    LDX #$0000
    JSR $&code_0136B9
    BCS loc_0136B7
    LDX #$0004
    JSR $&code_0136B9
    BCS loc_0136B7

  loc_0136B7:
    PLP 
    RTS 
}

code_0136B9 {
    LSR 
    BCC loc_0136E9
    PHA 
    PHY 
    LDA $00
    STA $map_width_px, X
    LDA $02
    STA $map_height_px, X
    LDY $0352, X
    LDA $03
    BPL loc_0136E0
    STY $2C
    LDY #$0000

  loc_0136D4:
    LDA [$29], Y
    STA [$2C], Y
    INY 
    INY 
    CPY $23
    BNE loc_0136D4
    BRA loc_0136E6

  loc_0136E0:
    STY $25
    JSL $@code_013272

  loc_0136E6:
    PLY 
    PLA 
    SEC 

  loc_0136E9:
    RTS 
}

code_0136EA {
    PHP 
    PHY 
    LDA $03
    BPL loc_013705
    LDY #$C000
    STY $2C
    LDY #$0000

  loc_0136F8:
    LDA [$29], Y
    STA [$2C], Y
    INY 
    INY 
    CPY #$4000
    BNE loc_0136F8
    BRA loc_01370E

  loc_013705:
    LDX #$C000
    STX $25
    JSL $@code_013272

  loc_01370E:
    SEP #$20
    LDX #$0000
    STX $VMADDL
    STZ $VMAIN
    LDX #$0000

  loc_01371C:
    LDA $7EC000, X
    STA $VMDATAL
    INX 
    CPX #$4000
    BNE loc_01371C
    LDA #$80
    STA $VMAIN
    PLY 
    PLP 
    RTS 
}

code_013731 {
    PHP 
    REP #$20
    LDA [$2F], Y
    INY 
    INY 
    STA $29
    SEP #$20
    LDA [$2F], Y
    INY 
    STA $2B
    REP #$20
    LDA $0001, X
    AND #$007F
    PHA 
    EOR $0001, X
    ASL 
    ORA #$0080
    ORA $01, S
    STA $0001, X
    PLA 
    PLP 
    RTS 
}

code_013759 {
    JSR $&code_01393F
    BIT #$80
    BEQ loc_01376B
    BIT #$40
    BEQ loc_013765
    RTS 

  loc_013765:
    ORA #$40
    JSR $&code_01394A
    RTS 

  loc_01376B:
    STA $location_id
    PHY 
    REP #$20
    AND #$00FF
    ASL 
    TAX 
    LDA $@lib_0133A6_part4.binary_list_0168A1, X
    SEC 
    SBC #$&lib_0133A6_part4.binary_list_0168A1
    TAX 
    SEP #$20
    LDA $@lib_0133A6_part4.binary_list_0168A1, X
    STA $TM
    STA $TMW
    STA $03C0
    LDA $@lib_0133A6_part4.binary_list_0168A1+1, X
    STA $TS
    STA $TSW
    LDA $@lib_0133A6_part4.binary_list_0168A1+2, X
    STA $CGWSEL
    LDA $@lib_0133A6_part4.binary_list_0168A1+3, X
    STA $CGADSUB
    STA $03C1
    LDA $@lib_0133A6_part4.binary_list_0168A1+4, X
    AND #$30
    STA $0373
    LDA $@lib_0133A6_part4.binary_list_0168A1+4, X
    STZ $036B
    STZ $036F
    LDY #$2000
    ROR 
    BCC loc_0137C5
    STY $036A

  loc_0137C5:
    ROR 
    BCC loc_0137CB
    STY $036E

  loc_0137CB:
    ROR 
    ROR 
    ROR 
    ROR 
    LDY #$00E0
    ROR 
    BCC loc_0137D8
    LDY #$0100

  loc_0137D8:
    STY $03CA
    ROR 
    BCS loc_0137E3
    LDA #$01
    TSB $036F

  loc_0137E3:
    LDY #$FDFF
    STY $035C
    STY $0360
    STZ $03DB
    LDA $@lib_0133A6_part4.binary_list_0168A1+5, X
    BPL loc_0137F8
    INC $03DB

  loc_0137F8:
    LDA $03DB
    BNE loc_01381A
    LDA $@lib_0133A6_part4.binary_list_0168A1+5, X
    PHA 
    AND #$03
    CLC 
    ADC #$60
    STA $BG1SC
    PLA 
    LSR 
    LSR 
    AND #$03
    CLC 
    ADC #$70
    STA $BG2SC
    STA $03C2
    BRA loc_013835

  loc_01381A:
    LDA $@lib_0133A6_part4.binary_list_0168A1+5, X
    PHA 
    AND #$03
    CLC 
    ADC #$70
    STA $BG1SC
    PLA 
    LSR 
    LSR 
    AND #$03
    CLC 
    ADC #$60
    STA $BG2SC
    STA $03C2

  loc_013835:
    LDA $@lib_0133A6_part4.binary_list_0168A1+6, X
    STA $BGMODE
    PHX 
    LDY #$0000

  loc_013840:
    LDA $@lib_0133A6_part4.binary_list_0168A1+7, X
    AND #$0F
    STA $034B, Y
    LDA $@lib_0133A6_part4.binary_list_0168A1+7, X
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    STA $034A, Y
    INX 
    INY 
    INY 
    CPY #$0008
    BNE loc_013840
    PLX 
    LDA $031E
    BEQ loc_013866
    BRA loc_01386C

  loc_013866:
    JSL $@lib_0133A6_part1.code_011662
    BCC loc_013874

  loc_01386C:
    LDA $@lib_0133A6_part4.binary_list_0168A1+B, X
    AND #$3F
    BRA loc_01387D

  loc_013874:
    LDA $@lib_0133A6_part4.binary_list_0168A1+B, X
    BPL loc_01387D
    INC $031E

  loc_01387D:
    ASL 
    BPL loc_013883
    INC $031E

  loc_013883:
    ASL 
    BPL loc_013889
    INC $0439

  loc_013889:
    LDA $@lib_0133A6_part4.binary_list_0168A1+B, X
    AND #$0F
    STA $03BA
    PLY 
    RTS 
}

code_013894 {
    JSR $&code_01393F
    JSR $&code_01393F
    JSR $&code_01393F
    RTS 
}

code_01389E {
    LDA $03B4
    BIT #$20
    BEQ loc_0138AB
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_0138AB:
    JSR $&code_01393F
    STA $031A
    JSR $&code_01393F
    STA $031C
    LDX #$0029
    JSR $&code_013731
    LDA $031E
    CMP $031C
    BEQ loc_0138C6
    RTS 

  loc_0138C6:
    LDX #$0422
    JSR $&code_013983
    BCS loc_0138CF
    RTS 

  loc_0138CF:
    LDA #$F0
    STA $APUIO0

  loc_0138D4:
    LDA $APUIO0
    BNE loc_0138D4
    LDA #$02
    JSL $@lib_0133A6_part2.code_0131C9
    LDA #$FF
    STA $APUIO0
    LDA #$02
    JSL $@lib_0133A6_part2.code_0131C9
    JSL $@common_shared_0FEEA6.code_0FEFF5
    LDA #$03
    JSL $@lib_0133A6_part2.code_0131C9
    LDA $031A
    STA $APUIO0
    RTS 
}

code_0138FB {
    LDA $03B4
    BIT #$10
    BEQ loc_013909
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013909:
    JSR $&code_01393F
    PHA 
    JSR $&code_01393F
    JSR $&code_01393F
    LDX #$0029
    JSR $&code_013731
    LDX #$041F
    JSR $&code_013983
    BCS loc_013923
    PLA 
    RTS 

  loc_013923:
    REP #$20
    LDA [$29]
    STA $23
    INC $29
    INC $29
    SEP #$20
    LDX #$3800
    PLA 
    BEQ loc_013938
    LDX #$F000

  loc_013938:
    STX $25
    JSL $@code_013272
    RTS 
}

code_01393F {
    PHP 
    REP #$20
    LDA [$2F], Y
    INY 
    AND #$00FF
    PLP 
    RTS 
}

code_01394A {
    STA $00
    LDY #$0000

  loc_01394F:
    INY 
    INY 

  loc_013951:
    LDA [$2F], Y
    INY 
    CMP #$00
    BEQ loc_01394F
    ASL 
    BCS loc_013973
    ASL 
    BCS loc_013973
    ASL 
    BCS loc_013972
    ASL 
    BCS loc_013975
    ASL 
    BCS loc_01397B
    ASL 
    BCS loc_013976
    ASL 
    BCS loc_013974
    ASL 
    BCS loc_013973
    BRA loc_0139E6

  loc_013972:
    INY 

  loc_013973:
    INY 

  loc_013974:
    INY 

  loc_013975:
    INY 

  loc_013976:
    INY 
    INY 
    INY 
    BRA loc_013951

  loc_01397B:
    LDA [$2F], Y
    INY 
    CMP $00
    BNE loc_013951
    RTS 
}

code_013983 {
    PHP 
    REP #$20
    LDA $29
    CMP $0000, X
    BNE loc_01399B
    SEP #$20
    LDA $2B
    CMP $0002, X
    BNE loc_01399B
    REP #$20
    PLP 
    CLC 
    RTS 

  loc_01399B:
    SEP #$20
    LDA $2B
    STA $0002, X
    REP #$20
    LDA $29
    STA $0000, X
    PLP 
    SEC 
    RTS 
}

code_0139AC {
    PHP 
    SEP #$20
    REP #$10
    LDA #$80
    STA $INIDISP
    STZ $OBJSEL
    STZ $OAMADDL
    STZ $OAMADDH
    STZ $BGMODE
    STZ $MOSAIC
    STZ $BG1SC
    STZ $BG2SC
    STZ $BG3SC
    STZ $BG4SC
    STZ $BG12NBA
    STZ $BG34NBA
    STZ $BG1HOFS
    STZ $BG1HOFS
    STZ $BG1VOFS
    STZ $BG1VOFS
    STZ $BG2HOFS

  loc_0139E6:
    STZ $BG2HOFS
    STZ $BG2VOFS
    STZ $BG2VOFS
    STZ $BG3HOFS
    STZ $BG3HOFS
    STZ $BG3VOFS
    STZ $BG3VOFS
    STZ $BG4HOFS
    STZ $BG4HOFS
    STZ $BG4VOFS
    STZ $BG4VOFS
    LDA #$80
    STA $VMAIN
    STZ $VMADDL
    STZ $VMADDH
    LDA #$80
    STA $M7SEL
    LDA #$01
    STZ $M7A
    STA $M7A
    STZ $M7B
    STZ $M7B
    STZ $M7C
    STZ $M7C
    STZ $M7D
    STA $M7D
    STZ $M7X
    STZ $M7X
    STZ $M7Y
    STZ $M7Y
    STZ $CGADD
    STZ $W12SEL
    STZ $W34SEL
    STZ $WOBJSEL
    STZ $WH0
    STZ $WH1
    STZ $WH2
    STZ $WH3
    STZ $WBGLOG
    STZ $WOBJLOG
    STZ $TM
    STZ $TS
    STZ $TMW
    STZ $TSW
    LDA #$02
    STA $CGWSEL
    STZ $CGADSUB
    LDA #$E0
    STA $COLDATA
    STZ $SETINI
    STZ $NMITIMEN
    LDA #$FF
    STA $WRIO
    LDA #$00
    STZ $WRMPYA
    STZ $WRMPYB
    STZ $WRDIVL
    STZ $WRDIVH
    STZ $WRDIVB
    STZ $HTIMEL
    STZ $HTIMEH
    STZ $VTIMEL
    STZ $VTIMEH
    STZ $MDMAEN
    STZ $HDMAEN
    STZ $MEMSEL
    REP #$20
    LDX #$0000
    LDA #$0000

  loc_013AAD:
    STA $0000, X
    INX 
    INX 
    CPX #$1F00
    BNE loc_013AAD
    LDX #$2000

  loc_013ABA:
    STA $7E0000, X
    INX 
    INX 
    BNE loc_013ABA
    LDX #$0000

  loc_013AC5:
    STA $cgram_buffer, X
    INX 
    INX 
    BNE loc_013AC5
    SEP #$20
    LDX #$&asset_list_028000
    STX $2F
    LDA #$^asset_list_028000
    STA $31
    PLP 
    RTL 
}