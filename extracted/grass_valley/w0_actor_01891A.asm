?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01891A {
    COP [14] ( #$000F, &code_018921 ) ; {100634}
    RTL                   ; {100640}
}

code_018921 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {100641}
    COP [AC] ( @code_01894A, #$0000, #$0010, #$2000 ) ; {100646}
    COP [17] ( &code_018968 ) ; {100657}

  loc_018935:
    COP [81] ( #1B, #02 ) ; {100661}
    COP [83]              ; {100665}
    COP [15]              ; {100667}
    COP [81] ( #24, #04 ) ; {100669}
    COP [83]              ; {100673}
    COP [16]              ; {100675}
    COP [87]              ; {100677}
    BRL loc_018935        ; {100679}
}

code_01894A {
    COP [07] ( #$8103, &code_018965 ) ; {100682}
    COP [0D] ( #00, #34, #2C, &code_018958 ) ; {100688}
    RTL                   ; {100695}
}

code_018958 {
    COP [01] ( &asciistring_018A2B ) ; {100696}
    BRK #$5E              ; {100700}
    COP [0A] ( #38 )      ; {100702}
    COP [09] ( #$8103 )   ; {100705}
}

code_018965 {
    COP [86]              ; {100709}
    RTL                   ; {100711}
}

code_018968 {
    COP [14] ( #$0009, &code_018973 ) ; {100712}
    COP [01] ( &asciistring_018978 ) ; {100718}
    RTL                   ; {100722}
}

code_018973 {
    COP [01] ( &asciistring_0189E0 ) ; {100723}
    RTL                   ; {100727}
}

asciistring_018978 |[10]I wonder why people [N]live in such small [N]houses? [FIN]Can you believe the [N]village Chief was [N]swallowed up in [FIN]one of the paintings [N]in the house on the [N]hill? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0189E0 |[10]I wonder why people [N]are living in such [N]small houses? [FIN]Can you believe that [N]the village Chief has [N]come back to life? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018A2B |[10]There is [03:24]a Medical [N]Herb [03:20]at the corner of [N]the fence- [JMP:&w0_shared_01B988.asciistring_01B988]|