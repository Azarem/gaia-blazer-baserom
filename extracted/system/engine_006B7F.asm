?BANK 00

?INCLUDE 'data_00F9F7'
?INCLUDE 'lib_0118FC_part2'
?INCLUDE 'lib_01232B'
?INCLUDE 'lib_0143B0'
?INCLUDE 'lib_01440D'
?INCLUDE 'lib_027132'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_02716E'

!scene_next                     0318
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
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

code_006B7F {
    LDA $location_id
    CMP #$10
    BNE loc_006BA4
    JSR $&code_006BF1
    JSR $&code_006BA8
    LDX $0476
    STX $046E
    LDX $0478
    STX $0470
    LDX $047A
    STX $0472
    LDX $047C
    STX $0474

  loc_006BA4:
    RTL 
}

code_006BA5 {
    JSR $&code_006C50
}

code_006BA8 {
    LDA $046E
    STA $M7A
    LDA $046F
    STA $M7A
    LDA $0470
    STA $M7B
    LDA $0471
    STA $M7B
    LDA $0472
    STA $M7C
    LDA $0473
    STA $M7C
    LDA $0474
    STA $M7D
    LDA $0475
    STA $M7D
    LDA $046A
    STA $M7X
    LDA $046B
    STA $M7X
    LDA $046C
    STA $M7Y
    LDA $046D
    STA $M7Y
    RTS 
}

code_006BF1 {
    SEP #$10
    LDX $047E
    REP #$10
    LDY $0480
    STY $00
    XBA 
    LDA $@data_00F9F7.binary_00FCC4, X
    STA $02
    JSR $&code_006CA0
    LDY $MPYM
    STY $0476
    LDY $0480
    STY $00
    XBA 
    LDA $@data_00F9F7.binary_00FC84, X
    STA $02
    JSR $&code_006CA0
    LDY $MPYM
    STY $0478
    LDY $0480
    STY $00
    XBA 
    LDA $@data_00F9F7.binary_00FC84, X
    EOR #$FF
    INC 
    STA $02
    JSR $&code_006CA0
    LDY $MPYM
    STY $047A
    LDY $0480
    STY $00
    XBA 
    LDA $@data_00F9F7.binary_00FCC4, X
    STA $02
    JSR $&code_006CA0
    LDY $MPYM
    STY $047C
    RTS 
}

code_006C50 {
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
    LDA $@data_00F9F7.binary_00FCC4, X
    STA $M7B
    STA $M7B
    REP #$20
    LDA $MPYM
    STA $046E
    STA $0474
    PLA 
    SEP #$20
    STA $M7A
    XBA 
    STA $M7A
    LDA $@data_00F9F7.binary_00FC84, X
    STA $M7B
    STA $M7B
    REP #$20
    LDA $MPYM
    STA $0470
    EOR #$FFFF
    INC 
    STA $0472
    SEP #$20
    RTS 
}

code_006CA0 {
    PHP 
    SEP #$20
    LDA $00
    STA $M7A
    LDA $01
    STA $M7A
    LDA $02
    STA $M7B
    STA $M7B
    LDA $MPYL
    STA $00
    LDA $MPYM
    STA $01
    PLP 
    RTS 

  loc_006CC1:
    PHX 
    JSL $@lib_01232B.code_01232B
    JSR $&code_006D4E
    PLX 
    COP [1B] ( &code_006CD0, #$0001 )
}

code_006CD0 {
    PHX 
    LDA $701FFE
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
    JSL $@lib_0118FC_part2.code_0121E8
    BCS loc_006CE4
    AND #$00FF
    CMP #$0004
    BNE loc_006D20
    LDA #$03FF
    STA $7F0006
    LDA #$0004
    JSL $@lib_0118FC_part2.code_0121E8
    BCS loc_006D14
    AND #$00FF
    XBA 
    ASL 
    ASL 
    TAX 
    STA $700000, X
    STA $701000, X

  loc_006D14:
    LDA #$7FFF
    STA $7F0006
    JSR $&code_006D4E
    BRA loc_006CE4

  loc_006D20:
    STA $03A4
    JSL $@lib_027132.code_027132
    PLX 
    LDA #$0001
    BCS loc_006D30
    LDA $1B90

  loc_006D30:
    STA $scene_next
    LDA #$0001
    STA $warp_dest_anim
    LDA #$0070
    STA $warp_dest_x
    LDA #$0060
    STA $warp_dest_y
    STZ $0445
    INC $0454
    COP [91]
    RTL 
}

code_006D4E {
    LDY #$&lib_0143B0.asciistring_0143B0
    JSL $@lib_shared_012769.code_012769
    STZ $03A4
    LDX #$0000
    LDY #$&lib_01440D.binary_01440D
    LDA #$0000
    PHA 

  loc_006D62:
    JSL $@lib_shared_02716E.code_02716E
    LDA $16
    CMP $7003FA, X
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
    MVN #$70, #$70
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
    MVN #$70, #$70
    PLB 
    PLY 
    PLX 
    JSL $@lib_shared_02716E.code_02716E
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
    JSL $@lib_shared_012769.code_012769
    PLX 
    PLY 
    PLA 
    INC 
    PHA 

  loc_006E06:
    INC $03A4
    TXA 
    CLC 
    ADC #$0400
    TAX 
    TYA 
    CLC 
    ADC #$0014
    TAY 
    CPX #$1000
    BEQ loc_006E1D
    BRL loc_006D62

  loc_006E1D:
    STZ $03A4
    PLA 
    BNE loc_006E27
    STA $701FFE

  loc_006E27:
    RTS 
}