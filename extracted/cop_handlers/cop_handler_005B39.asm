?BANK 00

?INCLUDE 'cop_handler_005BC1'

---------------------------------------------

Cop23_JumpIfTileLeft {
    TYX                   ; {23353}
    LDA $0000, X          ; {23354}
    SEC                   ; {23357}
    SBC #$0010            ; {23358}
    STA $16               ; {23361}
    LDA $0002, X          ; {23363}
    SEC                   ; {23366}
    SBC #$0010            ; {23367}
    STA $18               ; {23370}
    BRL cop_handler_005BC1.loc_005BD0 ; {23372}
}