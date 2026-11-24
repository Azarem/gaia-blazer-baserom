; Banner strings (level up, pause banner with lair counter) and the location name list (file offsets 83222-83312 and 83906-85761, SNES $02:C516-$C570 and $02:C7C2-$CF01, bank 02).
; 
; === MODEL ===
; Level up: LevelUpText prints 'LEVEL UP !' (control code 03:24 = attribute) at BG3 offset $216 when the player gains a level (player_spells_level_up); LevelUpClearText overprints the same cells with ten blank glyphs.
; Pause banner (lib_main_loop_helpers, once per frame from the main loop): when Start is pressed it pauses the music and, unless A is held, prints LocationBannerText: a 24x2 window at $186 and then the name of the current location, chosen by [TBL:&LocationNameList,1C6A]. The control code reads the WORD at $1C6A and uses it as the string number; $1C6B is never written, so the number is location_id (OQ-I011-11). When no_combat_scene is 0 it also prints LairCounterText: a 12x4 window at $51E with 'Monster Lair / Remaining' and two BCD digits of lairs_left converted to lair_count_bcd ($1B80). PauseCloseText erases both windows when the player resumes. The walkthrough confirms the lair count: 'the number of Monster Lairs in the area can be found by pressing the Start Button' (01-in-the-beginning.md).
; 
; === LOCATION NAMES ===
; LocationNameList holds 128 words (the address of the name of each location id) followed by the 128 name strings, in id order. Ids without a scene profile have a name that is a single terminator byte (25-27, 35-3B, 48-4F, 5D-63, 74-77, 7E, 7F). The ids 0F-13 have a profile but an empty name (no banner). Names are centred with a [14:n] blank run and printed with the intro font, in which the apostrophe prints as a blank and the period as '-' (so the extract shows 'Leo s Paintings' and 'St- Elles Shrine').
; 
; === NOTES ===
; - The names agree with the walkthrough and plans/doc-audit/walkthrough-crosswalk.md apart from capitalisation ('power plant', 'Shore reef of Rockbird', 'Underground lake,Lune') and the two rooms the ROM calls 'A dream 1' (ids 5A and 69, OQ-I004-14). No discrepancy row arises.
; - The four Soul names (SoulOf...Text) and the menu frames lie in the same address range but belong to the menu batch (lib_menus).
---------------------------------------------

?BANK 02

---------------------------------------------

; Prints 'LEVEL UP !' on BG3.
; 
; When: the level-up sequence (player_spells_level_up), once per level gained.
; Sees: the words LEVEL UP !
; Why: tells the player that the level went up.
; In: PrintTextString with Y = this string.
; Out: ten glyph cells at BG3 offset $216 with the attribute from [03:24]. [09] selects the two-row glyphs.

LevelUpText |[09][03:24][CUR:216]LEVEL UP !|
---------------------------------------------

; Erases the level-up banner.
; 
; When: the level-up sequence, after the banner has been shown.
; Sees: the banner disappears.
; Why: BG3 has no background, so the cells are overprinted with a blank glyph.
; In: PrintTextString with Y = this string.
; Out: ten blank glyphs at BG3 offset $216.

LevelUpClearText |[09][CUR:216]██████████|
---------------------------------------------

; Prints the pause banner with the name of the current location.
; 
; When: lib_main_loop_helpers, when Start is pressed and A is not held.
; Sees: a two-row window at the top with the name of the place ('Grass Valley highlands', 'Leo s Laboratory').
; Why: the player can see where they are; the name is data, not code.
; In: PrintTextString with Y = this string; location_id = the string number ([TBL] reads the word at $1C6A).
; Out: ten blanks at $216 (the cells of LevelUpText), window 24x2 at $186, then the name from LocationNameList.

LocationBannerText |[CUR:216][14:A][CUR:186][07:18,2][TBL:&LocationNameList,1C6A]|
---------------------------------------------

; Prints the Monster Lair counter of the pause banner.
; 
; When: lib_main_loop_helpers, when Start is pressed, A is not held and no_combat_scene is 0.
; Sees: 'Monster Lair Remaining nn': how many lairs are left to release in this area.
; Why: the walkthrough tells the player to press Start for the count.
; In: PrintTextString with Y = this string; lair_count_bcd ($1B80) = the two BCD digits of lairs_left.
; Out: window 12x4 at $51E with the text and the digits ([06:2,1B80]).

LairCounterText |[CUR:51E][07:C,4]Monster Lair[N][N]Remaining [06:2,1B80]|
---------------------------------------------

; Erases the pause banner windows.
; 
; When: lib_main_loop_helpers, when the player resumes.
; Sees: both windows vanish.
; Why: closes the banner and the counter in one print.
; In: PrintTextString with Y = this string.
; Out: [08:186] erases the banner window and [08:51E] the counter window.

PauseCloseText |[08:186][08:51E]|
---------------------------------------------

