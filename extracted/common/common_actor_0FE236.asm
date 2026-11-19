?BANK 1F

---------------------------------------------

code_0FE236 {
    COP [AD] ( #10 )      ; {1040950}
    COP [0C] ( #00, #02, &code_0FE246 ) ; {1040953}
    COP [80] ( #3C )      ; {1040959}
    COP [82]              ; {1040962}
    BRA code_0FE236       ; {1040964}
}

code_0FE246 {
    COP [80] ( #3D )      ; {1040966}
    COP [82]              ; {1040969}
    LDA $0016, X          ; {1040971}
    AND #$FDFF            ; {1040974}
    STA $0016, X          ; {1040977}

  loc_0FE254:
    COP [9B] ( #$0000, &code_0FE25E, &code_0FE286, &code_0FE286 ) ; {1040980}
}

code_0FE25E {
    COP [97]              ; {1040990}
    COP [9B] ( #$0018, &code_0FE26A, &code_0FE275, &code_0FE26A ) ; {1040992}
}

code_0FE26A {
    COP [21] ( &code_0FE3BF ) ; {1041002}
    COP [80] ( #2D )      ; {1041006}
    COP [82]              ; {1041009}
    BRA loc_0FE254        ; {1041011}
}

code_0FE275 {
    COP [9A] ( #$0028, &code_0FE27F, &code_0FE345, &code_0FE27F ) ; {1041013}
}

code_0FE27F {
    COP [80] ( #2C )      ; {1041023}
    COP [82]              ; {1041026}
    BRA loc_0FE2AC        ; {1041028}
}

code_0FE286 {
    COP [97]              ; {1041030}
    COP [9B] ( #$0018, &code_0FE292, &code_0FE29D, &code_0FE292 ) ; {1041032}
}

code_0FE292 {
    COP [22] ( &code_0FE3BF ) ; {1041042}
    COP [80] ( #25 )      ; {1041046}
    COP [82]              ; {1041049}
    BRA loc_0FE254        ; {1041051}
}

code_0FE29D {
    COP [9A] ( #$0028, &code_0FE2A7, &code_0FE382, &code_0FE2A7 ) ; {1041053}
}

code_0FE2A7 {
    COP [80] ( #24 )      ; {1041063}
    COP [82]              ; {1041066}

  loc_0FE2AC:
    COP [9A] ( #$0000, &code_0FE2B6, &code_0FE2DF, &code_0FE2DF ) ; {1041068}
}

code_0FE2B6 {
    COP [97]              ; {1041078}
    COP [9A] ( #$0018, &code_0FE2C2, &code_0FE2CD, &code_0FE2C2 ) ; {1041080}
}

code_0FE2C2 {
    COP [23] ( &code_0FE3BF ) ; {1041090}
    COP [80] ( #35 )      ; {1041094}
    COP [82]              ; {1041097}
    BRA loc_0FE2AC        ; {1041099}
}

code_0FE2CD {
    COP [9B] ( #$0028, &code_0FE2D7, &code_0FE308, &code_0FE2D7 ) ; {1041101}
}

code_0FE2D7 {
    COP [80] ( #34 )      ; {1041111}
    COP [82]              ; {1041114}
    BRL loc_0FE254        ; {1041116}
}

code_0FE2DF {
    COP [96]              ; {1041119}
    COP [9A] ( #$0018, &code_0FE2EB, &code_0FE2F6, &code_0FE2EB ) ; {1041121}
}

code_0FE2EB {
    COP [24] ( &code_0FE3BF ) ; {1041131}
    COP [80] ( #35 )      ; {1041135}
    COP [82]              ; {1041138}
    BRA loc_0FE2AC        ; {1041140}
}

code_0FE2F6 {
    COP [9B] ( #$0028, &code_0FE300, &code_0FE308, &code_0FE300 ) ; {1041142}
}

code_0FE300 {
    COP [80] ( #34 )      ; {1041152}
    COP [82]              ; {1041155}
    BRL loc_0FE254        ; {1041157}
}

code_0FE308 {
    COP [9B] ( #$0010, &code_0FE312, &code_0FE323, &code_0FE334 ) ; {1041160}
}

code_0FE312 {
    COP [B0] ( @code_0FE404, #$0200 ) ; {1041170}
    BRK #$41              ; {1041177}
    COP [80] ( #37 )      ; {1041179}
    COP [82]              ; {1041182}
    BRL loc_0FE254        ; {1041184}
}

code_0FE323 {
    COP [B0] ( @code_0FE40B, #$0200 ) ; {1041187}
    BRK #$41              ; {1041194}
    COP [80] ( #38 )      ; {1041196}
    COP [82]              ; {1041199}
    BRL loc_0FE254        ; {1041201}
}

code_0FE334 {
    COP [B0] ( @code_0FE3FD, #$0200 ) ; {1041204}
    BRK #$41              ; {1041211}
    COP [80] ( #36 )      ; {1041213}
    COP [82]              ; {1041216}
    BRL loc_0FE254        ; {1041218}
}

code_0FE345 {
    COP [9A] ( #$0010, &code_0FE34F, &code_0FE360, &code_0FE371 ) ; {1041221}
}

code_0FE34F {
    COP [B0] ( @code_0FE3E8, #$0200 ) ; {1041231}
    BRK #$41              ; {1041238}
    COP [80] ( #2E )      ; {1041240}
    COP [82]              ; {1041243}
    BRL loc_0FE2AC        ; {1041245}
}

code_0FE360 {
    COP [B0] ( @code_0FE3F6, #$0200 ) ; {1041248}
    BRK #$41              ; {1041255}
    COP [80] ( #30 )      ; {1041257}
    COP [82]              ; {1041260}
    BRL loc_0FE2AC        ; {1041262}
}

code_0FE371 {
    COP [B0] ( @code_0FE3EF, #$0200 ) ; {1041265}
    BRK #$41              ; {1041272}
    COP [80] ( #2F )      ; {1041274}
    COP [82]              ; {1041277}
    BRL loc_0FE2AC        ; {1041279}
}

code_0FE382 {
    COP [9A] ( #$0010, &code_0FE38C, &code_0FE39D, &code_0FE3AE ) ; {1041282}
}

code_0FE38C {
    COP [B0] ( @code_0FE3D3, #$0200 ) ; {1041292}
    BRK #$41              ; {1041299}
    COP [80] ( #26 )      ; {1041301}
    COP [82]              ; {1041304}
    BRL loc_0FE2AC        ; {1041306}
}

code_0FE39D {
    COP [B0] ( @code_0FE3E1, #$0200 ) ; {1041309}
    BRK #$41              ; {1041316}
    COP [80] ( #28 )      ; {1041318}
    COP [82]              ; {1041321}
    BRL loc_0FE2AC        ; {1041323}
}

code_0FE3AE {
    COP [B0] ( @code_0FE3DA, #$0200 ) ; {1041326}
    BRK #$41              ; {1041333}
    COP [80] ( #27 )      ; {1041335}
    COP [82]              ; {1041338}
    BRL loc_0FE2AC        ; {1041340}
}

code_0FE3BF {
    LDA $0016, X          ; {1041343}
    ORA #$0200            ; {1041346}
    STA $0016, X          ; {1041349}
    COP [80] ( #3E )      ; {1041352}
    COP [82]              ; {1041355}
    COP [1B] ( &code_0FE236, #$003C ) ; {1041357}
}

code_0FE3D3 {
    COP [80] ( #29 )      ; {1041363}
    COP [82]              ; {1041366}
    BRA loc_0FE410        ; {1041368}
}

code_0FE3DA {
    COP [80] ( #2A )      ; {1041370}
    COP [82]              ; {1041373}
    BRA loc_0FE410        ; {1041375}
}

code_0FE3E1 {
    COP [80] ( #2B )      ; {1041377}
    COP [82]              ; {1041380}
    BRA loc_0FE410        ; {1041382}
}

code_0FE3E8 {
    COP [80] ( #2E )      ; {1041384}
    COP [82]              ; {1041387}
    BRA loc_0FE410        ; {1041389}
}

code_0FE3EF {
    COP [80] ( #2F )      ; {1041391}
    COP [82]              ; {1041394}
    BRA loc_0FE410        ; {1041396}
}

code_0FE3F6 {
    COP [80] ( #30 )      ; {1041398}
    COP [82]              ; {1041401}
    BRA loc_0FE410        ; {1041403}
}

code_0FE3FD {
    COP [80] ( #39 )      ; {1041405}
    COP [82]              ; {1041408}
    BRA loc_0FE410        ; {1041410}
}

code_0FE404 {
    COP [80] ( #3A )      ; {1041412}
    COP [82]              ; {1041415}
    BRA loc_0FE410        ; {1041417}
}

code_0FE40B {
    COP [80] ( #3B )      ; {1041419}
    COP [82]              ; {1041422}

  loc_0FE410:
    COP [86]              ; {1041424}
    RTL                   ; {1041426}
}