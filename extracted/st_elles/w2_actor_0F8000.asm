?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8000 {
    COP [3B] ( #$007C, &code_0F8016 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F8016 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [17] ( &code_0F8029 )

  loc_0F8021:
    COP [80] ( #11 )
    COP [82]
    BRL loc_0F8021
}

code_0F8029 {
    COP [07] ( #$8704, &code_0F804A )
    COP [19] ( #1C, &code_0F8045 )
    COP [01] ( &asciistring_0F8059 )
    COP [3C] ( #04 )
    COP [10] ( #$0209, #01, #$0078, #$0410 )
    RTL 
}

code_0F8045 {
    COP [01] ( &asciistring_0F804F )
    RTL 
}

code_0F804A {
    COP [01] ( &asciistring_0F8080 )
    RTL 
}

asciistring_0F804F |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8059 |[10][02:2] placed [N]the Dream Rod on [N]the dolphin s nose- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8080 |[10]I always have the same[N]dream- Isn t that [N]strange! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|