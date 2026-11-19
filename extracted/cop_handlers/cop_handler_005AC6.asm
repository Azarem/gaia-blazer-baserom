?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1E_MaskActorFlags {
    TYX                   ; {23238}
    LDA [$38]             ; {23239}
    INC $38               ; {23241}
    INC $38               ; {23243}
    AND $0016, X          ; {23245}
    STA $0016, X          ; {23248}
    BRL cop_handler_006473.loc_0064BF ; {23251}
}