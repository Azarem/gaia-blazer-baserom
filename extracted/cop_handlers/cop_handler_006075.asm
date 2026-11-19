?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_01065B'
?INCLUDE 'lib_0106CD'

---------------------------------------------

Cop92_StartAnimation {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    JSL $@lib_01065B.code_01065B
    JSL $@lib_0106CD.code_0106CD
    BRL cop_handler_006473.loc_0064C4
}