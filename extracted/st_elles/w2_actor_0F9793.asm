?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F9793 {
    COP [3B] ( #$00C0, &code_0F97A9 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F97A9 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F97E2 )
    COP [91]

  loc_0F97B4:
    COP [97]
    COP [81] ( #0B, #05 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #0A, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0B, #05 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #09, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    BRA loc_0F97B4
}

code_0F97E2 {
    COP [01] ( &asciistring_0F97E7 )
    RTL 
}

asciistring_0F97E7 |[10]The coral reef is home[N]to the dolphins- [FIN]The pearls made in the[N]reef are their [N]treasure- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|