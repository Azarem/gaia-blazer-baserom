?BANK 1F

---------------------------------------------

code_0FAEE5 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [A5] ( &code_0FAF32, &code_0FAF20, &code_0FAEF8, &code_0FAF0E )
}

code_0FAEF8 {
    COP [21] ( &code_0FAEFE )
    BRA loc_0FAF18
}

code_0FAEFE {
    COP [24] ( &code_0FAF32 )

  loc_0FAF02:
    COP [96]
    COP [81] ( #21, #02 )
    COP [83]
    COP [97]
    BRA code_0FAEF8
}

code_0FAF0E {
    COP [23] ( &code_0FAF14 )
    BRA loc_0FAF2A
}

code_0FAF14 {
    COP [21] ( &code_0FAEF8 )

  loc_0FAF18:
    COP [81] ( #20, #02 )
    COP [83]
    BRA code_0FAF0E
}

code_0FAF20 {
    COP [22] ( &code_0FAF26 )
    BRA loc_0FAF3C
}

code_0FAF26 {
    COP [23] ( &code_0FAF0E )

  loc_0FAF2A:
    COP [81] ( #21, #02 )
    COP [83]
    BRA code_0FAF20
}

code_0FAF32 {
    COP [24] ( &code_0FAF38 )
    BRA loc_0FAF02
}

code_0FAF38 {
    COP [22] ( &code_0FAF20 )

  loc_0FAF3C:
    COP [81] ( #1F, #02 )
    COP [83]
    BRA code_0FAF32
}