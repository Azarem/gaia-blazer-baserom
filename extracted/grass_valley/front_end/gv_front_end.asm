?BANK 00

?INCLUDE 'engine_spc_ipl_upload'
?INCLUDE 'engine_title_file_select'
?INCLUDE 'gv_epilogue_texts'
?INCLUDE 'gv_prologue_texts'
?INCLUDE 'gv_title_texts'
?INCLUDE 'lib_0118FC_part5'
?INCLUDE 'lib_0126CF'
?INCLUDE 'lib_02719F'
?INCLUDE 'lib_scene_change_init'
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
!reload_menu_gfx                0454
!m7x_shadow                     046A
!m7y_shadow                     046C
!m7_scale                       0480
!souls_flags                    1B82
!BGMODE                         2105
!TM                             212C
!CGADSUB                        2131
!coldata_buffer                 7F0200

---------------------------------------------

code_0066C6 {
    LDA #$3080
    TSB $joy_block_mask
    STX $player_actor
    PHX 
    LDY #$&gv_title_texts.TileBlockText
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [1B] ( &code_0066DE, #$0001 )
}

code_0066DE {
    SEP #$20
    PHX 
    JSL $@engine_spc_ipl_upload.code_0FEFBC
    JSL $@lib_0118FC_part5.RestoreSceneBgGfxAndPalette
    JSL $@lib_02719F.LoadBootGraphicsBuffers
    PLX 
    REP #$20
    COP [10] ( #$0A00, #01, #$0000, #$0000 )
    COP [91]
    RTL 
}
---------------------------------------------

code_0066FC {
    LDA #$3000
    TSB $joy_block_mask
    STZ $joy_pressed
    STX $player_actor
    LDA $0445
    BEQ loc_006710
    BRL engine_title_file_select.EnterFileSelect

  loc_006710:
    COP [85] ( @code_006B61 )

  code_006715:
    STZ $0482
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
    COP [85] ( @code_006A5E )
    COP [03] ( #1F )
    COP [04]
    COP [AC] ( @code_006B51, #$FF50, #$0080, #$2300 )
    COP [AC] ( @code_006B29, #$0198, #$0078, #$0300 )
    COP [AC] ( @code_006B01, #$0198, #$0078, #$0300 )
    COP [85] ( @code_006A90 )
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
    COP [85] ( @code_006A25 )
    COP [03] ( #3D )
    COP [04]
    INC $0482
    COP [03] ( #79 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage01Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage02Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage03Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage04Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage05Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage06Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage07Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage08Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage09Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage10Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage11Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage12Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage13Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDY #$&gv_prologue_texts.IntroPage14Text
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    JSL $@lib_scene_change_init.ClearBg3Buffer
    COP [03] ( #1F )
    COP [04]
    STZ $0482
    COP [03] ( #81 )
    COP [04]
    LDA #$FFFF
    STA $0482
    LDA #$FFC8
    STA $m7x_shadow
    LDA #$003E
    STA $m7y_shadow
    LDA #$0083
    STA $m7_scale
    COP [1B] ( &code_006715, #$0001 )
}

code_006A25 {
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

code_006A40 {
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

code_006A5E {
    SEP #$20
    LDA #$05
    XBA 
    LDA #$^binary_006A86
    LDY #$&binary_006A86
    JSL $@lib_system_helpers.QueueHdmaDirect
    LDA #$2C
    XBA 
    LDA #$^binary_006A8B
    LDY #$&binary_006A8B
    JSL $@lib_system_helpers.QueueHdmaDirect
    REP #$20
    LDA $0482
    BNE loc_006A80
    RTL 

  loc_006A80:
    STZ $0042
    COP [86]
    RTL 
}
---------------------------------------------

binary_006A86 #7F0F600900
---------------------------------------------

binary_006A8B #7F11601400
---------------------------------------------

code_006A90 {
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
    LDA $0482
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
    LDA $0482
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

code_006B01 {
    COP [80] ( #00 )
    COP [82]
    COP [91]
    LDA $0482
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
    COP [1B] ( &code_006B01, #$012C )

  loc_006B26:
    COP [86]
    RTL 
}

code_006B29 {
    COP [80] ( #01 )
    COP [82]
    COP [91]
    LDA $0482
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
    COP [1B] ( &code_006B29, #$012C )

  loc_006B4E:
    COP [86]
    RTL 
}

code_006B51 {
    COP [80] ( #02 )
    COP [82]
    COP [91]
    LDA $0482
    BNE loc_006B5E
    RTL 

  loc_006B5E:
    COP [86]
    RTL 
}

code_006B61 {
    LDA $joy_pressed
    BIT #$1000
    BNE loc_006B6A
    RTL 

  loc_006B6A:
    COP [10] ( #$0A00, #01, #$0000, #$0000 )
    LDA #$0001
    STA $scene_variant
    STA $0445
    COP [86]
    RTL 
}
---------------------------------------------

code_00729D {
    LDA $0016, X
    ORA #$2010
    STA $0016, X
    STX $player_actor
    STZ $scroll_bg3_x
    LDA #$00FF
    STA $scroll_bg3_y
    STZ $m7x_shadow
    STZ $0466
    STZ $0482
    SEP #$20
    LDA #$93
    STA $CGADSUB
    LDA #$FF
    STA $coldata_buffer
    REP #$20
    LDA #$FFFF
    TSB $joy_block_mask
    COP [85] ( @code_00758C )
    COP [85] ( @code_0074E8 )
    COP [1B] ( &code_0072E0, #$0002 )
}

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
    JSL $@lib_scene_change_init.ClearBg3Buffer
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
    JSL $@lib_scene_change_init.ClearBg3Buffer
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
    JSL $@lib_scene_change_init.ClearBg3Buffer
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
    JSL $@lib_scene_change_init.ClearBg3Buffer
    COP [1B] ( &code_007383, #$0070 )
}

code_007383 {
    COP [1B] ( &code_007389, #$0078 )
}

code_007389 {
    COP [B0] ( @code_0074D3, #$2010 )
    COP [AC] ( @code_00748F, #$0190, #$0080, #$0050 )
    COP [AC] ( @code_007460, #$0190, #$0070, #$0050 )
    COP [91]
    LDA $0482
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
    JSL $@lib_scene_change_init.ClearBg3Buffer
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
    JSL $@lib_scene_change_init.ClearBg3Buffer
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
    JSL $@lib_scene_change_init.ClearBg3Buffer
    COP [1B] ( &code_007411, #$0070 )
}

code_007411 {
    LDA #$0001
    TSB $vram_upload_flags
    COP [1B] ( &code_00741D, #$0078 )
}

code_00741D {
    INC $0482
    COP [91]
    LDA $0482
    CMP #$0004
    BEQ loc_00742B
    RTL 

  loc_00742B:
    COP [1B] ( &code_007431, #$0078 )
}

code_007431 {
    DEC $0466
    COP [85] ( @code_007638 )
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

code_007460 {
    COP [80] ( #00 )
    COP [82]
    LDA $0482
    CMP #$0001
    BNE code_007460
    COP [80] ( #02 )
    COP [82]
    LDA $0482
    CMP #$0002
    BNE code_007460
    COP [80] ( #00 )
    COP [82]
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    INC $0482
    COP [91]
    RTL 
}

code_00748F {
    COP [80] ( #04 )
    COP [82]
    LDA $0482
    CMP #$0003
    BNE code_00748F
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    INC $0482
    COP [91]
    RTL 
}
---------------------------------------------

code_0074D3 {
    INC $m7x_shadow
    LDA $m7x_shadow
    STA $scroll_bg1_x
    CMP #$0100
    BEQ loc_0074E2
    RTL 

  loc_0074E2:
    INC $0482
    COP [91]
    RTL 
}

code_0074E8 {
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

code_00758C {
    LDA $0016, X
    ORA #$0010
    STA $0016, X

  loc_007595:
    COP [91]
    LDA $0466
    BMI loc_0075DE
    BNE loc_0075A2
    JSR $&code_0075E7
    RTL 

  loc_0075A2:
    STZ $0030, X
    COP [03] ( #E0 )
    LDA $0030, X
    JSR $&code_0075E7
    COP [27] ( &code_0075B2 )
}

code_0075B2 {
    LDA $0030, X
    JSR $&code_0075E7
    INC $0030, X
    COP [04]
    COP [91]
    LDA $0466
    BEQ loc_0075CB
    LDA #$00E0
    JSR $&code_0075E7
    RTL 

  loc_0075CB:
    COP [03] ( #70 )
    LDA $0030, X
    JSR $&code_0075E7
    DEC $0030, X
    DEC $0030, X
    COP [04]
    BRA loc_007595

  loc_0075DE:
    COP [91]
    LDA #$00E0
    JSR $&code_0075E7
    RTL 
}

code_0075E7 {
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

code_007638 {
    PHX 
    LDY #$&gv_epilogue_texts.StaffRollText
    JSL $@lib_0126CF.ScrollStaffRollText
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