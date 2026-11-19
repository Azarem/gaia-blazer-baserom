?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w4_shared_023F33'

!L_choice_result                0003D0

---------------------------------------------

code_022B80 {
    COP [14] ( #$0109, &code_022B87 )
    RTL 
}

code_022B87 {
    COP [15]
    COP [17] ( &code_022B9E )
    COP [A0] ( #$FFFC )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [91]
    COP [80] ( #03 )
    COP [82]
    RTL 
}

code_022B9E {
    COP [01] ( &asciistring_022BC8 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_022BC3 )
    LDA $L_choice_result
    BNE code_022BC3
    COP [18] ( #38, &code_022BB9 )
    COP [01] ( &asciistring_022C21 )
    RTL 
}

code_022BB9 {
    COP [01] ( &asciistring_022BE2 )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

code_022BC3 {
    COP [01] ( &asciistring_022C55 )
    RTL 
}

asciistring_022BC8 |[10]Would you like [N]a Medical Herb? [END]|

asciistring_022BE2 |[10]Take any leaves that [N]you want from my body-[FIN]OUCH! [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022C21 |[10]Medical Herbs are part[N]of my body- I cannot [N]give many at one time-[JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022C55 |[10]Oh, really? Come and [N]ask me when you are in[N]trouble- [JMP:&w4_shared_023F33.asciistring_023FA3]|