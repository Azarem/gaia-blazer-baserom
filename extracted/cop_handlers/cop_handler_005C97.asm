?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C

---------------------------------------------

Cop2F_ShiftPlayerActors {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $16
    LDA [$38]
    INC $38
    INC $38
    STA $18
    LDY $player_actor
    LDA $0000, Y
    CLC 
    ADC $16
    STA $0000, Y
    LDA $0002, Y
    CLC 
    ADC $18
    STA $0002, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    CLC 
    ADC $16
    STA $0000, Y
    LDA $0002, Y
    CLC 
    ADC $18
    STA $0002, Y
    BRL cop_handler_006473.loc_0064BF
}