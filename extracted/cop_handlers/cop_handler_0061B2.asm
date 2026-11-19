?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop9D_SetAnimationUnlock {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    LDA $38
    STA $0018, X
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    BRL cop_handler_006473.loc_0064BF
}