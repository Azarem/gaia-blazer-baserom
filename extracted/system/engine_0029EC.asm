?BANK 00

?INCLUDE 'cop_handler_005CF0_part1'
?INCLUDE 'engine_002EC0'
?INCLUDE 'engine_005354'
?INCLUDE 'meta_tables_008000'

!rng_state                      0301
!random_mod_result              0437
!actor_list_tail                06A6
!location_id                    1C6A

---------------------------------------------

code_0029EC {
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    LDA #$0300
    STA $0016, X
    COP [A3]
    LDA $0372
    STA $001C, X
    COP [A8] ( #$8000, #0E )
    COP [80] ( #10 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_002A10 {
    CPX $039A
    BNE loc_002A18
    BRL loc_002B96

  loc_002A18:
    COP [A8] ( #$8000, #0E )
    LDA #$0300
    STA $0016, X
    STZ $001A, X
    LDA $0372
    STA $001C, X
    LDA $0010, X
    SEC 
    SBC #$0010
    LSR 
    CLC 
    ADC $0000, X
    STA $0000, X
    LDA $0012, X
    SEC 
    SBC #$0010
    LSR 
    EOR #$FFFF
    INC 
    CLC 
    ADC $0002, X
    STA $0002, X
    LDA $03BA
    CMP #$0006
    BNE loc_002A59
    LDA #$0019

  loc_002A59:
    ASL 
    PHA 
    INC 
    STA $16
    PLA 
    ASL 
    CLC 
    ADC #$0004
    STA $18
    LDA $1B5E
    CMP #$0004
    BNE loc_002A72
    ASL $16
    ASL $18

  loc_002A72:
    COP [1F]
    COP [35] ( #64 )
    LDA $random_mod_result
    CMP $18
    BCS loc_002A94
    CMP $16
    BCS loc_002A8B
    COP [B0] ( @engine_002EC0.code_002EFA, #$4000 )
    BRA loc_002A9B

  loc_002A8B:
    COP [B0] ( @engine_002EC0.code_002EEA, #$4000 )
    BRA loc_002A9B

  loc_002A94:
    COP [B0] ( @engine_002EC0.code_002EDA, #$4000 )

  loc_002A9B:
    COP [80] ( #03 )
    COP [82]
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$F000, #7E )
    COP [A0] ( #$FFF0 )
    PHX 
    LDY $0038, X
    LDA $&meta_tables_008000+3, Y
    STA $00
    TXY 
    TXA 
    SEC 
    SBC #$0800
    LSR 
    LSR 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $001E, X
    STZ $0020, X
    ASL 
    TAX 
    LDA $7EF000, X
    TAX 
    LDA $7E0006, X
    CLC 
    ADC #$000E
    SEC 
    SBC #$F000
    TAX 
    LDA $00
    CMP #$1000
    BCS loc_002B27
    CMP #$0100
    BCS loc_002B14
    CMP #$0010
    BCS loc_002B01
    LDA #$0001
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$0005
    STA $0000, Y
    BRA loc_002B47

  loc_002B01:
    LDA #$0002
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$0003
    STA $0000, Y
    BRA loc_002B42

  loc_002B14:
    LDA #$0003
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$0001
    STA $0000, Y
    BRA loc_002B3D

  loc_002B27:
    LDA #$0004
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$FFFF
    STA $0000, Y
    LDA $01
    JSR $&code_002B57

  loc_002B3D:
    LDA $01
    JSR $&code_002B5B

  loc_002B42:
    LDA $00
    JSR $&code_002B57

  loc_002B47:
    LDA $00
    JSR $&code_002B5B
    PLX 
    COP [91]
    COP [82]
    COP [1B] ( &code_002B7E, #$0010 )
}

code_002B57 {
    LSR 
    LSR 
    LSR 
    LSR 
}

code_002B5B {
    AND #$000F
    PHX 
    TAX 
    LDA $@data_002B74, X
    PLX 
    SEP #$20
    STA $7EF005, X
    REP #$20
    TXA 
    CLC 
    ADC #$0007
    TAX 
    RTS 
}
---------------------------------------------

data_002B74 #B7C8C9D8D9CECFDEDFA7
---------------------------------------------

code_002B7E {
    LDY $0032, X
    BNE code_002B86
    BRL cop_handler_005CF0_part1.loc_002D40
}
---------------------------------------------

code_002B86 {
    SEP #$20
    LDA $002E, Y
    BEQ loc_002B91
    DEC 
    STA $002E, Y

  loc_002B91:
    REP #$20
    COP [86]
    RTL 

  loc_002B96:
    LDA #$0700
    STA $0016, X
    STZ $0004, X
    STZ $0006, X
    INC $042D
    LDA $0000, X
    SEC 
    SBC $0008, X
    STA $0425
    LDA $0002, X
    SEC 
    SBC $000A, X
    STA $0427
    LDA $0008, X
    CLC 
    ADC $000C, X
    STA $0429
    LDA $000A, X
    CLC 
    ADC $000E, X
    STA $042B
    COP [03] ( #20 )
    COP [84] ( @code_002BFE )
    LDA #$0003
    STA $0014, X
    COP [04]
    CPX $039A
    BNE code_002B7E
    JSR $&code_002C63
    LDA $location_id
    CMP #$007D
    BNE loc_002BF9
    SEP #$20
    LDA #$^engine_005354.code_005354
    PHA 
    REP #$20
    LDA #$&engine_005354.code_005354-1
    PHA 
    RTL 

  loc_002BF9:
    COP [31] ( #02 )
    BRA code_002B7E
}

code_002BFE {
    COP [A8] ( #$8000, #0E )
    COP [A3]
    LDA $0372
    STA $001C, X
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [1F]
    SEP #$20
    LDA $rng_state+1
    AND #$7F

  loc_002C1D:
    SEC 
    SBC $0429
    BPL loc_002C1D
    CLC 
    ADC $0429
    REP #$20
    AND #$00FF
    CLC 
    ADC $0425
    STA $0000, X
    COP [1F]
    SEP #$20
    LDA $rng_state+1
    AND #$7F

  loc_002C3C:
    SEC 
    SBC $042B
    BPL loc_002C3C
    CLC 
    ADC $042B
    REP #$20
    PHA 
    AND #$00FF
    CLC 
    ADC $0427
    STA $0002, X
    PLA 
    AND #$0001
    BNE loc_002C5B
    BRK #$85

  loc_002C5B:
    COP [80] ( #00 )
    COP [82]
    COP [86]
    RTL 
}

code_002C63 {
    PHX 
    LDA $actor_list_tail
    BRA loc_002C6C

  loc_002C69:
    LDA $003E, X

  loc_002C6C:
    TAX 
    BEQ loc_002C7B
    LDA $0016, X
    BIT #$24D0
    BNE loc_002C69
    COP [86]
    BRA loc_002C69

  loc_002C7B:
    PLX 
    RTS 
}

code_002C7D {
    PHP 
    PHX 
    REP #$20
    LDA $actor_list_tail
    BRA loc_002C89

  loc_002C86:
    LDA $003E, X

  loc_002C89:
    TAX 
    BEQ loc_002C98
    LDA $0016, X
    BIT #$0020
    BEQ loc_002C86
    COP [86]
    BRA loc_002C86

  loc_002C98:
    PLX 
    PLP 
    RTL 
}