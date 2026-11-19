?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_0276A5'

---------------------------------------------

Cop25_CallLib0276A5 {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    JSL $@lib_0276A5.code_0276A5
    LDA #$0010
    TSB $0332
    BRL cop_handler_006473.loc_0064BF
}