?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FC9BC {
    COP [A5] ( &code_0FC9C6, &code_0FC9CF, &code_0FC9D6, &code_0FC9DD )
}

code_0FC9C6 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9CF {
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9D6 {
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9DD {
    COP [96]
    COP [80] ( #10 )
    COP [82]

  loc_0FC9E4:
    COP [AD] ( #08 )
    COP [03] ( #08 )
    COP [80] ( #33 )
    COP [82]
    COP [0C] ( #00, #03, &code_0FCA05 )
    COP [04]
    COP [80] ( #11 )
    COP [82]
    COP [B0] ( @code_0FCA1F, #$0200 )
    BRA loc_0FC9E4
}

code_0FCA05 {
    COP [8F]
    COP [9B] ( #$0000, &code_0FCA11, &code_0FCA18, &code_0FCA18 )
}

code_0FCA11 {
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FC9E4
}

code_0FCA18 {
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FCA1F {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$002A
    SEP #$20
    LDA #$^common_actor_004659_part1.code_002D67
    PHA 
    REP #$20
    LDA #$&common_actor_004659_part1.code_002D67-1
    PHA 
    RTL 
}