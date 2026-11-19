?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0219CE {
    COP [14] ( #$00EE, &code_0219D5 )
    RTL 
}

code_0219D5 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0219EA )
    COP [15]

  loc_0219E0:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_0219E0
}

code_0219EA {
    COP [01] ( &asciistring_0219EF )
    RTL 
}

asciistring_0219EF |[10]There is a prison over[N]there- [FIN]Well--- there are no [N]actual bad people- [N]I guess it is just a [N]punishment room- [JMP:&w3_shared_02249A.asciistring_02251E]|