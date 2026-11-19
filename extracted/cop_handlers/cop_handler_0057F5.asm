?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop03_LoopStart {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $002E, X
    LDA $38
    STA $002C, X
    STA $0018, X
    BRL cop_handler_006473.loc_0064C1
}