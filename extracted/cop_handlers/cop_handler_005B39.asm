?BANK 00

?INCLUDE 'cop_handler_005BC1'

---------------------------------------------

Cop23_JumpIfTileLeft {
    TYX 
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    BRL cop_handler_005BC1.loc_005BD0
}