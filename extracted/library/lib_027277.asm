?BANK 04

?INCLUDE 'data_00F9F7'

!M7A                            211B
!M7B                            211C
!MPYM                           2135

---------------------------------------------

code_027277 {
    PHP 
    PHX 
    SEP #$20
    LDA $03CD
    BEQ loc_0272B5
    STZ $03CD
    LDX #$0000
    TXY 
    LDA $03CC
    STA $M7A
    STZ $M7A

  loc_027290:
    LDA $&data_00F9F7.binary_00FC84, Y
    STA $M7B
    STA $M7B
    REP #$20
    LDA $MPYM
    STA $7E7900, X
    STA $7E7B00, X
    TYA 
    SEP #$20
    CLC 
    ADC $03CE
    TAY 
    INX 
    INX 
    CPX #$0200
    BNE loc_027290

  loc_0272B5:
    PLX 
    PLP 
    RTL 
}