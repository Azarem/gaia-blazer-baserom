?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02382D {
    COP [14] ( #$013B, &code_023834 )
    RTL 
}

code_023834 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_023861 )
    COP [81] ( #1E, #08 )
    COP [83]

  loc_023843:
    COP [81] ( #0E, #02 )
    COP [83]
    COP [97]
    COP [81] ( #0F, #03 )
    COP [83]
    COP [81] ( #0D, #02 )
    COP [83]
    COP [96]
    COP [81] ( #0F, #03 )
    COP [83]
    BRA loc_023843
}

code_023861 {
    COP [01] ( &asciistring_023866 )
    RTL 
}

asciistring_023866 |[10]I would have liked to [N]have been born a [N]plant- [FIN]I would not fear [N]anything- [JMP:&w4_shared_023F33.asciistring_023FA3]|