?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020452 {
    COP [14] ( #$00E6, &code_020459 ) ; {132178}
    RTL                   ; {132184}
}

code_020459 {
    COP [17] ( &code_0204D2 ) ; {132185}
    COP [14] ( #$0103, &code_020481 ) ; {132189}
    COP [85] ( @engine_0026F3.code_00299D ) ; {132195}
    COP [15]              ; {132200}
    COP [91]              ; {132202}
    COP [14] ( #$0103, &code_020473 ) ; {132204}
    RTL                   ; {132210}
}

code_020473 {
    COP [80] ( #17 )      ; {132211}
    COP [82]              ; {132214}
    COP [81] ( #15, #08 ) ; {132216}
    COP [83]              ; {132220}
    COP [91]              ; {132222}
    RTL                   ; {132224}
}

code_020481 {
    COP [11] ( #0B, #0F, #37 ) ; {132225}
    COP [85] ( @engine_0026F3.code_00299D ) ; {132230}
    LDA $0016, X          ; {132235}
    AND #$FFEF            ; {132238}
    STA $0016, X          ; {132241}
    COP [15]              ; {132244}
    COP [05] ( #$0004 )   ; {132246}
    COP [81] ( #28, #02 ) ; {132250}
    COP [83]              ; {132254}
    COP [81] ( #27, #02 ) ; {132256}
    COP [83]              ; {132260}
    COP [81] ( #28, #02 ) ; {132262}
    COP [83]              ; {132266}
    COP [81] ( #27, #02 ) ; {132268}
    COP [83]              ; {132272}
    COP [81] ( #28, #02 ) ; {132274}
    COP [83]              ; {132278}
    COP [81] ( #29, #04 ) ; {132280}
    COP [83]              ; {132284}
    COP [81] ( #2A, #08 ) ; {132286}
    COP [83]              ; {132290}
    COP [81] ( #2B, #10 ) ; {132292}
    COP [83]              ; {132296}
    COP [80] ( #14 )      ; {132298}
    COP [82]              ; {132301}
    COP [91]              ; {132303}
    RTL                   ; {132305}
}

code_0204D2 {
    COP [14] ( #$0103, &code_0204DD ) ; {132306}
    COP [01] ( &asciistring_0204EC ) ; {132312}
    RTL                   ; {132316}
}

code_0204DD {
    COP [18] ( #18, &code_0204E7 ) ; {132317}
    COP [01] ( &asciistring_020545 ) ; {132322}
    RTL                   ; {132326}
}

code_0204E7 {
    COP [01] ( &asciistring_0204FD ) ; {132327}
    RTL                   ; {132331}
}

asciistring_0204EC |[10]Please save the King! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0204FD |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020545 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&w3_shared_02249A.asciistring_02251E]|