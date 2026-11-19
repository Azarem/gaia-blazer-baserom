?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop8D_JumpIfBit15Clear {
    TYX                   ; {24567}
    LDA $0016, X          ; {24568}
    BIT #$8000            ; {24571}
    BEQ loc_006003        ; {24574}
    BRL cop_handler_006473.loc_0064BF ; {24576}

  loc_006003:
    LDA [$38]             ; {24579}
    INC $38               ; {24581}
    INC $38               ; {24583}
    BRL cop_handler_006473.loc_0064C1 ; {24585}
}