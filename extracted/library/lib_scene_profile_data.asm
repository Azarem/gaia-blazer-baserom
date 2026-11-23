; Scene profile list and the 97 scene profile records (file offsets 92321-93740, SNES $02:E8A1-$EE2C, bank 02).
; 
; === MODEL ===
; A scene profile is a 12-byte record of video and game settings that a scene's asset record selects with an asset8 command whose id is below $80 (ApplySceneProfile in lib_scene_asset_loader). The id is also the location id (location_id, $1C6A): the pause banner uses it as the string number in LocationNameList. SceneProfileList holds 128 words, one per id: the bank-$02 address of the record, 0000 for the 31 ids that have none (25-27, 35-3B, 48-4F, 5D-63, 74-77, 7E-7F). The loader subtracts the list's own address from the word and indexes from the list label with long addressing. The records are not in id order (23 and 24 come before 19, 34 before 2E).
; 
; === RECORD LAYOUT (12 bytes) ===
;   +0   TM, also TMW and tm_shadow (main screen layers)
;   +1   TS, also TSW (sub screen layers)
;   +2   CGWSEL
;   +3   CGADSUB, also cgadsub_shadow
;   +4   flags: bit 0 sets tile_attr_bg1 = $2000, bit 1 sets tile_attr_bg2 = $2000, bits 4-5 go to scene_sprite_attr+1, bit 6 view height (set 256, clear 224), bit 7 clear adds bit 8 to the BG2 tile attribute word; bits 2-3 are never read (OQ-I011-7)
;   +5   BG layout: bits 0-1 screen size of the first layer, bits 2-3 of the second, bit 7 swaps the layers (bg_scroll_swap = 1): BG1SC = ($70 if swapped else $60) + size, BG2SC = ($60 if swapped else $70) + size, so the map bases are VRAM words $6000 and $7000
;   +6   BGMODE ($09 = Mode 1 with BG3 priority, $0F = Mode 7 for location $10)
;   +7..+10  four parallax ratios for BG1 x, BG1 y, BG2 x, BG2 y: high nibble = numerator, low nibble = divisor ($11 = same speed, $12 = half speed, $00 = fixed)
;   +11  bits 0-3 world_index, bit 5 no_combat_scene, bits 6 and 7 each add 1 to scene_variant
; 
; === WORLDS ===
; world_index 0 Grass Valley (ids 00-13: the village, the Underground Castle, Leo's Paintings, the dream rooms and the intro scenes), 1 GreenWood (14-24), 2 St. Elles (28-34), 3 Mountain of Souls (3C-47), 4 Leo's Laboratory (50-5C), 5 Magridd's Castle (64-73), 6 World of Evil (78-7D). The first id of each world (00, 14, 28, 3C, 50, 64, 78: the Master's shrine rooms) has byte 4 = $E4 and byte 5 = $0F; id 11 has the same two bytes.
; 
; === NOTES ===
; - Byte 11 = $A0 or $A1-$A5 (variant + 1, no combat) occurs exactly in the 12 dream rooms (A dream: Tulip, Lisa, Bird, Stump, a dolphin, Servas, an old man, a mushroom, a cat, a soldier and the two rooms the ROM names 'A dream 1'). Byte 11 = $C0-$C5 (variant + 2) occurs exactly in six rooms: Monster in the paintings (0C), Tomb of a stone statue (22), A ghost ship (32), Poseidon (44), Tin Doll (59) and The deck of an airship (72). SceneVariantRules has a variant-0 row for the same six locations. The likely meaning is boss music until the boss switch is set, then the normal tune (OQ-I011-5, OQ-I011-6).
; - Locations 0F-13 have a profile but an empty name: they are the intro and transition scenes (00/09-00/0D, and 00/0A is the Mode 7 scene), which show no banner.
; - The records are read once per scene load; no code reads them again, so the list and the records can move together.
---------------------------------------------

?BANK 02

---------------------------------------------

; 128 words: the address of the profile record of each location id.
; 
; When: ApplySceneProfile, once per scene load.
; Sees: nothing directly; the id of the scene picks its layer setup.
; Why: ids are sparse (97 of 128 have a record), so a list of addresses is smaller than 128 fixed slots.
; In: index = id x 2.
; Out: bank-$02 address of the record, or 0000 for an unused id.

