?BANK 00

?INCLUDE 'common_actor_006E28_part2'
?INCLUDE 'lib_010000'

!joy_pressed                    0322
!joy_block_mask                 0326
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!player_actor                   039C

---------------------------------------------

code_006E28 {
    COP [07] ( #$9F05, &code_006E34 )
    COP [07] ( #$9F04, &common_actor_006E28_part2.code_007264 )
}

code_006E34 {
    INC $0454
    COP [85] ( @common_actor_006E28_part2.code_007141 )
    LDA #$3080
    TSB $joy_block_mask
    COP [A3]
    STX $player_actor
    STZ $040D
    STZ $0410
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
    JSL $@lib_010000.code_010000
    PLX 
    RTL 
}