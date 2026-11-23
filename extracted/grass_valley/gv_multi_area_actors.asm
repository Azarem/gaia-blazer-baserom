; The conveyor belts of Grass Valley and one background drift actor shared by several areas (file offsets 110589-111130, bank 03): gv_obj_push_zone_setup_01AFFD (meta type $2C) picks the push zone list of the current location, seven tables of 8-byte records follow it, and gv_obj_bg2_scroll_drift_01B1F7 (type $07) drifts the second background layer.
; 
; === PUSH ZONES ===
; Type $2C is placed once in the Underground Castle scenes A02S01-S02 and in the Leo's Paintings scenes A03S01-S03 and S05-S06 (not in the dream rooms A02S03 and A03S04). It compares location_id with $05, $06, $07, $08, $09, $0B and $0C, stores the matching table in push_zone_list and its bank in push_zone_bank, and kills itself; any other location would leave the list unchanged. player_core.ScanPushZones then reads the records every frame. A record is x0, x1, y0, y1 (tiles) and the words dx, dy in pixels per frame ($0001 right or down, $FFFF left or up, 0 none); the list ends with $FF. Tables: location 05 (Underground Castle west) 4 zones, 06 (east) 8, 07 / 08 / 09 (Leo's Paintings 1-3) 2 / 10 / 7, 0B (Leo's Paintings 4) 1, 0C (the Metal Mantis room) 3. The walkthrough calls them conveyor belts ('Work your way across the conveyor belt', 'two carpet-style conveyor belts').
; 
; === BACKGROUND DRIFT ===
; Type $07 adds (1, -1) plus scroll_delta_x / scroll_delta_y to its own position every frame and copies the result to the BG2 scroll registers (scroll_bg2_x / y): a slow diagonal drift of the second layer (clouds or a sky). It is placed in the village (A01S01) and in the final scene A00S0D.
; 
; === NOTES ===
; - The seven tables carry no names in the ROM; their names come from the location ids the setup actor tests (OQ-I034-6: the map positions were read, not confirmed in the emulator).
---------------------------------------------

?BANK 03

!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!push_zone_list                 03D8
!push_zone_bank                 03DA
!location_id                    1C6A

---------------------------------------------

; Picks the conveyor belt list of the current location.
; 
; When: meta type $2C, once in each of A02S01-S02, A03S01-S03 and A03S05-S06; runs once at scene load.
; Sees: nothing; afterwards the hero is carried by the belts of the room (Underground Castle, Leo's Paintings).
; Why: the push zones are data, so each location only needs its table address in push_zone_list.
; In: actor script, X = own slot, M = 8 bits for the compare. Reads location_id.
; Out: push_zone_list = the table of the location (5, 6, 7, 8, 9, $0B, $0C), push_zone_bank = bank 3; unchanged for any other location (no placement has one); COP 86 kills the actor.
; Clobbers: A, Y.

gv_obj_push_zone_setup_01AFFD {
    SEP #$20
    LDA $location_id
    LDY #$&gv_push_zones_underground_west_01B042
    CMP #$05
    BEQ loc_01B035
    LDY #$&gv_push_zones_underground_east_01B063
    CMP #$06
    BEQ loc_01B035
    LDY #$&gv_push_zones_paintings_1_01B0A4
    CMP #$07
    BEQ loc_01B035
    LDY #$&gv_push_zones_paintings_2_01B0B5
    CMP #$08
    BEQ loc_01B035
    LDY #$&gv_push_zones_paintings_3_01B106
    CMP #$09
    BEQ loc_01B035
    LDY #$&gv_push_zones_paintings_4_01B13F
    CMP #$0B
    BEQ loc_01B035
    LDY #$&gv_push_zones_metal_mantis_01B148
    CMP #$0C
    BEQ loc_01B035
    BRA loc_01B03D

  loc_01B035:
    STY $push_zone_list
    LDA #$^gv_push_zones_underground_west_01B042
    STA $push_zone_bank

  loc_01B03D:
    REP #$20
    COP [86]
    RTL 
}
---------------------------------------------

; Conveyor belts of the Underground Castle, west (location 5).
; 
; When: read every frame by ScanPushZones once gv_obj_push_zone_setup_01AFFD has chosen it.
; Sees: four belts carry the hero: tiles x $27-$37, y $08-$0A right; x $49-$4B, y $0C-$1C up; x $3A-$3B, y $1E-$2E down; x $26-$36, y $2E-$30 right.
; Why: data, one 8-byte record per belt.
; In: n/a (data). Record = x0, x1, y0, y1, dx word, dy word.
; Out: n/a. 4 records and the $FF end byte.
; Clobbers: n/a.

gv_push_zones_underground_west_01B042 [
  unk16 < #27, #37, #08, #0A, #$0001, #$0000 >   ;00
  unk16 < #49, #4B, #0C, #1C, #$0000, #$FFFF >   ;01
  unk16 < #3A, #3B, #1E, #2E, #$0000, #$0001 >   ;02
  unk16 < #26, #36, #2E, #30, #$0001, #$0000 >   ;03
]

---------------------------------------------
; Conveyor belts of the Underground Castle, east (location 6).
; 
; When: as gv_push_zones_underground_west_01B042.
; Sees: eight belts: left (x $21-$31, y $25-$27), up (x $28-$2A, y $05-$25), left, right, down, down, left, left (see the records).
; Why: data.
; In: n/a (data). Same record layout.
; Out: n/a. 8 records and the $FF end byte.
; Clobbers: n/a.

gv_push_zones_underground_east_01B063 [
  unk16 < #21, #31, #25, #27, #$FFFF, #$0000 >   ;00
  unk16 < #28, #2A, #05, #25, #$0000, #$FFFF >   ;01
  unk16 < #2A, #3A, #13, #15, #$FFFF, #$0000 >   ;02
  unk16 < #28, #38, #03, #05, #$0001, #$0000 >   ;03
  unk16 < #38, #3A, #03, #13, #$0000, #$0001 >   ;04
  unk16 < #3A, #3C, #13, #34, #$0000, #$0001 >   ;05
  unk16 < #28, #38, #38, #3A, #$FFFF, #$0000 >   ;06
  unk16 < #1E, #2E, #3A, #3C, #$FFFF, #$0000 >   ;07
]

---------------------------------------------
; Conveyor belts of Leo's Paintings 1 (location 7).
; 
; When: as gv_push_zones_underground_west_01B042.
; Sees: two belts, x $03-$05 (up) and $06-$08 (down), both y $12-$20 (the walkthrough: 'two carpet-style conveyor belts').
; Why: data.
; In: n/a (data). Same record layout.
; Out: n/a. 2 records and the $FF end byte.
; Clobbers: n/a.

gv_push_zones_paintings_1_01B0A4 [
  unk16 < #03, #05, #12, #20, #$0000, #$FFFF >   ;00
  unk16 < #06, #08, #12, #20, #$0000, #$0001 >   ;01
]

---------------------------------------------
; Conveyor belts of Leo's Paintings 2 (location 8).
; 
; When: as gv_push_zones_underground_west_01B042.
; Sees: ten belts across the room, mostly vertical pairs (up and down) between x $1D and $2C and one horizontal one at y $09-$0B.
; Why: data.
; In: n/a (data). Same record layout.
; Out: n/a. 10 records and the $FF end byte.
; Clobbers: n/a.

gv_push_zones_paintings_2_01B0B5 [
  unk16 < #1D, #1F, #04, #07, #$0000, #$FFFF >   ;00
  unk16 < #1D, #1F, #09, #0C, #$0000, #$FFFF >   ;01
  unk16 < #1F, #21, #03, #06, #$0000, #$0001 >   ;02
  unk16 < #1F, #21, #08, #0B, #$0000, #$0001 >   ;03
  unk16 < #21, #23, #04, #07, #$0000, #$FFFF >   ;04
  unk16 < #21, #23, #09, #0C, #$0000, #$FFFF >   ;05
  unk16 < #26, #28, #03, #0C, #$0000, #$0001 >   ;06
  unk16 < #28, #2A, #03, #0C, #$0000, #$FFFF >   ;07
  unk16 < #2A, #2C, #03, #0C, #$0000, #$0001 >   ;08
  unk16 < #2C, #3B, #09, #0B, #$0001, #$0000 >   ;09
]

---------------------------------------------
; Conveyor belts of Leo's Paintings 3 (location 9).
; 
; When: as gv_push_zones_underground_west_01B042.
; Sees: seven belts between x $05 and $15.
; Why: data.
; In: n/a (data). Same record layout.
; Out: n/a. 7 records and the $FF end byte.
; Clobbers: n/a.

gv_push_zones_paintings_3_01B106 [
  unk16 < #05, #07, #11, #17, #$0000, #$0001 >   ;00
  unk16 < #07, #0D, #15, #17, #$0001, #$0000 >   ;01
  unk16 < #0D, #0F, #12, #17, #$0000, #$FFFF >   ;02
  unk16 < #0D, #0F, #09, #0F, #$0000, #$0001 >   ;03
  unk16 < #0F, #15, #07, #09, #$0001, #$0000 >   ;04
  unk16 < #0F, #15, #11, #13, #$0001, #$0000 >   ;05
  unk16 < #0F, #15, #1A, #1C, #$FFFF, #$0000 >   ;06
]

---------------------------------------------
; The one conveyor belt of Leo's Paintings 4 (location $0B).
; 
; When: as gv_push_zones_underground_west_01B042.
; Sees: x $07-$09, y $0E-$3E, moving up.
; Why: data.
; In: n/a (data). Same record layout.
; Out: n/a. 1 record and the $FF end byte.
; Clobbers: n/a.

gv_push_zones_paintings_4_01B13F [
  unk16 < #07, #09, #0E, #3E, #$0000, #$FFFF >
]

---------------------------------------------
; Conveyor belts of the Metal Mantis room (location $0C).
; 
; When: as gv_push_zones_underground_west_01B042.
; Sees: three belts at y $06-$0A, x $03-$05, $0B-$0D (up) and $07-$09 (down; the walkthrough: 'the center conveyor belt ... the one moving southbound').
; Why: data.
; In: n/a (data). Same record layout.
; Out: n/a. 3 records and the $FF end byte.
; Clobbers: n/a.

gv_push_zones_metal_mantis_01B148 [
  unk16 < #03, #05, #06, #0A, #$0000, #$FFFF >   ;00
  unk16 < #0B, #0D, #06, #0A, #$0000, #$FFFF >   ;01
  unk16 < #07, #09, #06, #0A, #$0000, #$0001 >   ;02
]
---------------------------------------------

; Drifts the second background layer by (1, -1) per frame.
; 
; When: meta type $07, every frame (the script has no entry point of its own, so it restarts each frame); placed in the village A01S01 and in A00S0D.
; Sees: a slowly moving background layer.
; Why: BG2 is scrolled by an actor so that the scroll continues across the scene without a separate scroll routine; scroll_delta_x / y add the camera movement.
; In: actor script, X = own slot, M = 16 bits. Reads scroll_delta_x, scroll_delta_y.
; Out: $00,X += 1 + scroll_delta_x and $02,X += -1 + scroll_delta_y; both are copied to scroll_bg2_x and scroll_bg2_y; RTL.
; Clobbers: A.

gv_obj_bg2_scroll_drift_01B1F7 {
    LDA $0000, X
    CLC 
    ADC #$0001
    CLC 
    ADC $scroll_delta_x
    STA $0000, X
    STA $scroll_bg2_x
    LDA $0002, X
    SEC 
    SBC #$0001
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}