?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374
!player_y                       0376

---------------------------------------------

Cop20_JumpIfPlayerOffGrid {
    TYX                   ; {23293}
    LDA $player_x         ; {23294}
    ORA $player_y         ; {23297}
    AND #$000F            ; {23300}
    BEQ loc_005B12        ; {23303}
    LDA [$38]             ; {23305}
    INC $38               ; {23307}
    INC $38               ; {23309}
    BRL cop_handler_006473.loc_0064C1 ; {23311}

  loc_005B12:
    BRL cop_handler_006473.loc_0064BB ; {23314}
}