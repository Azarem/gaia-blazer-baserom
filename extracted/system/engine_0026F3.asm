?BANK 00

?INCLUDE 'data_00BA0D'
?INCLUDE 'data_00EE8E'
?INCLUDE 'engine_000000'
?INCLUDE 'engine_0065A7'
?INCLUDE 'lib_0109D6_part1'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'meta_tables_008000'

!scene_active                   032E
!vram_write_queue               1C7B

---------------------------------------------

code_0026F3 {
    JSR $&code_002842

  loc_0026F6:
    COP [91]

  code_0026F8:
    LDA $0016, X
    BIT #$8000
    BEQ loc_002701
    RTL 

  loc_002701:
    LDA ($4A)
    BNE loc_002709
    COP [27] ( &code_0026F8 )

  loc_002709:
    BRK #$53
    JSR $&code_0028ED
    JSR $&code_002913
    COP [91]
    JSR $&code_0028C6
    BCC loc_0026F6
    JMP $&code_002871
}
---------------------------------------------

code_00271B {
    JSR $&code_002842
    LDA $002E, X
    AND #$00FF
    STA $002C, X

  loc_002727:
    COP [91]

  code_002729:
    LDA $0016, X
    BIT #$8000
    BEQ loc_002732
    RTL 

  loc_002732:
    LDA ($4A)
    BNE loc_00273A
    COP [27] ( &code_002729 )

  loc_00273A:
    BRK #$53
    JSR $&code_0028ED
    JSR $&code_002913
    DEC $002C, X
    BNE loc_002727
    COP [91]
    JSR $&code_0028C6
    BCS loc_00274F
    RTL 

  loc_00274F:
    JMP $&code_002871
}
---------------------------------------------

code_002752 {
    JSR $&code_002842
    LDA $002E, X
    AND #$00FF
    STA $0C
    LDA $0026, X
    ASL 
    TAY 
    LDA $&data_00EE8E, Y
    STA $00

  loc_002767:
    JSR $&code_0028ED
    LDA #$&code_00295E
    STA $0018, Y
    LDA ($00)
    INC $00
    INC $00
    STA $0000, Y
    LDA ($00)
    INC $00
    INC $00
    STA $0002, Y
    LDA $001C, Y
    AND #$3FFF
    ORA ($00)
    INC $00
    INC $00
    STA $001C, Y
    DEC $0C
    BNE loc_002767
    COP [91]
    JSR $&code_0028C6
    BCS loc_00279D
    RTL 

  loc_00279D:
    JMP $&code_002871
}

code_0027A0 {
    JSR $&code_002842

  loc_0027A3:
    COP [91]

  code_0027A5:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0027AE
    RTL 

  loc_0027AE:
    LDA ($4A)
    BNE loc_0027B6
    COP [27] ( &code_0027A5 )

  loc_0027B6:
    BRK #$53
    JSR $&code_0028ED
    LDA $001C, X
    CLC 
    ADC #$4000
    STA $001C, X
    JSR $&code_002913
    COP [91]
    JSR $&code_0028C6
    BCC loc_0027A3
    JMP $&code_002871
}
---------------------------------------------

code_0027D2 {
    JSR $&code_002842
    LDA $002E, X
    AND #$00FF
    STA $002C, X

  loc_0027DE:
    COP [91]

  code_0027E0:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0027E9
    RTL 

  loc_0027E9:
    LDA ($4A)
    BNE loc_0027F1
    COP [27] ( &code_0027E0 )

  loc_0027F1:
    BRK #$53
    JSR $&code_0028ED
    LDA $001C, X
    CLC 
    ADC #$4000
    STA $001C, X
    JSR $&code_002913
    DEC $002C, X
    BNE loc_0027DE
    COP [91]
    JSR $&code_0028C6
    BCS loc_002810
    RTL 

  loc_002810:
    JMP $&code_002871
}
---------------------------------------------

