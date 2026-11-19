?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop88_ToggleFlipY {
    TYX                   ; {24402}
    LDA $001C, X          ; {24403}
    EOR #$8000            ; {24406}
    STA $001C, X          ; {24409}
    BRL cop_handler_006473.loc_0064BF ; {24412}
}