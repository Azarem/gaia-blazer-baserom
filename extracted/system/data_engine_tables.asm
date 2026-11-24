; Engine tables: 16 small tables read all over the engine (file offsets 63991-65091, SNES $01:F9F7-$FE43, bank 00; 1101 bytes).
; 
; === WHAT IS HERE ===
; Menu positions: WeaponIconPositions, ArmorIconPositions, MagicIconPositions (8 words each: the BG offsets of the icons of the equipment page) and ItemIconPositions (40 words: the item grid), read by DrawEquipIconRows and DrawItemIconGrid.
; Bit and direction tables: SwitchBitMasks (8 bytes $01-$80: the mask of bit n and 7 for every bit array), PlayerFacingByAnim and PlayerMoveDirByAnim (44 bytes each, by the player's animation id: 0 up, 1 down, 2 right, 3 left; ids $2C and up are not valid), WeaponYOffsetByAnim (44 words: the weapon sprite's y offset by animation, 0 or 1 pixel).
; Colour and music: GaugeColorLadder (13 BGR555 words: the colour of the HP and enemy gauge in steps of 10 units, dark blue below 50 up to white from 100), MusicPointerTable (21 long pointers to the song data), MagicGraphicsPointers (8 long pointers into graphics_07B000) and MagicPalettePointers (8 long pointers into palette_07D000, 32 bytes each).
; Level-up and geometry: LevelExpThresholds (51 rows of 2 BCD words), SineTable plus SineTableTail (one 320-byte signed sine) and CircleHalfWidths (128 bytes).
; 
; === NOTES ===
; - The file keeps the extraction's split of the sine (SineTable 64 bytes, SineTableTail 256 bytes): they are one table and the split is only a boundary of the extraction.
; - Each part note names its consumers.
---------------------------------------------

?BANK 01

---------------------------------------------

; BG offsets of the 8 weapon icons on the equipment page.
; 
; When: DrawEquipIconRows (7 call sites of the equipment menu).
; Sees: the eight sword icons in two rows of four.
; Why: the page layout is data, so the icon loop is one routine for weapons, armor and magic.
; In: n/a (data): 8 words, index = the inventory slot.
; Out: $018C, $020C, $028C, $030C (the first column, four rows) and $0190, $0210, $0290, $0310 (the second column): byte offsets in the BG2 buffer; each step of 4 is one 2 x 2 icon.
; Clobbers: n/a (data).

WeaponIconPositions [
  #$018C   ;00
  #$020C   ;01
  #$028C   ;02
  #$030C   ;03
  #$0190   ;04
  #$0210   ;05
  #$0290   ;06
  #$0310   ;07
]
---------------------------------------------

; BG offsets of the 8 armor icons on the equipment page.
; 
; When: DrawEquipIconRows.
; Sees: the armor icons next to the weapons.
; Why: see WeaponIconPositions.
; In: n/a (data): 8 words, index = the inventory slot.
; Out: the byte offsets of the icons in the BG2 buffer.
; Clobbers: n/a (data).

ArmorIconPositions [
  #$019C   ;00
  #$021C   ;01
  #$029C   ;02
  #$031C   ;03
  #$01A0   ;04
  #$0220   ;05
  #$02A0   ;06
  #$0320   ;07
]
---------------------------------------------

; BG offsets of the 8 magic icons on the equipment page.
; 
; When: DrawEquipIconRows.
; Sees: the spell icons below the armor.
; Why: see WeaponIconPositions.
; In: n/a (data): 8 words, index = the inventory slot.
; Out: the byte offsets of the icons in the BG2 buffer.
; Clobbers: n/a (data).

MagicIconPositions [
  #$01AC   ;00
  #$022C   ;01
  #$02AC   ;02
  #$032C   ;03
  #$01B0   ;04
  #$0230   ;05
  #$02B0   ;06
  #$0330   ;07
]
---------------------------------------------

