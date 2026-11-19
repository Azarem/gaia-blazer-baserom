?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop19_JumpUnlessInventoryBit7 {
    TYX                   ; {23080}
    LDA [$38]             ; {23081}
    INC $38               ; {23083}
    AND #$00FF            ; {23085}
    JSR $&engine_0064F8.code_00651E ; {23088}
    BCS loc_005A3A        ; {23091}
    BPL loc_005A3A        ; {23093}
    BRL cop_handler_006473.loc_0064BB ; {23095}

  loc_005A3A:
    LDA [$38]             ; {23098}
    INC $38               ; {23100}
    INC $38               ; {23102}
    BRL cop_handler_006473.loc_0064C1 ; {23104}
}