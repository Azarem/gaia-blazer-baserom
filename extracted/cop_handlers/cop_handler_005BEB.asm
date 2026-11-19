?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

---------------------------------------------

Cop29_JumpIfTileIdDiffers {
    TYX                   ; {23531}
    LDA $0000, X          ; {23532}
    STA $16               ; {23535}
    LDA $0002, X          ; {23537}
    SEC                   ; {23540}
    SBC #$0010            ; {23541}
    STA $18               ; {23544}
    PHX                   ; {23546}
    JSL $@lib_027462_part1.code_0272B8 ; {23547}
    SEP #$20              ; {23551}
    LDA [$38]             ; {23553}
    INC $38               ; {23555}
    BNE loc_005C09        ; {23557}
    INC $39               ; {23559}

  loc_005C09:
    CMP $7E8000, X        ; {23561}
    REP #$20              ; {23565}
    BNE loc_005C15        ; {23567}
    PLX                   ; {23569}
    BRL cop_handler_006473.loc_0064BB ; {23570}

  loc_005C15:
    PLX                   ; {23573}
    LDA [$38]             ; {23574}
    INC $38               ; {23576}
    INC $38               ; {23578}
    BRL cop_handler_006473.loc_0064C1 ; {23580}
}