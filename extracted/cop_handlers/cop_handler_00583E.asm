?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop07_JumpIfFlagClear {
    TYX 
    LDA [$38]
    BRA loc_005849
}

Cop08_JumpIfFlagSet {
    TYX 
    LDA [$38]
    EOR #$8000

  loc_005849:
    BMI loc_005852
    JSR $&engine_0064F8.code_0064F8
    BCS loc_005857
    BRA loc_00585A

  loc_005852:
    JSR $&engine_0064F8.code_0064F8
    BCS loc_00585A

  loc_005857:
    BRL cop_handler_006473.loc_0064B7

  loc_00585A:
    INC $38
    INC $38
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}