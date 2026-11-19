?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop0C_JumpIfActorInBox {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006617
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006628
    STA $00

  loc_0058C0:
    LDA $0000, X
    SEC 
    SBC $00
    STA $16
    LDA $00
    ASL 
    CLC 
    ADC $0010, X
    SEC 
    SBC #$000F
    STA $18
    LDA $0000, Y
    SEC 
    SBC $16
    CMP $18
    BCC loc_0058E2
    BRL cop_handler_006473.loc_0064BB

  loc_0058E2:
    LDA $0002, X
    CLC 
    ADC $00
    STA $16
    LDA $00
    ASL 
    CLC 
    ADC $0012, X
    SEC 
    SBC #$000F
    STA $18
    LDA $16
    SEC 
    SBC $0002, Y
    CMP $18
    BCC loc_005904
    BRL cop_handler_006473.loc_0064BB

  loc_005904:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}