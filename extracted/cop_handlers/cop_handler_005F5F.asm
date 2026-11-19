?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop89_JumpIfPlayerWithinX {
    TYX 
    LDA $player_x
    SEC 
    SBC $0000, X
    BPL loc_005F6D
    EOR #$FFFF
    INC 

  loc_005F6D:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCS loc_005F7C
    BRL cop_handler_006473.loc_0064BB

  loc_005F7C:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}