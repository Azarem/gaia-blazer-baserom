?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop04_LoopNext {
    TYX                   ; {22539}
    DEC $002E, X          ; {22540}
    BNE loc_005814        ; {22543}
    BRL cop_handler_006473.loc_0064BF ; {22545}

  loc_005814:
    LDA $002C, X          ; {22548}
    STA $0018, X          ; {22551}
    BRL cop_handler_006473.loc_0064C9 ; {22554}
}