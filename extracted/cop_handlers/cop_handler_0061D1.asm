?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_000000'

---------------------------------------------

Cop9E_AnimStepUnlessBit2 {
    TYX 
    LDA $0016, X
    BIT #$0004
    BNE loc_0061E6
    JSL $@engine_000000.code_0008F3
    BCC loc_0061E3
    BRL cop_handler_006473.loc_0064BB

  loc_0061E3:
    BRL cop_handler_006473.loc_0064C9

  loc_0061E6:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}