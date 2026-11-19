?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop8A_JumpIfPlayerWithinY {
    TYX                   ; {24453}
    LDA $player_y         ; {24454}
    SEC                   ; {24457}
    SBC $0002, X          ; {24458}
    BPL loc_005F93        ; {24461}
    EOR #$FFFF            ; {24463}
    INC                   ; {24466}

  loc_005F93:
    STA $00               ; {24467}
    LDA [$38]             ; {24469}
    INC $38               ; {24471}
    INC $38               ; {24473}
    CMP $00               ; {24475}
    BCS loc_005FA2        ; {24477}
    BRL cop_handler_006473.loc_0064BB ; {24479}

  loc_005FA2:
    LDA [$38]             ; {24482}
    INC $38               ; {24484}
    INC $38               ; {24486}
    BRL cop_handler_006473.loc_0064C1 ; {24488}
}