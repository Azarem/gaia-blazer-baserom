?BANK 02

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_height_px                  0344
!M7A                            211B
!M7B                            211C
!MPYL                           2134
!WRDIVL                         4204
!WRDIVB                         4206
!RDDIVL                         4214
!RDDIVH                         4215

---------------------------------------------

code_0104AF {
    PHP 
    PHY 
    SEP #$20
    STA $M7A
    XBA 
    STA $M7A
    REP #$20
    TYA 
    SEP #$20
    STA $M7B
    STA $M7B
    LDY $MPYL
    STY $WRDIVL
    XBA 
    STA $WRDIVB
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    LDA $RDDIVH
    XBA 
    LDA $RDDIVL
    PLY 
    PLP 
    RTS 
}

code_0104E1 {
    PHP 
    PHY 
    REP #$20
    PHA 
    LDA $scroll_bg1_x, X
    PHA 
    LDY $034A, X
    LDA $scroll_bg1_x
    JSR $&code_0104AF
    TAY 
    CLC 
    ADC #$0100
    CMP $map_width_px, X
    BCC loc_01050A
    LDA $map_width_px, X
    CMP #$0300
    BCC loc_01050A
    SEC 
    SBC #$0100
    TAY 

  loc_01050A:
    TYA 
    CLC 
    ADC $038A
    STA $scroll_bg1_x, X
    LDA $01, S
    EOR $scroll_bg1_x, X
    AND #$0010
    BEQ loc_010521
    LDA $03, S
    TSB $0396

  loc_010521:
    LDA $scroll_bg1_x, X
    SEC 
    SBC $01, S
    STA $038E
    PLA 
    PLA 
    PLY 
    PLP 
    RTS 
}

code_01052F {
    PHP 
    PHY 
    REP #$20
    PHA 
    LDA $scroll_bg1_y, X
    PHA 
    LDY $034C, X
    LDA $scroll_bg1_y
    JSR $&code_0104AF
    TAY 
    CLC 
    ADC $03CA
    CMP $map_height_px, X
    BCC loc_010558
    LDA $map_height_px, X
    CMP #$0300
    BCC loc_010558
    SEC 
    SBC $03CA
    TAY 

  loc_010558:
    TYA 
    CLC 
    ADC $038C
    STA $scroll_bg1_y, X
    LDA $01, S
    EOR $scroll_bg1_y, X
    AND #$0010
    BEQ loc_01056F
    LDA $03, S
    TSB $0396

  loc_01056F:
    LDA $scroll_bg1_y, X
    SEC 
    SBC $01, S
    STA $0390
    PLA 
    PLA 
    PLY 
    PLP 
    RTS 
}