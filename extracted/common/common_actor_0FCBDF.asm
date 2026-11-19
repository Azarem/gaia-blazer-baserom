?BANK 1F

!rng_state                      0301
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FCBDF {
    COP [AA] ( #00 )

  code_0FCBE2:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FCBF0
    COP [0C] ( #00, #05, &code_0FCD52 )

  loc_0FCBF0:
    COP [1B] ( &code_0FCBE2, #$0010 )

  code_0FCBF6:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FCC0F
    DEC 
    BEQ loc_0FCC5F
    DEC 
    BNE loc_0FCC09
    BRL loc_0FCCB2

  loc_0FCC09:
    DEC 
    BNE loc_0FCC0F
    BRL loc_0FCD04

  loc_0FCC0F:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0040
    BPL loc_0FCC21
    BRL code_0FCD69

  loc_0FCC21:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCD69 )
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
    COP [85] ( @code_0FCD7A )
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRL code_0FCD52

  loc_0FCC5F:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    CLC 
    ADC #$0040
    CMP $map_height_px
    BCC loc_0FCC74
    BRL code_0FCD69

  loc_0FCC74:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCD69 )
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
    COP [85] ( @code_0FCD6F )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRL code_0FCD52

  loc_0FCCB2:
    LDA $player_x
    CLC 
    ADC #$0040
    CMP $map_width_px
    BCC loc_0FCCC1
    BRL code_0FCD69

  loc_0FCCC1:
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCD69 )
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
    COP [85] ( @code_0FCD83 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FCD52

  loc_0FCD04:
    LDA $player_x
    SEC 
    SBC #$0040
    BMI code_0FCD69
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCD69 )
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
    COP [85] ( @code_0FCD8E )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [97]
}

code_0FCD52 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FCD69 {
    COP [1B] ( &code_0FCBF6, #$0020 )
}

code_0FCD6F {
    COP [A1] ( #$0002, #$FFF8 )
    LDA #$000C
    BRA loc_0FCD97
}

code_0FCD7A {
    COP [9F] ( #$FFFF )
    LDA #$000B
    BRA loc_0FCD97
}

code_0FCD83 {
    COP [A1] ( #$FFF7, #$FFFC )
    LDA #$000D
    BRA loc_0FCD97
}

code_0FCD8E {
    COP [A1] ( #$0009, #$FFFC )
    LDA #$000D

  loc_0FCD97:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [AA] ( #00 )
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0010
    STA $002A, X
    BRK #$52
    COP [91]
    COP [83]
    COP [86]
    RTL 
}