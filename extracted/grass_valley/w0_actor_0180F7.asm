?BANK 03

?INCLUDE 'lib_014F02'
?INCLUDE 'w0_shared_01B988'

!L_choice_result                0003D0

---------------------------------------------

code_0180F7 {
    COP [14] ( #$0002, &code_0180FE )
    RTL 
}

code_0180FE {
    COP [30] ( #$0002, &code_018159, #03 )
    COP [14] ( #$0009, &code_018114 )
    COP [17] ( &code_01812B )
    COP [15]
    COP [91]
    RTL 
}

code_018114 {
    COP [07] ( #$9F02, &code_018128 )
    COP [17] ( &code_018160 )
    COP [11] ( #04, #3B, #1E )
    COP [15]
    COP [91]
    RTL 
}

code_018128 {
    COP [86]
    RTL 
}

code_01812B {
    COP [07] ( #$8101, &code_018152 )
    COP [01] ( &asciistring_01816F )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01814D )
    LDA $L_choice_result
    BNE code_01814D
    COP [09] ( #$8101 )
    COP [01] ( &asciistring_018211 )
    BRL loc_018156
}

code_01814D {
    COP [01] ( &asciistring_0181F8 )
    RTL 
}

code_018152 {
    COP [01] ( &asciistring_018255 )

  loc_018156:
    COP [37]
    RTL 
}

code_018159 {
    COP [01] ( &asciistring_01832D )
    COP [86]
    RTL 
}

code_018160 {
    COP [18] ( #29, &code_01816A )
    COP [01] ( &asciistring_0182E7 )
    RTL 
}

code_01816A {
    COP [01] ( &asciistring_0182AC )
    RTL 
}

asciistring_01816F |[10]My husband used to be [N]the village Chief- [FIN]One day he suddenly [N]disappeared along with[N]the other villagers- [FIN]I feel so lonely---- [N]How about being one of[N]my children? [END]|

asciistring_0181F8 |Well, [N]that s too bad- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018211 |Really?! [N]I will call you [N][02:2] from now on- [FIN]Use the second floor [N]as your own room- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018255 |[10][02:2], [N]you are just walking [N]around doing nothing- [FIN]I am beginning to [N]worry about you- [N]Please, stay here and [N]rest- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0182AC |[10]I feel bad for Lisa, [N]having been separated [N]from her parents- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0182E7 |[10][02:2]! [FIN]Soldiers from Magridd [N]were just here! [N]They kidnapped Lisa! [N]You must rescue her! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01832D |[10]You hear a sigh coming[N]from inside the house-[JMP:&w0_shared_01B988.asciistring_01B988]|