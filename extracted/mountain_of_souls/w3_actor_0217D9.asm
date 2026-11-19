?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326

---------------------------------------------

code_0217D9 {
    COP [14] ( #$00FE, &code_0217E0 )
    RTL 
}

code_0217E0 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_021824 )
    COP [15]
    COP [91]
    COP [18] ( #04, &code_0217F3 )
    RTL 
}

code_0217F3 {
    COP [0D] ( #00, #37, #24, &code_0217FB )
    RTL 
}

code_0217FB {
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [97]
    COP [81] ( #11, #02 )
    COP [83]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #0C )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]
    COP [01] ( &asciistring_021858 )
    COP [91]
    RTL 
}

code_021824 {
    COP [01] ( &asciistring_021829 )
    RTL 
}

asciistring_021829 |[10]This passage leads to [N]the underground lake, [N]Lune- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021858 |[10]Hey, you re not going [N]to the lake with that [N]sword are you? [FIN]You are going to get [N]in trouble- [FIN]Talk to some of the [N]people in town, maybe [N]someone can help you- [JMP:&w3_shared_02249A.asciistring_02251E]|