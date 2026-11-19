?BANK 00

?INCLUDE 'cop_handler_005BC1'

---------------------------------------------

Cop22_JumpIfTileAtPos {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    STA $18
    BRL cop_handler_005BC1.loc_005BD0
}