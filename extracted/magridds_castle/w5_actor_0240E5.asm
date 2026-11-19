?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0240E5 {
    COP [14] ( #$015F, &code_0240EC ) ; {147685}
    RTL                   ; {147691}
}

code_0240EC {
    COP [30] ( #$015F, &code_024111, #04 ) ; {147692}
    COP [85] ( @engine_0026F3.code_00299D ) ; {147699}
    COP [17] ( &code_024101 ) ; {147704}
    COP [15]              ; {147708}
    COP [91]              ; {147710}
    RTL                   ; {147712}
}

code_024101 {
    COP [14] ( #$0195, &code_02410C ) ; {147713}
    COP [01] ( &asciistring_024194 ) ; {147719}
    RTL                   ; {147723}
}

code_02410C {
    COP [01] ( &asciistring_0241F2 ) ; {147724}
    RTL                   ; {147728}
}

code_024111 {
    COP [01] ( &asciistring_024118 ) ; {147729}
    COP [86]              ; {147733}
    RTL                   ; {147735}
}

asciistring_024118 |[10][0E:3C]Thank you very much- [FIN]There are many thorns [N]in the basement- [FIN]If you free the [N]soldier right in front[N]of where I have been [N]captured, [FIN]you will receive [N]the Elemental Mail- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024194 |[10]This is King Magridd s[N]Castle- [FIN]The King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█that█or[N]I█will█be█punished-[JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0241F2 |[10]This is the Castle of [N]King Magridd- [FIN]The King is the [N]greatest man in the [N]world- [FIN]I don t have to say [N]that anymore, because [N]the King really did [N]become a good man- [JMP:&w5_shared_02706C.asciistring_0270DF]|