?BANK 1F

---------------------------------------------

code_0FBABC {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [A5] ( &code_0FBB0B, &code_0FBAF7, &code_0FBACF, &code_0FBAE3 )
}

code_0FBACF {
    COP [21] ( &code_0FBAD5 )
    BRA loc_0FBAED
}

code_0FBAD5 {
    COP [24] ( &code_0FBB0B )

  loc_0FBAD9:
    COP [96]
    COP [81] ( #27, #02 )
    COP [83]
    BRA code_0FBACF
}

code_0FBAE3 {
    COP [23] ( &code_0FBAE9 )
    BRA loc_0FBB01
}

code_0FBAE9 {
    COP [21] ( &code_0FBACF )

  loc_0FBAED:
    COP [97]
    COP [81] ( #26, #02 )
    COP [83]
    BRA code_0FBAE3
}

code_0FBAF7 {
    COP [22] ( &code_0FBAFD )
    BRA loc_0FBB15
}

code_0FBAFD {
    COP [23] ( &code_0FBAE3 )

  loc_0FBB01:
    COP [97]
    COP [81] ( #27, #02 )
    COP [83]
    BRA code_0FBAF7
}

code_0FBB0B {
    COP [24] ( &code_0FBB11 )
    BRA loc_0FBAD9
}

code_0FBB11 {
    COP [22] ( &code_0FBAF7 )

  loc_0FBB15:
    COP [97]
    COP [81] ( #25, #02 )
    COP [83]
    BRA code_0FBB0B
}