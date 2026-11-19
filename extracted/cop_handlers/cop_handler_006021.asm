?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop8F_FacePlayerX {
    TYX                   ; {24609}
    LDA $player_x         ; {24610}
    CMP $0000, X          ; {24613}
    BCC loc_006036        ; {24616}
    LDA $001C, X          ; {24618}
    ORA #$4000            ; {24621}
    STA $001C, X          ; {24624}
    BRL cop_handler_006473.loc_0064BF ; {24627}

  loc_006036:
    LDA $001C, X          ; {24630}
    AND #$BFFF            ; {24633}
    STA $001C, X          ; {24636}
    BRL cop_handler_006473.loc_0064BF ; {24639}
}