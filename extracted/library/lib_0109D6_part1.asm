?BANK 02

?INCLUDE 'lib_0272E6'
?INCLUDE 'lib_027462_part1'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!vram_write_queue               1C7B
!tile_type_map                  7F8000

---------------------------------------------

code_0106F1 {
    PHP 
    PHX 
    PHA 
    REP #$20
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    PLA 
    STA $7E8000, X
    PHX 
    REP #$20
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $7E2000, X
    AND $035C
    ORA $036A
    STA $1C7D
    LDA $7E2002, X
    AND $035C
    ORA $036A
    STA $1C81
    LDA $7E2004, X
    AND $035C
    ORA $036A
    STA $1C85
    LDA $7E2006, X
    AND $035C
    ORA $036A
    STA $1C89
    SEP #$20
    LDA $7E2001, X
    AND #$02
    PHA 
    LDA $7E2003, X
    AND #$02
    PHA 
    LDA $7E2005, X
    AND #$02
    PHA 
    LDA $7E2007, X
    AND #$02
    ASL 
    ORA $01, S
    ASL 
    ORA $02, S
    ASL 
    ORA $03, S
    LSR 
    XBA 
    PLA 
    PLA 
    PLA 
    XBA 
    PLX 
    STA $tile_type_map, X
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_x
    CMP #$0111
    BCS loc_0107A9
    LDA $18
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_y
    CMP #$0111
    BCS loc_0107A9
    JSL $@lib_0272E6.code_0272E6
    STA $vram_write_queue
    INC 
    STA $1C7F
    CLC 
    ADC #$001F
    STA $1C83
    INC 
    STA $1C87
    STZ $1C8B

  loc_0107A9:
    PLX 
    PLP 
    RTL 
}

code_0107AC {
    PHP 
    PHX 
    PHA 
    REP #$20
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    PLA 
    STA $7E8000, X
    STA $7EC000, X
    PHX 
    REP #$20
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $7E2000, X
    AND $035C
    ORA $036A
    STA $1C7D
    LDA $7E2002, X
    AND $035C
    ORA $036A
    STA $1C81
    LDA $7E2004, X
    AND $035C
    ORA $036A
    STA $1C85
    LDA $7E2006, X
    AND $035C
    ORA $036A
    STA $1C89
    LDA $7E2800, X
    AND $0360
    ORA $036E
    STA $1C8D
    LDA $7E2802, X
    AND $0360
    ORA $036E
    STA $1C91
    LDA $7E2804, X
    AND $0360
    ORA $036E
    STA $1C95
    LDA $7E2806, X
    AND $0360
    ORA $036E
    STA $1C99
    SEP #$20
    LDA $7E2001, X
    AND #$02
    PHA 
    LDA $7E2003, X
    AND #$02
    PHA 
    LDA $7E2005, X
    AND #$02
    PHA 
    LDA $7E2007, X
    AND #$02
    ASL 
    ORA $01, S
    ASL 
    ORA $02, S
    ASL 
    ORA $03, S
    LSR 
    XBA 
    PLA 
    PLA 
    PLA 
    XBA 
    PLX 
    STA $tile_type_map, X
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_x
    CMP #$0111
    BCS loc_0108B8
    LDA $18
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_y
    CMP #$0111
    BCS loc_0108B8
    JSL $@lib_0272E6.code_0272E6
    PHA 
    STA $vram_write_queue
    INC 
    STA $1C7F
    CLC 
    ADC #$001F
    STA $1C83
    INC 
    STA $1C87
    PLA 
    SEC 
    SBC #$6000
    CLC 
    ADC #$7000
    STA $1C8B
    INC 
    STA $1C8F
    CLC 
    ADC #$001F
    STA $1C93
    INC 
    STA $1C97
    STZ $1C9B

  loc_0108B8:
    PLX 
    PLP 
    RTL 
}