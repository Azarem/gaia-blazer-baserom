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
    PHP                   ; {66735}
    PHY                   ; {66736}
    SEP #$20              ; {66737}
    STA $M7A              ; {66739}
    XBA                   ; {66742}
    STA $M7A              ; {66743}
    REP #$20              ; {66746}
    TYA                   ; {66748}
    SEP #$20              ; {66749}
    STA $M7B              ; {66751}
    STA $M7B              ; {66754}
    LDY $MPYL             ; {66757}
    STY $WRDIVL           ; {66760}
    XBA                   ; {66763}
    STA $WRDIVB           ; {66764}
    NOP                   ; {66767}
    NOP                   ; {66768}
    NOP                   ; {66769}
    NOP                   ; {66770}
    NOP                   ; {66771}
    NOP                   ; {66772}
    NOP                   ; {66773}
    NOP                   ; {66774}
    LDA $RDDIVH           ; {66775}
    XBA                   ; {66778}
    LDA $RDDIVL           ; {66779}
    PLY                   ; {66782}
    PLP                   ; {66783}
    RTS                   ; {66784}
}

code_0104E1 {
    PHP                   ; {66785}
    PHY                   ; {66786}
    REP #$20              ; {66787}
    PHA                   ; {66789}
    LDA $scroll_bg1_x, X  ; {66790}
    PHA                   ; {66793}
    LDY $034A, X          ; {66794}
    LDA $scroll_bg1_x     ; {66797}
    JSR $&code_0104AF     ; {66800}
    TAY                   ; {66803}
    CLC                   ; {66804}
    ADC #$0100            ; {66805}
    CMP $map_width_px, X  ; {66808}
    BCC loc_01050A        ; {66811}
    LDA $map_width_px, X  ; {66813}
    CMP #$0300            ; {66816}
    BCC loc_01050A        ; {66819}
    SEC                   ; {66821}
    SBC #$0100            ; {66822}
    TAY                   ; {66825}

  loc_01050A:
    TYA                   ; {66826}
    CLC                   ; {66827}
    ADC $038A             ; {66828}
    STA $scroll_bg1_x, X  ; {66831}
    LDA $01, S            ; {66834}
    EOR $scroll_bg1_x, X  ; {66836}
    AND #$0010            ; {66839}
    BEQ loc_010521        ; {66842}
    LDA $03, S            ; {66844}
    TSB $0396             ; {66846}

  loc_010521:
    LDA $scroll_bg1_x, X  ; {66849}
    SEC                   ; {66852}
    SBC $01, S            ; {66853}
    STA $038E             ; {66855}
    PLA                   ; {66858}
    PLA                   ; {66859}
    PLY                   ; {66860}
    PLP                   ; {66861}
    RTS                   ; {66862}
}

code_01052F {
    PHP                   ; {66863}
    PHY                   ; {66864}
    REP #$20              ; {66865}
    PHA                   ; {66867}
    LDA $scroll_bg1_y, X  ; {66868}
    PHA                   ; {66871}
    LDY $034C, X          ; {66872}
    LDA $scroll_bg1_y     ; {66875}
    JSR $&code_0104AF     ; {66878}
    TAY                   ; {66881}
    CLC                   ; {66882}
    ADC $03CA             ; {66883}
    CMP $map_height_px, X ; {66886}
    BCC loc_010558        ; {66889}
    LDA $map_height_px, X ; {66891}
    CMP #$0300            ; {66894}
    BCC loc_010558        ; {66897}
    SEC                   ; {66899}
    SBC $03CA             ; {66900}
    TAY                   ; {66903}

  loc_010558:
    TYA                   ; {66904}
    CLC                   ; {66905}
    ADC $038C             ; {66906}
    STA $scroll_bg1_y, X  ; {66909}
    LDA $01, S            ; {66912}
    EOR $scroll_bg1_y, X  ; {66914}
    AND #$0010            ; {66917}
    BEQ loc_01056F        ; {66920}
    LDA $03, S            ; {66922}
    TSB $0396             ; {66924}

  loc_01056F:
    LDA $scroll_bg1_y, X  ; {66927}
    SEC                   ; {66930}
    SBC $01, S            ; {66931}
    STA $0390             ; {66933}
    PLA                   ; {66936}
    PLA                   ; {66937}
    PLY                   ; {66938}
    PLP                   ; {66939}
    RTS                   ; {66940}
}