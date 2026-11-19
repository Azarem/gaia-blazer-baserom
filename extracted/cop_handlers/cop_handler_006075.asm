?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_01065B'
?INCLUDE 'lib_0106CD'

---------------------------------------------

Cop92_StartAnimation {
    TYX                   ; {24693}
    LDA [$38]             ; {24694}
    INC $38               ; {24696}
    AND #$00FF            ; {24698}
    STA $001E, X          ; {24701}
    STZ $0020, X          ; {24704}
    JSL $@lib_01065B.code_01065B ; {24707}
    JSL $@lib_0106CD.code_0106CD ; {24711}
    BRL cop_handler_006473.loc_0064C4 ; {24715}
}