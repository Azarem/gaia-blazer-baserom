?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop8F_FacePlayerX {
    TYX 
    LDA $player_x
    CMP $0000, X
    BCC loc_006036
    LDA $001C, X
    ORA #$4000
    STA $001C, X
    BRL cop_handler_006473.loc_0064BF

  loc_006036:
    LDA $001C, X
    AND #$BFFF
    STA $001C, X
    BRL cop_handler_006473.loc_0064BF
}