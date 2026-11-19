?BANK 02

?INCLUDE 'data_048000'
?INCLUDE 'data_04F000'

!vram_upload_flags              03B8

---------------------------------------------

code_012390 {
    PHP 
    PHB 
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDY #$&data_04F000.binary_04F200
    STY $00
    LDA #$*data_04F000.binary_04F200
    STA $02
    LDY #$0000

  loc_0123A5:
    LDA [$00]
    INC $00
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $@data_048000.unk17_048800, X
    STA $7800, Y
    LDA $@data_048000.unk17_048800+2, X
    STA $7802, Y
    LDA $@data_048000.unk17_048800+4, X
    STA $7840, Y
    LDA $@data_048000.unk17_048800+6, X
    STA $7842, Y
    INY 
    INY 
    INY 
    INY 
    TYA 
    AND #$003F
    BNE loc_0123A5
    TYA 
    CLC 
    ADC #$0040
    TAY 
    CPY #$0800
    BNE loc_0123A5
    PLB 
    LDA #$0002
    TSB $vram_upload_flags
    PLP 
    RTS 
}