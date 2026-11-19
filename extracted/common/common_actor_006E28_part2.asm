?BANK 00

!joy_block_mask                 0326

---------------------------------------------

code_007141 {
    COP [07] ( #$9B00, &code_007149 )
    BRA loc_00716F
}

code_007149 {
    COP [AC] ( @code_007161, #$0070, #$00D0, #$0040 )
    COP [AC] ( @code_007169, #$0030, #$0150, #$0040 )
    BRA loc_00716F
}

code_007161 {
    COP [96]
    LDA #$000E
    BRL loc_007254
}

code_007169 {
    LDA #$000B
    BRL loc_007254

  loc_00716F:
    COP [07] ( #$9B01, &code_007177 )
    BRA loc_00719D
}

code_007177 {
    COP [AC] ( @code_00718F, #$0040, #$0160, #$0040 )
    COP [AC] ( @code_007195, #$00E0, #$0160, #$0040 )
    BRA loc_00719D
}

code_00718F {
    LDA #$0008
    BRL loc_007254
}

code_007195 {
    COP [96]
    LDA #$0008
    BRL loc_007254

  loc_00719D:
    COP [07] ( #$9B02, &code_0071A5 )
    BRA loc_0071CB
}

code_0071A5 {
    COP [AC] ( @code_0071BD, #$00F0, #$0150, #$0040 )
    COP [AC] ( @code_0071C3, #$00F0, #$0080, #$0040 )
    BRA loc_0071CB
}

code_0071BD {
    LDA #$0007
    BRL loc_007254
}

code_0071C3 {
    COP [98]
    LDA #$0007
    BRL loc_007254

  loc_0071CB:
    COP [07] ( #$9B03, &code_0071D3 )
    BRA loc_0071F7
}

code_0071D3 {
    COP [AC] ( @code_0071EB, #$0100, #$0070, #$0040 )
    COP [AC] ( @code_0071F1, #$01A0, #$0140, #$0040 )
    BRA loc_0071F7
}

code_0071EB {
    LDA #$000C
    BRL loc_007254
}

code_0071F1 {
    LDA #$000F
    BRL loc_007254

  loc_0071F7:
    COP [07] ( #$9B04, &code_0071FF )
    BRA loc_007225
}

code_0071FF {
    COP [AC] ( @code_007217, #$01B0, #$0130, #$0040 )
    COP [AC] ( @code_00721F, #$0170, #$0090, #$0040 )
    BRA loc_007225
}

code_007217 {
    COP [96]
    LDA #$000B
    BRL loc_007254
}

code_00721F {
    LDA #$000E
    BRL loc_007254

  loc_007225:
    COP [07] ( #$9B05, &code_00722D )
    BRA loc_007243
}

code_00722D {
    COP [AC] ( @code_007246, #$0170, #$0050, #$0040 )
    COP [AC] ( @code_00724E, #$0100, #$0030, #$0040 )

  loc_007243:
    COP [86]
    RTL 
}

code_007246 {
    COP [96]
    LDA #$000A
    BRL loc_007254
}

code_00724E {
    LDA #$0009
    BRL loc_007254

  loc_007254:
    STA $001E, X
    STZ $0020, X
    COP [91]
    COP [82]

  code_00725E:
    COP [1B] ( &code_00725E, #$00FF )
}

code_007264 {
    LDA #$BF80
    TSB $joy_block_mask
    COP [85] ( @code_007290 )
    COP [34]
    BRK #$86
    COP [1B] ( &code_007279, #$01A4 )
}

code_007279 {
    INC $0454
    STZ $040D
    STZ $0410
    COP [09] ( #$9F05 )
    COP [10] ( #$0700, #00, #$0070, #$0060 )
    RTL 
}

code_007290 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #44 )
    COP [94]
    COP [86]
    RTL 
}