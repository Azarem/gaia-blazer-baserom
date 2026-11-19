?BANK 1F

---------------------------------------------

code_0FD402 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X

  loc_0FD40B:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FD414, &code_0FD41E )
}

code_0FD414 {
    COP [9A] ( #$0000, &code_0FD428, &code_0FD440, &code_0FD440 )
}

code_0FD41E {
    COP [9B] ( #$0000, &code_0FD458, &code_0FD470, &code_0FD470 )
}

code_0FD428 {
    COP [97]

  code_0FD42A:
    COP [81] ( #18, #02 )
    COP [83]
    COP [28] ( &code_0FD436 )
    BRA loc_0FD488
}

code_0FD436 {
    COP [9A] ( #$0008, &code_0FD42A, &code_0FD41E, &code_0FD440 )
}

code_0FD440 {
    COP [97]

  code_0FD442:
    COP [81] ( #19, #02 )
    COP [83]
    COP [28] ( &code_0FD44E )
    BRA loc_0FD488
}

code_0FD44E {
    COP [9A] ( #$0008, &code_0FD428, &code_0FD41E, &code_0FD442 )
}

code_0FD458 {
    COP [97]

  code_0FD45A:
    COP [81] ( #17, #02 )
    COP [83]
    COP [28] ( &code_0FD466 )
    BRA loc_0FD488
}

code_0FD466 {
    COP [9B] ( #$0008, &code_0FD45A, &code_0FD414, &code_0FD470 )
}

code_0FD470 {
    COP [97]

  code_0FD472:
    COP [81] ( #16, #02 )
    COP [83]
    COP [28] ( &code_0FD47E )
    BRA loc_0FD488
}

code_0FD47E {
    COP [9B] ( #$0008, &code_0FD458, &code_0FD414, &code_0FD472 )

  loc_0FD488:
    COP [80] ( #15 )
    COP [82]

  loc_0FD48D:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FD496, &code_0FD4A0 )
}

code_0FD496 {
    COP [9A] ( #$0000, &code_0FD4AA, &code_0FD4C0, &code_0FD4C0 )
}

code_0FD4A0 {
    COP [9B] ( #$0000, &code_0FD4D6, &code_0FD4EC, &code_0FD4EC )
}

code_0FD4AA {
    COP [97]
    COP [23] ( &code_0FD4B8 )
    COP [81] ( #14, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4B8 {
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4C0 {
    COP [96]
    COP [24] ( &code_0FD4CE )
    COP [81] ( #14, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4CE {
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4D6 {
    COP [97]
    COP [21] ( &code_0FD4E4 )
    COP [81] ( #13, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4E4 {
    COP [80] ( #10 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4EC {
    COP [97]
    COP [22] ( &code_0FD4FA )
    COP [81] ( #12, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4FA {
    COP [80] ( #0F )
    COP [82]
    BRL loc_0FD40B
}