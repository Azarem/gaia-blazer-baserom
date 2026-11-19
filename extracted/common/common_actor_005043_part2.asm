?BANK 00

?INCLUDE 'lib_01186E'

---------------------------------------------

code_0055C6 {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    SEP #$20
    LDA $0466
    BNE loc_0055E6
    LDA #$2C
    XBA 
    LDA #$^binary_0055F5
    LDY #$&binary_0055F5+4
    JSL $@lib_01186E.code_01188A
    BRA loc_0055F2

  loc_0055E6:
    LDA #$2C
    XBA 
    LDA #$^binary_0055F5
    LDY #$&binary_0055F5
    JSL $@lib_01186E.code_01188A

  loc_0055F2:
    REP #$20
    RTL 
}
---------------------------------------------

binary_0055F5 #7F161016011700