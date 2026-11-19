?BANK 1F

---------------------------------------------

code_0FAA8F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAA9D

  code_0FAA97:
    COP [1B] ( &code_0FAA8F, #$0008 )

  loc_0FAA9D:
    COP [9A] ( #$0010, &code_0FAAA7, &code_0FAAB9, &code_0FAAB0 )
}

code_0FAAA7 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAB0 {
    COP [96]
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAB9 {
    COP [9B] ( #$0010, &code_0FAAC3, &code_0FAAF3, &code_0FAADB )
}

code_0FAAC3 {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    COP [80] ( #10 )
    COP [82]
    COP [85] ( @code_0FAB61 )
    COP [80] ( #36 )
    COP [82]
    BRA code_0FAAF3
}

code_0FAADB {
    COP [97]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #0F )
    COP [82]
    COP [85] ( @code_0FAB6C )
    COP [80] ( #35 )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAF3 {
    COP [9B] ( #$0010, &code_0FAAFD, &code_0FAB0F, &code_0FAB06 )
}

code_0FAAFD {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FAA8F
}

code_0FAB06 {
    COP [97]
    COP [80] ( #09 )
    COP [82]
    BRA code_0FAA8F
}

code_0FAB0F {
    COP [9A] ( #$0010, &code_0FAB19, &code_0FAA97, &code_0FAB32 )
}

code_0FAB19 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [85] ( @code_0FAB4B )
    COP [80] ( #37 )
    COP [82]
    BRL code_0FAA97
}

code_0FAB32 {
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [85] ( @code_0FAB4B )
    COP [80] ( #37 )
    COP [82]
    BRL code_0FAA97
}

code_0FAB4B {
    COP [A1] ( #$FFFF, #$0002 )
    LDA #$0025
    BRA loc_0FAB75

  loc_0FAB56:
    COP [A1] ( #$0001, #$0002 )
    LDA #$0025
    BRA loc_0FAB75
}

code_0FAB61 {
    COP [A1] ( #$0004, #$FFF3 )
    LDA #$0026
    BRA loc_0FAB75
}

code_0FAB6C {
    COP [A1] ( #$FFFD, #$0002 )
    LDA #$0027

  loc_0FAB75:
    STA $001E, X
    STZ $0020, X
    LDA #$000C
    STA $002A, X
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]
    COP [83]
    COP [80] ( #24 )
    COP [82]
    COP [86]
    RTL 
}