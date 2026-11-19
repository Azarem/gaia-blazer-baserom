?BANK 00

?INCLUDE 'cop_handler_005867_part2'
?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop09_SetOrClearFlag {
    TYX                   ; {22631}
    LDA [$38]             ; {22632}
    INC $38               ; {22634}
    INC $38               ; {22636}
    JSR $&cop_handler_005867_part2.code_0064CC ; {22638}
    BRL cop_handler_006473.loc_0064BF ; {22641}
}