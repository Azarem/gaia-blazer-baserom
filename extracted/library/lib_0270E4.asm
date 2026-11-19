?BANK 04

?INCLUDE 'lib_shared_02716E'

---------------------------------------------

code_0270E4 {
    PHP 
    PHX 
    PHB 
    REP #$20
    LDA $03BA
    INC 
    STA $1B90
    LDA $03A4
    STA $701FFE
    XBA 
    ASL 
    ASL 
    TAY 
    PHY 
    LDX #$0203
    LDA #$01FF
    MVN #$70, #$7F
    LDX #$1A5E
    LDA #$01F9
    MVN #$70, #$01
    PLX 
    PLB 
    JSL $@lib_shared_02716E.code_02716E
    LDA $16
    STA $7003FA, X
    LDA $18
    STA $7003FC, X
    PHB 
    TXY 
    TYA 
    CLC 
    ADC #$1000
    TAY 
    LDA #$03FD
    MVN #$70, #$70
    PLB 
    PLX 
    PLP 
    RTL 
}