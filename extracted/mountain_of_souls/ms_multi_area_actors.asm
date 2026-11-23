; The fairy gems and the push zones of the icy areas (file offsets 138958-139089 and 139789-139912, SNES $04:9ECE-$9F51 and $04:A20D-$A288; the snow mountain actors lie between the two ranges).
; 
; === WHAT RUNS HERE ===
; - Fairy gems (types $3E and $3F): a COP 14 root that waits for a lair, sets up the gem sprite (shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161) and idles looking at the hero (shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289). The talk handler gives EXP once and then offers to go back: $3E (switch $EC, A0CS01 tile ($14,$1D)) gives 300 EXP (flag $1E00), $3F (switch $D9, A0BS04 tile ($1A,$29)) 400 EXP (flag $1D05). Texts: 'I am watching the world. Here, take this. <name> received EXP!' and 'Would you like to return to the location of the Mountain of Souls?' with the choice Stay / Go back; Go back ends with 'Good luck then.' and COP 10 to area $0A scene $01 at pixel ($01D8,$0040); Stay says 'Return to me when you are ready.' (walkthrough: the fairy gems give 300 and 400 EXP; the text wording is OQ-I037-14).
; - Push zones (type $39, placed once in A0BS01, A0BS02, A0CS02 and A0CS03): ms_obj_push_zone_setup_02220D stores the table of the current location in push_zone_list and push_zone_bank and kills itself; player_core.ScanPushZones reads the 8-byte records (x0, x1, y0, y1 tiles, then dx and dy words) every frame. All records here have dx = 0 and dy = +1 (a push south): the icy slopes that the Mushroom Shoes do not stop ('You will still slip on the slopes though.'). Tables: North slope $3E 3 zones, Aurora's Ridge $3F 2, the ice hill $46 3, Laynole $47 1.
; 
; === EVENT FLAGS ===
; $1E00 and $1D05: the gem has given its EXP (checked first, so that later visits go straight to the choice). EXP is queued with COP 38 as BCD ($0300, $0400).
; 
; === OPEN ===
; The tables carry no names in the ROM; the names come from the location ids the setup actor tests ($3E, $3F, $46, $47). The extents of the zones were read, not confirmed in the emulator (OQ-I037-11).
---------------------------------------------

?BANK 04

?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!push_zone_list                 03D8
!push_zone_bank                 03DA
!contact_lock                   042D
!location_id                    1C6A

---------------------------------------------

; Fairy gem with 300 EXP.
; 
; When: placement script (type $3E, A0CS01, tile ($14,$1D)); COP 14 returns until lair record $EC (top of Snow Mountain, Green Lizards) is released.
; Sees: code_021ED5: JSL cm_npc_fairy_gem_setup_01B161 (gem setup), COP 17 sets the talk handler code_021EE9, then the actor continues in cm_npc_fairy_gem_idle_022289 (look at the hero) through a pushed return address. The talk handler: flag $1E00 set jumps to the prompt; else the text 'I am watching the world. Here, take this. <name> received EXP!', COP 38 queues $0300 (BCD) and flag $1E00 is set, then it falls into ms_npc_fairy_return_prompt_021EFB.
; Why: the first fairy gem of the walkthrough (chapter 5).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

ms_npc_fairy_exp_300_021ECE {
    COP [14] ( #$00EC, &code_021ED5 )
    RTL 
}

code_021ED5 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_021EE9 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289-1
    PHA 
    RTL 
}

