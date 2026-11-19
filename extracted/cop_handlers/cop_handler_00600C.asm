?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop8E_JumpIfBit15Set {
    TYX                   ; {24588}
    LDA $0016, X          ; {24589}
    BIT #$8000            ; {24592}
    BNE loc_006018        ; {24595}
    BRL cop_handler_006473.loc_0064BF ; {24597}

  loc_006018:
    LDA [$38]             ; {24600}
    INC $38               ; {24602}
    INC $38               ; {24604}
    BRL cop_handler_006473.loc_0064C1 ; {24606}
}