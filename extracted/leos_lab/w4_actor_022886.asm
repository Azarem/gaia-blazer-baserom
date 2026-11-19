?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022886 {
    COP [14] ( #$010D, &code_02288D )
    RTL 
}

code_02288D {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022923 )
    COP [07] ( #$8606, &code_022910 )

  loc_02289C:
    COP [19] ( #26, &code_0228A7 )
    COP [0C] ( #00, #02, &code_0228AE )
}

code_0228A7 {
    COP [80] ( #14 )
    COP [82]
    BRA loc_02289C
}

code_0228AE {
    COP [91]
    COP [96]
    COP [80] ( #1A )
    COP [82]
    COP [17] ( &code_022928 )

  code_0228BB:
    COP [91]
    COP [0D] ( #06, #16, #10, &code_022902 )
    COP [9C] ( &code_0228CA, &code_0228E6 )
}

code_0228CA {
    COP [9A] ( #$0010, &code_0228D4, &code_0228E6, &code_0228DD )
}

code_0228D4 {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0228BB
}

code_0228DD {
    COP [96]
    COP [80] ( #12 )
    COP [82]
    BRA code_0228BB
}

code_0228E6 {
    COP [9B] ( #$0010, &code_0228F0, &code_0228FE, &code_0228F7 )
}

code_0228F0 {
    COP [80] ( #11 )
    COP [82]
    BRA code_0228BB
}

code_0228F7 {
    COP [80] ( #10 )
    COP [82]
    BRA code_0228BB
}

code_0228FE {
    COP [27] ( &code_0228BB )
}

code_022902 {
    COP [96]
    COP [81] ( #12, #02 )
    COP [83]
    COP [09] ( #$8606 )
    BRA loc_022915
}

code_022910 {
    COP [11] ( #06, #18, #11 )

  loc_022915:
    COP [17] ( &code_022928 )
    COP [15]
    COP [91]
    COP [80] ( #13 )
    COP [82]
    RTL 
}

code_022923 {
    COP [01] ( &asciistring_02292D )
    RTL 
}

code_022928 {
    COP [01] ( &asciistring_02296A )
    RTL 
}

asciistring_02292D |[10]This is Dr-Leo s [N]Laboratory- [FIN]This house has a [N]second floor and an [N]attic- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02296A |[10]What a good smell- [JMP:&w4_shared_023F33.asciistring_023FA3]|