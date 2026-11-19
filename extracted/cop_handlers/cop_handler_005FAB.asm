?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop8B_JumpIfPlayerBeyondX {
    TYX 
    LDA $player_x
    SEC 
    SBC $0000, X
    BPL loc_005FB9
    EOR #$FFFF
    INC 

  loc_005FB9:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCC loc_005FC8
    BRL cop_handler_006473.loc_0064BB

  loc_005FC8:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}