; BG offsets of the 40 item icons of the item page.
; 
; When: DrawItemIconGrid (6 call sites of the item menu).
; Sees: the item grid of the inventory.
; Why: see WeaponIconPositions.
; In: n/a (data): 40 words, index = the item slot ($1B36 + n); the first values are $018C, $0190, $0194, $0198, $019C.
; Out: the byte offset of each icon's top-left cell in the BG2 buffer (DrawInventoryIcon).
; Clobbers: n/a (data).

ItemIconPositions [
  #$018C   ;00
  #$0190   ;01
  #$0194   ;02
  #$0198   ;03
  #$019C   ;04
  #$01A0   ;05
  #$01A4   ;06
  #$01A8   ;07
  #$01AC   ;08
  #$01B0   ;09
  #$020C   ;0A
  #$0210   ;0B
  #$0214   ;0C
  #$0218   ;0D
  #$021C   ;0E
  #$0220   ;0F
  #$0224   ;10
  #$0228   ;11
  #$022C   ;12
  #$0230   ;13
  #$028C   ;14
  #$0290   ;15
  #$0294   ;16
  #$0298   ;17
  #$029C   ;18
  #$02A0   ;19
  #$02A4   ;1A
  #$02A8   ;1B
  #$02AC   ;1C
  #$02B0   ;1D
  #$030C   ;1E
  #$0310   ;1F
  #$0314   ;20
  #$0318   ;21
  #$031C   ;22
  #$0320   ;23
  #$0324   ;24
  #$0328   ;25
  #$032C   ;26
  #$0330   ;27
]
---------------------------------------------

; The eight single-bit masks $01 to $80.
; 
; When: TestBitInArray, SetBitInArray and ClearBitInArray (lib_bit_array), for every switch, flag and chest array.
; Sees: a chest stays open, a lair stays released, an event stays done.
; Why: a table lookup of 1 << (n and 7) avoids a shift loop.
; In: n/a (data): index = bit number and 7.
; Out: the byte mask.
; Clobbers: n/a (data).

SwitchBitMasks #0102040810204080
---------------------------------------------

; The direction the player faces for each of his 44 animation ids.
; 
; When: GetPlayerFacing (talk, chests), ApplyPlayerWeaponPose and RunFlameBall.
; Sees: the hero talks to or opens what is in front of him, whatever pose he is in.
; Why: the facing is derived from the animation id, so every walking, standing and attack pose maps to one of four directions.
; In: n/a (data): 44 bytes, index = animation id $1E of the player ($2C and up are not valid).
; Out: 0 up, 1 down, 2 right, 3 left. The idle ids $00-$03 give down, up, left, right.
; Clobbers: n/a (data).

PlayerFacingByAnim #0100030201010000030302020101000003030202000000000000000000000000010003020202030301010000
---------------------------------------------

; The direction of movement for each of the player's 44 animation ids.
; 
; When: GetMoveDirectionOfAnim (SlideAroundCorner).
; Sees: nothing directly; the sidestep and backstep poses move in a direction other than their facing.
; Why: facing and movement direction are separate tables, so the crab-walk poses can face one way and move another.
; In: n/a (data): 44 bytes, index = animation id.
; Out: 0 up, 1 down, 2 right, 3 left.
; Clobbers: n/a (data).

PlayerMoveDirByAnim #0100030201000001030202030203030201000001000000000000000000000000010003020202030301010000
---------------------------------------------

; The vertical offset of the weapon sprite for each of the player's 44 animation ids.
; 
; When: FinishPlayerMove every frame, and one scene actor of the Underground Castle.
; Sees: the sword bobs one pixel with the walking steps.
; Why: the weapon is its own actor and follows the hero's pose from a table.
; In: n/a (data): 44 words, index = animation id x 2.
; Out: 0 or 1 pixel.
; Clobbers: n/a (data).

