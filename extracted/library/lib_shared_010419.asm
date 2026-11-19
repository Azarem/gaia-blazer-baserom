?BANK 02

---------------------------------------------

code_010419 {
    PHX 
    PHY 
    LDA #$0010
    STA $0E

  loc_010420:
    LDA $0000, Y
    AND #$00FF
    PHY 
    ASL 
    ASL 
    ASL 
    TAY 
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0000, X
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0040, X
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0002, X
    LDA ($29), Y
    AND $0A
    ORA $06
    STA $0042, X
    INX 
    INX 
    INX 
    INX 
    PLA 
    CLC 
    ADC #$0010
    TAY 
    DEC $0E
    BNE loc_010420
    PLY 
    PLX 
    RTS 
}