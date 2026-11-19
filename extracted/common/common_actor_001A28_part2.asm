?BANK 00

?INCLUDE 'common_actor_001A28_part3'
?INCLUDE 'data_00F9F7'

!rng_state                      0301
!joy_pressed                    0322
!joy_release_latch              032A
!player_x                       0374
!player_y                       0376
!player_actor                   039C
!return_active                  03FB

---------------------------------------------

code_001FCF {
    LDA $0016, X
    AND #$CEFF
    STA $0016, X
    INC $0024, X
    COP [91]
    COP [82]
    RTL 
}

code_001FE0 {
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    LDA $return_active
    BNE loc_002013
    LDA $1B82
    BEQ loc_002016

  loc_001FF3:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @code_002026 )
    COP [A8] ( #$8000, #0E )
    COP [A3]
    COP [A2] ( #30 )

  loc_00200B:
    COP [81] ( #08, #10 )
    COP [83]
    BRA loc_00200B

  loc_002013:
    COP [91]
    RTL 

  loc_002016:
    COP [91]
    LDA $1B82
    BNE loc_00201E
    RTL 

  loc_00201E:
    STZ $0000, X
    STZ $0002, X
    BRA loc_001FF3
}

code_002026 {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    PHX 
    JSR $&code_00210A
    BCC loc_00203A
    BRL loc_002108

  loc_00203A:
    LDA $joy_pressed
    LDY #$0002
    BIT #$0100
    BNE loc_002050
    LDY #$FFFE
    BIT #$0200
    BNE loc_002050
    LDY #$0000

  loc_002050:
    STY $16
    LDY #$0002
    BIT #$0400
    BNE loc_002065
    LDY #$FFFE
    BIT #$0800
    BNE loc_002065
    LDY #$0000

  loc_002065:
    STY $18
    LDA $player_x
    SEC 
    SBC $0000, X
    BEQ loc_00208A
    BPL loc_002081
    EOR #$FFFF
    INC 
    DEC $16
    CMP #$0060
    BCC loc_00208A
    DEC $16
    BRA loc_00208A

  loc_002081:
    INC $16
    CMP #$0050
    BCC loc_00208A
    INC $16

  loc_00208A:
    LDA $0000, X
    CLC 
    ADC $16
    STA $0000, X
    STA $16
    LDA $player_y
    SEC 
    SBC $0002, X
    BEQ loc_0020B8
    BPL loc_0020AF
    EOR #$FFFF
    INC 
    DEC $18
    CMP #$0040
    BCC loc_0020B8
    DEC $18
    BRA loc_0020B8

  loc_0020AF:
    INC $18
    CMP #$0050
    BCC loc_0020B8
    INC $18

  loc_0020B8:
    LDA $0002, X
    CLC 
    ADC $18
    STA $0002, X
    STA $18
    LDY $003C, X
    LDA $0431
    ASL 
    AND #$00FF
    TAX 
    SEP #$20
    LDA #$00
    XBA 
    LDA $&data_00F9F7.binary_00FC84, X
    BPL loc_0020E1
    XBA 
    DEC 
    XBA 
    SEC 
    ROR 
    SEC 
    ROR 
    BRA loc_0020E3

  loc_0020E1:
    LSR 
    LSR 

  loc_0020E3:
    REP #$20
    CLC 
    ADC $16
    STA $0000, Y
    SEP #$20
    LDA #$00
    XBA 
    LDA $&data_00F9F7.binary_00FCC4, X
    BPL loc_0020FE
    XBA 
    DEC 
    XBA 
    SEC 
    ROR 
    SEC 
    ROR 
    BRA loc_002100

  loc_0020FE:
    LSR 
    LSR 

  loc_002100:
    REP #$20
    CLC 
    ADC $18
    STA $0002, Y

  loc_002108:
    PLX 
    RTL 
}

code_00210A {
    LDA $0439
    BNE code_002163
    LDA $03A6
    BNE code_002163
    LDA $1B62
    BEQ code_002163
    LDA ($4A)
    BEQ code_002163
    LDA $0433
    BEQ loc_002140
    LDA $1B62
    SEC 
    SBC #$0011
    BEQ loc_002176
    DEC 
    BEQ loc_002186
    DEC 
    BEQ code_002163
    DEC 
    BEQ loc_0021A0
    DEC 
    BEQ code_002163
    DEC 
    BEQ code_002163
    DEC 
    BEQ code_002163
    BRL code_002163

  loc_002140:
    LDA $joy_pressed
    BIT #$4000
    BEQ code_002163
    LDA $1B62
    SEC 
    SBC #$0011
    BEQ loc_002168
    DEC 
    BEQ loc_002178
    DEC 
    BEQ loc_002188
    DEC 
    BEQ loc_002198
    DEC 
    BEQ loc_0021A5
    DEC 
    BEQ loc_0021B5
    DEC 
    BEQ loc_0021C5

  code_002163:
    INC $0431
    CLC 
    RTS 

  loc_002168:
    COP [26] ( #$0004, &code_002163 )
    INC $0433
    COP [85] ( @code_0021D5 )

  loc_002176:
    SEC 
    RTS 

  loc_002178:
    COP [26] ( #$0008, &code_002163 )
    INC $0433
    COP [85] ( @code_002246 )

  loc_002186:
    SEC 
    RTS 

  loc_002188:
    COP [26] ( #$0008, &code_002163 )
    INC $0433
    COP [85] ( @code_0022F1 )
    BRA code_002163

  loc_002198:
    INC $0433
    COP [85] ( @code_0023DD )

  loc_0021A0:
    INC $0431
    BRA code_002163

  loc_0021A5:
    COP [26] ( #$0008, &code_002163 )
    INC $0433
    COP [85] ( @code_002439 )
    BRA code_002163

  loc_0021B5:
    COP [26] ( #$0020, &code_002163 )
    INC $0433
    COP [85] ( @code_00249D )
    BRA code_002163

  loc_0021C5:
    COP [26] ( #$0008, &code_002163 )
    INC $0433
    COP [85] ( @code_0024F8 )
    BRA code_002163
}

code_0021D5 {
    LDA #$03A0
    STA $0016, X
    LDA #$0005
    STA $0030, X
    LDY $03A0
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    COP [80] ( #00 )
    COP [82]
    BRK #$1B
    LDA #$02A0
    STA $0016, X
    LDY $player_actor
    LDA $001E, Y
    TAY 
    LDA $&data_00F9F7.binary_00FA7F, Y
    AND #$00FF
    BEQ loc_00221E
    DEC 
    BEQ loc_002220
    DEC 
    BEQ loc_002225
    BRA loc_002227

  loc_00221E:
    COP [98]

  loc_002220:
    LDA #$0002
    BRA loc_00222A

  loc_002225:
    COP [96]

  loc_002227:
    LDA #$0001

  loc_00222A:
    STA $001E, X
    STZ $0020, X
    LDA #$0008
    STA $002A, X
    LDA #$4000
    TRB $joy_release_latch
    STZ $0433
    COP [91]
    COP [83]
    COP [86]
    RTL 
}

code_002246 {
    LDA #$03A0
    STA $0016, X
    LDY $03A0
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    COP [80] ( #03 )
    COP [82]
    BRK #$12
    COP [B2] ( @code_0022A0, #$0000, #$FFF8, #$02A0 )
    COP [B2] ( @code_0022B5, #$0000, #$0008, #$02A0 )
    COP [B2] ( @code_0022C8, #$FFF8, #$0000, #$02A0 )
    COP [B2] ( @code_0022DB, #$0008, #$0000, #$02A0 )
    COP [80] ( #04 )
    COP [82]
    BRL common_actor_001A28_part3.code_0026E7
}

code_0022A0 {
    LDA #$000A
    STA $0030, X
    COP [98]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #08, #08 )
    COP [83]
    BRA loc_0022EE
}

code_0022B5 {
    LDA #$000A
    STA $0030, X
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #08, #08 )
    COP [83]
    BRA loc_0022EE
}

code_0022C8 {
    LDA #$000A
    STA $0030, X
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #06, #08 )
    COP [83]
    BRA loc_0022EE
}

code_0022DB {
    LDA #$000A
    STA $0030, X
    COP [96]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #06, #08 )
    COP [83]

  loc_0022EE:
    COP [86]
    RTL 
}

code_0022F1 {
    LDA #$03A0
    STA $0016, X
    LDA #$0014
    STA $0030, X
    COP [85] ( @code_0023B1 )
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    COP [03] ( #05 )
    COP [80] ( #09 )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ loc_002351
    COP [04]
    COP [03] ( #05 )
    COP [80] ( #0A )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ loc_002369
    COP [04]
    COP [03] ( #05 )
    COP [80] ( #0B )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ loc_002381
    COP [04]

  loc_002342:
    COP [80] ( #0C )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ loc_002399
    BRA loc_002342

  loc_002351:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0D, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #10 )
    COP [82]
    BRL common_actor_001A28_part3.code_0026E7

  loc_002369:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0E, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #11 )
    COP [82]
    BRL common_actor_001A28_part3.code_0026E7

  loc_002381:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0E, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #12 )
    COP [82]
    BRL common_actor_001A28_part3.code_0026E7

  loc_002399:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0E, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #13 )
    COP [82]
    BRL common_actor_001A28_part3.code_0026E7
}

code_0023B1 {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    LDA $joy_pressed
    BIT #$4000
    BEQ loc_0023DA
    PHX 
    LDY $03A0
    LDA $003C, X
    TAX 
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    PLX 
    RTL 

  loc_0023DA:
    COP [86]
    RTL 
}

code_0023DD {
    LDA #$2020
    STA $0016, X

  code_0023E3:
    LDA $joy_pressed
    BIT #$4000
    BNE loc_0023EE
    BRL common_actor_001A28_part3.code_0026E7

  loc_0023EE:
    COP [26] ( #$0001, &common_actor_001A28_part3.code_0026E7 )
    COP [B0] ( @code_002401, #$02B0 )
    COP [1B] ( &code_0023E3, #$0004 )
}

code_002401 {
    LDY $03A0
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    LDA #$0005
    STA $0030, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    BRK #$24
    COP [80] ( #14 )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    COP [86]
    RTL 
}

code_002439 {
    LDA #$2020
    STA $0016, X
    STZ $0433
    COP [03] ( #04 )
    COP [B0] ( @code_002457, #$03A0 )
    COP [1B] ( &code_002452, #$0010 )
}

code_002452 {
    COP [04]
    COP [86]
    RTL 
}

code_002457 {
    INC $0433
    LDA #$001E
    STA $0030, X
    LDY $03A0
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A4]
    COP [A8] ( #$8000, #0F )
    COP [81] ( #18, #04 )
    COP [83]
    COP [81] ( #19, #04 )
    COP [83]
    LDA #$02A0
    STA $0016, X
    BRK #$21
    COP [80] ( #1A )
    COP [82]
    DEC $0433
    BNE loc_00249A
    LDA #$4000
    TRB $joy_release_latch

  loc_00249A:
    COP [86]
    RTL 
}

code_00249D {
    LDA #$2020
    STA $0016, X
    STZ $0433
    COP [03] ( #04 )
    COP [B0] ( @code_0024BB, #$02A0 )
    COP [1B] ( &code_0024B6, #$0010 )
}

code_0024B6 {
    COP [04]
    COP [86]
    RTL 
}

code_0024BB {
    INC $0433
    LDA #$0006
    STA $0030, X
    LDY $03A0
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A8] ( #$8000, #0F )
    BRK #$0B
    COP [80] ( #1C )
    COP [82]
    COP [81] ( #1B, #14 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    DEC $0433
    BNE loc_0024F5
    LDA #$4000
    TRB $joy_release_latch

  loc_0024F5:
    COP [86]
    RTL 
}

code_0024F8 {
    LDA #$02A0
    STA $0016, X
    COP [85] ( @code_002666 )
    LDY $03A0
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    SEC 
    SBC #$0010
    STA $0002, X
    COP [A8] ( #$8000, #0F )
    COP [A2] ( #30 )
    COP [81] ( #24, #04 )
    COP [83]
    BRK #$16
    COP [80] ( #25 )
    COP [82]
    LDA #$000F
    STA $0030, X
    COP [03] ( #3C )

  loc_002534:
    COP [80] ( #27 )
    COP [82]
    COP [1F]
    LDA #$0302
    AND #$0003
    BNE loc_002546
    BRL loc_0025AD

  loc_002546:
    DEC 
    BNE loc_00254C
    BRL loc_0025D9

  loc_00254C:
    DEC 
    BNE loc_002552
    BRL loc_002602

  loc_002552:
    BRL loc_00262B

  loc_002555:
    COP [80] ( #28 )
    COP [82]
    BRA loc_0025AD

  loc_00255C:
    COP [80] ( #1F )
    COP [82]
    BRL loc_00262B

  loc_002564:
    COP [80] ( #1E )
    COP [82]
    BRL loc_002602

  loc_00256C:
    COP [80] ( #29 )
    COP [82]
    BRA loc_0025D9

  loc_002573:
    COP [80] ( #2B )
    COP [82]
    BRA loc_0025AD

  loc_00257A:
    COP [80] ( #2D )
    COP [82]
    BRL loc_00262B

  loc_002582:
    COP [80] ( #20 )
    COP [82]
    BRA loc_002602

  loc_002589:
    COP [80] ( #22 )
    COP [82]
    BRA loc_0025D9

  loc_002590:
    COP [80] ( #21 )
    COP [82]
    BRL loc_00262B

  loc_002598:
    COP [80] ( #23 )
    COP [82]
    BRA loc_0025AD

  loc_00259F:
    COP [80] ( #2A )
    COP [82]
    BRA loc_0025D9

  loc_0025A6:
    COP [80] ( #2C )
    COP [82]
    BRA loc_002602

  loc_0025AD:
    DEC $002E, X
    BNE loc_0025B5
    BRL loc_002654

  loc_0025B5:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0025C0
    BRL loc_002654

  loc_0025C0:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_002555
    DEC 
    BNE loc_0025D0
    BRL loc_00257A

  loc_0025D0:
    DEC 
    BNE loc_0025D6
    BRL loc_00259F

  loc_0025D6:
    BRL loc_002534

  loc_0025D9:
    DEC $002E, X
    BEQ loc_002654
    LDA $0016, X
    BIT #$8000
    BNE loc_002654
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE loc_0025F3
    BRL loc_00256C

  loc_0025F3:
    DEC 
    BNE loc_0025F9
    BRL loc_002573

  loc_0025F9:
    DEC 
    BNE loc_0025FF
    BRL loc_0025A6

  loc_0025FF:
    BRL loc_002534

  loc_002602:
    DEC $002E, X
    BEQ loc_002654
    LDA $0016, X
    BIT #$8000
    BNE loc_002654
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE loc_00261C
    BRL loc_002564

  loc_00261C:
    DEC 
    BNE loc_002622
    BRL loc_002589

  loc_002622:
    DEC 
    BNE loc_002628
    BRL loc_002590

  loc_002628:
    BRL loc_002534

  loc_00262B:
    DEC $002E, X
    BEQ loc_002654
    LDA $0016, X
    BIT #$8000
    BNE loc_002654
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE loc_002645
    BRL loc_00255C

  loc_002645:
    DEC 
    BNE loc_00264B
    BRL loc_002582

  loc_00264B:
    DEC 
    BNE loc_002651
    BRL loc_002598

  loc_002651:
    BRL loc_002534

  loc_002654:
    COP [81] ( #26, #02 )
    COP [83]
    LDA #$4000
    TRB $joy_release_latch
    STZ $0433
    COP [86]
    RTL 
}

code_002666 {
    COP [A8] ( #$8000, #0D )

  loc_00266B:
    COP [92] ( #42 )
    COP [94]
    LDA $0433
    BNE loc_00266B
    COP [86]
    RTL 
}