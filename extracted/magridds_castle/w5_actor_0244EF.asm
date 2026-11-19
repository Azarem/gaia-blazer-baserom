?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0244EF {
    COP [14] ( #$0166, &code_0244F6 ) ; {148719}
    RTL                   ; {148725}
}

code_0244F6 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {148726}
    COP [17] ( &code_024504 ) ; {148731}
    COP [15]              ; {148735}
    COP [91]              ; {148737}
    RTL                   ; {148739}
}

code_024504 {
    COP [14] ( #$0195, &code_02450F ) ; {148740}
    COP [01] ( &asciistring_024514 ) ; {148746}
    RTL                   ; {148750}
}

code_02450F {
    COP [01] ( &asciistring_024575 ) ; {148751}
    RTL                   ; {148755}
}

asciistring_024514 |[10]This is King [N]Magridd s Castle- [FIN]Our King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█this█or[N]I█will█be█punished-[JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024575 |[10]I think he is in shock[N]after losing the [N]Queen- [JMP:&w5_shared_02706C.asciistring_0270DF]|