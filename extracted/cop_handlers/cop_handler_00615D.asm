?BANK 00

?INCLUDE 'cop_handler_006473'

!player_y                       0376

---------------------------------------------

Cop9B_JumpByPlayerDeltaY {
    TYX 
    LDY #$0004
    LDA $player_y
    SEC 
    SBC $0002, X
    BEQ loc_00617F
    BPL loc_006178
    EOR #$FFFF
    CMP [$38]
    BCC loc_00617F
    LDY #$0002
    BRA loc_00617F

  loc_006178:
    CMP [$38]
    BCC loc_00617F
    LDY #$0006

  loc_00617F:
    LDA [$38], Y
    BRL cop_handler_006473.loc_0064C1
}