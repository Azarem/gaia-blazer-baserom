?BANK 04

?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326
!cgram_buffer                   7F0000

---------------------------------------------

code_026A4E {
    LDA #$2C81
    STA $cgram_buffer
    COP [03] ( #02 )
    COP [04]
    COP [34]
    LDA #$6FC0
    TSB $joy_block_mask
    COP [80] ( #23 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_026AA6 )
    COP [80] ( #1F )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026C9D )
    COP [09] ( #$8000 )
    COP [05] ( #$0001 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026CBE )
    COP [09] ( #$8803 )
    COP [3C] ( #04 )
    COP [10] ( #$0110, #01, #$0020, #$01F0 )
    LDA #$6FC0
    TRB $joy_block_mask
    RTL 
}

asciistring_026AA6 |[10]I have been haunted by[N]a monster called [N]"research-ˮ [FIN]I would not pay [N]attention to my wife [N]and daughter- [FIN]Still I didn t [N]understand- [FIN]I was praised as a [N]genius, scientist and [N]even the King often [N]gave me orders- [FIN]I kept inventing [N]things, Water Mill, [N]Elevator, and even [N]this Airship- [FIN]Finally I invented [N]a machine to call upon[N]evil, only to [N]realize something- [FIN]Tools are there to [N]make peoples  lives [N]easier- [FIN]But when tools start [N]to use people, [FIN]their culture will [N]decline and they will [N]become unhappy- [FIN]When I get to the [N]World of Evil, [N]Deathtoll will be [N]called- [FIN]I don t want to [N]believe this beautiful[N]world will be [N]destroyed- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026C9D |[10]Please, let me off [N]somewhere! [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026CBE |[10]Dr-Leo, [N]you may be right- [FIN]But I must take you to[N]Magridd castle and [N]make sure you do not [N]escape- [FIN]I have to worry about [N]the present, [N]not tomorrow- [FIN]I must do my job or be[N]punished- [FIN]Please try to [N]understand this- [JMP:&w5_shared_02706C.asciistring_0270DF]|