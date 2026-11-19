?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1C_JumpIfActorFlags {
    TYX                   ; {23198}
    LDA [$38]             ; {23199}
    INC $38               ; {23201}
    INC $38               ; {23203}
    AND $0016, X          ; {23205}
    BNE loc_005AAD        ; {23208}
    BRL cop_handler_006473.loc_0064BB ; {23210}

  loc_005AAD:
    LDA [$38]             ; {23213}
    INC $38               ; {23215}
    INC $38               ; {23217}
    BRL cop_handler_006473.loc_0064C1 ; {23219}
}