?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop87_ToggleFlipX {
    TYX                   ; {24389}
    LDA $001C, X          ; {24390}
    EOR #$4000            ; {24393}
    STA $001C, X          ; {24396}
    BRL cop_handler_006473.loc_0064BF ; {24399}
}