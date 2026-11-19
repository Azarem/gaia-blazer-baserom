?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C

---------------------------------------------

Cop34_PlayerActorsSetBit7 {
    TYX 
    LDY $player_actor
    JSR $&code_005D6C
    LDY $039E
    JSR $&code_005D6C
    LDY $03A0
    JSR $&code_005D6C
    INC $0464
    BRL cop_handler_006473.loc_0064BF
}

code_005D6C {
    LDA $001A, Y
    ORA #$0080
    STA $001A, Y
    RTS 
}