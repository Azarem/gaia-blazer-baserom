?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop8B_JumpIfPlayerBeyondX {
    TYX                   ; {24491}
    LDA $player_x         ; {24492}
    SEC                   ; {24495}
    SBC $0000, X          ; {24496}
    BPL loc_005FB9        ; {24499}
    EOR #$FFFF            ; {24501}
    INC                   ; {24504}

  loc_005FB9:
    STA $00               ; {24505}
    LDA [$38]             ; {24507}
    INC $38               ; {24509}
    INC $38               ; {24511}
    CMP $00               ; {24513}
    BCC loc_005FC8        ; {24515}
    BRL cop_handler_006473.loc_0064BB ; {24517}

  loc_005FC8:
    LDA [$38]             ; {24520}
    INC $38               ; {24522}
    INC $38               ; {24524}
    BRL cop_handler_006473.loc_0064C1 ; {24526}
}