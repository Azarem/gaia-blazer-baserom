?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop16_UnblockOwnTiles {
    TYX                   ; {23035}
    JSR $&engine_0065A7.code_0065A7 ; {23036}
    BRL cop_handler_006473.loc_0064BF ; {23039}
}