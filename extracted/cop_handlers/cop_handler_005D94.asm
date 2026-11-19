?BANK 00

?INCLUDE 'cop_handler_006473'

!player_exp                     1B78

---------------------------------------------

Cop36_AddBcdCounter {
    TYX                   ; {23956}
    LDA [$38]             ; {23957}
    INC $38               ; {23959}
    INC $38               ; {23961}
    SED                   ; {23963}
    CLC                   ; {23964}
    ADC $player_exp       ; {23965}
    STA $player_exp       ; {23968}
    LDA $1B7A             ; {23971}
    ADC #$0000            ; {23974}
    STA $1B7A             ; {23977}
    CLD                   ; {23980}
    BRL cop_handler_006473.loc_0064BF ; {23981}
}