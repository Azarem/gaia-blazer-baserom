?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F85E1 {
    COP [3B] ( #$00A5, &code_0F85F7 ) ; {1017313}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1017319}
    SEP #$20              ; {1017323}
    LDA #$^engine_003005.code_00305F ; {1017325}
    PHA                   ; {1017327}
    REP #$20              ; {1017328}
    LDA #$&engine_003005.code_00305F-1 ; {1017330}
    PHA                   ; {1017333}
    RTL                   ; {1017334}
}

code_0F85F7 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1017335}
    COP [17] ( &code_0F861C ) ; {1017340}
    COP [15]              ; {1017344}

  code_0F8602:
    COP [80] ( #01 )      ; {1017346}
    COP [82]              ; {1017349}
    COP [07] ( #$0003, &code_0F8602 ) ; {1017351}
    COP [16]              ; {1017357}

  loc_0F860F:
    COP [80] ( #03 )      ; {1017359}
    COP [82]              ; {1017362}
    COP [80] ( #04 )      ; {1017364}
    COP [82]              ; {1017367}
    BRL loc_0F860F        ; {1017369}
}

code_0F861C {
    COP [07] ( #$8503, &code_0F8627 ) ; {1017372}
    COP [01] ( &asciistring_0F862C ) ; {1017378}
    RTL                   ; {1017382}
}

code_0F8627 {
    COP [01] ( &asciistring_0F86E3 ) ; {1017383}
    RTL                   ; {1017387}
}

asciistring_0F862C |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]As a reward for saving[N]us I will tell you a [N]secret- [FIN]No armor will protect [N]you against the Magma [N]off the volcanic [N]island, Durean- [FIN]You must find a way to[N]stop the volcano- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F86E3 |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]You have seized the [N]volcano, right? [N]You are a very brave [N]person- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|