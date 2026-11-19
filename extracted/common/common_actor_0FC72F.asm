?BANK 1F

---------------------------------------------

code_0FC72F {
    COP [A4]
    COP [A5] ( &code_0FC766, &code_0FC7BC, &code_0FC791, &code_0FC73B )
}

code_0FC73B {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [21] ( &code_0FC773 )

  code_0FC748:
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$FFF8 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$FFF8 )
    BRA code_0FC73B
}

code_0FC766 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [22] ( &code_0FC748 )
}

code_0FC773 {
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$0008 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$0008 )
    BRA code_0FC766
}

code_0FC791 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [24] ( &code_0FC7C9 )

  code_0FC79E:
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$0008 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$0008 )
    BRA code_0FC791
}

code_0FC7BC {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [23] ( &code_0FC79E )
}

code_0FC7C9 {
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$FFF8 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$FFF8 )
    BRA code_0FC7BC
}

code_0FC7E7 {
    COP [A7]
    COP [80] ( #0B )
    COP [82]
    LDA #$1000
    STA $0016, X

  loc_0FC7F4:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FC7FD, &code_0FC819 )
}

code_0FC7FD {
    COP [9A] ( #$0010, &code_0FC807, &code_0FC810, &code_0FC810 )
}

code_0FC807 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC810 {
    COP [96]
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC819 {
    COP [9B] ( #$0010, &code_0FC823, &code_0FC82C, &code_0FC82C )
}

code_0FC823 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC82C {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC835 {
    LDA #$0300
    STA $0016, X
    COP [A4]
    COP [80] ( #0A )
    COP [82]
    COP [86]
    RTL 
}