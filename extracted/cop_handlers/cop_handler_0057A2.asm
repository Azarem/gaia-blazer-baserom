?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_shared_012769'

---------------------------------------------

Cop01_ShowText {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    TAY 
    SEP #$20
    PHX 
    PHB 
    LDA $3A
    PHA 
    PLB 
    JSL $@lib_shared_012769.code_012C27
    PLB 
    PLX 
    REP #$20
    BRL cop_handler_006473.loc_0064BF
}