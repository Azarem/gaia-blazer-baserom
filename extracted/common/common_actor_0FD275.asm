?BANK 1F

---------------------------------------------

code_0FD275 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [A5] ( &code_0FD316, &code_0FD2EA, &code_0FD288, &code_0FD2BC )
}

code_0FD288 {
    COP [21] ( &code_0FD29C )
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [97]
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FD2D2
}

code_0FD29C {
    COP [24] ( &code_0FD2AC )

  loc_0FD2A0:
    COP [96]
    COP [81] ( #05, #02 )
    COP [83]
    COP [97]
    BRA code_0FD288
}

code_0FD2AC {
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [97]
    COP [80] ( #00 )
    COP [82]
    BRA code_0FD316
}

code_0FD2BC {
    COP [23] ( &code_0FD2CE )
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FD300
}

code_0FD2CE {
    COP [21] ( &code_0FD2DA )

  loc_0FD2D2:
    COP [81] ( #04, #02 )
    COP [83]
    BRA code_0FD2BC
}

code_0FD2DA {
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FD288
}

code_0FD2EA {
    COP [22] ( &code_0FD2FC )
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FD32F
}

code_0FD2FC {
    COP [23] ( &code_0FD308 )

  loc_0FD300:
    COP [81] ( #05, #02 )
    COP [83]
    BRA code_0FD2EA
}

code_0FD308 {
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRA code_0FD2BC
}

code_0FD316 {
    COP [24] ( &code_0FD32B )
    COP [97]
    COP [80] ( #00 )
    COP [82]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    BRL loc_0FD2A0
}

code_0FD32B {
    COP [22] ( &code_0FD337 )

  loc_0FD32F:
    COP [81] ( #03, #02 )
    COP [83]
    BRA code_0FD316
}

code_0FD337 {
    COP [97]
    COP [80] ( #00 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FD2EA
}