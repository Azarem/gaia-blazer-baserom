; Exit lists: the 128-word pointer table by location_id and 97 lists of 11-byte exit rows (file offsets 44182-46745, SNES $01:AC96-$B699, bank 00; 256 + 2308 bytes).
; 
; === MODEL ===
; CheckExitRegions (lib_tile_triggers_and_lair_return) runs every frame with exit_list_ofs, the list of the current location, which the scene loader takes from ExitListPointers[location_id x 2]. An exit is a rectangle of tiles; when the player stands inside it (the tile inside, then the pixel position inside the rectangle shrunk by 15 pixels) the scene change starts: area_next, scene_next, warp_dest_anim, warp_dest_x and warp_dest_y are stored and the transition begins. So doors, room edges, ladders and portals are data, not scripts.
; Row (11 bytes): +0 x, +1 y, +2 width, +3 height (tiles), +4 area_next, +5 scene_next, +6 warp_dest_anim, +7 word warp_dest_x, +9 word warp_dest_y (pixels). A list ends with $FF. Example: the Trial room list holds one row, x 4, y 10, 1 x 1 tiles, to area 0 scene 1, animation 3, at (96, 96).
; 
; === WHAT IS HERE ===
; 97 of the 128 ids have a pointer (the 31 without a scene hold $0000, as in the chest table). 78 lists have rows (201 in all; 21 lists have 1 row, 28 have 2, 15 have 3, 5 have 4, 2 have 5, 4 have 6, 2 have 7 and 1 has 11), 18 lists are a single $FF byte and one more (ExitListUnreferenced) is empty and not referenced. Names are ExitListLocLL with LL = location_id in hex.
; The 18 empty lists are the places the player leaves by a script, not by walking: the dream rooms (0A Tulip's, 0E Lisa's, 23 Bird's, 24 Stump's, 2D the dolphin's, 33 Servas', 40 the old man's, 43 the mushroom's, 55 the cat's, 69 and 73 the soldier's: 'A dream 1' and the others), the five intro scenes 0F-13, 72 the deck (the Demon Falcon's room) and 7D the battle with Deathtoll.
; 
; === NOTES ===
; - Location 5A (the second room the ROM calls 'A dream 1') points at the list of location 56 (ExitListLoc56, two rows to area $0D scene 1 and area $0E scene 2), while the empty list ExitListUnreferenced right after ExitListLoc59 has no reader. Every other dream room has an empty list, so the pointer looks like a slip (OQ-I033-5).
; - structs.json declares the exit row as 11 Bytes; +7 and +9 are 16-bit reads (retype decision: OQ-I033-10; the layouts are in docs/code/data-tables.md, section Row layouts).
---------------------------------------------

?BANK 01

---------------------------------------------

; The exit list pointers: 128 words by location_id.
; 
; When: the scene loader (exit_list_ofs), then CheckExitRegions every frame.
; Sees: nothing by itself; walking into a doorway, a room edge or a ladder starts the next scene.
; Why: exits are rectangles in a per-location list, so no scene needs a script for them.
; In: n/a (data): word at location_id x 2: the bank-$01 address of the list, or $0000 for the 31 ids without a scene.
; Out: 97 non-zero words and 96 distinct lists: locations 56 and 5A share ExitListLoc56, and ExitListUnreferenced has no pointer.
; Clobbers: n/a (data).

ExitListPointers [
  &ExitListLoc00   ;00
  &ExitListLoc01   ;01
  &ExitListLoc02   ;02
  &ExitListLoc03   ;03
  &ExitListLoc04   ;04
  &ExitListLoc05   ;05
  &ExitListLoc06   ;06
  &ExitListLoc07   ;07
  &ExitListLoc08   ;08
  &ExitListLoc09   ;09
  &ExitListLoc0A   ;0A
  &ExitListLoc0B   ;0B
  &ExitListLoc0C   ;0C
  &ExitListLoc0D   ;0D
  &ExitListLoc0E   ;0E
  &ExitListLoc0F   ;0F
  &ExitListLoc10   ;10
  &ExitListLoc11   ;11
  &ExitListLoc12   ;12
  &ExitListLoc13   ;13
  &ExitListLoc14   ;14
  &ExitListLoc15   ;15
  &ExitListLoc16   ;16
  &ExitListLoc17   ;17
  &ExitListLoc18   ;18
  &ExitListLoc19   ;19
  &ExitListLoc1A   ;1A
  &ExitListLoc1B   ;1B
  &ExitListLoc1C   ;1C
  &ExitListLoc1D   ;1D
  &ExitListLoc1E   ;1E
  &ExitListLoc1F   ;1F
  &ExitListLoc20   ;20
  &ExitListLoc21   ;21
  &ExitListLoc22   ;22
  &ExitListLoc23   ;23
  &ExitListLoc24   ;24
  #$0000   ;25
  #$0000   ;26
  #$0000   ;27
  &ExitListLoc28   ;28
  &ExitListLoc29   ;29
  &ExitListLoc2A   ;2A
  &ExitListLoc2B   ;2B
  &ExitListLoc2C   ;2C
  &ExitListLoc2D   ;2D
  &ExitListLoc2E   ;2E
  &ExitListLoc2F   ;2F
  &ExitListLoc30   ;30
  &ExitListLoc31   ;31
  &ExitListLoc32   ;32
  &ExitListLoc33   ;33
  &ExitListLoc34   ;34
  #$0000   ;35
  #$0000   ;36
  #$0000   ;37
  #$0000   ;38
  #$0000   ;39
  #$0000   ;3A
  #$0000   ;3B
  &ExitListLoc3C   ;3C
  &ExitListLoc3D   ;3D
  &ExitListLoc3E   ;3E
  &ExitListLoc3F   ;3F
  &ExitListLoc40   ;40
  &ExitListLoc41   ;41
  &ExitListLoc42   ;42
  &ExitListLoc43   ;43
  &ExitListLoc44   ;44
  &ExitListLoc45   ;45
  &ExitListLoc46   ;46
  &ExitListLoc47   ;47
  #$0000   ;48
  #$0000   ;49
  #$0000   ;4A
  #$0000   ;4B
  #$0000   ;4C
  #$0000   ;4D
  #$0000   ;4E
  #$0000   ;4F
  &ExitListLoc50   ;50
  &ExitListLoc51   ;51
  &ExitListLoc52   ;52
  &ExitListLoc53   ;53
  &ExitListLoc54   ;54
  &ExitListLoc55   ;55
  &ExitListLoc56   ;56
  &ExitListLoc57   ;57
  &ExitListLoc58   ;58
  &ExitListLoc59   ;59
  &ExitListLoc56   ;5A
  &ExitListLoc5B   ;5B
  &ExitListLoc5C   ;5C
  #$0000   ;5D
  #$0000   ;5E
  #$0000   ;5F
  #$0000   ;60
  #$0000   ;61
  #$0000   ;62
  #$0000   ;63
  &ExitListLoc64   ;64
  &ExitListLoc65   ;65
  &ExitListLoc66   ;66
  &ExitListLoc67   ;67
  &ExitListLoc68   ;68
  &ExitListLoc69   ;69
  &ExitListLoc6A   ;6A
  &ExitListLoc6B   ;6B
  &ExitListLoc6C   ;6C
  &ExitListLoc6D   ;6D
  &ExitListLoc6E   ;6E
  &ExitListLoc6F   ;6F
  &ExitListLoc70   ;70
  &ExitListLoc71   ;71
  &ExitListLoc72   ;72
  &ExitListLoc73   ;73
  #$0000   ;74
  #$0000   ;75
  #$0000   ;76
  #$0000   ;77
  &ExitListLoc78   ;78
  &ExitListLoc79   ;79
  &ExitListLoc7A   ;7A
  &ExitListLoc7B   ;7B
  &ExitListLoc7C   ;7C
  &ExitListLoc7D   ;7D
  #$0000   ;7E
  #$0000   ;7F
]

ExitListLoc00 [
  unk6 < #05, #06, #01, #01, #00, #08, #01, #40, #00, #90, #00 >   ;00
  unk6 < #07, #08, #01, #01, #01, #01, #00, #40, #01, #70, #02 >   ;01
  unk6 < #09, #06, #01, #01, #03, #05, #03, #30, #00, #D0, #02 >   ;02
]

ExitListLoc14 [
  unk6 < #07, #08, #01, #01, #04, #01, #00, #70, #01, #D0, #00 >   ;00
  unk6 < #05, #06, #01, #01, #05, #01, #01, #A0, #01, #30, #04 >   ;01
  unk6 < #09, #06, #01, #01, #05, #09, #00, #D0, #01, #30, #03 >   ;02
]

ExitListLoc28 [
  unk6 < #07, #08, #01, #01, #06, #01, #00, #F8, #01, #00, #02 >   ;00
  unk6 < #05, #06, #01, #01, #08, #01, #00, #50, #00, #70, #03 >   ;01
  unk6 < #09, #06, #01, #01, #07, #05, #01, #30, #00, #50, #01 >   ;02
]

ExitListLoc3C [
  unk6 < #07, #08, #01, #01, #0A, #01, #00, #90, #02, #60, #00 >   ;00
  unk6 < #05, #06, #01, #01, #0C, #03, #00, #30, #00, #E0, #01 >   ;01
  unk6 < #09, #06, #01, #01, #0B, #05, #00, #D0, #00, #70, #00 >   ;02
]

ExitListLoc50 [
  unk6 < #07, #08, #01, #01, #0D, #01, #01, #D0, #01, #A0, #01 >   ;00
  unk6 < #05, #06, #01, #01, #0E, #02, #01, #10, #00, #50, #00 >   ;01
  unk6 < #09, #06, #01, #01, #0E, #03, #01, #00, #01, #80, #03 >   ;02
]

ExitListLoc64 [
  unk6 < #07, #08, #01, #01, #10, #01, #00, #40, #03, #70, #00 >   ;00
  unk6 < #05, #06, #01, #01, #11, #03, #03, #D0, #01, #D0, #00 >   ;01
  unk6 < #09, #06, #01, #01, #12, #07, #02, #50, #01, #40, #00 >   ;02
]

ExitListLoc78 [
  unk6 < #07, #08, #01, #01, #14, #01, #01, #70, #01, #70, #05 >   ;00
  unk6 < #05, #06, #01, #01, #14, #01, #00, #C0, #01, #20, #01 >   ;01
  unk6 < #09, #06, #01, #01, #14, #03, #00, #B0, #01, #80, #00 >   ;02
]

---------------------------------------------
; The exit of the Trial room (location 0D): 1 row.
; 
; When: location 0D, the first room.
; Sees: walking onto the exit tile starts area 0 scene 1 with animation 3 at pixel (96, 96).
; Why: see the block note.
; In: n/a (data). Row: x 4, y 10, width 1, height 1, area_next 0, scene_next 1, warp_dest_anim 3, warp_dest_x $0060, warp_dest_y $0060.
; Out: one row, then $FF.
; Clobbers: n/a (data).

ExitListLoc0D [
  unk6 < #04, #0A, #01, #01, #00, #01, #03, #60, #00, #60, #00 >
]

ExitListLoc0F [
]

ExitListLoc10 [
]

ExitListLoc11 [
]

ExitListLoc12 [
]

ExitListLoc13 [
]

ExitListLoc01 [
  unk6 < #14, #26, #01, #01, #00, #01, #01, #70, #00, #70, #00 >   ;00
  unk6 < #13, #38, #02, #01, #02, #01, #01, #78, #00, #D8, #03 >   ;01
  unk6 < #26, #09, #01, #01, #01, #02, #01, #38, #00, #C0, #00 >   ;02
  unk6 < #2D, #10, #01, #01, #01, #02, #01, #C8, #00, #C0, #00 >   ;03
  unk6 < #24, #39, #01, #01, #01, #03, #01, #78, #00, #C0, #00 >   ;04
  unk6 < #0A, #13, #01, #01, #01, #04, #01, #90, #00, #50, #00 >   ;05
]

ExitListLoc02 [
  unk6 < #0C, #0D, #02, #01, #01, #01, #00, #D0, #02, #10, #01 >   ;00
  unk6 < #03, #0D, #02, #01, #01, #01, #00, #60, #02, #A0, #00 >   ;01
]

ExitListLoc03 [
  unk6 < #07, #0D, #02, #01, #01, #01, #00, #40, #02, #A0, #03 >
]

ExitListLoc04 [
  unk6 < #09, #06, #01, #01, #01, #01, #00, #A0, #00, #40, #01 >
]

ExitListLoc05 [
  unk6 < #07, #3F, #02, #01, #01, #01, #00, #38, #01, #A0, #03 >   ;00
  unk6 < #4F, #2C, #01, #02, #02, #02, #03, #10, #00, #F0, #02 >   ;01
]

ExitListLoc06 [
  unk6 < #00, #2E, #01, #02, #02, #01, #02, #E0, #04, #C8, #02 >
]

ExitListLoc0E [
]

ExitListLoc07 [
  unk6 < #07, #01, #02, #01, #03, #02, #01, #70, #00, #C0, #00 >   ;00
  unk6 < #07, #3F, #02, #01, #01, #01, #00, #00, #03, #50, #00 >   ;01
]

ExitListLoc08 [
  unk6 < #07, #0D, #01, #01, #03, #01, #00, #78, #00, #20, #00 >   ;00
  unk6 < #34, #01, #01, #01, #03, #03, #01, #80, #00, #E0, #01 >   ;01
]

ExitListLoc09 [
  unk6 < #08, #1F, #01, #01, #03, #02, #00, #40, #03, #20, #00 >   ;00
  unk6 < #08, #01, #01, #01, #03, #05, #01, #78, #00, #E0, #03 >   ;01
]

ExitListLoc0A [
]

ExitListLoc0B [
  unk6 < #07, #3F, #02, #01, #03, #03, #00, #80, #00, #30, #00 >   ;00
  unk6 < #07, #02, #02, #01, #03, #06, #01, #78, #00, #B0, #00 >   ;01
  unk6 < #02, #2D, #01, #01, #00, #01, #02, #80, #00, #60, #00 >   ;02
]

ExitListLoc0C [
  unk6 < #07, #0D, #02, #01, #03, #05, #00, #78, #00, #40, #00 >
]

ExitListLoc15 [
  unk6 < #17, #0B, #01, #01, #00, #02, #01, #70, #00, #70, #00 >   ;00
  unk6 < #2F, #19, #01, #03, #05, #01, #03, #10, #00, #60, #05 >   ;01
  unk6 < #05, #16, #01, #01, #04, #02, #00, #50, #00, #80, #00 >   ;02
  unk6 < #02, #20, #01, #01, #04, #02, #00, #20, #00, #00, #01 >   ;03
  unk6 < #0E, #1F, #01, #01, #04, #02, #00, #E0, #00, #E0, #00 >   ;04
  unk6 < #0D, #25, #01, #01, #04, #02, #00, #D0, #00, #30, #01 >   ;05
  unk6 < #13, #1D, #01, #01, #04, #02, #00, #30, #01, #E0, #00 >   ;06
  unk6 < #09, #2D, #01, #01, #04, #02, #00, #60, #00, #B0, #01 >   ;07
  unk6 < #19, #1D, #01, #01, #04, #02, #00, #90, #01, #E0, #00 >   ;08
  unk6 < #09, #07, #01, #01, #04, #03, #01, #80, #00, #C0, #00 >   ;09
  unk6 < #22, #08, #01, #01, #04, #04, #01, #70, #00, #C0, #00 >   ;0A
]

ExitListLoc16 [
  unk6 < #05, #07, #01, #01, #04, #01, #01, #50, #00, #50, #01 >   ;00
  unk6 < #02, #0F, #01, #01, #04, #01, #01, #20, #00, #F0, #01 >   ;01
  unk6 < #0E, #0D, #01, #01, #04, #01, #01, #E0, #00, #E0, #01 >   ;02
  unk6 < #0D, #12, #01, #01, #04, #01, #01, #D0, #00, #40, #02 >   ;03
  unk6 < #13, #0D, #01, #01, #04, #01, #01, #30, #01, #C0, #01 >   ;04
  unk6 < #06, #1A, #01, #01, #04, #01, #01, #90, #00, #C0, #02 >   ;05
  unk6 < #19, #0D, #01, #01, #04, #01, #01, #90, #01, #C0, #01 >   ;06
]

ExitListLoc17 [
  unk6 < #08, #0D, #01, #01, #04, #01, #00, #90, #00, #80, #00 >
]

ExitListLoc18 [
  unk6 < #07, #0D, #01, #01, #04, #01, #00, #20, #02, #90, #00 >
]

ExitListLoc23 [
]

ExitListLoc24 [
]

ExitListLoc19 [
  unk6 < #00, #55, #01, #03, #04, #01, #02, #E0, #02, #A0, #01 >   ;00
  unk6 < #0F, #3F, #02, #01, #05, #02, #01, #F0, #00, #E0, #01 >   ;01
  unk6 < #0F, #36, #02, #01, #05, #02, #00, #F0, #00, #10, #00 >   ;02
  unk6 < #0F, #27, #02, #01, #05, #05, #01, #F8, #00, #E0, #01 >   ;03
  unk6 < #0F, #1E, #02, #01, #05, #05, #00, #F8, #00, #20, #00 >   ;04
  unk6 < #0F, #03, #02, #01, #05, #08, #01, #78, #01, #E0, #02 >   ;05
  unk6 < #1A, #44, #01, #01, #00, #02, #03, #60, #00, #60, #00 >   ;06
]

ExitListLoc1A [
  unk6 < #0F, #1F, #01, #01, #05, #01, #00, #F8, #00, #00, #04 >   ;00
  unk6 < #02, #14, #01, #01, #05, #03, #00, #90, #00, #B0, #01 >   ;01
  unk6 < #17, #0A, #01, #01, #05, #03, #00, #F0, #01, #40, #01 >   ;02
  unk6 < #0F, #00, #01, #01, #05, #01, #01, #F8, #00, #50, #03 >   ;03
]

ExitListLoc1B [
  unk6 < #09, #1A, #01, #01, #05, #02, #01, #20, #00, #30, #01 >   ;00
  unk6 < #06, #26, #01, #01, #05, #04, #00, #30, #01, #00, #03 >   ;01
  unk6 < #1F, #13, #01, #01, #05, #02, #01, #70, #01, #90, #00 >   ;02
  unk6 < #0E, #15, #01, #01, #05, #04, #03, #E0, #01, #C0, #01 >   ;03
]

ExitListLoc1C [
  unk6 < #13, #2F, #01, #01, #05, #03, #01, #60, #00, #50, #02 >   ;00
  unk6 < #1E, #1B, #01, #01, #05, #03, #01, #E0, #00, #40, #01 >   ;01
]

ExitListLoc1D [
  unk6 < #0F, #1F, #02, #01, #05, #01, #00, #F8, #00, #80, #02 >   ;00
  unk6 < #0F, #0D, #01, #01, #05, #06, #00, #40, #01, #50, #01 >   ;01
  unk6 < #06, #03, #01, #01, #05, #06, #00, #80, #00, #D0, #00 >   ;02
  unk6 < #19, #03, #01, #01, #05, #06, #00, #90, #02, #D0, #00 >   ;03
  unk6 < #0F, #01, #02, #01, #05, #01, #01, #F8, #00, #D0, #01 >   ;04
]

ExitListLoc1E [
  unk6 < #14, #14, #01, #01, #05, #05, #01, #F0, #00, #C0, #00 >   ;00
  unk6 < #1A, #18, #01, #01, #05, #07, #00, #00, #02, #20, #02 >   ;01
  unk6 < #06, #0E, #01, #01, #05, #07, #00, #E0, #00, #50, #01 >   ;02
  unk6 < #08, #0C, #01, #01, #05, #05, #03, #70, #00, #30, #00 >   ;03
  unk6 < #29, #0C, #01, #01, #05, #05, #02, #80, #01, #30, #00 >   ;04
]

ExitListLoc1F [
  unk6 < #20, #21, #01, #01, #05, #06, #01, #A0, #01, #70, #01 >   ;00
  unk6 < #0E, #14, #01, #01, #05, #06, #01, #60, #00, #D0, #00 >   ;01
]

ExitListLoc20 [
  unk6 < #17, #2F, #02, #01, #05, #01, #00, #F0, #00, #40, #00 >   ;00
  unk6 < #0E, #2A, #01, #01, #05, #09, #00, #50, #01, #B0, #02 >   ;01
]

ExitListLoc21 [
  unk6 < #15, #2A, #01, #01, #05, #08, #01, #E0, #00, #90, #02 >   ;00
  unk6 < #19, #00, #02, #02, #05, #0A, #01, #F8, #00, #B0, #00 >   ;01
  unk6 < #1D, #32, #01, #01, #00, #02, #02, #80, #00, #60, #00 >   ;02
]

ExitListLoc22 [
  unk6 < #0F, #0D, #02, #01, #05, #09, #00, #98, #01, #20, #00 >
]

ExitListLoc29 [
  unk6 < #1F, #1E, #02, #02, #00, #03, #01, #70, #00, #70, #00 >   ;00
  unk6 < #1F, #3F, #02, #01, #07, #01, #00, #F8, #03, #50, #00 >   ;01
  unk6 < #0A, #28, #01, #01, #07, #03, #00, #50, #00, #30, #00 >   ;02
  unk6 < #35, #28, #01, #01, #07, #03, #00, #B0, #01, #30, #00 >   ;03
]

ExitListLoc2A [
  unk6 < #3F, #04, #02, #01, #06, #01, #01, #F8, #01, #E0, #03 >   ;00
  unk6 < #35, #02, #01, #01, #08, #01, #01, #C0, #01, #D0, #03 >   ;01
  unk6 < #7E, #19, #01, #01, #08, #02, #03, #20, #00, #C8, #02 >   ;02
  unk6 < #05, #02, #01, #01, #08, #03, #01, #20, #02, #E0, #03 >   ;03
  unk6 < #15, #03, #01, #01, #07, #05, #01, #30, #02, #E0, #03 >   ;04
  unk6 < #6B, #03, #01, #01, #07, #05, #01, #50, #07, #E0, #03 >   ;05
]

ExitListLoc2B [
  unk6 < #07, #1F, #01, #01, #07, #05, #00, #50, #00, #F0, #01 >
]

ExitListLoc2C [
  unk6 < #05, #02, #01, #01, #06, #01, #01, #A0, #00, #70, #02 >   ;00
  unk6 < #1B, #02, #01, #01, #06, #01, #01, #50, #03, #70, #02 >   ;01
]

ExitListLoc2D [
]

ExitListLoc34 [
  unk6 < #05, #1E, #01, #01, #07, #02, #01, #70, #00, #E0, #01 >   ;00
  unk6 < #6B, #02, #01, #01, #08, #04, #01, #40, #00, #E0, #03 >   ;01
  unk6 < #0B, #06, #01, #01, #09, #01, #01, #50, #00, #20, #04 >   ;02
  unk6 < #03, #16, #01, #01, #00, #03, #02, #80, #00, #60, #00 >   ;03
  unk6 < #23, #3F, #01, #01, #07, #01, #00, #50, #01, #40, #00 >   ;04
  unk6 < #75, #3F, #01, #01, #07, #01, #00, #B0, #06, #40, #00 >   ;05
]

ExitListLoc2E [
  unk6 < #1C, #3F, #01, #01, #07, #01, #00, #50, #03, #30, #00 >   ;00
  unk6 < #05, #35, #01, #01, #00, #03, #03, #60, #00, #60, #00 >   ;01
]

ExitListLoc2F [
  unk6 < #01, #2C, #01, #02, #07, #01, #02, #D0, #07, #90, #01 >
]

ExitListLoc30 [
  unk6 < #22, #3F, #01, #01, #07, #01, #00, #50, #00, #30, #00 >
]

ExitListLoc31 [
  unk6 < #04, #3F, #01, #01, #07, #05, #00, #B0, #06, #30, #00 >
]

ExitListLoc32 [
  unk6 < #05, #43, #01, #01, #07, #05, #00, #B0, #00, #70, #00 >
]

ExitListLoc33 [
]

ExitListLoc3D [
  unk6 < #1D, #02, #02, #01, #0B, #01, #01, #70, #00, #80, #03 >   ;00
  unk6 < #37, #15, #02, #01, #0C, #03, #01, #10, #02, #90, #03 >   ;01
  unk6 < #29, #05, #01, #01, #00, #04, #01, #70, #00, #70, #00 >   ;02
]

ExitListLoc3E [
  unk6 < #29, #01, #02, #01, #0B, #02, #01, #88, #00, #E0, #02 >   ;00
  unk6 < #07, #39, #01, #01, #0A, #01, #00, #D8, #01, #40, #00 >   ;01
]

ExitListLoc3F [
  unk6 < #08, #2F, #02, #01, #0B, #01, #00, #98, #02, #30, #00 >   ;00
  unk6 < #29, #04, #02, #01, #0C, #01, #01, #68, #01, #C0, #02 >   ;01
]

ExitListLoc40 [
]

ExitListLoc41 [
  unk6 < #07, #01, #01, #01, #0C, #03, #01, #B0, #03, #D0, #03 >   ;00
  unk6 < #24, #3D, #01, #01, #0B, #05, #00, #30, #00, #A0, #03 >   ;01
]

ExitListLoc42 [
  unk6 < #1A, #04, #01, #01, #0B, #07, #01, #F8, #00, #B0, #00 >   ;00
  unk6 < #03, #39, #01, #01, #0B, #04, #01, #40, #02, #C0, #03 >   ;01
  unk6 < #0D, #06, #01, #01, #00, #04, #02, #80, #00, #60, #00 >   ;02
]

ExitListLoc43 [
]

ExitListLoc44 [
  unk6 < #0F, #0D, #02, #01, #0B, #05, #00, #A0, #01, #50, #00 >
]

ExitListLoc45 [
  unk6 < #16, #2D, #02, #01, #0B, #02, #00, #98, #02, #50, #00 >   ;00
  unk6 < #1F, #14, #01, #01, #0C, #02, #00, #50, #00, #40, #00 >   ;01
]

ExitListLoc46 [
  unk6 < #05, #03, #01, #01, #0C, #01, #01, #F0, #01, #30, #01 >   ;00
  unk6 < #19, #5D, #01, #01, #0C, #03, #00, #30, #00, #40, #00 >   ;01
]

ExitListLoc47 [
  unk6 < #03, #03, #01, #01, #0C, #02, #01, #90, #01, #C0, #05 >   ;00
  unk6 < #21, #3A, #01, #01, #0A, #01, #00, #78, #03, #70, #01 >   ;01
  unk6 < #3B, #3E, #01, #01, #0B, #04, #00, #70, #00, #30, #00 >   ;02
  unk6 < #03, #1D, #01, #01, #00, #04, #03, #60, #00, #60, #00 >   ;03
]

ExitListLoc51 [
  unk6 < #1D, #1B, #01, #01, #00, #05, #01, #70, #00, #70, #00 >   ;00
  unk6 < #1E, #05, #01, #01, #0D, #02, #01, #E0, #01, #60, #00 >   ;01
  unk6 < #02, #04, #01, #01, #0D, #04, #01, #30, #00, #C0, #00 >   ;02
  unk6 < #18, #04, #01, #01, #0D, #04, #01, #90, #01, #C0, #00 >   ;03
  unk6 < #0F, #13, #01, #01, #0E, #01, #00, #D0, #01, #D0, #03 >   ;04
  unk6 < #13, #1B, #01, #01, #0E, #03, #00, #30, #00, #30, #00 >   ;05
]

ExitListLoc52 [
  unk6 < #1E, #07, #01, #01, #0D, #01, #00, #E0, #01, #60, #00 >   ;00
  unk6 < #02, #04, #01, #01, #0D, #03, #01, #10, #00, #40, #00 >   ;01
]

ExitListLoc53 [
  unk6 < #01, #05, #01, #01, #0D, #02, #00, #20, #00, #50, #00 >
]

ExitListLoc54 [
  unk6 < #03, #0D, #01, #01, #0D, #01, #00, #20, #00, #50, #00 >   ;00
  unk6 < #19, #0D, #01, #01, #0D, #01, #00, #80, #01, #50, #00 >   ;01
]

ExitListLoc55 [
]

---------------------------------------------
; The exit list of location 56 (Basement of Laboratory), also used by location 5A (A dream 1): 2 rows.
; 
; When: locations 56 and 5A.
; Sees: in 56 two exits lead to scene 1 of area $0D and scene 2 of area $0E; in 5A the same rectangles would exist in a dream room that has no such doors (OQ-I033-5).
; Why: unknown for 5A; see the block note.
; In: n/a (data). Rows: (x 29, y 59, 1 x 1) to area $0D scene 1 animation 1 at ($00F0, $0120); (59, 8, 1 x 1) to area $0E scene 2 animation 0 at ($01C0, $0040).
; Out: two rows, then $FF.
; Clobbers: n/a (data).

ExitListLoc56 [
  unk6 < #1D, #3B, #01, #01, #0D, #01, #01, #F0, #00, #20, #01 >   ;00
  unk6 < #3B, #08, #01, #01, #0E, #02, #00, #C0, #01, #40, #00 >   ;01
]

ExitListLoc57 [
  unk6 < #1C, #03, #01, #01, #0E, #01, #01, #B0, #03, #70, #00 >   ;00
  unk6 < #01, #06, #01, #01, #00, #05, #03, #60, #00, #60, #00 >   ;01
]

ExitListLoc58 [
  unk6 < #03, #02, #01, #01, #0D, #01, #01, #30, #01, #A0, #01 >   ;00
  unk6 < #20, #1E, #01, #01, #0E, #04, #00, #E0, #00, #90, #00 >   ;01
  unk6 < #10, #39, #01, #01, #00, #05, #02, #80, #00, #60, #00 >   ;02
]

ExitListLoc59 [
  unk6 < #0E, #07, #01, #01, #0E, #03, #01, #00, #02, #C0, #01 >
]

---------------------------------------------
; An empty exit list (one $FF byte) that no pointer uses.
; 
; When: never read.
; Sees: nothing.
; Why: it sits right after ExitListLoc59 where the pointer of location 5A, a dream room, would be expected (OQ-I033-5).
; In: n/a (data).
; Out: an immediate end of the list.
; Clobbers: n/a (data).

ExitListUnreferenced [
]

ExitListLoc5B [
  unk6 < #1F, #3F, #02, #01, #0D, #02, #00, #28, #00, #00, #01 >
]

ExitListLoc5C [
  unk6 < #1F, #3F, #02, #01, #0D, #02, #00, #58, #00, #00, #01 >
]

ExitListLoc65 [
  unk6 < #34, #06, #01, #01, #00, #06, #01, #70, #00, #70, #00 >   ;00
  unk6 < #0C, #06, #01, #01, #11, #01, #00, #40, #00, #50, #02 >   ;01
  unk6 < #3D, #08, #01, #01, #12, #04, #01, #40, #00, #E0, #01 >   ;02
  unk6 < #02, #08, #01, #01, #12, #01, #01, #B0, #01, #E0, #01 >   ;03
]

ExitListLoc66 [
  unk6 < #04, #24, #01, #01, #10, #01, #01, #C0, #00, #50, #00 >   ;00
  unk6 < #2C, #2C, #01, #01, #11, #02, #00, #C0, #02, #90, #02 >   ;01
]

ExitListLoc67 [
  unk6 < #2C, #28, #01, #01, #11, #01, #01, #C0, #02, #B0, #02 >   ;00
  unk6 < #04, #2D, #01, #01, #11, #03, #00, #30, #00, #A0, #03 >   ;01
]

ExitListLoc68 [
  unk6 < #03, #39, #01, #01, #11, #02, #01, #40, #00, #C0, #02 >   ;00
  unk6 < #1C, #0D, #01, #01, #00, #06, #03, #60, #00, #60, #00 >   ;01
]

ExitListLoc69 [
]

ExitListLoc6A [
  unk6 < #02, #16, #01, #01, #12, #02, #01, #20, #00, #50, #01 >   ;00
  unk6 < #1B, #1F, #01, #01, #10, #01, #00, #20, #00, #90, #00 >   ;01
]

ExitListLoc6B [
  unk6 < #02, #16, #01, #01, #12, #01, #00, #20, #00, #70, #01 >   ;00
  unk6 < #1C, #06, #01, #01, #12, #03, #01, #C0, #01, #40, #00 >   ;01
]

ExitListLoc6C [
  unk6 < #1C, #05, #01, #01, #12, #02, #00, #C0, #01, #70, #00 >
]

ExitListLoc6D [
  unk6 < #13, #09, #01, #01, #12, #05, #01, #F0, #00, #70, #00 >   ;00
  unk6 < #04, #1F, #01, #01, #10, #01, #00, #D0, #03, #90, #00 >   ;01
]

ExitListLoc6E [
  unk6 < #0F, #08, #01, #01, #12, #04, #00, #30, #01, #A0, #00 >   ;00
  unk6 < #03, #07, #01, #01, #12, #06, #01, #30, #00, #40, #00 >   ;01
]

ExitListLoc6F [
  unk6 < #03, #05, #01, #01, #12, #05, #00, #30, #00, #80, #00 >   ;00
  unk6 < #1C, #19, #01, #01, #12, #07, #01, #C0, #02, #70, #01 >   ;01
]

ExitListLoc70 [
  unk6 < #00, #04, #01, #01, #13, #01, #02, #E0, #02, #D8, #00 >   ;00
  unk6 < #2C, #18, #01, #01, #12, #06, #00, #C0, #01, #A0, #01 >   ;01
  unk6 < #16, #04, #01, #01, #00, #06, #02, #80, #00, #60, #00 >   ;02
]

ExitListLoc71 [
  unk6 < #2F, #0D, #01, #02, #12, #07, #03, #10, #00, #40, #00 >
]

ExitListLoc72 [
]

ExitListLoc73 [
]

ExitListLoc79 [
  unk6 < #17, #58, #01, #01, #00, #07, #01, #70, #00, #70, #00 >   ;00
  unk6 < #17, #05, #02, #02, #14, #02, #01, #F8, #00, #88, #03 >   ;01
  unk6 < #1C, #11, #01, #01, #00, #07, #03, #60, #00, #60, #00 >   ;02
]

ExitListLoc7A [
  unk6 < #0F, #39, #02, #02, #14, #01, #00, #78, #01, #70, #00 >   ;00
  unk6 < #0F, #04, #02, #02, #14, #03, #01, #F8, #00, #98, #03 >   ;01
]

ExitListLoc7B [
  unk6 < #0F, #3A, #02, #02, #14, #02, #00, #F8, #00, #58, #00 >   ;00
  unk6 < #0F, #01, #02, #01, #15, #01, #01, #78, #00, #C0, #02 >   ;01
  unk6 < #1B, #07, #01, #01, #00, #07, #02, #80, #00, #60, #00 >   ;02
]

ExitListLoc7C [
  unk6 < #07, #2D, #02, #03, #14, #03, #00, #F8, #00, #50, #00 >
]

ExitListLoc7D [
]