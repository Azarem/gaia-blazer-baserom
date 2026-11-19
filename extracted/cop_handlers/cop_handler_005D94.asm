?BANK 00

?INCLUDE 'cop_handler_006473'

!player_exp                     1B78

---------------------------------------------

Cop36_AddBcdCounter {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    SED 
    CLC 
    ADC $player_exp
    STA $player_exp
    LDA $1B7A
    ADC #$0000
    STA $1B7A
    CLD 
    BRL cop_handler_006473.loc_0064BF
}