code_021EE9 {
    COP [07] ( #$9E00, &ms_npc_fairy_return_prompt_021EFB ) ; bit 15 set: jumps when flag $1E00 (EXP already given) is set, straight to the prompt
    COP [01] ( &shared_actor_helpers_bank4.asciistring_02249A )
    COP [38] ( #$0300 )   ; BCD 300 EXP queued (exp_pending)
    COP [09] ( #$9E00 )
}
---------------------------------------------

; The shared prompt of both fairy gems: stay or go back to the house.
; 
; When: after the EXP is given, or at every later talk (flag set).
; Sees: 'Would you like to return to the location of the Mountain of Souls?' and COP 1A with ChoiceStayGoBackText; choice 0 (Stay) or cancel goes to code_021F1D ('Return to me when you are ready.'); Go back shows 'Good luck then.', increments contact_lock and COP 10 to area $0A scene $01 (A0AS01) at pixel ($01D8,$0040).
; Why: a free ride back to the house from the deep areas.
; In: X = D = slot of the gem; also reached by BRL from the 400 EXP gem.
; Out: RTL.
; Clobbers: A.

ms_npc_fairy_return_prompt_021EFB {
    COP [01] ( &shared_actor_helpers_bank4.asciistring_0224C2 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_021F1D )
    LDA $L_choice_result
    BEQ code_021F1D
    COP [01] ( &shared_actor_helpers_bank4.asciistring_0224F4 )
    INC $contact_lock
    COP [10] ( #$010A, #00, #$01D8, #$0040 ) ; area $0A scene $01 = A0AS01, the Soul of Mountain House
    RTL 
}

code_021F1D {
    COP [01] ( &shared_actor_helpers_bank4.asciistring_022507 )
    RTL 
}
---------------------------------------------

; Fairy gem with 400 EXP.
; 
; When: placement script (type $3F, A0BS04, tile ($1A,$29)); COP 14 until lair record $D9 (passage to Lune, Green Blobs).
; Sees: the same as ms_npc_fairy_exp_300_021ECE with flag $1D05 and BCD $0400; the handler code_021F3D ends in BRL to ms_npc_fairy_return_prompt_021EFB.
; Why: the second fairy gem of the walkthrough.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

ms_npc_fairy_exp_400_021F22 {
    COP [14] ( #$00D9, &code_021F29 )
    RTL 
}

code_021F29 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_021F3D )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289-1
    PHA 
    RTL 
}

code_021F3D {
    COP [07] ( #$9D05, &ms_npc_fairy_return_prompt_021EFB )
    COP [01] ( &shared_actor_helpers_bank4.asciistring_02249A )
    COP [38] ( #$0400 )   ; BCD 400 EXP queued (exp_pending)
    COP [09] ( #$9D05 )
    BRL ms_npc_fairy_return_prompt_021EFB
}
---------------------------------------------

; Picks the push zone list of the current location.
; 
; When: meta type $39, once in A0BS01, A0BS02, A0CS02 and A0CS03; runs once at scene load.
; Sees: nothing; afterwards the hero slides south on the zones (ScanPushZones, once per frame).
; Why: the push zones are data, so each location only needs its table address in push_zone_list.
; In: actor script, X = own slot, M = 8 bits for the compare. Reads location_id.
; Out: for location $46 the ice hill table, $47 Laynole, $3E North slope, $3F Aurora's Ridge: push_zone_list = its address, push_zone_bank = bank 4. Any other location leaves the list unchanged. COP 86 kills the actor.
; Clobbers: A, Y.

ms_obj_push_zone_setup_02220D {
    SEP #$20
    LDA $location_id
    LDY #$&ms_push_zones_ice_hill_022267
    CMP #$46
    BEQ loc_022230
    LDY #$&ms_push_zones_laynole_022280
    CMP #$47
    BEQ loc_022230
    LDY #$&ms_push_zones_north_slope_02223D
    CMP #$3E
    BEQ loc_022230
    LDY #$&ms_push_zones_aurora_ridge_022256
    CMP #$3F
    BEQ loc_022230
    BRA loc_022238

  loc_022230:
    STY $push_zone_list
    LDA #$^ms_push_zones_north_slope_02223D
    STA $push_zone_bank

  loc_022238:
    REP #$20
    COP [86]
    RTL 
}
---------------------------------------------

; Push zones of the North slope ($3E): three records.
; 
; When: read by ScanPushZones via push_zone_list.
; Sees: tile rectangles x $1A-$1C / y $0A-$11, x $16-$18 / y $19-$27 and x $2B-$2D / y $2F-$36, each dx = 0, dy = +1 (a push south).
; Why: the icy slopes of the area.
; In: n/a (data, 8-byte records).
; Out: n/a.
; Clobbers: n/a.

ms_push_zones_north_slope_02223D [
  unk16 < #1A, #1C, #0A, #11, #$0000, #$0001 >   ;00
  unk16 < #16, #18, #19, #27, #$0000, #$0001 >   ;01
  unk16 < #2B, #2D, #2F, #36, #$0000, #$0001 >   ;02
]

---------------------------------------------
; Push zones of Aurora's Ridge ($3F): two records.
; 
; When: read by ScanPushZones via push_zone_list.
; Sees: x $13-$15 / y $14-$1B and x $1C-$1E / y $0A-$11, dx = 0, dy = +1.
; Why: the icy slopes of the area.
; In: n/a (data, 8-byte records).
; Out: n/a.
; Clobbers: n/a.

ms_push_zones_aurora_ridge_022256 [
  unk16 < #13, #15, #14, #1B, #$0000, #$0001 >   ;00
  unk16 < #1C, #1E, #0A, #11, #$0000, #$0001 >   ;01
]

---------------------------------------------
; Push zones of the ice hill ($46): three records.
; 
; When: read by ScanPushZones via push_zone_list.
; Sees: x $02-$1E for y $08-$11, $2C-$42 and $4F-$59, dx = 0, dy = +1.
; Why: the 'aptly-named ice hill' of the walkthrough, where the Mushroom Shoes do not help against the slope.
; In: n/a (data, 8-byte records).
; Out: n/a.
; Clobbers: n/a.

ms_push_zones_ice_hill_022267 [
  unk16 < #02, #1E, #08, #11, #$0000, #$0001 >   ;00
  unk16 < #02, #1E, #2C, #42, #$0000, #$0001 >   ;01
  unk16 < #02, #1E, #4F, #59, #$0000, #$0001 >   ;02
]

---------------------------------------------
; Push zone of Laynole ($47): one record.
; 
; When: read by ScanPushZones via push_zone_list.
; Sees: x $2F-$3E / y $21-$36, dx = 0, dy = +1.
; Why: the slope of the Ice field of Laynole.
; In: n/a (data, 8-byte record).
; Out: n/a.
; Clobbers: n/a.

ms_push_zones_laynole_022280 [
  unk16 < #2F, #3E, #21, #36, #$0000, #$0001 >
]