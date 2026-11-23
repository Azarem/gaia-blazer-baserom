; The actors of the seabed scenes (world 2, St. Elles; A07S01 to A07S04) and the common scripts that run on them (file offsets 1022717-1024020, 1024262-1024571, 1025172-1025268, 1025436-1025471, 1025611-1025781 and 1026164-1026341, SNES $1F:9AFD-$A013, $A106-$A239, $A494-$A4F3, $A59C-$A5BE, $A64B-$A6F4 and $A874-$A944). Roots follow the patterns explained in se_seabed_sanctuary_actors_0F8000 (COP 14 already free, COP 30 return trip).
; 
; === ROSTER (root: switch, who, what the player gets or sees) ===
; - se_npc_dolphin_dream_cave_0F9AFD: switch $BB. The napping dolphin in the south-west corner of the Lue region. With the Dream Rod (item $1C) equipped the hero enters the dolphin's dream (A07S04 at pixel ($50,$200)); without it 'Zzzzz'; after the Big Pearl was given in the dream (flag $0506): 'Hey, didn't I meet you in my dream?'.
; - se_npc_dolphin_lue_0F9B8B: switch $8F. Lue, Dr. Leo's dolphin, freed from a cell. Gives the Thunder Ring (item $24) with the story of the Blue Stone ('My name is Lue. I used to live with the inventor, Dr. Leo ...'); afterwards he only says 'I heard that Dr. Leo was taken to the Magridd Castle. I wonder how he is.'
; - se_npc_dolphin_lue_friend_0F9DBE: switch $8C. The dolphin who tried to rescue Lue: butts the wall of Lue's alcove after Lue calls ('Lue! I'm coming!') and opens it (flag $0601).
; - se_obj_statue_gate_rockbird_0F9ED4 / blester_0F9F24 / durean_0F9F74 / ghost_ship_0F9FC4: the four gates at the seabed end of the statue passages. When the hero steps on the gate tile the pad is blocked, the player actors are hidden (COP 34) and after 120 frames the gate animation plays; the gate sets its own passage flag ($0406 / $0407 / $0500 / $0501), clears flag $0903 and sends the hero back to the Sanctuary in front of the matching statue.
; - se_npc_dolphin_big_pearl_0FA106: no switch (placed in the dream). The dolphin of the Big Pearl: with the Pearl equipped ('That Pearl! Yes, I was going to present that Pearl.') he takes it away (flag $0506), swims, and when the switch $79 under him is pressed he moves the hero to A07S03 at pixel ($40,$80); without the Pearl he remembers something 'like a ball, shiny and black' and ends the dream.
; - se_npc_fairy_exp_300_0FA494 ($7F, flag $1D06) and se_npc_fairy_exp_250_0FA4C4 ($7A, flag $1D07): two fairy gems; they use the shared fairy setup of shared_actor_helpers_bank3 and pay 300 and 250 EXP once ('Fairy Gem' of the walkthrough). The third fairy (200 EXP) and the return prompt are in se_st_elles_coast_actors.
; - se_obj_water_current_0FA59C: registers the two push zones of the seabed current (table unk16_0FA5AE) and kills itself.
; - se_effect_underwater_breath_0FA64B: the oxygen rule of the seabed: without the Bubble Armor the hero loses 1 HP every 64 frames; with it a bubble dome (se_effect_air_bubble_dome_0FA6A9) follows him and a bubble rises every 256 frames (se_effect_air_bubble_rising_0FA6CB).
; - se_effect_seabed_wave_hdma_0FA874: the water shimmer of the seabed (HDMA channels $0D and $0E).
; 
; === EVENT FLAGS ===
; $0000 (Lue's friend) Lue has called for him, $0406 / $0407 / $0500 / $0501 passage flags of the four gates, $0506 the Big Pearl was given, $0601 the wall of Lue's alcove is open, $0903 a statue trip is running (set by the statues, cleared by the gates), $1D06 / $1D07 the 300 / 250 EXP fairy was paid.
; 
; === OPEN ===
; The gate flags are never cleared by a script (OQ-I036-1). The no-switch placement of the Big Pearl dolphin and the identity of A07S03 are not traced.
---------------------------------------------

?BANK 1F

?INCLUDE 'engine_scheduler_sprites_combat_collision'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'se_st_elles_coast_actors'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'w2_shared_0FA945'

!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!player_x                       0374
!player_y                       0376
!push_zone_list                 03D8
!push_zone_bank                 03DA
!return_active                  03FB

---------------------------------------------

; The napping dolphin that holds the dream of the Big Pearl (switch $BB).
; 
; When: placement script; COP 14 until the lair $BB is released.
; Sees: the puff, tiles blocked, animation $11 in a loop; talk handler code_0F9B17.
; Why: walkthrough Seabed Sanctuary - Path Opening: 'In the southwest corner there is a napping dolphin. Equip the Dream Rod and speak with the dude to enter his dream.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_dolphin_dream_cave_0F9AFD {
    COP [14] ( #$00BB, &code_0F9B04 )
    RTL 
}

code_0F9B04 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_0F9B17 )

  loc_0F9B0F:
    COP [80] ( #11 )
    COP [82]
    BRL loc_0F9B0F
}

