?BANK 1F

---------------------------------------------

code_0FC845 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC854 )
    COP [1B] ( &code_0FC845, #$0008 )
}

code_0FC854 {
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #1F )
    COP [82]

  loc_0FC85E:
    COP [AD] ( #08 )
    COP [80] ( #20 )
    COP [82]
    COP [9A] ( #$0018, &code_0FC884, &code_0FC870, &code_0FC895 )
}

code_0FC870 {
    COP [9B] ( #$0000, &code_0FC8A6, &code_0FC8B7, &code_0FC8B7 )

  code_0FC87A:
    COP [9A] ( #$0000, &code_0FC884, &code_0FC895, &code_0FC895 )
}

code_0FC884 {
    COP [23] ( &code_0FC88F )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC88F {
    COP [1B] ( &code_0FC870, #$0008 )
}

code_0FC895 {
    COP [24] ( &code_0FC8A0 )
    COP [80] ( #23 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8A0 {
    COP [1B] ( &code_0FC870, #$0008 )
}

code_0FC8A6 {
    COP [21] ( &code_0FC8B1 )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8B1 {
    COP [1B] ( &code_0FC87A, #$0008 )
}

code_0FC8B7 {
    COP [22] ( &code_0FC8C2 )
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8C2 {
    COP [1B] ( &code_0FC87A, #$0008 )

  loc_0FC8C8:
    COP [80] ( #25 )
    COP [82]
    COP [0C] ( #00, #04, &code_0FC8D5 )
    BRA loc_0FC85E
}

code_0FC8D5 {
    COP [85] ( @code_0FC8F0 )
    LDA #$0200
    STA $0016, X
    COP [80] ( #27 )
    COP [82]
    STZ $0016, X
    COP [80] ( #1F )
    COP [82]
    BRL loc_0FC85E
}

code_0FC8F0 {
    LDA #$0200
    STA $0016, X
    COP [80] ( #26 )
    COP [82]
    COP [86]
    RTL 
}