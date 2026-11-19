?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop89_JumpIfPlayerWithinX {
    TYX                   ; {24415}
    LDA $player_x         ; {24416}
    SEC                   ; {24419}
    SBC $0000, X          ; {24420}
    BPL loc_005F6D        ; {24423}
    EOR #$FFFF            ; {24425}
    INC                   ; {24428}

  loc_005F6D:
    STA $00               ; {24429}
    LDA [$38]             ; {24431}
    INC $38               ; {24433}
    INC $38               ; {24435}
    CMP $00               ; {24437}
    BCS loc_005F7C        ; {24439}
    BRL cop_handler_006473.loc_0064BB ; {24441}

  loc_005F7C:
    LDA [$38]             ; {24444}
    INC $38               ; {24446}
    INC $38               ; {24448}
    BRL cop_handler_006473.loc_0064C1 ; {24450}
}