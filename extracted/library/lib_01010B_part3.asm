?BANK 02

---------------------------------------------

code_010466 {
    PHX 
    PHY 
    LDA #$0010
    STA $0E

  loc_01046D:
    LDA $0000, Y
    AND #$00FF
    INY 
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
    STA $0002, X
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0040, X
    LDA ($29), Y
    AND $0A
    ORA $06
    STA $0042, X
    INX 
    INX 
    INX 
    INX 
    PLY 
    DEC $0E
    BNE loc_01046D
    PLY 
    PLX 
    RTS 
}