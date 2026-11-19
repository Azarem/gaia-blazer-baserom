?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8577 {
    COP [3B] ( #$00C2, &code_0F858D )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F858D {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F85B2 )
    COP [15]

  code_0F8598:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F8598 )
    COP [16]

  loc_0F85A5:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F85A5
}

code_0F85B2 {
    COP [01] ( &asciistring_0F85B7 )
    RTL 
}

asciistring_0F85B7 |[10]My name is Anna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|