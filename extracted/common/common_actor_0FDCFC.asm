?BANK 1F

---------------------------------------------

code_0FDCFC {
    COP [A2] ( #20 )
    COP [A5] ( &code_0FDD09, &code_0FDDD9, &code_0FDD94, &code_0FDD4E )
}

code_0FDD09 {
    COP [AD] ( #08 )
    COP [22] ( &code_0FDD33 )
    COP [81] ( #2D, #04 )
    COP [83]
    COP [22] ( &code_0FDD33 )
    COP [81] ( #2D, #04 )
    COP [83]

  loc_0FDD20:
    COP [B2] ( @code_0FDE3B, #$0000, #$FFFA, #$0200 )
    COP [81] ( #2B, #08 )
    COP [83]
    BRA code_0FDD09
}

code_0FDD33 {
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    BRA loc_0FDD65
}

code_0FDD4E {
    COP [AD] ( #08 )
    COP [21] ( &code_0FDD78 )
    COP [81] ( #2E, #04 )
    COP [83]
    COP [21] ( &code_0FDD78 )
    COP [81] ( #2E, #04 )
    COP [83]

  loc_0FDD65:
    COP [B2] ( @code_0FDE2E, #$0000, #$FFE6, #$0200 )
    COP [81] ( #2B, #08 )
    COP [83]
    BRA code_0FDD4E
}

code_0FDD78 {
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    BRL loc_0FDD20
}

code_0FDD94 {
    COP [AD] ( #08 )
    COP [24] ( &code_0FDDBE )
    COP [81] ( #30, #04 )
    COP [83]
    COP [24] ( &code_0FDDBE )
    COP [81] ( #30, #04 )
    COP [83]

  loc_0FDDAB:
    COP [B2] ( @code_0FDE1F, #$0012, #$FFF9, #$0200 )
    COP [81] ( #2C, #08 )
    COP [83]
    BRA code_0FDD94
}

code_0FDDBE {
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FDDF0
}

code_0FDDD9 {
    COP [AD] ( #08 )
    COP [23] ( &code_0FDE03 )
    COP [81] ( #2F, #04 )
    COP [83]
    COP [23] ( &code_0FDE03 )
    COP [81] ( #2F, #04 )
    COP [83]

  loc_0FDDF0:
    COP [B2] ( @code_0FDE21, #$FFFB, #$FFF9, #$0200 )
    COP [81] ( #2C, #08 )
    COP [83]
    BRA code_0FDDD9
}

code_0FDE03 {
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRL loc_0FDDAB
}

code_0FDE1F {
    COP [96]
}

code_0FDE21 {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #35 )
    COP [82]
    COP [86]
    RTL 
}

code_0FDE2E {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #34 )
    COP [82]
    COP [86]
    RTL 
}

code_0FDE3B {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #33 )
    COP [82]
    COP [86]
    RTL 
}