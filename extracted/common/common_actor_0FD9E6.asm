?BANK 1F

---------------------------------------------

code_0FD9E6 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD9F4

  code_0FD9EE:
    COP [1B] ( &code_0FD9E6, #$0004 )

  loc_0FD9F4:
    COP [9B] ( #$0008, &code_0FD9FE, &code_0FDA18, &code_0FDA0B )
}

code_0FD9FE {
    COP [21] ( &code_0FDA5C )
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA code_0FD9E6
}

code_0FDA0B {
    COP [22] ( &code_0FDA5C )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FD9E6
}

code_0FDA18 {
    COP [9A] ( #$0000, &code_0FDA22, &code_0FDA3B, &code_0FDA3B )
}

code_0FDA22 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @code_0FDAC4, #$FFF8, #$0000, #$0200 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FDA54
}

code_0FDA3B {
    COP [96]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @code_0FDACE, #$0008, #$0000, #$0200 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FDA54

  code_0FDA54:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDA62
}

code_0FDA5C {
    COP [1B] ( &code_0FDA54, #$0004 )

  loc_0FDA62:
    COP [9A] ( #$0008, &code_0FDA6C, &code_0FDA86, &code_0FDA79 )
}

code_0FDA6C {
    COP [23] ( &code_0FD9EE )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FDA54
}

code_0FDA79 {
    COP [24] ( &code_0FD9EE )
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FDA54
}

code_0FDA86 {
    COP [9B] ( #$0000, &code_0FDA90, &code_0FDAAA, &code_0FDAAA )
}

code_0FDA90 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    COP [B2] ( @code_0FDAD8, #$0002, #$FFF8, #$0200 )
    COP [80] ( #0C )
    COP [82]
    BRL code_0FD9E6
}

code_0FDAAA {
    COP [97]
    COP [80] ( #09 )
    COP [82]
    COP [B2] ( @code_0FDAE2, #$FFFD, #$0008, #$0200 )
    COP [80] ( #0A )
    COP [82]
    BRL code_0FD9E6
}

code_0FDAC4 {
    BRK #$5B
    COP [81] ( #11, #08 )
    COP [83]
    BRA loc_0FDAEA
}

code_0FDACE {
    BRK #$5B
    COP [81] ( #11, #08 )
    COP [83]
    BRA loc_0FDAEA
}

code_0FDAD8 {
    BRK #$5B
    COP [81] ( #10, #08 )
    COP [83]
    BRA loc_0FDAEA
}

code_0FDAE2 {
    BRK #$5B
    COP [81] ( #0F, #08 )
    COP [83]

  loc_0FDAEA:
    COP [86]
    RTL 
}