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
    LDA $0016, X
    ORA #$2010
    STA $0016, X
    STX $player_actor
    STZ $scroll_bg3_x
    LDA #$00FF
    STA $scroll_bg3_y
    STZ $046A
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
    COP [85] ( @common_actor_00729D_part2.code_00758C )
    COP [85] ( @common_actor_00729D_part2.code_0074E8 )
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
    LDY #$&lib_014192.asciistring_014192
    JSL $@lib_shared_012769.code_012769
    PLX 
    INC $0466
    COP [1B] ( &code_007319, #$02D0 )
}

code_007319 {
    STZ $0466
    JSL $@lib_027781_part2.code_0276EE
    COP [1B] ( &code_007326, #$0070 )
}

code_007326 {
    PHX 
    LDY #$&lib_0141F1.asciistring_0141F1
    JSL $@lib_shared_012769.code_012769
    PLX 
    INC $0466
    COP [1B] ( &code_007338, #$02D0 )
}

code_007338 {
    STZ $0466
    JSL $@lib_027781_part2.code_0276EE
    COP [1B] ( &code_007345, #$0070 )
}

code_007345 {
    PHX 
    LDY #$&lib_014228.asciistring_014228
    JSL $@lib_shared_012769.code_012769
    PLX 
    INC $0466
    COP [1B] ( &code_007357, #$02D0 )
}

code_007357 {
    STZ $0466
    JSL $@lib_027781_part2.code_0276EE
    COP [1B] ( &code_007364, #$0070 )
}

code_007364 {
    PHX 
    LDY #$&lib_01426F.asciistring_01426F
    JSL $@lib_shared_012769.code_012769
    PLX 
    INC $0466
    COP [1B] ( &code_007376, #$02D0 )
}

code_007376 {
    STZ $0466
    JSL $@lib_027781_part2.code_0276EE
    COP [1B] ( &code_007383, #$0070 )
}

code_007383 {
    COP [1B] ( &code_007389, #$0078 )
}

code_007389 {
    COP [B0] ( @common_actor_00729D_part2.code_0074D3, #$2010 )
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
    LDY #$&lib_0142BB.asciistring_0142BB
    JSL $@lib_shared_012769.code_012769
    PLX 
    INC $0466
    COP [1B] ( &code_0073C6, #$0438 )
}

code_0073C6 {
    STZ $0466
    JSL $@lib_027781_part2.code_0276EE
    COP [1B] ( &code_0073D3, #$0070 )
}

code_0073D3 {
    PHX 
    LDY #$&lib_0142E1.asciistring_0142E1
    JSL $@lib_shared_012769.code_012769
    PLX 
    INC $0466
    COP [1B] ( &code_0073E5, #$0438 )
}

code_0073E5 {
    STZ $0466
    JSL $@lib_027781_part2.code_0276EE
    COP [1B] ( &code_0073F2, #$0070 )
}

code_0073F2 {
    PHX 
    LDY #$&lib_014339.asciistring_014339
    JSL $@lib_shared_012769.code_012769
    PLX 
    INC $0466
    COP [1B] ( &code_007404, #$0438 )
}

code_007404 {
    STZ $0466
    JSL $@lib_027781_part2.code_0276EE
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
    COP [85] ( @common_actor_00729D_part2.code_007638 )
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