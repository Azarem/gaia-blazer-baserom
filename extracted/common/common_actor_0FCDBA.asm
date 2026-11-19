?BANK 1F

!rng_state                      0301
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FCDBA {
    COP [AA] ( #02 )

  code_0FCDBD:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FCDCB
    COP [0C] ( #00, #05, &code_0FCF55 )

  loc_0FCDCB:
    COP [1B] ( &code_0FCDBD, #$0010 )

  code_0FCDD1:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FCDEA
    DEC 
    BEQ loc_0FCE44
    DEC 
    BNE loc_0FCDE4
    BRL loc_0FCEA1

  loc_0FCDE4:
    DEC 
    BNE loc_0FCDEA
    BRL loc_0FCEFD

  loc_0FCDEA:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0020
    BPL loc_0FCDFC
    BRL code_0FCF6C

  loc_0FCDFC:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [81] ( #03, #04 )
    COP [83]
    COP [85] ( @code_0FCF87 )
    COP [85] ( @code_0FCF8E )
    COP [85] ( @code_0FCF95 )
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRL code_0FCF55

  loc_0FCE44:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    CLC 
    ADC #$0020
    CMP $map_height_px
    BCC loc_0FCE59
    BRL code_0FCF6C

  loc_0FCE59:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [81] ( #05, #04 )
    COP [83]
    COP [85] ( @code_0FCF72 )
    COP [85] ( @code_0FCF79 )
    COP [85] ( @code_0FCFA3 )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRL code_0FCF55

  loc_0FCEA1:
    LDA $player_x
    CLC 
    ADC #$0020
    CMP $map_width_px
    BCC loc_0FCEB0
    BRL code_0FCF6C

  loc_0FCEB0:
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @code_0FCF95 )
    COP [85] ( @code_0FCF9C )
    COP [85] ( @code_0FCFA3 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FCF55

  loc_0FCEFD:
    LDA $player_x
    SEC 
    SBC #$0020
    BMI code_0FCF6C
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @code_0FCF79 )
    COP [85] ( @code_0FCF80 )
    COP [85] ( @code_0FCF87 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [97]
}

code_0FCF55 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FCF6C {
    COP [1B] ( &code_0FCDD1, #$0020 )
}

code_0FCF72 {
    COP [97]
    LDA #$0011
    BRA loc_0FCFA8
}

code_0FCF79 {
    COP [96]
    LDA #$0014
    BRA loc_0FCFA8
}

code_0FCF80 {
    COP [96]
    LDA #$0012
    BRA loc_0FCFA8
}

code_0FCF87 {
    COP [96]
    LDA #$0013
    BRA loc_0FCFA8
}

code_0FCF8E {
    COP [97]
    LDA #$0010
    BRA loc_0FCFA8
}

code_0FCF95 {
    COP [97]
    LDA #$0013
    BRA loc_0FCFA8
}

code_0FCF9C {
    COP [97]
    LDA #$0012
    BRA loc_0FCFA8
}

code_0FCFA3 {
    COP [97]
    LDA #$0014

  loc_0FCFA8:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [AA] ( #00 )
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0004
    STA $002A, X
    BRK #$52
    COP [91]
    COP [83]
    COP [80] ( #15 )
    COP [82]
    COP [81] ( #2F, #08 )
    COP [83]
    COP [86]
    RTL 
}