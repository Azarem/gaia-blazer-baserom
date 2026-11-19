?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_000000'

---------------------------------------------

Cop82_AnimStepYield {
    TYX 
    JSL $@engine_000000.code_0008F3
    BCC loc_005EBA
    BRL cop_handler_006473.loc_0064BF

  loc_005EBA:
    BRL cop_handler_006473.loc_0064C9
}