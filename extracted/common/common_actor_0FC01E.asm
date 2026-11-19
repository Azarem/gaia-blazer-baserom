?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FC01E {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC02C
    COP [1B] ( &code_0FC01E, #$0010 )

  loc_0FC02C:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FC03F
    DEC 
    BEQ loc_0FC05C
    DEC 
    BEQ loc_0FC079
    DEC 
    BEQ loc_0FC096

  loc_0FC03F:
    COP [97]
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0B4 )
    COP [80] ( #06 )
    COP [82]
    BRA code_0FC01E

  loc_0FC05C:
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0B9 )
    COP [80] ( #06 )
    COP [82]
    BRA code_0FC01E

  loc_0FC079:
    COP [96]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0BE )
    COP [80] ( #06 )
    COP [82]
    BRA code_0FC01E

  loc_0FC096:
    COP [97]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0BE )
    COP [80] ( #06 )
    COP [82]
    BRL code_0FC01E
}

code_0FC0B4 {
    LDA #$000C
    BRA loc_0FC0C1
}

code_0FC0B9 {
    LDA #$000B
    BRA loc_0FC0C1
}

code_0FC0BE {
    LDA #$000D

  loc_0FC0C1:
    STA $001E, X
    STZ $0020, X
    LDA #$0006
    STA $002A, X
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$FFF8 )
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]
    COP [83]
    COP [86]
    RTL 
}