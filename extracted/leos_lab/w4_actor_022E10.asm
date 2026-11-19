?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022E10 {
    COP [14] ( #$0142, &code_022E17 ) ; {142864}
    RTL                   ; {142870}
}

code_022E17 {
    COP [30] ( #$0142, &code_022E7E, #04 ) ; {142871}
    COP [07] ( #$8603, &code_022E53 ) ; {142878}
    COP [85] ( @engine_0026F3.code_00299D ) ; {142884}
    COP [17] ( &code_022E60 ) ; {142889}
    BRL loc_022E37        ; {142893}

  loc_022E30:
    BRK #$43              ; {142896}
    COP [80] ( #02 )      ; {142898}
    COP [82]              ; {142901}

  loc_022E37:
    COP [91]              ; {142903}
    COP [0C] ( #00, #02, &code_022E40 ) ; {142905}
    RTL                   ; {142911}
}

code_022E40 {
    BRK #$43              ; {142912}
    COP [80] ( #01 )      ; {142914}
    COP [82]              ; {142917}
    COP [91]              ; {142919}
    COP [0C] ( #00, #02, &code_022E52 ) ; {142921}
    BRL loc_022E30        ; {142927}
}

code_022E52 {
    RTL                   ; {142930}
}

code_022E53 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {142931}
    COP [80] ( #1F )      ; {142936}
    COP [82]              ; {142939}
    COP [91]              ; {142941}
    RTL                   ; {142943}
}

code_022E60 {
    COP [01] ( &asciistring_022EEE ) ; {142944}
    COP [09] ( #$8603 )   ; {142948}
    BRK #$4E              ; {142952}
    SEP #$20              ; {142954}
    LDA $1B82             ; {142956}
    ORA #$08              ; {142959}
    STA $1B82             ; {142961}
    REP #$20              ; {142964}
    COP [17] ( #$0000 )   ; {142966}
    COP [27] ( &code_022E53 ) ; {142970}
}

code_022E7E {
    COP [01] ( &asciistring_022E85 ) ; {142974}
    COP [86]              ; {142978}
    RTL                   ; {142980}
}

asciistring_022E85 |[10][0E:3C][02:2] hears [N]the door [N]speaking to itself- [FIN]I can see------ [FIN]I can see machines [N]throwing bombs inside [N]the model towns- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022EEE |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]Let me join you- [FIN]The soul that enables [N]you to see invisible [N]enemies in model towns[N]joins you- [JMP:&w4_shared_023F33.asciistring_023FA3]|