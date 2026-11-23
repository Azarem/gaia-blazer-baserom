?BANK 1F

---------------------------------------------

code_0FD058 {
    LDA $001A, X
    ORA #$0100
    STA $001A, X

  loc_0FD061:
    COP [AD] ( #08 )
    LDA #$0008
    STA $002C, X

  loc_0FD06A:
    COP [80] ( #1A )
    COP [82]
    LDA $0025, X
    AND #$00FF
    CMP #$0018
    BNE loc_0FD086
    DEC $002C, X
    BNE loc_0FD06A
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FD061

  loc_0FD086:
    LDA #$0200
    STA $0016, X
    COP [81] ( #1C, #14 )
    COP [83]
    BRK #$64
    COP [85] ( @code_0FD0C4 )
    COP [85] ( @code_0FD0C9 )
    COP [85] ( @code_0FD0D0 )
    COP [85] ( @code_0FD0D7 )
    COP [85] ( @code_0FD0DE )
    COP [85] ( @code_0FD0E3 )
    COP [85] ( @code_0FD0E8 )
    COP [85] ( @code_0FD0ED )
    COP [80] ( #1D )
    COP [82]
    COP [86]
    RTL 
}

code_0FD0C4 {
    LDA #$001F
    BRA loc_0FD0F2
}

code_0FD0C9 {
    COP [96]
    LDA #$0022
    BRA loc_0FD0F2
}

code_0FD0D0 {
    COP [96]
    LDA #$0020
    BRA loc_0FD0F2
}

code_0FD0D7 {
    COP [96]
    LDA #$0021
    BRA loc_0FD0F2
}

code_0FD0DE {
    LDA #$001E
    BRA loc_0FD0F2
}

code_0FD0E3 {
    LDA #$0021
    BRA loc_0FD0F2
}

code_0FD0E8 {
    LDA #$0020
    BRA loc_0FD0F2
}

code_0FD0ED {
    LDA #$0022
    BRA loc_0FD0F2

  loc_0FD0F2:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    LDA #$0002
    STA $002A, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A1] ( #$0008, #$FFF8 )
    COP [91]
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [86]
    RTL 
}