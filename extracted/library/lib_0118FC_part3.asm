?BANK 02

!S_bg3_tilemap_buffer           7000

---------------------------------------------

code_012350 {
    PHP 
    PHB 
    SEP #$20
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDA #$2000
    LDX #$07FE

  loc_012360:
    STA $S_bg3_tilemap_buffer, X
    DEX 
    DEX 
    BPL loc_012360
    LDA #$0001
    TSB $03B8
    PLB 
    PLP 
    RTS 
}

code_012370 {
    PHP 
    PHB 
    SEP #$20
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDA #$2000
    LDX #$03FE

  loc_012380:
    STA $S_bg3_tilemap_buffer, X
    DEX 
    DEX 
    BPL loc_012380
    LDA #$0001
    TSB $03B8
    PLB 
    PLP 
    RTS 
}