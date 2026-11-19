?BANK 04

?INCLUDE 'lib_01186E'

---------------------------------------------

code_02230A {
    PHX 
    LDX #$0000
    LDA #$007F
    STA $7E7800, X
    LDA #$0010
    STA $7E7803, X
    LDA #$0000
    STA $7E7801, X
    STA $7E7804, X
    LDA #$0050
    STA $0C
    LDA #$0001

  loc_02232F:
    STA $7E7806, X
    INX 
    INX 
    INX 
    DEC $0C
    BNE loc_02232F
    LDA $0C
    STA $7E7806, X
    PLX 
    COP [91]
    PHX 
    PHB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_01186E.code_01188A
    LDA #$7E
    PHA 
    PLB 
    REP #$20
    LDA #$0050
    STA $0C
    LDA $033A
    SEC 
    SBC #$0060
    ASL 
    STA $00
    LDX #$0000

  loc_02236B:
    XBA 
    STA $7E7807, X
    XBA 
    INX 
    INX 
    INX 
    CLC 
    ADC $00
    DEC $0C
    BNE loc_02236B
    PLB 
    PLX 
    RTL 
}