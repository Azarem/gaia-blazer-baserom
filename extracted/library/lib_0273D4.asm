?BANK 04

?INCLUDE 'data_00F9F7'

!player_actor                   039C

---------------------------------------------

code_0273D4 {
    PHP 
    SEP #$20
    LDY $player_actor
    LDX $001E, Y
    CPX #$002C
    BCS loc_0273E8
    LDA $&data_00F9F7.binary_00FA7F, X
    PLP 
    CLC 
    RTL 

  loc_0273E8:
    PLP 
    SEC 
    RTL 
}