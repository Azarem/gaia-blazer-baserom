?BANK 00

?INCLUDE 'engine_003005'
?INCLUDE 'lib_system_helpers'

!joy_block_mask                 0326
!map_height_px                  0344
!scene_sprite_attr              0372
!boss_actor                     039A
!player_actor                   039C
!random_mod_result              0437
!event_flags                    1A5E

---------------------------------------------

code_004D8B {
    STX $boss_actor
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
    COP [85] ( @engine_003005.RunBossMapPatch )
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
---------------------------------------------

code_004F4D {
    LDY $boss_actor
    LDA $0016, Y
    BIT #$0400
    BNE loc_004F59
    RTL 

  loc_004F59:
    STX $boss_actor
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [1B] ( &code_004F6E, #$00B4 )
}

code_004F6E {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @code_004F9E )

  code_004F7C:
    COP [80] ( #1F )
    COP [82]
    COP [08] ( #$8000, &code_004F7C )
    COP [85] ( @code_004FA9 )
    COP [81] ( #1F, #03 )
    COP [83]
    COP [10] ( #$0215, #01, #$0078, #$00C8 )
    COP [91]
    RTL 
}

code_004F9E {
    COP [01] ( &asciistring_004FB6 )
    COP [09] ( #$8000 )
    COP [86]
    RTL 
}

code_004FA9 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #48 )
    COP [94]
    COP [86]
    RTL 
}

asciistring_004FB6 |[10]Some people believe [N]being constantly [N]reincarnated means [N]everlasting suffering-[FIN]Being alive is [N]suffering for some [N]creatures- [FIN]You will find out what[N]I mean- [12][08:408][END]|
---------------------------------------------

code_005043 {
    STX $boss_actor
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    STZ $0466
    COP [85] ( @code_0055C6 )
    COP [AC] ( @code_005344, #$0038, #$0070, #$0200 )
    COP [AC] ( @code_00534C, #$00B8, #$0070, #$0200 )
    COP [AC] ( @code_0051C4, #$0038, #$0040, #$0200 )
    COP [AC] ( @code_0051F2, #$00B8, #$0040, #$0200 )
    COP [03] ( #3D )
    COP [04]
    BRA loc_0050ED

  loc_00508A:
    COP [91]
    LDA $event_flags
    AND #$00FF
    CMP #$0004
    BEQ loc_005098
    RTL 

  loc_005098:
    SEP #$20
    STZ $event_flags
    REP #$20
    COP [80] ( #14 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #12 )
    COP [82]
    COP [B0] ( @code_0051B6, #$0300 )
    COP [80] ( #13 )
    COP [82]
    COP [B2] ( @code_005194, #$0008, #$0010, #$0200 )
    COP [B2] ( @code_0051A4, #$0008, #$0010, #$0200 )
    COP [B2] ( @code_0051B2, #$0008, #$0010, #$0200 )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #15 )
    COP [82]

  loc_0050ED:
    COP [03] ( #04 )
    COP [B0] ( @code_005101, #$0301 )
    COP [1B] ( &code_0050FD, #$0028 )
}

code_0050FD {
    COP [04]
    BRA loc_00508A
}

code_005101 {
    LDA $001A, X
    ORA #$0100
    STA $001A, X
    COP [1F]
    COP [35] ( #A0 )
    LDA $random_mod_result
    CLC 
    ADC #$0020
    STA $0000, X
    COP [1F]
    COP [35] ( #1E )
    LDA $random_mod_result
    CLC 
    ADC #$00B0
    STA $0002, X
    SEP #$20
    LDA #$FF
    STA $0025, X
    REP #$20
    COP [80] ( #16 )
    COP [82]
    LDA $0016, X
    AND #$FCFF
    STA $0016, X

  loc_00513F:
    LDA $0025, X
    AND #$00FF
    CMP #$00FC
    BCC loc_005151
    COP [80] ( #17 )
    COP [82]
    BRA loc_00513F

  loc_005151:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [80] ( #18 )
    COP [82]
    SEP #$20
    INC $event_flags
    REP #$20
    COP [B0] ( @code_005170, #$4000 )
    COP [86]
    RTL 
}

code_005170 {
    COP [A8] ( #$8000, #0E )
    LDA $0005
    STA $001E, X
    STZ $0020, X
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A4]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #0A, #04 )
    COP [83]
    COP [86]
    RTL 
}

code_005194 {
    BRK #$51
    COP [80] ( #1A )
    COP [82]
    COP [81] ( #1C, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0051A4 {
    COP [80] ( #1B )
    COP [82]
    COP [81] ( #1C, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0051B2 {
    COP [96]
    BRA code_0051A4
}

code_0051B6 {
    COP [A3]
    COP [A0] ( #$FFFE )
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

code_0051C4 {
    COP [81] ( #0E, #0E )
    COP [83]
    COP [80] ( #0D )
    COP [82]
    BRK #$4B
    COP [B0] ( @code_005220, #$0200 )
    COP [1B] ( &code_0051DE, #$0002 )
}

code_0051DE {
    COP [03] ( #03 )
    COP [B0] ( @code_00526F, #$0200 )
    COP [1B] ( &code_0051EE, #$0003 )
}

code_0051EE {
    COP [04]
    BRA code_0051C4
}

code_0051F2 {
    COP [81] ( #0E, #0E )
    COP [83]
    COP [80] ( #0D )
    COP [82]
    BRK #$4B
    COP [B0] ( @code_0052B2, #$0200 )
    COP [1B] ( &code_00520C, #$0002 )
}

code_00520C {
    COP [03] ( #03 )
    COP [B0] ( @code_005301, #$0200 )
    COP [1B] ( &code_00521C, #$0003 )
}

code_00521C {
    COP [04]
    BRA code_0051F2
}

code_005220 {
    LDA $0016, X
    BIT #$8000
    BNE loc_00526C
    COP [81] ( #0C, #02 )
    COP [83]
    COP [9A] ( #$0000, &code_005238, &code_005252, &code_005252 )
}

code_005238 {
    COP [09] ( #$9906 )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_005220
}

code_005252 {
    COP [09] ( #$1906 )
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_005220

  loc_00526C:
    COP [86]
    RTL 
}

code_00526F {
    LDA $0016, X
    BIT #$8000
    BNE loc_0052AF
    COP [81] ( #0C, #02 )
    COP [83]
    COP [07] ( #$1906, &code_005299 )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_00526F
}

code_005299 {
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_00526F

  loc_0052AF:
    COP [86]
    RTL 
}

code_0052B2 {
    LDA $0016, X
    BIT #$8000
    BNE loc_0052FE
    COP [81] ( #0C, #02 )
    COP [83]
    COP [9A] ( #$0000, &code_0052CA, &code_0052E4, &code_0052E4 )
}

code_0052CA {
    COP [09] ( #$9907 )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_0052B2
}

code_0052E4 {
    COP [09] ( #$1907 )
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_0052B2

  loc_0052FE:
    COP [86]
    RTL 
}

code_005301 {
    LDA $0016, X
    BIT #$8000
    BNE loc_005341
    COP [81] ( #0C, #02 )
    COP [83]
    COP [07] ( #$1907, &code_00532B )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_005301
}

code_00532B {
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_005301

  loc_005341:
    COP [86]
    RTL 
}

code_005344 {
    COP [80] ( #11 )
    COP [82]
    COP [91]
    RTL 
}

code_00534C {
    COP [80] ( #10 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

code_0055C6 {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    SEP #$20
    LDA $0466
    BNE loc_0055E6
    LDA #$2C
    XBA 
    LDA #$^binary_0055F5
    LDY #$&binary_0055F5+4
    JSL $@lib_system_helpers.QueueHdmaDirect
    BRA loc_0055F2

  loc_0055E6:
    LDA #$2C
    XBA 
    LDA #$^binary_0055F5
    LDY #$&binary_0055F5
    JSL $@lib_system_helpers.QueueHdmaDirect

  loc_0055F2:
    REP #$20
    RTL 
}
---------------------------------------------

binary_0055F5 #7F161016011700