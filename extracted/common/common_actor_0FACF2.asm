?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FACF2 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAD00
    COP [1B] ( &code_0FACF2, #$0008 )

  loc_0FAD00:
    COP [81] ( #18, #08 )
    COP [83]
    COP [80] ( #19 )
    COP [82]
    COP [B0] ( @code_0FAD14, #$0200 )
    BRA code_0FACF2
}

code_0FAD14 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$001F
    SEP #$20
    LDA #$^common_actor_004659_part1.code_002D67
    PHA 
    REP #$20
    LDA #$&common_actor_004659_part1.code_002D67-1
    PHA 
    RTL 
}