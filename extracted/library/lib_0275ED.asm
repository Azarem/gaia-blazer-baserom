?BANK 04

!frame_counter                  0312
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_0275ED {
    LDA $043B
    BEQ loc_027613
    LDA $frame_counter
    AND #$03
    BNE loc_027613
    DEC $043B
    LDA $player_hp
    CMP $player_max_hp
    BCS loc_02760B
    INC $player_hp
    BRK #$48
    BRA loc_02760E

  loc_02760B:
    STZ $043B

  loc_02760E:
    LDA #$04
    TSB $0332

  loc_027613:
    RTL 
}