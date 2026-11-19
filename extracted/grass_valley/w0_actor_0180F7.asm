?BANK 03

?INCLUDE 'lib_014F02'
?INCLUDE 'w0_shared_01B988'

!L_choice_result                0003D0

---------------------------------------------

code_0180F7 {
    COP [14] ( #$0002, &code_0180FE ) ; {98551}
    RTL                   ; {98557}
}

code_0180FE {
    COP [30] ( #$0002, &code_018159, #03 ) ; {98558}
    COP [14] ( #$0009, &code_018114 ) ; {98565}
    COP [17] ( &code_01812B ) ; {98571}
    COP [15]              ; {98575}
    COP [91]              ; {98577}
    RTL                   ; {98579}
}

code_018114 {
    COP [07] ( #$9F02, &code_018128 ) ; {98580}
    COP [17] ( &code_018160 ) ; {98586}
    COP [11] ( #04, #3B, #1E ) ; {98590}
    COP [15]              ; {98595}
    COP [91]              ; {98597}
    RTL                   ; {98599}
}

code_018128 {
    COP [86]              ; {98600}
    RTL                   ; {98602}
}

code_01812B {
    COP [07] ( #$8101, &code_018152 ) ; {98603}
    COP [01] ( &asciistring_01816F ) ; {98609}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01814D ) ; {98613}
    LDA $L_choice_result  ; {98620}
    BNE code_01814D       ; {98624}
    COP [09] ( #$8101 )   ; {98626}
    COP [01] ( &asciistring_018211 ) ; {98630}
    BRL loc_018156        ; {98634}
}

code_01814D {
    COP [01] ( &asciistring_0181F8 ) ; {98637}
    RTL                   ; {98641}
}

code_018152 {
    COP [01] ( &asciistring_018255 ) ; {98642}

  loc_018156:
    COP [37]              ; {98646}
    RTL                   ; {98648}
}

code_018159 {
    COP [01] ( &asciistring_01832D ) ; {98649}
    COP [86]              ; {98653}
    RTL                   ; {98655}
}

code_018160 {
    COP [18] ( #29, &code_01816A ) ; {98656}
    COP [01] ( &asciistring_0182E7 ) ; {98661}
    RTL                   ; {98665}
}

code_01816A {
    COP [01] ( &asciistring_0182AC ) ; {98666}
    RTL                   ; {98670}
}

asciistring_01816F |[10]My husband used to be [N]the village Chief- [FIN]One day he suddenly [N]disappeared along with[N]the other villagers- [FIN]I feel so lonely---- [N]How about being one of[N]my children? [END]|

asciistring_0181F8 |Well, [N]that s too bad- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018211 |Really?! [N]I will call you [N][02:2] from now on- [FIN]Use the second floor [N]as your own room- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018255 |[10][02:2], [N]you are just walking [N]around doing nothing- [FIN]I am beginning to [N]worry about you- [N]Please, stay here and [N]rest- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0182AC |[10]I feel bad for Lisa, [N]having been separated [N]from her parents- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0182E7 |[10][02:2]! [FIN]Soldiers from Magridd [N]were just here! [N]They kidnapped Lisa! [N]You must rescue her! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01832D |[10]You hear a sigh coming[N]from inside the house-[JMP:&w0_shared_01B988.asciistring_01B988]|