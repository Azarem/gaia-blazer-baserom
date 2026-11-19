?BANK 04

?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326
!cgram_buffer                   7F0000

---------------------------------------------

code_026A4E {
    LDA #$2C81            ; {158286}
    STA $cgram_buffer     ; {158289}
    COP [03] ( #02 )      ; {158293}
    COP [04]              ; {158296}
    COP [34]              ; {158298}
    LDA #$6FC0            ; {158300}
    TSB $joy_block_mask   ; {158303}
    COP [80] ( #23 )      ; {158306}
    COP [82]              ; {158309}
    COP [03] ( #3D )      ; {158311}
    COP [04]              ; {158314}
    COP [01] ( &asciistring_026AA6 ) ; {158316}
    COP [80] ( #1F )      ; {158320}
    COP [82]              ; {158323}
    COP [03] ( #1F )      ; {158325}
    COP [04]              ; {158328}
    COP [01] ( &asciistring_026C9D ) ; {158330}
    COP [09] ( #$8000 )   ; {158334}
    COP [05] ( #$0001 )   ; {158338}
    COP [03] ( #1F )      ; {158342}
    COP [04]              ; {158345}
    COP [01] ( &asciistring_026CBE ) ; {158347}
    COP [09] ( #$8803 )   ; {158351}
    COP [3C] ( #04 )      ; {158355}
    COP [10] ( #$0110, #01, #$0020, #$01F0 ) ; {158358}
    LDA #$6FC0            ; {158367}
    TRB $joy_block_mask   ; {158370}
    RTL                   ; {158373}
}

asciistring_026AA6 |[10]I have been haunted by[N]a monster called [N]"research-ˮ [FIN]I would not pay [N]attention to my wife [N]and daughter- [FIN]Still I didn t [N]understand- [FIN]I was praised as a [N]genius, scientist and [N]even the King often [N]gave me orders- [FIN]I kept inventing [N]things, Water Mill, [N]Elevator, and even [N]this Airship- [FIN]Finally I invented [N]a machine to call upon[N]evil, only to [N]realize something- [FIN]Tools are there to [N]make peoples  lives [N]easier- [FIN]But when tools start [N]to use people, [FIN]their culture will [N]decline and they will [N]become unhappy- [FIN]When I get to the [N]World of Evil, [N]Deathtoll will be [N]called- [FIN]I don t want to [N]believe this beautiful[N]world will be [N]destroyed- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026C9D |[10]Please, let me off [N]somewhere! [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026CBE |[10]Dr-Leo, [N]you may be right- [FIN]But I must take you to[N]Magridd castle and [N]make sure you do not [N]escape- [FIN]I have to worry about [N]the present, [N]not tomorrow- [FIN]I must do my job or be[N]punished- [FIN]Please try to [N]understand this- [JMP:&w5_shared_02706C.asciistring_0270DF]|