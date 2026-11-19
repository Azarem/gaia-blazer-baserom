?BANK 03

!scroll_bg2_x                   033E
!scroll_bg2_y                   0340

---------------------------------------------

code_01B1F7 {
    LDA $0000, X
    CLC 
    ADC #$0001
    CLC 
    ADC $0382
    STA $0000, X
    STA $scroll_bg2_x
    LDA $0002, X
    SEC 
    SBC #$0001
    CLC 
    ADC $0384
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}