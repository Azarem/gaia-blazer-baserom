?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop07_JumpIfFlagClear {
    TYX                   ; {22590}
    LDA [$38]             ; {22591}
    BRA loc_005849        ; {22593}
}

Cop08_JumpIfFlagSet {
    TYX                   ; {22595}
    LDA [$38]             ; {22596}
    EOR #$8000            ; {22598}

  loc_005849:
    BMI loc_005852        ; {22601}
    JSR $&engine_0064F8.code_0064F8 ; {22603}
    BCS loc_005857        ; {22606}
    BRA loc_00585A        ; {22608}

  loc_005852:
    JSR $&engine_0064F8.code_0064F8 ; {22610}
    BCS loc_00585A        ; {22613}

  loc_005857:
    BRL cop_handler_006473.loc_0064B7 ; {22615}

  loc_00585A:
    INC $38               ; {22618}
    INC $38               ; {22620}
    LDA [$38]             ; {22622}
    INC $38               ; {22624}
    INC $38               ; {22626}
    BRL cop_handler_006473.loc_0064C1 ; {22628}
}