code_002813 {
    JSR $&code_002842

  loc_002816:
    COP [91]

  code_002818:
    LDA $0016, X
    BIT #$8000
    BEQ loc_002821
    RTL 

  loc_002821:
    COP [0C] ( #00, #02, &code_002828 )
    RTL 
}

code_002828 {
    LDA ($4A)
    BNE loc_002830
    COP [27] ( &code_002818 )

  loc_002830:
    BRK #$53
    JSR $&code_0028ED
    JSR $&code_002913
    COP [91]
    JSR $&code_0028C6
    BCC loc_002816
    JMP $&code_002871
}

code_002842 {
    TXY 
    LDA $002C, X
    BNE loc_00285E
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    TXA 
    STA $002C, Y

  loc_00285E:
    LDX $002C, Y
    LDA $7E8000, X
    TYX 
    AND #$00FF
    CMP #$00FD
    BEQ loc_002870
    PLA 
    RTL 

  loc_002870:
    RTS 
}

code_002871 {
    COP [91]
    LDA $vram_write_queue
    BEQ loc_002879
    RTL 

  loc_002879:
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    LDA $0034, X
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    SEP #$20
    LDA $&data_00BA0D+8, X
    BEQ loc_0028A0
    LDA #$FE
    JSL $@lib_0109D6_part1.code_0107AC
    BRA loc_0028A6

  loc_0028A0:
    LDA #$FE
    JSL $@lib_0109D6_part1.code_0106F1

  loc_0028A6:
    PLX 
    REP #$20
    COP [A8] ( #$8000, #0E )
    LDA #$0310
    STA $0016, X
    STZ $001C, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$83
    COP [80] ( #01 )
    COP [82]
    COP [86]
    RTL 
}

code_0028C6 {
    SEP #$20
    LDA $002E, X
    CMP $002F, X
    REP #$20
    BNE loc_0028D4
    PLA 
    RTL 

  loc_0028D4:
    TXY 
    LDA $0034, X
    TAX 
    SEP #$20
    LDA $002E, Y
    STA $002F, Y
    CLC 
    BNE loc_0028E9
    SEC 
    STA $7F0203, X

  loc_0028E9:
    REP #$20
    TYX 
    RTS 
}

code_0028ED {
    PHX 
    JSR $&engine_0065A7.code_006662
    LDA $0038, X
    TAX 
    LDA $&meta_tables_008000+6, X
    ORA #$8000
    STA $0016, Y
    LDA #$&code_002928
    STA $0018, Y
    SEP #$20
    LDA #$^code_002928
    STA $0036, Y
    REP #$20
    PLX 
    TXA 
    STA $0032, Y
    RTS 
}

code_002913 {
    LDA $0026, X
    BEQ loc_002927
    ASL 
    CLC 
    ADC $0026, X
    DEC 
    STA $0014, X
    PLA 
    INC 
    STA $0018, X
    RTL 

  loc_002927:
    RTS 
}
---------------------------------------------

code_002928 {
    COP [A8] ( #$8000, #0E )
    LDA #$0300
    STA $0016, X
    LDA $001C, X
    STA $0030, X
    LDA $0372
    STA $001C, X
    COP [80] ( #00 )
    COP [82]
    LDA $0030, X
    STA $001C, X
    LDA #$003C
    STA $0026, X
    LDY $0038, X
    LDA $&meta_tables_008000+6, Y
    ORA #$8800
    STA $0016, X
    BRA loc_00296A
}
---------------------------------------------

code_00295E {
    LDY $0038, X
    LDA $&meta_tables_008000+6, Y
    ORA #$8000
    STA $0016, X

  loc_00296A:
    SEP #$20
    LDA $&meta_tables_008000+A, Y
    STA $0024, X
    LDA $&meta_tables_008000+D, Y
    STA $0036, X
    PHA 
    REP #$20
    LDA $&meta_tables_008000+5, Y
    STA $001E, X
    STZ $0020, X
    LDA $&meta_tables_008000+8, Y
    STA $0022, X
    LDA $&meta_tables_008000+B, Y
    STA $0018, X
    DEC 
    PHA 
    JSL $@engine_000000.code_0008F3
    STZ $0004, X
    STZ $0006, X
    RTL 
}

code_00299D {
    LDA $scene_active
    BEQ loc_0029E5
    COP [A8] ( #$8000, #0E )
    LDA $0016, X
    AND #$DFFF
    ORA #$0010
    STA $0016, X
    LDA $0372
    STA $001C, X
    COP [A3]
    COP [A2] ( #30 )
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
    COP [80] ( #02 )
    COP [82]

  loc_0029E5:
    COP [86]
    RTL 
}