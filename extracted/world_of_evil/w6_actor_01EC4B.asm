?BANK 03

?INCLUDE 'w6_actor_01EC4B_part2'

!joy_block_mask                 0326

---------------------------------------------

code_01EC4B {
    COP [91]
    COP [0D] ( #00, #07, #06, &code_01EC55 )
    RTL 
}

code_01EC55 {
    COP [07] ( #$9F02, &code_01ECE7 )
    COP [07] ( #$9F05, &code_01ECA8 )
    LDA #$7FC0
    TSB $joy_block_mask
    COP [03] ( #03 )
    COP [04]
    COP [01] ( &asciistring_01ED13 )
    COP [0B] ( #3A )
    COP [0B] ( #3B )
    COP [0B] ( #3C )
    COP [0B] ( #3D )
    COP [0B] ( #3E )
    COP [0B] ( #3F )
    LDA #$0020
    STA $03B4
    COP [09] ( #$9F04 )
    COP [85] ( @code_01ECCD )
    COP [85] ( @code_01ECDA )
    COP [31] ( #00 )
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$0900, #00, #$00D0, #$0050 )
    RTL 
}

code_01ECA8 {
    COP [07] ( #$1F03, &code_01ECB1 )
    COP [86]
    RTL 
}

code_01ECB1 {
    LDA #$7FC0
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_01ED46 )
    COP [09] ( #$9F03 )
    LDA #$7FC0
    TRB $joy_block_mask
    COP [86]
    RTL 
}

code_01ECCD {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #48 )
    COP [94]
    COP [86]
    RTL 
}

code_01ECDA {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #4A )
    COP [94]
    COP [86]
    RTL 
}

code_01ECE7 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_01EE04 )
    COP [03] ( #3D )
    COP [04]
    LDA #$0020
    STA $03B4
    COP [10] ( #$0110, #01, #$01F0, #$0050 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

asciistring_01ED13 |[10]The 6 stones started [N]to shine and were [N]swallowed into the [N]aurora- [JMP:&w6_actor_01EC4B_part2.asciistring_01EEC5]|

asciistring_01ED46 |[10][02:2], the gate to [N]the World of Evil [N]finally opened- [FIN]But you need the [N]Phoenix s help to [N]defeat Deathtoll- [FIN]When the Phoenix joins[N]you, [N]the palace of [N]Deathtoll will appear [N]in the World of Evil- [FIN][02:2], [N]try to find the three [N]symbols- [JMP:&w6_actor_01EC4B_part2.asciistring_01EEC5]|

asciistring_01EE04 |[10][0F][02:2], [N][0E:1E]you made it! [N][0E:5A]All the creatures have[N]been saved every last [N]one thanks to you! [N][0E:5A]Why don t you go and [N]see the world and all [N]it s creatures- [0E:78][JMP:&w6_actor_01EC4B_part2.asciistring_01EEC5+M]|