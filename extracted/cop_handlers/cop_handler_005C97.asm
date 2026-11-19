?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C

---------------------------------------------

Cop2F_ShiftPlayerActors {
    TYX                   ; {23703}
    LDA [$38]             ; {23704}
    INC $38               ; {23706}
    INC $38               ; {23708}
    STA $16               ; {23710}
    LDA [$38]             ; {23712}
    INC $38               ; {23714}
    INC $38               ; {23716}
    STA $18               ; {23718}
    LDY $player_actor     ; {23720}
    LDA $0000, Y          ; {23723}
    CLC                   ; {23726}
    ADC $16               ; {23727}
    STA $0000, Y          ; {23729}
    LDA $0002, Y          ; {23732}
    CLC                   ; {23735}
    ADC $18               ; {23736}
    STA $0002, Y          ; {23738}
    LDA $003E, Y          ; {23741}
    TAY                   ; {23744}
    LDA $0000, Y          ; {23745}
    CLC                   ; {23748}
    ADC $16               ; {23749}
    STA $0000, Y          ; {23751}
    LDA $0002, Y          ; {23754}
    CLC                   ; {23757}
    ADC $18               ; {23758}
    STA $0002, Y          ; {23760}
    BRL cop_handler_006473.loc_0064BF ; {23763}
}