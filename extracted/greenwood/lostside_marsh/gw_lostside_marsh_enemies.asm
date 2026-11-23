?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'
?INCLUDE 'WorldMetaPointers'

!rng_state                      0301
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FB0F5 {
    COP [A5] ( &code_0FB0FF, &code_0FB172, &code_0FB1E5, &code_0FB25A )
}

code_0FB0FF {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB10D

  code_0FB107:
    COP [1B] ( &code_0FB0FF, #$0008 )

  loc_0FB10D:
    COP [9A] ( #$0030, &code_0FB107, &code_0FB117, &code_0FB107 )
}

code_0FB117 {
    COP [9B] ( #$0000, &code_0FB107, &code_0FB107, &code_0FB121 )
}

code_0FB121 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #03 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [B2] ( @code_0FB2DB, #$0000, #$000C, #$0200 )
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB0FF, #$0078 )
}

code_0FB172 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB180

  code_0FB17A:
    COP [1B] ( &code_0FB172, #$0008 )

  loc_0FB180:
    COP [9B] ( #$0030, &code_0FB17A, &code_0FB18A, &code_0FB17A )
}

code_0FB18A {
    COP [9A] ( #$0000, &code_0FB194, &code_0FB17A, &code_0FB17A )
}

code_0FB194 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FB2E8, #$FFF0, #$0000, #$0200 )
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB172, #$0078 )
}

code_0FB1E5 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB1F3

  code_0FB1ED:
    COP [1B] ( &code_0FB1E5, #$0008 )

  loc_0FB1F3:
    COP [9B] ( #$0030, &code_0FB1ED, &code_0FB1FD, &code_0FB1ED )
}

code_0FB1FD {
    COP [9A] ( #$0000, &code_0FB1ED, &code_0FB1ED, &code_0FB207 )
}

code_0FB207 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FB2E8, #$0020, #$0000, #$0200 )
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB1E5, #$0078 )
}

code_0FB25A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB268

  code_0FB262:
    COP [1B] ( &code_0FB25A, #$0008 )

  loc_0FB268:
    COP [9A] ( #$0030, &code_0FB262, &code_0FB272, &code_0FB262 )
}

code_0FB272 {
    COP [9B] ( #$0000, &code_0FB27C, &code_0FB262, &code_0FB262 )
}

code_0FB27C {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #05 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [B2] ( @code_0FB2F5, #$0000, #$FFE0, #$0200 )
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #06 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB25A, #$0078 )
}

code_0FB2CD {
    SEP #$20
    LDY $0038, X
    LDA $&WorldMetaPointers+2, Y
    STA $0025, X
    REP #$20
    RTS 
}

code_0FB2DB {
    COP [A3]
    BRK #$5B
    COP [81] ( #16, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB2E8 {
    COP [A3]
    BRK #$5B
    COP [81] ( #18, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB2F5 {
    COP [A3]
    BRK #$5B
    COP [81] ( #17, #08 )
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FB302 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB310

  code_0FB30A:
    COP [1B] ( &code_0FB302, #$0002 )

  loc_0FB310:
    COP [9A] ( #$0010, &code_0FB31A, &code_0FB32C, &code_0FB323 )
}

code_0FB31A {
    COP [97]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FB32C
}

code_0FB323 {
    COP [96]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FB32C
}

code_0FB32C {
    COP [9B] ( #$0010, &code_0FB336, &code_0FB30A, &code_0FB33F )
}

code_0FB336 {
    COP [97]
    COP [80] ( #25 )
    COP [82]
    BRA code_0FB302
}

code_0FB33F {
    COP [97]
    COP [80] ( #24 )
    COP [82]
    BRA code_0FB302
}
---------------------------------------------

code_0FB348 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB356

  code_0FB350:
    COP [1B] ( &code_0FB348, #$0020 )

  loc_0FB356:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FB369
    DEC 
    BEQ loc_0FB372
    DEC 
    BEQ loc_0FB37B
    DEC 
    BEQ loc_0FB386

  loc_0FB369:
    COP [9D] ( #0E )
    COP [9E] ( &code_0FB350 )

  loc_0FB370:
    BRA loc_0FB391

  loc_0FB372:
    COP [9D] ( #0D )
    COP [9E] ( &code_0FB350 )

  loc_0FB379:
    BRA loc_0FB391

  loc_0FB37B:
    COP [96]
    COP [9D] ( #0F )
    COP [9E] ( &code_0FB350 )

  loc_0FB384:
    BRA loc_0FB391

  loc_0FB386:
    COP [97]
    COP [9D] ( #0F )
    COP [9E] ( &code_0FB350 )

  loc_0FB38F:
    BRA loc_0FB391

  loc_0FB391:
    COP [9A] ( #$0010, &code_0FB3A5, &code_0FB39B, &code_0FB3AF )
}

code_0FB39B {
    COP [9B] ( #$0000, &code_0FB3B9, &code_0FB3C2, &code_0FB3C2 )
}

code_0FB3A5 {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3CB, &code_0FB348 )
}

code_0FB3AF {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3D4, &code_0FB348 )
}

code_0FB3B9 {
    COP [97]
    COP [85] ( @code_0FB3F6 )
    BRA loc_0FB3DB
}

code_0FB3C2 {
    COP [97]
    COP [85] ( @code_0FB406 )
    BRA loc_0FB3DB
}

code_0FB3CB {
    COP [97]
    COP [85] ( @code_0FB416 )
    BRA loc_0FB3DB
}

code_0FB3D4 {
    COP [96]
    COP [85] ( @code_0FB416 )

  loc_0FB3DB:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [81] ( #0C, #02 )
    COP [83]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL code_0FB350
}

code_0FB3F6 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    COP [80] ( #12 )
    COP [82]
    COP [86]
    RTL 
}

code_0FB406 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    COP [80] ( #11 )
    COP [82]
    COP [86]
    RTL 
}

code_0FB416 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    LDA $001C, X
    ASL 
    BPL loc_0FB42B
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FB430

  loc_0FB42B:
    COP [80] ( #13 )
    COP [82]

  loc_0FB430:
    COP [86]
    RTL 
}
---------------------------------------------

code_0FB433 {
    COP [15]

  code_0FB435:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FB443
    COP [0C] ( #00, #01, &code_0FB449 )

  loc_0FB443:
    COP [1B] ( &code_0FB435, #$0010 )
}

code_0FB449 {
    COP [16]
    BRL loc_0FB4CE

  code_0FB44E:
    COP [1F]
    LDA $rng_state+1
    PHP 
    AND #$0030
    CLC 
    ADC #$0020
    PLP 
    BPL loc_0FB462
    EOR #$FFFF
    INC 

  loc_0FB462:
    CLC 
    ADC $player_x
    AND #$FFF0
    CMP $map_width_px
    BCS code_0FB4DE
    STA $0000, X
    COP [1F]
    LDA $rng_state+1
    PHP 
    AND #$0030
    CLC 
    ADC #$0020
    PLP 
    BPL loc_0FB485
    EOR #$FFFF
    INC 

  loc_0FB485:
    CLC 
    ADC $player_y
    AND #$FFF0
    CMP $map_height_px
    BCS code_0FB4DE
    STA $0002, X
    COP [28] ( &code_0FB4DE )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$5F
    COP [80] ( #10 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1C )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [85] ( @code_0FB4E4 )
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X

  loc_0FB4CE:
    BRK #$5F
    COP [80] ( #10 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FB4DE {
    COP [1B] ( &code_0FB44E, #$0020 )
}

code_0FB4E4 {
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A0] ( #$FFF4 )
    BRK #$5B
    COP [9A] ( #$0018, &code_0FB506, &code_0FB4FC, &code_0FB510 )
}

code_0FB4FC {
    COP [9B] ( #$0000, &code_0FB558, &code_0FB55E, &code_0FB532 )
}

code_0FB506 {
    COP [9B] ( #$0018, &code_0FB51A, &code_0FB522, &code_0FB52A )
}

code_0FB510 {
    COP [9B] ( #$0018, &code_0FB54E, &code_0FB544, &code_0FB53A )
}

code_0FB51A {
    COP [81] ( #22, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB522 {
    COP [81] ( #20, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB52A {
    COP [81] ( #21, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB532 {
    COP [81] ( #1E, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB53A {
    COP [96]
    COP [81] ( #21, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB544 {
    COP [96]
    COP [81] ( #20, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB54E {
    COP [96]
    COP [81] ( #22, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB558 {
    COP [81] ( #1F, #10 )
    COP [83]
}

code_0FB55E {
    COP [86]
    RTL 
}
---------------------------------------------

code_0FB561 {
    COP [AD] ( #10 )
    COP [81] ( #14, #02 )
    COP [83]
    COP [B2] ( @code_0FB57F, #$0008, #$FFFC, #$0000 )

  loc_0FB575:
    COP [AD] ( #08 )
    COP [80] ( #14 )
    COP [82]
    BRA loc_0FB575
}

code_0FB57F {
    COP [A3]
    COP [81] ( #15, #02 )
    COP [83]

  loc_0FB587:
    COP [85] ( @shared_actor_helpers_bank0.code_002D96 )
    CPY #$06AA
    BEQ loc_0FB599
    COP [81] ( #15, #02 )
    COP [83]
    BRA loc_0FB587

  loc_0FB599:
    COP [86]
    RTL 
}
---------------------------------------------

code_0FB59C {
    LDA $001A, X
    ORA #$0200
    STA $001A, X

  loc_0FB5A5:
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #29 )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2A )
    COP [82]
    COP [04]
    BRA loc_0FB5A5
}
---------------------------------------------

code_0FB5E3 {
    LDA $001A, X
    ORA #$0800
    STA $001A, X

  code_0FB5EC:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB5FA
    COP [1B] ( &code_0FB5EC, #$0010 )

  loc_0FB5FA:
    COP [A5] ( &code_0FB604, &code_0FB623, &code_0FB642, &code_0FB661 )
}

code_0FB604 {
    COP [97]
    COP [80] ( #0F )
    COP [82]

  loc_0FB60B:
    COP [AE] ( #$FFF0, #$FFF0, &code_0FB661 )
    COP [AE] ( #$0000, #$FFE0, &code_0FB623 )
    COP [81] ( #11, #04 )
    COP [83]
    BRA loc_0FB60B
}

code_0FB623 {
    COP [97]
    COP [80] ( #0F )
    COP [82]

  loc_0FB62A:
    COP [AE] ( #$FFF0, #$0000, &code_0FB642 )
    COP [AE] ( #$0000, #$0010, &code_0FB604 )
    COP [81] ( #10, #04 )
    COP [83]
    BRA loc_0FB62A
}

code_0FB642 {
    COP [96]
    COP [80] ( #0F )
    COP [82]

  loc_0FB649:
    COP [AE] ( #$0020, #$0000, &code_0FB623 )
    COP [AE] ( #$0010, #$0010, &code_0FB661 )
    COP [81] ( #10, #04 )
    COP [83]
    BRA loc_0FB649
}

code_0FB661 {
    COP [96]
    COP [80] ( #0F )
    COP [82]

  loc_0FB668:
    COP [AE] ( #$0010, #$FFE0, &code_0FB642 )
    COP [AE] ( #$0020, #$FFF0, &code_0FB604 )
    COP [81] ( #11, #04 )
    COP [83]
    BRA loc_0FB668
}
---------------------------------------------

code_0FB695 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB6A3
    COP [1B] ( &code_0FB695, #$0010 )

  loc_0FB6A3:
    COP [0C] ( #00, #06, &code_0FB6B0 )
    COP [80] ( #1A )
    COP [82]
    BRA code_0FB695
}

code_0FB6B0 {
    COP [80] ( #1B )
    COP [82]
    COP [A3]
    COP [A2] ( #30 )

  loc_0FB6BA:
    COP [9C] ( &code_0FB6C0, &code_0FB6DC )
}

code_0FB6C0 {
    COP [9A] ( #$0000, &code_0FB6CA, &code_0FB6D3, &code_0FB6D3 )
}

code_0FB6CA {
    COP [97]
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6D3 {
    COP [96]
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6DC {
    COP [9B] ( #$0000, &code_0FB6E6, &code_0FB6EF, &code_0FB6EF )
}

code_0FB6E6 {
    COP [97]
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6EF {
    COP [97]
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FB6BA
}
---------------------------------------------

code_0FB898 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB8A6

  code_0FB8A0:
    COP [1B] ( &code_0FB898, #$0010 )

  loc_0FB8A6:
    COP [9A] ( #$0010, &code_0FB8B0, &code_0FB8C2, &code_0FB8B9 )
}

code_0FB8B0 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FB8C2
}

code_0FB8B9 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FB8C2
}

code_0FB8C2 {
    COP [9B] ( #$0010, &code_0FB8CC, &code_0FB8A0, &code_0FB8D5 )
}

code_0FB8CC {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA code_0FB898
}

code_0FB8D5 {
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA code_0FB898
}
---------------------------------------------

code_0FB8DE {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB8EC
    COP [1B] ( &code_0FB8DE, #$0010 )

  loc_0FB8EC:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FB8FF
    DEC 
    BEQ loc_0FB937
    DEC 
    BEQ loc_0FB96C
    BRL loc_0FB9A1

  loc_0FB8FF:
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [23] ( &code_0FB8DE )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #0C )
    COP [82]
    COP [A4]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #0D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRA code_0FB8DE

  loc_0FB937:
    COP [96]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #0C )
    COP [82]
    COP [A4]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #0D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRL code_0FB8DE

  loc_0FB96C:
    COP [97]
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    COP [A4]
    COP [81] ( #0A, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    BRL code_0FB8DE

  loc_0FB9A1:
    COP [97]
    COP [80] ( #00 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [A4]
    COP [81] ( #06, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #05 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    BRL code_0FB8DE
}
---------------------------------------------

code_0FB9D6 {
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FB9E3, &code_0FBA01, &code_0FBA01 )
}

code_0FB9E3 {
    COP [97]
    COP [9B] ( #$0018, &code_0FB9EF, &code_0FBA68, &code_0FB9EF )
}

code_0FB9EF {
    COP [21] ( &code_0FB9FA )
    COP [80] ( #23 )
    COP [82]
    BRA code_0FB9D6
}

code_0FB9FA {
    COP [80] ( #20 )
    COP [82]
    BRA code_0FB9D6
}

code_0FBA01 {
    COP [97]
    COP [9B] ( #$0018, &code_0FBA0D, &code_0FBA68, &code_0FBA0D )
}

code_0FBA0D {
    COP [22] ( &code_0FBA18 )
    COP [80] ( #22 )
    COP [82]
    BRA code_0FB9D6
}

code_0FBA18 {
    COP [80] ( #1F )
    COP [82]
    BRA code_0FB9D6

  loc_0FBA1F:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FBA2C, &code_0FBA4A, &code_0FBA4A )
}

code_0FBA2C {
    COP [9A] ( #$0018, &code_0FBA36, &code_0FBA85, &code_0FBA36 )
}

code_0FBA36 {
    COP [97]
    COP [23] ( &code_0FBA43 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA43 {
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA4A {
    COP [9A] ( #$0018, &code_0FBA54, &code_0FBA85, &code_0FBA54 )
}

code_0FBA54 {
    COP [96]
    COP [24] ( &code_0FBA61 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA61 {
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA68 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE loc_0FBA1F
    COP [80] ( #1F )
    COP [82]
    COP [B0] ( @code_0FBAA6, #$0200 )
    COP [80] ( #1F )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA85 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FBA92
    BRL code_0FB9D6

  loc_0FBA92:
    COP [80] ( #1F )
    COP [82]
    COP [B0] ( @code_0FBAA6, #$0200 )
    COP [80] ( #1F )
    COP [82]
    BRL code_0FB9D6
}

code_0FBAA6 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$0028
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

code_0FBABC {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [A5] ( &code_0FBB0B, &code_0FBAF7, &code_0FBACF, &code_0FBAE3 )
}

code_0FBACF {
    COP [21] ( &code_0FBAD5 )
    BRA loc_0FBAED
}

code_0FBAD5 {
    COP [24] ( &code_0FBB0B )

  loc_0FBAD9:
    COP [96]
    COP [81] ( #27, #02 )
    COP [83]
    BRA code_0FBACF
}

code_0FBAE3 {
    COP [23] ( &code_0FBAE9 )
    BRA loc_0FBB01
}

code_0FBAE9 {
    COP [21] ( &code_0FBACF )

  loc_0FBAED:
    COP [97]
    COP [81] ( #26, #02 )
    COP [83]
    BRA code_0FBAE3
}

code_0FBAF7 {
    COP [22] ( &code_0FBAFD )
    BRA loc_0FBB15
}

code_0FBAFD {
    COP [23] ( &code_0FBAE3 )

  loc_0FBB01:
    COP [97]
    COP [81] ( #27, #02 )
    COP [83]
    BRA code_0FBAF7
}

code_0FBB0B {
    COP [24] ( &code_0FBB11 )
    BRA loc_0FBAD9
}

code_0FBB11 {
    COP [22] ( &code_0FBAF7 )

  loc_0FBB15:
    COP [97]
    COP [81] ( #25, #02 )
    COP [83]
    BRA code_0FBB0B
}