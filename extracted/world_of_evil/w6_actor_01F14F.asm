?BANK 03

?INCLUDE 'lib_01186E'

!frame_counter                  0312
!M7A                            211B
!M7B                            211C
!MPYL                           2134

---------------------------------------------

code_01F14F {
    PHX 
    LDX #$0000
    LDA #$0006
    STA $7E7800, X
    LDA #$0008
    STA $7E7803, X
    LDA #$000A
    STA $7E7806, X
    LDA #$0006
    STA $7E7809, X
    LDA #$0009
    STA $7E780C, X
    LDA #$0010
    STA $7E780F, X
    LDA #$0010
    STA $7E7812, X
    LDA #$0010
    STA $7E7815, X
    LDA #$0011
    STA $7E7818, X
    LDA #$0018
    STA $7E781B, X
    LDA #$0020
    STA $7E781E, X
    LDA #$0010
    STA $7E7821, X
    LDA #$0000
    STA $7E7824, X
    PLX 
    COP [91]
    PHX 
    LDA $frame_counter
    ASL 
    ASL 
    ASL 
    STA $00
    TAY 
    LDX #$0000

  loc_01F1BE:
    XBA 
    STA $7E7801, X
    XBA 
    PHA 
    TYA 
    SEP #$20
    STA $M7A
    XBA 
    STA $M7A
    LDA $7E7800, X
    STA $M7B
    STA $M7B
    REP #$20
    PLA 
    CLC 
    ADC $MPYL
    INX 
    INX 
    INX 
    CPX #$0024
    BNE loc_01F1BE
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_01186E.code_01188A
    REP #$20
    PLX 
    RTL 
}