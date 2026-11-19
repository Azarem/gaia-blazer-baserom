?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop87_ToggleFlipX {
    TYX 
    LDA $001C, X
    EOR #$4000
    STA $001C, X
    BRL cop_handler_006473.loc_0064BF
}