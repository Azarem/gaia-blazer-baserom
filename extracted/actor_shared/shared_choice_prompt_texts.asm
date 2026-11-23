; Option windows of the choice menus: Yes / No, Yes, Record / Move / Quit, Record / Quit and Stay / Go back (file offsets 85762-85875, SNES $02:CF02-$CF73, bank 02).
; 
; === MODEL ===
; A string here is only the option window, never the question: the question is the COP [01] dialogue printed just before. Cop1A_ChoiceMenu (27 scripts: 18 Yes / No, 6 Stay / Go back, 1 each of the other three) prints the string with PrintTextString, then calls RunChoiceMenu with the option count from its own operand, and stores the chosen index in choice_result ($03D0). Cop02_PromptYesNo (no script uses it) always prints ChoiceYesNoText.
; Layout rule shared by all five strings: [CUR:o] is the window origin (BG3 byte offset, row = o / $40, column = (o mod $40) / 2; every window starts in column 4 and ends on tile row 15: origin row + h + 1 = 15), [07:w,h] draws the frame (w equals the widest option line including its leading blank, h is two tile rows per option), and every option is one text line with a leading blank (the arrow cell). Options are separated by [N][N] because a text line is two tiles tall. The trailing [CUR:c] draws nothing: c = origin + $82 (one row-pair down, one column right) is the cursor cell of the first option, and PrintTextString returns it in X, which is exactly what RunChoiceMenu expects.
; The option count in the COP operand must equal the number of lines in the string: the string does not carry it.
; 
; === NOTES ===
; - Which actor asks which string is documented at each part; the questions themselves are in the actor files.
; - The Master's menu is the walkthrough's northern square of Up Above: 'The northern square will allow you to save your adventure, as well as move on later in the game' (01-in-the-beginning.md; also 'go there to heal and save if wanted', 06-dr-leos-lab.md). 'Record' is the saving; 'Move' is the later 'move on', added once the Grass Valley chief has handed over the Brown Stone; it leaves for the Up Above hub (A00S09), where the walker starts on the stop of the current world (cm_npc_master_move_to_hub_0076B2).
---------------------------------------------

?BANK 02

---------------------------------------------

