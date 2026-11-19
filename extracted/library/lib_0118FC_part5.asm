?BANK 02

?INCLUDE 'data_00F9F7'
?INCLUDE 'data_04F000'

!VMADDL                         2116
!MDMAEN                         420B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305

---------------------------------------------

code_012450 {
    PHB 
    REP #$20
    LDX #$&data_04F000.binary_04F000
    LDY #$0000
    LDA #$00FF
    MVN #$7F, #$^data_04F000.binary_04F000
    SEP #$20
    PLB 
    RTS 
}

code_012463 {
    LDX #$2000
    STX $VMADDL
    LDA #$01
    STA $DMAP0
    LDA #$18
    STA $BBAD0
    LDX #$C000
    STX $A1T0L
    LDA #$7F
    STA $A1B0
    LDX #$2000
    STX $DAS0L
    LDA #$01
    STA $MDMAEN
    PHB 
    REP #$20
    LDX #$&data_04F000.binary_04F300
    LDY #$0160
    LDA #$009F
    MVN #$7F, #$^data_04F000.binary_04F300
    SEP #$20
    PLB 
    RTL 
}

code_01249C {
    PHP 
    REP #$20
    LDA $1B62
    SEC 
    SBC #$0011
    CMP #$0008
    BCS loc_0124EC
    PHA 
    ASL 
    CLC 
    ADC $01, S
    PLX 
    TAX 
    SEP #$20
    LDY #$2600
    STY $VMADDL
    LDA #$01
    STA $DMAP0
    LDA #$18
    STA $BBAD0
    LDY $&data_00F9F7.table_00FB88, X
    STY $A1T0L
    LDA $&data_00F9F7.table_00FB88+2, X
    STA $A1B0
    LDY #$0800
    STY $DAS0L
    LDA #$01
    STA $MDMAEN
    REP #$20
    PHB 
    LDA $&data_00F9F7.table_00FBA0, X
    TAX 
    LDY #$0160
    LDA #$001F
    MVN #$7F, #$0F
    PLB 

  loc_0124EC:
    PLP 
    RTL 
}