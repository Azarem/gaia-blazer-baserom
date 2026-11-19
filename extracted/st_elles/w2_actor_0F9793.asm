?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F9793 {
    COP [3B] ( #$00C0, &code_0F97A9 ) ; {1021843}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1021849}
    SEP #$20              ; {1021853}
    LDA #$^engine_003005.code_00305F ; {1021855}
    PHA                   ; {1021857}
    REP #$20              ; {1021858}
    LDA #$&engine_003005.code_00305F-1 ; {1021860}
    PHA                   ; {1021863}
    RTL                   ; {1021864}
}

code_0F97A9 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1021865}
    COP [17] ( &code_0F97E2 ) ; {1021870}
    COP [91]              ; {1021874}

  loc_0F97B4:
    COP [97]              ; {1021876}
    COP [81] ( #0B, #05 ) ; {1021878}
    COP [83]              ; {1021882}
    COP [9F] ( #$0008 )   ; {1021884}
    COP [81] ( #0A, #02 ) ; {1021888}
    COP [83]              ; {1021892}
    COP [9F] ( #$FFF8 )   ; {1021894}
    COP [96]              ; {1021898}
    COP [81] ( #0B, #05 ) ; {1021900}
    COP [83]              ; {1021904}
    COP [9F] ( #$0008 )   ; {1021906}
    COP [81] ( #09, #02 ) ; {1021910}
    COP [83]              ; {1021914}
    COP [9F] ( #$FFF8 )   ; {1021916}
    BRA loc_0F97B4        ; {1021920}
}

code_0F97E2 {
    COP [01] ( &asciistring_0F97E7 ) ; {1021922}
    RTL                   ; {1021926}
}

asciistring_0F97E7 |[10]The coral reef is home[N]to the dolphins- [FIN]The pearls made in the[N]reef are their [N]treasure- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|