?BANK 02

?INCLUDE 'data_04F000'

!VMADDL                         2116
!MDMAEN                         420B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305

---------------------------------------------

code_012416 {
    LDX #$2000
    STX $VMADDL
    LDA #$01
    STA $DMAP0
    LDA #$18
    STA $BBAD0
    LDX #$&graphics_04B000
    STX $A1T0L
    LDA #$^graphics_04B000
    STA $A1B0
    LDX #$2000
    STX $DAS0L
    LDA #$01
    STA $MDMAEN
    RTS 
}

code_01243D {
    PHB 
    REP #$20
    LDX #$&data_04F000.binary_04F100
    LDY #$0000
    LDA #$00FF
    MVN #$7F, #$^data_04F000.binary_04F100
    SEP #$20
    PLB 
    RTS 
}