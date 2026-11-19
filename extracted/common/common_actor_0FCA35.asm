?BANK 1F

---------------------------------------------

code_0FCA35 {
    LDA $001A, X          ; {1034805}
    ORA #$0200            ; {1034808}
    STA $001A, X          ; {1034811}
    COP [A5] ( &code_0FCA48, &code_0FCAAD, &code_0FCB12, &code_0FCB77 ) ; {1034814}
}

code_0FCA48 {
    LDA #$0005            ; {1034824}
    STA $002C, X          ; {1034827}

  loc_0FCA4E:
    COP [AD] ( #08 )      ; {1034830}
    COP [0C] ( #00, #05, &code_0FCA5E ) ; {1034833}

  code_0FCA57:
    COP [80] ( #2F )      ; {1034839}
    COP [82]              ; {1034842}
    BRA loc_0FCA4E        ; {1034844}
}

code_0FCA5E {
    COP [9C] ( &code_0FCA64, &code_0FCA88 ) ; {1034846}
}

code_0FCA64 {
    COP [9A] ( #$0010, &code_0FCA6E, &code_0FCA79, &code_0FCA79 ) ; {1034852}
}

code_0FCA6E {
    COP [23] ( &code_0FCA57 ) ; {1034862}
    COP [80] ( #14 )      ; {1034866}
    COP [82]              ; {1034869}
    BRA loc_0FCAA8        ; {1034871}
}

code_0FCA79 {
    COP [24] ( &code_0FCA57 ) ; {1034873}
    COP [96]              ; {1034877}
    COP [80] ( #14 )      ; {1034879}
    COP [82]              ; {1034882}
    COP [97]              ; {1034884}
    BRA loc_0FCAA8        ; {1034886}
}

code_0FCA88 {
    COP [9B] ( #$0010, &code_0FCA92, &code_0FCA9D, &code_0FCA9D ) ; {1034888}
}

code_0FCA92 {
    COP [21] ( &code_0FCA57 ) ; {1034898}
    COP [80] ( #13 )      ; {1034902}
    COP [82]              ; {1034905}
    BRA loc_0FCAA8        ; {1034907}
}

code_0FCA9D {
    COP [22] ( &code_0FCA57 ) ; {1034909}
    COP [80] ( #12 )      ; {1034913}
    COP [82]              ; {1034916}
    BRA loc_0FCAA8        ; {1034918}

  loc_0FCAA8:
    DEC $002C, X          ; {1034920}
    BNE loc_0FCA4E        ; {1034923}
}

code_0FCAAD {
    LDA #$0005            ; {1034925}
    STA $002C, X          ; {1034928}

  loc_0FCAB3:
    COP [AD] ( #08 )      ; {1034931}
    COP [0C] ( #00, #05, &code_0FCAC3 ) ; {1034934}

  code_0FCABC:
    COP [80] ( #30 )      ; {1034940}
    COP [82]              ; {1034943}
    BRA loc_0FCAB3        ; {1034945}
}

code_0FCAC3 {
    COP [9C] ( &code_0FCAC9, &code_0FCAED ) ; {1034947}
}

code_0FCAC9 {
    COP [9A] ( #$0010, &code_0FCAD3, &code_0FCADE, &code_0FCADE ) ; {1034953}
}

code_0FCAD3 {
    COP [23] ( &code_0FCABC ) ; {1034963}
    COP [80] ( #17 )      ; {1034967}
    COP [82]              ; {1034970}
    BRA loc_0FCB0D        ; {1034972}
}

code_0FCADE {
    COP [24] ( &code_0FCABC ) ; {1034974}
    COP [96]              ; {1034978}
    COP [80] ( #17 )      ; {1034980}
    COP [82]              ; {1034983}
    COP [97]              ; {1034985}
    BRA loc_0FCB0D        ; {1034987}
}

code_0FCAED {
    COP [9B] ( #$0010, &code_0FCAF7, &code_0FCB02, &code_0FCB02 ) ; {1034989}
}

code_0FCAF7 {
    COP [21] ( &code_0FCABC ) ; {1034999}
    COP [80] ( #16 )      ; {1035003}
    COP [82]              ; {1035006}
    BRA loc_0FCB0D        ; {1035008}
}

code_0FCB02 {
    COP [22] ( &code_0FCABC ) ; {1035010}
    COP [80] ( #15 )      ; {1035014}
    COP [82]              ; {1035017}
    BRA loc_0FCB0D        ; {1035019}

  loc_0FCB0D:
    DEC $002C, X          ; {1035021}
    BNE loc_0FCAB3        ; {1035024}
}

code_0FCB12 {
    LDA #$0005            ; {1035026}
    STA $002C, X          ; {1035029}

  loc_0FCB18:
    COP [AD] ( #08 )      ; {1035032}
    COP [0C] ( #00, #05, &code_0FCB28 ) ; {1035035}

  code_0FCB21:
    COP [80] ( #31 )      ; {1035041}
    COP [82]              ; {1035044}
    BRA loc_0FCB18        ; {1035046}
}

code_0FCB28 {
    COP [9C] ( &code_0FCB2E, &code_0FCB52 ) ; {1035048}
}

code_0FCB2E {
    COP [9A] ( #$0010, &code_0FCB38, &code_0FCB43, &code_0FCB43 ) ; {1035054}
}

code_0FCB38 {
    COP [23] ( &code_0FCB21 ) ; {1035064}
    COP [80] ( #1A )      ; {1035068}
    COP [82]              ; {1035071}
    BRA loc_0FCB72        ; {1035073}
}

code_0FCB43 {
    COP [24] ( &code_0FCB21 ) ; {1035075}
    COP [96]              ; {1035079}
    COP [80] ( #1A )      ; {1035081}
    COP [82]              ; {1035084}
    COP [97]              ; {1035086}
    BRA loc_0FCB72        ; {1035088}
}

code_0FCB52 {
    COP [9B] ( #$0010, &code_0FCB5C, &code_0FCB67, &code_0FCB67 ) ; {1035090}
}

code_0FCB5C {
    COP [21] ( &code_0FCB21 ) ; {1035100}
    COP [80] ( #19 )      ; {1035104}
    COP [82]              ; {1035107}
    BRA loc_0FCB72        ; {1035109}
}

code_0FCB67 {
    COP [22] ( &code_0FCB21 ) ; {1035111}
    COP [80] ( #18 )      ; {1035115}
    COP [82]              ; {1035118}
    BRA loc_0FCB72        ; {1035120}

  loc_0FCB72:
    DEC $002C, X          ; {1035122}
    BNE loc_0FCB18        ; {1035125}
}

code_0FCB77 {
    COP [AD] ( #08 )      ; {1035127}
    COP [0C] ( #00, #05, &code_0FCB87 ) ; {1035130}
    COP [80] ( #32 )      ; {1035136}
    COP [82]              ; {1035139}
    BRA code_0FCB77       ; {1035141}
}

code_0FCB87 {
    COP [9C] ( &code_0FCB8D, &code_0FCBB1 ) ; {1035143}
}

code_0FCB8D {
    COP [9A] ( #$0010, &code_0FCB97, &code_0FCBA2, &code_0FCBA2 ) ; {1035149}
}

code_0FCB97 {
    COP [23] ( &code_0FCBD7 ) ; {1035159}
    COP [80] ( #1D )      ; {1035163}
    COP [82]              ; {1035166}
    BRA loc_0FCBD1        ; {1035168}
}

code_0FCBA2 {
    COP [24] ( &code_0FCBD7 ) ; {1035170}
    COP [96]              ; {1035174}
    COP [80] ( #1D )      ; {1035176}
    COP [82]              ; {1035179}
    COP [97]              ; {1035181}
    BRA loc_0FCBD1        ; {1035183}
}

code_0FCBB1 {
    COP [9B] ( #$0010, &code_0FCBBB, &code_0FCBC6, &code_0FCBC6 ) ; {1035185}
}

code_0FCBBB {
    COP [21] ( &code_0FCBD7 ) ; {1035195}
    COP [80] ( #1C )      ; {1035199}
    COP [82]              ; {1035202}
    BRA loc_0FCBD1        ; {1035204}
}

code_0FCBC6 {
    COP [22] ( &code_0FCBD7 ) ; {1035206}
    COP [80] ( #1B )      ; {1035210}
    COP [82]              ; {1035213}
    BRA loc_0FCBD1        ; {1035215}

  loc_0FCBD1:
    COP [1B] ( &code_0FCB77, #$0001 ) ; {1035217}
}

code_0FCBD7 {
    COP [80] ( #1E )      ; {1035223}
    COP [82]              ; {1035226}
    COP [86]              ; {1035228}
    RTL                   ; {1035230}
}