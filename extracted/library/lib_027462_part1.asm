?BANK 04

?INCLUDE 'lib_shared_0131D1'

!map_width_pages                0343

---------------------------------------------

code_0272B8 {
    LDA $18
    PHA 
    SEP #$20
    LDA $map_width_pages
    JSL $@lib_shared_0131D1.code_0131D1
    STA $02, S
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    AND #$0F
    CLC 
    ADC $01, S
    STA $01, S
    LDA $17
    CLC 
    ADC $02, S
    STA $02, S
    REP #$20
    PLX 
    CPX #$4000
    BCC loc_0272E5
    LDX #$0000

  loc_0272E5:
    RTL 
}