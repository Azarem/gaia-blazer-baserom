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
    PHB                   ; {74832}
    REP #$20              ; {74833}
    LDX #$&data_04F000.binary_04F000 ; {74835}
    LDY #$0000            ; {74838}
    LDA #$00FF            ; {74841}
    MVN #$7F, #$^data_04F000.binary_04F000 ; {74844}
    SEP #$20              ; {74847}
    PLB                   ; {74849}
    RTS                   ; {74850}
}

code_012463 {
    LDX #$2000            ; {74851}
    STX $VMADDL           ; {74854}
    LDA #$01              ; {74857}
    STA $DMAP0            ; {74859}
    LDA #$18              ; {74862}
    STA $BBAD0            ; {74864}
    LDX #$C000            ; {74867}
    STX $A1T0L            ; {74870}
    LDA #$7F              ; {74873}
    STA $A1B0             ; {74875}
    LDX #$2000            ; {74878}
    STX $DAS0L            ; {74881}
    LDA #$01              ; {74884}
    STA $MDMAEN           ; {74886}
    PHB                   ; {74889}
    REP #$20              ; {74890}
    LDX #$&data_04F000.binary_04F300 ; {74892}
    LDY #$0160            ; {74895}
    LDA #$009F            ; {74898}
    MVN #$7F, #$^data_04F000.binary_04F300 ; {74901}
    SEP #$20              ; {74904}
    PLB                   ; {74906}
    RTL                   ; {74907}
}

code_01249C {
    PHP                   ; {74908}
    REP #$20              ; {74909}
    LDA $1B62             ; {74911}
    SEC                   ; {74914}
    SBC #$0011            ; {74915}
    CMP #$0008            ; {74918}
    BCS loc_0124EC        ; {74921}
    PHA                   ; {74923}
    ASL                   ; {74924}
    CLC                   ; {74925}
    ADC $01, S            ; {74926}
    PLX                   ; {74928}
    TAX                   ; {74929}
    SEP #$20              ; {74930}
    LDY #$2600            ; {74932}
    STY $VMADDL           ; {74935}
    LDA #$01              ; {74938}
    STA $DMAP0            ; {74940}
    LDA #$18              ; {74943}
    STA $BBAD0            ; {74945}
    LDY $&data_00F9F7.table_00FB88, X ; {74948}
    STY $A1T0L            ; {74951}
    LDA $&data_00F9F7.table_00FB88+2, X ; {74954}
    STA $A1B0             ; {74957}
    LDY #$0800            ; {74960}
    STY $DAS0L            ; {74963}
    LDA #$01              ; {74966}
    STA $MDMAEN           ; {74968}
    REP #$20              ; {74971}
    PHB                   ; {74973}
    LDA $&data_00F9F7.table_00FBA0, X ; {74974}
    TAX                   ; {74977}
    LDY #$0160            ; {74978}
    LDA #$001F            ; {74981}
    MVN #$7F, #$0F        ; {74984}
    PLB                   ; {74987}

  loc_0124EC:
    PLP                   ; {74988}
    RTL                   ; {74989}
}