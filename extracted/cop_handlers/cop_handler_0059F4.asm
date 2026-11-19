?BANK 00

?INCLUDE 'cop_handler_0059F4_part2'
?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop15_BlockOwnTiles {
    TYX                   ; {23028}
    JSR $&cop_handler_0059F4_part2.code_006537 ; {23029}
    BRL cop_handler_006473.loc_0064BF ; {23032}
}