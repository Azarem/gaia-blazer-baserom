?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w0_shared_01B988'

!L_choice_result                0003D0

---------------------------------------------

code_019CDE {
    COP [14] ( #$0015, &code_019CE5 ) ; {105694}
    RTL                   ; {105700}
}

code_019CE5 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {105701}
    COP [17] ( &code_019D3B ) ; {105706}
    COP [15]              ; {105710}
    COP [05] ( #$0205 )   ; {105712}
    COP [17] ( &code_019D69 ) ; {105716}
    COP [16]              ; {105720}
    COP [9F] ( #$0008 )   ; {105722}
    COP [81] ( #19, #02 ) ; {105726}
    COP [83]              ; {105730}
    COP [9F] ( #$FFF8 )   ; {105732}
    COP [87]              ; {105736}
    COP [81] ( #1B, #04 ) ; {105738}
    COP [83]              ; {105742}
    COP [9F] ( #$0008 )   ; {105744}
    COP [81] ( #1A, #05 ) ; {105748}
    COP [83]              ; {105752}
    COP [87]              ; {105754}
    COP [9F] ( #$FFF8 )   ; {105756}
    COP [81] ( #1B, #0E ) ; {105760}
    COP [83]              ; {105764}
    COP [9F] ( #$0010 )   ; {105766}
    COP [81] ( #1A, #04 ) ; {105770}
    COP [83]              ; {105774}
    COP [17] ( &code_019D6E ) ; {105776}
    COP [09] ( #$0205 )   ; {105780}
    COP [91]              ; {105784}
    RTL                   ; {105786}
}

code_019D3B {
    COP [18] ( #19, &code_019D64 ) ; {105787}
    COP [01] ( &asciistring_019DCA ) ; {105792}

  loc_019D44:
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_019D51 ) ; {105796}
    LDA $L_choice_result  ; {105803}
    BEQ loc_019D58        ; {105807}
}

code_019D51 {
    COP [01] ( &asciistring_019EB1 ) ; {105809}
    BRL loc_019D44        ; {105813}

  loc_019D58:
    COP [01] ( &asciistring_019E0E ) ; {105816}
    COP [0B] ( #19 )      ; {105820}
    COP [09] ( #$8205 )   ; {105823}
    RTL                   ; {105827}
}

code_019D64 {
    COP [01] ( &asciistring_019D73 ) ; {105828}
    RTL                   ; {105832}
}

code_019D69 {
    COP [01] ( &asciistring_019EC5 ) ; {105833}
    RTL                   ; {105837}
}

code_019D6E {
    COP [01] ( &asciistring_019EE2 ) ; {105838}
    RTL                   ; {105842}
}

asciistring_019D73 |[10]I am known among my [N]friends as something [N]of a Gourmet Goat- [FIN]I will only eat food [N]sold at the tool shop- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019DCA |[10]Oh! You have some food[N]from the tool shop! [FIN]I promise to tell you [N]a secret if you will [N]give me the food- [END]|

asciistring_019E0E |Thank you! I will [N]tell you a secret- [FIN]If you wish to get [N]inside the painting, [N]you must equip an item[N]which [FIN]used to belong to the [N]painter and touch the [N]painting- [FIN]Well, I have other [N]things to attend to so[N]I will see you later! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019EB1 |Oh come on!, [N]Please!! [END]|

asciistring_019EC5 |[10]I love food from the [N]tool shop! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019EE2 |[10]Hey, give me my food! [JMP:&w0_shared_01B988.asciistring_01B988]|