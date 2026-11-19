?BANK 04

!frame_counter                  0312
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_0275ED {
    LDA $043B             ; {161261}
    BEQ loc_027613        ; {161264}
    LDA $frame_counter    ; {161266}
    AND #$03              ; {161269}
    BNE loc_027613        ; {161271}
    DEC $043B             ; {161273}
    LDA $player_hp        ; {161276}
    CMP $player_max_hp    ; {161279}
    BCS loc_02760B        ; {161282}
    INC $player_hp        ; {161284}
    BRK #$48              ; {161287}
    BRA loc_02760E        ; {161289}

  loc_02760B:
    STZ $043B             ; {161291}

  loc_02760E:
    LDA #$04              ; {161294}
    TSB $0332             ; {161296}

  loc_027613:
    RTL                   ; {161299}
}