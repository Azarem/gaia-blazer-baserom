?BANK 00

?INCLUDE 'lib_0276A5'

---------------------------------------------

code_002EC0 {
    COP [A8] ( #$8000, #0E )
    LDA #$4000
    STA $0016, X
    COP [A4]
    LDA $0372
    STA $001C, X

  loc_002ED3:
    COP [80] ( #07 )
    COP [82]
    BRA loc_002ED3
}

code_002EDA {
    COP [A4]
    COP [80] ( #04 )
    COP [82]
    COP [81] ( #09, #04 )
    COP [83]
    COP [86]
    RTL 
}

code_002EEA {
    COP [A4]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #0A, #04 )
    COP [83]
    COP [86]
    RTL 
}

code_002EFA {
    COP [A4]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0B, #04 )
    COP [83]
    COP [86]
    RTL 
}

code_002F0A {
    PHP 
    PHY 
    REP #$20
    BRK #$4D
    LDA $001E, X
    CMP #$0006
    BEQ loc_002F31
    CMP #$0005
    BEQ loc_002F36
    CMP #$0004
    BEQ loc_002F3B
    CMP #$000B
    BEQ loc_002F31
    CMP #$000A
    BEQ loc_002F36
    CMP #$0009
    BEQ loc_002F3B

  loc_002F31:
    LDA #$0010
    BRA loc_002F3E

  loc_002F36:
    LDA #$0005
    BRA loc_002F3E

  loc_002F3B:
    LDA #$0001

  loc_002F3E:
    JSL $@lib_0276A5.code_0276A5
    LDA #$0010
    TSB $0332
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [86]
    PLY 
    PLP 
    RTL 
}