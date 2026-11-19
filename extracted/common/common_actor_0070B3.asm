?BANK 00

---------------------------------------------

code_0070B3 {
    COP [07] ( #$9F05, &code_0070BF )
    COP [07] ( #$9F04, &code_0070C2 )
}

code_0070BF {
    COP [91]
    RTL 
}

code_0070C2 {
    COP [86]
    RTL 
}

code_0070C5 {
    RTL 
}

code_0070C6 {
    COP [A3]
    RTL 
}

code_0070C9 {
    BRA code_0070B3

  code_0070CB:
    RTL 
}

code_0070CC {
    RTL 
}

code_0070CD {
    BRA code_0070B3

  code_0070CF:
    COP [80] ( #04 )
    COP [82]
    RTL 
}