?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0219CE {
    COP [14] ( #$00EE, &code_0219D5 ) ; {137678}
    RTL                   ; {137684}
}

code_0219D5 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {137685}
    COP [17] ( &code_0219EA ) ; {137690}
    COP [15]              ; {137694}

  loc_0219E0:
    COP [AD] ( #08 )      ; {137696}
    COP [80] ( #25 )      ; {137699}
    COP [82]              ; {137702}
    BRA loc_0219E0        ; {137704}
}

code_0219EA {
    COP [01] ( &asciistring_0219EF ) ; {137706}
    RTL                   ; {137710}
}

asciistring_0219EF |[10]There is a prison over[N]there- [FIN]Well--- there are no [N]actual bad people- [N]I guess it is just a [N]punishment room- [JMP:&w3_shared_02249A.asciistring_02251E]|