---------------------------------------------
; Talk handler of the dream cave dolphin.
; 
; When: the hero talks.
; Sees: flag $0506 set: 'Hey, didn't I meet you in my dream?'. Dream Rod (item $1C) not equipped: 'Zzzzz'. Equipped: '[the hero] touches the dolphin with the Dream Rod', transition type 4 and COP 10 to A07S04 at pixel ($50,$200).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F9B17 {
    COP [07] ( #$8506, &code_0F9B38 ) ; flag $0506 is set by the Big Pearl dolphin when he has taken the Pearl in the dream
    COP [19] ( #1C, &code_0F9B33 ) ; item $1C = Dream Rod, it must be equipped
    COP [01] ( &asciistring_0F9B47 )
    COP [3C] ( #04 )
    COP [10] ( #$0407, #00, #$0050, #$0200 ) ; A07S04 at pixel ($50,$200): the dream
    RTL 
}

code_0F9B33 {
    COP [01] ( &asciistring_0F9B3D )
    RTL 
}

code_0F9B38 {
    COP [01] ( &asciistring_0F9B69 )
    RTL 
}

asciistring_0F9B3D |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B47 |[10][02:2] touches [N]the dolphin with the [N]Dream Rod- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B69 |[10]Hey, didn t I meet you[N]in my dream? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; Lue the dolphin (switch $8F).
; 
; When: placement script; COP 14 until the lair $8F is released.
; Sees: COP 30 spawns code_0F9BED on the return trip; otherwise the puff and a loop of animation $0E four times, flipped and unflipped (the swimming in place); talk handler code_0F9BB5.
; Why: Lue's story explains the Blue Stone and gives the Thunder Ring (walkthrough: Seabed Sanctuary - The Thunder Ring).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_dolphin_lue_0F9B8B {
    COP [14] ( #$008F, &code_0F9B92 )
    RTL 
}

code_0F9B92 {
    COP [30] ( #$008F, &code_0F9BED, #1F )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9BB5 )

  loc_0F9BA2:
    COP [96]
    COP [81] ( #0E, #04 )
    COP [83]
    COP [97]
    COP [81] ( #0E, #04 )
    COP [83]
    BRL loc_0F9BA2
}

---------------------------------------------
; Talk handler of Lue.
; 
; When: the hero talks.
; Sees: Thunder Ring (item $24) owned: 'I heard that Dr. Leo was taken to the Magridd Castle. I wonder how he is.' Missing: code_0F9BD1.
; In: X = D = slot; the text is shown with $16 bit $0010 cleared and set again afterwards.
; Out: RTL.
; Clobbers: A.

code_0F9BB5 {
    COP [18] ( #24, &code_0F9BD1 ) ; item $24 = Thunder Ring: missing, Lue tells his story and gives it
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F9D86 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

---------------------------------------------
; Lue's story and the Thunder Ring.
; 
; When: the hero talks to Lue without the Thunder Ring.
; Sees: 'My name is Lue. I used to live with the inventor, Dr. Leo. The Blue Stone I received from him is a strange jewel. It attracts anyone who looks at it and then changes their personality. If that person has a good mind, they will become a great person. If they have a evil mind, they will become a bad person. One day, the Queen found the jewel and took it. Then she placed me in prison. Please save the Queen and get the Blue Stone back. I know this ring will help, please take it.', a sound (BRK #$5E) and COP 0A gives item $24.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F9BD1 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F9C12 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRK #$5E
    COP [0A] ( #24 )
    RTL 
}

---------------------------------------------
; One-shot actor for the return trip of the lair $8F: 'Hey, somebody help me!' (60 frame pause) unless the lair $8C (Lue's friend) is already released; then it kills itself.
; 
; In: X = D = slot of the new actor.
; Out: RTL.
; Clobbers: A.

code_0F9BED {
    COP [14] ( #$008C, &code_0F9BF7 )
    COP [01] ( &asciistring_0F9BFA )
}

code_0F9BF7 {
    COP [86]
    RTL 
}

asciistring_0F9BFA |[10][0E:3C]Hey, somebody help me![JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9C12 |[10]My name is Lue- [N]I used to live with [N]the inventor, Dr-Leo-[FIN]The Blue Stone I [N]received from him is [N]a strange jewel- [FIN]It attracts anyone who[N]looks at it and then [N]changes their [N]personality- [FIN]If that person has a [N]good mind, they will [N]become a great person-[FIN]If they have a evil [N]mind, they will become[N]a bad person- [FIN]One day, the Queen [N]found the jewel and [N]took it- Then she [N]placed me in prison- [FIN]Please save the Queen [N]and get the Blue Stone[N]back- [FIN]I know this ring will [N]help please take it- [FIN][02:2] received [N][03:24]the Thunder Ring- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9D86 |[10]I heard that Dr-Leo [N]was taken to the [N]Magridd Castle- [N]I wonder how he is- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The dolphin who tried to rescue Lue (switch $8C).
; 
; When: placement script; COP 14 until the lair $8C is released.
; Sees: COP 30 spawns code_0F9E32 on the return trip; otherwise the puff and a delay of 2 frames, then code_0F9DD7: flag $0000 clear: the friend moves to tile ($12,$0B) (COP 11 with slot 4), faces right, blocks its tiles and waits (animation $11) with the talk handler code_0F9E22.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_dolphin_lue_friend_0F9DBE {
    COP [14] ( #$008C, &code_0F9DC5 )
    RTL 
}

code_0F9DC5 {
    COP [30] ( #$008C, &code_0F9E32, #1F )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [1B] ( &code_0F9DD7, #$0002 )
}

---------------------------------------------
; The wall is opened: the butting loop of Lue's friend.
; 
; When: flag $0000 is set by code_0F9E32.
; Sees: sets return_active to $FFFF, sets flag $0601 (the wall of Lue's alcove), animation $0E nine times and $0C three times, then animation $17 with a hit sound (BRK #$4A) twice, clears return_active and repeats animation $17 and the sound forever.
; Why: walkthrough: 'apparently Lue's friend is a numbskull, for the wall has been opened!'
; In: X = D = slot.
; Out: never returns (endless loop with yields).
; Clobbers: A.

code_0F9DD7 {
    COP [07] ( #$0000, &code_0F9E0D ) ; flag $0000 clear = Lue has not called yet; set by code_0F9E32 on the return trip of lair $8C
    LDA #$FFFF
    STA $return_active
    COP [09] ( #$8601 )   ; flag $0601 = the wall of Lue's alcove is open (walkthrough); the map change itself was not traced
    COP [81] ( #0E, #09 )
    COP [83]
    COP [81] ( #0C, #03 )
    COP [83]
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    STZ $return_active

  loc_0F9E04:
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    BRA loc_0F9E04
}

code_0F9E0D {
    COP [11] ( #04, #12, #0B )
    COP [97]
    COP [15]
    COP [17] ( &code_0F9E22 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of Lue's friend: Lue's lair $8F not released: 'I tried hard to save Lue but he is not here.'; released: 'Lue told me many things about the Queen. I don't think she was a bad person. She was just attracted to the jewel.'
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F9E22 {
    COP [14] ( #$008F, &code_0F9E2D )
    COP [01] ( &asciistring_0F9E55 )
    RTL 
}

code_0F9E2D {
    COP [01] ( &asciistring_0F9E7D )
    RTL 
}

---------------------------------------------
; One-shot actor for the return trip of the lair $8C: sets flag $0000, shows 'Lue! I'm coming!' and kills itself; the friend then starts to butt the wall.
; 
; In: X = D = slot of the new actor.
; Out: RTL.
; Clobbers: A.

code_0F9E32 {
    COP [09] ( #$8000 )
    COP [01] ( &asciistring_0F9E3D )
    COP [86]
    RTL 
}

asciistring_0F9E3D |[10][0E:1E]Lue! I m coming! [0E:28][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F9E55 |[10]I tried hard to save [N]Lue but he is not [N]here- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9E7D |[10]Lue told me many [N]things about the [N]Queen- [FIN]I don t think she was [N]a bad person- She was [N]just attracted to the [N]jewel- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The gate at the Rockbird end of the seabed.
; 
; When: placement script; runs every frame.
; Sees: flag $0406 set: animation $26, tiles unblocked and done. Else the gate blocks its tiles and waits for the hero on tile ($5B,$24); then the pad is blocked, the player actors are hidden (COP 34), after 120 frames a sound and animations $26 and $27, after 90 more frames flag $0406 is set, flag $0903 cleared and COP 10 returns the hero to A06S01 at pixel ($220,$220), the tile of the Rockbird statue.
; Why: the other end of se_npc_statue_rockbird_path_0F8A7E.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_obj_statue_gate_rockbird_0F9ED4 {
    COP [07] ( #$8406, &code_0F9EE6 ) ; flag $0406 is set by this gate when the passage was used; the Rockbird statue reads the same flag
    COP [15]
    COP [91]
    COP [0D] ( #00, #5B, #24, &code_0F9EF0 ) ; the hero on tile ($5B,$24) starts the return to the Sanctuary
    RTL 
}

code_0F9EE6 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9EF0 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9EFE, #$0078 )
}

code_0F9EFE {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9F12, #$005A )
}

code_0F9F12 {
    COP [09] ( #$8406 )
    COP [09] ( #$0903 )   ; clears flag $0903: the statue trip is over
    COP [10] ( #$0106, #01, #$0220, #$0220 ) ; A06S01 at pixel ($220,$220), the tile of the Rockbird statue
    RTL 
}
---------------------------------------------

; The gate at the Blester end (tile ($6A,$04), flag $0407; returns to A06S01 at pixel ($220,$1C0)). Same script as se_obj_statue_gate_rockbird_0F9ED4.
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_obj_statue_gate_blester_0F9F24 {
    COP [07] ( #$8407, &code_0F9F36 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #6A, #04, &code_0F9F40 )
    RTL 
}

code_0F9F36 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9F40 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9F4E, #$0078 )
}

code_0F9F4E {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9F62, #$005A )
}

code_0F9F62 {
    COP [09] ( #$8407 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$0220, #$01C0 ) ; A06S01 at pixel ($220,$1C0), the tile of the Blester statue
    RTL 
}
---------------------------------------------

; The gate at the Durean end (tile ($24,$2B), flag $0500; returns to A06S01 at pixel ($1C0,$220)). Same script as se_obj_statue_gate_rockbird_0F9ED4.
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_obj_statue_gate_durean_0F9F74 {
    COP [07] ( #$8500, &code_0F9F86 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #24, #2B, &code_0F9F90 )
    RTL 
}

code_0F9F86 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9F90 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9F9E, #$0078 )
}

code_0F9F9E {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9FB2, #$005A )
}

code_0F9FB2 {
    COP [09] ( #$8500 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$01C0, #$0220 ) ; A06S01 at pixel ($1C0,$220), the tile of the Durean statue
    RTL 
}
---------------------------------------------

; The gate at the ghost ship end (tile ($14,$04), flag $0501; returns to A06S01 at pixel ($1C0,$1C0)). Same script as se_obj_statue_gate_rockbird_0F9ED4.
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_obj_statue_gate_ghost_ship_0F9FC4 {
    COP [07] ( #$8501, &code_0F9FD6 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #14, #04, &code_0F9FE0 )
    RTL 
}

code_0F9FD6 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9FE0 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9FEE, #$0078 )
}

code_0F9FEE {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0FA002, #$005A )
}

code_0FA002 {
    COP [09] ( #$8501 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$01C0, #$01C0 ) ; A06S01 at pixel ($1C0,$1C0), the tile of the ghost ship statue
    RTL 
}
---------------------------------------------

; The dolphin of the Big Pearl in the dream.
; 
; When: placement script of the dream scene.
; Sees: talk handler code_0FA159; tiles blocked and animation $10 until flag $0506 is set by the talk; then the pad is blocked, the dolphin swims (animation $0D, 4 repeats) and the pad is released; then it waits (animation $10) for the switch $79, the green switch under it; when it is set the pad is blocked, animation $10 twice, transition type 4 and COP 10 to A07S03 at pixel ($40,$80).
; Why: walkthrough Seabed Sanctuary - Path Opening: 'speak with the dolphin with the Big Pearl item equipped and use the switch that was beneath him to open the path to this rather secret cave'.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_dolphin_big_pearl_0FA106 {
    COP [17] ( &code_0FA159 )
    COP [15]

  code_0FA10C:
    COP [80] ( #10 )
    COP [82]
    COP [07] ( #$0506, &code_0FA10C ) ; flag $0506 is set by the talk handler once the Pearl was given
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #0D, #04 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]

  loc_0FA12D:
    COP [14] ( #$0079, &code_0FA13A ) ; switch $79 = the green switch of the lair under the dolphin
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FA12D
}

code_0FA13A {
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #10, #02 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$0307, #02, #$0040, #$0080 )
    RTL 
}

---------------------------------------------
; Talk handler of the Big Pearl dolphin.
; 
; When: the hero talks.
; Sees: Big Pearl (item $20) not equipped: code_0FA16E ('I used to live here. I am trying to remember something but I cannot. When I close my eyes, I see something like a ball, shiny and black.', then COP 10 to A07S03 at pixel ($40,$70)). Equipped: 'That Pearl! Yes, I was going to present that Pearl. This is the Coral Reef. I have missed this place.', COP 0B takes the Pearl away, the talk handler becomes code_0FA17F (the same text from its marker) and flag $0506 is set.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0FA159 {
    COP [19] ( #20, &code_0FA16E ) ; item $20 = Big Pearl, it must be equipped
    COP [01] ( &asciistring_0FA1E9 )
    COP [0B] ( #20 )
    COP [17] ( &code_0FA17F )
    COP [09] ( #$8506 )
    RTL 
}

code_0FA16E {
    COP [01] ( &asciistring_0FA184 )
    COP [3C] ( #04 )
    COP [10] ( #$0307, #00, #$0040, #$0070 )
    RTL 
}

code_0FA17F {
    COP [01] ( &asciistring_0FA237 )
    RTL 
}

asciistring_0FA184 |[10]I used to live [N]here- [FIN]I am trying to [N]remember something but[N]I cannot- [FIN]When I close my eyes, [N]I see something like [N]a ball, shiny and [N]black---- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA1E9 |[10]That Pearl! [FIN]Yes, I was going to [N]present that Pearl- [FIN][::]This is the Coral [N]Reef- I have missed [N]this place- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA237 |[10][JMP:&asciistring_0FA1E9+M]|
---------------------------------------------

; A fairy gem that pays 300 EXP (switch $7F, flag $1D06).
; 
; When: placement script; COP 14 until the lair $7F is released.
; Sees: JSL cm_npc_fairy_gem_setup_01B161 (the shared fairy setup), the talk handler code_0FA4AF, then the idle loop of w2_shared_0FA945 through a pushed return address.
; Why: the walkthrough lists the Yellow Seahorse lair that releases a Fairy Gem with 300 EXP.
; In: X = D = slot.
; Out: RTL into w2_obj_fairy_idle_loop_0FA945.
; Clobbers: A, Y.

se_npc_fairy_exp_300_0FA494 {
    COP [14] ( #$007F, &code_0FA49B )
    RTL 
}

code_0FA49B {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_0FA4AF )
    SEP #$20
    LDA #$^w2_shared_0FA945.w2_obj_fairy_idle_loop_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.w2_obj_fairy_idle_loop_0FA945-1
    PHA 
    RTL 
}

---------------------------------------------
; Talk handler of the 300 EXP fairy: when flag $1D06 is clear the standard text asciistring_0FA9C5 is shown, 300 EXP are queued (COP 38, BCD $0300) and the flag is set; then in every case the return prompt of se_st_elles_coast_actors (se_npc_fairy_return_prompt_0FA46D).
; 
; In: X = D = slot.
; Out: BRL into the return prompt.
; Clobbers: A.

code_0FA4AF {
    COP [07] ( #$9D06, &se_st_elles_coast_actors.se_npc_fairy_return_prompt_0FA46D ) ; flag $1D06: the 300 EXP were already paid
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 )
    COP [38] ( #$0300 )   ; 300 EXP in BCD
    COP [09] ( #$9D06 )
    BRL se_st_elles_coast_actors.se_npc_fairy_return_prompt_0FA46D
}
---------------------------------------------

; A fairy gem that pays 250 EXP (switch $7A, flag $1D07). Same script as se_npc_fairy_exp_300_0FA494 with $0250 and its own flag.
; 
; In: X = D = slot.
; Out: RTL into w2_obj_fairy_idle_loop_0FA945.
; Clobbers: A, Y.

se_npc_fairy_exp_250_0FA4C4 {
    COP [14] ( #$007A, &code_0FA4CB )
    RTL 
}

code_0FA4CB {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_0FA4DF )
    SEP #$20
    LDA #$^w2_shared_0FA945.w2_obj_fairy_idle_loop_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.w2_obj_fairy_idle_loop_0FA945-1
    PHA 
    RTL 
}

code_0FA4DF {
    COP [07] ( #$9D07, &se_st_elles_coast_actors.se_npc_fairy_return_prompt_0FA46D ) ; flag $1D07: the 250 EXP were already paid
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 )
    COP [38] ( #$0250 )   ; 250 EXP in BCD
    COP [09] ( #$9D07 )
    BRL se_st_elles_coast_actors.se_npc_fairy_return_prompt_0FA46D
}
---------------------------------------------

; The current of the seabed.
; 
; When: placement script of the scene with the current; runs once.
; Sees: sets push_zone_list to unk16_0FA5AE and push_zone_bank to its bank, then kills itself; the engine pushes the hero while he stands in a zone.
; Why: walkthrough: 'a powerful water current. The current will push you westward regardless of what you do - you can only slow it by holding Right on the D-Pad.'
; In: X = D = slot; the 8-bit accumulator is used for the bank.
; Out: RTL after COP 86.
; Clobbers: A, Y.

se_obj_water_current_0FA59C {
    SEP #$20
    LDY #$&unk16_0FA5AE
    STY $push_zone_list
    LDA #$^unk16_0FA5AE
    STA $push_zone_bank
    REP #$20
    COP [86]
    RTL 
}
---------------------------------------------

; The two push zones of the current: records of (tile x from, tile x to, tile y from, tile y to, push x, push y) = ($32,$7B,$0B,$16,-4,0) and ($7B,$7D,$0E,$16,-4,0), the push being a word of -4 (west) with no vertical component. The field meaning is read from the current's behaviour and the walkthrough; not verified in the push code.

unk16_0FA5AE [
  unk16 < #32, #7B, #0B, #16, #$FFFC, #$0000 >   ;00
  unk16 < #7B, #7D, #0E, #16, #$FFFC, #$0000 >   ;01
]
---------------------------------------------

; The oxygen rule of the seabed.
; 
; When: runs every frame in the underwater scenes; idle (COP 91 and RTL) while flag $0903 is set, i.e. during a statue trip.
; Sees: Bubble Armor (item $0B) not equipped: code_0FA697, 1 HP of damage every 64 frames (COP 39). Equipped: the bubble dome actor is spawned (COP B0) and each frame moved onto the hero (x, y - 4); every 256 frames a rising bubble is spawned (COP AF). If the armor is taken off the dome's $14 is cleared (code_0FA68A) and the rule starts again.
; Why: the Bubble Armor lets the hero walk freely underwater; it is not necessary (walkthrough: Bubble Armor notes), the water only costs 1 HP per 64 frames.
; In: X = D = slot; Y = the dome actor ($3E, the previous actor link).
; Out: RTL.
; Clobbers: A, Y.

se_effect_underwater_breath_0FA64B {
    COP [91]
    COP [07] ( #$8903, &code_0FA6A6 )
    COP [19] ( #0B, &code_0FA697 ) ; item $0B = Bubble Armor: not equipped, the hero is drowning
    COP [B0] ( @se_effect_air_bubble_dome_0FA6A9, #$0310 )
    COP [91]
    COP [19] ( #0B, &code_0FA68A )
    LDY $003E, X
    LDA $player_x
    STA $0000, Y
    LDA $player_y
    SEC 
    SBC #$0004
    STA $0002, Y
    LDA $frame_counter    ; every 256 frames (frame_counter low byte zero) a rising bubble is spawned
    AND #$00FF
    BEQ loc_0FA682
    RTL 

  loc_0FA682:
    COP [AF] ( @se_effect_air_bubble_rising_0FA6CB, #$2040 )
    RTL 
}

code_0FA68A {
    LDY $003E, X
    LDA #$0000
    STA $0014, Y
    COP [27] ( &se_effect_underwater_breath_0FA64B )
}

---------------------------------------------
; The drowning branch of the oxygen rule: when the frame counter AND $3F is zero COP 39 takes 1 HP; then COP 27 returns to the start of se_effect_underwater_breath_0FA64B.
; 
; In: X = D = slot.
; Out: yields through COP 27.
; Clobbers: A.

code_0FA697 {
    LDA $frame_counter
    AND #$003F
    BNE loc_0FA6A2
    COP [39] ( #01 )      ; 1 HP of damage every 64 frames without the Bubble Armor

  loc_0FA6A2:
    COP [27] ( &se_effect_underwater_breath_0FA64B )
}

code_0FA6A6 {
    COP [91]
    RTL 
}

---------------------------------------------
; The air bubble around the hero.
; 
; When: spawned by the oxygen rule when the Bubble Armor is equipped.
; Sees: drawn in front (COP A3), priority $30, animation $24; it waits in a loop with COP 82 and kills itself when the armor is no longer equipped (COP 19).
; In: X = D = slot of the new actor.
; Out: RTL after COP 86 in code_0FA6C8.
; Clobbers: A.

se_effect_air_bubble_dome_0FA6A9 {
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0024
    STA $001E, X
    STZ $0020, X
    JSL $@engine_scheduler_sprites_combat_collision.SetActorAnimFrame
    COP [A3]
    COP [91]

  loc_0FA6BF:
    COP [19] ( #0B, &code_0FA6C8 )
    COP [82]
    BRA loc_0FA6BF
}

code_0FA6C8 {
    COP [86]
    RTL 
}

---------------------------------------------
; A small bubble that rises from the hero.
; 
; When: spawned every 256 frames by the oxygen rule.
; Sees: starts at the hero's x + 4 and y - $10, animation $22, plays once and kills itself.
; In: X = D = slot of the new actor.
; Out: RTL.
; Clobbers: A.

se_effect_air_bubble_rising_0FA6CB {
    COP [A3]
    COP [A2] ( #30 )
    LDA $player_x
    CLC 
    ADC #$0004
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0010
    STA $0002, X
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #22 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; The water shimmer of the seabed: HDMA waves on BG1 and BG2 scroll.
; 
; When: runs every frame while the actor lives.
; Sees: builds two tables of 14 entries of $90 (16 lines) at $7E7000 and $7E7800 that point at $7E7100 and $7E7900; each frame fills 16 words in each from word_0FA905 (+1 / 0 / -1 / 0 wave, phase = frame / 4 + scroll_bg1_y / 2) plus scroll_bg1_x / 2 and scroll_bg1_y / 2 respectively, and queues the tables on channels $0D and $0E with QueueHdmaIndirect.
; In: X = D = slot; DP $16 and $18 are scratch.
; Out: RTL; X and DBR restored.
; Clobbers: A, Y, DP $16 / $18.

se_effect_seabed_wave_hdma_0FA874 {
    PHX 
    LDX #$0000

  loc_0FA878:
    LDA #$0090
    STA $7E7000, X
    STA $7E7800, X
    LDA #$7100
    STA $7E7001, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$002A
    BNE loc_0FA878
    LDA #$0000
    STA $7E7000, X
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    LDA $scroll_bg1_x
    LSR 
    STA $16
    LDA $scroll_bg1_y
    LSR 
    STA $18
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $18
    AND #$000F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 

  loc_0FA8CB:
    LDA $@word_0FA905, X
    CLC 
    ADC $16
    STA $7100, Y
    LDA $@word_0FA905, X
    CLC 
    ADC $18
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0020
    BNE loc_0FA8CB
    PLB 
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

; The wave of se_effect_seabed_wave_hdma_0FA874: 32 words, four 0, four 1, four 0, four -1 twice (a 16 step period of -1 / 0 / +1 pixels, listed twice so that the index can start anywhere).

word_0FA905 [
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