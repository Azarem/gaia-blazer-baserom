?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021711 {
    COP [14] ( #$00CB, &code_021718 ) ; {136977}
    RTL                   ; {136983}
}

code_021718 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {136984}
    COP [17] ( &code_02172D ) ; {136989}
    COP [15]              ; {136993}

  loc_021723:
    COP [AD] ( #08 )      ; {136995}
    COP [80] ( #25 )      ; {136998}
    COP [82]              ; {137001}
    BRA loc_021723        ; {137003}
}

code_02172D {
    COP [01] ( &asciistring_021732 ) ; {137005}
    RTL                   ; {137009}
}

asciistring_021732 |[10]These creatures grow [N]very fast- They become[N]adults within half a [N]year, [FIN]get married, have [N]children and pass away[N]in a year- [FIN]They never feel their [N]lives are too short- [N]They enjoy each [N]moment! [JMP:&w3_shared_02249A.asciistring_02251E]|