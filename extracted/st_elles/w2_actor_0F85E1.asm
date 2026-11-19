?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F85E1 {
    COP [3B] ( #$00A5, &code_0F85F7 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F85F7 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F861C )
    COP [15]

  code_0F8602:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F8602 )
    COP [16]

  loc_0F860F:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F860F
}

code_0F861C {
    COP [07] ( #$8503, &code_0F8627 )
    COP [01] ( &asciistring_0F862C )
    RTL 
}

code_0F8627 {
    COP [01] ( &asciistring_0F86E3 )
    RTL 
}

asciistring_0F862C |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]As a reward for saving[N]us I will tell you a [N]secret- [FIN]No armor will protect [N]you against the Magma [N]off the volcanic [N]island, Durean- [FIN]You must find a way to[N]stop the volcano- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F86E3 |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]You have seized the [N]volcano, right? [N]You are a very brave [N]person- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|