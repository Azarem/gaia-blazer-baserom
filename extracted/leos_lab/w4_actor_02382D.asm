?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02382D {
    COP [14] ( #$013B, &code_023834 ) ; {145453}
    RTL                   ; {145459}
}

code_023834 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {145460}
    COP [17] ( &code_023861 ) ; {145465}
    COP [81] ( #1E, #08 ) ; {145469}
    COP [83]              ; {145473}

  loc_023843:
    COP [81] ( #0E, #02 ) ; {145475}
    COP [83]              ; {145479}
    COP [97]              ; {145481}
    COP [81] ( #0F, #03 ) ; {145483}
    COP [83]              ; {145487}
    COP [81] ( #0D, #02 ) ; {145489}
    COP [83]              ; {145493}
    COP [96]              ; {145495}
    COP [81] ( #0F, #03 ) ; {145497}
    COP [83]              ; {145501}
    BRA loc_023843        ; {145503}
}

code_023861 {
    COP [01] ( &asciistring_023866 ) ; {145505}
    RTL                   ; {145509}
}

asciistring_023866 |[10]I would have liked to [N]have been born a [N]plant- [FIN]I would not fear [N]anything- [JMP:&w4_shared_023F33.asciistring_023FA3]|