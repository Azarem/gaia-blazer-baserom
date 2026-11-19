?BANK 1F

---------------------------------------------

code_0FC8FE {
    LDA $0016, X          ; {1034494}
    BIT #$8000            ; {1034497}
    BEQ loc_0FC90C        ; {1034500}

  code_0FC906:
    COP [1B] ( &code_0FC8FE, #$0004 ) ; {1034502}

  loc_0FC90C:
    COP [9B] ( #$0008, &code_0FC916, &code_0FC930, &code_0FC923 ) ; {1034508}
}

code_0FC916 {
    COP [21] ( &code_0FC964 ) ; {1034518}
    COP [97]              ; {1034522}
    COP [80] ( #04 )      ; {1034524}
    COP [82]              ; {1034527}
    BRA code_0FC8FE       ; {1034529}
}

code_0FC923 {
    COP [22] ( &code_0FC964 ) ; {1034531}
    COP [97]              ; {1034535}
    COP [80] ( #03 )      ; {1034537}
    COP [82]              ; {1034540}
    BRA code_0FC8FE       ; {1034542}
}

code_0FC930 {
    COP [9A] ( #$0000, &code_0FC93A, &code_0FC94B, &code_0FC94B ) ; {1034544}
}

code_0FC93A {
    COP [AE] ( #$FFF0, #$0000, &code_0FC964 ) ; {1034554}
    COP [97]              ; {1034562}
    COP [80] ( #08 )      ; {1034564}
    COP [82]              ; {1034567}
    BRA code_0FC95C       ; {1034569}
}

code_0FC94B {
    COP [AE] ( #$0010, #$0000, &code_0FC964 ) ; {1034571}
    COP [96]              ; {1034579}
    COP [80] ( #08 )      ; {1034581}
    COP [82]              ; {1034584}
    BRA code_0FC95C       ; {1034586}

  code_0FC95C:
    LDA $0016, X          ; {1034588}
    BIT #$8000            ; {1034591}
    BEQ loc_0FC96A        ; {1034594}
}

code_0FC964 {
    COP [1B] ( &code_0FC95C, #$0004 ) ; {1034596}

  loc_0FC96A:
    COP [9A] ( #$0008, &code_0FC974, &code_0FC98E, &code_0FC981 ) ; {1034602}
}

code_0FC974 {
    COP [23] ( &code_0FC906 ) ; {1034612}
    COP [97]              ; {1034616}
    COP [80] ( #05 )      ; {1034618}
    COP [82]              ; {1034621}
    BRA code_0FC95C       ; {1034623}
}

code_0FC981 {
    COP [24] ( &code_0FC906 ) ; {1034625}
    COP [96]              ; {1034629}
    COP [80] ( #05 )      ; {1034631}
    COP [82]              ; {1034634}
    BRA code_0FC95C       ; {1034636}
}

code_0FC98E {
    COP [9B] ( #$0000, &code_0FC998, &code_0FC9AA, &code_0FC9AA ) ; {1034638}
}

code_0FC998 {
    COP [AE] ( #$0000, #$FFF0, &code_0FC906 ) ; {1034648}
    COP [97]              ; {1034656}
    COP [80] ( #07 )      ; {1034658}
    COP [82]              ; {1034661}
    BRL code_0FC8FE       ; {1034663}
}

code_0FC9AA {
    COP [AE] ( #$0000, #$0010, &code_0FC906 ) ; {1034666}
    COP [97]              ; {1034674}
    COP [80] ( #06 )      ; {1034676}
    COP [82]              ; {1034679}
    BRL code_0FC8FE       ; {1034681}
}