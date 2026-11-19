?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop90_FacePlayerY {
    TYX 
    LDA $player_y
    CMP $0002, X
    BCC loc_006057
    LDA $001C, X
    ORA #$8000
    STA $001C, X
    BRL cop_handler_006473.loc_0064BF

  loc_006057:
    LDA $001C, X
    AND #$7FFF
    STA $001C, X
    BRL cop_handler_006473.loc_0064BF
}