?BANK 02

?INCLUDE 'lib_010EEA_part2'
?INCLUDE 'lib_shared_0131D1'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_pages                0343
!vram_write_queue               1C7B

---------------------------------------------

code_010EEA {
    LDA $1C75
    BNE loc_010EF0
    RTL 

  loc_010EF0:
    LDA $1C6C
    BNE loc_010EF8
    BRL loc_010FAD

  loc_010EF8:
    PHP 
    REP #$20
    LDY #$0000
    LDA $scroll_bg1_x
    AND #$FFF0
    STA $1C77
    LDA $scroll_bg1_y
    AND #$FFF0
    STA $1C79
    LDA $1C75
    DEC 
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    LDA #$0010
    STA $0C

  loc_010F1F:
    LDA $@lib_010EEA_part2.binary_016E2D, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $1C77
    STA $16
    LDA $@lib_010EEA_part2.binary_016E2D+10, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $1C79
    STA $18
    PHX 
    JSR $&code_011062
    STA $vram_write_queue, Y
    INC 
    STA $1C7F, Y
    CLC 
    ADC #$001F
    STA $1C83, Y
    INC 
    STA $1C87, Y
    LDA $7E2000, X
    AND $035C
    ORA $036A
    STA $1C7D, Y
    LDA $7E2002, X
    AND $035C
    ORA $036A
    STA $1C81, Y
    LDA $7E2004, X
    AND $035C
    ORA $036A
    STA $1C85, Y
    LDA $7E2006, X
    AND $035C
    ORA $036A
    STA $1C89, Y
    PLX 
    TYA 
    CLC 
    ADC #$0010
    TAY 
    INX 
    DEC $0C
    BNE loc_010F1F
    LDA #$0000
    STA $vram_write_queue, Y
    INC $1C75
    LDA $1C75
    CMP #$0024
    BCC loc_010FAB
    STZ $1C75

  loc_010FAB:
    PLP 
    RTL 

  loc_010FAD:
    PHP 
    REP #$20
    LDY #$0000
    LDA $scroll_bg1_x
    AND #$FFF0
    STA $1C77
    LDA $scroll_bg1_y
    AND #$FFF0
    STA $1C79
    LDA $1C75
    DEC 
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    LDA #$0010
    STA $0C

  loc_010FD4:
    LDA $@lib_010EEA_part2.binary_016E2D, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $1C77
    STA $16
    LDA $@lib_010EEA_part2.binary_016E2D+10, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $1C79
    STA $18
    PHX 
    JSR $&code_0110C6
    STA $vram_write_queue, Y
    INC 
    STA $1C7F, Y
    CLC 
    ADC #$001F
    STA $1C83, Y
    INC 
    STA $1C87, Y
    LDA $7E2800, X
    AND $0360
    ORA $036E
    STA $1C7D, Y
    LDA $7E2802, X
    AND $0360
    ORA $036E
    STA $1C81, Y
    LDA $7E2804, X
    AND $0360
    ORA $036E
    STA $1C85, Y
    LDA $7E2806, X
    AND $0360
    ORA $036E
    STA $1C89, Y
    PLX 
    TYA 
    CLC 
    ADC #$0010
    TAY 
    INX 
    DEC $0C
    BNE loc_010FD4
    LDA #$0000
    STA $vram_write_queue, Y
    INC $1C75
    LDA $1C75
    CMP #$0024
    BCC loc_011060
    STZ $1C75

  loc_011060:
    PLP 
    RTL 
}

code_011062 {
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
    LDA $7E8000, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $18
    AND #$00F8
    ASL 
    ASL 
    PHA 
    LDA $16
    AND #$00F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $16
    AND #$0100
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $18
    AND #$0100
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    PLA 
    CLC 
    ADC #$6000
    RTS 
}

code_0110C6 {
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
    LDA $7EC000, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $18
    AND #$00F8
    ASL 
    ASL 
    PHA 
    LDA $16
    AND #$00F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $16
    AND #$0100
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $18
    AND #$0100
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    PLA 
    CLC 
    ADC #$7000
    RTS 
}