; Yes / No option window (2 options).
; 
; When: Cop1A_ChoiceMenu with count 2 in 18 scripts (16 actor scripts of all six worlds, plus the two questions 'Is this okay?' and 'Do you wish to continue?' of the Master's menu in shared_actor_helpers_bank0) and the fixed prompt of Cop02_PromptYesNo (no script uses it).
; Sees: a window at row 10, column 4 (4 x 4) with ' Yes' and ' No'; the arrow starts on Yes.
; Why: the common confirmation window, so a script supplies only the question.
; In: n/a (data). Printed with Y = this string; the trailing [CUR:30A] is the arrow cell of Yes.
; Out: n/a. Index 0 = Yes, 1 = No; Cop1A stores the index in choice_result, Cop02 skips its jump on Yes; Y (cancel) takes the cancel pointer of Cop1A or the jump of Cop02.
; Clobbers: n/a.

ChoiceYesNoText |[CUR:288][07:4,4] Yes[N][N] No[CUR:30A]|
---------------------------------------------

; Single-option window with only 'Yes' (1 option).
; 
; When: Cop1A_ChoiceMenu with count 1 in one script: the dream character's plea in the Underground Castle actors (gv_underground_castle_actors, code_01A491), which ends 'Please promise me that you will one day return-'.
; Sees: a window at row 12, column 4 (4 x 2) holding ' Yes'.
; Why: a promise that can only be accepted; there is no No. The window sits lower than the Yes / No window so that its bottom edge is on the same row (15) as every other choice window.
; In: n/a (data). The trailing [CUR:38A] is the arrow cell.
; Out: n/a. Index 0 is the only answer; Y (cancel) takes the cancel pointer of the script (code_01A4B1).
; Clobbers: n/a.

ChoiceYesOnlyText |[CUR:308][07:4,2] Yes[CUR:38A]|
---------------------------------------------

; Record / Move / Quit option window (3 options): the Master's menu once 'Move' is available.
; 
; When: Cop1A_ChoiceMenu with count 3 in cm_npc_master_greeting_with_move_00769C of shared_actor_helpers_bank0 (the Master's menu actor cm_npc_master_shrine_menu_00766C): reached when COP [07] ( #$9B00 ) finds event flag $1B00 set. Another script sets it: code_01A0C6 of gv_village_actors_019475 runs COP [09] ( #$9B00 ) right after the Master's voice says the Brown Stone is a key to the World of Evil (walkthrough 02-grass-valley.md: the chief hands over the Brown Stone).
; Sees: a window at row 8, column 4 (7 x 6) with ' Record', ' Move ' and ' Quit', after the Master's 'how can I help you?'.
; Why: the Master offers saving at any time; Move is the third entry, which the walkthrough calls 'move on later in the game' (01-in-the-beginning.md).
; In: n/a (data). The trailing [CUR:28A] is the arrow cell of Record.
; Out: n/a. Index 0 Record (asks 'I will record all you have accomplished- Is this okay?' and calls lib_save_system.SaveGameToSlot), 1 Move (sets scene_next = 9 and warp_dest_x / warp_dest_y from cm_data_master_move_hub_positions_0076D3 by world_index; scene 9 of area 0 is the Up Above hub A00S09, where the map walker starts on the stop of the current world), 2 Quit (and Y) = the farewell cm_npc_master_farewell_007754.
; Clobbers: n/a.

ChoiceRecordMoveQuitText |[CUR:208][07:7,6] Record[N][N] Move [N][N] Quit[CUR:28A]|
---------------------------------------------

; Record / Quit option window (2 options): the Master's menu before 'Move' is available.
; 
; When: Cop1A_ChoiceMenu with count 2 in cm_npc_master_greeting_00767F of shared_actor_helpers_bank0 (the Master's menu actor cm_npc_master_shrine_menu_00766C), when event flag $1B00 is clear.
; Sees: a window at row 10, column 4 (7 x 4) with ' Record' and ' Quit'.
; Why: the same menu as ChoiceRecordMoveQuitText without the third entry.
; In: n/a (data). The trailing [CUR:30A] is the arrow cell of Record.
; Out: n/a. Index 0 Record (cm_npc_master_record_0076EF), any other answer and Y = the farewell cm_npc_master_farewell_007754.
; Clobbers: n/a.

ChoiceRecordQuitText |[CUR:288][07:7,4] Record[N][N] Quit[CUR:30A]|
---------------------------------------------

; Stay / Go back option window (2 options): the return-to-hub prompt of each world.
; 
; When: Cop1A_ChoiceMenu with count 2 in six hub-return scripts, one per world, each after the question '[10]Would you like to return to <place>?' (the places printed by the strings next to the scripts: Grass Valley, GreenWood, the Seabed Palace, the location of the Mountain of Souls, Dr-Leo s Laboratory, the outside of Magridd Castle; the St. Elles and Mountain of Souls prompts are the Fairy Gem prompts of OQ-I017-1 and OQ-I017-2).
; Sees: a window at row 10, column 4 (8 x 4) with ' Stay' and ' Go back'.
; Why: the same two answers for every world, so the shared string is used six times.
; In: n/a (data). The trailing [CUR:30A] is the arrow cell of Stay.
; Out: n/a. Index 0 Stay prints a 'Come back whenever you feel like returning' line (Y, the cancel pointer of every one of the six scripts, runs the same Stay code); index 1 Go back prints 'Allright, please continue-', increments contact_lock and warps with COP [10] to the hub of the world: area $01, $04, $06, $0A, $0D and $10 (words $0101, $0104, $0106, $010A, $010D, $0110; scene $01).
; Clobbers: n/a.

ChoiceStayGoBackText |[CUR:288][07:8,4] Stay[N][N] Go back[CUR:30A]|