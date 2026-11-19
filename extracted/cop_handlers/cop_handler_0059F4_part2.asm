?BANK 00

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!tile_type_map                  7F8000

---------------------------------------------

code_006537 {
    LDA $0010, X
    CLC 
    ADC $0012, X
    CMP #$0021
    BCS loc_006563
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    ORA #$00F0
    STA $tile_type_map, X
    PLX 
    RTS 

  loc_006563:
    TXY 
    LDA $0012, Y
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC $0012, X

  loc_006579:
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $0010, Y
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0E

  loc_006588:
    LDA $tile_type_map, X
    ORA #$00F0
    STA $tile_type_map, X
    JSL $@lib_027462_part2.code_02731A
    DEC $0E
    BNE loc_006588
    LDA $18
    CLC 
    ADC #$0010
    DEC $0C
    BNE loc_006579
    TYX 
    RTS 
}