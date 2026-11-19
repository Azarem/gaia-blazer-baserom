?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F88CC {
    COP [3B] ( #$00BE, &code_0F88E2 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F88E2 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F88F5 )

  loc_0F88EB:
    COP [81] ( #12, #04 )
    COP [83]
    COP [87]
    BRA loc_0F88EB
}

code_0F88F5 {
    COP [01] ( &asciistring_0F88FA )
    RTL 
}

asciistring_0F88FA |[10]The coral reef [N]hides many dangerous [N]monsters- Make sure [N]to use magic there- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|