?BANK 00

?INCLUDE 'engine_003005'

!joy_block_mask                 0326
!map_height_px                  0344
!player_actor                   039C
!random_mod_result              0437

---------------------------------------------

code_004D8B {
    STX $039A
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [9F] ( #$0008 )
    COP [91]
    LDY $player_actor
    LDA $0002, Y
    CMP #$0080
    BCC loc_004DA9
    RTL 

  loc_004DA9:
    COP [85] ( @engine_003005.code_003188 )
    LDA #$0004
    STA $0030, Y
    COP [1B] ( &code_004DBA, #$0004 )
}

code_004DBA {
    LDA #$2FC0
    TSB $joy_block_mask
    BRK #$A0
    COP [80] ( #01 )
    COP [82]
    LDA #$0100
    STA $map_height_px
    COP [01] ( &asciistring_004EF8 )
    LDA #$2FC0
    TRB $joy_block_mask
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [32] ( #0D )
    BRA loc_004E44

  loc_004DE5:
    COP [1F]
    COP [35] ( #A0 )
    LDA $random_mod_result
    CLC 
    ADC #$0028
    STA $0000, X
    LDA #$0060
    STA $0002, X
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRK #$4B
    COP [B2] ( @code_004E4B, #$0000, #$FFEE, #$0200 )
    COP [B2] ( @code_004E8A, #$0000, #$FFEE, #$0200 )
    COP [B2] ( @code_004EC9, #$0000, #$FFEE, #$0200 )
    COP [80] ( #03 )
    COP [82]
    COP [1B] ( &code_004E3B, #$0050 )
}

code_004E3B {
    LDA $0016, X
    ORA #$0200
    STA $0016, X

  loc_004E44:
    COP [80] ( #04 )
    COP [82]
    BRA loc_004DE5
}

code_004E4B {
    COP [A3]
    COP [97]
    COP [90]
    COP [88]

  loc_004E53:
    COP [9A] ( #$0020, &code_004E5D, &code_004E64, &code_004E64 )
}

code_004E5D {
    COP [80] ( #0A )
    COP [82]
    BRA loc_004E53
}

code_004E64 {
    COP [80] ( #05 )
    COP [82]

  loc_004E69:
    COP [9B] ( #$0020, &code_004E73, &code_004E7A, &code_004E73 )
}

code_004E73 {
    COP [80] ( #09 )
    COP [82]
    BRA loc_004E69
}

code_004E7A {
    COP [96]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0A, #10 )
    COP [83]
    COP [86]
    RTL 
}

code_004E8A {
    COP [A3]
    COP [96]
    COP [90]
    COP [88]

  loc_004E92:
    COP [9A] ( #$0020, &code_004EA3, &code_004EA3, &code_004E9C )
}

code_004E9C {
    COP [80] ( #0A )
    COP [82]
    BRA loc_004E92
}

code_004EA3 {
    COP [80] ( #05 )
    COP [82]

  loc_004EA8:
    COP [9B] ( #$0020, &code_004EB2, &code_004EB9, &code_004EB2 )
}

code_004EB2 {
    COP [80] ( #09 )
    COP [82]
    BRA loc_004EA8
}

code_004EB9 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0A, #10 )
    COP [83]
    COP [86]
    RTL 
}

code_004EC9 {
    COP [A3]
    COP [97]

  loc_004ECD:
    COP [9B] ( #$0020, &code_004EDE, &code_004EDE, &code_004ED7 )
}

code_004ED7 {
    COP [80] ( #08 )
    COP [82]
    BRA loc_004ECD
}

code_004EDE {
    COP [9A] ( #$0000, &code_004EEA, &code_004EEA, &code_004EE8 )
}

code_004EE8 {
    COP [96]
}

code_004EEA {
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0B, #08 )
    COP [83]
    COP [86]
    RTL 
}

asciistring_004EF8 |[10]The poor creature that[N]repeats transmigration[N]of the soul and cannot[N]die- [FIN]I will put you in [N]a deep sleep- [12][08:408][END]|