?BANK 02

?INCLUDE 'lib_017504'
?INCLUDE 'lib_0272E6'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!vram_write_queue               1C7B
!tile_type_map                  7F8000

---------------------------------------------

code_0108BB {
    PHX 
    ASL 
    ASL 
    ASL 
    TAX 
    TXY 
    LDA $@lib_017504.unk14_017504+4, X
    STA $16
    LDA $@lib_017504.unk14_017504+6, X
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    PHX 
    TYX 
    LDA $@lib_017504.unk14_017504, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $00
    LDA $@lib_017504.unk14_017504+1, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    LDA $@lib_017504.unk14_017504+2, X
    AND #$00FF
    STA $02
    LDA $@lib_017504.unk14_017504+3, X
    AND #$00FF
    STA $0E
    LDY #$0000
    PLX 

  loc_010903:
    PHX 
    LDA $02
    STA $0C
    LDA $00
    STA $16

  loc_01090C:
    PHX 
    SEP #$20
    LDA $7E8000, X
    PHA 
    LDA $tile_type_map, X
    PHA 
    REP #$20
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    PLA 
    STA $tile_type_map, X
    PLA 
    STA $7E8000, X
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_x
    CMP #$0111
    BCS loc_0109A6
    LDA $18
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_y
    CMP #$0111
    BCS loc_0109A6
    LDA $7E8000, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $7E2000, X
    AND $035C
    ORA $036A
    STA $1C7D, Y
    LDA $7E2002, X
    AND $035C
    ORA $036A
    STA $1C81, Y
    LDA $7E2004, X
    AND $035C
    ORA $036A
    STA $1C85, Y
    LDA $7E2006, X
    AND $035C
    ORA $036A
    STA $1C89, Y
    JSL $@lib_0272E6.code_0272E6
    STA $vram_write_queue, Y
    INC 
    STA $1C7F, Y
    CLC 
    ADC #$001F
    STA $1C83, Y
    INC 
    STA $1C87, Y
    TYA 
    CLC 
    ADC #$0010
    TAY 

  loc_0109A6:
    PLX 
    JSL $@lib_027462_part2.code_02731A
    LDA $16
    CLC 
    ADC #$0010
    STA $16
    DEC $0C
    BEQ loc_0109BA
    BRL loc_01090C

  loc_0109BA:
    PLX 
    JSL $@lib_027462_part2.code_027331
    LDA $18
    CLC 
    ADC #$0010
    STA $18
    DEC $0E
    BEQ loc_0109CE
    BRL loc_010903

  loc_0109CE:
    LDA #$0000
    STA $vram_write_queue, Y
    PLX 
    RTL 
}