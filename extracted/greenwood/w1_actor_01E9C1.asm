?BANK 03

!scroll_bg2_y                   0340

---------------------------------------------

code_01E9C1 {
    LDA $0002, X
    SEC 
    SBC #$0001
    CLC 
    ADC $0384
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}