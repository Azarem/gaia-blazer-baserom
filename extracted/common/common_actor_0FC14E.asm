?BANK 1F

?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

code_0FC14E {
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    TXA 
    PLX 
    STA $0030, X

  code_0FC166:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC174

  code_0FC16E:
    COP [1B] ( &code_0FC166, #$0008 )

  loc_0FC174:
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BNE loc_0FC186
    BRL loc_0FC26E

  loc_0FC186:
    COP [9B] ( #$0060, &code_0FC16E, &code_0FC190, &code_0FC16E )
}

code_0FC190 {
    COP [9A] ( #$0000, &code_0FC19A, &code_0FC1C7, &code_0FC1C7 )
}

code_0FC19A {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @code_0FC20D )
    COP [80] ( #2C )
    COP [82]
    COP [85] ( @code_0FC223 )
    COP [80] ( #2D )
    COP [82]
    COP [85] ( @code_0FC20D )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA loc_0FC1F6
}

code_0FC1C7 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @code_0FC20D )
    COP [80] ( #2C )
    COP [82]
    COP [85] ( @code_0FC229 )
    COP [80] ( #2D )
    COP [82]
    COP [85] ( @code_0FC20D )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [97]

  loc_0FC1F6:
    COP [03] ( #78 )
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BEQ loc_0FC26E
    COP [04]
    BRL code_0FC166
}

code_0FC20D {
    COP [28] ( &code_0FC213 )
    BRA loc_0FC220
}

code_0FC213 {
    LDA #$0300
    STA $0016, X
    COP [A4]
    COP [80] ( #2E )
    COP [82]

  loc_0FC220:
    COP [86]
    RTL 
}

code_0FC223 {
    COP [9F] ( #$FFF8 )
    BRA loc_0FC22D
}

code_0FC229 {
    COP [9F] ( #$0008 )

  loc_0FC22D:
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [9B] ( #$0020, &code_0FC244, &code_0FC252, &code_0FC260 )
}

code_0FC244 {
    COP [81] ( #33, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC252 {
    COP [81] ( #32, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC260 {
    COP [81] ( #34, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 

  loc_0FC26E:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    LDA $001C, X
    ASL 
    BMI loc_0FC283
    COP [23] ( &code_0FC289 )
    BRA loc_0FC28E

  loc_0FC283:
    COP [24] ( &code_0FC289 )
    BRA loc_0FC28E
}

code_0FC289 {
    COP [87]
    BRL code_0FC166

  loc_0FC28E:
    COP [80] ( #31 )
    COP [82]
    BRL code_0FC166
}