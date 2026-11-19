?BANK 00

?INCLUDE 'cop_handler_005BC1'

---------------------------------------------

Cop22_JumpIfTileAtPos {
    TYX                   ; {23339}
    LDA $0000, X          ; {23340}
    STA $16               ; {23343}
    LDA $0002, X          ; {23345}
    STA $18               ; {23348}
    BRL cop_handler_005BC1.loc_005BD0 ; {23350}
}