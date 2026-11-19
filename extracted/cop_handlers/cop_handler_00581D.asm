?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop05_WaitFlag {
    TYX 
    LDA [$38]
    BMI loc_005829
    JSR $&engine_0064F8.code_0064F8
    BCC loc_00582E
    BRA loc_005835

  loc_005829:
    JSR $&engine_0064F8.code_0064F8
    BCC loc_005835

  loc_00582E:
    DEC $38
    DEC $38
    BRL cop_handler_006473.loc_0064C4

  loc_005835:
    BRL cop_handler_006473.loc_0064BB
}