?BANK 1F

---------------------------------------------

code_0FE14E {
    COP [A5] ( &code_0FE158, &code_0FE161, &code_0FE168, &code_0FE171 ) ; {1040718}
}

code_0FE158 {
    COP [96]              ; {1040728}
    COP [80] ( #1D )      ; {1040730}
    COP [82]              ; {1040733}
    BRA code_0FE1A9       ; {1040735}
}

code_0FE161 {
    COP [80] ( #1F )      ; {1040737}
    COP [82]              ; {1040740}
    BRA code_0FE178       ; {1040742}
}

code_0FE168 {
    COP [96]              ; {1040744}
    COP [80] ( #1F )      ; {1040746}
    COP [82]              ; {1040749}
    BRA code_0FE178       ; {1040751}
}

code_0FE171 {
    COP [80] ( #1E )      ; {1040753}
    COP [82]              ; {1040756}
    BRA code_0FE1A9       ; {1040758}

  code_0FE178:
    COP [AD] ( #08 )      ; {1040760}
    COP [9B] ( #$0008, &code_0FE18F, &code_0FE185, &code_0FE18F ) ; {1040763}
}

code_0FE185 {
    COP [9A] ( #$0000, &code_0FE1DA, &code_0FE1EE, &code_0FE1EE ) ; {1040773}
}

code_0FE18F {
    COP [9A] ( #$0020, &code_0FE1A3, &code_0FE199, &code_0FE1A3 ) ; {1040783}
}

code_0FE199 {
    COP [A5] ( &code_0FE1EE, &code_0FE1DA, &code_0FE1EE, &code_0FE1DA ) ; {1040793}
}

code_0FE1A3 {
    COP [1B] ( &code_0FE178, #$0008 ) ; {1040803}

  code_0FE1A9:
    COP [AD] ( #08 )      ; {1040809}
    COP [9A] ( #$0008, &code_0FE1C0, &code_0FE1B6, &code_0FE1C0 ) ; {1040812}
}

code_0FE1B6 {
    COP [9B] ( #$0000, &code_0FE203, &code_0FE217, &code_0FE217 ) ; {1040822}
}

code_0FE1C0 {
    COP [9B] ( #$0020, &code_0FE1D4, &code_0FE1CA, &code_0FE1D4 ) ; {1040832}
}

code_0FE1CA {
    COP [A5] ( &code_0FE217, &code_0FE203, &code_0FE217, &code_0FE203 ) ; {1040842}
}

code_0FE1D4 {
    COP [1B] ( &code_0FE1A9, #$0008 ) ; {1040852}
}

code_0FE1DA {
    COP [97]              ; {1040858}

  loc_0FE1DC:
    COP [23] ( &code_0FE1E7 ) ; {1040860}
    COP [80] ( #22 )      ; {1040864}
    COP [82]              ; {1040867}
    BRA loc_0FE1DC        ; {1040869}
}

code_0FE1E7 {
    COP [80] ( #1F )      ; {1040871}
    COP [82]              ; {1040874}
    BRA code_0FE178       ; {1040876}
}

code_0FE1EE {
    COP [96]              ; {1040878}

  loc_0FE1F0:
    COP [24] ( &code_0FE1FB ) ; {1040880}
    COP [80] ( #22 )      ; {1040884}
    COP [82]              ; {1040887}
    BRA loc_0FE1F0        ; {1040889}
}

code_0FE1FB {
    COP [80] ( #1F )      ; {1040891}
    COP [82]              ; {1040894}
    BRL code_0FE178       ; {1040896}
}

code_0FE203 {
    COP [97]              ; {1040899}

  loc_0FE205:
    COP [21] ( &code_0FE210 ) ; {1040901}
    COP [80] ( #21 )      ; {1040905}
    COP [82]              ; {1040908}
    BRA loc_0FE205        ; {1040910}
}

code_0FE210 {
    COP [80] ( #1E )      ; {1040912}
    COP [82]              ; {1040915}
    BRA code_0FE1A9       ; {1040917}
}

code_0FE217 {
    COP [96]              ; {1040919}

  loc_0FE219:
    COP [22] ( &code_0FE224 ) ; {1040921}
    COP [80] ( #20 )      ; {1040925}
    COP [82]              ; {1040928}
    BRA loc_0FE219        ; {1040930}
}

code_0FE224 {
    COP [80] ( #1D )      ; {1040932}
    COP [82]              ; {1040935}
    BRL code_0FE1A9       ; {1040937}
}