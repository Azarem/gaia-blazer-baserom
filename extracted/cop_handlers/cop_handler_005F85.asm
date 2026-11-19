?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop8A_JumpIfPlayerWithinY {
    TYX 
    LDA $player_y
    SEC 
    SBC $0002, X
    BPL loc_005F93
    EOR #$FFFF
    INC 

  loc_005F93:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCS loc_005FA2
    BRL cop_handler_006473.loc_0064BB

  loc_005FA2:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}