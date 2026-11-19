?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop90_FacePlayerY {
    TYX                   ; {24642}
    LDA $player_y         ; {24643}
    CMP $0002, X          ; {24646}
    BCC loc_006057        ; {24649}
    LDA $001C, X          ; {24651}
    ORA #$8000            ; {24654}
    STA $001C, X          ; {24657}
    BRL cop_handler_006473.loc_0064BF ; {24660}

  loc_006057:
    LDA $001C, X          ; {24663}
    AND #$7FFF            ; {24666}
    STA $001C, X          ; {24669}
    BRL cop_handler_006473.loc_0064BF ; {24672}
}