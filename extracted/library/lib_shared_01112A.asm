?BANK 02

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'
?INCLUDE 'lib_shared_0131D1'

!map_width_pages                0343
!map_height_pages               0345
!tile_type_map                  7F8000

---------------------------------------------

code_01112A {
    PHP 
    REP #$20
    LDA $1C71
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $1C72
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    STX $1C66
    STX $1C68
    SEP #$20
    SEP #$20
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_shared_0131D1.code_0131D1
    XBA 
    LDA $1C6E
    JSL $@lib_shared_0131D1.code_0131D1
    STA $1C65
    XBA 
    STA $1C64
    LDA $1C74
    CMP #$80

  loc_011172:
    BCS loc_011172
    STA $10

  loc_011176:
    LDA $1C73
    CMP #$80

  loc_01117B:
    BCS loc_01117B
    STA $0E

  loc_01117F:
    REP #$20
    LDA $1C66
    CLC 
    ADC $1C64
    TAX 
    SEP #$20
    LDA $7E8000, X
    PHA 
    LDA $tile_type_map, X
    PHA 
    LDX $1C66
    LDA $tile_type_map, X
    AND #$F0
    ORA $01, S
    STA $tile_type_map, X
    PLA 
    PLA 
    STA $7E8000, X
    LDX $1C66
    JSL $@lib_027462_part2.code_02731A
    STX $1C66
    DEC $0E
    BNE loc_01117F
    LDX $1C68
    JSL $@lib_027462_part2.code_027331
    STX $1C68
    STX $1C66
    DEC $10
    BNE loc_011176
    PLP 
    RTS 
}

code_0111CB {
    PHP 
    REP #$20
    JSL $@lib_027462_part1.code_0272B8
    STX $1C62
    STX $1C64
    LDA $1C71
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $1C72
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    STX $1C66
    STX $1C68
    SEP #$20
    LDA $1C74
    CMP #$80

  loc_011201:
    BCS loc_011201
    STA $10

  loc_011205:
    LDA $1C73
    CMP #$80

  loc_01120A:
    BCS loc_01120A
    STA $0E

  loc_01120E:
    LDX $1C62
    LDA $7E8000, X
    PHA 
    LDA $tile_type_map, X
    LDX $1C66
    STA $tile_type_map, X
    PLA 
    STA $7E8000, X
    LDX $1C62
    JSL $@lib_027462_part2.code_02731A
    STX $1C62
    LDX $1C66
    JSL $@lib_027462_part2.code_02731A
    STX $1C66
    DEC $0E
    BNE loc_01120E
    LDX $1C64
    JSL $@lib_027462_part2.code_027331
    STX $1C64
    STX $1C62
    LDX $1C68
    JSL $@lib_027462_part2.code_027331
    STX $1C68
    STX $1C66
    DEC $10
    BNE loc_011205
    PLP 
    RTS 
}

code_01125E {
    PHP 
    REP #$20
    JSL $@lib_027462_part1.code_0272B8
    STX $1C62
    STX $1C64
    LDA $1C71
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $1C72
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    STX $1C66
    STX $1C68
    SEP #$20
    LDA $1C74
    CMP #$80

  loc_011294:
    BCS loc_011294
    STA $10

  loc_011298:
    LDA $1C73
    CMP #$80

  loc_01129D:
    BCS loc_01129D
    STA $0E

  loc_0112A1:
    LDX $1C62
    LDA $7E8000, X
    PHA 
    LDA $tile_type_map, X
    LDX $1C66
    STA $tile_type_map, X
    PLA 
    STA $7E8000, X
    STA $7EC000, X
    LDX $1C62
    JSL $@lib_027462_part2.code_02731A
    STX $1C62
    LDX $1C66
    JSL $@lib_027462_part2.code_02731A
    STX $1C66
    DEC $0E
    BNE loc_0112A1
    LDX $1C64
    JSL $@lib_027462_part2.code_027331
    STX $1C64
    STX $1C62
    LDX $1C68
    JSL $@lib_027462_part2.code_027331
    STX $1C68
    STX $1C66
    DEC $10
    BNE loc_011298
    PLP 
    RTS 
}