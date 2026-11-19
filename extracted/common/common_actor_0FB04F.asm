?BANK 1F

---------------------------------------------

code_0FB04F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB05D

  loc_0FB057:
    COP [1B] ( &code_0FB04F, #$0010 )

  loc_0FB05D:
    COP [0C] ( #00, #05, &code_0FB065 )
    BRA loc_0FB057
}

code_0FB065 {
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #03, #02 )
    COP [83]
    COP [80] ( #01 )
    COP [82]

  loc_0FB075:
    COP [0C] ( #00, #05, &code_0FB087 )
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FB057
}

code_0FB087 {
    COP [9A] ( #$0010, &code_0FB091, &code_0FB0AB, &code_0FB09E )
}

code_0FB091 {
    COP [23] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FB0AB
}

code_0FB09E {
    COP [24] ( &code_0FB0CF )
    COP [96]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FB0AB
}

code_0FB0AB {
    COP [9B] ( #$0010, &code_0FB0B5, &code_0FB0CF, &code_0FB0C2 )
}

code_0FB0B5 {
    COP [21] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FB0CF
}

code_0FB0C2 {
    COP [22] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FB0CF
}

code_0FB0CF {
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FB075
}