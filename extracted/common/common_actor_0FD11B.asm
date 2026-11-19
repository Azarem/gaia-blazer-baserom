?BANK 1F

---------------------------------------------

code_0FD11B {
    COP [A3]
    COP [1B] ( &code_0FD123, #$0000 )
}

code_0FD123 {
    COP [AD] ( #08 )
    BRL loc_0FD195

  code_0FD129:
    COP [97]
    COP [80] ( #29 )
    COP [82]
    BRA loc_0FD195

  code_0FD132:
    COP [96]
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD1A9

  code_0FD13B:
    COP [96]
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FD195

  code_0FD144:
    COP [96]
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FD1A9

  code_0FD14D:
    COP [96]
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD156:
    COP [96]
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD1A9

  code_0FD15F:
    COP [97]
    COP [80] ( #28 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD168:
    COP [97]
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD1D1

  code_0FD171:
    COP [97]
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD17A:
    COP [97]
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FD1D1

  code_0FD183:
    COP [97]
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FD195

  code_0FD18C:
    COP [97]
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD1D1

  loc_0FD195:
    COP [9B] ( #$0000, &code_0FD129, &code_0FD19F, &code_0FD19F )
}

code_0FD19F {
    COP [9A] ( #$0000, &code_0FD18C, &code_0FD132, &code_0FD132 )

  loc_0FD1A9:
    COP [9A] ( #$0000, &code_0FD1B3, &code_0FD1B3, &code_0FD144 )
}

code_0FD1B3 {
    COP [9B] ( #$0000, &code_0FD13B, &code_0FD14D, &code_0FD14D )

  loc_0FD1BD:
    COP [9B] ( #$0000, &code_0FD1C7, &code_0FD1C7, &code_0FD15F )
}

code_0FD1C7 {
    COP [9A] ( #$0000, &code_0FD168, &code_0FD168, &code_0FD156 )

  loc_0FD1D1:
    COP [9A] ( #$0000, &code_0FD17A, &code_0FD1DB, &code_0FD1DB )
}

code_0FD1DB {
    COP [9B] ( #$0000, &code_0FD183, &code_0FD183, &code_0FD171 )
}