?BANK 1F

---------------------------------------------

code_0FECD9 {
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [A5] ( &code_0FECEC, &code_0FECF9, &code_0FED06, &code_0FED06 )
}

code_0FECEC {
    COP [99]

  loc_0FECEE:
    COP [22] ( &code_0FECF9 )
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FECEE
}

code_0FECF9 {
    COP [98]

  loc_0FECFB:
    COP [21] ( &code_0FECEC )
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FECFB
}

code_0FED06 {
    COP [86]
    RTL 
}