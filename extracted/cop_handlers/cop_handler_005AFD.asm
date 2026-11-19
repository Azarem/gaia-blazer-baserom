?BANK 00

?INCLUDE 'cop_handler_006473'

!player_x                       0374
!player_y                       0376

---------------------------------------------

Cop20_JumpIfPlayerOffGrid {
    TYX 
    LDA $player_x
    ORA $player_y
    AND #$000F
    BEQ loc_005B12
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1

  loc_005B12:
    BRL cop_handler_006473.loc_0064BB
}