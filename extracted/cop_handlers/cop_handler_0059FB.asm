?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop16_UnblockOwnTiles {
    TYX 
    JSR $&engine_0065A7.code_0065A7
    BRL cop_handler_006473.loc_0064BF
}