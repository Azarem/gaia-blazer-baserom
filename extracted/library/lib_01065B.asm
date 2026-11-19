?BANK 02

?INCLUDE 'meta_tables_008000'

---------------------------------------------

code_01065B {
    PHP 
    PHB 
    SEP #$20
    LDA $0024, X
    PHA 
    PLB 
    REP #$20
    LDA $001E, X
    ASL 
    TAY 
    LDA $&meta_tables_008000, Y
    PHA 
    LDA $0020, X
    ASL 
    CLC 
    ADC $0020, X
    ASL 
    CLC 
    ADC $01, S
    PLY 
    TAY 
    LDA $0000, Y
    AND #$00FF
    BEQ loc_0106C6
    DEC 
    STA $0026, X
    LDA $0001, Y
    STA $0008, X
    LDA $0003, Y
    AND #$00FF
    ASL 
    CLC 
    ADC #$0000
    STA $000A, X
    LDA $0004, Y
    AND #$00FF
    STA $000C, X
    PHA 
    LDA $0005, Y
    AND #$00FF
    STA $0014, X
    STA $000E, X
    INC $0020, X
    PLA 
    CMP #$0002
    BNE loc_0106C2
    INC $000B, X
    INC $000B, X

  loc_0106C2:
    PLB 
    PLP 
    CLC 
    RTL 

  loc_0106C6:
    STZ $0020, X
    PLB 
    PLP 
    SEC 
    RTL 
}