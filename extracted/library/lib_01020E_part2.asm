?BANK 02

!VMAIN                          2115
!VMADDL                         2116
!MDMAEN                         420B
!DMAP2                          4320
!BBAD2                          4321
!A1T2L                          4322
!A1B2                           4324
!DAS2L                          4325

---------------------------------------------

code_01057D {
    PHP 
    REP #$20
    SEP #$10
    LDX #$81
    STX $VMAIN
    LDA [$32]
    BEQ loc_0105E0
    LDA [$32]
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$0002
    STA $A1T2L
    JSR $&code_010640
    LDA [$32]
    CLC 
    ADC #$0001
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$0042
    STA $A1T2L
    JSR $&code_010640
    LDA [$32]
    CLC 
    ADC #$0800
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$0082
    STA $A1T2L
    JSR $&code_010640
    LDA [$32]
    CLC 
    ADC #$0801
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$00C2
    STA $A1T2L
    JSR $&code_010640
    LDA #$0000
    STA [$32]

  loc_0105E0:
    LDX #$80
    STX $VMAIN
    LDA [$35]
    BEQ loc_01063E
    LDA [$35]
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$0002
    STA $A1T2L
    JSR $&code_010640
    LDA [$35]
    CLC 
    ADC #$0020
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$0042
    STA $A1T2L
    JSR $&code_010640
    LDA [$35]
    CLC 
    ADC #$0400
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$0082
    STA $A1T2L
    JSR $&code_010640
    LDA [$35]
    CLC 
    ADC #$0420
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$00C2
    STA $A1T2L
    JSR $&code_010640
    LDA #$0000
    STA [$35]

  loc_01063E:
    PLP 
    RTL 
}

code_010640 {
    LDX #$01
    STX $DMAP2
    LDX #$18
    STX $BBAD2
    LDX #$7E
    STX $A1B2
    LDA #$0040
    STA $DAS2L
    LDX #$04
    STX $MDMAEN
    RTS 
}