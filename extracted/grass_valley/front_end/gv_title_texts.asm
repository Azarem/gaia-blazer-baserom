; Title screen, tile block and save slot menu strings (file offsets 80679-80772, 82294-82321 and 82864-83036, SNES $02:BB27-$BB84, $02:C176-$C191 and $02:C3B0-$C45C, bank 02).
; 
; === MODEL ===
; TitlePushStartText and TitleCopyrightText are printed by the title actor (gv_obj_title_and_prologue_0066FC in gv_front_end, meta entry $56): the copyright block first, then 'PUSH START' at BG3 offset $4D6 ([09] = two-row glyphs). The walkthrough says the player presses Start at the title screen to reach the file selection menu. TileBlockText draws a 4x5 block of tiles at BG3 rows 11-15, columns 14-17 from the insert list entries 4-8 ([02:n]); it is printed by gv_obj_boot_loader_0066C6 (gv_front_end) and what it draws is not identified (OQ-I011-9).
; SaveSlotMenuText draws the file selection window (DrawSaveSlotMenu in engine_title_file_select): 'Please choose a record', the column heads Name, Lev and Area, 'No1:' to 'No4:' and 'Erase record'. The four slot lines are filled in by SaveSlotLineTemplates, an 80-byte table that is really four 20-byte STRINGS, stepped by $14: [CUR:o1][02:3][CUR:o2][06:2,0450][CUR:o3][06:1,0452] and an end byte. [02:3] is the slot name (insert entry 3, $0447), [06:2,0450] the level as BCD and [06:1,0452] a word read from the save block at +$1B90, the value the file select later loads into scene_next (OQ-I011-12). The cursor offsets are $2D4, $2E8 and $2F2 for slot 1 and each next slot adds $C0.
; 
; === NOTES ===
; - The strings use the intro font: the apostrophe prints as a blank, the period as '-'.
; - SaveSlotLineTemplates is typed Binary in the extract because it is mostly control codes; it is text.
---------------------------------------------

?BANK 02

---------------------------------------------

; 'PUSH START' on the title screen.
; 
; When: the title actor (gv_obj_title_and_prologue_0066FC in gv_front_end), after the copyright block.
; Sees: the words PUSH START at the lower middle of the title screen.
; Why: the walkthrough: pressing Start at the title screen leads to the file selection menu.
; In: PrintTextString with Y = this string.
; Out: two-row glyphs at BG3 offset $4D6.

TitlePushStartText |[09][CUR:4D6]PUSH START|
---------------------------------------------

; The three copyright lines of the title screen.
; 
; When: the title actor, before PUSH START.
; Sees: ALL RIGHTS RESERVED, COPYRIGHT 1992 QUINTET/ENIX and LICENSED BY NINTENDO, indented with [14:6] and [14:9] blank runs.
; Why: legal text of the cartridge.
; In: PrintTextString with Y = this string.
; Out: two-row glyphs from BG3 offset $5C0.

TitleCopyrightText |[09][CUR:5C0][14:6]ALL RIGHTS RESERVED[N]  COPYRIGHT 1992 QUINTET/ENIX[N][14:9]LICENSED BY NINTENDO|
---------------------------------------------

; A 4x5 block of tiles on BG3.
; 
; When: gv_obj_boot_loader_0066C6 (gv_front_end).
; Sees: a picture made of tiles at BG3 rows 11-15, columns 14-17; which picture is open (OQ-I011-9).
; Why: the insert list entries 4-8 (the ListTileBlockRow1-5 tile strings of lib_text_render) carry the tile numbers, one row each.
; In: PrintTextString with Y = this string.
; Out: [CUR:2DC], [CUR:31C], [CUR:35C], [CUR:39C], [CUR:3DC] each followed by one insert entry ([02:4] to [02:8]).

TileBlockText |[09][0A][CUR:2DC][02:4][CUR:31C][02:5][CUR:35C][02:6][CUR:39C][02:7][CUR:3DC][02:8]|
---------------------------------------------

; Draws the file selection menu.
; 
; When: DrawSaveSlotMenu (engine_title_file_select), when the file selection screen opens.
; Sees: a 22x22 window with 'Please choose a record', the heads Name, Lev and Area, the four slots 'No1:' to 'No4:' and 'Erase record'.
; Why: the slot contents are drawn separately from SaveSlotLineTemplates, so the frame and labels are fixed text.
; In: PrintTextString with Y = this string.
; Out: window at $88 (size 22x22), the prompt at $14A, the heads at $218, $226 and $22E and the slot labels from $2CA.

SaveSlotMenuText |[CUR:88][07:16,16][CUR:14A]Please choose a record[CUR:218]Name[CUR:226]Lev[CUR:22E]Area[CUR:2CA] No1:[N][N][N] No2:[N][N][N] No3:[N][N][N] No4:[N][N][N] Erase record|
---------------------------------------------

; Four 20-byte template strings for the four save slot lines.
; 
; When: DrawSaveSlotMenu (engine_title_file_select), once per slot (stepped by $14).
; Sees: on each slot line the saved name, the level and the area number.
; Why: the text renderer already knows how to print a name, a BCD value and a word, so the line is a string of control codes.
; In: PrintTextString with Y = the slot's template.
; Out: [CUR:o1][02:3] (the slot name at $0447), [CUR:o2][06:2,0450] (the level), [CUR:o3][06:1,0452] and the end byte; the offsets are $2D4, $2E8 and $2F2 for slot 1, plus $C0 per slot.

SaveSlotLineTemplates #01D402020301E8020602500401F2020601520400019403020301A8030602500401B203060152040001540402030168040602500401720406015204000114050203012805060250040132050601520400