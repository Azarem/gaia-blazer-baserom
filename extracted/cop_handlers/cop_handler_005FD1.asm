?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop8C_JumpIfPlayerBeyondY {
    TYX 
    LDA $player_y
    SEC 
    SBC $0002, X
    BPL loc_005FDF
    EOR #$FFFF
    INC 

  loc_005FDF:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCC loc_005FEE
    BRL cop_handler_006473.loc_0064BB

  loc_005FEE:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}