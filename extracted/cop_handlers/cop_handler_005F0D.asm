?BANK 00

?INCLUDE 'cop_handler_006473'

!actor_list_tail                06A6
!actor_list_head                06A8

---------------------------------------------

Cop86_KillSelf {
    TYX 
    LDY $003C, X
    BNE loc_005F23
    LDY $003E, X
    STY $actor_list_tail
    BEQ loc_005F37
    LDA #$0000
    STA $003C, Y
    BRA loc_005F37

  loc_005F23:
    LDA $003E, X
    STA $003E, Y
    BNE loc_005F30
    STY $actor_list_head
    BRA loc_005F37

  loc_005F30:
    TAY 
    LDA $003C, X
    STA $003C, Y

  loc_005F37:
    SEP #$20
    DEC $4A
    DEC $4A
    REP #$20
    TXA 
    STA ($4A)
    BRL cop_handler_006473.loc_0064BF
}