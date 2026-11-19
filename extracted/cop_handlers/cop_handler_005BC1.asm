?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

Cop28_JumpIfTileHere {
    TYX                   ; {23489}
    LDA $0000, X          ; {23490}
    STA $16               ; {23493}
    LDA $0002, X          ; {23495}
    SEC                   ; {23498}
    SBC #$0010            ; {23499}
    STA $18               ; {23502}

  loc_005BD0:
    PHX                   ; {23504}
    JSL $@lib_027462_part1.code_0272B8 ; {23505}
    LDA $tile_type_map, X ; {23509}
    PLX                   ; {23513}
    AND #$00FF            ; {23514}
    BNE loc_005BE2        ; {23517}
    BRL cop_handler_006473.loc_0064BB ; {23519}

  loc_005BE2:
    LDA [$38]             ; {23522}
    INC $38               ; {23524}
    INC $38               ; {23526}
    BRL cop_handler_006473.loc_0064C1 ; {23528}
}