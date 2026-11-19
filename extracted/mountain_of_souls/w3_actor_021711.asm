?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021711 {
    COP [14] ( #$00CB, &code_021718 )
    RTL 
}

code_021718 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02172D )
    COP [15]

  loc_021723:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_021723
}

code_02172D {
    COP [01] ( &asciistring_021732 )
    RTL 
}

asciistring_021732 |[10]These creatures grow [N]very fast- They become[N]adults within half a [N]year, [FIN]get married, have [N]children and pass away[N]in a year- [FIN]They never feel their [N]lives are too short- [N]They enjoy each [N]moment! [JMP:&w3_shared_02249A.asciistring_02251E]|