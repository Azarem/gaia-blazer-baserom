?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop18_JumpIfInventoryZero {
    TYX                   ; {23055}
    LDA [$38]             ; {23056}
    INC $38               ; {23058}
    AND #$00FF            ; {23060}
    JSR $&engine_0064F8.code_00651E ; {23063}
    BCS loc_005A1F        ; {23066}
    BRL cop_handler_006473.loc_0064BB ; {23068}

  loc_005A1F:
    LDA [$38]             ; {23071}
    INC $38               ; {23073}
    INC $38               ; {23075}
    BRL cop_handler_006473.loc_0064C1 ; {23077}
}