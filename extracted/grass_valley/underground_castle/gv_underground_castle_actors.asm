; The actors of the Underground Castle (area 2) and its shared fairy return prompt (file offsets 107584-111418, bank 03): Lisa in her dream (A02S03), the three fairies of the castle, the elevator (two sprites and a rider) and the colour gradient. The fairies share their setup with the other fairies of the game (shared_actor_helpers_bank3).
; 
; === LISA'S DREAM ===
; gv_npc_lisa_dream_01A440 (type $2B, scene A02S03, switch $10 of Lisa) is entered by using the Dream Rod on the sleeping Lisa (gv_village_actors_018000; walkthrough: 'speak with her to enter her dream'). She says 'Daddy, where are you?!'. Lair record $32 (location $0E, tile ($0F,$36), no spawn handler) is the switch of the dream room (walkthrough: 'trigger the switch nearby'): when it is set a voice says 'Lisa, you must tell everything that you know to the person in front of you. They will also need my paintbrush to continue on', Lisa answers 'Daddy! Is that you?' and, talked to again, 'Who are you? Why am I here?' sets flag $0104 and returns the hero to the village (area 1 scene 1, at x $3B0, y $1E0). After the ending (event flag $1F02 set by RunEnding) the same actor runs the epilogue dream: Lisa asks the hero to promise to return someday (a one-answer menu), says 'Thank you. I wish this dream would never end', flag $1F01 is set, scene_variant = 3 and the hero returns to the village at x $3B0, y $1D8, where Lisa starts the ending (gv_village_actors_018000).
; 
; === FAIRIES ===
; Three fairies share the return prompt: gv_npc_fairy_exp_30_01AC32 (type $39, A02S01) and gv_npc_fairy_heart_of_castle_01ADF8 (type $5C, A02S02) in this file, and gv_npc_fairy_metal_hint_01AD42 (spawned in the tulip's dream) in gv_leos_paintings_actors. Each talk ends in ReturnToGrassValleyPrompt: 'Would you like to return to Grass Valley?' with the shared Stay / Go back menu; Stay prints 'Come back whenever you feel like returning to Grass Valley'; Go back prints 'Allright, please continue' (the text is as in the ROM, OQ-I034-9), increments contact_lock and warps to the village (area 1 scene 1, x $138, y $3A0). The walkthrough: 'speak with the fairy in the blue gem nearby to return to Grass Valley'.
; 
; === THE ELEVATOR ===
; Types $30 / $31 are both placed at tile ($47,$38) in A02S01. Both wait for flag $0404 (the water mill wheel was turned, gv_village_actors_018000); until then the first one says 'I am an elevator invented by Dr-Leo. I cannot move unless the water mill is turning.' when the hero stands on that tile. With the flag set, standing on the lower tile (y $38) and pressing Up plays animation $2A ($2B for the platform), 20 repeats; at the upper tile (y $33) Down plays $2C ($2D). The platform actor ($31, drawn behind) spawns the rider gv_obj_elevator_ride_01AFB9 on each press; the rider locks the input for 81 frames, copies the Y of its spawner to the hero and his weapon and plays a sound every fourth frame (static reading, OQ-I034-6). A hero that is already at x >= $04B0 when the flag is set finds the elevator moved up by $50 pixels.
; 
; === NOTES ===
; - Type $2D (gv_fx_hdma_gradient_01B23D) queues gv_hdma_gradient_table_01B24E for register $2132: 127 lines and 32 lines of $E0 (intensity 0), then 16 bands of 4 lines from $E1 to $F0 (intensity 1 to 16).
; - asciistring_01B2AB ('I am watching over the world. Please take this. <name> received EXP!') is referenced by nothing; the advice text of FairyAdviceAndExp jumps into gv_watching_over_world_texts.asciistring_01ABB9, the same sentence (OQ-I034-8).
; - The Underground Castle scenes also place the palette-cycle types $02-$05 and $3E (shared palette actors) and, in A02S01-S02, the enemy types $24 / $25 (gv_underground_castle_enemies).
---------------------------------------------

?BANK 03

?INCLUDE 'data_engine_tables'
?INCLUDE 'gv_watching_over_world_texts'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!frame_counter                  0312
!scene_variant                  031E
!joy_pressed                    0322
!joy_block_mask                 0326
!player_actor                   039C
!player_weapon_actor            039E
!contact_lock                   042D

---------------------------------------------

; Lisa inside her dream, and the epilogue dream after the ending.
; 
; When: meta type $2B in A02S03 (Lisa's dream, location $0E), tile ($0F,$32); registered under switch $10 (the same record as Lisa in the village); the room's own switch is $32.
; Sees: 'Daddy, where are you?!'. After the switch: the voice 'Lisa, you must tell everything that you know to the person in front of you. They will also need my paintbrush to continue on', Lisa's short animations ($21 twice, $22), 'Daddy! Is that you? Where are you daddy?! I miss you so much. There was no answer.' and, when talked to, 'Who are you? Why am I here?' and the return to the village (flag $0104, transition type 4). With flag $1F02 set: the long speech ('I thought I would meet you here. I am all alone ... only promise me you will return someday ... Please promise me that you will one day return'), a Yes-only menu, 'Thank you. I wish this dream would never end', flag $1F01, scene_variant 3 and the return to the village.
; Why: the dream is one actor with two uses: the story of the first visit and, after the ending, the promise that leads to the epilogue.
; In: actor script, X = own slot (the position is moved 24 pixels right in the epilogue by COP 9F).
; Out: RTL after COP 14; with the switch set the actor plays animation $1F when the hero stands at tile ($12,$35). joy_block_mask is set and cleared around the cut scenes ($2F80 and $BFC0).
; Clobbers: A.

gv_npc_lisa_dream_01A440 {
    COP [14] ( #$0010, &code_01A447 )
    RTL 
}

code_01A447 {
    COP [07] ( #$9F02, &code_01A491 ) ; event flag $1F02 (set by RunEnding): the epilogue dream
    COP [17] ( &code_01A4DF )
    COP [15]
    COP [91]
    COP [14] ( #$0032, &code_01A45C ) ; switch $32 is the green switch of the dream room (a record without monsters)
    RTL 
}

code_01A45C {
    COP [01] ( &asciistring_01A521 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #21, #02 )
    COP [83]
    COP [80] ( #22 )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [01] ( &asciistring_01A59F )
    COP [17] ( &code_01A4E4 )
    COP [91]
    COP [0D] ( #00, #12, #35, &code_01A489 )
    RTL 
}

code_01A489 {
    COP [80] ( #1F )
    COP [82]
    COP [91]
    RTL 
}

code_01A491 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [9F] ( #$0018 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_01A604 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesOnlyText, #01, &code_01A4B1 )
}

code_01A4B1 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [01] ( &asciistring_01A77E )
    COP [03] ( #B5 )
    COP [04]
    COP [09] ( #$9F01 )   ; event flag $1F01: Lisa has her promise; the village Lisa starts the ending
    LDA #$0003
    STA $scene_variant
    COP [3C] ( #04 )
    COP [10] ( #$0101, #01, #$03B0, #$01D8 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_01A4DF {
    COP [01] ( &asciistring_01A50A )
    RTL 
}

code_01A4E4 {
    COP [01] ( &asciistring_01A5E9 )
    COP [09] ( #$8104 )   ; flag $0104: the dream was visited (Lisa shouts at the hero in the village)
    COP [3C] ( #04 )
    COP [10] ( #$0101, #03, #$03B0, #$01E0 )
    RTL 
}
---------------------------------------------

asciistring_01A50A |[10]Daddy, where are you?![JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A521 |[10]A voice, full of [N]sadness, came from [N]somewhere- [FIN]"Lisa, you must tell [N]everything that you [N]know to the person in [N]front of you- [FIN]They will also need my[N]paintbrush to continue[N]on-ˮ [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A59F |[10]Daddy! Is that you? [FIN]Where are you daddy?! [N]I miss you so [N]much----- [FIN][0F]There was no answer- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A5E9 |[10]Who are you? [N]Why am I here? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A604 |[10][0F][02:2], [N][0E:3C]I thought I would meet[N]you here- [N][0E:78]I am all alone- [N][0E:1E]I know that as time [N]passes I will stop [N]feeling lonely- [N][0E:5A]My father used to tell[N]me the key to [N]happiness lies in [N]patience not in haste-[N][0E:5A]I don t know whether [N]you are an angel or [N]human, but I must ask [N]you to do me a favor- [N][0E:5A]I will not ask you to [N]stay with me, [N][0E:5A]only promise me you [N]will return someday- [N][0E:5A]You could tell me a [N]lie, [0E:1E]but I feel our [N]promise will give me [N]hope for the future- [N][0E:5A]Please! [0E:28]Please promise[N]me that you will one [N]day return- [END]|

asciistring_01A77E |[0F]Thank you- [N][0E:5A]I wish this dream [N]would never end- [0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|
---------------------------------------------

; The fairy of Underground Castle west: 30 EXP and the way home.
; 
; When: meta type $39 in A02S01 (tile ($09,$21)); registered under switch $04 (lair record $04: location 5, tile ($06,$24)).
; Sees: it idles with animation 7 until the switch is set; then, once (flag $0505), '<name> heard a faint voice coming from the jewel in the < corner. Allright, come over here.' and the shared idle loop. The talk handler FairyAdviceAndExp is set from the start. The walkthrough lists '30 EXP' as a treasure of this region.
; Why: the fairy uses the shared setup shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161 and idle loop cm_npc_fairy_gem_idle_01B17C.
; In: actor script, X = own slot.
; Out: talk handler FairyAdviceAndExp.
; Clobbers: A.

gv_npc_fairy_exp_30_01AC32 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &FairyAdviceAndExp )

  loc_01AC3A:
    COP [14] ( #$0004, &code_01AC47 )
    COP [80] ( #07 )
    COP [82]
    BRA loc_01AC3A
}

code_01AC47 {
    COP [07] ( #$8505, &code_01AC5E )
    COP [09] ( #$8505 )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_01AC73 )
}

code_01AC5E {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

asciistring_01AC73 |[10][02:2] heard a [N]faint voice coming [N]from the jewel in the [N]< corner- [FIN]Allright, come over [N]here- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01ACBA |[10]I will give you some [N]advice- [FIN]Don t forget to equip [N]the things that you [N]wish to use or they [N]will not work- [FIN][JMP:&gv_watching_over_world_texts.asciistring_01ABB9+M]|

---------------------------------------------
; Talk handler of the first Underground Castle fairy: advice, 30 EXP once, then the return prompt.
; 
; When: the hero talks to gv_npc_fairy_exp_30_01AC32.
; Sees: 'I will give you some advice. Don't forget to equip the things that you wish to use or they will not work.' followed by 'I am watching over the world. Please take this. <name> received EXP!' (the advice string jumps into gv_watching_over_world_texts); from the second talk on only the prompt.
; Why: the flag $1C02 makes the gift one-time.
; In: actor script context, X = own slot.
; Out: with flag $1C02 clear: the text, 30 EXP queued (COP 38, BCD $0030), flag $1C02 set, then falls into ReturnToGrassValleyPrompt.
; Clobbers: A.

FairyAdviceAndExp {
    COP [07] ( #$9C02, &ReturnToGrassValleyPrompt )
    COP [01] ( &asciistring_01ACBA )
    COP [38] ( #$0030 )   ; 30 EXP in BCD, once (flag $1C02 below)
    COP [09] ( #$9C02 )
}
---------------------------------------------

; The Fairy Gem prompt of Grass Valley: 'Would you like to return to Grass Valley?'.
; 
; When: the talk handler of the three Underground Castle and Leo's Paintings fairies ends here.
; Sees: the shared Stay / Go back menu. Stay (and the cancel pointer): 'Come back whenever you feel like returning to Grass Valley'. Go back: 'Allright, please continue' (as printed, OQ-I034-9) and the hero reappears in the village.
; Why: all fairies of this world share one prompt.
; In: actor script context (a text and menu run through COP 01 / COP 1A, so X = own slot).
; Out: L_choice_result ($03D0) = 1: the 'Allright' text, contact_lock + 1 and COP 10 to area 1 scene 1 (arrival parameter 0, x $138, y $3A0); 0 or cancel: the Stay text (code_01AD3D).
; Clobbers: A.

ReturnToGrassValleyPrompt {
    COP [01] ( &asciistring_01B2D2 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_01AD3D ) ; shared Stay / Go back menu (ChoiceStayGoBackText): 0 = Stay, 1 = Go back
    LDA $L_choice_result
    BEQ code_01AD3D
    COP [01] ( &asciistring_01B2F5 )
    INC $contact_lock
    COP [10] ( #$0101, #00, #$0138, #$03A0 )
    RTL 
}

code_01AD3D {
    COP [01] ( &asciistring_01B30E )
    RTL 
}
---------------------------------------------

; The fairy at the heart of the Underground Castle (east).
; 
; When: meta type $5C in A02S02 (tile ($20,$36)); no switch.
; Sees: 'This is the heart of the Underground Castle. You may meet many monsters that cannot be defeated with that sword. You will be able to save those creatures once you return with the correct sword.' and the return prompt.
; Why: the metal monsters (Zantetsu Sword) are the reason to come back later; the shared fairy setup is used.
; In: actor script, X = own slot.
; Out: talk handler code_01AE0C ends in BRL ReturnToGrassValleyPrompt.
; Clobbers: A.

gv_npc_fairy_heart_of_castle_01ADF8 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01AE0C )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

code_01AE0C {
    COP [01] ( &asciistring_01AE13 )
    BRL ReturnToGrassValleyPrompt
}

asciistring_01AE13 |[10]This is the heart [N]of the Underground [N]Castle- [FIN]You may meet many [N]monsters that cannot [N]be defeated with that [N]sword- [FIN]You will be able to [N]save those creatures [N]once you return with [N]the correct sword- [FIN][END]|
---------------------------------------------

; The elevator of Underground Castle west (first sprite): it speaks and moves up and down when the water mill turns.
; 
; When: meta type $30 in A02S01, column x $47.
; Sees: before the wheel is turned (flag $0404): 'I am an elevator invented by Dr-Leo. I cannot move unless the water mill is turning.' when the hero stands on the lower tile ($47,$38). After: Up on the lower tile plays animation $2A (20 repeats) and the elevator goes to the upper tile ($47,$33); Down there plays animation $2C.
; Why: the elevator is two actors (this one and gv_obj_elevator_platform_01AF5C, which is drawn behind); only this one talks.
; In: actor script, X = own slot.
; Out: waits on COP 0D for the hero's tile and on the pad (joy_pressed $0800 Up, $0400 Down).
; Clobbers: A, Y (= player_actor).

gv_obj_elevator_01AE99 {
    COP [A0] ( #$0002 )

  loc_01AE9D:
    COP [91]
    COP [07] ( #$8404, &code_01AEAD ) ; flag $0404: the water mill wheel was turned
    COP [0D] ( #00, #47, #38, &code_01AEFA )
    RTL 
}

code_01AEAD {
    LDY $player_actor
    LDA $0000, Y
    CMP #$04B0            ; hero x >= $04B0: he is past the elevator, so the platform goes up by $50 and waits at the upper tile
    BCC code_01AEC0
    COP [A0] ( #$FFB0 )
    COP [27] ( &code_01AEDD )

  code_01AEC0:
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AECA )
    RTL 
}

code_01AECA {
    LDA $joy_pressed
    AND #$0800
    BNE loc_01AED3
    RTL 

  loc_01AED3:
    COP [81] ( #2A, #14 )
    COP [83]
    COP [27] ( &code_01AEDD )
}

code_01AEDD {
    COP [91]
    COP [0D] ( #00, #47, #33, &code_01AEE7 )
    RTL 
}

code_01AEE7 {
    LDA $joy_pressed
    AND #$0400
    BNE loc_01AEF0
    RTL 

  loc_01AEF0:
    COP [81] ( #2C, #14 )
    COP [83]
    COP [27] ( &code_01AEC0 )
}

code_01AEFA {
    COP [01] ( &asciistring_01AF0A )
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AF09 )
    BRA loc_01AE9D
}

code_01AF09 {
    RTL 
}

asciistring_01AF0A |[10]I am an elevator [N]invented by Dr-Leo- [FIN]I cannot move unless [N]the water mill is [N]turning- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The elevator of Underground Castle west (second sprite, drawn behind the hero): the part that carries him.
; 
; When: meta type $31 in A02S01; waits (COP 05) until flag $0404 is set.
; Sees: Up on the lower tile plays animation $2B, Down on the upper tile $2D, and spawns gv_obj_elevator_ride_01AFB9.
; Why: the platform is the actor whose Y the hero takes over while riding.
; In: actor script, X = own slot; COP A4 draws it behind.
; Out: the same tile and pad waits as gv_obj_elevator_01AE99.
; Clobbers: A, Y.

gv_obj_elevator_platform_01AF5C {
    COP [A4]
    COP [05] ( #$0404 )
    LDY $player_actor
    LDA $0000, Y
    CMP #$04B0
    BCC code_01AF75
    COP [A0] ( #$FFB0 )
    COP [27] ( &code_01AF97 )

  code_01AF75:
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AF7F )
    RTL 
}

code_01AF7F {
    LDA $joy_pressed
    AND #$0800
    BNE loc_01AF88
    RTL 

  loc_01AF88:
    COP [85] ( @gv_obj_elevator_ride_01AFB9 )
    COP [81] ( #2B, #14 )
    COP [83]
    COP [27] ( &code_01AF97 )
}

code_01AF97 {
    COP [91]
    COP [0D] ( #00, #47, #33, &code_01AFA1 )
    RTL 
}

code_01AFA1 {
    LDA $joy_pressed
    AND #$0400
    BNE loc_01AFAA
    RTL 

  loc_01AFAA:
    COP [85] ( @gv_obj_elevator_ride_01AFB9 )
    COP [81] ( #2D, #14 )
    COP [83]
    COP [27] ( &code_01AF75 )
}

---------------------------------------------
; The ride of the elevator: locks the hero and makes his Y follow the platform.
; 
; When: spawned by gv_obj_elevator_platform_01AF5C (COP 85) at the start of a ride.
; Sees: the hero rises or sinks with the platform for 81 frames; a rumble sound every fourth frame (BRK $63).
; Why: the hero is a separate actor, so his Y must be written every frame.
; In: actor script, X = own slot; the $3C link is the spawning platform.
; Out: input locked ($2F80) for the 81 frames; the platform's Y is stored into the hero, his weapon and (plus WeaponYOffsetByAnim of his animation) the weapon; then the lock is released and the actor kills itself.
; Clobbers: A, Y; X restored (PHX / PLX).

gv_obj_elevator_ride_01AFB9 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #51 )
    LDY $003C, X          ; the $3C link (the spawning platform): its Y is copied to the hero so that he rides with it
    LDA $0002, Y
    LDY $player_actor
    STA $0002, Y
    LDY $player_weapon_actor
    STA $0002, Y
    PHX 
    LDX $player_actor
    LDA $001E, X
    ASL 
    TAX 
    LDA $&data_engine_tables.WeaponYOffsetByAnim, X
    CLC 
    ADC $0002, Y
    STA $0002, Y
    PLX 
    LDA $frame_counter
    AND #$0003
    BNE loc_01AFF2
    BRK #$63

  loc_01AFF2:
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

; Starts the fixed-colour gradient of the Underground Castle.
; 
; When: meta type $2D, once in each of A02S01 and A02S02.
; Sees: a fixed-colour gradient over the lower part of the screen.
; Why: as gv_fx_hdma_gradient_01B273.
; In: actor script, X = own slot.
; Out: gv_hdma_gradient_table_01B24E queued for register $2132.
; Clobbers: A, Y.

gv_fx_hdma_gradient_01B23D {
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^gv_hdma_gradient_table_01B24E
    LDY #$&gv_hdma_gradient_table_01B24E
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLP 
    RTL 
}
---------------------------------------------

; HDMA table of the castle gradient: COLDATA values $E0 to $F0.
; 
; When: queued by gv_fx_hdma_gradient_01B23D.
; Sees: the fixed colour stays at $E0 for 127 + 32 lines, then steps up every 4 lines to $F0.
; Why: data.
; In: n/a (data). Line count / COLDATA value pairs ($7F $E0, $20 $E0, then $04 with $E1 ... $F0), end $00.
; Out: n/a.
; Clobbers: n/a.

gv_hdma_gradient_table_01B24E #7FE020E004E104E204E304E404E504E604E704E804E904EA04EB04EC04ED04EE04EF04F000
---------------------------------------------

asciistring_01B2AB |[10]I am watching over the[N]world- [N]Please take this- [FIN][02:2]  received [N]EXP! [FIN][END]|

asciistring_01B2D2 |[10]Would you like to [N]return to Grass [N]Valley? [END]|

asciistring_01B2F5 |Allright, please [N]continue- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01B30E |Come back [N]whenever you feel like[N]returning [N]to Grass Valley- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|