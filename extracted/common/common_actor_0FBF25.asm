?BANK 1F

---------------------------------------------

code_0FBF25 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBF33

  code_0FBF2D:
    COP [1B] ( &code_0FBF25, #$0020 )

  loc_0FBF33:
    COP [19] ( #24, &code_0FBF2D )
    COP [0C] ( #00, #02, &code_0FBF40 )
    BRA code_0FBF2D
}

code_0FBF40 {
    COP [85] ( @code_0FBF4B )
    COP [1B] ( &code_0FBF25, #$00B4 )
}

code_0FBF4B {
    LDA #$02A0
    STA $0016, X
    LDA #$00FF
    STA $0030, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$90
    COP [A0] ( #$FF50 )
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @code_0FBF88 )
    COP [A0] ( #$0080 )
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @code_0FBF88 )
    COP [A1] ( #$FFE8, #$0048 )
    COP [80] ( #02 )
    COP [82]
    COP [86]
    RTL 
}

code_0FBF88 {
    LDA #$00FF
    STA $0030, X
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #01 )
    COP [82]
    COP [86]
    RTL 
}