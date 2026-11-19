?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_000000'

---------------------------------------------

Cop82_AnimStepYield {
    TYX                   ; {24240}
    JSL $@engine_000000.code_0008F3 ; {24241}
    BCC loc_005EBA        ; {24245}
    BRL cop_handler_006473.loc_0064BF ; {24247}

  loc_005EBA:
    BRL cop_handler_006473.loc_0064C9 ; {24250}
}