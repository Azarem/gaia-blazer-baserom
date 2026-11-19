?BANK 02

!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DASB0                          4307

---------------------------------------------

code_01186E {
    PHP 
    PHX 
    SEP #$20
    PHA 
    LDA #$00
    XBA 
    PHA 
    TAX 
    LDA $@binary_0118BC, X
    LDX $46
    ORA #$40
    STA $DMAP0, X
    LDA $02, S
    STA $DASB0, X
    BRA loc_01189D
}

code_01188A {
    PHP 
    PHX 
    SEP #$20
    PHA 
    LDA #$00
    XBA 
    PHA 
    TAX 
    LDA $@binary_0118BC, X
    LDX $46
    STA $DMAP0, X

  loc_01189D:
    PLA 
    STA $BBAD0, X
    REP #$20
    TYA 
    STA $A1T0L, X
    SEP #$20
    PLA 
    STA $A1B0, X
    LDA $44
    TSB $42
    ASL $44
    LDA $46
    ADC #$10
    STA $46
    PLX 
    PLP 
    RTL 
}
---------------------------------------------

binary_0118BC #00000101020000000000000000020202020202020200010101010002020202020200020000000000000000000000000000000000808080808281818282828080