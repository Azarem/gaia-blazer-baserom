?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_02108F {
    COP [3B] ( #$00D6, &code_0210A5 ) ; {135311}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {135317}
    SEP #$20              ; {135321}
    LDA #$^engine_003005.code_00305F ; {135323}
    PHA                   ; {135325}
    REP #$20              ; {135326}
    LDA #$&engine_003005.code_00305F-1 ; {135328}
    PHA                   ; {135331}
    RTL                   ; {135332}
}

code_0210A5 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {135333}
    COP [17] ( &code_0210B3 ) ; {135338}
    COP [15]              ; {135342}
    COP [91]              ; {135344}
    RTL                   ; {135346}
}

code_0210B3 {
    COP [07] ( #$9B03, &code_0210C7 ) ; {135347}
    COP [01] ( &asciistring_0210CC ) ; {135353}
    BRK #$5E              ; {135357}
    COP [0A] ( #3D )      ; {135359}
    COP [09] ( #$9B03 )   ; {135362}
    RTL                   ; {135366}
}

code_0210C7 {
    COP [01] ( &asciistring_021224 ) ; {135367}
    RTL                   ; {135371}
}

asciistring_0210CC |[10]My name is Nome- [N]I used to live in [N]Dr-Leo s house- [FIN]Dr-Leo was asked by [N]King Magridd to build [N]a machine that would [N]call upon evil- [FIN]Because he refused, he[N]was taken to Magridd [N]Castle- [FIN]He secretly gave us 4 [N]stones and told us to [N]run away- [FIN]Those stones are keys [N]to the World of Evil- [FIN]The other stones are [N]in Dr-Leo s [N]Laboratory and in the [N]Castle of Magridd- [FIN]Here, take this [03:24]Silver[N]Stone [03:20]and hurry to the[N]Laboratory where [N]Dr-Leo was held- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021224 |[10]What is his daughters [N]name? Lisa? [N]I wonder how she is [N]doing? [JMP:&w3_shared_02249A.asciistring_02251E]|