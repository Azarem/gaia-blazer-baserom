?BANK 1F

---------------------------------------------

code_0FAD2A {
    LDA $0016, X          ; {1027370}
    BIT #$8000            ; {1027373}
    BEQ loc_0FAD38        ; {1027376}
    COP [1B] ( &code_0FAD2A, #$0010 ) ; {1027378}

  loc_0FAD38:
    COP [9A] ( #$0010, &code_0FAD42, &code_0FAE1B, &code_0FAD42 ) ; {1027384}
}

code_0FAD42 {
    COP [9B] ( #$0010, &code_0FAD4C, &code_0FAE53, &code_0FAD4C ) ; {1027394}
}

code_0FAD4C {
    COP [9C] ( &code_0FAD52, &code_0FADB1 ) ; {1027404}
}

code_0FAD52 {
    COP [9A] ( #$0010, &code_0FAD5C, &code_0FAE07, &code_0FAD7B ) ; {1027410}
}

code_0FAD5C {
    COP [23] ( &code_0FADA1 ) ; {1027420}
    COP [80] ( #14 )      ; {1027424}
    COP [82]              ; {1027427}
    COP [9A] ( #$0010, &code_0FAD6F, &code_0FAE1B, &code_0FAD6F ) ; {1027429}
}

code_0FAD6F {
    COP [23] ( &code_0FADA1 ) ; {1027439}
    COP [80] ( #0E )      ; {1027443}
    COP [82]              ; {1027446}
    BRL code_0FAE07       ; {1027448}
}

code_0FAD7B {
    COP [24] ( &code_0FADA1 ) ; {1027451}
    COP [96]              ; {1027455}
    COP [80] ( #14 )      ; {1027457}
    COP [82]              ; {1027460}
    COP [97]              ; {1027462}
    COP [9A] ( #$0010, &code_0FAD92, &code_0FAE1B, &code_0FAD92 ) ; {1027464}
}

code_0FAD92 {
    COP [24] ( &code_0FADA1 ) ; {1027474}
    COP [96]              ; {1027478}
    COP [80] ( #0E )      ; {1027480}
    COP [82]              ; {1027483}
    COP [97]              ; {1027485}
    BRA code_0FAE07       ; {1027487}
}

code_0FADA1 {
    COP [1B] ( &code_0FADA7, #$0000 ) ; {1027489}
}

code_0FADA7 {
    COP [9B] ( #$0000, &code_0FADBB, &code_0FADD9, &code_0FADD9 ) ; {1027495}
}

code_0FADB1 {
    COP [9B] ( #$0010, &code_0FADBB, &code_0FAE07, &code_0FADD9 ) ; {1027505}
}

code_0FADBB {
    COP [21] ( &code_0FADF7 ) ; {1027515}
    COP [80] ( #13 )      ; {1027519}
    COP [82]              ; {1027522}
    COP [9B] ( #$0010, &code_0FADCE, &code_0FAE53, &code_0FADCE ) ; {1027524}
}

code_0FADCE {
    COP [21] ( &code_0FADF7 ) ; {1027534}
    COP [80] ( #0D )      ; {1027538}
    COP [82]              ; {1027541}
    BRA code_0FAE07       ; {1027543}
}

code_0FADD9 {
    COP [22] ( &code_0FADF7 ) ; {1027545}
    COP [80] ( #12 )      ; {1027549}
    COP [82]              ; {1027552}
    COP [9B] ( #$0010, &code_0FADEC, &code_0FAE53, &code_0FADEC ) ; {1027554}
}

code_0FADEC {
    COP [22] ( &code_0FADF7 ) ; {1027564}
    COP [80] ( #0C )      ; {1027568}
    COP [82]              ; {1027571}
    BRA code_0FAE07       ; {1027573}
}

code_0FADF7 {
    COP [1B] ( &code_0FADFD, #$0000 ) ; {1027575}
}

code_0FADFD {
    COP [9A] ( #$0000, &code_0FAD5C, &code_0FAD7B, &code_0FAD7B ) ; {1027581}
}

code_0FAE07 {
    COP [9A] ( #$0010, &code_0FAE11, &code_0FAE1B, &code_0FAE11 ) ; {1027591}
}

code_0FAE11 {
    COP [9B] ( #$0010, &code_0FAD2A, &code_0FAE53, &code_0FAD2A ) ; {1027601}
}

code_0FAE1B {
    COP [9B] ( #$0000, &code_0FAE25, &code_0FAE3C, &code_0FAE3C ) ; {1027611}
}

code_0FAE25 {
    COP [80] ( #0B )      ; {1027621}
    COP [82]              ; {1027624}
    COP [80] ( #16 )      ; {1027626}
    COP [82]              ; {1027629}
    COP [85] ( @code_0FAEAF ) ; {1027631}
    COP [80] ( #10 )      ; {1027636}
    COP [82]              ; {1027639}
    BRL code_0FAD2A       ; {1027641}
}

code_0FAE3C {
    COP [80] ( #0B )      ; {1027644}
    COP [82]              ; {1027647}
    COP [80] ( #15 )      ; {1027649}
    COP [82]              ; {1027652}
    COP [85] ( @code_0FAEBA ) ; {1027654}
    COP [80] ( #0F )      ; {1027659}
    COP [82]              ; {1027662}
    BRL code_0FAD2A       ; {1027664}
}

code_0FAE53 {
    COP [9A] ( #$0000, &code_0FAE5D, &code_0FAE74, &code_0FAE74 ) ; {1027667}
}

code_0FAE5D {
    COP [80] ( #0B )      ; {1027677}
    COP [82]              ; {1027680}
    COP [80] ( #17 )      ; {1027682}
    COP [82]              ; {1027685}
    COP [85] ( @code_0FAE8F ) ; {1027687}
    COP [80] ( #11 )      ; {1027692}
    COP [82]              ; {1027695}
    BRL code_0FAD2A       ; {1027697}
}

code_0FAE74 {
    COP [96]              ; {1027700}
    COP [80] ( #0B )      ; {1027702}
    COP [82]              ; {1027705}
    COP [80] ( #17 )      ; {1027707}
    COP [82]              ; {1027710}
    COP [85] ( @code_0FAE8F ) ; {1027712}
    COP [80] ( #11 )      ; {1027717}
    COP [82]              ; {1027720}
    COP [97]              ; {1027722}
    BRL code_0FAD2A       ; {1027724}
}

code_0FAE8F {
    COP [A1] ( #$FFFF, #$FFF8 ) ; {1027727}
    LDA #$0200            ; {1027733}
    STA $0016, X          ; {1027736}
    COP [A3]              ; {1027739}
    COP [A2] ( #30 )      ; {1027741}
    BRK #$5B              ; {1027744}

  loc_0FAEA2:
    COP [80] ( #26 )      ; {1027746}
    COP [82]              ; {1027749}
    COP [1C] ( #$8000, &code_0FAEE2 ) ; {1027751}
    BRA loc_0FAEA2        ; {1027757}
}

code_0FAEAF {
    COP [A1] ( #$0004, #$FFF1 ) ; {1027759}
    LDA #$0025            ; {1027765}
    BRA loc_0FAEC3        ; {1027768}
}

code_0FAEBA {
    COP [A1] ( #$FFFC, #$FFF8 ) ; {1027770}
    LDA #$0024            ; {1027776}

  loc_0FAEC3:
    STA $001E, X          ; {1027779}
    STZ $0020, X          ; {1027782}
    LDA #$0200            ; {1027785}
    STA $0016, X          ; {1027788}
    COP [A3]              ; {1027791}
    COP [A2] ( #30 )      ; {1027793}
    BRK #$5B              ; {1027796}
    COP [91]              ; {1027798}

  loc_0FAED8:
    COP [82]              ; {1027800}
    COP [1C] ( #$8000, &code_0FAEE2 ) ; {1027802}
    BRA loc_0FAED8        ; {1027808}
}

code_0FAEE2 {
    COP [86]              ; {1027810}
    RTL                   ; {1027812}
}