; Scene variant rules: 23 rows of 4 bytes and a terminator (file offsets 63898-63990, SNES $01:F99A-$F9F6, bank 00; 93 bytes).
; 
; === MODEL ===
; LookupSceneVariant (lib_scene_map_patches) is called by ApplySceneProfile when scene_variant is still 0. It walks this table for a row of the current location whose switch bit is set in the switch array $1ADE and, if there is one, stores the row's variant in scene_variant ($031E). The variant picks the music of the scene (the music commands of the asset list carry a variant byte).
; Row (4 bytes): +0 location_id (a first byte of $80 or more ends the table), +1 word switch number (a bit of $1ADE), +3 variant. The switch numbers are lair record indices (LairRecords): the six values are the boss lairs, one per world: $0009 the Metal Mantis (world 0), $0050 the Elemental Statues (1), $00B6 the Floating Skull (2), $0103 Poseidon (3), $012F the Tin Doll (4) and $0195 the Demon Falcon (5). The record of each switch has the world's boss as its monster (meta type $1F, $3D, $41, $38, $1E, $09).
; 
; === ROWS ===
; Rows per world: world 0 locations 01, 02, 03, 04 (variant 2) and 0C (variant 0); world 1 locations 15, 16, 17, 18 (variant 2) and 22 (0); world 2 locations 29, 2C (2) and 32 (0); world 3 locations 3D (2) and 44 (0); world 4 locations 51, 52, 53, 54 (2) and 59 (0); world 5 locations 65 (2), 72 (0) and 71 (1). The variant-0 rows are the six boss rooms, the rooms whose scene profile adds 2 to the variant (byte 11 = $C0-$C5, lib_scene_profile_data): after the boss lair is released the boss room goes back to variant 0 and the other rooms of the world change to variant 2 (the Castle of King Magridd's dock, 71, to variant 1). The story that fits: the boss music of the room before the boss falls and the music of the world after it (inferred; OQ-I011-5). World 6 has no row.
; 
; === NOTES ===
; - Bit n of $1ADE is set by the release code (ReleaseLairAtSwitch for a path, PlayLairReleaseScene for an NPC, which runs once the player has returned to the NPC's home scene), so the rooms change after the release, not at the moment the boss dies.
---------------------------------------------

?BANK 01

---------------------------------------------

; The scene variant rules: which rooms change their music variant once a boss lair has been released.
; 
; When: LookupSceneVariant, once per scene load, when the scene profile left scene_variant at 0.
; Sees: probably a change of music in the rooms of a world once its boss lair has been released, the boss room going back to its normal tune (inferred, OQ-I033-13).
; Why: the boss and post-boss music depend on a switch, not on the room, so they are data rows keyed by location and switch.
; In: n/a (data). Row (4 bytes): location_id, word switch number ($1ADE bit = the lair record index of the world's boss lair), variant. A first byte of $80 or more ends the table.
; Out: scene_variant = the variant of the first row of this location whose switch is set; 23 rows, 5 per world for worlds 0, 1 and 4, 3 for worlds 2 and 5, 2 for world 3.
; Clobbers: n/a (data).

SceneVariantRules [
  unk10 < #01, #$0009, #02 >   ;00
  unk10 < #02, #$0009, #02 >   ;01
  unk10 < #03, #$0009, #02 >   ;02
  unk10 < #04, #$0009, #02 >   ;03
  unk10 < #0C, #$0009, #00 >   ;04
  unk10 < #15, #$0050, #02 >   ;05
  unk10 < #16, #$0050, #02 >   ;06
  unk10 < #17, #$0050, #02 >   ;07
  unk10 < #18, #$0050, #02 >   ;08
  unk10 < #22, #$0050, #00 >   ;09
  unk10 < #29, #$00B6, #02 >   ;0A
  unk10 < #2C, #$00B6, #02 >   ;0B
  unk10 < #32, #$00B6, #00 >   ;0C
  unk10 < #3D, #$0103, #02 >   ;0D
  unk10 < #44, #$0103, #00 >   ;0E
  unk10 < #51, #$012F, #02 >   ;0F
  unk10 < #52, #$012F, #02 >   ;10
  unk10 < #53, #$012F, #02 >   ;11
  unk10 < #54, #$012F, #02 >   ;12
  unk10 < #59, #$012F, #00 >   ;13
  unk10 < #65, #$0195, #02 >   ;14
  unk10 < #72, #$0195, #00 >   ;15
  unk10 < #71, #$0195, #01 >   ;16
]