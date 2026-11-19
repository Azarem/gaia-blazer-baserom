?BANK 1F

?INCLUDE 'common_actor_004659_part1'

!rng_state                      0301

---------------------------------------------

code_0FB9D6 {
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FB9E3, &code_0FBA01, &code_0FBA01 )
}

code_0FB9E3 {
    COP [97]
    COP [9B] ( #$0018, &code_0FB9EF, &code_0FBA68, &code_0FB9EF )
}

code_0FB9EF {
    COP [21] ( &code_0FB9FA )
    COP [80] ( #23 )
    COP [82]
    BRA code_0FB9D6
}

code_0FB9FA {
    COP [80] ( #20 )
    COP [82]
    BRA code_0FB9D6
}

code_0FBA01 {
    COP [97]
    COP [9B] ( #$0018, &code_0FBA0D, &code_0FBA68, &code_0FBA0D )
}

code_0FBA0D {
    COP [22] ( &code_0FBA18 )
    COP [80] ( #22 )
    COP [82]
    BRA code_0FB9D6
}

code_0FBA18 {
    COP [80] ( #1F )
    COP [82]
    BRA code_0FB9D6

  loc_0FBA1F:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FBA2C, &code_0FBA4A, &code_0FBA4A )
}

code_0FBA2C {
    COP [9A] ( #$0018, &code_0FBA36, &code_0FBA85, &code_0FBA36 )
}

code_0FBA36 {
    COP [97]
    COP [23] ( &code_0FBA43 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA43 {
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA4A {
    COP [9A] ( #$0018, &code_0FBA54, &code_0FBA85, &code_0FBA54 )
}

code_0FBA54 {
    COP [96]
    COP [24] ( &code_0FBA61 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA61 {
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA68 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE loc_0FBA1F
    COP [80] ( #1F )
    COP [82]
    COP [B0] ( @code_0FBAA6, #$0200 )
    COP [80] ( #1F )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA85 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FBA92
    BRL code_0FB9D6

  loc_0FBA92:
    COP [80] ( #1F )
    COP [82]
    COP [B0] ( @code_0FBAA6, #$0200 )
    COP [80] ( #1F )
    COP [82]
    BRL code_0FB9D6
}

code_0FBAA6 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$0028
    SEP #$20
    LDA #$^common_actor_004659_part1.code_002D67
    PHA 
    REP #$20
    LDA #$&common_actor_004659_part1.code_002D67-1
    PHA 
    RTL 
}