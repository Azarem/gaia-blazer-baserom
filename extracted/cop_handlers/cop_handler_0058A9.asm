?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop0C_JumpIfActorInBox {
    TYX                   ; {22697}
    LDA [$38]             ; {22698}
    INC $38               ; {22700}
    AND #$00FF            ; {22702}
    JSR $&engine_0065A7.code_006617 ; {22705}
    LDA [$38]             ; {22708}
    INC $38               ; {22710}
    AND #$00FF            ; {22712}
    JSR $&engine_0065A7.code_006628 ; {22715}
    STA $00               ; {22718}

  loc_0058C0:
    LDA $0000, X          ; {22720}
    SEC                   ; {22723}
    SBC $00               ; {22724}
    STA $16               ; {22726}
    LDA $00               ; {22728}
    ASL                   ; {22730}
    CLC                   ; {22731}
    ADC $0010, X          ; {22732}
    SEC                   ; {22735}
    SBC #$000F            ; {22736}
    STA $18               ; {22739}
    LDA $0000, Y          ; {22741}
    SEC                   ; {22744}
    SBC $16               ; {22745}
    CMP $18               ; {22747}
    BCC loc_0058E2        ; {22749}
    BRL cop_handler_006473.loc_0064BB ; {22751}

  loc_0058E2:
    LDA $0002, X          ; {22754}
    CLC                   ; {22757}
    ADC $00               ; {22758}
    STA $16               ; {22760}
    LDA $00               ; {22762}
    ASL                   ; {22764}
    CLC                   ; {22765}
    ADC $0012, X          ; {22766}
    SEC                   ; {22769}
    SBC #$000F            ; {22770}
    STA $18               ; {22773}
    LDA $16               ; {22775}
    SEC                   ; {22777}
    SBC $0002, Y          ; {22778}
    CMP $18               ; {22781}
    BCC loc_005904        ; {22783}
    BRL cop_handler_006473.loc_0064BB ; {22785}

  loc_005904:
    LDA [$38]             ; {22788}
    INC $38               ; {22790}
    INC $38               ; {22792}
    BRL cop_handler_006473.loc_0064C1 ; {22794}
}