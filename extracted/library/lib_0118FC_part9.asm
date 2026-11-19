?BANK 02

!WRDIVL                         4204
!WRDIVB                         4206
!RDDIVL                         4214
!RDMPYL                         4216

---------------------------------------------

code_0131E8 {
    STY $WRDIVL
    STA $WRDIVB
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    LDA $RDMPYL
    XBA 
    LDA $RDDIVL
    RTL 
}