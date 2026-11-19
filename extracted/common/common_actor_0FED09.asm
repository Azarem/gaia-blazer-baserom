?BANK 1F

?INCLUDE 'common_actor_004659_part1'
?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

code_0FED09 {
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
    COP [A1] ( #$0008, #$FFF1 )

  code_0FED27:
    COP [AD] ( #10 )
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BEQ loc_0FED6E
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #2C )
    COP [82]
    COP [A0] ( #$0008 )
    COP [B2] ( @code_0FED71, #$0000, #$0000, #$0200 )
    COP [80] ( #2D )
    COP [82]
    COP [A0] ( #$FFF8 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FED27, #$0078 )

  loc_0FED6E:
    COP [86]
    RTL 
}

code_0FED71 {
    COP [A3]
    BRK #$64
    COP [80] ( #2B )
    COP [82]
    COP [81] ( #2E, #04 )
    COP [83]
    LDY #$002E
    SEP #$20
    LDA #$^common_actor_004659_part1.code_002D67
    PHA 
    REP #$20
    LDA #$&common_actor_004659_part1.code_002D67-1
    PHA 
    RTL 
}