WeaponYOffsetByAnim [
  #$0001   ;00
  #$0000   ;01
  #$0001   ;02
  #$0000   ;03
  #$0001   ;04
  #$0001   ;05
  #$0000   ;06
  #$0000   ;07
  #$0001   ;08
  #$0001   ;09
  #$0000   ;0A
  #$0000   ;0B
  #$0001   ;0C
  #$0001   ;0D
  #$0000   ;0E
  #$0000   ;0F
  #$0001   ;10
  #$0001   ;11
  #$0000   ;12
  #$0000   ;13
  #$0000   ;14
  #$0000   ;15
  #$0000   ;16
  #$0000   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$0000   ;1C
  #$0000   ;1D
  #$0000   ;1E
  #$0000   ;1F
  #$0000   ;20
  #$0000   ;21
  #$0000   ;22
  #$0001   ;23
  #$0001   ;24
  #$0001   ;25
  #$0000   ;26
  #$0000   ;27
  #$0001   ;28
  #$0001   ;29
  #$0000   ;2A
  #$0000   ;2B
]
---------------------------------------------

; The colours of the HP and enemy gauge by tens of units.
; 
; When: DrawGaugeBar, whenever the HUD HP bar or the enemy bar is drawn.
; Sees: a bar that changes from dark blue (below 50) through lighter steps to white at 100 and more; it shows the tens above 50 that the bar's 25 tiles cannot (walkthrough level-up.md).
; Why: the HP can exceed what the bar shows, so the colour carries the extra.
; In: n/a (data): 13 BGR555 words, index = floor(units / 10); the entries are $79E0 (five times), $7AE0, $5FC0, $03D7, $03DE, $3FDE and $7BDE (three times).
; Out: the colour stored in cgram_buffer (colour 10 or 14). A value of 130 or more reads past the table (OQ-I010-5).
; Clobbers: n/a (data).

GaugeColorLadder [
  #$79E0   ;00
  #$79E0   ;01
  #$79E0   ;02
  #$79E0   ;03
  #$79E0   ;04
  #$7AE0   ;05
  #$5FC0   ;06
  #$03D7   ;07
  #$03DE   ;08
  #$3FDE   ;09
  #$7BDE   ;0A
  #$7BDE   ;0B
  #$7BDE   ;0C
]
---------------------------------------------

; The 21 long pointers to the song data.
; 
; When: MusicLoadUpload, with the track number of the music-load actor ($30) as the index.
; Sees: the music of a scene or a boss after a change.
; Why: the songs are uploaded to the sound chip one at a time, so the game only needs the address of each.
; In: n/a (data): 3-byte pointers, index = track number 0-20.
; Out: the long address copied to dp$29-$2B for the IPL upload (engine_spc_ipl_upload.UploadSpcStream).
; Clobbers: n/a (data).

MusicPointerTable [
  @music_0F6D31   ;00
  @music_0D6E9C   ;01
  @music_0CBCAF   ;02
  @music_052CC8   ;03
  @music_0CC66C   ;04
  @music_0D2D18   ;05
  @music_0D46E4   ;06
  @music_0D574E   ;07
  @music_08703D   ;08
  @music_0A6F8A   ;09
  @music_0BB3E4   ;0A
  @music_0C73F8   ;0B
  @music_0BEFCA   ;0C
  @music_0B52E8   ;0D
  @music_0C0000   ;0E
  @music_02F66C   ;0F
  @music_0BD265   ;10
  @music_0AEC48   ;11
  @music_0C94E8   ;12
  @music_0DB13D   ;13
  @music_0C6897   ;14
]
---------------------------------------------

; The graphics source of each of the 8 spells.
; 
; When: LoadEquippedMagicGfx, after every menu close and scene load.
; Sees: the effect tiles of the equipped spell.
; Why: only one spell's graphics fit in VRAM, so they are swapped.
; In: n/a (data): 8 long pointers, index = equipped_magic - $11.
; Out: graphics_07B000 + 0, 0, $800, $1000, $1000, $1800, $1800, $800 (each $800 bytes are DMAed to VRAM word $2600; some spells share graphics).
; Clobbers: n/a (data).

MagicGraphicsPointers [
  @graphics_07B000   ;00
  @graphics_07B000   ;01
  @graphics_07B000+800   ;02
  @graphics_07B000+1000   ;03
  @graphics_07B000+1000   ;04
  @graphics_07B000+1800   ;05
  @graphics_07B000+1800   ;06
  @graphics_07B000+800   ;07
]
---------------------------------------------

