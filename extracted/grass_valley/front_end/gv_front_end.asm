; The boot, title, prologue, ending and staff roll actors (bank 00, file offsets 26310 to 30315). The texts are in gv_title_texts, gv_prologue_texts and gv_epilogue_texts.
; 
; === SCENES ===
; - Boot, area 0 scene $0C (meta type $5B): gv_obj_boot_loader_0066C6 prints TileBlockText, uploads the SPC engine and the boot graphics and starts the title.
; - Title and prologue, area 0 scene $0A (meta type $56): gv_obj_title_and_prologue_0066FC. A Mode 7 title (BGMODE $0F, TM $11) pans and zooms, the three title sprite actors slide in (one from the left, two from the right, moved by gv_obj_title_sprite_motion_006A90), 'ALL RIGHTS RESERVED COPYRIGHT 1992 QUINTET/ENIX LICENSED BY NINTENDO' and PUSH START are printed, and if nobody presses Start the 14 prologue pages (IntroPage01Text-14) fade in and out with gv_fx_coldata_ramp_down_006A40 and gv_fx_coldata_ramp_up_006A25 before the title starts again. The walkthrough: 'After hearing the epic title screen music, you can press the Start Button to reach the file selection menu.' gv_obj_title_start_button_006B61 does that: on Start it reloads scene $0A with scene_variant = 1 and file_select_request ($0445) = 1, and the title actor then branches to engine_title_file_select.EnterFileSelect.
; - Ending, area 0 scene $0B (meta type $57): gv_obj_ending_sequence_00729D prints EndingPage1Text-7 (gv_epilogue_texts: 720 frames per page for the first four, 1080 for the last three, 112 frames between the pages) with a text curtain (gv_fx_ending_hdma_wipe_00758C) and a BG2 parallax (gv_fx_ending_hdma_scroll_0074E8). After the fourth page gv_obj_ending_scroll_0074D3 scrolls BG1 by 256 pixels and two sprite actors (gv_obj_ending_sprite_007460, gv_obj_ending_sprite_00748F) play animation steps keyed to front_end_step. The staff roll (gv_obj_staff_roll_007638) follows and the game continues in area 0 scene $0D (gv_up_above_trial_room_and_lisa_turbo_actors).
; 
; === SHARED VARIABLES ===
; - front_end_step ($0482): title: 0, set to 1 when the prologue starts, $FFFF while the title restarts (the sprite actors end on it); ending: 0, 1 when the BG1 scroll has finished, then 2, 3 and 4 as the two ending sprites and the main actor advance the animation steps.
; - ending_page_flag ($0466): 1 while an ending page is shown, 0 between the pages, $FFFF after the last page (the curtain actor opens, holds and closes on it).
; - file_select_request ($0445): 1 after Start was pressed on the title.
; 
; === NOTES ===
; - The ending of the story is told in gv_epilogue_texts: Grass Valley at sunset, the creatures looking at it, a light ray that nobody notices, and Lisa alone.
; - The scene after the staff roll is the closing scene with Lisa and Turbo (area 0 scene $0D, COP 10 with arrival animation 2); souls_flags is cleared here.
---------------------------------------------

?BANK 00

?INCLUDE 'engine_spc_ipl_upload'
?INCLUDE 'engine_title_file_select'
?INCLUDE 'gv_epilogue_texts'
?INCLUDE 'gv_prologue_texts'
?INCLUDE 'gv_title_texts'
?INCLUDE 'lib_boot_and_scene_init'
?INCLUDE 'lib_menu_screen_setup'
?INCLUDE 'lib_name_entry_and_staff_roll'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'lib_text_render'

!scene_variant                  031E
!joy_pressed                    0322
!joy_block_mask                 0326
!scroll_bg1_x                   033A
!scroll_bg3_x                   0386
!scroll_bg3_y                   0388
!player_actor                   039C
!asset_skip_mask                03B4
!vram_upload_flags              03B8
!file_select_request            0445
!reload_menu_gfx                0454
!m7x_shadow                     046A
!m7y_shadow                     046C
!m7_scale                       0480
!front_end_step                 0482
!souls_flags                    1B82
!BGMODE                         2105
!TM                             212C
!CGADSUB                        2131
!coldata_buffer                 7F0200

---------------------------------------------

