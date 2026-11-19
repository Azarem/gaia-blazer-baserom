?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0212FE {
    COP [14] ( #$00D4, &code_021305 ) ; {135934}
    RTL                   ; {135940}
}

code_021305 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {135941}
    COP [15]              ; {135946}
    COP [14] ( #$00EF, &code_021314 ) ; {135948}
    BRA loc_02133C        ; {135954}
}

code_021314 {
    COP [14] ( #$00F0, &code_02131C ) ; {135956}
    BRA loc_02133C        ; {135962}
}

code_02131C {
    COP [14] ( #$00E9, &code_021324 ) ; {135964}
    BRA loc_021343        ; {135970}
}

code_021324 {
    COP [14] ( #$00F2, &code_02132C ) ; {135972}
    BRA loc_021343        ; {135978}
}

code_02132C {
    COP [17] ( &code_0213BA ) ; {135980}
    COP [05] ( #$0001 )   ; {135984}
    COP [16]              ; {135988}
    COP [17] ( &code_021399 ) ; {135990}
    BRA loc_02134A        ; {135994}

  loc_02133C:
    COP [17] ( &code_0213B0 ) ; {135996}
    COP [91]              ; {136000}
    RTL                   ; {136002}

  loc_021343:
    COP [17] ( &code_0213B5 ) ; {136003}
    COP [91]              ; {136007}
    RTL                   ; {136009}

  loc_02134A:
    COP [81] ( #1D, #06 ) ; {136010}
    COP [83]              ; {136014}
    COP [81] ( #1B, #04 ) ; {136016}
    COP [83]              ; {136020}
    COP [81] ( #1D, #0B ) ; {136022}
    COP [83]              ; {136026}
    COP [81] ( #1B, #0D ) ; {136028}
    COP [83]              ; {136032}
    COP [96]              ; {136034}
    COP [81] ( #1D, #02 ) ; {136036}
    COP [83]              ; {136040}
    COP [81] ( #1B, #06 ) ; {136042}
    COP [83]              ; {136046}
    COP [81] ( #1D, #02 ) ; {136048}
    COP [83]              ; {136052}
    COP [81] ( #1B, #06 ) ; {136054}
    COP [83]              ; {136058}
    COP [81] ( #1D, #0E ) ; {136060}
    COP [83]              ; {136064}
    COP [81] ( #1C, #1D ) ; {136066}
    COP [83]              ; {136070}
    COP [97]              ; {136072}
    COP [80] ( #1D )      ; {136074}
    COP [82]              ; {136077}
    COP [80] ( #1A )      ; {136079}
    COP [82]              ; {136082}
    BRA loc_02134A        ; {136084}

  loc_021396:
    COP [91]              ; {136086}
    RTL                   ; {136088}
}

code_021399 {
    LDA $0016, X          ; {136089}
    AND #$FFEF            ; {136092}
    STA $0016, X          ; {136095}
    COP [01] ( &asciistring_0213BF ) ; {136098}
    LDA $0016, X          ; {136102}
    ORA #$0010            ; {136105}
    STA $0016, X          ; {136108}
    RTL                   ; {136111}
}

code_0213B0 {
    COP [01] ( &asciistring_0213E9 ) ; {136112}
    RTL                   ; {136116}
}

code_0213B5 {
    COP [01] ( &asciistring_021409 ) ; {136117}
    RTL                   ; {136121}
}

code_0213BA {
    COP [01] ( &asciistring_02143E ) ; {136122}
    RTL                   ; {136126}
}

asciistring_0213BF |[10]I have no time to [N]talk- I think I am [N]going to lose the [N]race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0213E9 |[10]We are snail jockeys- [N]This snail is called [N]Legend- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021409 |[10]All the jockeys are [N]here, but the race [N]track is not completed[N]yet- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02143E |[10]I am going to win this[N]race! [JMP:&w3_shared_02249A.asciistring_02251E]|