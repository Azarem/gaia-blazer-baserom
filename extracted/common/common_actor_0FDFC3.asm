?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FDFC3 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &code_0FDFD3 )
    COP [80] ( #0A )
    COP [82]
    BRA code_0FDFC3
}

code_0FDFD3 {
    COP [9A] ( #$0000, &code_0FDFE1, &code_0FDFDD, &code_0FDFDD )
}

code_0FDFDD {
    COP [96]
    BRA loc_0FDFE3
}

code_0FDFE1 {
    COP [97]

  loc_0FDFE3:
    COP [9B] ( #$0028, &code_0FDFF7, &code_0FDFED, &code_0FE00C )
}

code_0FDFED {
    COP [9B] ( #$0000, &code_0FDFFE, &code_0FE005, &code_0FE005 )
}

code_0FDFF7 {
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FE011
}

code_0FDFFE {
    COP [80] ( #0D )
    COP [82]
    BRA loc_0FE011
}

code_0FE005 {
    COP [80] ( #0C )
    COP [82]
    BRA loc_0FE011
}

code_0FE00C {
    COP [80] ( #0B )
    COP [82]

  loc_0FE011:
    COP [81] ( #0A, #02 )
    COP [83]
    COP [0C] ( #00, #02, &code_0FDFC3 )
    COP [81] ( #0F, #04 )
    COP [83]
    COP [B0] ( @code_0FE032, #$0200 )
    COP [81] ( #0A, #02 )
    COP [83]
    BRA code_0FDFC3
}

code_0FE032 {
    COP [A3]
    BRK #$64
    LDY #$0010
    SEP #$20
    LDA #$^common_actor_004659_part1.code_002D67
    PHA 
    REP #$20
    LDA #$&common_actor_004659_part1.code_002D67-1
    PHA 
    RTL 
}