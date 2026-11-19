?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'lib_014F02'
?INCLUDE 'w0_actor_018353'
?INCLUDE 'w0_actor_0191D2_part2'
?INCLUDE 'w0_actor_0191D2_part3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_0191D2 {
    COP [3B] ( #$0016, &code_0191E8 )
    COP [17] ( &w0_actor_0191D2_part3.code_01B191 )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0191E8 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01922C )

  code_0191F1:
    COP [91]
    COP [20] ( &code_019228 )
    COP [9A] ( #$0000, &code_019201, &code_019228, &code_019216 )
}

code_019201 {
    COP [23] ( &code_01920E )
    COP [97]
    COP [9D] ( #11 )
    COP [9E] ( &code_01920E )
}

code_01920E {
    COP [80] ( #0C )
    COP [82]
    BRL code_019228
}

code_019216 {
    COP [24] ( &code_019223 )
    COP [96]
    COP [9D] ( #11 )
    COP [9E] ( &code_019223 )
}

code_019223 {
    COP [80] ( #0C )
    COP [82]
}

code_019228 {
    COP [27] ( &code_0191F1 )
}

code_01922C {
    COP [18] ( #19, &code_019236 )
    COP [01] ( &asciistring_01931F )
    RTL 
}

code_019236 {
    COP [01] ( &asciistring_019255 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_019241 )
}

code_019241 {
    COP [12] ( #05, &w0_actor_0191D2_part2.asciistring_018480 )
    COP [01] ( &asciistring_0192D9 )
    COP [12] ( #05, &w0_actor_018353.code_018353 )
    BRK #$5E
    COP [0A] ( #19 )
    RTL 
}

asciistring_019255 |[10]I am helping my [N]mother-Would you like [N]to buy some goat s [N]food? [FIN]Do you want to know [N]how much it costs? [FIN]Well-------- [N][0E:1E]How about one billion [N]dollars plus tax?! [END]|

asciistring_0192D9 |[10]TEDDY!! [N]I m sorry, I will give[N]it to you for free- [FIN][02:2] received [N][03:24]a bag of goat s food[03:20]!![JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01931F |[10]Oh, you don t need [N]many bags of goat s [N]food, [FIN]return here after you [N]have used the one [N]I have given you- [JMP:&w0_shared_01B988.asciistring_01B988]|