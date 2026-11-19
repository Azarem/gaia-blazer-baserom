?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

CopAE_JumpIfTileTypeSet {
    TYX                   ; {25513}
    PHX                   ; {25514}
    LDA [$38]             ; {25515}
    INC $38               ; {25517}
    INC $38               ; {25519}
    CLC                   ; {25521}
    ADC $0000, X          ; {25522}
    STA $16               ; {25525}
    LDA [$38]             ; {25527}
    INC $38               ; {25529}
    INC $38               ; {25531}
    CLC                   ; {25533}
    ADC $0002, X          ; {25534}
    SEC                   ; {25537}
    SBC #$0010            ; {25538}
    STA $18               ; {25541}
    JSL $@lib_027462_part1.code_0272B8 ; {25543}
    LDA $tile_type_map, X ; {25547}
    PLX                   ; {25551}
    AND #$000F            ; {25552}
    BEQ loc_0063DE        ; {25555}
    LDA [$38]             ; {25557}
    INC $38               ; {25559}
    INC $38               ; {25561}
    BRL cop_handler_006473.loc_0064C1 ; {25563}

  loc_0063DE:
    BRL cop_handler_006473.loc_0064BB ; {25566}
}