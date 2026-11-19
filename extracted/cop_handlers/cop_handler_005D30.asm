?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C

---------------------------------------------

Cop33_PlayerActorsClearBit7 {
    TYX 
    LDY $player_actor
    JSR $&code_005D49
    LDY $039E
    JSR $&code_005D49
    LDY $03A0
    JSR $&code_005D49
    STZ $0464
    BRL cop_handler_006473.loc_0064BF
}

code_005D49 {
    LDA $001A, Y
    AND #$FF7F
    STA $001A, Y
    RTS 
}