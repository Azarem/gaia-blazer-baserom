?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01BCEC {
    COP [14] ( #$005A, &code_01BCF3 ) ; {113900}
    RTL                   ; {113906}
}

code_01BCF3 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {113907}
    COP [17] ( &code_01BD11 ) ; {113912}

  loc_01BCFC:
    COP [81] ( #11, #03 ) ; {113916}
    COP [83]              ; {113920}
    COP [15]              ; {113922}
    COP [1B] ( &code_01BD0A, #$0028 ) ; {113924}
}

code_01BD0A {
    COP [16]              ; {113930}
    COP [87]              ; {113932}
    BRL loc_01BCFC        ; {113934}
}

code_01BD11 {
    COP [07] ( #$8402, &code_01BD1D ) ; {113937}
    COP [14] ( #$0061, &code_01BD22 ) ; {113943}
}

code_01BD1D {
    COP [01] ( &asciistring_01BD27 ) ; {113949}
    RTL                   ; {113953}
}

code_01BD22 {
    COP [01] ( &asciistring_01BD84 ) ; {113954}
    RTL                   ; {113958}
}

asciistring_01BD27 |[10]I am guarding the [N]graveyard- [FIN]I hear someone snoring[N]but can t tell from [N]which direction the [N]sound is coming- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01BD84 |[10]I am guarding the [N]graveyard- [FIN]I hear someone snoring[N]but can t tell which [N]direction the sound [N]is coming from- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|