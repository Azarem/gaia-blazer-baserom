?BANK 1F

---------------------------------------------

code_0FE413 {
    COP [AA] ( #00 )

  loc_0FE416:
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FE423, &code_0FE441, &code_0FE441 )
}

code_0FE423 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE42F, &code_0FE4C0, &code_0FE42F )
}

code_0FE42F {
    COP [21] ( &code_0FE43A )
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FE416
}

code_0FE43A {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FE416
}

code_0FE441 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE44D, &code_0FE4A8, &code_0FE44D )
}

code_0FE44D {
    COP [22] ( &code_0FE458 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_0FE416
}

code_0FE458 {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FE416

  loc_0FE45F:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FE46C, &code_0FE48A, &code_0FE48A )
}

code_0FE46C {
    COP [9A] ( #$0018, &code_0FE476, &code_0FE4D9, &code_0FE476 )
}

code_0FE476 {
    COP [97]
    COP [23] ( &code_0FE483 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE45F
}

code_0FE483 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE45F
}

code_0FE48A {
    COP [9A] ( #$0018, &code_0FE494, &code_0FE4D9, &code_0FE494 )
}

code_0FE494 {
    COP [96]
    COP [24] ( &code_0FE4A1 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE45F
}

code_0FE4A1 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE45F
}

code_0FE4A8 {
    BRK #$41
    COP [80] ( #0C )
    COP [82]
    COP [B0] ( @code_0FE4B8, #$0200 )
    BRA loc_0FE45F
}

code_0FE4B8 {
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE4C0 {
    BRK #$41
    COP [80] ( #0D )
    COP [82]
    COP [B0] ( @code_0FE4D1, #$0200 )
    BRL loc_0FE45F
}

code_0FE4D1 {
    COP [80] ( #1A )
    COP [82]
    COP [86]
    RTL 
}

code_0FE4D9 {
    BRK #$41
    COP [80] ( #0E )
    COP [82]
    COP [B0] ( @code_0FE4EA, #$0200 )
    BRL loc_0FE416
}

code_0FE4EA {
    COP [80] ( #1B )
    COP [82]
    COP [86]
    RTL 
}