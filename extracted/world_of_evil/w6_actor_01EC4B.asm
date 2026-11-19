?BANK 03

?INCLUDE 'w6_actor_01EC4B_part2'

!joy_block_mask                 0326

---------------------------------------------

code_01EC4B {
    COP [91]              ; {126027}
    COP [0D] ( #00, #07, #06, &code_01EC55 ) ; {126029}
    RTL                   ; {126036}
}

code_01EC55 {
    COP [07] ( #$9F02, &code_01ECE7 ) ; {126037}
    COP [07] ( #$9F05, &code_01ECA8 ) ; {126043}
    LDA #$7FC0            ; {126049}
    TSB $joy_block_mask   ; {126052}
    COP [03] ( #03 )      ; {126055}
    COP [04]              ; {126058}
    COP [01] ( &asciistring_01ED13 ) ; {126060}
    COP [0B] ( #3A )      ; {126064}
    COP [0B] ( #3B )      ; {126067}
    COP [0B] ( #3C )      ; {126070}
    COP [0B] ( #3D )      ; {126073}
    COP [0B] ( #3E )      ; {126076}
    COP [0B] ( #3F )      ; {126079}
    LDA #$0020            ; {126082}
    STA $03B4             ; {126085}
    COP [09] ( #$9F04 )   ; {126088}
    COP [85] ( @code_01ECCD ) ; {126092}
    COP [85] ( @code_01ECDA ) ; {126097}
    COP [31] ( #00 )      ; {126102}
    COP [03] ( #F1 )      ; {126105}
    COP [04]              ; {126108}
    COP [10] ( #$0900, #00, #$00D0, #$0050 ) ; {126110}
    RTL                   ; {126119}
}

code_01ECA8 {
    COP [07] ( #$1F03, &code_01ECB1 ) ; {126120}
    COP [86]              ; {126126}
    RTL                   ; {126128}
}

code_01ECB1 {
    LDA #$7FC0            ; {126129}
    TSB $joy_block_mask   ; {126132}
    COP [03] ( #1F )      ; {126135}
    COP [04]              ; {126138}
    COP [01] ( &asciistring_01ED46 ) ; {126140}
    COP [09] ( #$9F03 )   ; {126144}
    LDA #$7FC0            ; {126148}
    TRB $joy_block_mask   ; {126151}
    COP [86]              ; {126154}
    RTL                   ; {126156}
}

code_01ECCD {
    COP [A8] ( #$8000, #0D ) ; {126157}
    COP [92] ( #48 )      ; {126162}
    COP [94]              ; {126165}
    COP [86]              ; {126167}
    RTL                   ; {126169}
}

code_01ECDA {
    COP [A8] ( #$8000, #0D ) ; {126170}
    COP [92] ( #4A )      ; {126175}
    COP [94]              ; {126178}
    COP [86]              ; {126180}
    RTL                   ; {126182}
}

code_01ECE7 {
    LDA #$BFC0            ; {126183}
    TSB $joy_block_mask   ; {126186}
    COP [03] ( #29 )      ; {126189}
    COP [04]              ; {126192}
    COP [01] ( &asciistring_01EE04 ) ; {126194}
    COP [03] ( #3D )      ; {126198}
    COP [04]              ; {126201}
    LDA #$0020            ; {126203}
    STA $03B4             ; {126206}
    COP [10] ( #$0110, #01, #$01F0, #$0050 ) ; {126209}
    LDA #$BFC0            ; {126218}
    TRB $joy_block_mask   ; {126221}
    COP [91]              ; {126224}
    RTL                   ; {126226}
}

asciistring_01ED13 |[10]The 6 stones started [N]to shine and were [N]swallowed into the [N]aurora- [JMP:&w6_actor_01EC4B_part2.asciistring_01EEC5]|

asciistring_01ED46 |[10][02:2], the gate to [N]the World of Evil [N]finally opened- [FIN]But you need the [N]Phoenix s help to [N]defeat Deathtoll- [FIN]When the Phoenix joins[N]you, [N]the palace of [N]Deathtoll will appear [N]in the World of Evil- [FIN][02:2], [N]try to find the three [N]symbols- [JMP:&w6_actor_01EC4B_part2.asciistring_01EEC5]|

asciistring_01EE04 |[10][0F][02:2], [N][0E:1E]you made it! [N][0E:5A]All the creatures have[N]been saved every last [N]one thanks to you! [N][0E:5A]Why don t you go and [N]see the world and all [N]it s creatures- [0E:78][JMP:&w6_actor_01EC4B_part2.asciistring_01EEC5+M]|