?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0240E5 {
    COP [14] ( #$015F, &code_0240EC )
    RTL 
}

code_0240EC {
    COP [30] ( #$015F, &code_024111, #04 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_024101 )
    COP [15]
    COP [91]
    RTL 
}

code_024101 {
    COP [14] ( #$0195, &code_02410C )
    COP [01] ( &asciistring_024194 )
    RTL 
}

code_02410C {
    COP [01] ( &asciistring_0241F2 )
    RTL 
}

code_024111 {
    COP [01] ( &asciistring_024118 )
    COP [86]
    RTL 
}

asciistring_024118 |[10][0E:3C]Thank you very much- [FIN]There are many thorns [N]in the basement- [FIN]If you free the [N]soldier right in front[N]of where I have been [N]captured, [FIN]you will receive [N]the Elemental Mail- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024194 |[10]This is King Magridd s[N]Castle- [FIN]The King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█that█or[N]I█will█be█punished-[JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0241F2 |[10]This is the Castle of [N]King Magridd- [FIN]The King is the [N]greatest man in the [N]world- [FIN]I don t have to say [N]that anymore, because [N]the King really did [N]become a good man- [JMP:&w5_shared_02706C.asciistring_0270DF]|