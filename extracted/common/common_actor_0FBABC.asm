?BANK 1F

---------------------------------------------

code_0FBABC {
    LDA $001A, X          ; {1030844}
    ORA #$0400            ; {1030847}
    STA $001A, X          ; {1030850}
    COP [A5] ( &code_0FBB0B, &code_0FBAF7, &code_0FBACF, &code_0FBAE3 ) ; {1030853}
}

code_0FBACF {
    COP [21] ( &code_0FBAD5 ) ; {1030863}
    BRA loc_0FBAED        ; {1030867}
}

code_0FBAD5 {
    COP [24] ( &code_0FBB0B ) ; {1030869}

  loc_0FBAD9:
    COP [96]              ; {1030873}
    COP [81] ( #27, #02 ) ; {1030875}
    COP [83]              ; {1030879}
    BRA code_0FBACF       ; {1030881}
}

code_0FBAE3 {
    COP [23] ( &code_0FBAE9 ) ; {1030883}
    BRA loc_0FBB01        ; {1030887}
}

code_0FBAE9 {
    COP [21] ( &code_0FBACF ) ; {1030889}

  loc_0FBAED:
    COP [97]              ; {1030893}
    COP [81] ( #26, #02 ) ; {1030895}
    COP [83]              ; {1030899}
    BRA code_0FBAE3       ; {1030901}
}

code_0FBAF7 {
    COP [22] ( &code_0FBAFD ) ; {1030903}
    BRA loc_0FBB15        ; {1030907}
}

code_0FBAFD {
    COP [23] ( &code_0FBAE3 ) ; {1030909}

  loc_0FBB01:
    COP [97]              ; {1030913}
    COP [81] ( #27, #02 ) ; {1030915}
    COP [83]              ; {1030919}
    BRA code_0FBAF7       ; {1030921}
}

code_0FBB0B {
    COP [24] ( &code_0FBB11 ) ; {1030923}
    BRA loc_0FBAD9        ; {1030927}
}

code_0FBB11 {
    COP [22] ( &code_0FBAF7 ) ; {1030929}

  loc_0FBB15:
    COP [97]              ; {1030933}
    COP [81] ( #25, #02 ) ; {1030935}
    COP [83]              ; {1030939}
    BRA code_0FBB0B       ; {1030941}
}