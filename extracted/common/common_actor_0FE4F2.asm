?BANK 1F

---------------------------------------------

code_0FE4F2 {
    COP [AA] ( #02 )

  loc_0FE4F5:
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FE502, &code_0FE520, &code_0FE520 )
}

code_0FE502 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE50E, &code_0FE5B2, &code_0FE50E )
}

code_0FE50E {
    COP [21] ( &code_0FE519 )
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FE4F5
}

code_0FE519 {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FE4F5
}

code_0FE520 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE52C, &code_0FE587, &code_0FE52C )
}

code_0FE52C {
    COP [22] ( &code_0FE537 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_0FE4F5
}

code_0FE537 {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FE4F5

  loc_0FE53E:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FE54B, &code_0FE569, &code_0FE569 )
}

code_0FE54B {
    COP [9A] ( #$0018, &code_0FE555, &code_0FE5DE, &code_0FE555 )
}

code_0FE555 {
    COP [97]
    COP [23] ( &code_0FE562 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE53E
}

code_0FE562 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE53E
}

code_0FE569 {
    COP [9A] ( #$0018, &code_0FE573, &code_0FE5DE, &code_0FE573 )
}

code_0FE573 {
    COP [96]
    COP [24] ( &code_0FE580 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE53E
}

code_0FE580 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE53E
}

code_0FE587 {
    BRK #$52
    COP [80] ( #0F )
    COP [82]
    COP [B0] ( @code_0FE59C, #$0200 )
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FE53E
}

code_0FE59C {
    COP [A3]
    COP [9A] ( #$0000, &code_0FE5AA, &code_0FE5A8, &code_0FE5A8 )
}

code_0FE5A8 {
    COP [96]
}

code_0FE5AA {
    COP [80] ( #15 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE5B2 {
    BRK #$52
    COP [80] ( #11 )
    COP [82]
    COP [B0] ( @code_0FE5C8, #$0200 )
    COP [80] ( #12 )
    COP [82]
    BRL loc_0FE53E
}

code_0FE5C8 {
    COP [A3]
    COP [9A] ( #$0000, &code_0FE5D6, &code_0FE5D4, &code_0FE5D4 )
}

code_0FE5D4 {
    COP [96]
}

code_0FE5D6 {
    COP [80] ( #18 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE5DE {
    BRK #$52
    COP [80] ( #13 )
    COP [82]
    COP [B0] ( @code_0FE5F4, #$0200 )
    COP [80] ( #14 )
    COP [82]
    BRL loc_0FE4F5
}

code_0FE5F4 {
    COP [A3]
    COP [9B] ( #$0000, &code_0FE600, &code_0FE608, &code_0FE608 )
}

code_0FE600 {
    COP [80] ( #17 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE608 {
    COP [80] ( #16 )
    COP [82]
    COP [86]
    RTL 
}