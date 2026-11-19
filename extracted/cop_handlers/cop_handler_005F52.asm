?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop88_ToggleFlipY {
    TYX 
    LDA $001C, X
    EOR #$8000
    STA $001C, X
    BRL cop_handler_006473.loc_0064BF
}