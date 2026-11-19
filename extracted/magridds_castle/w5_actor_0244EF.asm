?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0244EF {
    COP [14] ( #$0166, &code_0244F6 )
    RTL 
}

code_0244F6 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_024504 )
    COP [15]
    COP [91]
    RTL 
}

code_024504 {
    COP [14] ( #$0195, &code_02450F )
    COP [01] ( &asciistring_024514 )
    RTL 
}

code_02450F {
    COP [01] ( &asciistring_024575 )
    RTL 
}

asciistring_024514 |[10]This is King [N]Magridd s Castle- [FIN]Our King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█this█or[N]I█will█be█punished-[JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024575 |[10]I think he is in shock[N]after losing the [N]Queen- [JMP:&w5_shared_02706C.asciistring_0270DF]|