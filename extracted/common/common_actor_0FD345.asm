?BANK 1F

---------------------------------------------

code_0FD345 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X

  code_0FD34E:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD35C

  code_0FD356:
    COP [1B] ( &code_0FD34E, #$0004 )

  loc_0FD35C:
    COP [9A] ( #$0010, &code_0FD366, &code_0FD370, &code_0FD366 )
}

code_0FD366 {
    COP [9B] ( #$0010, &code_0FD356, &code_0FD37A, &code_0FD356 )
}

code_0FD370 {
    COP [9B] ( #$0000, &code_0FD3C2, &code_0FD3E2, &code_0FD3E2 )
}

code_0FD37A {
    COP [9A] ( #$0000, &code_0FD384, &code_0FD3A3, &code_0FD3A3 )
}

code_0FD384 {
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0D, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0E, #10 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FD34E
}

code_0FD3A3 {
    COP [96]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0D, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0E, #10 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FD34E
}

code_0FD3C2 {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0B, #04 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0C, #10 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    BRL code_0FD34E
}

code_0FD3E2 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #09, #04 )
    COP [83]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0A, #10 )
    COP [83]
    COP [80] ( #06 )
    COP [82]
    BRL code_0FD34E
}