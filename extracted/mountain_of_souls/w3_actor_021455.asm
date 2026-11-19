?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021455 {
    COP [14] ( #$00EF, &code_02145C ) ; {136277}
    RTL                   ; {136283}
}

code_02145C {
    COP [85] ( @engine_0026F3.code_00299D ) ; {136284}
    COP [15]              ; {136289}
    COP [14] ( #$00D4, &code_02146B ) ; {136291}
    BRA loc_021493        ; {136297}
}

code_02146B {
    COP [14] ( #$00F0, &code_021473 ) ; {136299}
    BRA loc_021493        ; {136305}
}

code_021473 {
    COP [14] ( #$00E9, &code_02147B ) ; {136307}
    BRA loc_02149A        ; {136313}
}

code_02147B {
    COP [14] ( #$00F2, &code_021483 ) ; {136315}
    BRA loc_02149A        ; {136321}
}

code_021483 {
    COP [17] ( &code_021511 ) ; {136323}
    COP [05] ( #$0001 )   ; {136327}
    COP [16]              ; {136331}
    COP [17] ( &code_0214F0 ) ; {136333}
    BRA loc_0214A1        ; {136337}

  loc_021493:
    COP [17] ( &code_021507 ) ; {136339}
    COP [91]              ; {136343}
    RTL                   ; {136345}

  loc_02149A:
    COP [17] ( &code_02150C ) ; {136346}
    COP [91]              ; {136350}
    RTL                   ; {136352}

  loc_0214A1:
    COP [81] ( #1D, #06 ) ; {136353}
    COP [83]              ; {136357}
    COP [81] ( #1B, #02 ) ; {136359}
    COP [83]              ; {136363}
    COP [81] ( #1D, #0B ) ; {136365}
    COP [83]              ; {136369}
    COP [81] ( #1B, #0D ) ; {136371}
    COP [83]              ; {136375}
    COP [96]              ; {136377}
    COP [81] ( #1D, #02 ) ; {136379}
    COP [83]              ; {136383}
    COP [81] ( #1B, #06 ) ; {136385}
    COP [83]              ; {136389}
    COP [81] ( #1D, #02 ) ; {136391}
    COP [83]              ; {136395}
    COP [81] ( #1B, #06 ) ; {136397}
    COP [83]              ; {136401}
    COP [81] ( #1D, #0E ) ; {136403}
    COP [83]              ; {136407}
    COP [81] ( #1C, #1B ) ; {136409}
    COP [83]              ; {136413}
    COP [97]              ; {136415}
    COP [80] ( #1D )      ; {136417}
    COP [82]              ; {136420}
    COP [80] ( #1A )      ; {136422}
    COP [82]              ; {136425}
    BRA loc_0214A1        ; {136427}

  loc_0214ED:
    COP [91]              ; {136429}
    RTL                   ; {136431}
}

code_0214F0 {
    LDA $0016, X          ; {136432}
    AND #$FFEF            ; {136435}
    STA $0016, X          ; {136438}
    COP [01] ( &asciistring_021516 ) ; {136441}
    LDA $0016, X          ; {136445}
    ORA #$0010            ; {136448}
    STA $0016, X          ; {136451}
    RTL                   ; {136454}
}

code_021507 {
    COP [01] ( &asciistring_02153D ) ; {136455}
    RTL                   ; {136459}
}

code_02150C {
    COP [01] ( &asciistring_021569 ) ; {136460}
    RTL                   ; {136464}
}

code_021511 {
    COP [01] ( &asciistring_02159A ) ; {136465}
    RTL                   ; {136469}
}

asciistring_021516 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02153D |[10]We are snail jockeys- [N]This snail is called [N]Flash- [N]I am the fastest! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021569 |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02159A |[10]I am going to win this[N]race! [JMP:&w3_shared_02249A.asciistring_02251E]|