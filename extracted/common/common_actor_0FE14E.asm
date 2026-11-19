?BANK 1F

---------------------------------------------

code_0FE14E {
    COP [A5] ( &code_0FE158, &code_0FE161, &code_0FE168, &code_0FE171 )
}

code_0FE158 {
    COP [96]
    COP [80] ( #1D )
    COP [82]
    BRA code_0FE1A9
}

code_0FE161 {
    COP [80] ( #1F )
    COP [82]
    BRA code_0FE178
}

code_0FE168 {
    COP [96]
    COP [80] ( #1F )
    COP [82]
    BRA code_0FE178
}

code_0FE171 {
    COP [80] ( #1E )
    COP [82]
    BRA code_0FE1A9

  code_0FE178:
    COP [AD] ( #08 )
    COP [9B] ( #$0008, &code_0FE18F, &code_0FE185, &code_0FE18F )
}

code_0FE185 {
    COP [9A] ( #$0000, &code_0FE1DA, &code_0FE1EE, &code_0FE1EE )
}

code_0FE18F {
    COP [9A] ( #$0020, &code_0FE1A3, &code_0FE199, &code_0FE1A3 )
}

code_0FE199 {
    COP [A5] ( &code_0FE1EE, &code_0FE1DA, &code_0FE1EE, &code_0FE1DA )
}

code_0FE1A3 {
    COP [1B] ( &code_0FE178, #$0008 )

  code_0FE1A9:
    COP [AD] ( #08 )
    COP [9A] ( #$0008, &code_0FE1C0, &code_0FE1B6, &code_0FE1C0 )
}

code_0FE1B6 {
    COP [9B] ( #$0000, &code_0FE203, &code_0FE217, &code_0FE217 )
}

code_0FE1C0 {
    COP [9B] ( #$0020, &code_0FE1D4, &code_0FE1CA, &code_0FE1D4 )
}

code_0FE1CA {
    COP [A5] ( &code_0FE217, &code_0FE203, &code_0FE217, &code_0FE203 )
}

code_0FE1D4 {
    COP [1B] ( &code_0FE1A9, #$0008 )
}

code_0FE1DA {
    COP [97]

  loc_0FE1DC:
    COP [23] ( &code_0FE1E7 )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FE1DC
}

code_0FE1E7 {
    COP [80] ( #1F )
    COP [82]
    BRA code_0FE178
}

code_0FE1EE {
    COP [96]

  loc_0FE1F0:
    COP [24] ( &code_0FE1FB )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FE1F0
}

code_0FE1FB {
    COP [80] ( #1F )
    COP [82]
    BRL code_0FE178
}

code_0FE203 {
    COP [97]

  loc_0FE205:
    COP [21] ( &code_0FE210 )
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FE205
}

code_0FE210 {
    COP [80] ( #1E )
    COP [82]
    BRA code_0FE1A9
}

code_0FE217 {
    COP [96]

  loc_0FE219:
    COP [22] ( &code_0FE224 )
    COP [80] ( #20 )
    COP [82]
    BRA loc_0FE219
}

code_0FE224 {
    COP [80] ( #1D )
    COP [82]
    BRL code_0FE1A9
}