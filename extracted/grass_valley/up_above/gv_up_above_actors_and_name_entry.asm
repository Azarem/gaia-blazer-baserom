?BANK 00

?INCLUDE 'lib_010000'
?INCLUDE 'shared_actor_helpers_bank0'

!joy_pressed                    0322
!joy_block_mask                 0326
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!player_actor                   039C
!asset_cache_gfx2               040D
!asset_cache_gfx3               0410
!reload_menu_gfx                0454

---------------------------------------------

code_006E28 {
    COP [07] ( #$9F05, &code_006E34 )
    COP [07] ( #$9F04, &code_007264 )
}

code_006E34 {
    INC $reload_menu_gfx
    COP [85] ( @code_007141 )
    LDA #$3080
    TSB $joy_block_mask
    COP [A3]
    STX $player_actor
    STZ $asset_cache_gfx2
    STZ $asset_cache_gfx3
    COP [85] ( @code_00708E )
    LDA $0000, X
    CMP #$0070
    BEQ code_006EA0
    CMP #$0030
    BNE loc_006E62
    BRL code_006EDE

  loc_006E62:
    CMP #$01B0
    BNE loc_006E6A
    BRL code_006FD4

  loc_006E6A:
    CMP #$0170
    BNE loc_006E72
    BRL code_007026

  loc_006E72:
    LDA $0002, X
    CMP #$0170
    BNE loc_006E7D
    BRL code_006F30

  loc_006E7D:
    CMP #$0070
    BNE loc_006E85
    BRL code_006F82

  loc_006E85:
    BRL loc_007073

  loc_006E88:
    LDA $joy_pressed
    BIT #$0400
    BNE loc_006EA7
    BIT #$8000
    BEQ code_006EA0
    BRK #$98
    COP [10] ( #$0100, #00, #$0070, #$0050 )

  code_006EA0:
    COP [80] ( #10 )
    COP [82]
    BRA loc_006E88

  loc_006EA7:
    COP [08] ( #$9B00, &code_006EA0 )
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #24 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL code_006EDE

  loc_006EC1:
    LDA $joy_pressed
    BIT #$0800
    BNE loc_006EE5
    BIT #$0100
    BNE loc_006EF9
    BIT #$8000
    BEQ code_006EDE
    BRK #$98
    COP [10] ( #$0200, #00, #$0070, #$0050 )

  code_006EDE:
    COP [80] ( #02 )
    COP [82]
    BRA loc_006EC1

  loc_006EE5:
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #25 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL code_006EA0

  loc_006EF9:
    COP [08] ( #$9B01, &code_006EDE )
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL code_006F30

  loc_006F13:
    LDA $joy_pressed
    BIT #$0200
    BNE loc_006F37
    BIT #$0800
    BNE loc_006F4B
    BIT #$8000
    BEQ code_006F30
    BRK #$98
    COP [10] ( #$0300, #00, #$0070, #$0050 )

  code_006F30:
    COP [80] ( #02 )
    COP [82]
    BRA loc_006F13

  loc_006F37:
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006EC1

  loc_006F4B:
    COP [08] ( #$9B02, &code_006F30 )
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_006F65

  loc_006F65:
    LDA $joy_pressed
    BIT #$0400
    BNE loc_006F89
    BIT #$0100
    BNE loc_006F9D
    BIT #$8000
    BEQ code_006F82
    BRK #$98
    COP [10] ( #$0400, #00, #$0070, #$0050 )

  code_006F82:
    COP [80] ( #10 )
    COP [82]
    BRA loc_006F65

  loc_006F89:
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006F13

  loc_006F9D:
    COP [08] ( #$9B03, &code_006F82 )
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #2A )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006FB7

  loc_006FB7:
    LDA $joy_pressed
    BIT #$0200
    BNE loc_006FDB
    BIT #$0800
    BNE loc_006FEF
    BIT #$8000
    BEQ code_006FD4
    BRK #$98
    COP [10] ( #$0500, #00, #$0070, #$0050 )

  code_006FD4:
    COP [80] ( #02 )
    COP [82]
    BRA loc_006FB7

  loc_006FDB:
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_006F65

  loc_006FEF:
    COP [08] ( #$9B04, &code_006FD4 )
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_007009

  loc_007009:
    LDA $joy_pressed
    BIT #$0400
    BNE loc_00702D
    BIT #$0800
    BNE loc_007041
    BIT #$8000
    BEQ code_007026
    BRK #$98
    COP [10] ( #$0600, #00, #$0070, #$0050 )

  code_007026:
    COP [80] ( #10 )
    COP [82]
    BRA loc_007009

  loc_00702D:
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006FB7

  loc_007041:
    COP [08] ( #$9B05, &code_007026 )
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_00705B

  loc_00705B:
    LDA $joy_pressed
    BIT #$0100
    BNE loc_00707A
    BIT #$8000
    BEQ loc_007073
    BRK #$98
    COP [10] ( #$0700, #00, #$0070, #$0050 )

  loc_007073:
    COP [80] ( #10 )
    COP [82]
    BRA loc_00705B

  loc_00707A:
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #1E )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_007009
}

code_00708E {
    LDY $player_actor
    LDA $0000, Y
    STA $player_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $0002, Y
    STA $player_y
    LSR 
    LSR 
    LSR 
    LSR 
    DEC 
    STA $player_tile_y
    PHX 
    JSL $@lib_010000.AimCameraAtPlayer
    PLX 
    RTL 
}
---------------------------------------------

code_0070B3 {
    COP [07] ( #$9F05, &code_0070BF )
    COP [07] ( #$9F04, &code_0070C2 )
}

code_0070BF {
    COP [91]
    RTL 
}

code_0070C2 {
    COP [86]
    RTL 
}

code_0070C5 {
    RTL 
}

code_0070C6 {
    COP [A3]
    RTL 
}

code_0070C9 {
    BRA code_0070B3

  code_0070CB:
    RTL 
}

code_0070CC {
    RTL 
}

code_0070CD {
    BRA code_0070B3

  code_0070CF:
    COP [80] ( #04 )
    COP [82]
    RTL 
}
---------------------------------------------

code_0070D5 {
    COP [80] ( #05 )
    COP [82]
    RTL 
}
---------------------------------------------

code_0070DB {
    COP [80] ( #30 )
    COP [82]
    RTL 
}
---------------------------------------------

code_0070E1 {
    RTL 
}
---------------------------------------------

code_0070E2 {
    RTL 
}
---------------------------------------------

code_0070E3 {
    COP [14] ( #$00B6, &code_0070EC )
    COP [91]
    RTL 
}

code_0070EC {
    COP [80] ( #18 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

code_0070F4 {
    COP [14] ( #$0009, &code_0070FB )
    RTL 
}

code_0070FB {
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

code_007103 {
    RTL 
}
---------------------------------------------

code_007104 {
    COP [14] ( #$012F, &code_00710D )
    COP [91]
    RTL 
}

code_00710D {
    COP [80] ( #12 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

code_007115 {
    COP [80] ( #31 )
    COP [82]
    RTL 
}
---------------------------------------------

code_00711B {
    COP [80] ( #32 )
    COP [82]
    RTL 
}
---------------------------------------------

code_007121 {
    COP [80] ( #33 )
    COP [82]
    RTL 
}
---------------------------------------------

code_007127 {
    COP [07] ( #$9F05, &code_007133 )
    COP [07] ( #$9F04, &code_00713A )
}

code_007133 {
    COP [92] ( #2D )
    COP [94]
    BRA code_007133
}

code_00713A {
    COP [92] ( #4B )
    COP [94]
    BRA code_00713A
}
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
    INC $reload_menu_gfx
    STZ $asset_cache_gfx2
    STZ $asset_cache_gfx3
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
---------------------------------------------

code_00797B {
    COP [07] ( #$9F06, &code_007995 )
    COP [09] ( #$9F06 )
    COP [1B] ( &code_00798B, #$0002 )
}

code_00798B {
    COP [01] ( &asciistring_007998 )
    COP [3A]
    COP [01] ( &asciistring_007A06 )
}

code_007995 {
    COP [86]
    RTL 
}

asciistring_007998 |[10]A voice came from [N]above- [FIN]"My follower, since [N]you will be able to [N]speak with all living [N]things, [FIN]you should have a [N]name- Please choose a [N]name for yourself- [JMP:&shared_actor_helpers_bank0.asciistring_007A52]|

asciistring_007A06 |[10][02:2],------- [N]What an interesting [N]name- [FIN]Allright, go and save [N]the world for all [N]creatures- [JMP:&shared_actor_helpers_bank0.asciistring_007A52]|