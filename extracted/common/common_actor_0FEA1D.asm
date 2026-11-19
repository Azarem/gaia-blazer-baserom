?BANK 1F

---------------------------------------------

code_0FEA1D {
    COP [AD] ( #08 )      ; {1042973}
    COP [9B] ( #$0000, &code_0FEA2A, &code_0FEA48, &code_0FEA48 ) ; {1042976}
}

code_0FEA2A {
    COP [97]              ; {1042986}
    COP [9B] ( #$0018, &code_0FEA36, &code_0FEAE9, &code_0FEA36 ) ; {1042988}
}

code_0FEA36 {
    COP [21] ( &code_0FEA41 ) ; {1042998}
    COP [80] ( #04 )      ; {1043002}
    COP [82]              ; {1043005}
    BRA code_0FEA1D       ; {1043007}
}

code_0FEA41 {
    COP [80] ( #01 )      ; {1043009}
    COP [82]              ; {1043012}
    BRA code_0FEA1D       ; {1043014}
}

code_0FEA48 {
    COP [97]              ; {1043016}
    COP [9B] ( #$0018, &code_0FEA54, &code_0FEB23, &code_0FEA54 ) ; {1043018}
}

code_0FEA54 {
    COP [22] ( &code_0FEA5F ) ; {1043028}
    COP [80] ( #03 )      ; {1043032}
    COP [82]              ; {1043035}
    BRA code_0FEA1D       ; {1043037}
}

code_0FEA5F {
    COP [80] ( #00 )      ; {1043039}
    COP [82]              ; {1043042}
    BRA code_0FEA1D       ; {1043044}

  loc_0FEA66:
    COP [AD] ( #08 )      ; {1043046}
    COP [9A] ( #$0000, &code_0FEA73, &code_0FEA91, &code_0FEA91 ) ; {1043049}
}

code_0FEA73 {
    COP [9A] ( #$0018, &code_0FEA7D, &code_0FEAAF, &code_0FEA7D ) ; {1043059}
}

code_0FEA7D {
    COP [97]              ; {1043069}
    COP [23] ( &code_0FEA8A ) ; {1043071}
    COP [80] ( #05 )      ; {1043075}
    COP [82]              ; {1043078}
    BRA loc_0FEA66        ; {1043080}
}

code_0FEA8A {
    COP [80] ( #02 )      ; {1043082}
    COP [82]              ; {1043085}
    BRA loc_0FEA66        ; {1043087}
}

code_0FEA91 {
    COP [9A] ( #$0018, &code_0FEA9B, &code_0FEAAF, &code_0FEA9B ) ; {1043089}
}

code_0FEA9B {
    COP [96]              ; {1043099}
    COP [24] ( &code_0FEAA8 ) ; {1043101}
    COP [80] ( #05 )      ; {1043105}
    COP [82]              ; {1043108}
    BRA loc_0FEA66        ; {1043110}
}

code_0FEAA8 {
    COP [80] ( #02 )      ; {1043112}
    COP [82]              ; {1043115}
    BRA loc_0FEA66        ; {1043117}
}

code_0FEAAF {
    COP [9B] ( #$0000, &code_0FEAB9, &code_0FEAD1, &code_0FEAD1 ) ; {1043119}
}

code_0FEAB9 {
    COP [80] ( #0E )      ; {1043129}
    COP [82]              ; {1043132}
    COP [B2] ( @code_0FEB7B, #$FFF8, #$FFE8, #$0200 ) ; {1043134}
    COP [80] ( #0F )      ; {1043145}
    COP [82]              ; {1043148}
    BRL code_0FEA1D       ; {1043150}
}

code_0FEAD1 {
    COP [80] ( #10 )      ; {1043153}
    COP [82]              ; {1043156}
    COP [B2] ( @code_0FEB88, #$FFF8, #$0008, #$0200 ) ; {1043158}
    COP [80] ( #11 )      ; {1043169}
    COP [82]              ; {1043172}
    BRL code_0FEA1D       ; {1043174}
}

code_0FEAE9 {
    COP [9A] ( #$0000, &code_0FEAF3, &code_0FEB0B, &code_0FEB0B ) ; {1043177}
}

code_0FEAF3 {
    COP [80] ( #0C )      ; {1043187}
    COP [82]              ; {1043190}
    COP [B2] ( @code_0FEB5D, #$FFF8, #$0008, #$0200 ) ; {1043192}
    COP [80] ( #0D )      ; {1043203}
    COP [82]              ; {1043206}
    BRL loc_0FEA66        ; {1043208}
}

code_0FEB0B {
    COP [80] ( #0A )      ; {1043211}
    COP [82]              ; {1043214}
    COP [B2] ( @code_0FEB6C, #$0018, #$0008, #$0200 ) ; {1043216}
    COP [80] ( #0B )      ; {1043227}
    COP [82]              ; {1043230}
    BRL loc_0FEA66        ; {1043232}
}

code_0FEB23 {
    COP [9A] ( #$0000, &code_0FEB2D, &code_0FEB45, &code_0FEB45 ) ; {1043235}
}

code_0FEB2D {
    COP [80] ( #06 )      ; {1043245}
    COP [82]              ; {1043248}
    COP [B2] ( @code_0FEB5D, #$FFF8, #$0008, #$0200 ) ; {1043250}
    COP [80] ( #07 )      ; {1043261}
    COP [82]              ; {1043264}
    BRL loc_0FEA66        ; {1043266}
}

code_0FEB45 {
    COP [80] ( #08 )      ; {1043269}
    COP [82]              ; {1043272}
    COP [B2] ( @code_0FEB6C, #$0018, #$0008, #$0200 ) ; {1043274}
    COP [80] ( #09 )      ; {1043285}
    COP [82]              ; {1043288}
    BRL loc_0FEA66        ; {1043290}
}

code_0FEB5D {
    COP [A3]              ; {1043293}
    COP [97]              ; {1043295}
    BRK #$52              ; {1043297}
    COP [81] ( #14, #08 ) ; {1043299}
    COP [83]              ; {1043303}
    COP [86]              ; {1043305}
    RTL                   ; {1043307}
}

code_0FEB6C {
    COP [A3]              ; {1043308}
    COP [96]              ; {1043310}
    BRK #$52              ; {1043312}
    COP [81] ( #14, #08 ) ; {1043314}
    COP [83]              ; {1043318}
    COP [86]              ; {1043320}
    RTL                   ; {1043322}
}

code_0FEB7B {
    COP [A3]              ; {1043323}
    BRK #$52              ; {1043325}
    COP [81] ( #13, #08 ) ; {1043327}
    COP [83]              ; {1043331}
    COP [86]              ; {1043333}
    RTL                   ; {1043335}
}

code_0FEB88 {
    COP [A3]              ; {1043336}
    BRK #$52              ; {1043338}
    COP [81] ( #12, #08 ) ; {1043340}
    COP [83]              ; {1043344}
    COP [86]              ; {1043346}
    RTL                   ; {1043348}
}