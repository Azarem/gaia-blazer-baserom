?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F83AD {
    COP [14] ( #$0086, &code_0F83B4 )
    RTL 
}

code_0F83B4 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F841B )

  loc_0F83BD:
    COP [81] ( #13, #04 )
    COP [83]
    COP [07] ( #$8007, &code_0F83D6 )

  loc_0F83C9:
    COP [87]
    COP [81] ( #14, #04 )
    COP [83]
    COP [87]
    BRL loc_0F83BD
}

code_0F83D6 {
    COP [17] ( #$0000 )
    COP [03] ( #3D )
    COP [04]
    BRK #$56
    COP [A2] ( #30 )
    COP [A3]
    COP [84] ( @code_0F8404 )
    COP [80] ( #15 )
    COP [82]
    COP [84] ( @code_0F8404 )
    COP [A6]
    COP [A2] ( #20 )
    COP [09] ( #$0007 )
    COP [17] ( &code_0F841B )
    BRA loc_0F83C9
}

code_0F8404 {
    LDA #$0310
    STA $0016, X
    LDA #$002A
    STA $001E, X
    STZ $0020, X
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}

code_0F841B {
    COP [01] ( &asciistring_0F8424 )
    COP [09] ( #$8007 )
    RTL 
}

asciistring_0F8424 |[10]I am the best jumper! [N]I ll show you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|