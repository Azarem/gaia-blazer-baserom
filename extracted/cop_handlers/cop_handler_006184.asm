?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374
!player_y                       0376

---------------------------------------------

Cop9C_JumpByPlayerAxis {
    TYX 
    LDY #$0000
    LDA $player_x
    SEC 
    SBC $0000, X
    BPL loc_006195
    EOR #$FFFF
    INC 

  loc_006195:
    PHA 
    LDA $player_y
    SEC 
    SBC $0002, X
    BPL loc_0061A3
    EOR #$FFFF
    INC 

  loc_0061A3:
    CMP $01, S
    BCC loc_0061AC
    LDY #$0002
    BRA loc_0061AC

  loc_0061AC:
    PLA 
    LDA [$38], Y
    BRL cop_handler_006473.loc_0064C1
}