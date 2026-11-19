?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w4_shared_023F33'

!L_choice_result                0003D0

---------------------------------------------

code_022B80 {
    COP [14] ( #$0109, &code_022B87 ) ; {142208}
    RTL                   ; {142214}
}

code_022B87 {
    COP [15]              ; {142215}
    COP [17] ( &code_022B9E ) ; {142217}
    COP [A0] ( #$FFFC )   ; {142221}
    COP [85] ( @engine_0026F3.code_00299D ) ; {142225}
    COP [91]              ; {142230}
    COP [80] ( #03 )      ; {142232}
    COP [82]              ; {142235}
    RTL                   ; {142237}
}

code_022B9E {
    COP [01] ( &asciistring_022BC8 ) ; {142238}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_022BC3 ) ; {142242}
    LDA $L_choice_result  ; {142249}
    BNE code_022BC3       ; {142253}
    COP [18] ( #38, &code_022BB9 ) ; {142255}
    COP [01] ( &asciistring_022C21 ) ; {142260}
    RTL                   ; {142264}
}

code_022BB9 {
    COP [01] ( &asciistring_022BE2 ) ; {142265}
    BRK #$5E              ; {142269}
    COP [0A] ( #38 )      ; {142271}
    RTL                   ; {142274}
}

code_022BC3 {
    COP [01] ( &asciistring_022C55 ) ; {142275}
    RTL                   ; {142279}
}

asciistring_022BC8 |[10]Would you like [N]a Medical Herb? [END]|

asciistring_022BE2 |[10]Take any leaves that [N]you want from my body-[FIN]OUCH! [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022C21 |[10]Medical Herbs are part[N]of my body- I cannot [N]give many at one time-[JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022C55 |[10]Oh, really? Come and [N]ask me when you are in[N]trouble- [JMP:&w4_shared_023F33.asciistring_023FA3]|