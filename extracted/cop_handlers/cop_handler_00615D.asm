?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop9B_JumpByPlayerDeltaY {
    TYX                   ; {24925}
    LDY #$0004            ; {24926}
    LDA $player_y         ; {24929}
    SEC                   ; {24932}
    SBC $0002, X          ; {24933}
    BEQ loc_00617F        ; {24936}
    BPL loc_006178        ; {24938}
    EOR #$FFFF            ; {24940}
    CMP [$38]             ; {24943}
    BCC loc_00617F        ; {24945}
    LDY #$0002            ; {24947}
    BRA loc_00617F        ; {24950}

  loc_006178:
    CMP [$38]             ; {24952}
    BCC loc_00617F        ; {24954}
    LDY #$0006            ; {24956}

  loc_00617F:
    LDA [$38], Y          ; {24959}
    BRL cop_handler_006473.loc_0064C1 ; {24961}
}