SceneProfileList [
  &SceneProfile00   ;00
  &SceneProfile01   ;01
  &SceneProfile02   ;02
  &SceneProfile03   ;03
  &SceneProfile04   ;04
  &SceneProfile05   ;05
  &SceneProfile06   ;06
  &SceneProfile07   ;07
  &SceneProfile08   ;08
  &SceneProfile09   ;09
  &SceneProfile0A   ;0A
  &SceneProfile0B   ;0B
  &SceneProfile0C   ;0C
  &SceneProfile0D   ;0D
  &SceneProfile0E   ;0E
  &SceneProfile0F   ;0F
  &SceneProfile10   ;10
  &SceneProfile11   ;11
  &SceneProfile12   ;12
  &SceneProfile13   ;13
  &SceneProfile14   ;14
  &SceneProfile15   ;15
  &SceneProfile16   ;16
  &SceneProfile17   ;17
  &SceneProfile18   ;18
  &SceneProfile19   ;19
  &SceneProfile1A   ;1A
  &SceneProfile1B   ;1B
  &SceneProfile1C   ;1C
  &SceneProfile1D   ;1D
  &SceneProfile1E   ;1E
  &SceneProfile1F   ;1F
  &SceneProfile20   ;20
  &SceneProfile21   ;21
  &SceneProfile22   ;22
  &SceneProfile23   ;23
  &SceneProfile24   ;24
  #$0000   ;25
  #$0000   ;26
  #$0000   ;27
  &SceneProfile28   ;28
  &SceneProfile29   ;29
  &SceneProfile2A   ;2A
  &SceneProfile2B   ;2B
  &SceneProfile2C   ;2C
  &SceneProfile2D   ;2D
  &SceneProfile2E   ;2E
  &SceneProfile2F   ;2F
  &SceneProfile30   ;30
  &SceneProfile31   ;31
  &SceneProfile32   ;32
  &SceneProfile33   ;33
  &SceneProfile34   ;34
  #$0000   ;35
  #$0000   ;36
  #$0000   ;37
  #$0000   ;38
  #$0000   ;39
  #$0000   ;3A
  #$0000   ;3B
  &SceneProfile3C   ;3C
  &SceneProfile3D   ;3D
  &SceneProfile3E   ;3E
  &SceneProfile3F   ;3F
  &SceneProfile40   ;40
  &SceneProfile41   ;41
  &SceneProfile42   ;42
  &SceneProfile43   ;43
  &SceneProfile44   ;44
  &SceneProfile45   ;45
  &SceneProfile46   ;46
  &SceneProfile47   ;47
  #$0000   ;48
  #$0000   ;49
  #$0000   ;4A
  #$0000   ;4B
  #$0000   ;4C
  #$0000   ;4D
  #$0000   ;4E
  #$0000   ;4F
  &SceneProfile50   ;50
  &SceneProfile51   ;51
  &SceneProfile52   ;52
  &SceneProfile53   ;53
  &SceneProfile54   ;54
  &SceneProfile55   ;55
  &SceneProfile56   ;56
  &SceneProfile57   ;57
  &SceneProfile58   ;58
  &SceneProfile59   ;59
  &SceneProfile5A   ;5A
  &SceneProfile5B   ;5B
  &SceneProfile5C   ;5C
  #$0000   ;5D
  #$0000   ;5E
  #$0000   ;5F
  #$0000   ;60
  #$0000   ;61
  #$0000   ;62
  #$0000   ;63
  &SceneProfile64   ;64
  &SceneProfile65   ;65
  &SceneProfile66   ;66
  &SceneProfile67   ;67
  &SceneProfile68   ;68
  &SceneProfile69   ;69
  &SceneProfile6A   ;6A
  &SceneProfile6B   ;6B
  &SceneProfile6C   ;6C
  &SceneProfile6D   ;6D
  &SceneProfile6E   ;6E
  &SceneProfile6F   ;6F
  &SceneProfile70   ;70
  &SceneProfile71   ;71
  &SceneProfile72   ;72
  &SceneProfile73   ;73
  #$0000   ;74
  #$0000   ;75
  #$0000   ;76
  #$0000   ;77
  &SceneProfile78   ;78
  &SceneProfile79   ;79
  &SceneProfile7A   ;7A
  &SceneProfile7B   ;7B
  &SceneProfile7C   ;7C
  &SceneProfile7D   ;7D
  #$0000   ;7E
  #$0000   ;7F
]

SceneProfile00 #17008000E40F091111111120

SceneProfile01 #17128243248F091111000020

SceneProfile02 #15008000640F091111000020

SceneProfile03 #15008000640F091111000020

SceneProfile04 #15008081640F091111000020

