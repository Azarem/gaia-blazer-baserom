?BANK 02

!WRDIVL                         4204
!WRDIVB                         4206
!RDDIVL                         4214
!RDMPYL                         4216

---------------------------------------------

code_0131E8 {
    STY $WRDIVL           ; {78312}
    STA $WRDIVB           ; {78315}
    NOP                   ; {78318}
    NOP                   ; {78319}
    NOP                   ; {78320}
    NOP                   ; {78321}
    NOP                   ; {78322}
    NOP                   ; {78323}
    NOP                   ; {78324}
    NOP                   ; {78325}
    LDA $RDMPYL           ; {78326}
    XBA                   ; {78329}
    LDA $RDDIVL           ; {78330}
    RTL                   ; {78333}
}