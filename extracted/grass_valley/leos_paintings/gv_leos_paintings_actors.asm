; The actors of the dream tulip scene and the Leo's Paintings scenes (file offsets 107440-111275, bank 03): gv_npc_tulip_dream_01A3B0 (type $2A, the tulip's dream, scene A03S04) and its fairy gem gv_npc_fairy_metal_hint_01AD42, the BG2 drift actor gv_obj_bg2_scroll_drift_01B21A (type $08, every Leo's Paintings scene) and the colour gradient gv_fx_hdma_gradient_01B273 (type $0A) with its table gv_hdma_gradient_table_01B284.
; 
; === THE TULIP'S DREAM ===
; The sleeping tulip of the village that sat on the Clubhouse Pass (gv_village_actors_019475) can be entered with the Dream Rod (walkthrough: 'if you want, you can use the Dream Rod on it'). The dream tulip is registered under switch $22, the lair record of Leo's Paintings 3 (location 9, tile ($1A,$08), the Purple Birds' lair of the walkthrough) that also frees the village tulip and the boy of the secret hut. Talk: 'In my dreams I can do anything I like. For example...' 'HA!' and a gem with a fairy appears at (x $70, y $80) (COP AC with flags $50, sound $1C); later talks answer 'Why don't you try and talk to the jewelry?'. The fairy tells that the monsters in the paintings 'cannot be defeated unless you have a special sword', 'the special sword that can destroy metal' and to return when it has been found, then offers the return to Grass Valley (ReturnToGrassValleyPrompt in gv_underground_castle_actors). The walkthrough: any monster with the 'metal' attribute cannot be defeated until the Zantetsu Sword is obtained later in the game.
; 
; === BACKGROUND AND COLOUR ===
; Type $08 moves itself by (-8, -8) plus scroll_delta every frame and copies the position to the BG2 scroll registers (a fast drift of the second layer). Type $0A queues the HDMA table gv_hdma_gradient_table_01B284 for PPU register $2132 (the fixed-colour COLDATA): the first 7 lines with $F2, then 18 bands of 12 lines from $F1 down to $E0; the value is all three colour channels (bits 7-5) with an intensity of 18 falling to 0.
; 
; === NOTES ===
; - Which painting backgrounds use the BG2 drift and how fast it looks was not checked in the emulator (OQ-I034-7).
---------------------------------------------

?BANK 03

?INCLUDE 'gv_underground_castle_actors'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'

!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!scroll_delta_x                 0382
!scroll_delta_y                 0384

---------------------------------------------

; The tulip of the tulip's dream.
; 
; When: meta type $2A in scene A03S04 (location $0A, the tulip's dream), tile ($0C,$04); registered under switch $22 (the Leo's Paintings 3 lair record, see the block note).
; Sees: 'In my dreams I can do anything I like. For example---- HA!' and a fairy gem pops up; afterwards 'Why don't you try and talk to the jewelry?'. It plays animation $1E for ever.
; Why: the dream only carries the hint about the metal sword (given by the fairy).
; In: actor script, X = own slot.
; Out: RTL after COP 14; the first text is followed by COP AC (gv_npc_fairy_metal_hint_01AD42 at x $70, y $80) and BRK $1C.
; Clobbers: A.

gv_npc_tulip_dream_01A3B0 {
    COP [14] ( #$0022, &code_01A3B7 )
    RTL 
}

code_01A3B7 {
    COP [17] ( &code_01A3D5 )
    COP [15]

  loc_01A3BD:
    COP [80] ( #1E )
    COP [82]
    BRL loc_01A3BD

  code_01A3C5:
    COP [AC] ( @gv_npc_fairy_metal_hint_01AD42, #$0070, #$0080, #$0050 )
    BRK #$1C
    BRL loc_01A3BD
}

code_01A3D5 {
    COP [01] ( &asciistring_01A3E6 )
    COP [17] ( &code_01A3E1 )
    COP [27] ( &code_01A3C5 )
}

code_01A3E1 {
    COP [01] ( &asciistring_01A420 )
    RTL 
}

asciistring_01A3E6 |[10]In my dreams I can [N]do anything I like-[N]For example---- [FIN]HA! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A420 |[10]Why don t you try and [N]talk to the jewelry? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The fairy of the tulip's dream: it explains the metal monsters.
; 
; When: spawned by gv_npc_tulip_dream_01A3B0.
; Sees: 'The monsters running all over in Dr-Leo's paintings cannot be defeated unless you have a special sword. You must find the special sword that can destroy metal. Return here once you have found the sword.' then the return prompt.
; Why: the shared fairy setup (shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161, then the idle loop cm_npc_fairy_gem_idle_01B17C entered through a pushed return address); the ending is the common return prompt of the fairies.
; In: actor script, X = own slot.
; Out: talk handler code_01AD56 ends in BRL ReturnToGrassValleyPrompt.
; Clobbers: A.

gv_npc_fairy_metal_hint_01AD42 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01AD56 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

code_01AD56 {
    COP [01] ( &asciistring_01AD5D )
    BRL gv_underground_castle_actors.ReturnToGrassValleyPrompt
}

asciistring_01AD5D |[10]The monsters running [N]all over in Dr-Leo s [N]paintings [FIN]cannot be defeated [N]unless you have a [N]special sword- [FIN]You must find the [N]special sword that can[N]destroy metal- [FIN]Return here once you [N]have found the sword- [FIN][END]|
---------------------------------------------

; Drifts the second background layer by (-8, -8) per frame.
; 
; When: meta type $08, every frame; placed in every Leo's Paintings scene.
; Sees: a moving background layer.
; Why: as gv_obj_bg2_scroll_drift_01B1F7, with a different step.
; In: actor script, X = own slot, M = 16 bits. Reads scroll_delta_x, scroll_delta_y.
; Out: $00,X += -8 + scroll_delta_x, $02,X += -8 + scroll_delta_y; both copied to scroll_bg2_x / scroll_bg2_y.
; Clobbers: A.

gv_obj_bg2_scroll_drift_01B21A {
    LDA $0000, X
    SEC 
    SBC #$0008
    CLC 
    ADC $scroll_delta_x
    STA $0000, X
    STA $scroll_bg2_x
    LDA $0002, X
    SEC 
    SBC #$0008
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}
---------------------------------------------

; Starts the fixed-colour gradient of a painting.
; 
; When: meta type $0A, once per Leo's Paintings scene.
; Sees: a fixed-colour gradient from the top to the bottom of the screen.
; Why: QueueHdmaDirect takes the table and the PPU register, so the actor only names them.
; In: actor script, X = own slot.
; Out: gv_hdma_gradient_table_01B284 is queued for register $2132 (A = $32 in the high byte, bank and address in A and Y); the processor flags are saved with PHP / PLP.
; Clobbers: A, Y.

gv_fx_hdma_gradient_01B273 {
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^gv_hdma_gradient_table_01B284
    LDY #$&gv_hdma_gradient_table_01B284
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLP 
    RTL 
}
---------------------------------------------

; HDMA table of the painting gradient: COLDATA values $F2 down to $E0.
; 
; When: queued by gv_fx_hdma_gradient_01B273.
; Sees: the fixed colour slides from intensity 18 to 0.
; Why: data.
; In: n/a (data). Line count $07 with $F2, then 18 bands of $0C lines with $F1 ... $E0, end $00.
; Out: n/a.
; Clobbers: n/a.

gv_hdma_gradient_table_01B284 #07F20CF10CF00CEF0CEE0CED0CEC0CEB0CEA0CE90CE80CE70CE60CE50CE40CE30CE20CE10CE000