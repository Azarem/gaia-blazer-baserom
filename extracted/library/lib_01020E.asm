?BANK 02

?INCLUDE 'lib_01020E_part2'
?INCLUDE 'lib_shared_01032F'
?INCLUDE 'lib_shared_0104AF'
?INCLUDE 'lib_shared_0131D1'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_width_pages                0343
!map_height_px                  0344
!map_height_pages               0345
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_01020E {
    REP #$20
    LDA $player_x
    SEC 
    SBC #$0070
    BPL loc_01021E
    LDA #$0000
    BRA loc_010234

  loc_01021E:
    CLC 
    ADC #$0100
    CMP $map_width_px
    BCS loc_01022D
    SEC 
    SBC #$0100
    BRA loc_010234

  loc_01022D:
    LDA $map_width_px
    SEC 
    SBC #$0100

  loc_010234:
    STA $scroll_bg1_x
    LDA $player_y
    SEC 
    SBC #$0090
    BPL loc_010245
    LDA #$0000
    BRA loc_01025B

  loc_010245:
    CLC 
    ADC $03CA
    CMP $map_height_px
    BCS loc_010254
    SEC 
    SBC $03CA
    BRA loc_01025B

  loc_010254:
    LDA $map_height_px
    SEC 
    SBC $03CA

  loc_01025B:
    STA $scroll_bg1_y
    LDA $map_width_px
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0392
    LDA $map_height_px
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0394
    LDX #$0000

  loc_010275:
    REP #$20
    LDA #$0000
    JSR $&lib_shared_0104AF.code_0104E1
    LDA $map_width_px, X
    BEQ loc_010290
    LDA $scroll_bg1_x, X

  loc_010285:
    SEC 
    SBC $map_width_px, X
    BCC loc_010290
    STA $scroll_bg1_x, X
    BRA loc_010285

  loc_010290:
    LDA #$0000
    JSR $&lib_shared_0104AF.code_01052F
    LDA $map_height_px, X
    BEQ loc_0102A9
    LDA $scroll_bg1_y, X

  loc_01029E:
    SEC 
    SBC $map_height_px, X
    BCC loc_0102A9
    STA $scroll_bg1_y, X
    BRA loc_01029E

  loc_0102A9:
    SEP #$20
    REP #$20
    LDA $scroll_bg1_x, X
    AND #$FF00
    STA $16
    LDA $scroll_bg1_y, X
    AND #$FF00
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
    STY $32
    LDY $0364, X
    STY $35
    LDA #$20

  loc_0102FE:
    PHA 
    PHX 
    LDX $32
    JSR $&lib_shared_01032F.code_01032F
    JSL $@lib_01020E_part2.code_01057D
    PLX 
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    CMP $map_width_px, X
    BCC loc_01031A
    AND #$0100

  loc_01031A:
    STA $16
    SEP #$20
    PLA 
    DEC 
    BNE loc_0102FE
    INX 
    INX 
    INX 
    INX 
    CPX #$0008
    BEQ loc_01032E
    BRL loc_010275

  loc_01032E:
    RTL 
}