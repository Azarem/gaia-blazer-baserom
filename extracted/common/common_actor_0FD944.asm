?BANK 1F

---------------------------------------------

code_0FD944 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD952

  code_0FD94C:
    COP [1B] ( &code_0FD944, #$0004 )

  loc_0FD952:
    COP [9B] ( #$0008, &code_0FD95C, &code_0FD976, &code_0FD969 )
}

code_0FD95C {
    COP [21] ( &code_0FD99C )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FD944
}

code_0FD969 {
    COP [22] ( &code_0FD99C )
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA code_0FD944
}

code_0FD976 {
    COP [9A] ( #$0000, &code_0FD980, &code_0FD98A, &code_0FD98A )
}

code_0FD980 {
    COP [97]
    COP [81] ( #02, #02 )
    COP [83]
    BRA code_0FD994
}

code_0FD98A {
    COP [96]
    COP [81] ( #02, #02 )
    COP [83]
    BRA code_0FD994

  code_0FD994:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD9A2
}

code_0FD99C {
    COP [1B] ( &code_0FD994, #$0004 )

  loc_0FD9A2:
    COP [9A] ( #$0008, &code_0FD9AC, &code_0FD9C6, &code_0FD9B9 )
}

code_0FD9AC {
    COP [23] ( &code_0FD94C )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FD994
}

code_0FD9B9 {
    COP [24] ( &code_0FD94C )
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FD994
}

code_0FD9C6 {
    COP [9B] ( #$0000, &code_0FD9D0, &code_0FD9DB, &code_0FD9DB )
}

code_0FD9D0 {
    COP [97]
    COP [81] ( #01, #02 )
    COP [83]
    BRL code_0FD944
}

code_0FD9DB {
    COP [97]
    COP [81] ( #00, #02 )
    COP [83]
    BRL code_0FD944
}