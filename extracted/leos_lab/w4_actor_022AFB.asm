?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022AFB {
    COP [14] ( #$0139, &code_022B02 ) ; {142075}
    RTL                   ; {142081}
}

code_022B02 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {142082}
    COP [17] ( &code_022B15 ) ; {142087}
    COP [15]              ; {142091}
    COP [91]              ; {142093}
    COP [80] ( #03 )      ; {142095}
    COP [82]              ; {142098}
    RTL                   ; {142100}
}

code_022B15 {
    COP [01] ( &asciistring_022B1A ) ; {142101}
    RTL                   ; {142105}
}

asciistring_022B1A |[10]If the soul of the [N]Great Door joins you, [FIN]you will be able to [N]see the invisible [N]enemies in the models [N]of town- [FIN]Listen to what the cat[N]says- [JMP:&w4_shared_023F33.asciistring_023FA3]|