?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FD1E5 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FD1F5 )
    COP [80] ( #2B )
    COP [82]
    BRA code_0FD1E5
}

code_0FD1F5 {
    COP [1F]
    LDA $rng_state+1
    BPL loc_0FD21A
    COP [9A] ( #$0000, &code_0FD206, &code_0FD210, &code_0FD210 )
}

code_0FD206 {
    COP [9B] ( #$0000, &code_0FD261, &code_0FD24E, &code_0FD24E )
}

code_0FD210 {
    COP [9B] ( #$0000, &code_0FD228, &code_0FD23B, &code_0FD23B )

  loc_0FD21A:
    AND #$0003
    BEQ code_0FD228
    DEC 
    BEQ code_0FD23B
    DEC 
    BEQ code_0FD24E
    DEC 
    BEQ code_0FD261
}

code_0FD228 {
    COP [96]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA code_0FD1E5
}

code_0FD23B {
    COP [96]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA code_0FD1E5
}

code_0FD24E {
    COP [97]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA code_0FD1E5
}

code_0FD261 {
    COP [97]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRL code_0FD1E5
}