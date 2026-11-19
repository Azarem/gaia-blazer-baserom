?BANK 02

---------------------------------------------

code_0106CD {
    PHB 
    PHX 
    LDA $0023, X
    AND #$00
    SBC $007F09, X
    STA $1C5E
    LDA $000C, X
    PHA 
    LDY $000A, X
    LDA $0008, X
    TAX 
    PLA 
    JSR $1C5C
    TXA 
    PLX 
    STA $0008, X
    PLB 
    RTL 
}