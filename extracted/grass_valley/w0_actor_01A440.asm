?BANK 03

?INCLUDE 'lib_014F15'
?INCLUDE 'w0_actor_01A440_part2'

!joy_block_mask                 0326

---------------------------------------------

code_01A440 {
    COP [14] ( #$0010, &code_01A447 ) ; {107584}
    RTL                   ; {107590}
}

code_01A447 {
    COP [07] ( #$9F02, &code_01A491 ) ; {107591}
    COP [17] ( &code_01A4DF ) ; {107597}
    COP [15]              ; {107601}
    COP [91]              ; {107603}
    COP [14] ( #$0032, &code_01A45C ) ; {107605}
    RTL                   ; {107611}
}

code_01A45C {
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A521 ) ; {107612}
    LDA #$2F80            ; {107616}
    TSB $joy_block_mask   ; {107619}
    COP [81] ( #21, #02 ) ; {107622}
    COP [83]              ; {107626}
    COP [80] ( #22 )      ; {107628}
    COP [82]              ; {107631}
    LDA #$2F80            ; {107633}
    TRB $joy_block_mask   ; {107636}
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A59F ) ; {107639}
    COP [17] ( &code_01A4E4 ) ; {107643}
    COP [91]              ; {107647}
    COP [0D] ( #00, #12, #35, &code_01A489 ) ; {107649}
    RTL                   ; {107656}
}

code_01A489 {
    COP [80] ( #1F )      ; {107657}
    COP [82]              ; {107660}
    COP [91]              ; {107662}
    RTL                   ; {107664}
}

code_01A491 {
    LDA #$BFC0            ; {107665}
    TSB $joy_block_mask   ; {107668}
    COP [9F] ( #$0018 )   ; {107671}
    COP [03] ( #29 )      ; {107675}
    COP [04]              ; {107678}
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A604 ) ; {107680}
    LDA #$BFC0            ; {107684}
    TRB $joy_block_mask   ; {107687}
    COP [1A] ( &lib_014F15.asciistring_014F15, #01, &code_01A4B1 ) ; {107690}
}

code_01A4B1 {
    LDA #$BFC0            ; {107697}
    TSB $joy_block_mask   ; {107700}
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A77E ) ; {107703}
    COP [03] ( #B5 )      ; {107707}
    COP [04]              ; {107710}
    COP [09] ( #$9F01 )   ; {107712}
    LDA #$0003            ; {107716}
    STA $031E             ; {107719}
    COP [3C] ( #04 )      ; {107722}
    COP [10] ( #$0101, #01, #$03B0, #$01D8 ) ; {107725}
    LDA #$BFC0            ; {107734}
    TRB $joy_block_mask   ; {107737}
    COP [91]              ; {107740}
    RTL                   ; {107742}
}

code_01A4DF {
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A50A ) ; {107743}
    RTL                   ; {107747}
}

code_01A4E4 {
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A5E9 ) ; {107748}
    COP [09] ( #$8104 )   ; {107752}
    COP [3C] ( #04 )      ; {107756}
    COP [10] ( #$0101, #03, #$03B0, #$01E0 ) ; {107759}
    RTL                   ; {107768}
}