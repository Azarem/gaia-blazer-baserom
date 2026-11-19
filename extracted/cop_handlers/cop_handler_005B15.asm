?BANK 00

?INCLUDE 'cop_handler_005BC1'

---------------------------------------------

Cop21_JumpIfTileAbove {
    TYX                   ; {23317}
    LDA $0000, X          ; {23318}
    STA $16               ; {23321}
    LDA $0002, X          ; {23323}
    SEC                   ; {23326}
    SBC #$0010            ; {23327}
    SEC                   ; {23330}
    SBC $0012, X          ; {23331}
    STA $18               ; {23334}
    BRL cop_handler_005BC1.loc_005BD0 ; {23336}
}