; The boot actor.
; 
; When: meta type $5B in A00S0C, the first scene after power-on.
; Sees: TileBlockText on BG3 (a 4x5 block of tiles, OQ-I011-9) for one frame, then the title.
; Why: the SPC engine and the boot graphics are loaded here before any scene needs them.
; In: actor script, X = own slot.
; Out: joy_block_mask |= $3080, player_actor = X; after 1 frame code_0066DE uploads the SPC engine (engine_spc_ipl_upload.UploadSpcDriver), restores the scene gfx and palette and loads the boot graphics buffers, then COP 10 starts the title (area 0 scene $0A, arrival animation 1).
; Clobbers: A, Y.

gv_obj_boot_loader_0066C6 {
    LDA #$3080
    TSB $joy_block_mask
    STX $player_actor
    PHX 
    LDY #$&gv_title_texts.TileBlockText
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [1B] ( &code_0066DE, #$0001 )
}

---------------------------------------------
; Second step of the boot loader.
; 
; When: one frame after gv_obj_boot_loader_0066C6.
; Sees: no visible change of its own.
; Why: it runs once.
; In: actor script, X = own slot.
; Out: COP 10 to area 0 scene $0A (arrival animation 1, x 0, y 0); COP 91 and RTL.
; Clobbers: A, X is saved with PHX / PLX.

code_0066DE {
    SEP #$20
    PHX 
    JSL $@engine_spc_ipl_upload.UploadSpcDriver
    JSL $@lib_menu_screen_setup.RestoreSceneBgGfxAndPalette
    JSL $@lib_boot_and_scene_init.LoadBootGraphicsBuffers
    PLX 
    REP #$20
    COP [10] ( #$0A00, #01, #$0000, #$0000 )
    COP [91]
    RTL 
}
---------------------------------------------

; The title screen and the prologue.
; 
; When: meta type $56 in A00S0A.
; Sees: see the block note.
; Why: when file_select_request ($0445) is set (Start was pressed) it hands over to the file select at once.
; In: actor script, X = own slot.
; Out: joy_block_mask |= $3000 (Start / Select blocked) until PUSH START is printed; spawns gv_obj_title_start_button_006B61; code_006715 starts the title (front_end_step 0): coldata_buffer = $E0, BGMODE $0F, TM $11, m7x_shadow from $FFC8 by +1 per frame until $013E, then m7_scale = 2 and +4 per frame until $0206 with m7x_shadow = $80; the copyright text, gv_fx_hdma_title_split_006A5E, the title sprites at (x $FF50 y $80, flags $2300), (x $0198, y $78, $0300) twice, and the motion actor; after the prompt a fade (gv_fx_coldata_ramp_up_006A25), front_end_step = 1 and the 14 pages, each ClearBg3Buffer + PrintTextString + ramp down, 482 frames of reading, ramp up; at the end front_end_step = 0, 129 frames, then $FFFF, Mode 7 values reset and the title restarts through COP 1B.
; Clobbers: A, Y.

gv_obj_title_and_prologue_0066FC {
    LDA #$3000
    TSB $joy_block_mask
    STZ $joy_pressed
    STX $player_actor
    LDA $file_select_request ; file_select_request ($0445): set by gv_obj_title_start_button_006B61 when Start was pressed
    BEQ loc_006710
    BRL engine_title_file_select.EnterFileSelect

  loc_006710:
    COP [85] ( @gv_obj_title_start_button_006B61 )

; The start of the title animation (and the target of the restart).
; 
; When: from gv_obj_title_and_prologue_0066FC and from the end of the prologue.
; Sees: the Mode 7 logo pan and zoom.
; Why: STZ front_end_step makes the sprite actors stop their 'prologue' behaviour.
; In: actor script, X = own slot.
; Out: front_end_step = 0, coldata_buffer = $E0, BGMODE $0F, TM $11, m7x_shadow = $FFC8, m7y_shadow = $3E, m7_scale = $83.
; Clobbers: A.

  code_006715:
    STZ $front_end_step   ; front_end_step = 0: the title phase (see the block note)
    SEP #$20
    LDA #$E0
    STA $coldata_buffer
    LDA #$0F
    STA $BGMODE
    LDA #$11
    STA $TM
    REP #$20
    LDA #$FFC8
    STA $m7x_shadow
    LDA #$003E
    STA $m7y_shadow
    LDA #$0083
    STA $m7_scale
    COP [91]
    INC $m7x_shadow
    LDA $m7x_shadow
    CMP #$013E
    BEQ loc_00674C
    RTL 

  loc_00674C:
    LDA #$0002
    STA $m7_scale
    COP [03] ( #1F )
    COP [04]
    LDA #$0080
    STA $m7x_shadow
    COP [91]
    LDA $m7_scale
    CLC 
    ADC #$0004
    STA $m7_scale
    CMP #$0206
    BEQ loc_00676F
    RTL 

  loc_00676F:
    COP [03] ( #1F )
    COP [04]
    PHX 
    LDY #$&gv_title_texts.TitleCopyrightText
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_hdma_title_split_006A5E )
    COP [03] ( #1F )
    COP [04]
    COP [AC] ( @gv_obj_title_sprite_006B51, #$FF50, #$0080, #$2300 )
    COP [AC] ( @gv_obj_title_sprite_006B29, #$0198, #$0078, #$0300 )
    COP [AC] ( @gv_obj_title_sprite_006B01, #$0198, #$0078, #$0300 )
    COP [85] ( @gv_obj_title_sprite_motion_006A90 )
    COP [03] ( #F1 )
    COP [04]
    PHX 
    LDY #$&gv_title_texts.TitlePushStartText
    JSL $@lib_text_render.PrintTextString
    PLX 
    LDA #$3000
    TRB $joy_block_mask
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #79 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #3D )
    COP [04]
    INC $front_end_step   ; front_end_step = 1: the prologue phase starts (the motion actor and the title sprites react)
    COP [03] ( #79 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage01Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage02Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage03Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage04Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage05Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage06Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage07Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage08Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage09Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage10Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage11Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage12Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage13Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage14Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @gv_fx_coldata_ramp_down_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @gv_fx_coldata_ramp_up_006A25 )
    COP [03] ( #21 )
    COP [04]
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [03] ( #1F )
    COP [04]
    STZ $front_end_step   ; front_end_step = 0 again, then $FFFF below: the title sprites end and the title restarts
    COP [03] ( #81 )
    COP [04]
    LDA #$FFFF
    STA $front_end_step
    LDA #$FFC8
    STA $m7x_shadow
    LDA #$003E
    STA $m7y_shadow
    LDA #$0083
    STA $m7_scale
    COP [1B] ( &code_006715, #$0001 )
}

---------------------------------------------
; Raises the fixed colour from 0 to $1F.
; 
; When: spawned by the title actor before every prologue page (and after the last).
; Sees: the fixed colour ($E0 | n written to coldata_buffer, all three channels) rises one step per frame over 32 frames.
; Why: the screen is faded before the next page is printed (which direction the fade goes depends on CGADSUB, OQ-I034-15).
; In: actor script, X = own slot; the counter is the actor's $30.
; Out: COP 86 after 32 steps.
; Clobbers: A.

gv_fx_coldata_ramp_up_006A25 {
    STZ $0030, X
    COP [03] ( #20 )
    SEP #$20
    LDA $0030, X
    ORA #$E0
    STA $coldata_buffer
    REP #$20
    INC $0030, X
    COP [04]
    COP [86]
    RTL 
}

---------------------------------------------
; Lowers the fixed colour from $1F to 0.
; 
; When: spawned by the title actor right after a prologue page is printed.
; Sees: the fixed colour ($E0 | n) drops one step per frame over 32 frames.
; Why: the opposite of gv_fx_coldata_ramp_up_006A25.
; In: actor script, X = own slot; the counter is the actor's $30.
; Out: COP 86 after 32 steps.
; Clobbers: A.

gv_fx_coldata_ramp_down_006A40 {
    LDA #$001F
    STA $0030, X
    COP [03] ( #20 )
    SEP #$20
    LDA $0030, X
    ORA #$E0
    STA $coldata_buffer
    REP #$20
    DEC $0030, X
    COP [04]
    COP [86]
    RTL 
}

---------------------------------------------
; Splits the title screen into two display modes.
; 
; When: spawned by the title actor after the zoom; it runs every frame until front_end_step is not 0.
; Sees: the upper 127 lines in BGMODE $0F with TM $11 (the Mode 7 logo and the sprites), the next 96 lines in BGMODE $09 with TM $14 (BG3: copyright and PUSH START).
; Why: the upper part is the Mode 7 title, the lower part carries BG3 (tables gv_hdma_title_bgmode_006A86 and gv_hdma_title_tm_006A8B; what each band draws is OQ-I034-15).
; In: actor script, X = own slot.
; Out: two HDMA queues through lib_system_helpers.QueueHdmaDirect (A high byte $05 = BGMODE, $2C = TM); once front_end_step is not 0: STZ $0042 and COP 86.
; Clobbers: A, Y.

gv_fx_hdma_title_split_006A5E {
    SEP #$20
    LDA #$05
    XBA 
    LDA #$^gv_hdma_title_bgmode_006A86
    LDY #$&gv_hdma_title_bgmode_006A86
    JSL $@lib_system_helpers.QueueHdmaDirect
    LDA #$2C
    XBA 
    LDA #$^gv_hdma_title_tm_006A8B
    LDY #$&gv_hdma_title_tm_006A8B
    JSL $@lib_system_helpers.QueueHdmaDirect
    REP #$20
    LDA $front_end_step
    BNE loc_006A80
    RTL 

  loc_006A80:
    STZ $0042
    COP [86]
    RTL 
}
---------------------------------------------

; HDMA table for BGMODE ($2105): 127 lines of $0F, 96 lines of $09, end.
; 
; When: queued by gv_fx_hdma_title_split_006A5E.
; Sees: n/a (the screen splits at line 127).
; Why: $0F is Mode 7, $09 is Mode 1 with BG3 priority.
; In: n/a.
; Out: bytes 7F 0F 60 09 00.
; Clobbers: none.

gv_hdma_title_bgmode_006A86 #7F0F600900
---------------------------------------------

; HDMA table for TM ($212C): 127 lines of $11 (BG1 and OBJ), 96 lines of $14 (BG3 and OBJ), end.
; 
; When: queued by gv_fx_hdma_title_split_006A5E.
; Sees: n/a.
; Why: see gv_hdma_title_bgmode_006A86.
; In: n/a.
; Out: bytes 7F 11 60 14 00.
; Clobbers: none.

gv_hdma_title_tm_006A8B #7F11601400
---------------------------------------------

; Moves the three title sprite actors.
; 
; When: spawned after the three sprites by the title actor; the sprites are chained through their $3E field.
; Sees: for 128 frames the first two linked sprites (the two spawned at x $0198) move 2 pixels left, to x $98, and the third (spawned at x $FF50) 2 pixels right, to x $50; when front_end_step becomes non-zero two of them move up 1 pixel for 64 frames; when it returns to 0 two move 2 pixels left for 128 frames and the actor ends.
; Why: one actor drives all three so that they stay in step.
; In: actor script, X = own slot; the $3E chain is set by the spawn order.
; Out: COP 86 at the end; the waits are COP 91 loops on front_end_step.
; Clobbers: A, Y.

gv_obj_title_sprite_motion_006A90 {
    COP [03] ( #80 )
    LDY $003E, X
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    INC 
    INC 
    STA $0000, Y
    COP [04]
    COP [91]
    LDA $front_end_step
    BNE loc_006AC0
    RTL 

  loc_006AC0:
    COP [03] ( #40 )
    LDY $003E, X
    LDA $0002, Y
    DEC 
    STA $0002, Y
    LDA $003E, Y
    TAY 
    LDA $0002, Y
    DEC 
    STA $0002, Y
    COP [04]
    COP [91]
    LDA $front_end_step
    BEQ loc_006AE2
    RTL 

  loc_006AE2:
    COP [03] ( #80 )
    LDY $003E, X
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    COP [04]
    COP [86]
    RTL 
}

---------------------------------------------
; A title sprite (animation 0, animation 3 every 300 frames).
; 
; When: spawned by the title actor at (x $0198, y $78, flags $0300).
; Sees: animation 0; once x is $98 it plays animation 3, then 0 again and repeats every $012C (300) frames.
; Why: the motion actor brings it to x $98.
; In: actor script, X = own slot.
; Out: COP 86 once front_end_step is negative.
; Clobbers: A.

gv_obj_title_sprite_006B01 {
    COP [80] ( #00 )
    COP [82]
    COP [91]
    LDA $front_end_step
    BMI loc_006B26
    LDA $0000, X
    CMP #$0098
    BEQ loc_006B16
    RTL 

  loc_006B16:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    COP [1B] ( &gv_obj_title_sprite_006B01, #$012C )

  loc_006B26:
    COP [86]
    RTL 
}

---------------------------------------------
; A title sprite (animation 1, animation 4 once settled).
; 
; When: spawned by the title actor at (x $0198, y $78, flags $0300).
; Sees: animation 1; once x is $98 it plays animation 4, then 1 again and repeats every $012C (300) frames.
; Why: see gv_obj_title_sprite_006B01.
; In: actor script, X = own slot.
; Out: COP 86 once front_end_step is negative.
; Clobbers: A.

gv_obj_title_sprite_006B29 {
    COP [80] ( #01 )
    COP [82]
    COP [91]
    LDA $front_end_step
    BMI loc_006B4E
    LDA $0000, X
    CMP #$0098
    BEQ loc_006B3E
    RTL 

  loc_006B3E:
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    COP [1B] ( &gv_obj_title_sprite_006B29, #$012C )

  loc_006B4E:
    COP [86]
    RTL 
}

---------------------------------------------
; A title sprite (animation 2, static).
; 
; When: spawned by the title actor at (x $FF50, y $80, flags $2300).
; Sees: animation 2 while it slides in from the left.
; Why: see gv_obj_title_sprite_006B01.
; In: actor script, X = own slot.
; Out: COP 86 as soon as front_end_step is non-zero.
; Clobbers: A.

gv_obj_title_sprite_006B51 {
    COP [80] ( #02 )
    COP [82]
    COP [91]
    LDA $front_end_step
    BNE loc_006B5E
    RTL 

  loc_006B5E:
    COP [86]
    RTL 
}

---------------------------------------------
; Waits for the Start button on the title.
; 
; When: spawned by the title actor; it runs every frame.
; Sees: nothing; the title restarts as the file select.
; Why: the walkthrough: 'you can press the Start Button to reach the file selection menu.'
; In: actor script, X = own slot; reads joy_pressed.
; Out: on Start ($1000): COP 10 to area 0 scene $0A (arrival animation 1, x 0, y 0), scene_variant = 1, file_select_request = 1, COP 86.
; Clobbers: A.

gv_obj_title_start_button_006B61 {
    LDA $joy_pressed
    BIT #$1000
    BNE loc_006B6A
    RTL 

  loc_006B6A:
    COP [10] ( #$0A00, #01, #$0000, #$0000 )
    LDA #$0001
    STA $scene_variant
    STA $file_select_request
    COP [86]
    RTL 
}
---------------------------------------------

; The ending actor.
; 
; When: meta type $57 in A00S0B.
; Sees: the seven ending pages (gv_epilogue_texts) over the sunset scene, then the staff roll and the closing scene.
; Why: one script keeps the pages, the curtain, the scroll and the sprites in step.
; In: actor script, X = own slot.
; Out: $16 |= $2010, player_actor = X, BG3 scroll (0, $FF), m7x_shadow = 0, ending_page_flag = 0, front_end_step = 0, CGADSUB = $93, coldata_buffer = $FF, joy_block_mask = $FFFF; spawns gv_fx_ending_hdma_wipe_00758C and gv_fx_ending_hdma_scroll_0074E8; code_0072E0 lowers coldata_buffer from $E0 | $1F to $E0 (one step per 4 frames); then 120 frames, page 1 (each page: print, ending_page_flag = 1, wait, ending_page_flag = 0, ClearBg3Buffer, wait 112 frames).
; Clobbers: A, Y.

gv_obj_ending_sequence_00729D {
    LDA $0016, X
    ORA #$2010
    STA $0016, X
    STX $player_actor
    STZ $scroll_bg3_x
    LDA #$00FF
    STA $scroll_bg3_y
    STZ $m7x_shadow
    STZ $0466             ; ending_page_flag = 0 (1 while a page is shown, $FFFF after the last)
    STZ $front_end_step
    SEP #$20
    LDA #$93
    STA $CGADSUB
    LDA #$FF
    STA $coldata_buffer
    REP #$20
    LDA #$FFFF
    TSB $joy_block_mask
    COP [85] ( @gv_fx_ending_hdma_wipe_00758C )
    COP [85] ( @gv_fx_ending_hdma_scroll_0074E8 )
    COP [1B] ( &code_0072E0, #$0002 )
}

---------------------------------------------
; The ending fade-in.
; 
; When: 2 frames after gv_obj_ending_sequence_00729D starts.
; Sees: the fixed colour ($E0 | n) falls from $1F to 0 in 32 steps of 4 frames.
; Why: the first page is printed after the fade.
; In: actor script, X = own slot; counter in $30.
; Out: continues with code_0072FF and code_007307 (page 1).
; Clobbers: A.

code_0072E0 {
    LDA #$001F
    STA $0030, X
    COP [03] ( #20 )
    SEP #$20
    LDA $0030, X
    ORA #$E0
    STA $coldata_buffer
    REP #$20
    DEC $0030, X
    COP [1B] ( &code_0072FF, #$0004 )
}

code_0072FF {
    COP [04]
    COP [1B] ( &code_007307, #$0078 )
}

code_007307 {
    PHX 
    LDY #$&gv_epilogue_texts.EndingPage1Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    INC $0466
    COP [1B] ( &code_007319, #$02D0 )
}

code_007319 {
    STZ $0466
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [1B] ( &code_007326, #$0070 )
}

code_007326 {
    PHX 
    LDY #$&gv_epilogue_texts.EndingPage2Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    INC $0466
    COP [1B] ( &code_007338, #$02D0 )
}

code_007338 {
    STZ $0466
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [1B] ( &code_007345, #$0070 )
}

code_007345 {
    PHX 
    LDY #$&gv_epilogue_texts.EndingPage3Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    INC $0466
    COP [1B] ( &code_007357, #$02D0 )
}

code_007357 {
    STZ $0466
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [1B] ( &code_007364, #$0070 )
}

code_007364 {
    PHX 
    LDY #$&gv_epilogue_texts.EndingPage4Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    INC $0466
    COP [1B] ( &code_007376, #$02D0 )
}

code_007376 {
    STZ $0466
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [1B] ( &code_007383, #$0070 )
}

code_007383 {
    COP [1B] ( &code_007389, #$0078 )
}

---------------------------------------------
; The scroll and the sprites of the second half of the ending.
; 
; When: 120 frames after page 4.
; Sees: the scene scrolls (gv_obj_ending_scroll_0074D3) and two sprites appear at (x $0190, y $80) and (x $0190, y $70) (COP AC, flags $0050).
; Why: the story changes scene between the fourth and fifth page (gv_epilogue_texts).
; In: actor script, X = own slot.
; Out: waits until front_end_step is non-zero, then 120 frames and page 5.
; Clobbers: A.

code_007389 {
    COP [B0] ( @gv_obj_ending_scroll_0074D3, #$2010 )
    COP [AC] ( @gv_obj_ending_sprite_00748F, #$0190, #$0080, #$0050 )
    COP [AC] ( @gv_obj_ending_sprite_007460, #$0190, #$0070, #$0050 )
    COP [91]
    LDA $front_end_step
    BNE loc_0073AE
    RTL 

  loc_0073AE:
    COP [1B] ( &code_0073B4, #$0078 )
}

code_0073B4 {
    PHX 
    LDY #$&gv_epilogue_texts.EndingPage5Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    INC $0466
    COP [1B] ( &code_0073C6, #$0438 )
}

code_0073C6 {
    STZ $0466
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [1B] ( &code_0073D3, #$0070 )
}

code_0073D3 {
    PHX 
    LDY #$&gv_epilogue_texts.EndingPage6Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    INC $0466
    COP [1B] ( &code_0073E5, #$0438 )
}

code_0073E5 {
    STZ $0466
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [1B] ( &code_0073F2, #$0070 )
}

code_0073F2 {
    PHX 
    LDY #$&gv_epilogue_texts.EndingPage7Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    INC $0466
    COP [1B] ( &code_007404, #$0438 )
}

code_007404 {
    STZ $0466
    JSL $@lib_boot_and_scene_init.ClearBg3Buffer
    COP [1B] ( &code_007411, #$0070 )
}

code_007411 {
    LDA #$0001
    TSB $vram_upload_flags
    COP [1B] ( &code_00741D, #$0078 )
}

---------------------------------------------
; The final animation steps of the ending.
; 
; When: 120 frames after page 7 (and vram_upload_flags |= 1).
; Sees: the two ending sprites finish their animations.
; Why: front_end_step goes 1 to 2 here, to 3 in gv_obj_ending_sprite_007460 and to 4 in gv_obj_ending_sprite_00748F.
; In: actor script, X = own slot.
; Out: waits for front_end_step = 4, then COP 1B to code_007431.
; Clobbers: A.

code_00741D {
    INC $front_end_step
    COP [91]
    LDA $front_end_step
    CMP #$0004
    BEQ loc_00742B
    RTL 

  loc_00742B:
    COP [1B] ( &code_007431, #$0078 )
}

---------------------------------------------
; The end of the pages and the start of the staff roll.
; 
; When: 120 frames after front_end_step reaches 4.
; Sees: the curtain opens fully, the staff roll starts and, after 240 frames, the fixed colour rises one step every 16 frames.
; Why: ending_page_flag - 1 = $FFFF makes the curtain actor show BG3 on all $E0 lines.
; In: actor script, X = own slot.
; Out: spawns gv_obj_staff_roll_007638; coldata_buffer = $E0 | n, n = 0 ... $1F, then COP 91 and RTL.
; Clobbers: A.

code_007431 {
    DEC $0466             ; ending_page_flag = $FFFF: the curtain opens fully
    COP [85] ( @gv_obj_staff_roll_007638 )
    COP [1B] ( &code_00743F, #$00F0 )
}

code_00743F {
    STZ $0030, X
    COP [03] ( #20 )
    SEP #$20
    LDA $0030, X
    ORA #$E0
    STA $coldata_buffer
    REP #$20
    INC $0030, X
    COP [1B] ( &code_00745B, #$0010 )
}

code_00745B {
    COP [04]
    COP [91]
    RTL 
}

---------------------------------------------
; An ending sprite (animations 0, 2, 3, 1).
; 
; When: spawned by code_007389 at (x $0190, y $70, flags $0050).
; Sees: animation 0 until front_end_step is 1, then animation 2; when front_end_step is 2 it plays animations 0, 3 and 1 and advances front_end_step to 3.
; Why: the scripted animation steps are keyed to the shared counter.
; In: actor script, X = own slot.
; Out: INC front_end_step, COP 91, RTL.
; Clobbers: A.

gv_obj_ending_sprite_007460 {
    COP [80] ( #00 )
    COP [82]
    LDA $front_end_step
    CMP #$0001
    BNE gv_obj_ending_sprite_007460
    COP [80] ( #02 )
    COP [82]
    LDA $front_end_step
    CMP #$0002
    BNE gv_obj_ending_sprite_007460
    COP [80] ( #00 )
    COP [82]
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    INC $front_end_step
    COP [91]
    RTL 
}

---------------------------------------------
; An ending sprite (animations 4, 6, 5).
; 
; When: spawned by code_007389 at (x $0190, y $80, flags $0050).
; Sees: animation 4 until front_end_step is 3, then animations 4, 6 and 5; it advances front_end_step to 4.
; Why: see gv_obj_ending_sprite_007460.
; In: actor script, X = own slot.
; Out: INC front_end_step, COP 91, RTL.
; Clobbers: A.

gv_obj_ending_sprite_00748F {
    COP [80] ( #04 )
    COP [82]
    LDA $front_end_step
    CMP #$0003
    BNE gv_obj_ending_sprite_00748F
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    INC $front_end_step
    COP [91]
    RTL 
}
---------------------------------------------

; Scrolls BG1 to the right.
; 
; When: spawned by code_007389 (flags $2010); runs every frame.
; Sees: BG1 moves right by 1 pixel per frame.
; Why: m7x_shadow is the scroll counter, started at 0 by the ending actor; gv_fx_ending_hdma_scroll_0074E8 reads it for BG2.
; In: actor script, X = own slot.
; Out: scroll_bg1_x = m7x_shadow; at $0100 front_end_step is incremented once and the actor idles (COP 91, RTL).
; Clobbers: A.

gv_obj_ending_scroll_0074D3 {
    INC $m7x_shadow
    LDA $m7x_shadow
    STA $scroll_bg1_x
    CMP #$0100
    BEQ loc_0074E2
    RTL 

  loc_0074E2:
    INC $front_end_step
    COP [91]
    RTL 
}

---------------------------------------------
; BG2 horizontal scroll bands of the ending.
; 
; When: spawned by the ending actor; runs every frame.
; Sees: BG2 below the first 112 lines is cut into seven bands (heights $30, $10, $10, $10, $08, $01 after the static $70 lines) that are offset by m7x_shadow / 2 plus 1/2, 1/4, 0, 1/4, 3/8 and 1/2 of the actor's frame counter, so the bands drift at different speeds.
; Why: a parallax with the BG1 scroll (OQ-I034-15 for what is drawn).
; In: actor script, X = own slot; the counter is $30 (incremented each frame).
; Out: the HDMA table at $7E7800 is rebuilt every frame and queued to BG2HOFS ($210F) with lib_system_helpers.QueueHdmaDirect.
; Clobbers: A, Y.

gv_fx_ending_hdma_scroll_0074E8 {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    STZ $0030, X
    PHX 
    LDX #$0000
    LDA #$0070
    STA $7E7800, X
    LDA #$0030
    STA $7E7803, X
    LDA #$0010
    STA $7E7806, X
    LDA #$0010
    STA $7E7809, X
    LDA #$0010
    STA $7E780C, X
    LDA #$0008
    STA $7E780F, X
    LDA #$0001
    STA $7E7812, X
    LDA #$0000
    STA $7E7815, X
    STA $7E7801, X
    PLX 
    COP [91]
    PHX 
    TXY 
    LDX #$0000
    LDA $m7x_shadow
    LSR 
    STA $16
    STA $7E780A, X
    LDA $0030, Y
    LSR 
    PHA 
    LSR 
    CLC 
    ADC $01, S
    LSR 
    CLC 
    ADC $16
    STA $7E7810, X
    PLA 
    LDA $0030, Y
    LSR 
    CLC 
    ADC $16
    STA $7E7804, X
    STA $7E7813, X
    LDA $0030, Y
    LSR 
    LSR 
    CLC 
    ADC $16
    STA $7E7807, X
    STA $7E780D, X
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaDirect
    REP #$20
    PLX 
    INC $0030, X
    RTL 
}

---------------------------------------------
; The text curtain of the ending pages.
; 
; When: spawned by the ending actor; runs every frame.
; Sees: while ending_page_flag is 1 the BG3 window opens from the top down (one line per frame up to $E0), stays open, and closes again by 2 lines per frame when the flag returns to 0; with ending_page_flag $FFFF it is fully open.
; Why: the text layer (TM $17 above the curtain line, $13 below it) is shown only inside the curtain.
; In: actor script, X = own slot; the line count is $30.
; Out: one HDMA queue per frame through gv_fx_ending_queue_wipe_0075E7.
; Clobbers: A, Y.

gv_fx_ending_hdma_wipe_00758C {
    LDA $0016, X
    ORA #$0010
    STA $0016, X

  loc_007595:
    COP [91]
    LDA $0466
    BMI loc_0075DE
    BNE loc_0075A2
    JSR $&gv_fx_ending_queue_wipe_0075E7
    RTL 

  loc_0075A2:
    STZ $0030, X
    COP [03] ( #E0 )
    LDA $0030, X
    JSR $&gv_fx_ending_queue_wipe_0075E7
    COP [27] ( &code_0075B2 )
}

code_0075B2 {
    LDA $0030, X
    JSR $&gv_fx_ending_queue_wipe_0075E7
    INC $0030, X
    COP [04]
    COP [91]
    LDA $0466
    BEQ loc_0075CB
    LDA #$00E0
    JSR $&gv_fx_ending_queue_wipe_0075E7
    RTL 

  loc_0075CB:
    COP [03] ( #70 )
    LDA $0030, X
    JSR $&gv_fx_ending_queue_wipe_0075E7
    DEC $0030, X
    DEC $0030, X
    COP [04]
    BRA loc_007595

  loc_0075DE:
    COP [91]
    LDA #$00E0
    JSR $&gv_fx_ending_queue_wipe_0075E7
    RTL 
}

---------------------------------------------
; Builds and queues the curtain HDMA table.
; 
; When: called by gv_fx_ending_hdma_wipe_00758C (JSR).
; Sees: n/a.
; Why: A = number of lines that show BG3.
; In: A (8 bits) = line count; X = own slot (saved with PHX).
; Out: the table at $7E7000: for A >= $80 two entries of TM $17 ($7F and A - $7F lines), for A below $80 one entry (A lines, TM $17), then 1 line of TM $13 and the end byte; queued to TM ($212C) with QueueHdmaDirect. Returns with RTS, X restored.
; Clobbers: A, Y.

gv_fx_ending_queue_wipe_0075E7 {
    PHX 
    SEP #$20
    LDX #$0000
    CMP #$00
    BEQ loc_007614
    CMP #$80
    BCC loc_007608
    SEC 
    SBC #$7F
    PHA 
    LDA #$7F
    STA $7E7000, X
    LDA #$17
    STA $7E7001, X
    INX 
    INX 
    PLA 

  loc_007608:
    STA $7E7000, X
    LDA #$17
    STA $7E7001, X
    INX 
    INX 

  loc_007614:
    LDA #$01
    STA $7E7000, X
    LDA #$13
    STA $7E7001, X
    INX 
    INX 
    LDA #$00
    STA $7E7000, X
    LDA #$2C
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaDirect
    REP #$20
    PLX 
    RTS 
}

---------------------------------------------
; The staff roll.
; 
; When: spawned by code_007431.
; Sees: the staff roll text (gv_epilogue_texts.StaffRollText); after lib_name_entry_and_staff_roll.ScrollStaffRollText returns there are 240 frames, COP 31 and another 240 frames.
; Why: the scrolling itself is in ScrollStaffRollText.
; In: actor script, X = own slot (saved with PHX / PLX).
; Out: code_007650 starts COP 10 to area 0 scene $0D (arrival animation 2, x 0, y 0), clears souls_flags, sets asset_skip_mask = $20 and reload_menu_gfx + 1.
; Clobbers: A, Y.

gv_obj_staff_roll_007638 {
    PHX 
    LDY #$&gv_epilogue_texts.StaffRollText
    JSL $@lib_name_entry_and_staff_roll.ScrollStaffRollText
    PLX 
    COP [1B] ( &code_007647, #$00F0 )
}

code_007647 {
    COP [31] ( #00 )
    COP [1B] ( &code_007650, #$00F0 )
}

code_007650 {
    COP [10] ( #$0D00, #02, #$0000, #$0000 )
    SEP #$20
    STZ $souls_flags
    REP #$20
    LDA #$0020
    STA $asset_skip_mask
    INC $reload_menu_gfx
    COP [91]
    RTL 
}