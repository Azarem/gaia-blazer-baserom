?BANK 00

?INCLUDE 'common_actor_00729D_part2'
?INCLUDE 'lib_014192'
?INCLUDE 'lib_0141F1'
?INCLUDE 'lib_014228'
?INCLUDE 'lib_01426F'
?INCLUDE 'lib_0142BB'
?INCLUDE 'lib_0142E1'
?INCLUDE 'lib_014339'
?INCLUDE 'lib_027781_part2'
?INCLUDE 'lib_shared_012769'

!joy_block_mask                 0326
!scroll_bg3_x                   0386
!scroll_bg3_y                   0388
!player_actor                   039C
!vram_upload_flags              03B8
!CGADSUB                        2131
!coldata_buffer                 7F0200

---------------------------------------------

code_00729D {
    LDA $0016, X          ; {29341}
    ORA #$2010            ; {29344}
    STA $0016, X          ; {29347}
    STX $player_actor     ; {29350}
    STZ $scroll_bg3_x     ; {29353}
    LDA #$00FF            ; {29356}
    STA $scroll_bg3_y     ; {29359}
    STZ $046A             ; {29362}
    STZ $0466             ; {29365}
    STZ $0482             ; {29368}
    SEP #$20              ; {29371}
    LDA #$93              ; {29373}
    STA $CGADSUB          ; {29375}
    LDA #$FF              ; {29378}
    STA $coldata_buffer   ; {29380}
    REP #$20              ; {29384}
    LDA #$FFFF            ; {29386}
    TSB $joy_block_mask   ; {29389}
    COP [85] ( @common_actor_00729D_part2.code_00758C ) ; {29392}
    COP [85] ( @common_actor_00729D_part2.code_0074E8 ) ; {29397}
    COP [1B] ( &code_0072E0, #$0002 ) ; {29402}
}

code_0072E0 {
    LDA #$001F            ; {29408}
    STA $0030, X          ; {29411}
    COP [03] ( #20 )      ; {29414}
    SEP #$20              ; {29417}
    LDA $0030, X          ; {29419}
    ORA #$E0              ; {29422}
    STA $coldata_buffer   ; {29424}
    REP #$20              ; {29428}
    DEC $0030, X          ; {29430}
    COP [1B] ( &code_0072FF, #$0004 ) ; {29433}
}

code_0072FF {
    COP [04]              ; {29439}
    COP [1B] ( &code_007307, #$0078 ) ; {29441}
}

code_007307 {
    PHX                   ; {29447}
    LDY #$&lib_014192.asciistring_014192 ; {29448}
    JSL $@lib_shared_012769.code_012769 ; {29451}
    PLX                   ; {29455}
    INC $0466             ; {29456}
    COP [1B] ( &code_007319, #$02D0 ) ; {29459}
}

code_007319 {
    STZ $0466             ; {29465}
    JSL $@lib_027781_part2.code_0276EE ; {29468}
    COP [1B] ( &code_007326, #$0070 ) ; {29472}
}

code_007326 {
    PHX                   ; {29478}
    LDY #$&lib_0141F1.asciistring_0141F1 ; {29479}
    JSL $@lib_shared_012769.code_012769 ; {29482}
    PLX                   ; {29486}
    INC $0466             ; {29487}
    COP [1B] ( &code_007338, #$02D0 ) ; {29490}
}

code_007338 {
    STZ $0466             ; {29496}
    JSL $@lib_027781_part2.code_0276EE ; {29499}
    COP [1B] ( &code_007345, #$0070 ) ; {29503}
}

code_007345 {
    PHX                   ; {29509}
    LDY #$&lib_014228.asciistring_014228 ; {29510}
    JSL $@lib_shared_012769.code_012769 ; {29513}
    PLX                   ; {29517}
    INC $0466             ; {29518}
    COP [1B] ( &code_007357, #$02D0 ) ; {29521}
}

code_007357 {
    STZ $0466             ; {29527}
    JSL $@lib_027781_part2.code_0276EE ; {29530}
    COP [1B] ( &code_007364, #$0070 ) ; {29534}
}

code_007364 {
    PHX                   ; {29540}
    LDY #$&lib_01426F.asciistring_01426F ; {29541}
    JSL $@lib_shared_012769.code_012769 ; {29544}
    PLX                   ; {29548}
    INC $0466             ; {29549}
    COP [1B] ( &code_007376, #$02D0 ) ; {29552}
}

code_007376 {
    STZ $0466             ; {29558}
    JSL $@lib_027781_part2.code_0276EE ; {29561}
    COP [1B] ( &code_007383, #$0070 ) ; {29565}
}

code_007383 {
    COP [1B] ( &code_007389, #$0078 ) ; {29571}
}

code_007389 {
    COP [B0] ( @common_actor_00729D_part2.code_0074D3, #$2010 ) ; {29577}
    COP [AC] ( @code_00748F, #$0190, #$0080, #$0050 ) ; {29584}
    COP [AC] ( @code_007460, #$0190, #$0070, #$0050 ) ; {29595}
    COP [91]              ; {29606}
    LDA $0482             ; {29608}
    BNE loc_0073AE        ; {29611}
    RTL                   ; {29613}

  loc_0073AE:
    COP [1B] ( &code_0073B4, #$0078 ) ; {29614}
}

code_0073B4 {
    PHX                   ; {29620}
    LDY #$&lib_0142BB.asciistring_0142BB ; {29621}
    JSL $@lib_shared_012769.code_012769 ; {29624}
    PLX                   ; {29628}
    INC $0466             ; {29629}
    COP [1B] ( &code_0073C6, #$0438 ) ; {29632}
}

code_0073C6 {
    STZ $0466             ; {29638}
    JSL $@lib_027781_part2.code_0276EE ; {29641}
    COP [1B] ( &code_0073D3, #$0070 ) ; {29645}
}

code_0073D3 {
    PHX                   ; {29651}
    LDY #$&lib_0142E1.asciistring_0142E1 ; {29652}
    JSL $@lib_shared_012769.code_012769 ; {29655}
    PLX                   ; {29659}
    INC $0466             ; {29660}
    COP [1B] ( &code_0073E5, #$0438 ) ; {29663}
}

code_0073E5 {
    STZ $0466             ; {29669}
    JSL $@lib_027781_part2.code_0276EE ; {29672}
    COP [1B] ( &code_0073F2, #$0070 ) ; {29676}
}

code_0073F2 {
    PHX                   ; {29682}
    LDY #$&lib_014339.asciistring_014339 ; {29683}
    JSL $@lib_shared_012769.code_012769 ; {29686}
    PLX                   ; {29690}
    INC $0466             ; {29691}
    COP [1B] ( &code_007404, #$0438 ) ; {29694}
}

code_007404 {
    STZ $0466             ; {29700}
    JSL $@lib_027781_part2.code_0276EE ; {29703}
    COP [1B] ( &code_007411, #$0070 ) ; {29707}
}

code_007411 {
    LDA #$0001            ; {29713}
    TSB $vram_upload_flags ; {29716}
    COP [1B] ( &code_00741D, #$0078 ) ; {29719}
}

code_00741D {
    INC $0482             ; {29725}
    COP [91]              ; {29728}
    LDA $0482             ; {29730}
    CMP #$0004            ; {29733}
    BEQ loc_00742B        ; {29736}
    RTL                   ; {29738}

  loc_00742B:
    COP [1B] ( &code_007431, #$0078 ) ; {29739}
}

code_007431 {
    DEC $0466             ; {29745}
    COP [85] ( @common_actor_00729D_part2.code_007638 ) ; {29748}
    COP [1B] ( &code_00743F, #$00F0 ) ; {29753}
}

code_00743F {
    STZ $0030, X          ; {29759}
    COP [03] ( #20 )      ; {29762}
    SEP #$20              ; {29765}
    LDA $0030, X          ; {29767}
    ORA #$E0              ; {29770}
    STA $coldata_buffer   ; {29772}
    REP #$20              ; {29776}
    INC $0030, X          ; {29778}
    COP [1B] ( &code_00745B, #$0010 ) ; {29781}
}

code_00745B {
    COP [04]              ; {29787}
    COP [91]              ; {29789}
    RTL                   ; {29791}
}

code_007460 {
    COP [80] ( #00 )      ; {29792}
    COP [82]              ; {29795}
    LDA $0482             ; {29797}
    CMP #$0001            ; {29800}
    BNE code_007460       ; {29803}
    COP [80] ( #02 )      ; {29805}
    COP [82]              ; {29808}
    LDA $0482             ; {29810}
    CMP #$0002            ; {29813}
    BNE code_007460       ; {29816}
    COP [80] ( #00 )      ; {29818}
    COP [82]              ; {29821}
    COP [80] ( #03 )      ; {29823}
    COP [82]              ; {29826}
    COP [80] ( #01 )      ; {29828}
    COP [82]              ; {29831}
    INC $0482             ; {29833}
    COP [91]              ; {29836}
    RTL                   ; {29838}
}

code_00748F {
    COP [80] ( #04 )      ; {29839}
    COP [82]              ; {29842}
    LDA $0482             ; {29844}
    CMP #$0003            ; {29847}
    BNE code_00748F       ; {29850}
    COP [80] ( #04 )      ; {29852}
    COP [82]              ; {29855}
    COP [80] ( #06 )      ; {29857}
    COP [82]              ; {29860}
    COP [80] ( #05 )      ; {29862}
    COP [82]              ; {29865}
    INC $0482             ; {29867}
    COP [91]              ; {29870}
    RTL                   ; {29872}
}