?BANK 02

?INCLUDE 'data_iris_and_icon_tiles'
?INCLUDE 'data_menu_palettes_and_groups'

!vram_upload_flags              03B8

---------------------------------------------

code_012390 {
    PHP 
    PHB 
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDY #$&data_menu_palettes_and_groups.MenuTileGroupMap
    STY $00
    LDA #$*data_menu_palettes_and_groups.MenuTileGroupMap
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
    LDA $@data_iris_and_icon_tiles.IconTileRecords, X
    STA $7800, Y
    LDA $@data_iris_and_icon_tiles.IconTileRecords+2, X
    STA $7802, Y
    LDA $@data_iris_and_icon_tiles.IconTileRecords+4, X
    STA $7840, Y
    LDA $@data_iris_and_icon_tiles.IconTileRecords+6, X
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