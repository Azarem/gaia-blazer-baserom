?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022794 {
    COP [14] ( #$0114, &code_02279B ) ; {141204}
    RTL                   ; {141210}
}

code_02279B {
    COP [85] ( @engine_0026F3.code_00299D ) ; {141211}
    COP [17] ( &code_02282A ) ; {141216}
    COP [07] ( #$8605, &code_022817 ) ; {141220}
    COP [15]              ; {141226}

  loc_0227AC:
    COP [19] ( #26, &code_0227B7 ) ; {141228}
    COP [0C] ( #00, #02, &code_0227BE ) ; {141233}
}

code_0227B7 {
    COP [80] ( #13 )      ; {141239}
    COP [82]              ; {141242}
    BRA loc_0227AC        ; {141244}
}

code_0227BE {
    COP [91]              ; {141246}
    COP [17] ( &code_02282F ) ; {141248}

  code_0227C4:
    COP [0D] ( #05, #16, #10, &code_022809 ) ; {141252}
    COP [9C] ( &code_0227D1, &code_0227ED ) ; {141259}
}

code_0227D1 {
    COP [9A] ( #$0010, &code_0227DB, &code_0227ED, &code_0227E4 ) ; {141265}
}

code_0227DB {
    COP [97]              ; {141275}
    COP [80] ( #12 )      ; {141277}
    COP [82]              ; {141280}
    BRA code_0227C4       ; {141282}
}

code_0227E4 {
    COP [96]              ; {141284}
    COP [80] ( #12 )      ; {141286}
    COP [82]              ; {141289}
    BRA code_0227C4       ; {141291}
}

code_0227ED {
    COP [9B] ( #$0010, &code_0227F7, &code_022805, &code_0227FE ) ; {141293}
}

code_0227F7 {
    COP [80] ( #11 )      ; {141303}
    COP [82]              ; {141306}
    BRA code_0227C4       ; {141308}
}

code_0227FE {
    COP [80] ( #10 )      ; {141310}
    COP [82]              ; {141313}
    BRA code_0227C4       ; {141315}
}

code_022805 {
    COP [27] ( &code_0227C4 ) ; {141317}
}

code_022809 {
    COP [97]              ; {141321}
    COP [81] ( #12, #02 ) ; {141323}
    COP [83]              ; {141327}
    COP [09] ( #$8605 )   ; {141329}
    BRA loc_02281C        ; {141333}
}

code_022817 {
    COP [11] ( #05, #14, #11 ) ; {141335}

  loc_02281C:
    COP [17] ( &code_02282F ) ; {141340}
    COP [15]              ; {141344}
    COP [91]              ; {141346}
    COP [80] ( #13 )      ; {141348}
    COP [82]              ; {141351}
    RTL                   ; {141353}
}

code_02282A {
    COP [01] ( &asciistring_022834 ) ; {141354}
    RTL                   ; {141358}
}

code_02282F {
    COP [01] ( &asciistring_02286C ) ; {141359}
    RTL                   ; {141363}
}

asciistring_022834 |[10]We don t really [N]like to chase rats- [FIN]Cats just have to eat [N]in order to live- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02286C |[10]What a pleasant smell- [JMP:&w4_shared_023F33.asciistring_023FA3]|