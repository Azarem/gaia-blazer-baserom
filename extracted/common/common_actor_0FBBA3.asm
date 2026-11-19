?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FBBA3 {
    COP [A3]
    COP [A2] ( #30 )

  loc_0FBBA8:
    COP [AD] ( #10 )
    COP [9A] ( #$0018, &code_0FBBB5, &code_0FBBC9, &code_0FBBB5 )
}

code_0FBBB5 {
    COP [9B] ( #$0018, &code_0FBBD3, &code_0FBBBF, &code_0FBBD3 )
}

code_0FBBBF {
    COP [9A] ( #$0000, &code_0FBC01, &code_0FBC09, &code_0FBC09 )
}

code_0FBBC9 {
    COP [9B] ( #$0000, &code_0FBC11, &code_0FBC19, &code_0FBC19 )
}

code_0FBBD3 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FBBE5
    DEC 
    BEQ loc_0FBBEC
    DEC 
    BEQ loc_0FBBF3
    BRA loc_0FBBFA

  loc_0FBBE5:
    COP [80] ( #03 )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBEC:
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBF3:
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBFA:
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FBBA8
}

code_0FBC01 {
    COP [81] ( #2A, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC09 {
    COP [81] ( #2B, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC11 {
    COP [81] ( #29, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC19 {
    COP [81] ( #28, #02 )
    COP [83]
    BRL code_0FBBD3
}