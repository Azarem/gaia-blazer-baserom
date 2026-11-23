?BANK 1F

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'se_seabed_sanctuary_actors_0F8000'
?INCLUDE 'shared_choice_prompt_texts'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0
!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!player_actor                   039C
!asset_skip_mask                03B4
!return_active                  03FB

---------------------------------------------

code_0F8D58 {
    COP [3B] ( #$00A7, &code_0F8D6E )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F8D6E {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F8D81 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F8D81 {
    COP [07] ( #$8503, &code_0F8D96 )
    COP [18] ( #21, &code_0F8D91 )
    COP [01] ( &asciistring_0F8D9B )
    RTL 
}

code_0F8D91 {
    COP [01] ( &asciistring_0F8DF9 )
    RTL 
}

code_0F8D96 {
    COP [01] ( &asciistring_0F8E14 )
    RTL 
}

asciistring_0F8D9B |[10]The teardrops from a [N]mermaid have the power[N]to turn Magma to [N]stone- [FIN]Use them at the top of[N]the volcanic island- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8DF9 |[10]Open the treasure [N]chest- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8E14 |[10]These teardrops were [N]left by a mermaid when[N]evil invaded this [N]place- [FIN]Icy teardrops, filled [N]with sorrow, will turn[N]even the hottest Magma[N]to stone- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8E99 {
    COP [14] ( #$00AB, &code_0F8EA0 )
    RTL 
}

code_0F8EA0 {
    COP [30] ( #$00AB, &code_0F8EE9, #1F )
    COP [17] ( &code_0F8EC5 )
    COP [91]
    COP [0D] ( #00, #1C, #22, &code_0F8EB5 )
    RTL 
}

code_0F8EB5 {
    COP [11] ( #00, #1C, #24 )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F8EC5 {
    COP [01] ( &asciistring_0F8EF0 )
    COP [07] ( #$8500, &code_0F8EE8 )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$0240, #$02B0 )
}

code_0F8EE8 {
    RTL 
}

code_0F8EE9 {
    COP [01] ( &se_seabed_sanctuary_actors_0F8000.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8EF0 |[10]I will open the [N]passage for you- [FIN]Walk downward under [N]the sea and go to the [N]volcanic island, [N]Durean- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8F45 {
    COP [14] ( #$00C1, &code_0F8F4C )
    RTL 
}

code_0F8F4C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )

  loc_0F8F51:
    COP [17] ( &code_0F9041 )
    COP [15]

  code_0F8F57:
    COP [80] ( #10 )
    COP [82]
    COP [07] ( #$0000, &code_0F8F57 )

  loc_0F8F62:
    COP [0D] ( #00, #03, #31, &code_0F8F71 )
    COP [80] ( #10 )
    COP [82]
    BRL loc_0F8F62
}

code_0F8F71 {
    COP [16]
    COP [17] ( #$0000 )
    COP [85] ( @code_0F8FAB )
    COP [81] ( #0D, #1B )
    COP [83]
    COP [17] ( &code_0F9041 )
    COP [15]

  loc_0F8F88:
    COP [0D] ( #00, #03, #19, &code_0F8F97 )
    COP [80] ( #0F )
    COP [82]
    BRL loc_0F8F88
}

code_0F8F97 {
    COP [16]
    COP [17] ( #$0000 )
    COP [85] ( @code_0F8FF6 )
    COP [81] ( #0C, #1B )
    COP [83]
    BRL loc_0F8F51
}

code_0F8FAB {
    LDA #$2F80
    TSB $joy_block_mask
    LDA #$01B0
    STA $0025, X
    LDY $player_actor
    LDA $0016, Y
    AND #$EFFF
    STA $0016, Y
    COP [91]
    LDY $003C, X
    LDA $0002, Y
    SEC 
    SBC #$0020
    LDY $player_actor
    STA $0002, Y
    LDA #$FFFF
    STA $0006, Y
    DEC $0025, X
    BEQ loc_0F8FE1
    RTL 

  loc_0F8FE1:
    LDY $player_actor
    LDA $0016, Y
    ORA #$1000
    STA $0016, Y
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

code_0F8FF6 {
    LDA #$2F80
    TSB $joy_block_mask
    LDA #$01B0
    STA $0025, X
    LDY $player_actor
    LDA $0016, Y
    AND #$EFFF
    STA $0016, Y
    COP [91]
    LDY $003C, X
    LDA $0002, Y
    CLC 
    ADC #$0010
    LDY $player_actor
    STA $0002, Y
    LDA #$0001
    STA $0006, Y
    DEC $0025, X
    BEQ loc_0F902C
    RTL 

  loc_0F902C:
    LDY $player_actor
    LDA $0016, Y
    ORA #$1000
    STA $0016, Y
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

code_0F9041 {
    COP [01] ( &asciistring_0F904A )
    COP [09] ( #$8000 )
    RTL 
}

asciistring_0F904A |[10]Stand on my nose- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F905C {
    COP [3B] ( #$00B5, &code_0F9072 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F9072 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9085 )
    COP [15]
    COP [91]
    COP [80] ( #02 )
    COP [82]
    RTL 
}

code_0F9085 {
    COP [18] ( #13, &code_0F908F )
    COP [01] ( &asciistring_0F90B5 )
    RTL 
}

code_0F908F {
    COP [01] ( &asciistring_0F9099 )
    BRK #$5E
    COP [0A] ( #13 )
    RTL 
}

asciistring_0F9099 |[10]I will give you [N][03:24]the Magic Flair- [FIN][03:20][JMP:&asciistring_0F90B5+M]|

asciistring_0F90B5 |[10][::]Magic Flair is useful [N]against monsters that [N]fly and have a large [N]amount of hit points- [FIN]You know which [N]monsters I am [N]referring to, right? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F911E {
    COP [14] ( #$00B6, &code_0F9125 )
    RTL 
}

code_0F9125 {
    COP [30] ( #$00B6, &code_0F922E, #1F )
    COP [9F] ( #$0008 )
    COP [07] ( #$9F02, &code_0F913F )
    COP [15]
    COP [17] ( &code_0F9215 )
    COP [91]
    RTL 
}

code_0F913F {
    COP [11] ( #0D, #00, #C9 )
    COP [11] ( #1A, #00, #C9 )
    LDA #$FF80
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F9416 )
    COP [AC] ( @code_0F91AA, #$0200, #$0100, #$0050 )
    COP [05] ( #$0000 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F953B )
    COP [03] ( #79 )
    COP [04]
    COP [AC] ( @code_0F91E2, #$0200, #$0100, #$0050 )
    COP [05] ( #$0001 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F95CE )
    COP [03] ( #79 )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$0104, #01, #$0120, #$02E0 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F91AA {
    COP [81] ( #0D, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [97]
    COP [81] ( #0D, #06 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8000 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F91E2 {
    COP [81] ( #0D, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [97]
    COP [81] ( #0D, #05 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8001 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F9215 {
    COP [07] ( #$9B02, &code_0F9229 )
    COP [01] ( &asciistring_0F9252 )
    BRK #$5E
    COP [0A] ( #3C )
    COP [09] ( #$9B02 )
    RTL 
}

code_0F9229 {
    COP [01] ( &asciistring_0F938C )
    RTL 
}

code_0F922E {
    LDA #$FFFF
    STA $return_active
    COP [14] ( #$00BD, &code_0F9242 )
    COP [14] ( #$0092, &code_0F9242 )
    BRA loc_0F9246
}

code_0F9242 {
    COP [01] ( &asciistring_0F9390 )

  loc_0F9246:
    COP [01] ( &asciistring_0F939F )
    COP [37]
    STZ $return_active
    COP [86]
    RTL 
}

asciistring_0F9252 |[10]I have heard about you[N]from Lue- [FIN]You are the one who [N]saved me- [FIN]Everything started [N]when I saw the jewel [N]that Lue had- [FIN]One glance at the Blue[N]Stone caused desire [N]and hatred to [N]overwhelm me- [FIN]Right after that the [N]creatures disappeared [N]and the monsters took [N]over- [FIN]Maybe because we let [N]bad feeling dominate [N]us we created the [N]monsters ourselves- [FIN]I will give you [03:24]the [N]Blue Stone- [FIN][03:20][::]Please travel to other[N]regions and release [N]all creatures- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F938C |[10][JMP:&asciistring_0F9252+M]|

asciistring_0F9390 |[10][0E:1E]Queen! [0E:3C][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F939F |[10][0E:3C]A beautiful voice came[N]from inside the [N]palace- [FIN]I am the Mermaid [N]Queen- [FIN]I know not who you [N]are, but thank you for[N]releasing me- [FIN]Please return to the [N]palace- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9416 |[10][0F][02:2], [N]thank you very much! [N][0E:3C]Peace has returned [N]here, to St-Elles- [N][0E:5A]The dolphin, Lue, used[N]to live with Dr-Leo- [N][0E:5A]It s strange, whenever[N]he tells me about Dr- [N]Leo and his daughter [N]Lisa- [N][0E:2D]I miss them and [N]sometimes find myself [N]crying- [N][0E:5A]Now Dr-Leo is gone, [N][0E:1E]Lisa must be very [N]lonely- [N][0E:5A]Oh, here comes Lue- He[N]must have heard your [N]voice- [N][0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F953B |[10][0F]Phew! [N][0E:5A][02:2], [N]why did you not visit [N]me? [N][0E:5A]I decided to return to[N]my home town along [N]with my friends- [N][0E:5A]To tell you the truth,[N][0E:28]I am to be married- [N][0E:50]Hey Lala, come in [N]here! [0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F95CE |[10][0F]Don t you think she is[N]beautiful- [N][0E:5A]We will be happy [N]together- [N][0E:5A][02:2], [N]I wish you luck- [0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|
---------------------------------------------

code_0F961C {
    COP [14] ( #$00B9, &code_0F9623 )
    RTL 
}

code_0F9623 {
    COP [30] ( #$00B9, &code_0F966C, #1F )
    COP [17] ( &code_0F9648 )
    COP [91]
    COP [0D] ( #00, #1C, #1C, &code_0F9638 )
    RTL 
}

code_0F9638 {
    COP [11] ( #00, #1C, #1E )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F9648 {
    COP [01] ( &asciistring_0F9673 )
    COP [07] ( #$8501, &code_0F966B )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$0140, #$0040 )
}

code_0F966B {
    RTL 
}

code_0F966C {
    COP [01] ( &se_seabed_sanctuary_actors_0F8000.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F9673 |[10]I will open the [N]passage for you- [FIN]Go ¦ along the [N]seabed and you will [N]find a ghost ship- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F96B9 {
    COP [14] ( #$00BD, &code_0F96C0 )
    RTL 
}

code_0F96C0 {
    COP [07] ( #$9F02, &code_0F9704 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9707 )
    COP [15]

  loc_0F96D1:
    COP [14] ( #$00B6, &code_0F96DF )
    COP [80] ( #08 )
    COP [82]
    BRL loc_0F96D1
}

code_0F96DF {
    COP [16]
    COP [9F] ( #$0010 )
    COP [81] ( #0A, #03 )
    COP [83]
    COP [9F] ( #$FFF0 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_0F970C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F9704 {
    COP [86]
    RTL 
}

code_0F9707 {
    COP [01] ( &asciistring_0F9711 )
    RTL 
}

code_0F970C {
    COP [01] ( &asciistring_0F976C )
    RTL 
}

asciistring_0F9711 |[10]I saw the Queen when [N]I was dreaming- [N]She looked very sad- [FIN]It was somewhere near [N]a sunken ship- [N]Please save the [N]Queen!! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F976C |[10]Thank you very much! [N]I can hardly believe [N]that she is really [N]back! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F9793 {
    COP [3B] ( #$00C0, &code_0F97A9 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F97A9 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F97E2 )
    COP [91]

  loc_0F97B4:
    COP [97]
    COP [81] ( #0B, #05 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #0A, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0B, #05 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #09, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    BRA loc_0F97B4
}

code_0F97E2 {
    COP [01] ( &asciistring_0F97E7 )
    RTL 
}

asciistring_0F97E7 |[10]The coral reef is home[N]to the dolphins- [FIN]The pearls made in the[N]reef are their [N]treasure- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F982F {
    COP [3B] ( #$008E, &code_0F9845 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F9845 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9858 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F9858 {
    COP [18] ( #18, &code_0F985F )
    BRA loc_0F9864
}

code_0F985F {
    COP [18] ( #34, &code_0F9869 )

  loc_0F9864:
    COP [01] ( &asciistring_0F98C6 )
    RTL 
}

code_0F9869 {
    COP [01] ( &asciistring_0F9873 )
    BRK #$5E
    COP [0A] ( #34 )
    RTL 
}

asciistring_0F9873 |[10]Thank you very [N]much for releasing me![FIN]I will give you [03:24]the [N]Red+Hot Stick- [N][03:20]The Phoenix resides on[N]the Stick- [FIN][JMP:&asciistring_0F98C6+M]|

asciistring_0F98C6 |[10][::]Take the Red+Hot Stick[N]and visit the Mountain[N]King- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F98F5 {
    COP [14] ( #$008A, &code_0F98FC )
    RTL 
}

code_0F98FC {
    COP [18] ( #24, &code_0F9903 )
    BRA code_0F997F
}

code_0F9903 {
    COP [0D] ( #00, #0A, #27, &code_0F997F )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F99A2 )
    COP [15]

  code_0F9915:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0002, &code_0F9915 )
    COP [16]
    COP [9F] ( #$FFF8 )
    COP [80] ( #05 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [81] ( #04, #02 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [01] ( &asciistring_0F9A0F )
    BRK #$4E
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [81] ( #19, #02 )
    COP [83]
    BRK #$4E
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [80] ( #18 )
    COP [82]
    COP [01] ( &asciistring_0F9A3F )
    BRK #$4E
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [80] ( #00 )
    COP [82]
    COP [01] ( &asciistring_0F9A6F )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_0F99D1 )
    COP [15]
    COP [91]
    COP [80] ( #00 )
    COP [82]
    RTL 
}

code_0F997F {
    COP [16]
    COP [17] ( &code_0F99D1 )
    COP [9F] ( #$FFF8 )
    COP [80] ( #05 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [81] ( #04, #02 )
    COP [83]
    COP [15]
    COP [91]
    COP [80] ( #00 )
    COP [82]
    RTL 
}

code_0F99A2 {
    COP [01] ( &asciistring_0F99E0 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0F99B6 )
    LDA $L_choice_result
    BNE code_0F99B6
    BRL loc_0F99C9
}

code_0F99B6 {
    COP [01] ( &asciistring_0F9A00 )
    COP [17] ( #$0000 )
    COP [09] ( #$8002 )
    LDA #$2F80
    TSB $joy_block_mask
    RTL 

  loc_0F99C9:
    COP [01] ( &asciistring_0F9AA7 )
    COP [27] ( &code_0F997F )
}

code_0F99D1 {
    COP [18] ( #24, &code_0F99DB )
    COP [01] ( &asciistring_0F9AAB )
    RTL 
}

code_0F99DB {
    COP [01] ( &asciistring_0F9AA7 )
    RTL 
}

asciistring_0F99E0 |[10]Have you seen the [N]Queen of the Mermaids?[END]|

asciistring_0F9A00 |Okay, wait- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9A0F |[10][0A]This█is█a█secret,█the[N]Queen█looks█like█this-[FIN][END]|

asciistring_0F9A3F |[0A]She█always█sits█like[N]this-[N]She█looks█so█mean-[FIN][END]|

asciistring_0F9A6F |[0A]Lue,█the█dolphin█has[N]been█captured![N]Please█save█him![JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9AA7 |[10][JMP:&asciistring_0F9A6F]|

asciistring_0F9AAB |[10]Lue can leave whenever[N]he wishes, but he [N]never comes out- [FIN]Maybe he likes that [N]place- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0FA014 {
    COP [14] ( #$00B6, &code_0FA02E )
    COP [14] ( #$009D, &code_0FA027 )
    COP [17] ( &code_0FA031 )
    COP [91]
    RTL 
}

code_0FA027 {
    COP [17] ( &code_0FA03A )
    COP [91]
    RTL 
}

code_0FA02E {
    COP [86]
    RTL 
}

code_0FA031 {
    COP [01] ( &asciistring_0FA03F )
    COP [09] ( #$8502 )
    RTL 
}

code_0FA03A {
    COP [01] ( &asciistring_0FA0D3 )
    RTL 
}

asciistring_0FA03F |[10][02:2] heard [N]a small voice- [FIN]This is St-Elles [N]Palace in the ocean- [FIN]No human can live [N]under the sea- [FIN]Go to the island, [N]Southerta, through the[N]shrine and look for [N]the Bubble Clothing- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA0D3 |[10]Listen closely to the [N]advice of the 4 [N]mermaid statues- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0FA7C4 {
    PHX 
    LDX #$0000

  loc_0FA7C8:
    LDA #$0090
    STA $7E7000, X
    LDA #$7100
    STA $7E7001, X
    INX 
    INX 
    INX 
    CPX #$002A
    BNE loc_0FA7C8
    LDA #$0000
    STA $7E7000, X
    PLX 
    COP [91]
    PHX 
    LDA $scroll_bg1_x
    LSR 
    STA $00
    LDA $scroll_bg1_y
    LSR 
    STA $02
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $02
    AND #$000F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_0FA80E:
    LDA $@word_0FA834, X
    CLC 
    ADC $00
    STA $7100, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0020
    BNE loc_0FA80E
    PLB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaIndirect
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_0FA834 [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0000   ;03
  #$0001   ;04
  #$0001   ;05
  #$0001   ;06
  #$0001   ;07
  #$0000   ;08
  #$0000   ;09
  #$0000   ;0A
  #$0000   ;0B
  #$FFFF   ;0C
  #$FFFF   ;0D
  #$FFFF   ;0E
  #$FFFF   ;0F
  #$0000   ;10
  #$0000   ;11
  #$0000   ;12
  #$0000   ;13
  #$0001   ;14
  #$0001   ;15
  #$0001   ;16
  #$0001   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$FFFF   ;1C
  #$FFFF   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
]