; 128 words (address of each location's name) and then the 128 names.
; 
; When: the [TBL] control code of LocationBannerText, once per pause banner.
; Sees: the name of the place in the banner.
; Why: ids are sparse, so unused ids point at a one-byte empty string.
; In: string number = location_id ($1C6A).
; Out: the string address.

LocationNameList [
  &LocationName00   ;00
  &LocationName01   ;01
  &LocationName02   ;02
  &LocationName03   ;03
  &LocationName04   ;04
  &LocationName05   ;05
  &LocationName06   ;06
  &LocationName07   ;07
  &LocationName08   ;08
  &LocationName09   ;09
  &LocationName0A   ;0A
  &LocationName0B   ;0B
  &LocationName0C   ;0C
  &LocationName0D   ;0D
  &LocationName0E   ;0E
  &LocationName0F   ;0F
  &LocationName10   ;10
  &LocationName11   ;11
  &LocationName12   ;12
  &LocationName13   ;13
  &LocationName14   ;14
  &LocationName15   ;15
  &LocationName16   ;16
  &LocationName17   ;17
  &LocationName18   ;18
  &LocationName19   ;19
  &LocationName1A   ;1A
  &LocationName1B   ;1B
  &LocationName1C   ;1C
  &LocationName1D   ;1D
  &LocationName1E   ;1E
  &LocationName1F   ;1F
  &LocationName20   ;20
  &LocationName21   ;21
  &LocationName22   ;22
  &LocationName23   ;23
  &LocationName24   ;24
  &LocationName25   ;25
  &LocationName26   ;26
  &LocationName27   ;27
  &LocationName28   ;28
  &LocationName29   ;29
  &LocationName2A   ;2A
  &LocationName2B   ;2B
  &LocationName2C   ;2C
  &LocationName2D   ;2D
  &LocationName2E   ;2E
  &LocationName2F   ;2F
  &LocationName30   ;30
  &LocationName31   ;31
  &LocationName32   ;32
  &LocationName33   ;33
  &LocationName34   ;34
  &LocationName35   ;35
  &LocationName36   ;36
  &LocationName37   ;37
  &LocationName38   ;38
  &LocationName39   ;39
  &LocationName3A   ;3A
  &LocationName3B   ;3B
  &LocationName3C   ;3C
  &LocationName3D   ;3D
  &LocationName3E   ;3E
  &LocationName3F   ;3F
  &LocationName40   ;40
  &LocationName41   ;41
  &LocationName42   ;42
  &LocationName43   ;43
  &LocationName44   ;44
  &LocationName45   ;45
  &LocationName46   ;46
  &LocationName47   ;47
  &LocationName48   ;48
  &LocationName49   ;49
  &LocationName4A   ;4A
  &LocationName4B   ;4B
  &LocationName4C   ;4C
  &LocationName4D   ;4D
  &LocationName4E   ;4E
  &LocationName4F   ;4F
  &LocationName50   ;50
  &LocationName51   ;51
  &LocationName52   ;52
  &LocationName53   ;53
  &LocationName54   ;54
  &LocationName55   ;55
  &LocationName56   ;56
  &LocationName57   ;57
  &LocationName58   ;58
  &LocationName59   ;59
  &LocationName5A   ;5A
  &LocationName5B   ;5B
  &LocationName5C   ;5C
  &LocationName5D   ;5D
  &LocationName5E   ;5E
  &LocationName5F   ;5F
  &LocationName60   ;60
  &LocationName61   ;61
  &LocationName62   ;62
  &LocationName63   ;63
  &LocationName64   ;64
  &LocationName65   ;65
  &LocationName66   ;66
  &LocationName67   ;67
  &LocationName68   ;68
  &LocationName69   ;69
  &LocationName6A   ;6A
  &LocationName6B   ;6B
  &LocationName6C   ;6C
  &LocationName6D   ;6D
  &LocationName6E   ;6E
  &LocationName6F   ;6F
  &LocationName70   ;70
  &LocationName71   ;71
  &LocationName72   ;72
  &LocationName73   ;73
  &LocationName74   ;74
  &LocationName75   ;75
  &LocationName76   ;76
  &LocationName77   ;77
  &LocationName78   ;78
  &LocationName79   ;79
  &LocationName7A   ;7A
  &LocationName7B   ;7B
  &LocationName7C   ;7C
  &LocationName7D   ;7D
  &LocationName7E   ;7E
  &LocationName7F   ;7F
]

LocationName00 |  Grass Valley Shrine |

LocationName01 | Grass Valley highlands|

LocationName02 | Child s secret passage|

LocationName03 |[14:6]Treasure room|

LocationName04 |The village Chief s room|

LocationName05 |Underground Castle, west|

LocationName06 |Underground Castle, east|

LocationName07 |[14:5]Leo s Paintings|

LocationName08 |[14:5]Leo s Paintings|

LocationName09 |[14:5]Leo s Paintings|

LocationName0A |[14:6]Tulip s Dream|

LocationName0B |[14:5]Leo s Paintings|

LocationName0C |Monster in the paintings|

LocationName0D |[14:7]Trial room|

LocationName0E |[14:6]Lisa s dream|

LocationName0F ||

LocationName10 ||

LocationName11 ||

LocationName12 ||

LocationName13 ||

LocationName14 |[14:4]GreenWood Shrine|

LocationName15 |[14:3]Woods of GreenWood|

LocationName16 |[14:6]A mole s hole|

LocationName17 |[14:3]A squirrel s house|

LocationName18 | Squirrel, the Exchanger|

LocationName19 |[14:3]Lostside, a marsh|

LocationName1A |[14:6]Water Shrine|

LocationName1B |[14:6]Water Shrine|

LocationName1C |[14:6]Water Shrine|

LocationName1D |[14:7]Fire Shrine|

LocationName1E |[14:7]Fire Shrine|

LocationName1F |[14:7]Fire Shrine|

LocationName20 |[14:6]Light Shrine|

LocationName21 |[14:6]Light Shrine|

LocationName22 | Tomb of a stone statue|

LocationName23 |[14:6]Bird s Dream|

LocationName24 |[14:5]Stump s Dream|

LocationName25 ||

LocationName26 ||

LocationName27 ||

LocationName28 |[14:4]St- Elles Shrine|

LocationName29 |  The Seabed Sanctuary|

LocationName2A | The Seabed of St- Elles|

LocationName2B |[14:4]The Secret Cave|

LocationName2C |[14:4]The Secret Cave|

LocationName2D |[14:3]A dolphin s dream|

LocationName2E |[14:8]Southerta|

LocationName2F | Shore reef of Rockbird|

LocationName30 |[14:8]Durean|

LocationName31 |[14:8]Blester|

LocationName32 |[14:6]A ghost ship|

LocationName33 |[14:6]Servas  dream|

LocationName34 | The Seabed of St- Elles|

LocationName35 ||

LocationName36 ||

LocationName37 ||

LocationName38 ||

LocationName39 ||

LocationName3A ||

LocationName3B ||

LocationName3C |  The Soul s Sanctuary|

LocationName3D |  Soul of Mountain House|

LocationName3E |  Mountain, North+slope|

LocationName3F |[14:5]Aurora s Ridge|

LocationName40 |[14:3]An old man s dream|

LocationName41 |[14:4]A passage to Lune|

LocationName42 |  Underground lake,Lune|

LocationName43 |[14:3]A mushroom s dream|

LocationName44 |[14:8]Poseidon|

LocationName45 |The top of Snow Mountain|

LocationName46 |[14:7]An ice hill|

LocationName47 |  Ice field of Laynole|

LocationName48 ||

LocationName49 ||

LocationName4A ||

LocationName4B ||

LocationName4C ||

LocationName4D ||

LocationName4E ||

LocationName4F ||

LocationName50 |  The Laboratory Shrine|

LocationName51 |[14:4]Leo s Laboratory|

LocationName52 |[14:4]Leo s Laboratory|

LocationName53 |[14:8]An attic|

LocationName54 |[14:7]A mice nest|

LocationName55 |[14:6]A cat s dream|

LocationName56 | Basement of Laboratory|

LocationName57 | Basement of Laboratory|

LocationName58 |[14:7]power plant|

LocationName59 |[14:8]Tin Doll|

LocationName5A |[14:8]A dream 1|

LocationName5B |[14:5]Model of a town|

LocationName5C |[14:5]Model of a town|

LocationName5D ||

LocationName5E ||

LocationName5F ||

LocationName60 ||

LocationName61 ||

LocationName62 ||

LocationName63 ||

LocationName64 |  Magridd Castle Shrine|

LocationName65 | Castle of King Magridd|

LocationName66 |[14:3]The torture chamber|

LocationName67 | Basement of the castle|

LocationName68 | Basement of the castle|

LocationName69 |[14:8]A dream 1|

LocationName6A |[14:5]The left tower|

LocationName6B |[14:5]The left tower|

LocationName6C |[14:8]A prison|

LocationName6D |[14:5]The right tower|

LocationName6E |[14:5]The right tower|

LocationName6F |[14:5]The right tower|

LocationName70 | A corridor to the dock|

LocationName71 | The dock for an airship|

LocationName72 | The deck of an airship|

LocationName73 |[14:4]A soldier s dream|

LocationName74 ||

LocationName75 ||

LocationName76 ||

LocationName77 ||

LocationName78 |  The Evil World Shrine|

LocationName79 |[14:6]World of Evil|

LocationName7A |[14:6]World of Evil|

LocationName7B |[14:5]Dazzling Space|

LocationName7C |[14:3]Deathtoll s Shrine|

LocationName7D |  Battle with Deathtoll|

LocationName7E ||

LocationName7F ||