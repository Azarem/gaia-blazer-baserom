?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop8C_JumpIfPlayerBeyondY {
    TYX                   ; {24529}
    LDA $player_y         ; {24530}
    SEC                   ; {24533}
    SBC $0002, X          ; {24534}
    BPL loc_005FDF        ; {24537}
    EOR #$FFFF            ; {24539}
    INC                   ; {24542}

  loc_005FDF:
    STA $00               ; {24543}
    LDA [$38]             ; {24545}
    INC $38               ; {24547}
    INC $38               ; {24549}
    CMP $00               ; {24551}
    BCC loc_005FEE        ; {24553}
    BRL cop_handler_006473.loc_0064BB ; {24555}

  loc_005FEE:
    LDA [$38]             ; {24558}
    INC $38               ; {24560}
    INC $38               ; {24562}
    BRL cop_handler_006473.loc_0064C1 ; {24564}
}