?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

Cop2B_UnblockTileAt {
    TYX                   ; {23632}
    PHX                   ; {23633}
    LDA [$38]             ; {23634}
    INC $38               ; {23636}
    INC $38               ; {23638}
    CLC                   ; {23640}
    ADC $0000, X          ; {23641}
    STA $16               ; {23644}
    LDA [$38]             ; {23646}
    INC $38               ; {23648}
    INC $38               ; {23650}
    CLC                   ; {23652}
    ADC $0002, X          ; {23653}
    SEC                   ; {23656}
    SBC #$0010            ; {23657}
    STA $18               ; {23660}
    JSL $@lib_027462_part1.code_0272B8 ; {23662}
    LDA $tile_type_map, X ; {23666}
    AND #$FF00            ; {23670}
    STA $tile_type_map, X ; {23673}
    PLX                   ; {23677}
    BRL cop_handler_006473.loc_0064BF ; {23678}
}