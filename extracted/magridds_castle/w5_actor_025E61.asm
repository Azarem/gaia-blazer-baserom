?BANK 04

?INCLUDE 'engine_000000'
?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_actor_025E61_part2'
?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_025E61 {
    COP [14] ( #$0183, &code_025E68 ) ; {155233}
    RTL                   ; {155239}
}

code_025E68 {
    COP [30] ( #$0183, &code_02601D, #04 ) ; {155240}
    COP [07] ( #$9F05, &code_025FDC ) ; {155247}
    COP [07] ( #$8805, &code_025FAF ) ; {155253}
    COP [85] ( @engine_0026F3.code_00299D ) ; {155259}
    COP [15]              ; {155264}
    COP [14] ( #$016E, &code_025E8B ) ; {155266}
    BRL loc_025E91        ; {155272}
}

code_025E8B {
    COP [14] ( #$0181, &code_025E98 ) ; {155275}

  loc_025E91:
    COP [17] ( &code_025FDF ) ; {155281}
    COP [91]              ; {155285}
    RTL                   ; {155287}
}

code_025E98 {
    COP [17] ( &code_025FE4 ) ; {155288}
    COP [05] ( #$0001 )   ; {155292}
    COP [96]              ; {155296}
    COP [80] ( #23 )      ; {155298}
    COP [82]              ; {155301}
    PHX                   ; {155303}
    LDX $player_actor     ; {155304}
    LDA #$0003            ; {155307}
    STA $001E, X          ; {155310}
    STZ $0020, X          ; {155313}
    JSL $@engine_000000.code_0008F3 ; {155316}
    PLX                   ; {155320}
    COP [05] ( #$0005 )   ; {155321}
    COP [16]              ; {155325}
    COP [81] ( #26, #02 ) ; {155327}
    COP [83]              ; {155331}
    COP [80] ( #23 )      ; {155333}
    COP [82]              ; {155336}
    COP [15]              ; {155338}
    COP [01] ( &w5_actor_025E61_part2.asciistring_026240 ) ; {155340}
    COP [03] ( #1F )      ; {155344}
    COP [04]              ; {155347}
    COP [01] ( &w5_actor_025E61_part2.asciistring_02626D ) ; {155349}
    COP [03] ( #3D )      ; {155353}
    COP [04]              ; {155356}
    COP [01] ( &w5_actor_025E61_part2.asciistring_0262A0 ) ; {155358}
    COP [B2] ( @w5_actor_025E61_part2.code_0266E8, #$0040, #$FF70, #$0040 ) ; {155362}
    COP [B2] ( @w5_actor_025E61_part2.code_026961, #$0040, #$FF60, #$0040 ) ; {155373}
    COP [05] ( #$0007 )   ; {155384}
    COP [01] ( &w5_actor_025E61_part2.asciistring_0262B9 ) ; {155388}
    COP [03] ( #1F )      ; {155392}
    COP [04]              ; {155395}
    COP [01] ( &w5_actor_025E61_part2.asciistring_0262ED ) ; {155397}
    COP [03] ( #5B )      ; {155401}
    COP [04]              ; {155404}
    LDA #$0004            ; {155406}
    STA $1B84             ; {155409}
    COP [01] ( &w5_actor_025E61_part2.asciistring_026382 ) ; {155412}
    LDA #$0003            ; {155416}
    STA $1B84             ; {155419}
    COP [03] ( #1F )      ; {155422}
    COP [04]              ; {155425}
    COP [01] ( &w5_actor_025E61_part2.asciistring_026458 ) ; {155427}
    COP [09] ( #$0007 )   ; {155431}
    COP [05] ( #$0007 )   ; {155435}
    COP [01] ( &w5_actor_025E61_part2.asciistring_02648E ) ; {155439}
    LDA #$6FC0            ; {155443}
    TRB $joy_block_mask   ; {155446}
    COP [91]              ; {155449}
    COP [0D] ( #00, #1E, #18, &code_025F43 ) ; {155451}
    RTL                   ; {155458}
}

code_025F43 {
    LDA #$6FC0            ; {155459}
    TSB $joy_block_mask   ; {155462}
    COP [01] ( &w5_actor_025E61_part2.asciistring_0264C3 ) ; {155465}
    BRK #$5E              ; {155469}
    COP [0A] ( #23 )      ; {155471}
    COP [03] ( #1F )      ; {155474}
    COP [04]              ; {155477}
    COP [01] ( &w5_actor_025E61_part2.asciistring_026509 ) ; {155479}
    COP [16]              ; {155483}
    COP [80] ( #26 )      ; {155485}
    COP [82]              ; {155488}
    COP [80] ( #23 )      ; {155490}
    COP [82]              ; {155493}
    COP [03] ( #3D )      ; {155495}
    COP [04]              ; {155498}
    COP [01] ( &w5_actor_025E61_part2.asciistring_026533 ) ; {155500}
    COP [80] ( #26 )      ; {155504}
    COP [82]              ; {155507}
    COP [80] ( #23 )      ; {155509}
    COP [82]              ; {155512}
    COP [B0] ( @w5_actor_025E61_part2.code_02699C, #$0300 ) ; {155514}
    COP [03] ( #3D )      ; {155521}
    COP [04]              ; {155524}
    COP [80] ( #22 )      ; {155526}
    COP [82]              ; {155529}
    COP [15]              ; {155531}
    COP [05] ( #$0006 )   ; {155533}
    COP [03] ( #15 )      ; {155537}
    COP [04]              ; {155540}
    COP [31] ( #13 )      ; {155542}
    COP [03] ( #79 )      ; {155545}
    COP [04]              ; {155548}
    COP [09] ( #$8805 )   ; {155550}
    LDA #$6FC0            ; {155554}
    TRB $joy_block_mask   ; {155557}

  loc_025FA8:
    COP [17] ( &code_025FF7 ) ; {155560}
    COP [91]              ; {155564}
    RTL                   ; {155566}
}

code_025FAF {
    COP [07] ( #$8900, &code_025FC2 ) ; {155567}
    COP [AC] ( @w5_actor_025E61_part2.code_0266FC, #$0230, #$0180, #$0040 ) ; {155573}
    BRA loc_025FCD        ; {155584}
}

code_025FC2 {
    COP [AC] ( @w5_actor_025E61_part2.code_02670A, #$0220, #$0190, #$0040 ) ; {155586}

  loc_025FCD:
    COP [9F] ( #$0080 )   ; {155597}
    COP [96]              ; {155601}
    COP [80] ( #22 )      ; {155603}
    COP [82]              ; {155606}
    COP [15]              ; {155608}
    BRA loc_025FA8        ; {155610}
}

code_025FDC {
    COP [86]              ; {155612}
    RTL                   ; {155614}
}

code_025FDF {
    COP [01] ( &asciistring_0260F6 ) ; {155615}
    RTL                   ; {155619}
}

code_025FE4 {
    COP [01] ( &asciistring_026144 ) ; {155620}
    LDA #$6FC0            ; {155624}
    TSB $joy_block_mask   ; {155627}
    COP [09] ( #$8000 )   ; {155630}
    COP [17] ( #$0000 )   ; {155634}
    RTL                   ; {155638}
}

code_025FF7 {
    COP [07] ( #$8900, &code_026018 ) ; {155639}
    COP [07] ( #$8901, &code_026018 ) ; {155645}
    LDA #$0004            ; {155651}
    STA $1B84             ; {155654}
    COP [01] ( &w5_actor_025E61_part2.asciistring_026551 ) ; {155657}
    LDA #$0003            ; {155661}
    STA $1B84             ; {155664}
    COP [09] ( #$8901 )   ; {155667}
    RTL                   ; {155671}
}

code_026018 {
    COP [01] ( &w5_actor_025E61_part2.asciistring_0266DB ) ; {155672}
    RTL                   ; {155676}
}

code_02601D {
    COP [14] ( #$0181, &code_026025 ) ; {155677}
    BRA loc_02602B        ; {155683}
}

code_026025 {
    COP [14] ( #$016E, &code_026032 ) ; {155685}

  loc_02602B:
    COP [01] ( &asciistring_0260F0 ) ; {155691}
    COP [86]              ; {155695}
    RTL                   ; {155697}
}

code_026032 {
    COP [01] ( &asciistring_026039 ) ; {155698}
    COP [86]              ; {155702}
    RTL                   ; {155704}
}

asciistring_026039 |[10][0E:3C]I am Dr-Leo- [N]I have been watching [N]from the darkness- [FIN]I am going to retrieve[N]the Black Stone, go [N]to the World of Evil [N]and defeat Deathtoll- [FIN]I hope you will come [N]with me- [FIN]The airship dock is at[N]the top floor of the [N]right tower- [FIN]I will be waiting for [N]you- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0260F0 |[10][0E:3C][JMP:&asciistring_0260F6+M]|

asciistring_0260F6 |[10][::]I am Dr-Leo- [N]I will save the story [N]for later- [FIN]Please save the two [N]soldiers who promised [N]to come with me- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026144 |[10]You are [02:2]- [N]Birds from GreenWood [N]told me of you- [FIN]The stones you have [N]collected are keys to [N]open the gate to the [N]World of Evil- [FIN]They are the Origins [N]of Power for machines [N]that beckon evil- [FIN]King Magridd holds the[N]last stone- [FIN]We have to free him to[N]get the last stone- [FIN]Go then to the World [N]of Evil and defeat [N]Deathtoll- [JMP:&w5_shared_02706C.asciistring_0270DF]|