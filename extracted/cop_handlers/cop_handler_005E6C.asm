?BANK 00

?INCLUDE 'cop_handler_006473'

!transition_type                03E3

---------------------------------------------

Cop3C_SetMode03E3 {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $transition_type
    BRL cop_handler_006473.loc_0064BF
}