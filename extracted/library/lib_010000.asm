?BANK 02

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_010000 {
    PHP 
    REP #$30
    LDX #$0000
    TXY 
    LDA $scroll_bg1_x
    PHA 
    LDA $player_x
    SEC 
    SBC #$0070
    BPL loc_010019
    LDA #$0000
    BRA loc_01002F

  loc_010019:
    CLC 
    ADC #$0100
    CMP $map_width_px
    BCS loc_010028
    SEC 
    SBC #$0100
    BRA loc_01002F

  loc_010028:
    LDA $map_width_px
    SEC 
    SBC #$0100

  loc_01002F:
    SEC 
    SBC $01, S
    TAX 
    PLA 
    LDA $scroll_bg1_y
    PHA 
    LDA $player_y
    SEC 
    SBC #$0080
    BPL loc_010046
    LDA #$0000
    BRA loc_01005C

  loc_010046:
    CLC 
    ADC $03CA
    CMP $map_height_px
    BCS loc_010055
    SEC 
    SBC $03CA
    BRA loc_01005C

  loc_010055:
    LDA $map_height_px
    SEC 
    SBC $03CA

  loc_01005C:
    SEC 
    SBC $01, S
    TAY 
    PLA 
    STX $0382
    STY $0384
    PLP 
    RTL 
}