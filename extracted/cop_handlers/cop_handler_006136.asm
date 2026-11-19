?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374

---------------------------------------------

Cop9A_JumpByPlayerDeltaX {
    TYX 
    LDY #$0004
    LDA $player_x
    SEC 
    SBC $0000, X
    BEQ loc_006158
    BPL loc_006151
    EOR #$FFFF
    CMP [$38]
    BCC loc_006158
    LDY #$0002
    BRA loc_006158

  loc_006151:
    CMP [$38]
    BCC loc_006158
    LDY #$0006

  loc_006158:
    LDA [$38], Y
    BRL cop_handler_006473.loc_0064C1
}