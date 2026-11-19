?BANK 00

?INCLUDE 'cop_handler_005867_part2'
?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop09_SetOrClearFlag {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    JSR $&cop_handler_005867_part2.code_0064CC
    BRL cop_handler_006473.loc_0064BF
}