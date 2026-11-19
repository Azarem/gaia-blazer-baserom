?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_000000'

---------------------------------------------

Cop83_AnimStepRepeat {
    TYX                   ; {24253}

  loc_005EBE:
    JSL $@engine_000000.code_0008F3 ; {24254}
    BCC loc_005ECC        ; {24258}
    DEC $002A, X          ; {24260}
    BNE loc_005EBE        ; {24263}
    BRL cop_handler_006473.loc_0064BF ; {24265}

  loc_005ECC:
    BRL cop_handler_006473.loc_0064C9 ; {24268}
}