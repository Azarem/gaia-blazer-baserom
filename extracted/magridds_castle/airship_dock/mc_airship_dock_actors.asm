?BANK 04

?INCLUDE 'engine_scheduler_sprites_combat_collision'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_choice_prompt_texts'

!joy_block_mask                 0326
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!map2_width_px                  0346
!map2_height_px                 0348
!ratio_x_bg2                    034E
!ratio_y_bg2                    0350
!scene_sprite_attr              0372
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!player_actor                   039C
!push_zone_list                 03D8
!push_zone_bank                 03DA
!asset_cache_tilemap1           0419
!random_mod_result              0437
!text_delay                     1B84
!cgram_buffer                   7F0000

---------------------------------------------

code_025B1A {
    COP [14] ( #$016E, &code_025B21 )
    RTL 
}

code_025B21 {
    COP [30] ( #$016E, &code_025B98, #04 )
    COP [07] ( #$8805, &code_025B81 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_025B93 )
    COP [05] ( #$0000 )
    COP [09] ( #$0000 )
    COP [16]
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [01] ( &asciistring_025C7E )
    COP [32] ( #00 )
    COP [B2] ( @code_025B84, #$0080, #$0000, #$0200 )
    BRK #$5B
    COP [05] ( #$0001 )
    BRK #$04
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [97]
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #29, #08 )
    COP [83]
}

code_025B81 {
    COP [86]
    RTL 
}

code_025B84 {
    COP [97]
    COP [81] ( #25, #10 )
    COP [83]
    COP [09] ( #$8001 )
    COP [86]
    RTL 
}

code_025B93 {
    COP [01] ( &asciistring_025C65 )
    RTL 
}

code_025B98 {
    COP [14] ( #$0183, &code_025BA3 )
    COP [01] ( &asciistring_025BB3 )
    RTL 
}

code_025BA3 {
    COP [14] ( #$0181, &code_025BAE )
    COP [01] ( &asciistring_025BEB )
    RTL 
}

code_025BAE {
    COP [01] ( &asciistring_025C22 )
    RTL 
}

asciistring_025BB3 |[10][0E:3C]Please save Dr-Leo- [N]He must be in the [N]prison of the left [N]tower!! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025BEB |[10][0E:3C]Please save my friend![N]He must be in the same[N]prison that Dr-Leo [N]is in- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025C22 |[10][0E:3C]Please come to the [N]airship dock as soon [N]as possible- [FIN]Dr-Leo is waiting for [N]you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025C65 |[10]Are you [02:2]? [FIN]Please see to Dr-Leo- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025C7E |[10]Doctor, we can finally[N]start our ship- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_025CA6 {
    COP [14] ( #$0181, &code_025CAD )
    RTL 
}

code_025CAD {
    COP [07] ( #$8805, &code_025D40 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [05] ( #$0001 )
    COP [03] ( #65 )
    COP [04]
    COP [16]
    COP [96]
    COP [81] ( #2A, #02 )
    COP [83]
    COP [01] ( &asciistring_025D43 )
    COP [32] ( #0D )
    COP [B2] ( @code_025DA5, #$0080, #$FFF0, #$0040 )
    COP [B2] ( @code_025DCE, #$0080, #$0000, #$0040 )
    COP [B2] ( @code_025DFD, #$0080, #$0010, #$0040 )
    COP [B2] ( @code_025E26, #$0090, #$0000, #$0040 )
    COP [05] ( #$0002 )
    COP [01] ( &asciistring_025D4D )
    COP [09] ( #$8003 )
    COP [03] ( #03 )
    COP [05] ( #$0000 )
    COP [09] ( #$0000 )
    LDA $0000, X
    SEC 
    SBC #$0002
    STA $0000, X
    BRK #$44
    COP [04]
    COP [05] ( #$0004 )
    COP [96]
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #29, #08 )
    COP [83]
    COP [09] ( #$8005 )
}

code_025D40 {
    COP [86]
    RTL 
}

asciistring_025D43 |[10]Dok!! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025D4D |[10]You are Queen Magridd![FIN]You destroyed the [N]world! [N]Didn t you realize?! [FIN][10]Shut up wimp! [FIN]Defeat him! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

code_025DA5 {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @code_025E4B, #$0040 )
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025DCE {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @code_025E54, #$0040 )
    BRK #$1B
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [09] ( #$8004 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025DFD {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @code_025E4B, #$0040 )
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025E26 {
    COP [03] ( #51 )
    COP [04]
    COP [AA] ( #00 )
    COP [97]
    COP [81] ( #1A, #02 )
    COP [83]
    COP [80] ( #11 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [09] ( #$8002 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025E4B {
    COP [81] ( #25, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_025E54 {
    COP [81] ( #25, #07 )
    COP [83]
    COP [09] ( #$8000 )
    COP [86]
    RTL 
}
---------------------------------------------

code_025E61 {
    COP [14] ( #$0183, &code_025E68 )
    RTL 
}

code_025E68 {
    COP [30] ( #$0183, &code_02601D, #04 )
    COP [07] ( #$9F05, &code_025FDC )
    COP [07] ( #$8805, &code_025FAF )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$016E, &code_025E8B )
    BRL loc_025E91
}

code_025E8B {
    COP [14] ( #$0181, &code_025E98 )

  loc_025E91:
    COP [17] ( &code_025FDF )
    COP [91]
    RTL 
}

code_025E98 {
    COP [17] ( &code_025FE4 )
    COP [05] ( #$0001 )
    COP [96]
    COP [80] ( #23 )
    COP [82]
    PHX 
    LDX $player_actor
    LDA #$0003
    STA $001E, X
    STZ $0020, X
    JSL $@engine_scheduler_sprites_combat_collision.SetActorAnimFrame
    PLX 
    COP [05] ( #$0005 )
    COP [16]
    COP [81] ( #26, #02 )
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [15]
    COP [01] ( &asciistring_026240 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_02626D )
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_0262A0 )
    COP [B2] ( @code_0266E8, #$0040, #$FF70, #$0040 )
    COP [B2] ( @code_026961, #$0040, #$FF60, #$0040 )
    COP [05] ( #$0007 )
    COP [01] ( &asciistring_0262B9 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_0262ED )
    COP [03] ( #5B )
    COP [04]
    LDA #$0004
    STA $text_delay
    COP [01] ( &asciistring_026382 )
    LDA #$0003
    STA $text_delay
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026458 )
    COP [09] ( #$0007 )
    COP [05] ( #$0007 )
    COP [01] ( &asciistring_02648E )
    LDA #$6FC0
    TRB $joy_block_mask
    COP [91]
    COP [0D] ( #00, #1E, #18, &code_025F43 )
    RTL 
}

code_025F43 {
    LDA #$6FC0
    TSB $joy_block_mask
    COP [01] ( &asciistring_0264C3 )
    BRK #$5E
    COP [0A] ( #23 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026509 )
    COP [16]
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_026533 )
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [B0] ( @code_02699C, #$0300 )
    COP [03] ( #3D )
    COP [04]
    COP [80] ( #22 )
    COP [82]
    COP [15]
    COP [05] ( #$0006 )
    COP [03] ( #15 )
    COP [04]
    COP [31] ( #13 )
    COP [03] ( #79 )
    COP [04]
    COP [09] ( #$8805 )
    LDA #$6FC0
    TRB $joy_block_mask

  loc_025FA8:
    COP [17] ( &code_025FF7 )
    COP [91]
    RTL 
}

code_025FAF {
    COP [07] ( #$8900, &code_025FC2 )
    COP [AC] ( @code_0266FC, #$0230, #$0180, #$0040 )
    BRA loc_025FCD
}

code_025FC2 {
    COP [AC] ( @code_02670A, #$0220, #$0190, #$0040 )

  loc_025FCD:
    COP [9F] ( #$0080 )
    COP [96]
    COP [80] ( #22 )
    COP [82]
    COP [15]
    BRA loc_025FA8
}

code_025FDC {
    COP [86]
    RTL 
}

code_025FDF {
    COP [01] ( &asciistring_0260F6 )
    RTL 
}

code_025FE4 {
    COP [01] ( &asciistring_026144 )
    LDA #$6FC0
    TSB $joy_block_mask
    COP [09] ( #$8000 )
    COP [17] ( #$0000 )
    RTL 
}

code_025FF7 {
    COP [07] ( #$8900, &code_026018 )
    COP [07] ( #$8901, &code_026018 )
    LDA #$0004
    STA $text_delay
    COP [01] ( &asciistring_026551 )
    LDA #$0003
    STA $text_delay
    COP [09] ( #$8901 )
    RTL 
}

code_026018 {
    COP [01] ( &asciistring_0266DB )
    RTL 
}

code_02601D {
    COP [14] ( #$0181, &code_026025 )
    BRA loc_02602B
}

code_026025 {
    COP [14] ( #$016E, &code_026032 )

  loc_02602B:
    COP [01] ( &asciistring_0260F0 )
    COP [86]
    RTL 
}

code_026032 {
    COP [01] ( &asciistring_026039 )
    COP [86]
    RTL 
}

asciistring_026039 |[10][0E:3C]I am Dr-Leo- [N]I have been watching [N]from the darkness- [FIN]I am going to retrieve[N]the Black Stone, go [N]to the World of Evil [N]and defeat Deathtoll- [FIN]I hope you will come [N]with me- [FIN]The airship dock is at[N]the top floor of the [N]right tower- [FIN]I will be waiting for [N]you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0260F0 |[10][0E:3C][JMP:&asciistring_0260F6+M]|

asciistring_0260F6 |[10][::]I am Dr-Leo- [N]I will save the story [N]for later- [FIN]Please save the two [N]soldiers who promised [N]to come with me- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026144 |[10]You are [02:2]- [N]Birds from GreenWood [N]told me of you- [FIN]The stones you have [N]collected are keys to [N]open the gate to the [N]World of Evil- [FIN]They are the Origins [N]of Power for machines [N]that beckon evil- [FIN]King Magridd holds the[N]last stone- [FIN]We have to free him to[N]get the last stone- [FIN]Go then to the World [N]of Evil and defeat [N]Deathtoll- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

asciistring_026240 |[10]You took everything [N]away from me- [FIN]You are dirtier than [N]evil! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02626D |[10]Dr-Leo, you talk too [N]much- [FIN]Life is never easy- [N]Look! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0262A0 |[10]Hey, keep walking- [0E:28][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF+M]|

asciistring_0262B9 |[10]Daddy! [FIN]Daddy! I knew [N]I would see you, [N]but not like this---- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0262ED |[10]Dr-Leo, [N]you will still do what[N]I say? [FIN][10]You-------- [FIN]As you said, I made a [N]machine to call [N]Deathtoll! [FIN]Lisa has nothing to do[N]with this- [FIN][10]Shut up! [FIN]Dr-Leo, you still [N]have to work for us- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026382 |[10]All right- [FIN]I cannot sacrifice [N]peoples  lives [N]anymore- [FIN]But please, release [N]Lisa- [FIN]She is the most [N]precious thing in this[N]world- [FIN]Even if I could not [N]see her, she would [N]still be my [N]motivation- [FIN]I can endure anything [N]by just imagining her [N]face- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026458 |[10]You are an honest man-[FIN]All right, Dr-Leo- [N]Leave Lisa alone- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02648E |[10][0F]Leo whispered in [N][02:2] s ears- [0F][FIN][0A][02:2],[N]stay█behind█me----[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0264C3 |[10][0A]Here,█take█this█and[N]get█on█the█airship-[FIN]Please█take█care█of[N]Lisa-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026509 |[10]I will not run away- [N]Just take me wherever [N]you want- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026533 |[10][0F]Lisa, [N][0E:3C]please forgive me- [N][0E:50][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF+M]|

asciistring_026551 |[10][02:2], I think [N]I was born in the [N]wrong generation- [FIN]Scientists are [N]supposed to invent [N]machines in order to [N]make people happy- [FIN]But an unexpected [N]scientist may ruin the[N]culture- [FIN]Some people believe [N]happiness comes [N]quickly, [FIN]I think it comes with [N]patientce- [FIN]Lisa, I am sorry for [N]leaving you- [FIN]I am not passing away,[N]rather, [N]I am going to sleep- [FIN]When a scientist with [N]my knowledge is [N]needed, I will be [N]back- [FIN][0A]Lisa,█be█happy-[N]But█don t█rush[N]yourself-[N][0E:28]Yes,█gradually--------[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0266DB |[10]-------- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

code_0266E8 {
    COP [81] ( #09, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [05] ( #$0006 )
    COP [80] ( #09 )
    COP [82]
}

code_0266FC {
    COP [80] ( #03 )
    COP [82]
    COP [15]
    COP [17] ( &code_026736 )
    COP [91]
    RTL 
}

code_02670A {
    COP [07] ( #$8902, &code_026723 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_02673B )
    COP [05] ( #$0902 )
    COP [16]
}

code_026723 {
    COP [17] ( &code_026753 )
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_026736 {
    COP [01] ( &asciistring_026758 )
    RTL 
}

code_02673B {
    COP [01] ( &asciistring_026772 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_026746 )
}

code_026746 {
    COP [01] ( &asciistring_026874 )
    COP [17] ( &code_026753 )
    COP [09] ( #$8902 )
    RTL 
}

code_026753 {
    COP [01] ( &asciistring_026921 )
    RTL 
}

asciistring_026758 |[10][0F]Lisa just keeps [N]crying- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026772 |[10]Hello- Thank you for [N]staying with me while [N]my father passed away-[FIN]I didn t think I would[N]see him again- [FIN]But because of you I [N]was finally able to [N]see him again- [FIN]Ever since you saved [N]me at Grass Valley, [N]I imagined you [N]fighting monsters [N]whenever I closed my [N]eyes- [FIN]By the way, [N]I would like you to [N]answer my questions- [FIN]Are you a real human [N]being like me? [END]|

asciistring_026874 |I see --------- [FIN]I feel like you are [N]far away even though [N]you are right in front[N]of me- [FIN]I feel like you are [N]watching us from the [N]sky- [FIN]I don t know how to [N]express the way I [N]feel- [FIN]But that is okay, [N]I, I love--- [FIN]You are going to fight[N]Deathtoll, right? [FIN][JMP:&asciistring_026921+M]|

asciistring_026921 |[10][::]I would say goodbye, [N]but I know I am going [N]to cry- [FIN]Please leave while my [N]back is turned- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

code_026961 {
    COP [81] ( #15, #03 )
    COP [83]
    COP [80] ( #12 )
    COP [82]
    COP [09] ( #$8007 )
    COP [05] ( #$8007 )
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #03 )
    COP [83]
    COP [97]
    COP [80] ( #17 )
    COP [82]
    COP [09] ( #$8007 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_02699C {
    COP [03] ( #40 )
    COP [B0] ( @code_0269B5, #$0300 )
    COP [1B] ( &code_0269AC, #$0002 )
}

code_0269AC {
    COP [04]
    COP [09] ( #$8006 )
    COP [86]
    RTL 
}

code_0269B5 {
    COP [A8] ( #$8000, #0E )
    COP [A3]
    LDA $scene_sprite_attr
    STA $001C, X
    JSR $&code_0269CF
    BRK #$85
    COP [80] ( #00 )
    COP [82]
    COP [86]
    RTL 
}

code_0269CF {
    COP [1F]
    COP [35] ( #40 )
    LDA $random_mod_result
    SEC 
    SBC #$0020
    CLC 
    ADC $0000, X
    STA $0000, X
    COP [1F]
    COP [35] ( #40 )
    LDA $random_mod_result
    SEC 
    SBC #$0020
    CLC 
    ADC $0002, X
    STA $0002, X
    RTS 
}
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

asciistring_026AA6 |[10]I have been haunted by[N]a monster called [N]"research-ˮ [FIN]I would not pay [N]attention to my wife [N]and daughter- [FIN]Still I didn t [N]understand- [FIN]I was praised as a [N]genius, scientist and [N]even the King often [N]gave me orders- [FIN]I kept inventing [N]things, Water Mill, [N]Elevator, and even [N]this Airship- [FIN]Finally I invented [N]a machine to call upon[N]evil, only to [N]realize something- [FIN]Tools are there to [N]make peoples  lives [N]easier- [FIN]But when tools start [N]to use people, [FIN]their culture will [N]decline and they will [N]become unhappy- [FIN]When I get to the [N]World of Evil, [N]Deathtoll will be [N]called- [FIN]I don t want to [N]believe this beautiful[N]world will be [N]destroyed- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026C9D |[10]Please, let me off [N]somewhere! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026CBE |[10]Dr-Leo, [N]you may be right- [FIN]But I must take you to[N]Magridd castle and [N]make sure you do not [N]escape- [FIN]I have to worry about [N]the present, [N]not tomorrow- [FIN]I must do my job or be[N]punished- [FIN]Please try to [N]understand this- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_026D61 {
    COP [80] ( #14 )
    COP [82]
    COP [05] ( #$0000 )
    COP [80] ( #13 )
    COP [82]
    COP [09] ( #$8001 )
    COP [91]
    RTL 
}
---------------------------------------------

code_026D76 {
    COP [15]
    COP [80] ( #13 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

code_026D80 {
    COP [14] ( #$0195, &code_026D8C )
    COP [3B] ( #$0195, &code_026D9E )
}

code_026D8C {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [91]
    COP [0D] ( #00, #17, #0F, &code_026D9F )
}

code_026D9E {
    RTL 
}

code_026D9F {
    COP [01] ( &asciistring_026DB6 )
    COP [09] ( #$8900 )
    STZ $asset_cache_tilemap1
    BRK #$91
    COP [10] ( #$0113, #01, #$0170, #$00F0 )
    RTL 
}

asciistring_026DB6 |[10][02:2] drove [N]the Airship back to [N]the dock- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_026F48 {
    LDA $bg2_offset_y
    SEC 
    SBC #$0008
    STA $bg2_offset_y
    RTL 
}
---------------------------------------------

code_026F53 {
    DEC $bg2_offset_y
    RTL 
}
---------------------------------------------

code_026F57 {
    COP [07] ( #$8900, &code_026F69 )
    COP [19] ( #23, &code_026F69 )
    COP [0D] ( #00, #17, #0F, &code_026F6A )
}

code_026F69 {
    RTL 
}

code_026F6A {
    LDA #$2F80
    TSB $joy_block_mask
    COP [1B] ( &code_026F76, #$0002 )
}

code_026F76 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_026FF9 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRK #$4F
    COP [91]
    LDA $scroll_bg2_x
    BEQ loc_026F99
    DEC $bg2_offset_x
    RTL 

  loc_026F99:
    BRK #$4A
    COP [1B] ( &code_026FA1, #$0046 )
}

code_026FA1 {
    BRK #$91
    COP [91]
    LDA $scroll_bg2_y
    BEQ loc_026FAE
    DEC $bg2_offset_y
    RTL 

  loc_026FAE:
    STZ $ratio_x_bg2
    STZ $ratio_y_bg2
    LDA #$0200
    STA $map2_width_px
    STA $map2_height_px
    LDA #$0002
    STA $0030, X

  loc_026FC3:
    COP [03] ( #10 )
    LDA $scroll_bg2_y
    SEC 
    SBC $0030, X
    STA $scroll_bg2_y
    COP [04]
    INC $0030, X
    LDA $0030, X
    CMP #$0010
    BCC loc_026FC3
    STZ $asset_cache_tilemap1
    COP [10] ( #$0213, #01, #$0170, #$00F0 )
    COP [03] ( #10 )
    LDA $scroll_bg2_y
    SEC 
    SBC $0030, X
    STA $scroll_bg2_y
    COP [04]
    RTL 
}

asciistring_026FF9 |[10][02:2] plugged [N]in the starting key- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_027019 {
    SEP #$20
    LDY #$&unk16_02702B
    STY $push_zone_list
    LDA #$^unk16_02702B
    STA $push_zone_bank
    REP #$20
    COP [86]
    RTL 
}
---------------------------------------------

unk16_02702B [
  unk16 < #16, #19, #06, #0D, #$0000, #$0001 >   ;00
  unk16 < #15, #17, #0D, #14, #$0000, #$0001 >   ;01
  unk16 < #18, #1A, #0D, #14, #$0000, #$0001 >   ;02
  unk16 < #17, #18, #10, #14, #$0000, #$0001 >   ;03
  unk16 < #13, #1C, #14, #1E, #$0000, #$0001 >   ;04
  unk16 < #13, #16, #1E, #23, #$0000, #$0001 >   ;05
  unk16 < #19, #1C, #1E, #23, #$0000, #$0001 >   ;06
  unk16 < #16, #19, #23, #29, #$0000, #$0001 >   ;07
]