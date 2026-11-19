?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop9A_JumpByPlayerDeltaX {
    TYX                   ; {24886}
    LDY #$0004            ; {24887}
    LDA $player_x         ; {24890}
    SEC                   ; {24893}
    SBC $0000, X          ; {24894}
    BEQ loc_006158        ; {24897}
    BPL loc_006151        ; {24899}
    EOR #$FFFF            ; {24901}
    CMP [$38]             ; {24904}
    BCC loc_006158        ; {24906}
    LDY #$0002            ; {24908}
    BRA loc_006158        ; {24911}

  loc_006151:
    CMP [$38]             ; {24913}
    BCC loc_006158        ; {24915}
    LDY #$0006            ; {24917}

  loc_006158:
    LDA [$38], Y          ; {24920}
    BRL cop_handler_006473.loc_0064C1 ; {24922}
}