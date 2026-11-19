?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop81_SetAnimationCount {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    LDA [$38]
    INC $38
    AND #$00FF
    STA $002A, X
    LDA $38
    STA $0018, X
    BRL cop_handler_006473.loc_0064BF
}