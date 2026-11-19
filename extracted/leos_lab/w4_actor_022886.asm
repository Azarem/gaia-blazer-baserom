?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022886 {
    COP [14] ( #$010D, &code_02288D ) ; {141446}
    RTL                   ; {141452}
}

code_02288D {
    COP [85] ( @engine_0026F3.code_00299D ) ; {141453}
    COP [17] ( &code_022923 ) ; {141458}
    COP [07] ( #$8606, &code_022910 ) ; {141462}

  loc_02289C:
    COP [19] ( #26, &code_0228A7 ) ; {141468}
    COP [0C] ( #00, #02, &code_0228AE ) ; {141473}
}

code_0228A7 {
    COP [80] ( #14 )      ; {141479}
    COP [82]              ; {141482}
    BRA loc_02289C        ; {141484}
}

code_0228AE {
    COP [91]              ; {141486}
    COP [96]              ; {141488}
    COP [80] ( #1A )      ; {141490}
    COP [82]              ; {141493}
    COP [17] ( &code_022928 ) ; {141495}

  code_0228BB:
    COP [91]              ; {141499}
    COP [0D] ( #06, #16, #10, &code_022902 ) ; {141501}
    COP [9C] ( &code_0228CA, &code_0228E6 ) ; {141508}
}

code_0228CA {
    COP [9A] ( #$0010, &code_0228D4, &code_0228E6, &code_0228DD ) ; {141514}
}

code_0228D4 {
    COP [97]              ; {141524}
    COP [80] ( #12 )      ; {141526}
    COP [82]              ; {141529}
    BRA code_0228BB       ; {141531}
}

code_0228DD {
    COP [96]              ; {141533}
    COP [80] ( #12 )      ; {141535}
    COP [82]              ; {141538}
    BRA code_0228BB       ; {141540}
}

code_0228E6 {
    COP [9B] ( #$0010, &code_0228F0, &code_0228FE, &code_0228F7 ) ; {141542}
}

code_0228F0 {
    COP [80] ( #11 )      ; {141552}
    COP [82]              ; {141555}
    BRA code_0228BB       ; {141557}
}

code_0228F7 {
    COP [80] ( #10 )      ; {141559}
    COP [82]              ; {141562}
    BRA code_0228BB       ; {141564}
}

code_0228FE {
    COP [27] ( &code_0228BB ) ; {141566}
}

code_022902 {
    COP [96]              ; {141570}
    COP [81] ( #12, #02 ) ; {141572}
    COP [83]              ; {141576}
    COP [09] ( #$8606 )   ; {141578}
    BRA loc_022915        ; {141582}
}

code_022910 {
    COP [11] ( #06, #18, #11 ) ; {141584}

  loc_022915:
    COP [17] ( &code_022928 ) ; {141589}
    COP [15]              ; {141593}
    COP [91]              ; {141595}
    COP [80] ( #13 )      ; {141597}
    COP [82]              ; {141600}
    RTL                   ; {141602}
}

code_022923 {
    COP [01] ( &asciistring_02292D ) ; {141603}
    RTL                   ; {141607}
}

code_022928 {
    COP [01] ( &asciistring_02296A ) ; {141608}
    RTL                   ; {141612}
}

asciistring_02292D |[10]This is Dr-Leo s [N]Laboratory- [FIN]This house has a [N]second floor and an [N]attic- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02296A |[10]What a good smell- [JMP:&w4_shared_023F33.asciistring_023FA3]|