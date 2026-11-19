?BANK 00

?INCLUDE 'cop_handler_005BC1'

---------------------------------------------

Cop21_JumpIfTileAbove {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    SEC 
    SBC $0012, X
    STA $18
    BRL cop_handler_005BC1.loc_005BD0
}