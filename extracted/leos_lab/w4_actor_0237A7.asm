?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0237A7 {
    COP [14] ( #$0152, &code_0237AE ) ; {145319}
    RTL                   ; {145325}
}

code_0237AE {
    COP [85] ( @engine_0026F3.code_00299D ) ; {145326}
    COP [17] ( &code_0237DB ) ; {145331}
    COP [81] ( #1E, #08 ) ; {145335}
    COP [83]              ; {145339}

  loc_0237BD:
    COP [81] ( #0D, #02 ) ; {145341}
    COP [83]              ; {145345}
    COP [96]              ; {145347}
    COP [81] ( #0F, #03 ) ; {145349}
    COP [83]              ; {145353}
    COP [81] ( #0E, #02 ) ; {145355}
    COP [83]              ; {145359}
    COP [97]              ; {145361}
    COP [81] ( #0F, #03 ) ; {145363}
    COP [83]              ; {145367}
    BRA loc_0237BD        ; {145369}
}

code_0237DB {
    COP [01] ( &asciistring_0237E0 ) ; {145371}
    RTL                   ; {145375}
}

asciistring_0237E0 |[10]We are weak and timid [N]animals- [FIN]Don t you think it s [N]unfair the weaker [N]creatures are defeated[N]first? [JMP:&w4_shared_023F33.asciistring_023FA3]|