?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326

---------------------------------------------

code_0217D9 {
    COP [14] ( #$00FE, &code_0217E0 ) ; {137177}
    RTL                   ; {137183}
}

code_0217E0 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {137184}
    COP [17] ( &code_021824 ) ; {137189}
    COP [15]              ; {137193}
    COP [91]              ; {137195}
    COP [18] ( #04, &code_0217F3 ) ; {137197}
    RTL                   ; {137202}
}

code_0217F3 {
    COP [0D] ( #00, #37, #24, &code_0217FB ) ; {137203}
    RTL                   ; {137210}
}

code_0217FB {
    COP [16]              ; {137211}
    LDA #$2F80            ; {137213}
    TSB $joy_block_mask   ; {137216}
    COP [97]              ; {137219}
    COP [81] ( #11, #02 ) ; {137221}
    COP [83]              ; {137225}
    COP [80] ( #0F )      ; {137227}
    COP [82]              ; {137230}
    COP [80] ( #0C )      ; {137232}
    COP [82]              ; {137235}
    LDA #$2F80            ; {137237}
    TRB $joy_block_mask   ; {137240}
    COP [15]              ; {137243}
    COP [01] ( &asciistring_021858 ) ; {137245}
    COP [91]              ; {137249}
    RTL                   ; {137251}
}

code_021824 {
    COP [01] ( &asciistring_021829 ) ; {137252}
    RTL                   ; {137256}
}

asciistring_021829 |[10]This passage leads to [N]the underground lake, [N]Lune- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021858 |[10]Hey, you re not going [N]to the lake with that [N]sword are you? [FIN]You are going to get [N]in trouble- [FIN]Talk to some of the [N]people in town, maybe [N]someone can help you- [JMP:&w3_shared_02249A.asciistring_02251E]|