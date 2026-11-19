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
    COP [3B] ( #$0016, &code_0191E8 ) ; {102866}
    COP [17] ( &w0_actor_0191D2_part3.code_01B191 ) ; {102872}
    SEP #$20              ; {102876}
    LDA #$^engine_003005.code_00305F ; {102878}
    PHA                   ; {102880}
    REP #$20              ; {102881}
    LDA #$&engine_003005.code_00305F-1 ; {102883}
    PHA                   ; {102886}
    RTL                   ; {102887}
}

code_0191E8 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {102888}
    COP [17] ( &code_01922C ) ; {102893}

  code_0191F1:
    COP [91]              ; {102897}
    COP [20] ( &code_019228 ) ; {102899}
    COP [9A] ( #$0000, &code_019201, &code_019228, &code_019216 ) ; {102903}
}

code_019201 {
    COP [23] ( &code_01920E ) ; {102913}
    COP [97]              ; {102917}
    COP [9D] ( #11 )      ; {102919}
    COP [9E] ( &code_01920E ) ; {102922}
}

code_01920E {
    COP [80] ( #0C )      ; {102926}
    COP [82]              ; {102929}
    BRL code_019228       ; {102931}
}

code_019216 {
    COP [24] ( &code_019223 ) ; {102934}
    COP [96]              ; {102938}
    COP [9D] ( #11 )      ; {102940}
    COP [9E] ( &code_019223 ) ; {102943}
}

code_019223 {
    COP [80] ( #0C )      ; {102947}
    COP [82]              ; {102950}
}

code_019228 {
    COP [27] ( &code_0191F1 ) ; {102952}
}

code_01922C {
    COP [18] ( #19, &code_019236 ) ; {102956}
    COP [01] ( &asciistring_01931F ) ; {102961}
    RTL                   ; {102965}
}

code_019236 {
    COP [01] ( &asciistring_019255 ) ; {102966}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_019241 ) ; {102970}
}

code_019241 {
    COP [12] ( #05, &w0_actor_0191D2_part2.asciistring_018480 ) ; {102977}
    COP [01] ( &asciistring_0192D9 ) ; {102982}
    COP [12] ( #05, &w0_actor_018353.code_018353 ) ; {102986}
    BRK #$5E              ; {102991}
    COP [0A] ( #19 )      ; {102993}
    RTL                   ; {102996}
}

asciistring_019255 |[10]I am helping my [N]mother-Would you like [N]to buy some goat s [N]food? [FIN]Do you want to know [N]how much it costs? [FIN]Well-------- [N][0E:1E]How about one billion [N]dollars plus tax?! [END]|

asciistring_0192D9 |[10]TEDDY!! [N]I m sorry, I will give[N]it to you for free- [FIN][02:2] received [N][03:24]a bag of goat s food[03:20]!![JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01931F |[10]Oh, you don t need [N]many bags of goat s [N]food, [FIN]return here after you [N]have used the one [N]I have given you- [JMP:&w0_shared_01B988.asciistring_01B988]|