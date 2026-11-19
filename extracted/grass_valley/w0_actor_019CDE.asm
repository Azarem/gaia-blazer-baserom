?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w0_shared_01B988'

!L_choice_result                0003D0

---------------------------------------------

code_019CDE {
    COP [14] ( #$0015, &code_019CE5 )
    RTL 
}

code_019CE5 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_019D3B )
    COP [15]
    COP [05] ( #$0205 )
    COP [17] ( &code_019D69 )
    COP [16]
    COP [9F] ( #$0008 )
    COP [81] ( #19, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [87]
    COP [81] ( #1B, #04 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #1A, #05 )
    COP [83]
    COP [87]
    COP [9F] ( #$FFF8 )
    COP [81] ( #1B, #0E )
    COP [83]
    COP [9F] ( #$0010 )
    COP [81] ( #1A, #04 )
    COP [83]
    COP [17] ( &code_019D6E )
    COP [09] ( #$0205 )
    COP [91]
    RTL 
}

code_019D3B {
    COP [18] ( #19, &code_019D64 )
    COP [01] ( &asciistring_019DCA )

  loc_019D44:
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_019D51 )
    LDA $L_choice_result
    BEQ loc_019D58
}

code_019D51 {
    COP [01] ( &asciistring_019EB1 )
    BRL loc_019D44

  loc_019D58:
    COP [01] ( &asciistring_019E0E )
    COP [0B] ( #19 )
    COP [09] ( #$8205 )
    RTL 
}

code_019D64 {
    COP [01] ( &asciistring_019D73 )
    RTL 
}

code_019D69 {
    COP [01] ( &asciistring_019EC5 )
    RTL 
}

code_019D6E {
    COP [01] ( &asciistring_019EE2 )
    RTL 
}

asciistring_019D73 |[10]I am known among my [N]friends as something [N]of a Gourmet Goat- [FIN]I will only eat food [N]sold at the tool shop- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019DCA |[10]Oh! You have some food[N]from the tool shop! [FIN]I promise to tell you [N]a secret if you will [N]give me the food- [END]|

asciistring_019E0E |Thank you! I will [N]tell you a secret- [FIN]If you wish to get [N]inside the painting, [N]you must equip an item[N]which [FIN]used to belong to the [N]painter and touch the [N]painting- [FIN]Well, I have other [N]things to attend to so[N]I will see you later! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019EB1 |Oh come on!, [N]Please!! [END]|

asciistring_019EC5 |[10]I love food from the [N]tool shop! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019EE2 |[10]Hey, give me my food! [JMP:&w0_shared_01B988.asciistring_01B988]|