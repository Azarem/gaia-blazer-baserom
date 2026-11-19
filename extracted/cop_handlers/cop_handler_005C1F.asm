?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

Cop2A_BlockTileAt {
    TYX                   ; {23583}
    PHX                   ; {23584}
    LDA [$38]             ; {23585}
    INC $38               ; {23587}
    INC $38               ; {23589}
    CLC                   ; {23591}
    ADC $0000, X          ; {23592}
    STA $16               ; {23595}
    LDA [$38]             ; {23597}
    INC $38               ; {23599}
    INC $38               ; {23601}
    CLC                   ; {23603}
    ADC $0002, X          ; {23604}
    SEC                   ; {23607}
    SBC #$0010            ; {23608}
    STA $18               ; {23611}
    JSL $@lib_027462_part1.code_0272B8 ; {23613}
    LDA $tile_type_map, X ; {23617}
    ORA #$00F0            ; {23621}
    STA $tile_type_map, X ; {23624}
    PLX                   ; {23628}
    BRL cop_handler_006473.loc_0064BF ; {23629}
}