?BANK 02

?INCLUDE 'lib_01010B_part2'
?INCLUDE 'lib_shared_01032F'
?INCLUDE 'lib_shared_0131D1'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_width_pages                0343
!map_height_pages               0345

---------------------------------------------

code_01010B {
    LDA #$1C80
    STX $03, Y
    BEQ loc_010118
    LDX #$0000
    JSR $&code_010163

  loc_010118:
    LDA #$1C40
    STX $03, Y
    BEQ loc_010125
    LDX #$0000
    JSR $&code_0101C2

  loc_010125:
    LDX $038E
    STX $0382
    LDX $0390
    STX $0384
    LDA #$1C20
    STX $03, Y
    BEQ loc_010145
    LDX #$0004
    LDA $map_width_pages, X
    CMP #$9003
    ORA $20, S
    ADC $81, S

  loc_010145:
    LDA #$1C10
    STX $03, Y
    BEQ loc_010159
    LDX #$0004
    LDA $map_height_pages, X
    CMP #$9003
    ORA $20, S
    REP #$81

  loc_010159:
    LDX #$0000
    STX $0382
    STX $0384
    RTL 
}

code_010163 {
    REP #$20
    LDA #$0000
    LDY $0382
    BEQ loc_0101BF
    BMI loc_010172
    LDA #$0100

  loc_010172:
    CLC 
    ADC $scroll_bg1_x, X
    AND #$0FF0
    STA $16
    LDA $scroll_bg1_y, X
    AND #$0F00
    STA $18
    SEP #$20
    LDY $0354, X
    STY $00
    LDY $0352, X
    STY $02
    LDY $map_width_px, X
    STY $04
    LDA $036B, X
    STZ $06
    STA $07
    LDA $map_width_pages, X
    XBA 
    LDA $map_height_pages, X
    JSL $@lib_shared_0131D1.code_0131D1
    CLC 
    ADC $0353, X
    STZ $08
    STA $09
    LDY $035C, X
    STY $0A
    LDY $035A, X
    STY $29
    LDY $0362, X
    TYX 
    JSR $&lib_shared_01032F.code_01032F

  loc_0101BF:
    SEP #$20
    RTS 
}

code_0101C2 {
    REP #$20
    LDA $scroll_bg1_x, X
    AND #$0F00
    STA $16
    LDA #$0000
    LDY $0384
    BEQ loc_01020B
    BMI loc_0101D9
    LDA #$0100

  loc_0101D9:
    CLC 
    ADC $scroll_bg1_y, X
    AND #$0FF0
    STA $18
    SEP #$20
    LDY $0354, X
    STY $00
    LDY $0352, X
    STY $02
    LDY $map_width_px, X
    STY $04
    LDA $036B, X
    STZ $06
    STA $07
    LDY $035C, X
    STY $0A
    LDY $035A, X
    STY $29
    LDY $0364, X
    TYX 
    JSR $&lib_01010B_part2.code_0103AB

  loc_01020B:
    SEP #$20
    RTS 
}