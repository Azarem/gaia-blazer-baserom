?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022E10 {
    COP [14] ( #$0142, &code_022E17 )
    RTL 
}

code_022E17 {
    COP [30] ( #$0142, &code_022E7E, #04 )
    COP [07] ( #$8603, &code_022E53 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022E60 )
    BRL loc_022E37

  loc_022E30:
    BRK #$43
    COP [80] ( #02 )
    COP [82]

  loc_022E37:
    COP [91]
    COP [0C] ( #00, #02, &code_022E40 )
    RTL 
}

code_022E40 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_022E52 )
    BRL loc_022E30
}

code_022E52 {
    RTL 
}

code_022E53 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [80] ( #1F )
    COP [82]
    COP [91]
    RTL 
}

code_022E60 {
    COP [01] ( &asciistring_022EEE )
    COP [09] ( #$8603 )
    BRK #$4E
    SEP #$20
    LDA $1B82
    ORA #$08
    STA $1B82
    REP #$20
    COP [17] ( #$0000 )
    COP [27] ( &code_022E53 )
}

code_022E7E {
    COP [01] ( &asciistring_022E85 )
    COP [86]
    RTL 
}

asciistring_022E85 |[10][0E:3C][02:2] hears [N]the door [N]speaking to itself- [FIN]I can see------ [FIN]I can see machines [N]throwing bombs inside [N]the model towns- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022EEE |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]Let me join you- [FIN]The soul that enables [N]you to see invisible [N]enemies in model towns[N]joins you- [JMP:&w4_shared_023F33.asciistring_023FA3]|