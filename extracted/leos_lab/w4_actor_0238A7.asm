?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0238A7 {
    COP [14] ( #$013C, &code_0238AE ) ; {145575}
    RTL                   ; {145581}
}

code_0238AE {
    COP [85] ( @engine_0026F3.code_00299D ) ; {145582}
    COP [17] ( &code_0238D3 ) ; {145587}
    COP [15]              ; {145591}

  loc_0238B9:
    COP [0C] ( #00, #04, &code_0238C6 ) ; {145593}
    COP [80] ( #0C )      ; {145599}
    COP [82]              ; {145602}
    BRA loc_0238B9        ; {145604}
}

code_0238C6 {
    COP [80] ( #1E )      ; {145606}
    COP [82]              ; {145609}
    COP [0C] ( #00, #04, &code_0238C6 ) ; {145611}
    BRA loc_0238B9        ; {145617}
}

code_0238D3 {
    COP [07] ( #$0605, &code_0238DF ) ; {145619}
    COP [07] ( #$8606, &code_0238E4 ) ; {145625}
}

code_0238DF {
    COP [01] ( &asciistring_0238F8 ) ; {145631}
    RTL                   ; {145635}
}

code_0238E4 {
    COP [18] ( #15, &code_0238EE ) ; {145636}
    COP [01] ( &asciistring_023976 ) ; {145641}
    RTL                   ; {145645}
}

code_0238EE {
    COP [01] ( &asciistring_023921 ) ; {145646}
    BRK #$5E              ; {145650}
    COP [0A] ( #15 )      ; {145652}
    RTL                   ; {145655}
}

asciistring_0238F8 |[10]We cannot walk [N]around outside because[N]of the cats- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023921 |[10]Thank you for getting [N]rid of the cats- [FIN]Take this magic, the [N]Magic of Spark Bomb- [FIN][02:2] received [N][03:24]Spark Bomb- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023976 |[10]It is not easy to hit [N]the enemies with Spark[N]Bomb, but if you do, [N]it works very well- [JMP:&w4_shared_023F33.asciistring_023FA3]|