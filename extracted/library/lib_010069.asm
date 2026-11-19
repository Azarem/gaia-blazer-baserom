?BANK 02

?INCLUDE 'lib_shared_0104AF'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_height_px                  0344

---------------------------------------------

code_010069 {
    PHP 
    REP #$20
    LDA $0382
    BEQ loc_0100AE
    BPL loc_010084
    LDA $scroll_bg1_x
    BEQ loc_0100AE
    PHA 
    CLC 
    ADC $0382
    BPL loc_01009C
    LDA #$0000
    BRA loc_01009C

  loc_010084:
    LDA $scroll_bg1_x
    PHA 
    CLC 
    ADC $0382
    CLC 
    ADC #$0100
    CMP $map_width_px
    BCC loc_010098
    LDA $map_width_px

  loc_010098:
    SEC 
    SBC #$0100

  loc_01009C:
    STA $scroll_bg1_x
    PLA 
    EOR $scroll_bg1_x
    AND #$0010
    BEQ loc_0100AE
    LDA #$0080
    TSB $0396

  loc_0100AE:
    LDA $0384
    BEQ loc_0100F0
    BPL loc_0100C6
    LDA $scroll_bg1_y
    BEQ loc_0100F0
    PHA 
    CLC 
    ADC $0384
    BPL loc_0100DE
    LDA #$0000
    BRA loc_0100DE

  loc_0100C6:
    LDA $scroll_bg1_y
    PHA 
    CLC 
    ADC $0384
    CLC 
    ADC $03CA
    CMP $map_height_px
    BCC loc_0100DA
    LDA $map_height_px

  loc_0100DA:
    SEC 
    SBC $03CA

  loc_0100DE:
    STA $scroll_bg1_y
    PLA 
    EOR $scroll_bg1_y
    AND #$0010
    BEQ loc_0100F0
    LDA #$0040
    TSB $0396

  loc_0100F0:
    LDX #$0004
    LDA $034E
    BEQ loc_0100FE
    LDA #$0020
    JSR $&lib_shared_0104AF.code_0104E1

  loc_0100FE:
    LDA $0350
    BEQ loc_010109
    LDA #$0010
    JSR $&lib_shared_0104AF.code_01052F

  loc_010109:
    PLP 
    RTL 
}