; The palette of each of the 8 spells.
; 
; When: LoadEquippedMagicGfx.
; Sees: the colours of the equipped spell.
; Why: see MagicGraphicsPointers.
; In: n/a (data): 8 long pointers, index = equipped_magic - $11.
; Out: palette_07D000 + $20 x n (32 bytes each, copied to cgram_buffer + $160).
; Clobbers: n/a (data).

MagicPalettePointers [
  @palette_07D000   ;00
  @palette_07D000+20   ;01
  @palette_07D000+40   ;02
  @palette_07D000+60   ;03
  @palette_07D000+80   ;04
  @palette_07D000+A0   ;05
  @palette_07D000+C0   ;06
  @palette_07D000+E0   ;07
]
---------------------------------------------

; The EXP thresholds of the 50 levels.
; 
; When: WatchForLevelUp, every frame.
; Sees: the level rises when the hero's EXP reaches the next value (walkthrough level-up.md: 100, 280, 580, 1,000, ... up to 99,999,999; the level cap is 50).
; Why: the thresholds are irregular, so a table replaces a formula.
; In: n/a (data): 51 rows of 4 bytes at level x 4: two words, the high word first, each 4 BCD digits (row 1 = $0000, $0100 = 100; row 47 = $7200, $0000 = 72,000,000). Row 0 is unused; rows 49 and 50 are $9999, $9999.
; Out: player_exp_next and its high word. All 49 thresholds of the walkthrough's level-up table match the values here.
; Clobbers: n/a (data).

LevelExpThresholds [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0100   ;03
  #$0000   ;04
  #$0280   ;05
  #$0000   ;06
  #$0580   ;07
  #$0000   ;08
  #$1000   ;09
  #$0000   ;0A
  #$2000   ;0B
  #$0000   ;0C
  #$3200   ;0D
  #$0000   ;0E
  #$4500   ;0F
  #$0000   ;10
  #$5800   ;11
  #$0000   ;12
  #$7600   ;13
  #$0000   ;14
  #$9600   ;15
  #$0001   ;16
  #$2400   ;17
  #$0001   ;18
  #$5000   ;19
  #$0001   ;1A
  #$9000   ;1B
  #$0002   ;1C
  #$5000   ;1D
  #$0003   ;1E
  #$2000   ;1F
  #$0004   ;20
  #$2000   ;21
  #$0005   ;22
  #$9000   ;23
  #$0008   ;24
  #$3000   ;25
  #$0011   ;26
  #$5000   ;27
  #$0016   ;28
  #$0000   ;29
  #$0022   ;2A
  #$0000   ;2B
  #$0030   ;2C
  #$0000   ;2D
  #$0042   ;2E
  #$0000   ;2F
  #$0057   ;30
  #$0000   ;31
  #$0076   ;32
  #$0000   ;33
  #$0095   ;34
  #$0000   ;35
  #$0120   ;36
  #$0000   ;37
  #$0150   ;38
  #$0000   ;39
  #$0185   ;3A
  #$0000   ;3B
  #$0225   ;3C
  #$0000   ;3D
  #$0270   ;3E
  #$0000   ;3F
  #$0320   ;40
  #$0000   ;41
  #$0375   ;42
  #$0000   ;43
  #$0440   ;44
  #$0000   ;45
  #$0500   ;46
  #$0000   ;47
  #$0600   ;48
  #$0000   ;49
  #$0720   ;4A
  #$0000   ;4B
  #$0850   ;4C
  #$0000   ;4D
  #$1000   ;4E
  #$0000   ;4F
  #$1250   ;50
  #$0000   ;51
  #$1580   ;52
  #$0000   ;53
  #$1950   ;54
  #$0000   ;55
  #$2500   ;56
  #$0000   ;57
  #$3400   ;58
  #$0000   ;59
  #$4600   ;5A
  #$0000   ;5B
  #$5900   ;5C
  #$0000   ;5D
  #$7200   ;5E
  #$0000   ;5F
  #$8500   ;60
  #$0000   ;61
  #$9999   ;62
  #$9999   ;63
  #$9999   ;64
  #$9999   ;65
]
---------------------------------------------

