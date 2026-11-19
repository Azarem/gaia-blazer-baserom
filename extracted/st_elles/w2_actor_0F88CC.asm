?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F88CC {
    COP [3B] ( #$00BE, &code_0F88E2 ) ; {1018060}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1018066}
    SEP #$20              ; {1018070}
    LDA #$^engine_003005.code_00305F ; {1018072}
    PHA                   ; {1018074}
    REP #$20              ; {1018075}
    LDA #$&engine_003005.code_00305F-1 ; {1018077}
    PHA                   ; {1018080}
    RTL                   ; {1018081}
}

code_0F88E2 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1018082}
    COP [17] ( &code_0F88F5 ) ; {1018087}

  loc_0F88EB:
    COP [81] ( #12, #04 ) ; {1018091}
    COP [83]              ; {1018095}
    COP [87]              ; {1018097}
    BRA loc_0F88EB        ; {1018099}
}

code_0F88F5 {
    COP [01] ( &asciistring_0F88FA ) ; {1018101}
    RTL                   ; {1018105}
}

asciistring_0F88FA |[10]The coral reef [N]hides many dangerous [N]monsters- Make sure [N]to use magic there- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|