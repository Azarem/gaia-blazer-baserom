?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

Cop2A_BlockTileAt {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $16
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    ORA #$00F0
    STA $tile_type_map, X
    PLX 
    BRL cop_handler_006473.loc_0064BF
}