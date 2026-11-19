?BANK 00

?INCLUDE 'cop_handler_006473'

!rng_state                      0301
!random_mod_result              0437

---------------------------------------------

Cop35_RandomMod {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $00
    LDA $rng_state+1
    AND #$00FF

  loc_005D86:
    SEC 
    SBC $00
    BPL loc_005D86
    CLC 
    ADC $00
    STA $random_mod_result
    BRL cop_handler_006473.loc_0064BF
}