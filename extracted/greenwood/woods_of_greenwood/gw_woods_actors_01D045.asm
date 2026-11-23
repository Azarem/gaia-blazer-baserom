?BANK 03

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'gw_watching_over_world_return_prompt_texts'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'

!frame_counter                  0312
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!asset_cache_tilemap1           0419
!souls_flags                    1B82

---------------------------------------------

code_01D045 {
    COP [3B] ( #$005D, &code_01D05B )
    COP [17] ( &shared_actor_helpers_bank3.code_01B191 )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_01D05B {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_01D0DE )
    COP [91]
    COP [14] ( #$004A, &code_01D06F )
    RTL 
}

code_01D06F {
    COP [14] ( #$003F, &code_01D076 )
    RTL 
}

code_01D076 {
    COP [17] ( &code_01D0E3 )
    COP [05] ( #$0005 )
    COP [09] ( #$0005 )
    COP [16]
    COP [81] ( #04, #02 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [17] ( &code_01D0F0 )
    COP [15]
    RTL 
}

code_01D096 {
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [09] ( #$0006 )
    COP [87]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D101 )
    COP [05] ( #$0007 )
    COP [17] ( &code_01D10E )
    COP [91]
    RTL 
}

code_01D0DE {
    COP [01] ( &asciistring_01D134 )
    RTL 
}

code_01D0E3 {
    COP [01] ( &asciistring_01D174 )
    COP [17] ( #$0000 )
    COP [09] ( #$8003 )
    RTL 
}

code_01D0F0 {
    COP [01] ( &asciistring_01D1E5 )
    COP [09] ( #$8006 )
    COP [27] ( &code_01D096 )
    COP [01] ( &asciistring_01D291 )
    RTL 
}

code_01D101 {
    COP [01] ( &asciistring_01D49D )
    COP [09] ( #$8000 )
    COP [09] ( #$8007 )
    RTL 
}

code_01D10E {
    COP [07] ( #$8006, &code_01D126 )
    COP [09] ( #$8006 )
    COP [01] ( &asciistring_01D291 )
    BRK #$5E
    COP [0A] ( #38 )
    COP [17] ( &code_01D12F )
    RTL 
}

code_01D126 {
    COP [01] ( &asciistring_01D2D3 )
    COP [17] ( &code_01D12F )
    RTL 
}

code_01D12F {
    COP [01] ( &asciistring_01D4D0 )
    RTL 
}

asciistring_01D134 |[10]I am Billy, leader of [N]the "Woodstin+Trioˮ, -[N]Our show is really [N]exciting! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D174 |[10]The band is back [N]together, so let s [N]start the show! [FIN]Even though you are [N]our only audience we [N]will try our best- [FIN]Please watch the two [N]other guys- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D1E5 |[10]How did you like it? [FIN]For our next number [N]you must try and guess[N]the real squirrel, me-[FIN]We will move around [N]and if you choose [N]correctly, you will [N]win a prize- [FIN]Please talk with whom [N]you think the real [N]squirrel is- [FIN]Here we go! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D291 |[10]You re right!! [N]Okay, I will give you [N]a present- [FIN][02:2] received [N][03:24]the Medical Herb- [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D2D3 |[10]Too bad, but please [N]try again soon- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01D2F3 {
    COP [3B] ( #$003F, &code_01D309 )
    COP [17] ( &shared_actor_helpers_bank3.code_01B191 )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_01D309 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01D3E5 )
    COP [15]
    COP [91]
    COP [14] ( #$005D, &code_01D31D )
    RTL 
}

code_01D31D {
    COP [14] ( #$004A, &code_01D324 )
    RTL 
}

code_01D324 {
    COP [17] ( &code_01D3EA )
    COP [05] ( #$0004 )
    COP [16]
    COP [17] ( #$0000 )
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #0C, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [87]
    COP [81] ( #0E, #03 )
    COP [83]
    COP [87]
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #0D, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [81] ( #0E, #03 )
    COP [83]
    COP [9F] ( #$0010 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    BRK #$4E
    COP [80] ( #02 )
    COP [82]
    COP [1B] ( &code_01D37C, #$003C )
}

code_01D37C {
    COP [09] ( #$8005 )
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D3EA )
    COP [05] ( #$0006 )
    COP [16]
    COP [17] ( #$0000 )
    COP [80] ( #03 )
    COP [82]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    COP [87]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D3EF )
    COP [05] ( #$0007 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    BRK #$4E
    COP [80] ( #0C )
    COP [82]
    COP [17] ( &code_01D3FC )
    COP [91]
    RTL 
}

code_01D3E5 {
    COP [01] ( &asciistring_01D410 )
    RTL 
}

code_01D3EA {
    COP [01] ( &asciistring_01D481 )
    RTL 
}

code_01D3EF {
    COP [01] ( &asciistring_01D49D )
    COP [09] ( #$8006 )
    COP [09] ( #$8007 )
    RTL 
}

code_01D3FC {
    COP [07] ( #$8000, &code_01D40B )
    COP [01] ( &asciistring_01D4BB )
    COP [17] ( &code_01D40B )
    RTL 
}

code_01D40B {
    COP [01] ( &asciistring_01D4D0 )
    RTL 
}

asciistring_01D410 |[10]I am a member of the [N]"Woodstin+Trio-ˮ [N]We put on a variety [N]show in this theater- [FIN]I need my other two [N]band members to start [N]the show- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D481 |[10]Hey, don t walk around[N]here- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

asciistring_01D49D |[10]Okay, let s see if [N]I really am Billy- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D4BB |[10]Too bad, almost- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D4D0 |[10]I hope you liked [N]our show- [N]See you later- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01D4F9 {
    COP [14] ( #$0050, &code_01D500 )
    RTL 
}

code_01D500 {
    COP [30] ( #$0050, &code_01D531, #03 )
    COP [91]
    COP [0D] ( #00, #17, #0D, &code_01D511 )
    RTL 
}

code_01D511 {
    COP [07] ( #$8507, &code_01D52E )
    COP [1B] ( &code_01D51D, #$0002 )
}

code_01D51D {
    COP [01] ( &asciistring_01D53A )
    BRK #$5E
    COP [0A] ( #3B )
    COP [09] ( #$8507 )
    COP [09] ( #$9B01 )
}

code_01D52E {
    COP [91]
    RTL 
}

code_01D531 {
    COP [01] ( &asciistring_01D5CE )
    COP [37]
    COP [86]
    RTL 
}

asciistring_01D53A |[10]I am the [N]Guardian of the Woods-[FIN]I have been watching [N]the world for a long [N]time- [FIN][02:2], a dog named [N]Turbo has buried [N]something near my [N]roots- [FIN]You will need this [N]Green Stone someday, [N]so please take it- [FIN][02:2] received [N][03:24]the Green Stone- [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D5CE |[10][0E:3C]I am the Guardian of [N]the Woods- Thank you [N]for releasing me- [FIN]I will give you the [N]Green Stone upon your [N]return- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01D614 {
    RTL 
}
---------------------------------------------

code_01D615 {
    COP [14] ( #$0064, &code_01D61C )
    RTL 
}

code_01D61C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01D635 )

  loc_01D625:
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01D630, #$0028 )
}

code_01D630 {
    COP [87]
    BRL loc_01D625
}

code_01D635 {
    COP [01] ( &asciistring_01D63A )
    RTL 
}

asciistring_01D63A |[10]I heard of the [N]Phoenix s magic when I[N]visited the Soul of [N]the Mountain- [FIN]If you collect the [N]three symbols, you [N]should visit the [N]Mountain King- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01D6AB {
    COP [14] ( #$0049, &code_01D6B2 )
    RTL 
}

code_01D6B2 {
    COP [85] ( @code_01D803 )
    COP [17] ( &code_01D6D0 )
    COP [15]
    COP [91]
    COP [07] ( #$8303, &code_01D6C6 )
    RTL 
}

code_01D6C6 {
    COP [16]
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [86]
    RTL 
}

code_01D6D0 {
    COP [01] ( &asciistring_01D6F9 )
    SEP #$20
    LDA $souls_flags
    ORA #$02
    STA $souls_flags
    REP #$20
    COP [09] ( #$8303 )
    BRK #$4E
    COP [14] ( #$004F, &code_01D6EE )
    BRA loc_01D6F4
}

code_01D6EE {
    COP [14] ( #$0051, &code_01D6F8 )

  loc_01D6F4:
    COP [01] ( &asciistring_01D7A2 )
}

code_01D6F8 {
    RTL 
}

asciistring_01D6F9 |[10]Even though I [N]don t look like it, [N]I am from the sky [N]just like you- [FIN]I light up the [N]darkness- [N]You cheer up everyone-[FIN]Let s work together to[N]revive the world- [FIN]The creature who [N]lights up darkness [N]joined [02:2]! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D7A2 |[10][0E:3C]By the way why don t [N]we go to the second [N]basement of the Water [N]Shrine? [FIN]You will now be able [N]to see monsters which [N]you could not see [N]without me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01D803 {
    COP [07] ( #$0304, &code_01D80C )
    COP [86]
    RTL 
}

code_01D80C {
    COP [91]
    COP [0D] ( #00, #19, #19, &code_01D816 )
    RTL 
}

code_01D816 {
    COP [01] ( &asciistring_01D826 )
    BRK #$5E
    COP [0A] ( #1E )
    COP [09] ( #$8304 )
    COP [91]
    RTL 
}

asciistring_01D826 |[10][03:24]The leaves of [N]GreenWood [03:20]are found [N]under the dog bones! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01D857 {
    COP [14] ( #$0049, &code_01D85E )
    RTL 
}

code_01D85E {
    COP [30] ( #$0049, &code_01D868, #03 )
    COP [91]
    RTL 
}

code_01D868 {
    COP [01] ( &asciistring_01D86F )
    COP [86]
    RTL 
}

asciistring_01D86F |[10][0E:3C]A voice is calling [N][02:2] from [N]the hole- [FIN]I am the creature who [N]brings light to [N]darkness- I will help [N]you upon your return- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01D8C8 {
    COP [14] ( #$0051, &code_01D8CF )
    RTL 
}

code_01D8CF {
    COP [07] ( #$8403, &code_01D905 )
    COP [15]
    COP [17] ( &code_01D908 )
    COP [91]
    RTL 
}

code_01D8DE {
    COP [17] ( #$0000 )
    COP [03] ( #20 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    COP [04]
    COP [16]
}

code_01D905 {
    COP [86]
    RTL 
}

code_01D908 {
    COP [19] ( #1F, &code_01D91C )
    COP [01] ( &asciistring_01D94B )
    COP [0B] ( #1F )
    COP [09] ( #$8403 )
    COP [27] ( &code_01D8DE )
}

code_01D91C {
    COP [01] ( &asciistring_01D921 )
    RTL 
}

asciistring_01D921 |[10]You must bring [N]me something that once[N]belonged to Monmo- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D94B |[10]Th-- that s Monmo s [N]ribbon! [FIN]Al-- allright, I will [N]move if you give that [N]to me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01D98E {
    COP [14] ( #$0062, &code_01D995 )
    RTL 
}

code_01D995 {
    COP [15]
    COP [17] ( &code_01D9BB )
    COP [07] ( #$0307, &code_01D9A5 )
    COP [17] ( &code_01D9C0 )
}

code_01D9A5 {
    COP [07] ( #$0400, &code_01D9AF )
    COP [17] ( &code_01D9D9 )
}

code_01D9AF {
    COP [91]
    COP [18] ( #1F, &code_01D9BA )
    COP [09] ( #$8907 )
}

code_01D9BA {
    RTL 
}

code_01D9BB {
    COP [01] ( &asciistring_01D9DE )
    RTL 
}

code_01D9C0 {
    COP [01] ( &asciistring_01DA4D )
    COP [17] ( &code_01D9D4 )
    COP [14] ( #$005C, &code_01D9CF )
    RTL 
}

code_01D9CF {
    COP [09] ( #$8400 )
    RTL 
}

code_01D9D4 {
    COP [01] ( &asciistring_01DB09 )
    RTL 
}

code_01D9D9 {
    COP [01] ( &asciistring_01DB0D )
    RTL 
}

asciistring_01D9DE |[10]I am always digging in[N]the ground, sometimes [N]I dig up strange [N]things- [FIN]I just dug up some dog[N]bones to #- [FIN]I got scared and re+ [N]buried them- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DA4D |[10]What? Did a female [N]mole come by here? [FIN]No, I am living down [N]here alone- [FIN]Oh, I think I have [N]heard this story----- [FIN]There once was a cute [N]female mole living [N]around here- [FIN]But she was taken away[N]by evil creatures- [FIN][::]I am scared----- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DB09 |[10][JMP:&asciistring_01DA4D+M]|

asciistring_01DB0D |[10]I became so scared I [N]dug a tunnel to the [N]house next door- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01DB3F {
    COP [14] ( #$005C, &code_01DB46 )
    RTL 
}

code_01DB46 {
    COP [17] ( #$0000 )
    COP [91]
    COP [0D] ( #00, #05, #0B, &code_01DB69 )
    COP [0D] ( #00, #05, #0F, &code_01DB69 )
    COP [0D] ( #00, #0E, #0D, &code_01DBA5 )
    COP [0D] ( #00, #0D, #12, &code_01DBA5 )
    RTL 
}

code_01DB69 {
    COP [2A] ( #$0010, #$0000 )
    COP [9B] ( #$0000, &code_01DB79, &code_01DB79, &code_01DB87 )
}

code_01DB79 {
    COP [80] ( #0B )
    COP [82]
    COP [81] ( #07, #10 )
    COP [83]
    BRL loc_01DB92
}

code_01DB87 {
    COP [80] ( #0B )
    COP [82]
    COP [81] ( #06, #10 )
    COP [83]

  loc_01DB92:
    COP [01] ( &asciistring_01DBAD )
    COP [16]
    COP [87]
    COP [80] ( #0B )
    COP [82]
    COP [15]
    COP [17] ( &code_01DBA8 )
}

code_01DBA5 {
    COP [91]
    RTL 
}

code_01DBA8 {
    COP [01] ( &asciistring_01DBDB )
    RTL 
}

asciistring_01DBAD |[10]BOO! [FIN]----------- [FIN]Come on! Aren t you [N]suprised? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DBDB |[10]Phew! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01DBE5 {
    COP [14] ( #$0040, &code_01DBEC )
    RTL 
}

code_01DBEC {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_01DBFA )
    COP [91]
    RTL 
}

code_01DBFA {
    COP [14] ( #$0051, &code_01DC05 )
    COP [01] ( &asciistring_01DD41 )
    RTL 
}

code_01DC05 {
    COP [18] ( #36, &code_01DC0F )
    COP [01] ( &asciistring_01DD72 )
    RTL 
}

code_01DC0F {
    COP [01] ( &asciistring_01DC19 )
    BRK #$5E
    COP [0A] ( #36 )
    RTL 
}

asciistring_01DC19 |[10]I didn t know that he [N]was a ghost- [FIN]Both of us fell in [N]love with Monmo- [FIN]One day, Monmo was [N]captured by evil- He [N]tried to rescue her [N]but never came back- [FIN]Suddenly he appeared, [N]I had no idea what [N]happened to him- [FIN]Anyways, take this [N]bracelet and revive [N]GreenWood- [FIN]I know those two moles[N]would have liked to [N]live here in peace- [FIN][02:2] received [N][03:24]Shield Bracelet! [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DD41 |[10]My roommate has [N]disappeared- Will you [N]look for him? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DD72 |[10]I am a bit jealous [N]that he won Monmo s [N]heart- [FIN]But I hope they are [N]happy now- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01DDB7 {
    COP [14] ( #$0072, &code_01DDBE )
    RTL 
}

code_01DDBE {
    COP [07] ( #$8307, &code_01DE5D )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01DE60 )
    COP [15]
    COP [91]
    RTL 
}

code_01DDD2 {
    COP [17] ( &code_01DE68 )
    COP [16]

  code_01DDD8:
    COP [27] ( &code_01DDDC )
}

code_01DDDC {
    COP [0D] ( #16, #0E, #1F, &code_01DE49 )
    COP [9C] ( &code_01DDE9, &code_01DE1B )
}

code_01DDE9 {
    COP [9A] ( #$0010, &code_01DDF3, &code_01DE1B, &code_01DE12 )
}

code_01DDF3 {
    COP [14] ( #$0056, &code_01DE09 )
    LDA $0000, X
    CMP #$0120
    BCS code_01DE09
    LDA $0002, X
    CMP #$0170
    BCC code_01DDD8
}

code_01DE09 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_01DDDC
}

code_01DE12 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRA code_01DDDC
}

code_01DE1B {
    COP [9B] ( #$0010, &code_01DE25, &code_01DDD8, &code_01DE42 )
}

code_01DE25 {
    COP [14] ( #$0056, &code_01DE3B )
    LDA $0002, X
    CMP #$0170
    BCS code_01DE3B
    LDA $0000, X
    CMP #$0120
    BCC code_01DDD8
}

code_01DE3B {
    COP [80] ( #0A )
    COP [82]
    BRA code_01DDDC
}

code_01DE42 {
    COP [80] ( #09 )
    COP [82]
    BRA code_01DDDC
}

code_01DE49 {
    COP [17] ( &code_01DE6D )
    COP [15]
    COP [80] ( #06 )
    COP [82]
    COP [91]
    RTL 
}

code_01DE57 {
    COP [16]
    COP [09] ( #$8307 )
}

code_01DE5D {
    COP [86]
    RTL 
}

code_01DE60 {
    COP [01] ( &asciistring_01DE75 )
    COP [27] ( &code_01DDD2 )
}

code_01DE68 {
    COP [01] ( &asciistring_01DF22 )
    RTL 
}

code_01DE6D {
    COP [01] ( &asciistring_01DF4C )
    COP [27] ( &code_01DE57 )
}

asciistring_01DE75 |[10]My name is Monmo the [N]mole- [FIN]This place is so [N]bright I cannot see- [FIN]Would you please lead [N]me to my house? I will[N]follow you- [FIN]Please take to the [N]hole that leads to my [N]home- [FIN]Allright, talk to me [N]when I am standing in [N]the right place- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DF22 |[10]Please don t walk so [N]fast, I can t keep up [N]with you- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DF4C |[10]I ll give you [N]a present- [N]Could you wait here? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01DF73 {
    COP [14] ( #$004F, &code_01DF7A )
    RTL 
}

code_01DF7A {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01DF88 )
    COP [15]
    COP [91]
    RTL 
}

code_01DF88 {
    COP [01] ( &asciistring_01DF8D )
    RTL 
}

asciistring_01DF8D |[10]Turbo, the dog, [N]used to live with a [N]human named Dr-Leo- [FIN]Turbo learned a great [N]many things from him- [FIN]He used branches from [N]the trees to make a [N]tool called a raft- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E005 {
    COP [14] ( #$0043, &code_01E00C )
    RTL 
}

code_01E00C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01E01A )
    COP [15]
    COP [91]
    RTL 
}

code_01E01A {
    COP [18] ( #02, &code_01E024 )
    COP [01] ( &asciistring_01E11B )
    RTL 
}

code_01E024 {
    COP [18] ( #25, &code_01E03B )
    COP [19] ( #25, &code_01E040 )
    COP [01] ( &asciistring_01E0DD )
    COP [0B] ( #25 )
    BRK #$5E
    COP [0A] ( #02 )
    RTL 
}

code_01E03B {
    COP [01] ( &asciistring_01E045 )
    RTL 
}

code_01E040 {
    COP [01] ( &asciistring_01E0A5 )
    RTL 
}

asciistring_01E045 |[10]Welcome to the [N]squirrel s exchange [N]store- [FIN]I am hungry, if [N]you can bring me [N]something to eat, [FIN]I will trade you [N]something- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E0A5 |[10]Ah, I smell some [N]delicious seeds- You [N]have some don t you? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E0DD |[10]I will exchange this [N]sword with you for the[N]seeds- [FIN][02:2] received [N][03:24]the Psycho Sword- [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E11B |[10]Those seeds were very [N]good! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E134 {
    COP [14] ( #$0043, &code_01E13B )
    RTL 
}

code_01E13B {
    COP [30] ( #$0043, &code_01E145, #03 )
    COP [91]
    RTL 
}

code_01E145 {
    COP [01] ( &asciistring_01E14C )
    COP [86]
    RTL 
}

asciistring_01E14C |[10][0E:3C]A small voice is [N]coming from a hole- [FIN]Oh, I am starving----[FIN]If someone can bring [N]me something to eat [FIN]I will exchange this [N]powerful sword with [N]them----- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E1C0 {
    COP [14] ( #$0041, &code_01E1C7 )
    RTL 
}

code_01E1C7 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01E1D5 )
    COP [15]
    COP [91]
    RTL 
}

code_01E1D5 {
    COP [07] ( #$9A02, &code_01E1E9 )
    COP [01] ( &asciistring_01E1EE )
    BRK #$5E
    COP [0A] ( #2C )
    COP [09] ( #$9A02 )
    RTL 
}

code_01E1E9 {
    COP [01] ( &asciistring_01E22B )
    RTL 
}

asciistring_01E1EE |[10]Thank you for [N]releasing me- I will [N]give you this- [FIN][02:2] received [N][03:24]the Master s Emblem C-[03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E22B |[10]Thank you for [N]releasing me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E241 {
    COP [15]
    COP [17] ( &code_01E24A )
    COP [91]
    RTL 
}

code_01E24A {
    COP [07] ( #$8402, &code_01E255 )
    COP [01] ( &asciistring_01E266 )
    RTL 
}

code_01E255 {
    COP [01] ( &asciistring_01E2EA )
    COP [3C] ( #04 )
    COP [10] ( #$0104, #02, #$0120, #$02D0 )
    RTL 
}

asciistring_01E266 |[10]Turbo refused to give [N]his life to the evil [N]one, Deathtoll- [FIN]He fought Deathtoll [N]trying to save [N]GreenWood and all [N]it s animals, [FIN]but he was defeated- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E2EA |[10]Turbo, wait! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E2FB {
    COP [14] ( #$0074, &code_01E302 )
    RTL 
}

code_01E302 {
    COP [81] ( #27, #0F )
    COP [83]
    COP [81] ( #28, #08 )
    COP [83]
    COP [15]
    COP [17] ( &code_01E337 )
    COP [91]
    RTL 
}

code_01E317 {
    COP [17] ( #$0000 )
    COP [1B] ( &code_01E321, #$003C )
}

code_01E321 {
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #27, #0F )
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_01E337 {
    COP [01] ( &asciistring_01E343 )
    COP [09] ( #$8402 )
    COP [27] ( &code_01E317 )
}

asciistring_01E343 |[10][02:2], go to [N]the Light Shrine and [N]release the Guardian [N]of the Woods- [FIN]You will find what you[N]are looking for- [FIN]There is a bird, Tiki,[N]that may tell you how [N]to use the raft- [FIN]You must protect [N]GreenWood now that [N]I am gone- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E3E2 {
    COP [A1] ( #$007C, #$FFFA )
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01E3FD, #$0028 )
}

code_01E3FD {
    COP [87]
    COP [80] ( #1D )
    COP [82]
    COP [15]
    COP [17] ( &code_01E412 )
    COP [91]
    COP [80] ( #1A )
    COP [82]
    RTL 
}

code_01E412 {
    COP [01] ( &asciistring_01E426 )
    STZ $asset_cache_tilemap1
    COP [3C] ( #04 )
    COP [10] ( #$0104, #00, #$0070, #$02A0 )
    RTL 
}

asciistring_01E426 |[10]Even though I am only [N]a stump in real life, [N]I often dream [FIN]that I am a bird and [N]can fly wherever I [N]wish- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E9D3 {
    PHX 
    LDX #$0000

  loc_01E9D7:
    LDA #$00A0
    STA $7E7000, X
    STA $7E7800, X
    LDA #$7100
    STA $7E7001, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$0015
    BNE loc_01E9D7
    LDA #$0000
    STA $7E7000, X
    STA $7E7800, X
    PLX 
    COP [91]
    LDA $0000, X
    INC 
    CLC 
    ADC $scroll_delta_x
    STA $0000, X
    STA $scroll_bg2_x
    LDA $0002, X
    INC 
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    PHX 
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $scroll_bg2_y
    AND #$001F
    ASL 
    TAX 
    LDY #$0000
    PHB 
    SEP #$20
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_01EA3D:
    LDA $@word_01EA7B, X
    CLC 
    ADC $033E
    STA $7100, Y
    LDA $@word_01EA7B, X
    CLC 
    ADC $0340
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0040
    BNE loc_01EA3D
    PLB 
    SEP #$20
    LDA #$0D
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaIndirect
    LDA #$0E
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_01EA7B [
  #$0000   ;00
  #$0001   ;01
  #$0002   ;02
  #$0002   ;03
  #$0003   ;04
  #$0003   ;05
  #$0004   ;06
  #$0004   ;07
  #$0004   ;08
  #$0004   ;09
  #$0004   ;0A
  #$0003   ;0B
  #$0003   ;0C
  #$0002   ;0D
  #$0002   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFE   ;12
  #$FFFE   ;13
  #$FFFD   ;14
  #$FFFD   ;15
  #$FFFC   ;16
  #$FFFC   ;17
  #$FFFC   ;18
  #$FFFC   ;19
  #$FFFC   ;1A
  #$FFFD   ;1B
  #$FFFD   ;1C
  #$FFFE   ;1D
  #$FFFE   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0002   ;22
  #$0002   ;23
  #$0003   ;24
  #$0003   ;25
  #$0004   ;26
  #$0004   ;27
  #$0004   ;28
  #$0004   ;29
  #$0004   ;2A
  #$0003   ;2B
  #$0003   ;2C
  #$0002   ;2D
  #$0002   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFE   ;32
  #$FFFE   ;33
  #$FFFD   ;34
  #$FFFD   ;35
  #$FFFC   ;36
  #$FFFC   ;37
  #$FFFC   ;38
  #$FFFC   ;39
  #$FFFC   ;3A
  #$FFFD   ;3B
  #$FFFD   ;3C
  #$FFFE   ;3D
  #$FFFE   ;3E
  #$FFFF   ;3F
]