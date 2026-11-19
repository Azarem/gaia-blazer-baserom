?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1D_SetActorFlags {
    TYX                   ; {23222}
    LDA [$38]             ; {23223}
    INC $38               ; {23225}
    INC $38               ; {23227}
    ORA $0016, X          ; {23229}
    STA $0016, X          ; {23232}
    BRL cop_handler_006473.loc_0064BF ; {23235}
}