SceneProfile05 #17008002240F091111121200

SceneProfile06 #17008002240F091111121200

SceneProfile07 #17008082240F091111000000

SceneProfile08 #17008082640F091111000000

SceneProfile09 #17008082240F091111000000

SceneProfile0A #17008082640F0911110000A0

SceneProfile0B #17008082240F091111000000

SceneProfile0C #17008082640F0911110000C0

SceneProfile0D #15008000640F091111000000

SceneProfile0E #17008000240F0911111212A0

SceneProfile0F #17008000240F091111111100

SceneProfile10 #15008095240F0F1111000000

SceneProfile11 #17008000E40F091111000000

SceneProfile12 #040080000400091111000000

SceneProfile13 #16008082248F091111000020

SceneProfile14 #17008000E40F091111111121

SceneProfile15 #17128201268F091111000021

SceneProfile16 #15008000240F091111111121

SceneProfile17 #15008000640F091111111121

SceneProfile18 #15008000640F091111111121

SceneProfile23 #15008000240F0911111111A1

SceneProfile24 #17128201268F0911110000A1

SceneProfile19 #170080006403091111000001

SceneProfile1A #170080002403091111000001

SceneProfile1B #170080002403091111000001

SceneProfile1C #150282832403091111111101

SceneProfile1D #170080002403091111110001

SceneProfile1E #170080002403091111110001

SceneProfile1F #170080002403091111110001

SceneProfile20 #150080002403091111111101

SceneProfile21 #15028283640F091111111101

SceneProfile22 #15008000640F0911111111C1

SceneProfile28 #17008000E40F091111111122

SceneProfile29 #17008002240F091111001222

SceneProfile2A #17128203248C091111121202

SceneProfile2B #17128203248C091111121202

SceneProfile2C #15008000640F091111020222

SceneProfile2D #17128203248C0911111212A2

SceneProfile34 #17128203248C091111121202

SceneProfile2E #170080022403091111111102

SceneProfile2F #170080022403091111111102

SceneProfile30 #170380032403091111111102

SceneProfile31 #17128243248C091111000002

SceneProfile32 #1700800224030911111212C2

SceneProfile33 #1700800224030911111212A2

SceneProfile3C #17008000E40F091111111123

SceneProfile3D #150080032403091111001223

SceneProfile3E #170080022403091111120103

SceneProfile3F #170080A2240F091111120203

SceneProfile40 #170080A2240F0911111202A3

SceneProfile41 #170080022403091111141403

SceneProfile42 #170080022403091111111103

SceneProfile43 #1700800224030911111111A3

SceneProfile44 #1700800264030911111111C3

SceneProfile45 #150080022403091111121203

SceneProfile46 #17008002268F091111141403

SceneProfile47 #17008002240F091111121203

SceneProfile50 #17008000E40F091111111124

SceneProfile51 #170080022403091111121224

SceneProfile52 #170080022403091111121224

SceneProfile53 #150080026403091111121224

SceneProfile54 #150080026403091111121224

SceneProfile55 #1700800224030911111212A4

SceneProfile56 #170080023503091111121204

SceneProfile57 #17128243268F091111111104

SceneProfile58 #17008002350F091111121204

SceneProfile59 #15008002240F0911111212C4

SceneProfile5A #17128243268F0911111111A4

SceneProfile5B #17008002B60F091111111104

SceneProfile5C #17008002B60F091111111104

SceneProfile64 #17008000E40F091111111125

SceneProfile65 #17008000240F091111111125

SceneProfile66 #150080022403091111010105

SceneProfile67 #17008000B60F091111111105

SceneProfile68 #17008000B60F091111111105

SceneProfile69 #17008000B60F0911111111A5

SceneProfile6A #150080022403091111010105

SceneProfile6B #17008200B60F091111111105

SceneProfile6C #150080022403091111020205

SceneProfile6D #17008000B60F091111111105

SceneProfile6E #17008000B60F091111111105

SceneProfile6F #150080022403091111020205

SceneProfile70 #170080022403091111110105

SceneProfile71 #17008002240F091111111125

SceneProfile72 #17128243268F0911110111C5

SceneProfile73 #17128243268F0911110111A5

SceneProfile78 #17008003E40F091111111126

SceneProfile79 #17028243240F091111001206

SceneProfile7A #17028243240F091111001206

SceneProfile7B #17028243240F091111111106

SceneProfile7C #15008001640F091111000006

SceneProfile7D #170080827403091111111106