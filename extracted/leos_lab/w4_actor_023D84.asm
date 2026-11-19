?BANK 04

?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023D84 {
    COP [05] ( #$0000 )
    BRK #$43
    COP [81] ( #16, #04 )
    COP [83]
    COP [97]
    COP [81] ( #17, #03 )
    COP [83]
    COP [01] ( &asciistring_023DBC )
    COP [03] ( #1F )
    COP [04]
    COP [09] ( #$8001 )
    COP [05] ( #$0002 )
    COP [96]
    COP [81] ( #17, #03 )
    COP [83]
    COP [81] ( #15, #05 )
    COP [83]
    BRK #$43
    COP [86]
    RTL 
}

asciistring_023DBC |[10]Hey, it s time to go- [JMP:&w4_shared_023F33.asciistring_023FA3]|