; The start of the 320-byte signed sine: 256 values close to 127 x sin(2 pi x i / 256) (largest deviation 1.9; none of six plain rounding rules reproduces them) and 64 more for the cosine.
; 
; When: RunSoulOrbController (the orb's orbit), BuildRotationMatrix and BuildRotationMatrixAlt (the Mode 7 rotation), FillSineWaveTables (dead code) and a few boss scripts of the World of Evil.
; Sees: the soul orb circling the hero, the rotating Mode 7 maps.
; Why: a lookup avoids computing sines on the 65816.
; In: n/a (data): signed bytes, index = angle (0-255, 256 = a full turn); cosine = the entry at angle + 64, which is why the table runs 64 bytes past the end.
; Out: this part holds the first 64 entries: $00, $03, $06, $09 ... rising towards $7F; the rest is SineTableTail.
; Clobbers: n/a (data).

SineTable #000306090C0F1215181C1F2225282B2E303336393C3F414447494C4E515355585A5C5E60626466686A6C6D6F70727375767778797A7B7C7C7D7E7E7F7F7F7F7F
---------------------------------------------

; The rest of the 320-byte sine: entries 64 to 319.
; 
; When: as SineTable.
; Sees: as SineTable.
; Why: the extraction splits the table at this label; it is one table with SineTable.
; In: n/a (data): signed bytes; entry 64 is $7F, the peak.
; Out: the descending half and the negative half of the sine, then the 64 entries the cosine needs. The negative half is not the exact negation of the positive one (12 of 128 entries match: the table rises 0, 3, 6, 9 ... and falls 0, -4, -7, -10 ...).
; Clobbers: n/a (data).

SineTableTail #7F7F7F7F7F7F7E7E7D7C7C7B7A79787776757372706F6D6C6A68666462605E5C5A585553514E4C494744413F3C393633302E2B2825221F1C1815120F0C09060300FCF9F6F3F0EDEAE7E3E0DDDAD7D4D1CFCCC9C6C3C0BEBBB8B6B3B1AEACAAA7A5A3A19F9D9B9997959392908F8D8C8A8988878685848383828181818181818181818181818181818283838485868788898A8C8D8F9092939597999B9D9FA1A3A5A7AAACAEB1B3B6B8BBBEC0C3C6C9CCCFD1D4D7DADDE0E3E7EAEDF0F3F6F9FC000306090C0F1215181C1F2225282B2E303336393C3F414447494C4E515355585A5C5E60626466686A6C6D6F70727375767778797A7B7C7C7D7E7E7F7F7F7F7F
---------------------------------------------

; The half-width of a circle for each of its 128 rows.
; 
; When: BuildSoulOrbCircleWindow (lib_hdma_window_effects), every frame after a Soul effect (Light, Reality, Detection, Shield) has started (OQ-I033-9).
; Sees: the circular window of radius $40 pixels around the soul orb that the four Soul effects cut into the screen.
; Why: the width of each row of a circle is data, so no square root is needed.
; In: n/a (data): 128 bytes, index = row; the first values are $00, $04, $0A, $0F, $12, $15, $18, $1A.
; Out: the half-width in pixels; the table is mirrored about row 64 (C[i] = C[128 - i] for 125 of 127 rows; rows 1 and 127 hold 4 and 0) and peaks at $3F for rows 59 to 69.
; Clobbers: n/a (data).

CircleHalfWidths #00040A0F1215181A1C1E202223252627292A2B2C2D2E2F303031323334343535363737383839393A3A3A3B3B3C3C3C3C3D3D3D3D3E3E3E3E3E3E3E3F3F3F3F3F3F3F3F3F3F3F3E3E3E3E3E3E3E3D3D3D3D3C3C3C3C3B3B3A3A3A393938383737363535343433323130302F2E2D2C2B2A292726252322201E1C1A1815120F0A00