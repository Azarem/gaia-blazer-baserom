?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374
!player_y                       0376

---------------------------------------------

Cop9C_JumpByPlayerAxis {
    TYX                   ; {24964}
    LDY #$0000            ; {24965}
    LDA $player_x         ; {24968}
    SEC                   ; {24971}
    SBC $0000, X          ; {24972}
    BPL loc_006195        ; {24975}
    EOR #$FFFF            ; {24977}
    INC                   ; {24980}

  loc_006195:
    PHA                   ; {24981}
    LDA $player_y         ; {24982}
    SEC                   ; {24985}
    SBC $0002, X          ; {24986}
    BPL loc_0061A3        ; {24989}
    EOR #$FFFF            ; {24991}
    INC                   ; {24994}

  loc_0061A3:
    CMP $01, S            ; {24995}
    BCC loc_0061AC        ; {24997}
    LDY #$0002            ; {24999}
    BRA loc_0061AC        ; {25002}

  loc_0061AC:
    PLA                   ; {25004}
    LDA [$38], Y          ; {25005}
    BRL cop_handler_006473.loc_0064C1 ; {25007}
}