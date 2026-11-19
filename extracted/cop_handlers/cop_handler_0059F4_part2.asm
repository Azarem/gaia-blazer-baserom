?BANK 00

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!tile_type_map                  7F8000

---------------------------------------------

code_006537 {
    LDA $0010, X          ; {25911}
    CLC                   ; {25914}
    ADC $0012, X          ; {25915}
    CMP #$0021            ; {25918}
    BCS loc_006563        ; {25921}
    PHX                   ; {25923}
    LDA $0000, X          ; {25924}
    STA $16               ; {25927}
    LDA $0002, X          ; {25929}
    SEC                   ; {25932}
    SBC #$0010            ; {25933}
    STA $18               ; {25936}
    JSL $@lib_027462_part1.code_0272B8 ; {25938}
    LDA $tile_type_map, X ; {25942}
    ORA #$00F0            ; {25946}
    STA $tile_type_map, X ; {25949}
    PLX                   ; {25953}
    RTS                   ; {25954}

  loc_006563:
    TXY                   ; {25955}
    LDA $0012, Y          ; {25956}
    LSR                   ; {25959}
    LSR                   ; {25960}
    LSR                   ; {25961}
    LSR                   ; {25962}
    STA $0C               ; {25963}
    LDA $0000, X          ; {25965}
    STA $16               ; {25968}
    LDA $0002, X          ; {25970}
    SEC                   ; {25973}
    SBC $0012, X          ; {25974}

  loc_006579:
    STA $18               ; {25977}
    JSL $@lib_027462_part1.code_0272B8 ; {25979}
    LDA $0010, Y          ; {25983}
    LSR                   ; {25986}
    LSR                   ; {25987}
    LSR                   ; {25988}
    LSR                   ; {25989}
    STA $0E               ; {25990}

  loc_006588:
    LDA $tile_type_map, X ; {25992}
    ORA #$00F0            ; {25996}
    STA $tile_type_map, X ; {25999}
    JSL $@lib_027462_part2.code_02731A ; {26003}
    DEC $0E               ; {26007}
    BNE loc_006588        ; {26009}
    LDA $18               ; {26011}
    CLC                   ; {26013}
    ADC #$0010            ; {26014}
    DEC $0C               ; {26017}
    BNE loc_006579        ; {26019}
    TYX                   ; {26021}
    RTS                   ; {26022}
}