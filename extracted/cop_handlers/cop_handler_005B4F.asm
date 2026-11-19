?BANK 00

?INCLUDE 'cop_handler_005BC1'

---------------------------------------------

Cop24_JumpIfTileRight {
    TYX                   ; {23375}
    LDA $0000, X          ; {23376}
    CLC                   ; {23379}
    ADC $0010, X          ; {23380}
    STA $16               ; {23383}
    LDA $0002, X          ; {23385}
    SEC                   ; {23388}
    SBC #$0010            ; {23389}
    STA $18               ; {23392}
    BRL cop_handler_005BC1.loc_005BD0 ; {23394}
}