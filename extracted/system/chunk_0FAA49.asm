?BANK 1F

?INCLUDE 'chunk_000000'
?INCLUDE 'chunk_010000'
?INCLUDE 'chunk_0270E4'
?INCLUDE 'data_00F9F7'
?INCLUDE 'meta_tables_008000'
?INCLUDE 'spc_030000'

!APUIO0                         2140
!APUIO1                         2141
!APUIO2                         2142

---------------------------------------------

code_0FAA49 {
    LDA $0016, X          ; {1026633}
    BIT #$8000            ; {1026636}
    BEQ loc_0FAA57        ; {1026639}

  code_0FAA51:
    COP [1B] ( &code_0FAA49, #$0008 ) ; {1026641}

  loc_0FAA57:
    COP [9A] ( #$0010, &code_0FAA61, &code_0FAA73, &code_0FAA6A ) ; {1026647}
}

code_0FAA61 {
    COP [97]              ; {1026657}
    COP [80] ( #05 )      ; {1026659}
    COP [82]              ; {1026662}
    BRA code_0FAA73       ; {1026664}
}

code_0FAA6A {
    COP [96]              ; {1026666}
    COP [80] ( #05 )      ; {1026668}
    COP [82]              ; {1026671}
    BRA code_0FAA73       ; {1026673}
}

code_0FAA73 {
    COP [9B] ( #$0010, &code_0FAA7D, &code_0FAA51, &code_0FAA86 ) ; {1026675}
}

code_0FAA7D {
    COP [97]              ; {1026685}
    COP [80] ( #04 )      ; {1026687}
    COP [82]              ; {1026690}
    BRA code_0FAA49       ; {1026692}
}

code_0FAA86 {
    COP [97]              ; {1026694}
    COP [80] ( #03 )      ; {1026696}
    COP [82]              ; {1026699}
    BRA code_0FAA49       ; {1026701}
}

code_0FAA8F {
    LDA $0016, X          ; {1026703}
    BIT #$8000            ; {1026706}
    BEQ loc_0FAA9D        ; {1026709}

  code_0FAA97:
    COP [1B] ( &code_0FAA8F, #$0008 ) ; {1026711}

  loc_0FAA9D:
    COP [9A] ( #$0010, &code_0FAAA7, &code_0FAAB9, &code_0FAAB0 ) ; {1026717}
}

code_0FAAA7 {
    COP [97]              ; {1026727}
    COP [80] ( #0D )      ; {1026729}
    COP [82]              ; {1026732}
    BRA code_0FAAF3       ; {1026734}
}

code_0FAAB0 {
    COP [96]              ; {1026736}
    COP [80] ( #0D )      ; {1026738}
    COP [82]              ; {1026741}
    BRA code_0FAAF3       ; {1026743}
}

code_0FAAB9 {
    COP [9B] ( #$0010, &code_0FAAC3, &code_0FAAF3, &code_0FAADB ) ; {1026745}
}

code_0FAAC3 {
    COP [97]              ; {1026755}
    COP [80] ( #0C )      ; {1026757}
    COP [82]              ; {1026760}
    COP [80] ( #10 )      ; {1026762}
    COP [82]              ; {1026765}
    COP [85] ( @code_0FAB61 ) ; {1026767}
    COP [80] ( #36 )      ; {1026772}
    COP [82]              ; {1026775}
    BRA code_0FAAF3       ; {1026777}
}

code_0FAADB {
    COP [97]              ; {1026779}
    COP [80] ( #0A )      ; {1026781}
    COP [82]              ; {1026784}
    COP [80] ( #0F )      ; {1026786}
    COP [82]              ; {1026789}
    COP [85] ( @code_0FAB6C ) ; {1026791}
    COP [80] ( #35 )      ; {1026796}
    COP [82]              ; {1026799}
    BRA code_0FAAF3       ; {1026801}
}

code_0FAAF3 {
    COP [9B] ( #$0010, &code_0FAAFD, &code_0FAB0F, &code_0FAB06 ) ; {1026803}
}

code_0FAAFD {
    COP [97]              ; {1026813}
    COP [80] ( #0B )      ; {1026815}
    COP [82]              ; {1026818}
    BRA code_0FAA8F       ; {1026820}
}

code_0FAB06 {
    COP [97]              ; {1026822}
    COP [80] ( #09 )      ; {1026824}
    COP [82]              ; {1026827}
    BRA code_0FAA8F       ; {1026829}
}

code_0FAB0F {
    COP [9A] ( #$0010, &code_0FAB19, &code_0FAA97, &code_0FAB32 ) ; {1026831}
}

code_0FAB19 {
    COP [97]              ; {1026841}
    COP [80] ( #0E )      ; {1026843}
    COP [82]              ; {1026846}
    COP [80] ( #11 )      ; {1026848}
    COP [82]              ; {1026851}
    COP [85] ( @code_0FAB4B ) ; {1026853}
    COP [80] ( #37 )      ; {1026858}
    COP [82]              ; {1026861}
    BRL code_0FAA97       ; {1026863}
}

code_0FAB32 {
    COP [96]              ; {1026866}
    COP [80] ( #0E )      ; {1026868}
    COP [82]              ; {1026871}
    COP [80] ( #11 )      ; {1026873}
    COP [82]              ; {1026876}
    COP [85] ( @code_0FAB4B ) ; {1026878}
    COP [80] ( #37 )      ; {1026883}
    COP [82]              ; {1026886}
    BRL code_0FAA97       ; {1026888}
}

code_0FAB4B {
    COP [A1] ( #$FFFF, #$0002 ) ; {1026891}
    LDA #$0025            ; {1026897}
    BRA loc_0FAB75        ; {1026900}

  loc_0FAB56:
    COP [A1] ( #$0001, #$0002 ) ; {1026902}
    LDA #$0025            ; {1026908}
    BRA loc_0FAB75        ; {1026911}
}

code_0FAB61 {
    COP [A1] ( #$0004, #$FFF3 ) ; {1026913}
    LDA #$0026            ; {1026919}
    BRA loc_0FAB75        ; {1026922}
}

code_0FAB6C {
    COP [A1] ( #$FFFD, #$0002 ) ; {1026924}
    LDA #$0027            ; {1026930}

  loc_0FAB75:
    STA $001E, X          ; {1026933}
    STZ $0020, X          ; {1026936}
    LDA #$000C            ; {1026939}
    STA $002A, X          ; {1026942}
    LDA #$0200            ; {1026945}
    STA $0016, X          ; {1026948}
    COP [A3]              ; {1026951}
    COP [A2] ( #30 )      ; {1026953}
    BRK #$5B              ; {1026956}
    COP [91]              ; {1026958}
    COP [83]              ; {1026960}
    COP [80] ( #24 )      ; {1026962}
    COP [82]              ; {1026965}
    COP [86]              ; {1026967}
    RTL                   ; {1026969}
}

code_0FAB9A {
    LDA $0016, X          ; {1026970}
    BIT #$8000            ; {1026973}
    BEQ loc_0FABA8        ; {1026976}
    COP [1B] ( &code_0FAB9A, #$0010 ) ; {1026978}

  loc_0FABA8:
    COP [0C] ( #00, #05, &code_0FABB5 ) ; {1026984}
    COP [80] ( #1B )      ; {1026990}
    COP [82]              ; {1026993}
    BRA code_0FAB9A       ; {1026995}
}

code_0FABB5 {
    COP [9A] ( #$0010, &code_0FABBF, &code_0FABFB, &code_0FABC9 ) ; {1026997}
}

code_0FABBF {
    COP [9B] ( #$0010, &code_0FABE7, &code_0FAC1F, &code_0FABF1 ) ; {1027007}
}

code_0FABC9 {
    COP [9B] ( #$0010, &code_0FABD3, &code_0FAC15, &code_0FABDD ) ; {1027017}
}

code_0FABD3 {
    COP [96]              ; {1027027}
    COP [81] ( #1E, #10 ) ; {1027029}
    COP [83]              ; {1027033}
    BRA loc_0FAC29        ; {1027035}
}

code_0FABDD {
    COP [96]              ; {1027037}
    COP [81] ( #1D, #10 ) ; {1027039}
    COP [83]              ; {1027043}
    BRA loc_0FAC29        ; {1027045}
}

code_0FABE7 {
    COP [97]              ; {1027047}
    COP [81] ( #1E, #10 ) ; {1027049}
    COP [83]              ; {1027053}
    BRA loc_0FAC29        ; {1027055}
}

code_0FABF1 {
    COP [97]              ; {1027057}
    COP [81] ( #1D, #10 ) ; {1027059}
    COP [83]              ; {1027063}
    BRA loc_0FAC29        ; {1027065}
}

code_0FABFB {
    COP [9B] ( #$0000, &code_0FAC0D, &code_0FAC0D, &code_0FAC05 ) ; {1027067}
}

code_0FAC05 {
    COP [81] ( #34, #10 ) ; {1027077}
    COP [83]              ; {1027081}
    BRA loc_0FAC29        ; {1027083}
}

code_0FAC0D {
    COP [81] ( #1A, #10 ) ; {1027085}
    COP [83]              ; {1027089}
    BRA loc_0FAC29        ; {1027091}
}

code_0FAC15 {
    COP [96]              ; {1027093}
    COP [81] ( #1C, #10 ) ; {1027095}
    COP [83]              ; {1027099}
    BRA loc_0FAC29        ; {1027101}
}

code_0FAC1F {
    COP [97]              ; {1027103}
    COP [81] ( #1C, #10 ) ; {1027105}
    COP [83]              ; {1027109}
    BRA loc_0FAC29        ; {1027111}

  loc_0FAC29:
    COP [80] ( #1B )      ; {1027113}
    COP [82]              ; {1027116}
    BRL code_0FAB9A       ; {1027118}
}

code_0FAC31 {
    LDA $0016, X          ; {1027121}
    BIT #$8000            ; {1027124}
    BEQ loc_0FAC3F        ; {1027127}

  code_0FAC39:
    COP [1B] ( &code_0FAC31, #$0010 ) ; {1027129}

  loc_0FAC3F:
    COP [1F]              ; {1027135}
    LDA $0302             ; {1027137}
    AND #$0003            ; {1027140}
    BEQ loc_0FAC52        ; {1027143}
    DEC                   ; {1027145}
    BEQ loc_0FAC5B        ; {1027146}
    DEC                   ; {1027148}
    BEQ loc_0FAC64        ; {1027149}
    DEC                   ; {1027151}
    BEQ loc_0FAC6F        ; {1027152}

  loc_0FAC52:
    COP [9D] ( #14 )      ; {1027154}
    COP [9E] ( &code_0FAC39 ) ; {1027157}

  loc_0FAC59:
    BRA code_0FAC31       ; {1027161}

  loc_0FAC5B:
    COP [9D] ( #12 )      ; {1027163}
    COP [9E] ( &code_0FAC39 ) ; {1027166}

  loc_0FAC62:
    BRA code_0FAC31       ; {1027170}

  loc_0FAC64:
    COP [96]              ; {1027172}
    COP [9D] ( #16 )      ; {1027174}
    COP [9E] ( &code_0FAC39 ) ; {1027177}

  loc_0FAC6D:
    BRA code_0FAC31       ; {1027181}

  loc_0FAC6F:
    COP [97]              ; {1027183}
    COP [9D] ( #16 )      ; {1027185}
    COP [9E] ( &code_0FAC39 ) ; {1027188}

  loc_0FAC78:
    BRA code_0FAC31       ; {1027192}
}

code_0FAC7A {
    LDA $0016, X          ; {1027194}
    BIT #$8000            ; {1027197}
    BEQ loc_0FAC88        ; {1027200}
    COP [1B] ( &code_0FAC7A, #$0020 ) ; {1027202}

  loc_0FAC88:
    COP [0C] ( #00, #05, &code_0FAC95 ) ; {1027208}
    COP [80] ( #2E )      ; {1027214}
    COP [82]              ; {1027217}
    BRA code_0FAC7A       ; {1027219}
}

code_0FAC95 {
    COP [80] ( #2F )      ; {1027221}
    COP [82]              ; {1027224}

  loc_0FAC9A:
    COP [9C] ( &code_0FACA0, &code_0FACC0 ) ; {1027226}
}

code_0FACA0 {
    COP [9A] ( #$0000, &code_0FACAA, &code_0FACDC, &code_0FACB5 ) ; {1027232}
}

code_0FACAA {
    COP [97]              ; {1027242}
    COP [9D] ( #33 )      ; {1027244}
    COP [9E] ( &code_0FACC0 ) ; {1027247}

  loc_0FACB3:
    BRA code_0FACDC       ; {1027251}
}

code_0FACB5 {
    COP [96]              ; {1027253}
    COP [9D] ( #33 )      ; {1027255}
    COP [9E] ( &code_0FACC0 ) ; {1027258}

  loc_0FACBE:
    BRA code_0FACDC       ; {1027262}
}

code_0FACC0 {
    COP [9B] ( #$0000, &code_0FACCA, &code_0FACDC, &code_0FACD3 ) ; {1027264}
}

code_0FACCA {
    COP [9D] ( #32 )      ; {1027274}
    COP [9E] ( &code_0FACA0 ) ; {1027277}

  loc_0FACD1:
    BRA code_0FACDC       ; {1027281}
}

code_0FACD3 {
    COP [9D] ( #31 )      ; {1027283}
    COP [9E] ( &code_0FACA0 ) ; {1027286}

  loc_0FACDA:
    BRA code_0FACDC       ; {1027290}
}

code_0FACDC {
    LDA $0016, X          ; {1027292}
    BIT #$8000            ; {1027295}
    BNE loc_0FACEB        ; {1027298}
    COP [80] ( #30 )      ; {1027300}
    COP [82]              ; {1027303}
    BRA loc_0FAC9A        ; {1027305}

  loc_0FACEB:
    COP [80] ( #2E )      ; {1027307}
    COP [82]              ; {1027310}
    BRA code_0FAC7A       ; {1027312}
}

code_0FACF2 {
    LDA $0016, X          ; {1027314}
    BIT #$8000            ; {1027317}
    BEQ loc_0FAD00        ; {1027320}
    COP [1B] ( &code_0FACF2, #$0008 ) ; {1027322}

  loc_0FAD00:
    COP [81] ( #18, #08 ) ; {1027328}
    COP [83]              ; {1027332}
    COP [80] ( #19 )      ; {1027334}
    COP [82]              ; {1027337}
    COP [B0] ( @code_0FAD14, #$0200 ) ; {1027339}
    BRA code_0FACF2       ; {1027346}
}

code_0FAD14 {
    COP [A3]              ; {1027348}
    COP [A2] ( #30 )      ; {1027350}
    BRK #$64              ; {1027353}
    LDY #$001F            ; {1027355}
    SEP #$20              ; {1027358}
    LDA #$^chunk_000000.code_002D67 ; {1027360}
    PHA                   ; {1027362}
    REP #$20              ; {1027363}
    LDA #$&chunk_000000.code_002D67-1 ; {1027365}
    PHA                   ; {1027368}
    RTL                   ; {1027369}
}

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

code_0FAEE5 {
    LDA $001A, X          ; {1027813}
    ORA #$0400            ; {1027816}
    STA $001A, X          ; {1027819}
    COP [A5] ( &code_0FAF32, &code_0FAF20, &code_0FAEF8, &code_0FAF0E ) ; {1027822}
}

code_0FAEF8 {
    COP [21] ( &code_0FAEFE ) ; {1027832}
    BRA loc_0FAF18        ; {1027836}
}

code_0FAEFE {
    COP [24] ( &code_0FAF32 ) ; {1027838}

  loc_0FAF02:
    COP [96]              ; {1027842}
    COP [81] ( #21, #02 ) ; {1027844}
    COP [83]              ; {1027848}
    COP [97]              ; {1027850}
    BRA code_0FAEF8       ; {1027852}
}

code_0FAF0E {
    COP [23] ( &code_0FAF14 ) ; {1027854}
    BRA loc_0FAF2A        ; {1027858}
}

code_0FAF14 {
    COP [21] ( &code_0FAEF8 ) ; {1027860}

  loc_0FAF18:
    COP [81] ( #20, #02 ) ; {1027864}
    COP [83]              ; {1027868}
    BRA code_0FAF0E       ; {1027870}
}

code_0FAF20 {
    COP [22] ( &code_0FAF26 ) ; {1027872}
    BRA loc_0FAF3C        ; {1027876}
}

code_0FAF26 {
    COP [23] ( &code_0FAF0E ) ; {1027878}

  loc_0FAF2A:
    COP [81] ( #21, #02 ) ; {1027882}
    COP [83]              ; {1027886}
    BRA code_0FAF20       ; {1027888}
}

code_0FAF32 {
    COP [24] ( &code_0FAF38 ) ; {1027890}
    BRA loc_0FAF02        ; {1027894}
}

code_0FAF38 {
    COP [22] ( &code_0FAF20 ) ; {1027896}

  loc_0FAF3C:
    COP [81] ( #1F, #02 ) ; {1027900}
    COP [83]              ; {1027904}
    BRA code_0FAF32       ; {1027906}
}

code_0FAF44 {
    COP [A2] ( #30 )      ; {1027908}
    COP [A3]              ; {1027911}

  code_0FAF49:
    LDA $0016, X          ; {1027913}
    BIT #$8000            ; {1027916}
    BEQ loc_0FAF57        ; {1027919}
    COP [1B] ( &code_0FAF49, #$0010 ) ; {1027921}

  loc_0FAF57:
    COP [9C] ( &code_0FAF5D, &code_0FAF85 ) ; {1027927}
}

code_0FAF5D {
    COP [9A] ( #$0010, &code_0FAF67, &code_0FAF74, &code_0FAF74 ) ; {1027933}
}

code_0FAF67 {
    COP [81] ( #1C, #02 ) ; {1027943}
    COP [83]              ; {1027947}
    COP [80] ( #1D )      ; {1027949}
    COP [82]              ; {1027952}
    BRA loc_0FAF57        ; {1027954}
}

code_0FAF74 {
    COP [96]              ; {1027956}
    COP [81] ( #1C, #02 ) ; {1027958}
    COP [83]              ; {1027962}
    COP [80] ( #1D )      ; {1027964}
    COP [82]              ; {1027967}
    COP [97]              ; {1027969}
    BRA loc_0FAF57        ; {1027971}
}

code_0FAF85 {
    COP [9B] ( #$0010, &code_0FAF8F, &code_0FAF9C, &code_0FAF9C ) ; {1027973}
}

code_0FAF8F {
    COP [81] ( #1A, #02 ) ; {1027983}
    COP [83]              ; {1027987}
    COP [80] ( #1B )      ; {1027989}
    COP [82]              ; {1027992}
    BRA loc_0FAF57        ; {1027994}
}

code_0FAF9C {
    COP [96]              ; {1027996}
    COP [81] ( #18, #02 ) ; {1027998}
    COP [83]              ; {1028002}
    COP [80] ( #19 )      ; {1028004}
    COP [82]              ; {1028007}
    COP [97]              ; {1028009}
    BRA loc_0FAF57        ; {1028011}
}

code_0FAFAD {
    LDA $0016, X          ; {1028013}
    BIT #$8000            ; {1028016}
    BEQ loc_0FAFBB        ; {1028019}
    COP [1B] ( &code_0FAFAD, #$0008 ) ; {1028021}

  loc_0FAFBB:
    COP [97]              ; {1028027}
    COP [80] ( #22 )      ; {1028029}
    COP [82]              ; {1028032}
    COP [9B] ( #$0010, &code_0FAFCC, &code_0FAFD6, &code_0FAFCC ) ; {1028034}
}

code_0FAFCC {
    COP [9A] ( #$0010, &code_0FAFAD, &code_0FAFF6, &code_0FAFAD ) ; {1028044}
}

code_0FAFD6 {
    COP [9A] ( #$0000, &code_0FAFE0, &code_0FAFEA, &code_0FAFEA ) ; {1028054}
}

code_0FAFE0 {
    COP [80] ( #23 )      ; {1028064}
    COP [82]              ; {1028067}
    LDA #$0029            ; {1028069}
    BRA loc_0FB014        ; {1028072}
}

code_0FAFEA {
    COP [80] ( #23 )      ; {1028074}
    COP [82]              ; {1028077}
    COP [96]              ; {1028079}
    LDA #$0029            ; {1028081}
    BRA loc_0FB014        ; {1028084}
}

code_0FAFF6 {
    COP [9B] ( #$0000, &code_0FB000, &code_0FB00A, &code_0FB00A ) ; {1028086}
}

code_0FB000 {
    COP [80] ( #23 )      ; {1028096}
    COP [82]              ; {1028099}
    LDA #$0028            ; {1028101}
    BRA loc_0FB014        ; {1028104}
}

code_0FB00A {
    COP [80] ( #23 )      ; {1028106}
    COP [82]              ; {1028109}
    LDA #$0027            ; {1028111}
    BRA loc_0FB014        ; {1028114}

  loc_0FB014:
    PHA                   ; {1028116}
    COP [84] ( @code_0FB02F ) ; {1028117}
    PLA                   ; {1028122}
    STA $001E, Y          ; {1028123}
    LDA #$0000            ; {1028126}
    STA $0020, Y          ; {1028129}
    COP [97]              ; {1028132}
    COP [81] ( #22, #04 ) ; {1028134}
    COP [83]              ; {1028138}
    BRL code_0FAFAD       ; {1028140}
}

code_0FB02F {
    LDA #$0200            ; {1028143}
    STA $0016, X          ; {1028146}
    COP [A2] ( #30 )      ; {1028149}
    COP [A3]              ; {1028152}
    COP [A0] ( #$FFFC )   ; {1028154}
    BRK #$64              ; {1028158}
    COP [91]              ; {1028160}

  loc_0FB042:
    COP [82]              ; {1028162}
    COP [1C] ( #$8000, &code_0FB04C ) ; {1028164}
    BRA loc_0FB042        ; {1028170}
}

code_0FB04C {
    COP [86]              ; {1028172}
    RTL                   ; {1028174}
}

code_0FB04F {
    LDA $0016, X          ; {1028175}
    BIT #$8000            ; {1028178}
    BEQ loc_0FB05D        ; {1028181}

  loc_0FB057:
    COP [1B] ( &code_0FB04F, #$0010 ) ; {1028183}

  loc_0FB05D:
    COP [0C] ( #00, #05, &code_0FB065 ) ; {1028189}
    BRA loc_0FB057        ; {1028195}
}

code_0FB065 {
    COP [80] ( #02 )      ; {1028197}
    COP [82]              ; {1028200}
    COP [81] ( #03, #02 ) ; {1028202}
    COP [83]              ; {1028206}
    COP [80] ( #01 )      ; {1028208}
    COP [82]              ; {1028211}

  loc_0FB075:
    COP [0C] ( #00, #05, &code_0FB087 ) ; {1028213}
    COP [80] ( #02 )      ; {1028219}
    COP [82]              ; {1028222}
    COP [80] ( #00 )      ; {1028224}
    COP [82]              ; {1028227}
    BRA loc_0FB057        ; {1028229}
}

code_0FB087 {
    COP [9A] ( #$0010, &code_0FB091, &code_0FB0AB, &code_0FB09E ) ; {1028231}
}

code_0FB091 {
    COP [23] ( &code_0FB0CF ) ; {1028241}
    COP [97]              ; {1028245}
    COP [80] ( #06 )      ; {1028247}
    COP [82]              ; {1028250}
    BRA code_0FB0AB       ; {1028252}
}

code_0FB09E {
    COP [24] ( &code_0FB0CF ) ; {1028254}
    COP [96]              ; {1028258}
    COP [80] ( #06 )      ; {1028260}
    COP [82]              ; {1028263}
    BRA code_0FB0AB       ; {1028265}
}

code_0FB0AB {
    COP [9B] ( #$0010, &code_0FB0B5, &code_0FB0CF, &code_0FB0C2 ) ; {1028267}
}

code_0FB0B5 {
    COP [21] ( &code_0FB0CF ) ; {1028277}
    COP [97]              ; {1028281}
    COP [80] ( #05 )      ; {1028283}
    COP [82]              ; {1028286}
    BRA code_0FB0CF       ; {1028288}
}

code_0FB0C2 {
    COP [22] ( &code_0FB0CF ) ; {1028290}
    COP [97]              ; {1028294}
    COP [80] ( #04 )      ; {1028296}
    COP [82]              ; {1028299}
    BRA code_0FB0CF       ; {1028301}
}

code_0FB0CF {
    COP [80] ( #01 )      ; {1028303}
    COP [82]              ; {1028306}
    BRA loc_0FB075        ; {1028308}
}

code_0FB0D6 {
    COP [A2] ( #00 )      ; {1028310}
    COP [A4]              ; {1028313}
    COP [A5] ( &code_0FB0E5, &code_0FB0ED, &code_0FB0ED, &code_0FB0ED ) ; {1028315}
}

code_0FB0E5 {
    COP [81] ( #2C, #FF ) ; {1028325}
    COP [83]              ; {1028329}
    BRA code_0FB0E5       ; {1028331}
}

code_0FB0ED {
    COP [81] ( #2D, #FF ) ; {1028333}
    COP [83]              ; {1028337}
    BRA code_0FB0ED       ; {1028339}
}

code_0FB0F5 {
    COP [A5] ( &code_0FB0FF, &code_0FB172, &code_0FB1E5, &code_0FB25A ) ; {1028341}
}

code_0FB0FF {
    LDA $0016, X          ; {1028351}
    BIT #$8000            ; {1028354}
    BEQ loc_0FB10D        ; {1028357}

  code_0FB107:
    COP [1B] ( &code_0FB0FF, #$0008 ) ; {1028359}

  loc_0FB10D:
    COP [9A] ( #$0030, &code_0FB107, &code_0FB117, &code_0FB107 ) ; {1028365}
}

code_0FB117 {
    COP [9B] ( #$0000, &code_0FB107, &code_0FB107, &code_0FB121 ) ; {1028375}
}

code_0FB121 {
    LDA $0016, X          ; {1028385}
    AND #$DFFF            ; {1028388}
    STA $0016, X          ; {1028391}
    COP [80] ( #03 )      ; {1028394}
    COP [82]              ; {1028397}
    LDA $0016, X          ; {1028399}
    AND #$FDFF            ; {1028402}
    STA $0016, X          ; {1028405}
    COP [80] ( #00 )      ; {1028408}
    COP [82]              ; {1028411}
    COP [B2] ( &code_0FB2DB, #1F, #$0000, #$000C, #$0200 ) ; {1028413}
    COP [80] ( #09 )      ; {1028424}
    COP [82]              ; {1028427}
    COP [80] ( #00 )      ; {1028429}
    COP [82]              ; {1028432}
    LDA $0016, X          ; {1028434}
    ORA #$0200            ; {1028437}
    STA $0016, X          ; {1028440}
    COP [80] ( #04 )      ; {1028443}
    COP [82]              ; {1028446}
    LDA $0016, X          ; {1028448}
    ORA #$2000            ; {1028451}
    STA $0016, X          ; {1028454}
    JSR $&code_0FB2CD     ; {1028457}
    COP [1B] ( &code_0FB0FF, #$0078 ) ; {1028460}
}

code_0FB172 {
    LDA $0016, X          ; {1028466}
    BIT #$8000            ; {1028469}
    BEQ loc_0FB180        ; {1028472}

  code_0FB17A:
    COP [1B] ( &code_0FB172, #$0008 ) ; {1028474}

  loc_0FB180:
    COP [9B] ( #$0030, &code_0FB17A, &code_0FB18A, &code_0FB17A ) ; {1028480}
}

code_0FB18A {
    COP [9A] ( #$0000, &code_0FB194, &code_0FB17A, &code_0FB17A ) ; {1028490}
}

code_0FB194 {
    LDA $0016, X          ; {1028500}
    AND #$DFFF            ; {1028503}
    STA $0016, X          ; {1028506}
    COP [80] ( #07 )      ; {1028509}
    COP [82]              ; {1028512}
    LDA $0016, X          ; {1028514}
    AND #$FDFF            ; {1028517}
    STA $0016, X          ; {1028520}
    COP [80] ( #02 )      ; {1028523}
    COP [82]              ; {1028526}
    COP [B2] ( &code_0FB2E8, #1F, #$FFF0, #$0000, #$0200 ) ; {1028528}
    COP [80] ( #0B )      ; {1028539}
    COP [82]              ; {1028542}
    COP [80] ( #02 )      ; {1028544}
    COP [82]              ; {1028547}
    LDA $0016, X          ; {1028549}
    ORA #$0200            ; {1028552}
    STA $0016, X          ; {1028555}
    COP [80] ( #08 )      ; {1028558}
    COP [82]              ; {1028561}
    LDA $0016, X          ; {1028563}
    ORA #$2000            ; {1028566}
    STA $0016, X          ; {1028569}
    JSR $&code_0FB2CD     ; {1028572}
    COP [1B] ( &code_0FB172, #$0078 ) ; {1028575}
}

code_0FB1E5 {
    LDA $0016, X          ; {1028581}
    BIT #$8000            ; {1028584}
    BEQ loc_0FB1F3        ; {1028587}

  code_0FB1ED:
    COP [1B] ( &code_0FB1E5, #$0008 ) ; {1028589}

  loc_0FB1F3:
    COP [9B] ( #$0030, &code_0FB1ED, &code_0FB1FD, &code_0FB1ED ) ; {1028595}
}

code_0FB1FD {
    COP [9A] ( #$0000, &code_0FB1ED, &code_0FB1ED, &code_0FB207 ) ; {1028605}
}

code_0FB207 {
    COP [96]              ; {1028615}
    LDA $0016, X          ; {1028617}
    AND #$DFFF            ; {1028620}
    STA $0016, X          ; {1028623}
    COP [80] ( #07 )      ; {1028626}
    COP [82]              ; {1028629}
    LDA $0016, X          ; {1028631}
    AND #$FDFF            ; {1028634}
    STA $0016, X          ; {1028637}
    COP [80] ( #02 )      ; {1028640}
    COP [82]              ; {1028643}
    COP [B2] ( &code_0FB2E8, #1F, #$0020, #$0000, #$0200 ) ; {1028645}
    COP [80] ( #0B )      ; {1028656}
    COP [82]              ; {1028659}
    COP [80] ( #02 )      ; {1028661}
    COP [82]              ; {1028664}
    LDA $0016, X          ; {1028666}
    ORA #$0200            ; {1028669}
    STA $0016, X          ; {1028672}
    COP [80] ( #08 )      ; {1028675}
    COP [82]              ; {1028678}
    LDA $0016, X          ; {1028680}
    ORA #$2000            ; {1028683}
    STA $0016, X          ; {1028686}
    JSR $&code_0FB2CD     ; {1028689}
    COP [1B] ( &code_0FB1E5, #$0078 ) ; {1028692}
}

code_0FB25A {
    LDA $0016, X          ; {1028698}
    BIT #$8000            ; {1028701}
    BEQ loc_0FB268        ; {1028704}

  code_0FB262:
    COP [1B] ( &code_0FB25A, #$0008 ) ; {1028706}

  loc_0FB268:
    COP [9A] ( #$0030, &code_0FB262, &code_0FB272, &code_0FB262 ) ; {1028712}
}

code_0FB272 {
    COP [9B] ( #$0000, &code_0FB27C, &code_0FB262, &code_0FB262 ) ; {1028722}
}

code_0FB27C {
    LDA $0016, X          ; {1028732}
    AND #$DFFF            ; {1028735}
    STA $0016, X          ; {1028738}
    COP [80] ( #05 )      ; {1028741}
    COP [82]              ; {1028744}
    LDA $0016, X          ; {1028746}
    AND #$FDFF            ; {1028749}
    STA $0016, X          ; {1028752}
    COP [80] ( #01 )      ; {1028755}
    COP [82]              ; {1028758}
    COP [B2] ( &code_0FB2F5, #1F, #$0000, #$FFE0, #$0200 ) ; {1028760}
    COP [80] ( #0A )      ; {1028771}
    COP [82]              ; {1028774}
    COP [80] ( #01 )      ; {1028776}
    COP [82]              ; {1028779}
    LDA $0016, X          ; {1028781}
    ORA #$0200            ; {1028784}
    STA $0016, X          ; {1028787}
    COP [80] ( #06 )      ; {1028790}
    COP [82]              ; {1028793}
    LDA $0016, X          ; {1028795}
    ORA #$2000            ; {1028798}
    STA $0016, X          ; {1028801}
    JSR $&code_0FB2CD     ; {1028804}
    COP [1B] ( &code_0FB25A, #$0078 ) ; {1028807}
}

code_0FB2CD {
    SEP #$20              ; {1028813}
    LDY $0038, X          ; {1028815}
    LDA $&meta_tables_008000+2, Y ; {1028818}
    STA $0025, X          ; {1028821}
    REP #$20              ; {1028824}
    RTS                   ; {1028826}
}

code_0FB2DB {
    COP [A3]              ; {1028827}
    BRK #$5B              ; {1028829}
    COP [81] ( #16, #08 ) ; {1028831}
    COP [83]              ; {1028835}
    COP [86]              ; {1028837}
    RTL                   ; {1028839}
}

code_0FB2E8 {
    COP [A3]              ; {1028840}
    BRK #$5B              ; {1028842}
    COP [81] ( #18, #08 ) ; {1028844}
    COP [83]              ; {1028848}
    COP [86]              ; {1028850}
    RTL                   ; {1028852}
}

code_0FB2F5 {
    COP [A3]              ; {1028853}
    BRK #$5B              ; {1028855}
    COP [81] ( #17, #08 ) ; {1028857}
    COP [83]              ; {1028861}
    COP [86]              ; {1028863}
    RTL                   ; {1028865}
}

code_0FB302 {
    LDA $0016, X          ; {1028866}
    BIT #$8000            ; {1028869}
    BEQ loc_0FB310        ; {1028872}

  code_0FB30A:
    COP [1B] ( &code_0FB302, #$0002 ) ; {1028874}

  loc_0FB310:
    COP [9A] ( #$0010, &code_0FB31A, &code_0FB32C, &code_0FB323 ) ; {1028880}
}

code_0FB31A {
    COP [97]              ; {1028890}
    COP [80] ( #26 )      ; {1028892}
    COP [82]              ; {1028895}
    BRA code_0FB32C       ; {1028897}
}

code_0FB323 {
    COP [96]              ; {1028899}
    COP [80] ( #26 )      ; {1028901}
    COP [82]              ; {1028904}
    BRA code_0FB32C       ; {1028906}
}

code_0FB32C {
    COP [9B] ( #$0010, &code_0FB336, &code_0FB30A, &code_0FB33F ) ; {1028908}
}

code_0FB336 {
    COP [97]              ; {1028918}
    COP [80] ( #25 )      ; {1028920}
    COP [82]              ; {1028923}
    BRA code_0FB302       ; {1028925}
}

code_0FB33F {
    COP [97]              ; {1028927}
    COP [80] ( #24 )      ; {1028929}
    COP [82]              ; {1028932}
    BRA code_0FB302       ; {1028934}
}

code_0FB348 {
    LDA $0016, X          ; {1028936}
    BIT #$8000            ; {1028939}
    BEQ loc_0FB356        ; {1028942}

  code_0FB350:
    COP [1B] ( &code_0FB348, #$0020 ) ; {1028944}

  loc_0FB356:
    COP [1F]              ; {1028950}
    LDA $0302             ; {1028952}
    AND #$0003            ; {1028955}
    BEQ loc_0FB369        ; {1028958}
    DEC                   ; {1028960}
    BEQ loc_0FB372        ; {1028961}
    DEC                   ; {1028963}
    BEQ loc_0FB37B        ; {1028964}
    DEC                   ; {1028966}
    BEQ loc_0FB386        ; {1028967}

  loc_0FB369:
    COP [9D] ( #0E )      ; {1028969}
    COP [9E] ( &code_0FB350 ) ; {1028972}

  loc_0FB370:
    BRA loc_0FB391        ; {1028976}

  loc_0FB372:
    COP [9D] ( #0D )      ; {1028978}
    COP [9E] ( &code_0FB350 ) ; {1028981}

  loc_0FB379:
    BRA loc_0FB391        ; {1028985}

  loc_0FB37B:
    COP [96]              ; {1028987}
    COP [9D] ( #0F )      ; {1028989}
    COP [9E] ( &code_0FB350 ) ; {1028992}

  loc_0FB384:
    BRA loc_0FB391        ; {1028996}

  loc_0FB386:
    COP [97]              ; {1028998}
    COP [9D] ( #0F )      ; {1029000}
    COP [9E] ( &code_0FB350 ) ; {1029003}

  loc_0FB38F:
    BRA loc_0FB391        ; {1029007}

  loc_0FB391:
    COP [9A] ( #$0010, &code_0FB3A5, &code_0FB39B, &code_0FB3AF ) ; {1029009}
}

code_0FB39B {
    COP [9B] ( #$0000, &code_0FB3B9, &code_0FB3C2, &code_0FB3C2 ) ; {1029019}
}

code_0FB3A5 {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3CB, &code_0FB348 ) ; {1029029}
}

code_0FB3AF {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3D4, &code_0FB348 ) ; {1029039}
}

code_0FB3B9 {
    COP [97]              ; {1029049}
    COP [85] ( @code_0FB3F6 ) ; {1029051}
    BRA loc_0FB3DB        ; {1029056}
}

code_0FB3C2 {
    COP [97]              ; {1029058}
    COP [85] ( @code_0FB406 ) ; {1029060}
    BRA loc_0FB3DB        ; {1029065}
}

code_0FB3CB {
    COP [97]              ; {1029067}
    COP [85] ( @code_0FB416 ) ; {1029069}
    BRA loc_0FB3DB        ; {1029074}
}

code_0FB3D4 {
    COP [96]              ; {1029076}
    COP [85] ( @code_0FB416 ) ; {1029078}

  loc_0FB3DB:
    LDA $0016, X          ; {1029083}
    ORA #$0200            ; {1029086}
    STA $0016, X          ; {1029089}
    COP [81] ( #0C, #02 ) ; {1029092}
    COP [83]              ; {1029096}
    LDA $0016, X          ; {1029098}
    AND #$FDFF            ; {1029101}
    STA $0016, X          ; {1029104}
    BRL code_0FB350       ; {1029107}
}

code_0FB3F6 {
    LDA #$0200            ; {1029110}
    STA $0016, X          ; {1029113}
    COP [A4]              ; {1029116}
    COP [80] ( #12 )      ; {1029118}
    COP [82]              ; {1029121}
    COP [86]              ; {1029123}
    RTL                   ; {1029125}
}

code_0FB406 {
    LDA #$0200            ; {1029126}
    STA $0016, X          ; {1029129}
    COP [A4]              ; {1029132}
    COP [80] ( #11 )      ; {1029134}
    COP [82]              ; {1029137}
    COP [86]              ; {1029139}
    RTL                   ; {1029141}
}

code_0FB416 {
    LDA #$0200            ; {1029142}
    STA $0016, X          ; {1029145}
    COP [A4]              ; {1029148}
    LDA $001C, X          ; {1029150}
    ASL                   ; {1029153}
    BPL loc_0FB42B        ; {1029154}
    COP [80] ( #27 )      ; {1029156}
    COP [82]              ; {1029159}
    BRA loc_0FB430        ; {1029161}

  loc_0FB42B:
    COP [80] ( #13 )      ; {1029163}
    COP [82]              ; {1029166}

  loc_0FB430:
    COP [86]              ; {1029168}
    RTL                   ; {1029170}
}

code_0FB433 {
    COP [15]              ; {1029171}

  code_0FB435:
    LDA $0016, X          ; {1029173}
    BIT #$8000            ; {1029176}
    BNE loc_0FB443        ; {1029179}
    COP [0C] ( #00, #01, &code_0FB449 ) ; {1029181}

  loc_0FB443:
    COP [1B] ( &code_0FB435, #$0010 ) ; {1029187}
}

code_0FB449 {
    COP [16]              ; {1029193}
    BRL loc_0FB4CE        ; {1029195}

  code_0FB44E:
    COP [1F]              ; {1029198}
    LDA $0302             ; {1029200}
    PHP                   ; {1029203}
    AND #$0030            ; {1029204}
    CLC                   ; {1029207}
    ADC #$0020            ; {1029208}
    PLP                   ; {1029211}
    BPL loc_0FB462        ; {1029212}
    EOR #$FFFF            ; {1029214}
    INC                   ; {1029217}

  loc_0FB462:
    CLC                   ; {1029218}
    ADC $0374             ; {1029219}
    AND #$FFF0            ; {1029222}
    CMP $0342             ; {1029225}
    BCS code_0FB4DE       ; {1029228}
    STA $0000, X          ; {1029230}
    COP [1F]              ; {1029233}
    LDA $0302             ; {1029235}
    PHP                   ; {1029238}
    AND #$0030            ; {1029239}
    CLC                   ; {1029242}
    ADC #$0020            ; {1029243}
    PLP                   ; {1029246}
    BPL loc_0FB485        ; {1029247}
    EOR #$FFFF            ; {1029249}
    INC                   ; {1029252}

  loc_0FB485:
    CLC                   ; {1029253}
    ADC $0376             ; {1029254}
    AND #$FFF0            ; {1029257}
    CMP $0344             ; {1029260}
    BCS code_0FB4DE       ; {1029263}
    STA $0002, X          ; {1029265}
    COP [28] ( &code_0FB4DE ) ; {1029268}
    LDA $0016, X          ; {1029272}
    AND #$DFFF            ; {1029275}
    STA $0016, X          ; {1029278}
    BRK #$5F              ; {1029281}
    COP [80] ( #10 )      ; {1029283}
    COP [82]              ; {1029286}
    LDA $0016, X          ; {1029288}
    AND #$FDFF            ; {1029291}
    STA $0016, X          ; {1029294}
    COP [80] ( #1C )      ; {1029297}
    COP [82]              ; {1029300}
    COP [80] ( #1D )      ; {1029302}
    COP [82]              ; {1029305}
    COP [85] ( @code_0FB4E4 ) ; {1029307}
    COP [80] ( #1C )      ; {1029312}
    COP [82]              ; {1029315}
    LDA $0016, X          ; {1029317}
    ORA #$0200            ; {1029320}
    STA $0016, X          ; {1029323}

  loc_0FB4CE:
    BRK #$5F              ; {1029326}
    COP [80] ( #10 )      ; {1029328}
    COP [82]              ; {1029331}
    LDA $0016, X          ; {1029333}
    ORA #$2000            ; {1029336}
    STA $0016, X          ; {1029339}
}

code_0FB4DE {
    COP [1B] ( &code_0FB44E, #$0020 ) ; {1029342}
}

code_0FB4E4 {
    LDA #$0200            ; {1029348}
    STA $0016, X          ; {1029351}
    COP [A3]              ; {1029354}
    COP [A0] ( #$FFF4 )   ; {1029356}
    BRK #$5B              ; {1029360}
    COP [9A] ( #$0018, &code_0FB506, &code_0FB4FC, &code_0FB510 ) ; {1029362}
}

code_0FB4FC {
    COP [9B] ( #$0000, &code_0FB558, &code_0FB55E, &code_0FB532 ) ; {1029372}
}

code_0FB506 {
    COP [9B] ( #$0018, &code_0FB51A, &code_0FB522, &code_0FB52A ) ; {1029382}
}

code_0FB510 {
    COP [9B] ( #$0018, &code_0FB54E, &code_0FB544, &code_0FB53A ) ; {1029392}
}

code_0FB51A {
    COP [81] ( #22, #10 ) ; {1029402}
    COP [83]              ; {1029406}
    BRA code_0FB55E       ; {1029408}
}

code_0FB522 {
    COP [81] ( #20, #10 ) ; {1029410}
    COP [83]              ; {1029414}
    BRA code_0FB55E       ; {1029416}
}

code_0FB52A {
    COP [81] ( #21, #10 ) ; {1029418}
    COP [83]              ; {1029422}
    BRA code_0FB55E       ; {1029424}
}

code_0FB532 {
    COP [81] ( #1E, #10 ) ; {1029426}
    COP [83]              ; {1029430}
    BRA code_0FB55E       ; {1029432}
}

code_0FB53A {
    COP [96]              ; {1029434}
    COP [81] ( #21, #10 ) ; {1029436}
    COP [83]              ; {1029440}
    BRA code_0FB55E       ; {1029442}
}

code_0FB544 {
    COP [96]              ; {1029444}
    COP [81] ( #20, #10 ) ; {1029446}
    COP [83]              ; {1029450}
    BRA code_0FB55E       ; {1029452}
}

code_0FB54E {
    COP [96]              ; {1029454}
    COP [81] ( #22, #10 ) ; {1029456}
    COP [83]              ; {1029460}
    BRA code_0FB55E       ; {1029462}
}

code_0FB558 {
    COP [81] ( #1F, #10 ) ; {1029464}
    COP [83]              ; {1029468}
}

code_0FB55E {
    COP [86]              ; {1029470}
    RTL                   ; {1029472}
}

code_0FB561 {
    COP [AD] ( #10 )      ; {1029473}
    COP [81] ( #14, #02 ) ; {1029476}
    COP [83]              ; {1029480}
    COP [B2] ( &code_0FB57F, #1F, #$0008, #$FFFC, #$0000 ) ; {1029482}

  loc_0FB575:
    COP [AD] ( #08 )      ; {1029493}
    COP [80] ( #14 )      ; {1029496}
    COP [82]              ; {1029499}
    BRA loc_0FB575        ; {1029501}
}

code_0FB57F {
    COP [A3]              ; {1029503}
    COP [81] ( #15, #02 ) ; {1029505}
    COP [83]              ; {1029509}

  loc_0FB587:
    COP [85] ( @chunk_000000.code_002D96 ) ; {1029511}
    CPY #$06AA            ; {1029516}
    BEQ loc_0FB599        ; {1029519}
    COP [81] ( #15, #02 ) ; {1029521}
    COP [83]              ; {1029525}
    BRA loc_0FB587        ; {1029527}

  loc_0FB599:
    COP [86]              ; {1029529}
    RTL                   ; {1029531}
}

code_0FB59C {
    LDA $001A, X          ; {1029532}
    ORA #$0200            ; {1029535}
    STA $001A, X          ; {1029538}

  loc_0FB5A5:
    COP [03] ( #04 )      ; {1029541}
    COP [80] ( #28 )      ; {1029544}
    COP [82]              ; {1029547}
    COP [80] ( #2C )      ; {1029549}
    COP [82]              ; {1029552}
    COP [04]              ; {1029554}
    COP [03] ( #04 )      ; {1029556}
    COP [80] ( #28 )      ; {1029559}
    COP [82]              ; {1029562}
    COP [80] ( #29 )      ; {1029564}
    COP [82]              ; {1029567}
    COP [04]              ; {1029569}
    COP [03] ( #04 )      ; {1029571}
    COP [80] ( #28 )      ; {1029574}
    COP [82]              ; {1029577}
    COP [80] ( #2B )      ; {1029579}
    COP [82]              ; {1029582}
    COP [04]              ; {1029584}
    COP [03] ( #04 )      ; {1029586}
    COP [80] ( #28 )      ; {1029589}
    COP [82]              ; {1029592}
    COP [80] ( #2A )      ; {1029594}
    COP [82]              ; {1029597}
    COP [04]              ; {1029599}
    BRA loc_0FB5A5        ; {1029601}
}

code_0FB5E3 {
    LDA $001A, X          ; {1029603}
    ORA #$0800            ; {1029606}
    STA $001A, X          ; {1029609}

  code_0FB5EC:
    LDA $0016, X          ; {1029612}
    BIT #$8000            ; {1029615}
    BEQ loc_0FB5FA        ; {1029618}
    COP [1B] ( &code_0FB5EC, #$0010 ) ; {1029620}

  loc_0FB5FA:
    COP [A5] ( &code_0FB604, &code_0FB623, &code_0FB642, &code_0FB661 ) ; {1029626}
}

code_0FB604 {
    COP [97]              ; {1029636}
    COP [80] ( #0F )      ; {1029638}
    COP [82]              ; {1029641}

  loc_0FB60B:
    COP [AE] ( #$FFF0, #$FFF0, &code_0FB661 ) ; {1029643}
    COP [AE] ( #$0000, #$FFE0, &code_0FB623 ) ; {1029651}
    COP [81] ( #11, #04 ) ; {1029659}
    COP [83]              ; {1029663}
    BRA loc_0FB60B        ; {1029665}
}

code_0FB623 {
    COP [97]              ; {1029667}
    COP [80] ( #0F )      ; {1029669}
    COP [82]              ; {1029672}

  loc_0FB62A:
    COP [AE] ( #$FFF0, #$0000, &code_0FB642 ) ; {1029674}
    COP [AE] ( #$0000, #$0010, &code_0FB604 ) ; {1029682}
    COP [81] ( #10, #04 ) ; {1029690}
    COP [83]              ; {1029694}
    BRA loc_0FB62A        ; {1029696}
}

code_0FB642 {
    COP [96]              ; {1029698}
    COP [80] ( #0F )      ; {1029700}
    COP [82]              ; {1029703}

  loc_0FB649:
    COP [AE] ( #$0020, #$0000, &code_0FB623 ) ; {1029705}
    COP [AE] ( #$0010, #$0010, &code_0FB661 ) ; {1029713}
    COP [81] ( #10, #04 ) ; {1029721}
    COP [83]              ; {1029725}
    BRA loc_0FB649        ; {1029727}
}

code_0FB661 {
    COP [96]              ; {1029729}
    COP [80] ( #0F )      ; {1029731}
    COP [82]              ; {1029734}

  loc_0FB668:
    COP [AE] ( #$0010, #$FFE0, &code_0FB642 ) ; {1029736}
    COP [AE] ( #$0020, #$FFF0, &code_0FB604 ) ; {1029744}
    COP [81] ( #11, #04 ) ; {1029752}
    COP [83]              ; {1029756}
    BRA loc_0FB668        ; {1029758}
}

code_0FB680 {
    LDA $0016, X          ; {1029760}
    BIT #$8000            ; {1029763}
    BEQ loc_0FB68E        ; {1029766}
    COP [1B] ( &code_0FB680, #$0010 ) ; {1029768}

  loc_0FB68E:
    COP [80] ( #12 )      ; {1029774}
    COP [82]              ; {1029777}
    BRA code_0FB680       ; {1029779}
}

code_0FB695 {
    LDA $0016, X          ; {1029781}
    BIT #$8000            ; {1029784}
    BEQ loc_0FB6A3        ; {1029787}
    COP [1B] ( &code_0FB695, #$0010 ) ; {1029789}

  loc_0FB6A3:
    COP [0C] ( #00, #06, &code_0FB6B0 ) ; {1029795}
    COP [80] ( #1A )      ; {1029801}
    COP [82]              ; {1029804}
    BRA code_0FB695       ; {1029806}
}

code_0FB6B0 {
    COP [80] ( #1B )      ; {1029808}
    COP [82]              ; {1029811}
    COP [A3]              ; {1029813}
    COP [A2] ( #30 )      ; {1029815}

  loc_0FB6BA:
    COP [9C] ( &code_0FB6C0, &code_0FB6DC ) ; {1029818}
}

code_0FB6C0 {
    COP [9A] ( #$0000, &code_0FB6CA, &code_0FB6D3, &code_0FB6D3 ) ; {1029824}
}

code_0FB6CA {
    COP [97]              ; {1029834}
    COP [80] ( #1E )      ; {1029836}
    COP [82]              ; {1029839}
    BRA loc_0FB6BA        ; {1029841}
}

code_0FB6D3 {
    COP [96]              ; {1029843}
    COP [80] ( #1E )      ; {1029845}
    COP [82]              ; {1029848}
    BRA loc_0FB6BA        ; {1029850}
}

code_0FB6DC {
    COP [9B] ( #$0000, &code_0FB6E6, &code_0FB6EF, &code_0FB6EF ) ; {1029852}
}

code_0FB6E6 {
    COP [97]              ; {1029862}
    COP [80] ( #1D )      ; {1029864}
    COP [82]              ; {1029867}
    BRA loc_0FB6BA        ; {1029869}
}

code_0FB6EF {
    COP [97]              ; {1029871}
    COP [80] ( #1C )      ; {1029873}
    COP [82]              ; {1029876}
    BRA loc_0FB6BA        ; {1029878}
}

code_0FB6F8 {
    COP [A5] ( &code_0FB702, &code_0FB767, &code_0FB7CC, &code_0FB833 ) ; {1029880}
}

code_0FB702 {
    COP [A0] ( #$0004 )   ; {1029890}

  code_0FB706:
    LDA $0016, X          ; {1029894}
    BIT #$8000            ; {1029897}
    BEQ loc_0FB714        ; {1029900}

  code_0FB70E:
    COP [1B] ( &code_0FB706, #$0004 ) ; {1029902}

  loc_0FB714:
    COP [9B] ( #$0000, &code_0FB70E, &code_0FB71E, &code_0FB71E ) ; {1029908}
}

code_0FB71E {
    COP [9A] ( #$0040, &code_0FB70E, &code_0FB728, &code_0FB70E ) ; {1029918}
}

code_0FB728 {
    LDA $0016, X          ; {1029928}
    AND #$DFFF            ; {1029931}
    STA $0016, X          ; {1029934}
    COP [80] ( #13 )      ; {1029937}
    COP [82]              ; {1029940}
    COP [85] ( @code_0FB74A ) ; {1029942}
    LDA $0016, X          ; {1029947}
    ORA #$2000            ; {1029950}
    STA $0016, X          ; {1029953}
    COP [1B] ( &code_0FB706, #$003C ) ; {1029956}
}

code_0FB74A {
    LDA #$0200            ; {1029962}
    STA $0016, X          ; {1029965}
    COP [A0] ( #$0008 )   ; {1029968}
    COP [A3]              ; {1029972}
    COP [A2] ( #30 )      ; {1029974}
    COP [80] ( #14 )      ; {1029977}
    COP [82]              ; {1029980}
    COP [81] ( #17, #20 ) ; {1029982}
    COP [83]              ; {1029986}
    COP [86]              ; {1029988}
    RTL                   ; {1029990}
}

code_0FB767 {
    COP [9F] ( #$FFFC )   ; {1029991}

  code_0FB76B:
    LDA $0016, X          ; {1029995}
    BIT #$8000            ; {1029998}
    BEQ loc_0FB779        ; {1030001}

  code_0FB773:
    COP [1B] ( &code_0FB76B, #$0004 ) ; {1030003}

  loc_0FB779:
    COP [9A] ( #$0000, &code_0FB783, &code_0FB783, &code_0FB773 ) ; {1030009}
}

code_0FB783 {
    COP [9B] ( #$0040, &code_0FB773, &code_0FB78D, &code_0FB773 ) ; {1030019}
}

code_0FB78D {
    LDA $0016, X          ; {1030029}
    AND #$DFFF            ; {1030032}
    STA $0016, X          ; {1030035}
    COP [80] ( #13 )      ; {1030038}
    COP [82]              ; {1030041}
    COP [85] ( @code_0FB7AF ) ; {1030043}
    LDA $0016, X          ; {1030048}
    ORA #$2000            ; {1030051}
    STA $0016, X          ; {1030054}
    COP [1B] ( &code_0FB76B, #$003C ) ; {1030057}
}

code_0FB7AF {
    LDA #$0200            ; {1030063}
    STA $0016, X          ; {1030066}
    COP [9F] ( #$FFF8 )   ; {1030069}
    COP [A3]              ; {1030073}
    COP [A2] ( #30 )      ; {1030075}
    COP [80] ( #16 )      ; {1030078}
    COP [82]              ; {1030081}
    COP [81] ( #19, #20 ) ; {1030083}
    COP [83]              ; {1030087}
    COP [86]              ; {1030089}
    RTL                   ; {1030091}
}

code_0FB7CC {
    COP [9F] ( #$0004 )   ; {1030092}
    COP [96]              ; {1030096}

  code_0FB7D2:
    LDA $0016, X          ; {1030098}
    BIT #$8000            ; {1030101}
    BEQ loc_0FB7E0        ; {1030104}

  code_0FB7DA:
    COP [1B] ( &code_0FB7D2, #$0004 ) ; {1030106}

  loc_0FB7E0:
    COP [9A] ( #$0000, &code_0FB7DA, &code_0FB7EA, &code_0FB7EA ) ; {1030112}
}

code_0FB7EA {
    COP [9B] ( #$0040, &code_0FB7DA, &code_0FB7F4, &code_0FB7DA ) ; {1030122}
}

code_0FB7F4 {
    LDA $0016, X          ; {1030132}
    AND #$DFFF            ; {1030135}
    STA $0016, X          ; {1030138}
    COP [80] ( #13 )      ; {1030141}
    COP [82]              ; {1030144}
    COP [85] ( @code_0FB816 ) ; {1030146}
    LDA $0016, X          ; {1030151}
    ORA #$2000            ; {1030154}
    STA $0016, X          ; {1030157}
    COP [1B] ( &code_0FB7D2, #$003C ) ; {1030160}
}

code_0FB816 {
    LDA #$0200            ; {1030166}
    STA $0016, X          ; {1030169}
    COP [9F] ( #$0008 )   ; {1030172}
    COP [A3]              ; {1030176}
    COP [A2] ( #30 )      ; {1030178}
    COP [80] ( #16 )      ; {1030181}
    COP [82]              ; {1030184}
    COP [81] ( #19, #20 ) ; {1030186}
    COP [83]              ; {1030190}
    COP [86]              ; {1030192}
    RTL                   ; {1030194}
}

code_0FB833 {
    COP [A0] ( #$FFFC )   ; {1030195}

  code_0FB837:
    LDA $0016, X          ; {1030199}
    BIT #$8000            ; {1030202}
    BEQ loc_0FB845        ; {1030205}

  code_0FB83F:
    COP [1B] ( &code_0FB837, #$0004 ) ; {1030207}

  loc_0FB845:
    COP [9B] ( #$0000, &code_0FB84F, &code_0FB84F, &code_0FB83F ) ; {1030213}
}

code_0FB84F {
    COP [9A] ( #$0040, &code_0FB83F, &code_0FB859, &code_0FB83F ) ; {1030223}
}

code_0FB859 {
    LDA $0016, X          ; {1030233}
    AND #$DFFF            ; {1030236}
    STA $0016, X          ; {1030239}
    COP [80] ( #13 )      ; {1030242}
    COP [82]              ; {1030245}
    COP [85] ( @code_0FB87B ) ; {1030247}
    LDA $0016, X          ; {1030252}
    ORA #$2000            ; {1030255}
    STA $0016, X          ; {1030258}
    COP [1B] ( &code_0FB837, #$003C ) ; {1030261}
}

code_0FB87B {
    LDA #$0200            ; {1030267}
    STA $0016, X          ; {1030270}
    COP [A0] ( #$FFF0 )   ; {1030273}
    COP [A3]              ; {1030277}
    COP [A2] ( #30 )      ; {1030279}
    COP [80] ( #15 )      ; {1030282}
    COP [82]              ; {1030285}
    COP [81] ( #18, #20 ) ; {1030287}
    COP [83]              ; {1030291}
    COP [86]              ; {1030293}
    RTL                   ; {1030295}
}

code_0FB898 {
    LDA $0016, X          ; {1030296}
    BIT #$8000            ; {1030299}
    BEQ loc_0FB8A6        ; {1030302}

  code_0FB8A0:
    COP [1B] ( &code_0FB898, #$0010 ) ; {1030304}

  loc_0FB8A6:
    COP [9A] ( #$0010, &code_0FB8B0, &code_0FB8C2, &code_0FB8B9 ) ; {1030310}
}

code_0FB8B0 {
    COP [97]              ; {1030320}
    COP [80] ( #0B )      ; {1030322}
    COP [82]              ; {1030325}
    BRA code_0FB8C2       ; {1030327}
}

code_0FB8B9 {
    COP [96]              ; {1030329}
    COP [80] ( #0B )      ; {1030331}
    COP [82]              ; {1030334}
    BRA code_0FB8C2       ; {1030336}
}

code_0FB8C2 {
    COP [9B] ( #$0010, &code_0FB8CC, &code_0FB8A0, &code_0FB8D5 ) ; {1030338}
}

code_0FB8CC {
    COP [97]              ; {1030348}
    COP [80] ( #07 )      ; {1030350}
    COP [82]              ; {1030353}
    BRA code_0FB898       ; {1030355}
}

code_0FB8D5 {
    COP [97]              ; {1030357}
    COP [80] ( #03 )      ; {1030359}
    COP [82]              ; {1030362}
    BRA code_0FB898       ; {1030364}
}

code_0FB8DE {
    LDA $0016, X          ; {1030366}
    BIT #$8000            ; {1030369}
    BEQ loc_0FB8EC        ; {1030372}
    COP [1B] ( &code_0FB8DE, #$0010 ) ; {1030374}

  loc_0FB8EC:
    COP [1F]              ; {1030380}
    LDA $0302             ; {1030382}
    AND #$0003            ; {1030385}
    BEQ loc_0FB8FF        ; {1030388}
    DEC                   ; {1030390}
    BEQ loc_0FB937        ; {1030391}
    DEC                   ; {1030393}
    BEQ loc_0FB96C        ; {1030394}
    BRL loc_0FB9A1        ; {1030396}

  loc_0FB8FF:
    COP [97]              ; {1030399}
    COP [80] ( #02 )      ; {1030401}
    COP [82]              ; {1030404}
    COP [23] ( &code_0FB8DE ) ; {1030406}
    LDA $0016, X          ; {1030410}
    ORA #$0200            ; {1030413}
    STA $0016, X          ; {1030416}
    COP [80] ( #0C )      ; {1030419}
    COP [82]              ; {1030422}
    COP [A4]              ; {1030424}
    COP [81] ( #0E, #02 ) ; {1030426}
    COP [83]              ; {1030430}
    COP [A7]              ; {1030432}
    COP [80] ( #0D )      ; {1030434}
    COP [82]              ; {1030437}
    LDA $0016, X          ; {1030439}
    AND #$FDFF            ; {1030442}
    STA $0016, X          ; {1030445}
    COP [80] ( #02 )      ; {1030448}
    COP [82]              ; {1030451}
    BRA code_0FB8DE       ; {1030453}

  loc_0FB937:
    COP [96]              ; {1030455}
    COP [80] ( #02 )      ; {1030457}
    COP [82]              ; {1030460}
    LDA $0016, X          ; {1030462}
    ORA #$0200            ; {1030465}
    STA $0016, X          ; {1030468}
    COP [80] ( #0C )      ; {1030471}
    COP [82]              ; {1030474}
    COP [A4]              ; {1030476}
    COP [81] ( #0E, #02 ) ; {1030478}
    COP [83]              ; {1030482}
    COP [A7]              ; {1030484}
    COP [80] ( #0D )      ; {1030486}
    COP [82]              ; {1030489}
    LDA $0016, X          ; {1030491}
    AND #$FDFF            ; {1030494}
    STA $0016, X          ; {1030497}
    COP [80] ( #02 )      ; {1030500}
    COP [82]              ; {1030503}
    BRL code_0FB8DE       ; {1030505}

  loc_0FB96C:
    COP [97]              ; {1030508}
    COP [80] ( #01 )      ; {1030510}
    COP [82]              ; {1030513}
    LDA $0016, X          ; {1030515}
    ORA #$0200            ; {1030518}
    STA $0016, X          ; {1030521}
    COP [80] ( #08 )      ; {1030524}
    COP [82]              ; {1030527}
    COP [A4]              ; {1030529}
    COP [81] ( #0A, #02 ) ; {1030531}
    COP [83]              ; {1030535}
    COP [A7]              ; {1030537}
    COP [80] ( #09 )      ; {1030539}
    COP [82]              ; {1030542}
    LDA $0016, X          ; {1030544}
    AND #$FDFF            ; {1030547}
    STA $0016, X          ; {1030550}
    COP [80] ( #01 )      ; {1030553}
    COP [82]              ; {1030556}
    BRL code_0FB8DE       ; {1030558}

  loc_0FB9A1:
    COP [97]              ; {1030561}
    COP [80] ( #00 )      ; {1030563}
    COP [82]              ; {1030566}
    LDA $0016, X          ; {1030568}
    ORA #$0200            ; {1030571}
    STA $0016, X          ; {1030574}
    COP [80] ( #04 )      ; {1030577}
    COP [82]              ; {1030580}
    COP [A4]              ; {1030582}
    COP [81] ( #06, #02 ) ; {1030584}
    COP [83]              ; {1030588}
    COP [A7]              ; {1030590}
    COP [80] ( #05 )      ; {1030592}
    COP [82]              ; {1030595}
    LDA $0016, X          ; {1030597}
    AND #$FDFF            ; {1030600}
    STA $0016, X          ; {1030603}
    COP [80] ( #00 )      ; {1030606}
    COP [82]              ; {1030609}
    BRL code_0FB8DE       ; {1030611}
}

code_0FB9D6 {
    COP [AD] ( #08 )      ; {1030614}
    COP [9B] ( #$0000, &code_0FB9E3, &code_0FBA01, &code_0FBA01 ) ; {1030617}
}

code_0FB9E3 {
    COP [97]              ; {1030627}
    COP [9B] ( #$0018, &code_0FB9EF, &code_0FBA68, &code_0FB9EF ) ; {1030629}
}

code_0FB9EF {
    COP [21] ( &code_0FB9FA ) ; {1030639}
    COP [80] ( #23 )      ; {1030643}
    COP [82]              ; {1030646}
    BRA code_0FB9D6       ; {1030648}
}

code_0FB9FA {
    COP [80] ( #20 )      ; {1030650}
    COP [82]              ; {1030653}
    BRA code_0FB9D6       ; {1030655}
}

code_0FBA01 {
    COP [97]              ; {1030657}
    COP [9B] ( #$0018, &code_0FBA0D, &code_0FBA68, &code_0FBA0D ) ; {1030659}
}

code_0FBA0D {
    COP [22] ( &code_0FBA18 ) ; {1030669}
    COP [80] ( #22 )      ; {1030673}
    COP [82]              ; {1030676}
    BRA code_0FB9D6       ; {1030678}
}

code_0FBA18 {
    COP [80] ( #1F )      ; {1030680}
    COP [82]              ; {1030683}
    BRA code_0FB9D6       ; {1030685}

  loc_0FBA1F:
    COP [AD] ( #08 )      ; {1030687}
    COP [9A] ( #$0000, &code_0FBA2C, &code_0FBA4A, &code_0FBA4A ) ; {1030690}
}

code_0FBA2C {
    COP [9A] ( #$0018, &code_0FBA36, &code_0FBA85, &code_0FBA36 ) ; {1030700}
}

code_0FBA36 {
    COP [97]              ; {1030710}
    COP [23] ( &code_0FBA43 ) ; {1030712}
    COP [80] ( #24 )      ; {1030716}
    COP [82]              ; {1030719}
    BRA loc_0FBA1F        ; {1030721}
}

code_0FBA43 {
    COP [80] ( #21 )      ; {1030723}
    COP [82]              ; {1030726}
    BRA loc_0FBA1F        ; {1030728}
}

code_0FBA4A {
    COP [9A] ( #$0018, &code_0FBA54, &code_0FBA85, &code_0FBA54 ) ; {1030730}
}

code_0FBA54 {
    COP [96]              ; {1030740}
    COP [24] ( &code_0FBA61 ) ; {1030742}
    COP [80] ( #24 )      ; {1030746}
    COP [82]              ; {1030749}
    BRA loc_0FBA1F        ; {1030751}
}

code_0FBA61 {
    COP [80] ( #21 )      ; {1030753}
    COP [82]              ; {1030756}
    BRA loc_0FBA1F        ; {1030758}
}

code_0FBA68 {
    COP [1F]              ; {1030760}
    LDA $0302             ; {1030762}
    AND #$0003            ; {1030765}
    BNE loc_0FBA1F        ; {1030768}
    COP [80] ( #1F )      ; {1030770}
    COP [82]              ; {1030773}
    COP [B0] ( @code_0FBAA6, #$0200 ) ; {1030775}
    COP [80] ( #1F )      ; {1030782}
    COP [82]              ; {1030785}
    BRA loc_0FBA1F        ; {1030787}
}

code_0FBA85 {
    COP [1F]              ; {1030789}
    LDA $0302             ; {1030791}
    AND #$0003            ; {1030794}
    BEQ loc_0FBA92        ; {1030797}
    BRL code_0FB9D6       ; {1030799}

  loc_0FBA92:
    COP [80] ( #1F )      ; {1030802}
    COP [82]              ; {1030805}
    COP [B0] ( @code_0FBAA6, #$0200 ) ; {1030807}
    COP [80] ( #1F )      ; {1030814}
    COP [82]              ; {1030817}
    BRL code_0FB9D6       ; {1030819}
}

code_0FBAA6 {
    COP [A3]              ; {1030822}
    COP [A2] ( #30 )      ; {1030824}
    BRK #$64              ; {1030827}
    LDY #$0028            ; {1030829}
    SEP #$20              ; {1030832}
    LDA #$^chunk_000000.code_002D67 ; {1030834}
    PHA                   ; {1030836}
    REP #$20              ; {1030837}
    LDA #$&chunk_000000.code_002D67-1 ; {1030839}
    PHA                   ; {1030842}
    RTL                   ; {1030843}
}

code_0FBABC {
    LDA $001A, X          ; {1030844}
    ORA #$0400            ; {1030847}
    STA $001A, X          ; {1030850}
    COP [A5] ( &code_0FBB0B, &code_0FBAF7, &code_0FBACF, &code_0FBAE3 ) ; {1030853}
}

code_0FBACF {
    COP [21] ( &code_0FBAD5 ) ; {1030863}
    BRA loc_0FBAED        ; {1030867}
}

code_0FBAD5 {
    COP [24] ( &code_0FBB0B ) ; {1030869}

  loc_0FBAD9:
    COP [96]              ; {1030873}
    COP [81] ( #27, #02 ) ; {1030875}
    COP [83]              ; {1030879}
    BRA code_0FBACF       ; {1030881}
}

code_0FBAE3 {
    COP [23] ( &code_0FBAE9 ) ; {1030883}
    BRA loc_0FBB01        ; {1030887}
}

code_0FBAE9 {
    COP [21] ( &code_0FBACF ) ; {1030889}

  loc_0FBAED:
    COP [97]              ; {1030893}
    COP [81] ( #26, #02 ) ; {1030895}
    COP [83]              ; {1030899}
    BRA code_0FBAE3       ; {1030901}
}

code_0FBAF7 {
    COP [22] ( &code_0FBAFD ) ; {1030903}
    BRA loc_0FBB15        ; {1030907}
}

code_0FBAFD {
    COP [23] ( &code_0FBAE3 ) ; {1030909}

  loc_0FBB01:
    COP [97]              ; {1030913}
    COP [81] ( #27, #02 ) ; {1030915}
    COP [83]              ; {1030919}
    BRA code_0FBAF7       ; {1030921}
}

code_0FBB0B {
    COP [24] ( &code_0FBB11 ) ; {1030923}
    BRA loc_0FBAD9        ; {1030927}
}

code_0FBB11 {
    COP [22] ( &code_0FBAF7 ) ; {1030929}

  loc_0FBB15:
    COP [97]              ; {1030933}
    COP [81] ( #25, #02 ) ; {1030935}
    COP [83]              ; {1030939}
    BRA code_0FBB0B       ; {1030941}
}

code_0FBB1F {
    LDA $0016, X          ; {1030943}
    BIT #$8000            ; {1030946}
    BEQ loc_0FBB2D        ; {1030949}
    COP [1B] ( &code_0FBB1F, #$0010 ) ; {1030951}

  loc_0FBB2D:
    COP [0C] ( #00, #05, &code_0FBB3A ) ; {1030957}
    COP [80] ( #04 )      ; {1030963}
    COP [82]              ; {1030966}
    BRA code_0FBB1F       ; {1030968}
}

code_0FBB3A {
    COP [9C] ( &code_0FBB40, &code_0FBB5C ) ; {1030970}
}

code_0FBB40 {
    COP [9A] ( #$0000, &code_0FBB4A, &code_0FBB53, &code_0FBB53 ) ; {1030976}
}

code_0FBB4A {
    COP [97]              ; {1030986}
    COP [80] ( #07 )      ; {1030988}
    COP [82]              ; {1030991}
    BRA code_0FBB1F       ; {1030993}
}

code_0FBB53 {
    COP [96]              ; {1030995}
    COP [80] ( #07 )      ; {1030997}
    COP [82]              ; {1031000}
    BRA code_0FBB1F       ; {1031002}
}

code_0FBB5C {
    COP [9B] ( #$0000, &code_0FBB66, &code_0FBB6F, &code_0FBB6F ) ; {1031004}
}

code_0FBB66 {
    COP [97]              ; {1031014}
    COP [80] ( #06 )      ; {1031016}
    COP [82]              ; {1031019}
    BRA code_0FBB1F       ; {1031021}
}

code_0FBB6F {
    COP [97]              ; {1031023}
    COP [80] ( #05 )      ; {1031025}
    COP [82]              ; {1031028}
    BRA code_0FBB1F       ; {1031030}
}

code_0FBB78 {
    LDA $0016, X          ; {1031032}
    BIT #$8000            ; {1031035}
    BEQ loc_0FBB86        ; {1031038}

  loc_0FBB80:
    COP [1B] ( &code_0FBB78, #$003C ) ; {1031040}

  loc_0FBB86:
    LDA $0016, X          ; {1031046}
    AND #$DFFF            ; {1031049}
    STA $0016, X          ; {1031052}
    COP [80] ( #22 )      ; {1031055}
    COP [82]              ; {1031058}
    LDA $0016, X          ; {1031060}
    ORA #$2000            ; {1031063}
    STA $0016, X          ; {1031066}
    COP [A0] ( #$0048 )   ; {1031069}
    BRA loc_0FBB80        ; {1031073}
}

code_0FBBA3 {
    COP [A3]              ; {1031075}
    COP [A2] ( #30 )      ; {1031077}

  loc_0FBBA8:
    COP [AD] ( #10 )      ; {1031080}
    COP [9A] ( #$0018, &code_0FBBB5, &code_0FBBC9, &code_0FBBB5 ) ; {1031083}
}

code_0FBBB5 {
    COP [9B] ( #$0018, &code_0FBBD3, &code_0FBBBF, &code_0FBBD3 ) ; {1031093}
}

code_0FBBBF {
    COP [9A] ( #$0000, &code_0FBC01, &code_0FBC09, &code_0FBC09 ) ; {1031103}
}

code_0FBBC9 {
    COP [9B] ( #$0000, &code_0FBC11, &code_0FBC19, &code_0FBC19 ) ; {1031113}
}

code_0FBBD3 {
    COP [1F]              ; {1031123}
    LDA $0302             ; {1031125}
    AND #$0003            ; {1031128}
    BEQ loc_0FBBE5        ; {1031131}
    DEC                   ; {1031133}
    BEQ loc_0FBBEC        ; {1031134}
    DEC                   ; {1031136}
    BEQ loc_0FBBF3        ; {1031137}
    BRA loc_0FBBFA        ; {1031139}

  loc_0FBBE5:
    COP [80] ( #03 )      ; {1031141}
    COP [82]              ; {1031144}
    BRA loc_0FBBA8        ; {1031146}

  loc_0FBBEC:
    COP [80] ( #2C )      ; {1031148}
    COP [82]              ; {1031151}
    BRA loc_0FBBA8        ; {1031153}

  loc_0FBBF3:
    COP [80] ( #02 )      ; {1031155}
    COP [82]              ; {1031158}
    BRA loc_0FBBA8        ; {1031160}

  loc_0FBBFA:
    COP [80] ( #01 )      ; {1031162}
    COP [82]              ; {1031165}
    BRA loc_0FBBA8        ; {1031167}
}

code_0FBC01 {
    COP [81] ( #2A, #02 ) ; {1031169}
    COP [83]              ; {1031173}
    BRA code_0FBBD3       ; {1031175}
}

code_0FBC09 {
    COP [81] ( #2B, #02 ) ; {1031177}
    COP [83]              ; {1031181}
    BRA code_0FBBD3       ; {1031183}
}

code_0FBC11 {
    COP [81] ( #29, #02 ) ; {1031185}
    COP [83]              ; {1031189}
    BRA code_0FBBD3       ; {1031191}
}

code_0FBC19 {
    COP [81] ( #28, #02 ) ; {1031193}
    COP [83]              ; {1031197}
    BRL code_0FBBD3       ; {1031199}
}

code_0FBC22 {
    LDA $001A, X          ; {1031202}
    ORA #$0400            ; {1031205}
    STA $001A, X          ; {1031208}

  code_0FBC2B:
    LDA $0016, X          ; {1031211}
    BIT #$8000            ; {1031214}
    BEQ loc_0FBC39        ; {1031217}

  loc_0FBC33:
    COP [1B] ( &code_0FBC2B, #$001E ) ; {1031219}

  loc_0FBC39:
    COP [1F]              ; {1031225}
    LDA $0302             ; {1031227}
    AND #$0003            ; {1031230}
    BEQ code_0FBC4C       ; {1031233}
    DEC                   ; {1031235}
    BEQ code_0FBC7D       ; {1031236}
    DEC                   ; {1031238}
    BEQ code_0FBCAE       ; {1031239}
    BRL code_0FBCE0       ; {1031241}

  code_0FBC4C:
    COP [23] ( &code_0FBC7D ) ; {1031244}
    LDA $001A, X          ; {1031248}
    AND #$FBFF            ; {1031251}
    STA $001A, X          ; {1031254}
    COP [80] ( #1B )      ; {1031257}
    COP [82]              ; {1031260}
    COP [80] ( #1D )      ; {1031262}
    COP [82]              ; {1031265}
    COP [80] ( #20 )      ; {1031267}
    COP [82]              ; {1031270}
    COP [80] ( #1C )      ; {1031272}
    COP [82]              ; {1031275}
    LDA $001A, X          ; {1031277}
    ORA #$0400            ; {1031280}
    STA $001A, X          ; {1031283}
    COP [80] ( #1A )      ; {1031286}
    COP [82]              ; {1031289}
    BRA loc_0FBC33        ; {1031291}
}

code_0FBC7D {
    COP [24] ( &code_0FBCAE ) ; {1031293}
    LDA $001A, X          ; {1031297}
    AND #$FBFF            ; {1031300}
    STA $001A, X          ; {1031303}
    COP [80] ( #1B )      ; {1031306}
    COP [82]              ; {1031309}
    COP [80] ( #1D )      ; {1031311}
    COP [82]              ; {1031314}
    COP [80] ( #21 )      ; {1031316}
    COP [82]              ; {1031319}
    COP [80] ( #1C )      ; {1031321}
    COP [82]              ; {1031324}
    LDA $001A, X          ; {1031326}
    ORA #$0400            ; {1031329}
    STA $001A, X          ; {1031332}
    COP [80] ( #1A )      ; {1031335}
    COP [82]              ; {1031338}
    BRA loc_0FBC33        ; {1031340}
}

code_0FBCAE {
    COP [21] ( &code_0FBCE0 ) ; {1031342}
    LDA $001A, X          ; {1031346}
    AND #$FBFF            ; {1031349}
    STA $001A, X          ; {1031352}
    COP [80] ( #1B )      ; {1031355}
    COP [82]              ; {1031358}
    COP [80] ( #1D )      ; {1031360}
    COP [82]              ; {1031363}
    COP [80] ( #1F )      ; {1031365}
    COP [82]              ; {1031368}
    COP [80] ( #1C )      ; {1031370}
    COP [82]              ; {1031373}
    LDA $001A, X          ; {1031375}
    ORA #$0400            ; {1031378}
    STA $001A, X          ; {1031381}
    COP [80] ( #1A )      ; {1031384}
    COP [82]              ; {1031387}
    BRL loc_0FBC33        ; {1031389}
}

code_0FBCE0 {
    COP [22] ( &code_0FBC4C ) ; {1031392}
    LDA $001A, X          ; {1031396}
    AND #$FBFF            ; {1031399}
    STA $001A, X          ; {1031402}
    COP [80] ( #1B )      ; {1031405}
    COP [82]              ; {1031408}
    COP [80] ( #1D )      ; {1031410}
    COP [82]              ; {1031413}
    COP [80] ( #1E )      ; {1031415}
    COP [82]              ; {1031418}
    COP [80] ( #1C )      ; {1031420}
    COP [82]              ; {1031423}
    LDA $001A, X          ; {1031425}
    ORA #$0400            ; {1031428}
    STA $001A, X          ; {1031431}
    COP [80] ( #1A )      ; {1031434}
    COP [82]              ; {1031437}
    BRL loc_0FBC33        ; {1031439}
}

code_0FBD12 {
    COP [A5] ( &code_0FBD1C, &code_0FBD23, &code_0FBD2A, &code_0FBD33 ) ; {1031442}
}

code_0FBD1C {
    COP [80] ( #08 )      ; {1031452}
    COP [82]              ; {1031455}
    BRA loc_0FBD38        ; {1031457}
}

code_0FBD23 {
    COP [80] ( #0A )      ; {1031459}
    COP [82]              ; {1031462}
    BRA loc_0FBD38        ; {1031464}
}

code_0FBD2A {
    COP [96]              ; {1031466}
    COP [80] ( #0A )      ; {1031468}
    COP [82]              ; {1031471}
    BRA loc_0FBD38        ; {1031473}
}

code_0FBD33 {
    COP [80] ( #09 )      ; {1031475}
    COP [82]              ; {1031478}

  loc_0FBD38:
    COP [AD] ( #08 )      ; {1031480}
    COP [9C] ( &code_0FBD41, &code_0FBDC2 ) ; {1031483}
}

code_0FBD41 {
    COP [9A] ( #$0000, &code_0FBD4B, &code_0FBD86, &code_0FBD86 ) ; {1031489}
}

code_0FBD4B {
    COP [97]              ; {1031499}
    COP [80] ( #0A )      ; {1031501}
    COP [82]              ; {1031504}

  code_0FBD52:
    COP [80] ( #0D )      ; {1031506}
    COP [82]              ; {1031509}
    COP [9A] ( #$0000, &code_0FBD52, &code_0FBD61, &code_0FBD61 ) ; {1031511}
}

code_0FBD61 {
    LDA $0016, X          ; {1031521}
    ORA #$0200            ; {1031524}
    STA $0016, X          ; {1031527}
    COP [B2] ( &code_0FBE44, #1F, #$FFF8, #$0008, #$0200 ) ; {1031530}
    LDA $0016, X          ; {1031541}
    AND #$FDFF            ; {1031544}
    STA $0016, X          ; {1031547}
    COP [81] ( #0A, #02 ) ; {1031550}
    COP [83]              ; {1031554}
    BRA loc_0FBD38        ; {1031556}
}

code_0FBD86 {
    COP [96]              ; {1031558}
    COP [80] ( #0A )      ; {1031560}
    COP [82]              ; {1031563}

  code_0FBD8D:
    COP [80] ( #0D )      ; {1031565}
    COP [82]              ; {1031568}
    COP [9A] ( #$0000, &code_0FBD9C, &code_0FBD9C, &code_0FBD8D ) ; {1031570}
}

code_0FBD9C {
    LDA $0016, X          ; {1031580}
    ORA #$0200            ; {1031583}
    STA $0016, X          ; {1031586}
    COP [B2] ( &code_0FBE44, #1F, #$FFF8, #$0008, #$0200 ) ; {1031589}
    LDA $0016, X          ; {1031600}
    AND #$FDFF            ; {1031603}
    STA $0016, X          ; {1031606}
    COP [81] ( #0A, #02 ) ; {1031609}
    COP [83]              ; {1031613}
    BRL loc_0FBD38        ; {1031615}
}

code_0FBDC2 {
    COP [9B] ( #$0000, &code_0FBDCC, &code_0FBE08, &code_0FBE08 ) ; {1031618}
}

code_0FBDCC {
    COP [97]              ; {1031628}
    COP [80] ( #09 )      ; {1031630}
    COP [82]              ; {1031633}

  code_0FBDD3:
    COP [80] ( #0C )      ; {1031635}
    COP [82]              ; {1031638}
    COP [9B] ( #$0000, &code_0FBDD3, &code_0FBDE2, &code_0FBDE2 ) ; {1031640}
}

code_0FBDE2 {
    LDA $0016, X          ; {1031650}
    ORA #$0200            ; {1031653}
    STA $0016, X          ; {1031656}
    COP [B2] ( &code_0FBE44, #1F, #$FFF8, #$0008, #$0200 ) ; {1031659}
    LDA $0016, X          ; {1031670}
    AND #$FDFF            ; {1031673}
    STA $0016, X          ; {1031676}
    COP [81] ( #09, #02 ) ; {1031679}
    COP [83]              ; {1031683}
    BRL loc_0FBD38        ; {1031685}
}

code_0FBE08 {
    COP [97]              ; {1031688}
    COP [80] ( #08 )      ; {1031690}
    COP [82]              ; {1031693}

  code_0FBE0F:
    COP [80] ( #0B )      ; {1031695}
    COP [82]              ; {1031698}
    COP [9B] ( #$0000, &code_0FBE1E, &code_0FBE1E, &code_0FBE0F ) ; {1031700}
}

code_0FBE1E {
    LDA $0016, X          ; {1031710}
    ORA #$0200            ; {1031713}
    STA $0016, X          ; {1031716}
    COP [B2] ( &code_0FBE44, #1F, #$FFF8, #$0008, #$0200 ) ; {1031719}
    LDA $0016, X          ; {1031730}
    AND #$FDFF            ; {1031733}
    STA $0016, X          ; {1031736}
    COP [81] ( #08, #02 ) ; {1031739}
    COP [83]              ; {1031743}
    BRL loc_0FBD38        ; {1031745}
}

code_0FBE44 {
    COP [A3]              ; {1031748}
    COP [97]              ; {1031750}
    COP [99]              ; {1031752}
    COP [81] ( #10, #08 ) ; {1031754}
    COP [83]              ; {1031758}
    BRK #$4B              ; {1031760}
    COP [9C] ( &code_0FBE58, &code_0FBE62 ) ; {1031762}
}

code_0FBE58 {
    COP [9A] ( #$0000, &code_0FBE78, &code_0FBE76, &code_0FBE76 ) ; {1031768}
}

code_0FBE62 {
    COP [9B] ( #$0000, &code_0FBE6C, &code_0FBE6E, &code_0FBE6E ) ; {1031778}
}

code_0FBE6C {
    COP [98]              ; {1031788}
}

code_0FBE6E {
    COP [81] ( #0E, #20 ) ; {1031790}
    COP [83]              ; {1031794}
    BRA loc_0FBE7E        ; {1031796}
}

code_0FBE76 {
    COP [96]              ; {1031798}
}

code_0FBE78 {
    COP [81] ( #0F, #20 ) ; {1031800}
    COP [83]              ; {1031804}

  loc_0FBE7E:
    COP [86]              ; {1031806}
    RTL                   ; {1031808}
}

code_0FBE81 {
    LDA $0025, X          ; {1031809}
    AND #$00FF            ; {1031812}
    STA $0030, X          ; {1031815}

  loc_0FBE8A:
    COP [AD] ( #08 )      ; {1031818}
    COP [9C] ( &code_0FBE93, &code_0FBED3 ) ; {1031821}
}

code_0FBE93 {
    COP [9A] ( #$0000, &code_0FBE9D, &code_0FBEB8, &code_0FBEB8 ) ; {1031827}
}

code_0FBE9D {
    COP [97]              ; {1031837}
    COP [81] ( #16, #08 ) ; {1031839}
    COP [83]              ; {1031843}
    JSR $&code_0FBF13     ; {1031845}
    BCC loc_0FBE8A        ; {1031848}
    COP [81] ( #19, #04 ) ; {1031850}
    COP [83]              ; {1031854}
    COP [81] ( #13, #10 ) ; {1031856}
    COP [83]              ; {1031860}
    BRA loc_0FBE8A        ; {1031862}
}

code_0FBEB8 {
    COP [96]              ; {1031864}
    COP [81] ( #16, #08 ) ; {1031866}
    COP [83]              ; {1031870}
    JSR $&code_0FBF13     ; {1031872}
    BCC loc_0FBE8A        ; {1031875}
    COP [81] ( #19, #04 ) ; {1031877}
    COP [83]              ; {1031881}
    COP [81] ( #13, #10 ) ; {1031883}
    COP [83]              ; {1031887}
    BRA loc_0FBE8A        ; {1031889}
}

code_0FBED3 {
    COP [9B] ( #$0000, &code_0FBEDD, &code_0FBEF8, &code_0FBEF8 ) ; {1031891}
}

code_0FBEDD {
    COP [97]              ; {1031901}
    COP [81] ( #15, #08 ) ; {1031903}
    COP [83]              ; {1031907}
    JSR $&code_0FBF13     ; {1031909}
    BCC loc_0FBE8A        ; {1031912}
    COP [81] ( #18, #04 ) ; {1031914}
    COP [83]              ; {1031918}
    COP [81] ( #12, #10 ) ; {1031920}
    COP [83]              ; {1031924}
    BRA loc_0FBE8A        ; {1031926}
}

code_0FBEF8 {
    COP [97]              ; {1031928}
    COP [81] ( #14, #08 ) ; {1031930}
    COP [83]              ; {1031934}
    JSR $&code_0FBF13     ; {1031936}
    BCC loc_0FBE8A        ; {1031939}
    COP [81] ( #17, #04 ) ; {1031941}
    COP [83]              ; {1031945}
    COP [80] ( #11 )      ; {1031947}
    COP [82]              ; {1031950}
    BRL loc_0FBE8A        ; {1031952}
}

code_0FBF13 {
    LDA $0025, X          ; {1031955}
    AND #$00FF            ; {1031958}
    CMP $0030, X          ; {1031961}
    BEQ loc_0FBF23        ; {1031964}
    STA $0030, X          ; {1031966}
    SEC                   ; {1031969}
    RTS                   ; {1031970}

  loc_0FBF23:
    CLC                   ; {1031971}
    RTS                   ; {1031972}
}

code_0FBF25 {
    LDA $0016, X          ; {1031973}
    BIT #$8000            ; {1031976}
    BEQ loc_0FBF33        ; {1031979}

  code_0FBF2D:
    COP [1B] ( &code_0FBF25, #$0020 ) ; {1031981}

  loc_0FBF33:
    COP [19] ( #24, &code_0FBF2D ) ; {1031987}
    COP [0C] ( #00, #02, &code_0FBF40 ) ; {1031992}
    BRA code_0FBF2D       ; {1031998}
}

code_0FBF40 {
    COP [85] ( @code_0FBF4B ) ; {1032000}
    COP [1B] ( &code_0FBF25, #$00B4 ) ; {1032005}
}

code_0FBF4B {
    LDA #$02A0            ; {1032011}
    STA $0016, X          ; {1032014}
    LDA #$00FF            ; {1032017}
    STA $0030, X          ; {1032020}
    COP [A3]              ; {1032023}
    COP [A2] ( #30 )      ; {1032025}
    BRK #$90              ; {1032028}
    COP [A0] ( #$FF50 )   ; {1032030}
    COP [80] ( #00 )      ; {1032034}
    COP [82]              ; {1032037}
    COP [85] ( @code_0FBF88 ) ; {1032039}
    COP [A0] ( #$0080 )   ; {1032044}
    COP [80] ( #00 )      ; {1032048}
    COP [82]              ; {1032051}
    COP [85] ( @code_0FBF88 ) ; {1032053}
    COP [A1] ( #$FFE8, #$0048 ) ; {1032058}
    COP [80] ( #02 )      ; {1032064}
    COP [82]              ; {1032067}
    COP [86]              ; {1032069}
    RTL                   ; {1032071}
}

code_0FBF88 {
    LDA #$00FF            ; {1032072}
    STA $0030, X          ; {1032075}
    LDA #$02A0            ; {1032078}
    STA $0016, X          ; {1032081}
    COP [A3]              ; {1032084}
    COP [A2] ( #30 )      ; {1032086}
    COP [80] ( #01 )      ; {1032089}
    COP [82]              ; {1032092}
    COP [86]              ; {1032094}
    RTL                   ; {1032096}
}

code_0FBFA1 {
    LDA #$&code_0FBFB7    ; {1032097}
    STA $0018, X          ; {1032100}

  loc_0FBFA7:
    COP [1F]              ; {1032103}
    LDA $0302             ; {1032105}
    AND #$007F            ; {1032108}
    CLC                   ; {1032111}
    ADC #$007F            ; {1032112}
    STA $0014, X          ; {1032115}
    RTL                   ; {1032118}
}
---------------------------------------------

code_0FBFB7 {
    COP [07] ( #$8503, &code_0FBFC4 ) ; {1032119}
    COP [85] ( @code_0FBFC7 ) ; {1032125}
    BRA loc_0FBFA7        ; {1032130}
}

code_0FBFC4 {
    COP [86]              ; {1032132}
    RTL                   ; {1032134}
}

code_0FBFC7 {
    LDA #$0301            ; {1032135}
    STA $0016, X          ; {1032138}
    COP [A3]              ; {1032141}
    BRK #$50              ; {1032143}

  loc_0FBFD1:
    COP [80] ( #03 )      ; {1032145}
    COP [82]              ; {1032148}
    COP [1C] ( #$8000, &code_0FBFDE ) ; {1032150}
    BRA loc_0FBFD1        ; {1032156}
}

code_0FBFDE {
    COP [1F]              ; {1032158}
    LDA $0302             ; {1032160}
    AND #$007F            ; {1032163}
    SEC                   ; {1032166}
    SBC #$0040            ; {1032167}
    CLC                   ; {1032170}
    ADC $0374             ; {1032171}
    STA $0000, X          ; {1032174}
    COP [1F]              ; {1032177}
    LDA $0302             ; {1032179}
    AND #$007F            ; {1032182}
    SEC                   ; {1032185}
    SBC #$0040            ; {1032186}
    CLC                   ; {1032189}
    ADC $0376             ; {1032190}
    SEC                   ; {1032193}
    SBC #$00E0            ; {1032194}
    STA $0002, X          ; {1032197}
    COP [81] ( #04, #07 ) ; {1032200}
    COP [83]              ; {1032204}
    LDA #$0200            ; {1032206}
    STA $0016, X          ; {1032209}
    COP [A6]              ; {1032212}
    COP [80] ( #05 )      ; {1032214}
    COP [82]              ; {1032217}
    COP [86]              ; {1032219}
    RTL                   ; {1032221}
}

code_0FC01E {
    LDA $0016, X          ; {1032222}
    BIT #$8000            ; {1032225}
    BEQ loc_0FC02C        ; {1032228}
    COP [1B] ( &code_0FC01E, #$0010 ) ; {1032230}

  loc_0FC02C:
    COP [1F]              ; {1032236}
    LDA $0302             ; {1032238}
    AND #$0003            ; {1032241}
    BEQ loc_0FC03F        ; {1032244}
    DEC                   ; {1032246}
    BEQ loc_0FC05C        ; {1032247}
    DEC                   ; {1032249}
    BEQ loc_0FC079        ; {1032250}
    DEC                   ; {1032252}
    BEQ loc_0FC096        ; {1032253}

  loc_0FC03F:
    COP [97]              ; {1032255}
    COP [80] ( #09 )      ; {1032257}
    COP [82]              ; {1032260}
    COP [80] ( #06 )      ; {1032262}
    COP [82]              ; {1032265}
    COP [80] ( #07 )      ; {1032267}
    COP [82]              ; {1032270}
    COP [85] ( @code_0FC0B4 ) ; {1032272}
    COP [80] ( #06 )      ; {1032277}
    COP [82]              ; {1032280}
    BRA code_0FC01E       ; {1032282}

  loc_0FC05C:
    COP [97]              ; {1032284}
    COP [80] ( #08 )      ; {1032286}
    COP [82]              ; {1032289}
    COP [80] ( #06 )      ; {1032291}
    COP [82]              ; {1032294}
    COP [80] ( #07 )      ; {1032296}
    COP [82]              ; {1032299}
    COP [85] ( @code_0FC0B9 ) ; {1032301}
    COP [80] ( #06 )      ; {1032306}
    COP [82]              ; {1032309}
    BRA code_0FC01E       ; {1032311}

  loc_0FC079:
    COP [96]              ; {1032313}
    COP [80] ( #0A )      ; {1032315}
    COP [82]              ; {1032318}
    COP [80] ( #06 )      ; {1032320}
    COP [82]              ; {1032323}
    COP [80] ( #07 )      ; {1032325}
    COP [82]              ; {1032328}
    COP [85] ( @code_0FC0BE ) ; {1032330}
    COP [80] ( #06 )      ; {1032335}
    COP [82]              ; {1032338}
    BRA code_0FC01E       ; {1032340}

  loc_0FC096:
    COP [97]              ; {1032342}
    COP [80] ( #0A )      ; {1032344}
    COP [82]              ; {1032347}
    COP [80] ( #06 )      ; {1032349}
    COP [82]              ; {1032352}
    COP [80] ( #07 )      ; {1032354}
    COP [82]              ; {1032357}
    COP [85] ( @code_0FC0BE ) ; {1032359}
    COP [80] ( #06 )      ; {1032364}
    COP [82]              ; {1032367}
    BRL code_0FC01E       ; {1032369}
}

code_0FC0B4 {
    LDA #$000C            ; {1032372}
    BRA loc_0FC0C1        ; {1032375}
}

code_0FC0B9 {
    LDA #$000B            ; {1032377}
    BRA loc_0FC0C1        ; {1032380}
}

code_0FC0BE {
    LDA #$000D            ; {1032382}

  loc_0FC0C1:
    STA $001E, X          ; {1032385}
    STZ $0020, X          ; {1032388}
    LDA #$0006            ; {1032391}
    STA $002A, X          ; {1032394}
    LDA #$0200            ; {1032397}
    STA $0016, X          ; {1032400}
    COP [A0] ( #$FFF8 )   ; {1032403}
    COP [A3]              ; {1032407}
    COP [A2] ( #30 )      ; {1032409}
    BRK #$5B              ; {1032412}
    COP [91]              ; {1032414}
    COP [83]              ; {1032416}
    COP [86]              ; {1032418}
    RTL                   ; {1032420}
}

code_0FC0E5 {
    LDA $0016, X          ; {1032421}
    BIT #$8000            ; {1032424}
    BEQ loc_0FC0F3        ; {1032427}
    COP [1B] ( &code_0FC0E5, #$0010 ) ; {1032429}

  loc_0FC0F3:
    COP [0C] ( #00, #04, &code_0FC100 ) ; {1032435}

  code_0FC0F9:
    COP [80] ( #1D )      ; {1032441}
    COP [82]              ; {1032444}
    BRA code_0FC0E5       ; {1032446}
}

code_0FC100 {
    COP [9C] ( &code_0FC106, &code_0FC12A ) ; {1032448}
}

code_0FC106 {
    COP [9A] ( #$0010, &code_0FC110, &code_0FC11D, &code_0FC11D ) ; {1032454}
}

code_0FC110 {
    COP [23] ( &code_0FC0F9 ) ; {1032464}
    COP [97]              ; {1032468}
    COP [80] ( #20 )      ; {1032470}
    COP [82]              ; {1032473}
    BRA code_0FC0F9       ; {1032475}
}

code_0FC11D {
    COP [24] ( &code_0FC0F9 ) ; {1032477}
    COP [96]              ; {1032481}
    COP [80] ( #20 )      ; {1032483}
    COP [82]              ; {1032486}
    BRA code_0FC0F9       ; {1032488}
}

code_0FC12A {
    COP [9B] ( #$0010, &code_0FC134, &code_0FC141, &code_0FC141 ) ; {1032490}
}

code_0FC134 {
    COP [21] ( &code_0FC0F9 ) ; {1032500}
    COP [97]              ; {1032504}
    COP [80] ( #1F )      ; {1032506}
    COP [82]              ; {1032509}
    BRA code_0FC0F9       ; {1032511}
}

code_0FC141 {
    COP [22] ( &code_0FC0F9 ) ; {1032513}
    COP [97]              ; {1032517}
    COP [80] ( #1E )      ; {1032519}
    COP [82]              ; {1032522}
    BRA code_0FC0F9       ; {1032524}
}

code_0FC14E {
    PHX                   ; {1032526}
    LDA $0000, X          ; {1032527}
    STA $16               ; {1032530}
    LDA $0002, X          ; {1032532}
    SEC                   ; {1032535}
    SBC #$0010            ; {1032536}
    STA $18               ; {1032539}
    JSL $@chunk_0270E4.code_0272B8 ; {1032541}
    TXA                   ; {1032545}
    PLX                   ; {1032546}
    STA $0030, X          ; {1032547}

  code_0FC166:
    LDA $0016, X          ; {1032550}
    BIT #$8000            ; {1032553}
    BEQ loc_0FC174        ; {1032556}

  code_0FC16E:
    COP [1B] ( &code_0FC166, #$0008 ) ; {1032558}

  loc_0FC174:
    PHX                   ; {1032564}
    LDA $0030, X          ; {1032565}
    TAX                   ; {1032568}
    LDA $7F8000, X        ; {1032569}
    PLX                   ; {1032573}
    AND #$00FF            ; {1032574}
    BNE loc_0FC186        ; {1032577}
    BRL loc_0FC26E        ; {1032579}

  loc_0FC186:
    COP [9B] ( #$0060, &code_0FC16E, &code_0FC190, &code_0FC16E ) ; {1032582}
}

code_0FC190 {
    COP [9A] ( #$0000, &code_0FC19A, &code_0FC1C7, &code_0FC1C7 ) ; {1032592}
}

code_0FC19A {
    LDA $0016, X          ; {1032602}
    AND #$DFFF            ; {1032605}
    STA $0016, X          ; {1032608}
    COP [85] ( @code_0FC20D ) ; {1032611}
    COP [80] ( #2C )      ; {1032616}
    COP [82]              ; {1032619}
    COP [85] ( @code_0FC223 ) ; {1032621}
    COP [80] ( #2D )      ; {1032626}
    COP [82]              ; {1032629}
    COP [85] ( @code_0FC20D ) ; {1032631}
    LDA $0016, X          ; {1032636}
    ORA #$2000            ; {1032639}
    STA $0016, X          ; {1032642}
    BRA loc_0FC1F6        ; {1032645}
}

code_0FC1C7 {
    COP [96]              ; {1032647}
    LDA $0016, X          ; {1032649}
    AND #$DFFF            ; {1032652}
    STA $0016, X          ; {1032655}
    COP [85] ( @code_0FC20D ) ; {1032658}
    COP [80] ( #2C )      ; {1032663}
    COP [82]              ; {1032666}
    COP [85] ( @code_0FC229 ) ; {1032668}
    COP [80] ( #2D )      ; {1032673}
    COP [82]              ; {1032676}
    COP [85] ( @code_0FC20D ) ; {1032678}
    LDA $0016, X          ; {1032683}
    ORA #$2000            ; {1032686}
    STA $0016, X          ; {1032689}
    COP [97]              ; {1032692}

  loc_0FC1F6:
    COP [03] ( #78 )      ; {1032694}
    PHX                   ; {1032697}
    LDA $0030, X          ; {1032698}
    TAX                   ; {1032701}
    LDA $7F8000, X        ; {1032702}
    PLX                   ; {1032706}
    AND #$00FF            ; {1032707}
    BEQ loc_0FC26E        ; {1032710}
    COP [04]              ; {1032712}
    BRL code_0FC166       ; {1032714}
}

code_0FC20D {
    COP [28] ( &code_0FC213 ) ; {1032717}
    BRA loc_0FC220        ; {1032721}
}

code_0FC213 {
    LDA #$0300            ; {1032723}
    STA $0016, X          ; {1032726}
    COP [A4]              ; {1032729}
    COP [80] ( #2E )      ; {1032731}
    COP [82]              ; {1032734}

  loc_0FC220:
    COP [86]              ; {1032736}
    RTL                   ; {1032738}
}

code_0FC223 {
    COP [9F] ( #$FFF8 )   ; {1032739}
    BRA loc_0FC22D        ; {1032743}
}

code_0FC229 {
    COP [9F] ( #$0008 )   ; {1032745}

  loc_0FC22D:
    LDA #$0200            ; {1032749}
    STA $0016, X          ; {1032752}
    COP [A3]              ; {1032755}
    COP [A2] ( #30 )      ; {1032757}
    BRK #$5B              ; {1032760}
    COP [9B] ( #$0020, &code_0FC244, &code_0FC252, &code_0FC260 ) ; {1032762}
}

code_0FC244 {
    COP [81] ( #33, #0A ) ; {1032772}
    COP [83]              ; {1032776}
    COP [80] ( #39 )      ; {1032778}
    COP [82]              ; {1032781}
    COP [86]              ; {1032783}
    RTL                   ; {1032785}
}

code_0FC252 {
    COP [81] ( #32, #0A ) ; {1032786}
    COP [83]              ; {1032790}
    COP [80] ( #39 )      ; {1032792}
    COP [82]              ; {1032795}
    COP [86]              ; {1032797}
    RTL                   ; {1032799}
}

code_0FC260 {
    COP [81] ( #34, #0A ) ; {1032800}
    COP [83]              ; {1032804}
    COP [80] ( #39 )      ; {1032806}
    COP [82]              ; {1032809}
    COP [86]              ; {1032811}
    RTL                   ; {1032813}

  loc_0FC26E:
    LDA $0016, X          ; {1032814}
    AND #$DFFF            ; {1032817}
    STA $0016, X          ; {1032820}
    LDA $001C, X          ; {1032823}
    ASL                   ; {1032826}
    BMI loc_0FC283        ; {1032827}
    COP [23] ( &code_0FC289 ) ; {1032829}
    BRA loc_0FC28E        ; {1032833}

  loc_0FC283:
    COP [24] ( &code_0FC289 ) ; {1032835}
    BRA loc_0FC28E        ; {1032839}
}

code_0FC289 {
    COP [87]              ; {1032841}
    BRL code_0FC166       ; {1032843}

  loc_0FC28E:
    COP [80] ( #31 )      ; {1032846}
    COP [82]              ; {1032849}
    BRL code_0FC166       ; {1032851}
}

code_0FC296 {
    COP [AA] ( #02 )      ; {1032854}

  code_0FC299:
    LDA $0016, X          ; {1032857}
    BIT #$8000            ; {1032860}
    BEQ loc_0FC2A7        ; {1032863}

  code_0FC2A1:
    COP [1B] ( &code_0FC299, #$0008 ) ; {1032865}

  loc_0FC2A7:
    COP [9A] ( #$0010, &code_0FC2B1, &code_0FC2C3, &code_0FC2BA ) ; {1032871}
}

code_0FC2B1 {
    COP [97]              ; {1032881}
    COP [80] ( #13 )      ; {1032883}
    COP [82]              ; {1032886}
    BRA code_0FC303       ; {1032888}
}

code_0FC2BA {
    COP [96]              ; {1032890}
    COP [80] ( #13 )      ; {1032892}
    COP [82]              ; {1032895}
    BRA code_0FC303       ; {1032897}
}

code_0FC2C3 {
    COP [9B] ( #$0010, &code_0FC2CD, &code_0FC303, &code_0FC2E8 ) ; {1032899}
}

code_0FC2CD {
    COP [97]              ; {1032909}
    COP [81] ( #0F, #02 ) ; {1032911}
    COP [83]              ; {1032915}
    COP [81] ( #15, #02 ) ; {1032917}
    COP [83]              ; {1032921}
    COP [85] ( @code_0FC39C ) ; {1032923}
    COP [81] ( #0F, #02 ) ; {1032928}
    COP [83]              ; {1032932}
    BRA code_0FC303       ; {1032934}
}

code_0FC2E8 {
    COP [97]              ; {1032936}
    COP [81] ( #0E, #02 ) ; {1032938}
    COP [83]              ; {1032942}
    COP [81] ( #14, #02 ) ; {1032944}
    COP [83]              ; {1032948}
    COP [85] ( @code_0FC3B9 ) ; {1032950}
    COP [81] ( #0E, #02 ) ; {1032955}
    COP [83]              ; {1032959}
    BRA code_0FC303       ; {1032961}
}

code_0FC303 {
    COP [9B] ( #$0010, &code_0FC30D, &code_0FC320, &code_0FC316 ) ; {1032963}
}

code_0FC30D {
    COP [97]              ; {1032973}
    COP [80] ( #12 )      ; {1032975}
    COP [82]              ; {1032978}
    BRA code_0FC299       ; {1032980}
}

code_0FC316 {
    COP [97]              ; {1032982}
    COP [80] ( #11 )      ; {1032984}
    COP [82]              ; {1032987}
    BRL code_0FC299       ; {1032989}
}

code_0FC320 {
    COP [9A] ( #$0010, &code_0FC32A, &code_0FC2A1, &code_0FC346 ) ; {1032992}
}

code_0FC32A {
    COP [97]              ; {1033002}
    COP [81] ( #10, #02 ) ; {1033004}
    COP [83]              ; {1033008}
    COP [81] ( #16, #02 ) ; {1033010}
    COP [83]              ; {1033014}
    COP [85] ( @code_0FC362 ) ; {1033016}
    COP [81] ( #10, #02 ) ; {1033021}
    COP [83]              ; {1033025}
    BRL code_0FC2A1       ; {1033027}
}

code_0FC346 {
    COP [96]              ; {1033030}
    COP [81] ( #10, #02 ) ; {1033032}
    COP [83]              ; {1033036}
    COP [81] ( #16, #02 ) ; {1033038}
    COP [83]              ; {1033042}
    COP [85] ( @code_0FC37F ) ; {1033044}
    COP [81] ( #10, #02 ) ; {1033049}
    COP [83]              ; {1033053}
    BRL code_0FC2A1       ; {1033055}
}

code_0FC362 {
    JSR $&code_0FC3D6     ; {1033058}
    COP [80] ( #1B )      ; {1033061}
    COP [82]              ; {1033064}
    COP [A6]              ; {1033066}

  loc_0FC36C:
    COP [23] ( &code_0FC377 ) ; {1033068}
    COP [80] ( #37 )      ; {1033072}
    COP [82]              ; {1033075}
    BRA loc_0FC36C        ; {1033077}
}

code_0FC377 {
    COP [80] ( #38 )      ; {1033079}
    COP [82]              ; {1033082}
    COP [86]              ; {1033084}
    RTL                   ; {1033086}
}

code_0FC37F {
    JSR $&code_0FC3D6     ; {1033087}
    COP [80] ( #1B )      ; {1033090}
    COP [82]              ; {1033093}
    COP [A6]              ; {1033095}

  loc_0FC389:
    COP [24] ( &code_0FC394 ) ; {1033097}
    COP [80] ( #37 )      ; {1033101}
    COP [82]              ; {1033104}
    BRA loc_0FC389        ; {1033106}
}

code_0FC394 {
    COP [80] ( #38 )      ; {1033108}
    COP [82]              ; {1033111}
    COP [86]              ; {1033113}
    RTL                   ; {1033115}
}

code_0FC39C {
    JSR $&code_0FC3D6     ; {1033116}
    COP [80] ( #19 )      ; {1033119}
    COP [82]              ; {1033122}
    COP [A6]              ; {1033124}

  loc_0FC3A6:
    COP [21] ( &code_0FC3B1 ) ; {1033126}
    COP [80] ( #36 )      ; {1033130}
    COP [82]              ; {1033133}
    BRA loc_0FC3A6        ; {1033135}
}

code_0FC3B1 {
    COP [80] ( #38 )      ; {1033137}
    COP [82]              ; {1033140}
    COP [86]              ; {1033142}
    RTL                   ; {1033144}
}

code_0FC3B9 {
    JSR $&code_0FC3D6     ; {1033145}
    COP [80] ( #17 )      ; {1033148}
    COP [82]              ; {1033151}
    COP [A6]              ; {1033153}

  loc_0FC3C3:
    COP [22] ( &code_0FC3CE ) ; {1033155}
    COP [80] ( #35 )      ; {1033159}
    COP [82]              ; {1033162}
    BRA loc_0FC3C3        ; {1033164}
}

code_0FC3CE {
    COP [80] ( #38 )      ; {1033166}
    COP [82]              ; {1033169}
    COP [86]              ; {1033171}
    RTL                   ; {1033173}
}

code_0FC3D6 {
    LDA #$0202            ; {1033174}
    STA $0016, X          ; {1033177}
    COP [AA] ( #02 )      ; {1033180}
    COP [A3]              ; {1033183}
    COP [A0] ( #$FFEE )   ; {1033185}
    BRK #$61              ; {1033189}
    RTS                   ; {1033191}
}

code_0FC3E8 {
    LDA $001A, X          ; {1033192}
    ORA #$0400            ; {1033195}
    STA $001A, X          ; {1033198}
    COP [AA] ( #04 )      ; {1033201}

  code_0FC3F4:
    LDA $0016, X          ; {1033204}
    BIT #$8000            ; {1033207}
    BEQ loc_0FC402        ; {1033210}

  code_0FC3FC:
    COP [1B] ( &code_0FC3F4, #$0008 ) ; {1033212}

  loc_0FC402:
    COP [9A] ( #$0010, &code_0FC40C, &code_0FC41E, &code_0FC415 ) ; {1033218}
}

code_0FC40C {
    COP [97]              ; {1033228}
    COP [80] ( #13 )      ; {1033230}
    COP [82]              ; {1033233}
    BRA code_0FC458       ; {1033235}
}

code_0FC415 {
    COP [96]              ; {1033237}
    COP [80] ( #13 )      ; {1033239}
    COP [82]              ; {1033242}
    BRA code_0FC458       ; {1033244}
}

code_0FC41E {
    COP [9B] ( #$0010, &code_0FC428, &code_0FC458, &code_0FC440 ) ; {1033246}
}

code_0FC428 {
    COP [97]              ; {1033256}
    COP [80] ( #0F )      ; {1033258}
    COP [82]              ; {1033261}
    COP [80] ( #15 )      ; {1033263}
    COP [82]              ; {1033266}
    COP [85] ( @code_0FC4EA ) ; {1033268}
    COP [80] ( #0F )      ; {1033273}
    COP [82]              ; {1033276}
    BRA code_0FC458       ; {1033278}
}

code_0FC440 {
    COP [97]              ; {1033280}
    COP [80] ( #0E )      ; {1033282}
    COP [82]              ; {1033285}
    COP [80] ( #14 )      ; {1033287}
    COP [82]              ; {1033290}
    COP [85] ( @code_0FC507 ) ; {1033292}
    COP [80] ( #0E )      ; {1033297}
    COP [82]              ; {1033300}
    BRA code_0FC458       ; {1033302}
}

code_0FC458 {
    COP [9B] ( #$0010, &code_0FC462, &code_0FC474, &code_0FC46B ) ; {1033304}
}

code_0FC462 {
    COP [97]              ; {1033314}
    COP [80] ( #12 )      ; {1033316}
    COP [82]              ; {1033319}
    BRA code_0FC3F4       ; {1033321}
}

code_0FC46B {
    COP [97]              ; {1033323}
    COP [80] ( #11 )      ; {1033325}
    COP [82]              ; {1033328}
    BRA code_0FC3F4       ; {1033330}
}

code_0FC474 {
    COP [9A] ( #$0010, &code_0FC47E, &code_0FC3FC, &code_0FC497 ) ; {1033332}
}

code_0FC47E {
    COP [97]              ; {1033342}
    COP [80] ( #10 )      ; {1033344}
    COP [82]              ; {1033347}
    COP [80] ( #16 )      ; {1033349}
    COP [82]              ; {1033352}
    COP [85] ( @code_0FC4B0 ) ; {1033354}
    COP [80] ( #10 )      ; {1033359}
    COP [82]              ; {1033362}
    BRL code_0FC3FC       ; {1033364}
}

code_0FC497 {
    COP [96]              ; {1033367}
    COP [80] ( #10 )      ; {1033369}
    COP [82]              ; {1033372}
    COP [80] ( #16 )      ; {1033374}
    COP [82]              ; {1033377}
    COP [85] ( @code_0FC4CD ) ; {1033379}
    COP [80] ( #10 )      ; {1033384}
    COP [82]              ; {1033387}
    BRL code_0FC3FC       ; {1033389}
}

code_0FC4B0 {
    JSR $&code_0FC524     ; {1033392}
    COP [80] ( #1B )      ; {1033395}
    COP [82]              ; {1033398}
    COP [A6]              ; {1033400}

  loc_0FC4BA:
    COP [23] ( &code_0FC4C5 ) ; {1033402}
    COP [80] ( #37 )      ; {1033406}
    COP [82]              ; {1033409}
    BRA loc_0FC4BA        ; {1033411}
}

code_0FC4C5 {
    COP [80] ( #38 )      ; {1033413}
    COP [82]              ; {1033416}
    COP [86]              ; {1033418}
    RTL                   ; {1033420}
}

code_0FC4CD {
    JSR $&code_0FC524     ; {1033421}
    COP [80] ( #1B )      ; {1033424}
    COP [82]              ; {1033427}
    COP [A6]              ; {1033429}

  loc_0FC4D7:
    COP [24] ( &code_0FC4E2 ) ; {1033431}
    COP [80] ( #37 )      ; {1033435}
    COP [82]              ; {1033438}
    BRA loc_0FC4D7        ; {1033440}
}

code_0FC4E2 {
    COP [80] ( #38 )      ; {1033442}
    COP [82]              ; {1033445}
    COP [86]              ; {1033447}
    RTL                   ; {1033449}
}

code_0FC4EA {
    JSR $&code_0FC524     ; {1033450}
    COP [80] ( #19 )      ; {1033453}
    COP [82]              ; {1033456}
    COP [A6]              ; {1033458}

  loc_0FC4F4:
    COP [21] ( &code_0FC4FF ) ; {1033460}
    COP [80] ( #36 )      ; {1033464}
    COP [82]              ; {1033467}
    BRA loc_0FC4F4        ; {1033469}
}

code_0FC4FF {
    COP [80] ( #38 )      ; {1033471}
    COP [82]              ; {1033474}
    COP [86]              ; {1033476}
    RTL                   ; {1033478}
}

code_0FC507 {
    JSR $&code_0FC524     ; {1033479}
    COP [80] ( #17 )      ; {1033482}
    COP [82]              ; {1033485}
    COP [A6]              ; {1033487}

  loc_0FC511:
    COP [22] ( &code_0FC51C ) ; {1033489}
    COP [80] ( #35 )      ; {1033493}
    COP [82]              ; {1033496}
    BRA loc_0FC511        ; {1033498}
}

code_0FC51C {
    COP [80] ( #38 )      ; {1033500}
    COP [82]              ; {1033503}
    COP [86]              ; {1033505}
    RTL                   ; {1033507}
}

code_0FC524 {
    LDA #$0202            ; {1033508}
    STA $0016, X          ; {1033511}
    COP [AA] ( #04 )      ; {1033514}
    COP [A3]              ; {1033517}
    COP [A0] ( #$FFEE )   ; {1033519}
    BRK #$61              ; {1033523}
    RTS                   ; {1033525}
}

code_0FC536 {
    COP [A3]              ; {1033526}
    COP [A2] ( #30 )      ; {1033528}

  code_0FC53B:
    COP [0C] ( #00, #10, &code_0FC547 ) ; {1033531}
    COP [1B] ( &code_0FC53B, #$0010 ) ; {1033537}
}

code_0FC547 {
    COP [9A] ( #$0018, &code_0FC551, &code_0FC619, &code_0FC55B ) ; {1033543}
}

code_0FC551 {
    COP [9B] ( #$0018, &code_0FC5BF, &code_0FC6AA, &code_0FC5EC ) ; {1033553}
}

code_0FC55B {
    COP [9B] ( #$0018, &code_0FC565, &code_0FC67D, &code_0FC592 ) ; {1033563}
}

code_0FC565 {
    COP [96]              ; {1033573}
    COP [81] ( #25, #04 ) ; {1033575}
    COP [83]              ; {1033579}
    COP [0C] ( #00, #04, &code_0FC575 ) ; {1033581}
    BRA loc_0FC589        ; {1033587}
}

code_0FC575 {
    COP [80] ( #26 )      ; {1033589}
    COP [82]              ; {1033592}
    COP [85] ( @code_0FC6D7 ) ; {1033594}
    COP [80] ( #27 )      ; {1033599}
    COP [82]              ; {1033602}
    COP [80] ( #28 )      ; {1033604}
    COP [82]              ; {1033607}

  loc_0FC589:
    COP [81] ( #25, #04 ) ; {1033609}
    COP [83]              ; {1033613}
    BRL code_0FC53B       ; {1033615}
}

code_0FC592 {
    COP [96]              ; {1033618}
    COP [81] ( #24, #04 ) ; {1033620}
    COP [83]              ; {1033624}
    COP [0C] ( #00, #04, &code_0FC5A2 ) ; {1033626}
    BRA loc_0FC5B6        ; {1033632}
}

code_0FC5A2 {
    COP [80] ( #26 )      ; {1033634}
    COP [82]              ; {1033637}
    COP [85] ( @code_0FC6D7 ) ; {1033639}
    COP [80] ( #27 )      ; {1033644}
    COP [82]              ; {1033647}
    COP [80] ( #28 )      ; {1033649}
    COP [82]              ; {1033652}

  loc_0FC5B6:
    COP [81] ( #24, #04 ) ; {1033654}
    COP [83]              ; {1033658}
    BRL code_0FC53B       ; {1033660}
}

code_0FC5BF {
    COP [97]              ; {1033663}
    COP [81] ( #25, #04 ) ; {1033665}
    COP [83]              ; {1033669}
    COP [0C] ( #00, #04, &code_0FC5CF ) ; {1033671}
    BRA loc_0FC5E3        ; {1033677}
}

code_0FC5CF {
    COP [80] ( #26 )      ; {1033679}
    COP [82]              ; {1033682}
    COP [85] ( @code_0FC6D7 ) ; {1033684}
    COP [80] ( #27 )      ; {1033689}
    COP [82]              ; {1033692}
    COP [80] ( #28 )      ; {1033694}
    COP [82]              ; {1033697}

  loc_0FC5E3:
    COP [81] ( #25, #04 ) ; {1033699}
    COP [83]              ; {1033703}
    BRL code_0FC53B       ; {1033705}
}

code_0FC5EC {
    COP [97]              ; {1033708}
    COP [81] ( #24, #04 ) ; {1033710}
    COP [83]              ; {1033714}
    COP [0C] ( #00, #04, &code_0FC5FC ) ; {1033716}
    BRA loc_0FC610        ; {1033722}
}

code_0FC5FC {
    COP [80] ( #26 )      ; {1033724}
    COP [82]              ; {1033727}
    COP [85] ( @code_0FC6D7 ) ; {1033729}
    COP [80] ( #27 )      ; {1033734}
    COP [82]              ; {1033737}
    COP [80] ( #28 )      ; {1033739}
    COP [82]              ; {1033742}

  loc_0FC610:
    COP [81] ( #24, #04 ) ; {1033744}
    COP [83]              ; {1033748}
    BRL code_0FC53B       ; {1033750}
}

code_0FC619 {
    COP [9B] ( #$0000, &code_0FC650, &code_0FC650, &code_0FC623 ) ; {1033753}
}

code_0FC623 {
    COP [97]              ; {1033763}
    COP [81] ( #21, #04 ) ; {1033765}
    COP [83]              ; {1033769}
    COP [0C] ( #00, #04, &code_0FC633 ) ; {1033771}
    BRA loc_0FC647        ; {1033777}
}

code_0FC633 {
    COP [80] ( #26 )      ; {1033779}
    COP [82]              ; {1033782}
    COP [85] ( @code_0FC6D7 ) ; {1033784}
    COP [80] ( #27 )      ; {1033789}
    COP [82]              ; {1033792}
    COP [80] ( #28 )      ; {1033794}
    COP [82]              ; {1033797}

  loc_0FC647:
    COP [81] ( #21, #04 ) ; {1033799}
    COP [83]              ; {1033803}
    BRL code_0FC53B       ; {1033805}
}

code_0FC650 {
    COP [97]              ; {1033808}
    COP [81] ( #22, #04 ) ; {1033810}
    COP [83]              ; {1033814}
    COP [0C] ( #00, #04, &code_0FC660 ) ; {1033816}
    BRA loc_0FC674        ; {1033822}
}

code_0FC660 {
    COP [80] ( #26 )      ; {1033824}
    COP [82]              ; {1033827}
    COP [85] ( @code_0FC6D7 ) ; {1033829}
    COP [80] ( #27 )      ; {1033834}
    COP [82]              ; {1033837}
    COP [80] ( #28 )      ; {1033839}
    COP [82]              ; {1033842}

  loc_0FC674:
    COP [81] ( #22, #04 ) ; {1033844}
    COP [83]              ; {1033848}
    BRL code_0FC53B       ; {1033850}
}

code_0FC67D {
    COP [96]              ; {1033853}
    COP [81] ( #23, #04 ) ; {1033855}
    COP [83]              ; {1033859}
    COP [0C] ( #00, #04, &code_0FC68D ) ; {1033861}
    BRA loc_0FC6A1        ; {1033867}
}

code_0FC68D {
    COP [80] ( #26 )      ; {1033869}
    COP [82]              ; {1033872}
    COP [85] ( @code_0FC6D7 ) ; {1033874}
    COP [80] ( #27 )      ; {1033879}
    COP [82]              ; {1033882}
    COP [80] ( #28 )      ; {1033884}
    COP [82]              ; {1033887}

  loc_0FC6A1:
    COP [81] ( #23, #04 ) ; {1033889}
    COP [83]              ; {1033893}
    BRL code_0FC53B       ; {1033895}
}

code_0FC6AA {
    COP [97]              ; {1033898}
    COP [81] ( #23, #04 ) ; {1033900}
    COP [83]              ; {1033904}
    COP [0C] ( #00, #04, &code_0FC6BA ) ; {1033906}
    BRA loc_0FC6CE        ; {1033912}
}

code_0FC6BA {
    COP [80] ( #26 )      ; {1033914}
    COP [82]              ; {1033917}
    COP [85] ( @code_0FC6D7 ) ; {1033919}
    COP [80] ( #27 )      ; {1033924}
    COP [82]              ; {1033927}
    COP [80] ( #28 )      ; {1033929}
    COP [82]              ; {1033932}

  loc_0FC6CE:
    COP [81] ( #23, #04 ) ; {1033934}
    COP [83]              ; {1033938}
    BRL code_0FC53B       ; {1033940}
}

code_0FC6D7 {
    LDA #$0200            ; {1033943}
    STA $0016, X          ; {1033946}
    COP [A0] ( #$001C )   ; {1033949}
    BRK #$56              ; {1033953}
    COP [80] ( #29 )      ; {1033955}
    COP [82]              ; {1033958}
    COP [9A] ( #$0000, &code_0FC6F2, &code_0FC6FC, &code_0FC6FC ) ; {1033960}
}

code_0FC6F2 {
    COP [9B] ( #$0000, &code_0FC706, &code_0FC710, &code_0FC710 ) ; {1033970}
}

code_0FC6FC {
    COP [9B] ( #$0000, &code_0FC71A, &code_0FC724, &code_0FC724 ) ; {1033980}
}

code_0FC706 {
    COP [97]              ; {1033990}
    COP [81] ( #2B, #08 ) ; {1033992}
    COP [83]              ; {1033996}
    BRA loc_0FC72C        ; {1033998}
}

code_0FC710 {
    COP [97]              ; {1034000}
    COP [81] ( #2A, #08 ) ; {1034002}
    COP [83]              ; {1034006}
    BRA loc_0FC72C        ; {1034008}
}

code_0FC71A {
    COP [96]              ; {1034010}
    COP [81] ( #2B, #08 ) ; {1034012}
    COP [83]              ; {1034016}
    BRA loc_0FC72C        ; {1034018}
}

code_0FC724 {
    COP [96]              ; {1034020}
    COP [81] ( #2A, #08 ) ; {1034022}
    COP [83]              ; {1034026}

  loc_0FC72C:
    COP [86]              ; {1034028}
    RTL                   ; {1034030}
}

code_0FC72F {
    COP [A4]              ; {1034031}
    COP [A5] ( &code_0FC766, &code_0FC7BC, &code_0FC791, &code_0FC73B ) ; {1034033}
}

code_0FC73B {
    COP [AD] ( #08 )      ; {1034043}
    COP [0C] ( #00, #02, &code_0FC7E7 ) ; {1034046}
    COP [21] ( &code_0FC773 ) ; {1034052}

  code_0FC748:
    COP [80] ( #09 )      ; {1034056}
    COP [82]              ; {1034059}
    COP [85] ( @code_0FC835 ) ; {1034061}
    COP [A0] ( #$FFF8 )   ; {1034066}
    COP [80] ( #09 )      ; {1034070}
    COP [82]              ; {1034073}
    COP [85] ( @code_0FC835 ) ; {1034075}
    COP [A0] ( #$FFF8 )   ; {1034080}
    BRA code_0FC73B       ; {1034084}
}

code_0FC766 {
    COP [AD] ( #08 )      ; {1034086}
    COP [0C] ( #00, #02, &code_0FC7E7 ) ; {1034089}
    COP [22] ( &code_0FC748 ) ; {1034095}
}

code_0FC773 {
    COP [80] ( #09 )      ; {1034099}
    COP [82]              ; {1034102}
    COP [85] ( @code_0FC835 ) ; {1034104}
    COP [A0] ( #$0008 )   ; {1034109}
    COP [80] ( #09 )      ; {1034113}
    COP [82]              ; {1034116}
    COP [85] ( @code_0FC835 ) ; {1034118}
    COP [A0] ( #$0008 )   ; {1034123}
    BRA code_0FC766       ; {1034127}
}

code_0FC791 {
    COP [AD] ( #08 )      ; {1034129}
    COP [0C] ( #00, #02, &code_0FC7E7 ) ; {1034132}
    COP [24] ( &code_0FC7C9 ) ; {1034138}

  code_0FC79E:
    COP [80] ( #09 )      ; {1034142}
    COP [82]              ; {1034145}
    COP [85] ( @code_0FC835 ) ; {1034147}
    COP [9F] ( #$0008 )   ; {1034152}
    COP [80] ( #09 )      ; {1034156}
    COP [82]              ; {1034159}
    COP [85] ( @code_0FC835 ) ; {1034161}
    COP [9F] ( #$0008 )   ; {1034166}
    BRA code_0FC791       ; {1034170}
}

code_0FC7BC {
    COP [AD] ( #08 )      ; {1034172}
    COP [0C] ( #00, #02, &code_0FC7E7 ) ; {1034175}
    COP [23] ( &code_0FC79E ) ; {1034181}
}

code_0FC7C9 {
    COP [80] ( #09 )      ; {1034185}
    COP [82]              ; {1034188}
    COP [85] ( @code_0FC835 ) ; {1034190}
    COP [9F] ( #$FFF8 )   ; {1034195}
    COP [80] ( #09 )      ; {1034199}
    COP [82]              ; {1034202}
    COP [85] ( @code_0FC835 ) ; {1034204}
    COP [9F] ( #$FFF8 )   ; {1034209}
    BRA code_0FC7BC       ; {1034213}
}

code_0FC7E7 {
    COP [A7]              ; {1034215}
    COP [80] ( #0B )      ; {1034217}
    COP [82]              ; {1034220}
    LDA #$1000            ; {1034222}
    STA $0016, X          ; {1034225}

  loc_0FC7F4:
    COP [AD] ( #08 )      ; {1034228}
    COP [9C] ( &code_0FC7FD, &code_0FC819 ) ; {1034231}
}

code_0FC7FD {
    COP [9A] ( #$0010, &code_0FC807, &code_0FC810, &code_0FC810 ) ; {1034237}
}

code_0FC807 {
    COP [97]              ; {1034247}
    COP [80] ( #0E )      ; {1034249}
    COP [82]              ; {1034252}
    BRA loc_0FC7F4        ; {1034254}
}

code_0FC810 {
    COP [96]              ; {1034256}
    COP [80] ( #0E )      ; {1034258}
    COP [82]              ; {1034261}
    BRA loc_0FC7F4        ; {1034263}
}

code_0FC819 {
    COP [9B] ( #$0010, &code_0FC823, &code_0FC82C, &code_0FC82C ) ; {1034265}
}

code_0FC823 {
    COP [97]              ; {1034275}
    COP [80] ( #0D )      ; {1034277}
    COP [82]              ; {1034280}
    BRA loc_0FC7F4        ; {1034282}
}

code_0FC82C {
    COP [97]              ; {1034284}
    COP [80] ( #0C )      ; {1034286}
    COP [82]              ; {1034289}
    BRA loc_0FC7F4        ; {1034291}
}

code_0FC835 {
    LDA #$0300            ; {1034293}
    STA $0016, X          ; {1034296}
    COP [A4]              ; {1034299}
    COP [80] ( #0A )      ; {1034301}
    COP [82]              ; {1034304}
    COP [86]              ; {1034306}
    RTL                   ; {1034308}
}

code_0FC845 {
    COP [AD] ( #08 )      ; {1034309}
    COP [0C] ( #00, #02, &code_0FC854 ) ; {1034312}
    COP [1B] ( &code_0FC845, #$0008 ) ; {1034318}
}

code_0FC854 {
    COP [80] ( #29 )      ; {1034324}
    COP [82]              ; {1034327}
    COP [80] ( #1F )      ; {1034329}
    COP [82]              ; {1034332}

  loc_0FC85E:
    COP [AD] ( #08 )      ; {1034334}
    COP [80] ( #20 )      ; {1034337}
    COP [82]              ; {1034340}
    COP [9A] ( #$0018, &code_0FC884, &code_0FC870, &code_0FC895 ) ; {1034342}
}

code_0FC870 {
    COP [9B] ( #$0000, &code_0FC8A6, &code_0FC8B7, &code_0FC8B7 ) ; {1034352}

  code_0FC87A:
    COP [9A] ( #$0000, &code_0FC884, &code_0FC895, &code_0FC895 ) ; {1034362}
}

code_0FC884 {
    COP [23] ( &code_0FC88F ) ; {1034372}
    COP [80] ( #24 )      ; {1034376}
    COP [82]              ; {1034379}
    BRA loc_0FC8C8        ; {1034381}
}

code_0FC88F {
    COP [1B] ( &code_0FC870, #$0008 ) ; {1034383}
}

code_0FC895 {
    COP [24] ( &code_0FC8A0 ) ; {1034389}
    COP [80] ( #23 )      ; {1034393}
    COP [82]              ; {1034396}
    BRA loc_0FC8C8        ; {1034398}
}

code_0FC8A0 {
    COP [1B] ( &code_0FC870, #$0008 ) ; {1034400}
}

code_0FC8A6 {
    COP [21] ( &code_0FC8B1 ) ; {1034406}
    COP [80] ( #22 )      ; {1034410}
    COP [82]              ; {1034413}
    BRA loc_0FC8C8        ; {1034415}
}

code_0FC8B1 {
    COP [1B] ( &code_0FC87A, #$0008 ) ; {1034417}
}

code_0FC8B7 {
    COP [22] ( &code_0FC8C2 ) ; {1034423}
    COP [80] ( #21 )      ; {1034427}
    COP [82]              ; {1034430}
    BRA loc_0FC8C8        ; {1034432}
}

code_0FC8C2 {
    COP [1B] ( &code_0FC87A, #$0008 ) ; {1034434}

  loc_0FC8C8:
    COP [80] ( #25 )      ; {1034440}
    COP [82]              ; {1034443}
    COP [0C] ( #00, #04, &code_0FC8D5 ) ; {1034445}
    BRA loc_0FC85E        ; {1034451}
}

code_0FC8D5 {
    COP [85] ( @code_0FC8F0 ) ; {1034453}
    LDA #$0200            ; {1034458}
    STA $0016, X          ; {1034461}
    COP [80] ( #27 )      ; {1034464}
    COP [82]              ; {1034467}
    STZ $0016, X          ; {1034469}
    COP [80] ( #1F )      ; {1034472}
    COP [82]              ; {1034475}
    BRL loc_0FC85E        ; {1034477}
}

code_0FC8F0 {
    LDA #$0200            ; {1034480}
    STA $0016, X          ; {1034483}
    COP [80] ( #26 )      ; {1034486}
    COP [82]              ; {1034489}
    COP [86]              ; {1034491}
    RTL                   ; {1034493}
}

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

code_0FC9BC {
    COP [A5] ( &code_0FC9C6, &code_0FC9CF, &code_0FC9D6, &code_0FC9DD ) ; {1034684}
}

code_0FC9C6 {
    COP [96]              ; {1034694}
    COP [80] ( #0F )      ; {1034696}
    COP [82]              ; {1034699}
    BRA loc_0FC9E4        ; {1034701}
}

code_0FC9CF {
    COP [80] ( #10 )      ; {1034703}
    COP [82]              ; {1034706}
    BRA loc_0FC9E4        ; {1034708}
}

code_0FC9D6 {
    COP [80] ( #0F )      ; {1034710}
    COP [82]              ; {1034713}
    BRA loc_0FC9E4        ; {1034715}
}

code_0FC9DD {
    COP [96]              ; {1034717}
    COP [80] ( #10 )      ; {1034719}
    COP [82]              ; {1034722}

  loc_0FC9E4:
    COP [AD] ( #08 )      ; {1034724}
    COP [03] ( #08 )      ; {1034727}
    COP [80] ( #33 )      ; {1034730}
    COP [82]              ; {1034733}
    COP [0C] ( #00, #03, &code_0FCA05 ) ; {1034735}
    COP [04]              ; {1034741}
    COP [80] ( #11 )      ; {1034743}
    COP [82]              ; {1034746}
    COP [B0] ( @code_0FCA1F, #$0200 ) ; {1034748}
    BRA loc_0FC9E4        ; {1034755}
}

code_0FCA05 {
    COP [8F]              ; {1034757}
    COP [9B] ( #$0000, &code_0FCA11, &code_0FCA18, &code_0FCA18 ) ; {1034759}
}

code_0FCA11 {
    COP [80] ( #10 )      ; {1034769}
    COP [82]              ; {1034772}
    BRA loc_0FC9E4        ; {1034774}
}

code_0FCA18 {
    COP [80] ( #0F )      ; {1034776}
    COP [82]              ; {1034779}
    BRA loc_0FC9E4        ; {1034781}
}

code_0FCA1F {
    COP [A3]              ; {1034783}
    COP [A2] ( #30 )      ; {1034785}
    BRK #$64              ; {1034788}
    LDY #$002A            ; {1034790}
    SEP #$20              ; {1034793}
    LDA #$^chunk_000000.code_002D67 ; {1034795}
    PHA                   ; {1034797}
    REP #$20              ; {1034798}
    LDA #$&chunk_000000.code_002D67-1 ; {1034800}
    PHA                   ; {1034803}
    RTL                   ; {1034804}
}

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

code_0FCBDF {
    COP [AA] ( #00 )      ; {1035231}

  code_0FCBE2:
    LDA $0016, X          ; {1035234}
    BIT #$8000            ; {1035237}
    BNE loc_0FCBF0        ; {1035240}
    COP [0C] ( #00, #05, &code_0FCD52 ) ; {1035242}

  loc_0FCBF0:
    COP [1B] ( &code_0FCBE2, #$0010 ) ; {1035248}

  code_0FCBF6:
    COP [1F]              ; {1035254}
    LDA $0302             ; {1035256}
    AND #$0003            ; {1035259}
    BEQ loc_0FCC0F        ; {1035262}
    DEC                   ; {1035264}
    BEQ loc_0FCC5F        ; {1035265}
    DEC                   ; {1035267}
    BNE loc_0FCC09        ; {1035268}
    BRL loc_0FCCB2        ; {1035270}

  loc_0FCC09:
    DEC                   ; {1035273}
    BNE loc_0FCC0F        ; {1035274}
    BRL loc_0FCD04        ; {1035276}

  loc_0FCC0F:
    LDA $0374             ; {1035279}
    STA $0000, X          ; {1035282}
    LDA $0376             ; {1035285}
    SEC                   ; {1035288}
    SBC #$0040            ; {1035289}
    BPL loc_0FCC21        ; {1035292}
    BRL code_0FCD69       ; {1035294}

  loc_0FCC21:
    AND #$FFF0            ; {1035297}
    STA $0002, X          ; {1035300}
    COP [28] ( &code_0FCD69 ) ; {1035303}
    LDA $0016, X          ; {1035307}
    AND #$DFFF            ; {1035310}
    STA $0016, X          ; {1035313}
    COP [80] ( #0A )      ; {1035316}
    COP [82]              ; {1035319}
    LDA $0016, X          ; {1035321}
    AND #$FDFF            ; {1035324}
    STA $0016, X          ; {1035327}
    COP [80] ( #00 )      ; {1035330}
    COP [82]              ; {1035333}
    COP [81] ( #03, #04 ) ; {1035335}
    COP [83]              ; {1035339}
    COP [85] ( @code_0FCD7A ) ; {1035341}
    COP [80] ( #04 )      ; {1035346}
    COP [82]              ; {1035349}
    COP [80] ( #00 )      ; {1035351}
    COP [82]              ; {1035354}
    BRL code_0FCD52       ; {1035356}

  loc_0FCC5F:
    LDA $0374             ; {1035359}
    STA $0000, X          ; {1035362}
    LDA $0376             ; {1035365}
    CLC                   ; {1035368}
    ADC #$0040            ; {1035369}
    CMP $0344             ; {1035372}
    BCC loc_0FCC74        ; {1035375}
    BRL code_0FCD69       ; {1035377}

  loc_0FCC74:
    AND #$FFF0            ; {1035380}
    STA $0002, X          ; {1035383}
    COP [28] ( &code_0FCD69 ) ; {1035386}
    LDA $0016, X          ; {1035390}
    AND #$DFFF            ; {1035393}
    STA $0016, X          ; {1035396}
    COP [80] ( #0A )      ; {1035399}
    COP [82]              ; {1035402}
    LDA $0016, X          ; {1035404}
    AND #$FDFF            ; {1035407}
    STA $0016, X          ; {1035410}
    COP [80] ( #01 )      ; {1035413}
    COP [82]              ; {1035416}
    COP [81] ( #05, #04 ) ; {1035418}
    COP [83]              ; {1035422}
    COP [85] ( @code_0FCD6F ) ; {1035424}
    COP [80] ( #06 )      ; {1035429}
    COP [82]              ; {1035432}
    COP [80] ( #01 )      ; {1035434}
    COP [82]              ; {1035437}
    BRL code_0FCD52       ; {1035439}

  loc_0FCCB2:
    LDA $0374             ; {1035442}
    CLC                   ; {1035445}
    ADC #$0040            ; {1035446}
    CMP $0342             ; {1035449}
    BCC loc_0FCCC1        ; {1035452}
    BRL code_0FCD69       ; {1035454}

  loc_0FCCC1:
    AND #$FFF0            ; {1035457}
    STA $0000, X          ; {1035460}
    LDA $0376             ; {1035463}
    STA $0002, X          ; {1035466}
    COP [28] ( &code_0FCD69 ) ; {1035469}
    LDA $0016, X          ; {1035473}
    AND #$DFFF            ; {1035476}
    STA $0016, X          ; {1035479}
    COP [80] ( #0A )      ; {1035482}
    COP [82]              ; {1035485}
    LDA $0016, X          ; {1035487}
    AND #$FDFF            ; {1035490}
    STA $0016, X          ; {1035493}
    COP [80] ( #02 )      ; {1035496}
    COP [82]              ; {1035499}
    COP [81] ( #07, #04 ) ; {1035501}
    COP [83]              ; {1035505}
    COP [85] ( @code_0FCD83 ) ; {1035507}
    COP [80] ( #08 )      ; {1035512}
    COP [82]              ; {1035515}
    COP [80] ( #02 )      ; {1035517}
    COP [82]              ; {1035520}
    BRA code_0FCD52       ; {1035522}

  loc_0FCD04:
    LDA $0374             ; {1035524}
    SEC                   ; {1035527}
    SBC #$0040            ; {1035528}
    BMI code_0FCD69       ; {1035531}
    AND #$FFF0            ; {1035533}
    STA $0000, X          ; {1035536}
    LDA $0376             ; {1035539}
    STA $0002, X          ; {1035542}
    COP [28] ( &code_0FCD69 ) ; {1035545}
    LDA $0016, X          ; {1035549}
    AND #$DFFF            ; {1035552}
    STA $0016, X          ; {1035555}
    COP [80] ( #0A )      ; {1035558}
    COP [82]              ; {1035561}
    LDA $0016, X          ; {1035563}
    AND #$FDFF            ; {1035566}
    STA $0016, X          ; {1035569}
    COP [96]              ; {1035572}
    COP [80] ( #02 )      ; {1035574}
    COP [82]              ; {1035577}
    COP [81] ( #07, #04 ) ; {1035579}
    COP [83]              ; {1035583}
    COP [85] ( @code_0FCD8E ) ; {1035585}
    COP [80] ( #08 )      ; {1035590}
    COP [82]              ; {1035593}
    COP [80] ( #02 )      ; {1035595}
    COP [82]              ; {1035598}
    COP [97]              ; {1035600}
}

code_0FCD52 {
    LDA $0016, X          ; {1035602}
    ORA #$0200            ; {1035605}
    STA $0016, X          ; {1035608}
    COP [80] ( #09 )      ; {1035611}
    COP [82]              ; {1035614}
    LDA $0016, X          ; {1035616}
    ORA #$2000            ; {1035619}
    STA $0016, X          ; {1035622}
}

code_0FCD69 {
    COP [1B] ( &code_0FCBF6, #$0020 ) ; {1035625}
}

code_0FCD6F {
    COP [A1] ( #$0002, #$FFF8 ) ; {1035631}
    LDA #$000C            ; {1035637}
    BRA loc_0FCD97        ; {1035640}
}

code_0FCD7A {
    COP [9F] ( #$FFFF )   ; {1035642}
    LDA #$000B            ; {1035646}
    BRA loc_0FCD97        ; {1035649}
}

code_0FCD83 {
    COP [A1] ( #$FFF7, #$FFFC ) ; {1035651}
    LDA #$000D            ; {1035657}
    BRA loc_0FCD97        ; {1035660}
}

code_0FCD8E {
    COP [A1] ( #$0009, #$FFFC ) ; {1035662}
    LDA #$000D            ; {1035668}

  loc_0FCD97:
    STA $001E, X          ; {1035671}
    STZ $0020, X          ; {1035674}
    LDA #$0200            ; {1035677}
    STA $0016, X          ; {1035680}
    COP [AA] ( #00 )      ; {1035683}
    COP [A3]              ; {1035686}
    COP [A2] ( #30 )      ; {1035688}
    LDA #$0010            ; {1035691}
    STA $002A, X          ; {1035694}
    BRK #$52              ; {1035697}
    COP [91]              ; {1035699}
    COP [83]              ; {1035701}
    COP [86]              ; {1035703}
    RTL                   ; {1035705}
}

code_0FCDBA {
    COP [AA] ( #02 )      ; {1035706}

  code_0FCDBD:
    LDA $0016, X          ; {1035709}
    BIT #$8000            ; {1035712}
    BNE loc_0FCDCB        ; {1035715}
    COP [0C] ( #00, #05, &code_0FCF55 ) ; {1035717}

  loc_0FCDCB:
    COP [1B] ( &code_0FCDBD, #$0010 ) ; {1035723}

  code_0FCDD1:
    COP [1F]              ; {1035729}
    LDA $0302             ; {1035731}
    AND #$0003            ; {1035734}
    BEQ loc_0FCDEA        ; {1035737}
    DEC                   ; {1035739}
    BEQ loc_0FCE44        ; {1035740}
    DEC                   ; {1035742}
    BNE loc_0FCDE4        ; {1035743}
    BRL loc_0FCEA1        ; {1035745}

  loc_0FCDE4:
    DEC                   ; {1035748}
    BNE loc_0FCDEA        ; {1035749}
    BRL loc_0FCEFD        ; {1035751}

  loc_0FCDEA:
    LDA $0374             ; {1035754}
    STA $0000, X          ; {1035757}
    LDA $0376             ; {1035760}
    SEC                   ; {1035763}
    SBC #$0020            ; {1035764}
    BPL loc_0FCDFC        ; {1035767}
    BRL code_0FCF6C       ; {1035769}

  loc_0FCDFC:
    AND #$FFF0            ; {1035772}
    STA $0002, X          ; {1035775}
    COP [28] ( &code_0FCF6C ) ; {1035778}
    LDA $0016, X          ; {1035782}
    AND #$DFFF            ; {1035785}
    STA $0016, X          ; {1035788}
    COP [80] ( #0A )      ; {1035791}
    COP [82]              ; {1035794}
    LDA $0016, X          ; {1035796}
    AND #$FDFF            ; {1035799}
    STA $0016, X          ; {1035802}
    COP [80] ( #00 )      ; {1035805}
    COP [82]              ; {1035808}
    COP [81] ( #03, #04 ) ; {1035810}
    COP [83]              ; {1035814}
    COP [85] ( @code_0FCF87 ) ; {1035816}
    COP [85] ( @code_0FCF8E ) ; {1035821}
    COP [85] ( @code_0FCF95 ) ; {1035826}
    COP [80] ( #04 )      ; {1035831}
    COP [82]              ; {1035834}
    COP [80] ( #00 )      ; {1035836}
    COP [82]              ; {1035839}
    BRL code_0FCF55       ; {1035841}

  loc_0FCE44:
    LDA $0374             ; {1035844}
    STA $0000, X          ; {1035847}
    LDA $0376             ; {1035850}
    CLC                   ; {1035853}
    ADC #$0020            ; {1035854}
    CMP $0344             ; {1035857}
    BCC loc_0FCE59        ; {1035860}
    BRL code_0FCF6C       ; {1035862}

  loc_0FCE59:
    AND #$FFF0            ; {1035865}
    STA $0002, X          ; {1035868}
    COP [28] ( &code_0FCF6C ) ; {1035871}
    LDA $0016, X          ; {1035875}
    AND #$DFFF            ; {1035878}
    STA $0016, X          ; {1035881}
    COP [80] ( #0A )      ; {1035884}
    COP [82]              ; {1035887}
    LDA $0016, X          ; {1035889}
    AND #$FDFF            ; {1035892}
    STA $0016, X          ; {1035895}
    COP [80] ( #01 )      ; {1035898}
    COP [82]              ; {1035901}
    COP [81] ( #05, #04 ) ; {1035903}
    COP [83]              ; {1035907}
    COP [85] ( @code_0FCF72 ) ; {1035909}
    COP [85] ( @code_0FCF79 ) ; {1035914}
    COP [85] ( @code_0FCFA3 ) ; {1035919}
    COP [80] ( #06 )      ; {1035924}
    COP [82]              ; {1035927}
    COP [80] ( #01 )      ; {1035929}
    COP [82]              ; {1035932}
    BRL code_0FCF55       ; {1035934}

  loc_0FCEA1:
    LDA $0374             ; {1035937}
    CLC                   ; {1035940}
    ADC #$0020            ; {1035941}
    CMP $0342             ; {1035944}
    BCC loc_0FCEB0        ; {1035947}
    BRL code_0FCF6C       ; {1035949}

  loc_0FCEB0:
    AND #$FFF0            ; {1035952}
    STA $0000, X          ; {1035955}
    LDA $0376             ; {1035958}
    STA $0002, X          ; {1035961}
    COP [28] ( &code_0FCF6C ) ; {1035964}
    LDA $0016, X          ; {1035968}
    AND #$DFFF            ; {1035971}
    STA $0016, X          ; {1035974}
    COP [80] ( #0A )      ; {1035977}
    COP [82]              ; {1035980}
    LDA $0016, X          ; {1035982}
    AND #$FDFF            ; {1035985}
    STA $0016, X          ; {1035988}
    COP [80] ( #02 )      ; {1035991}
    COP [82]              ; {1035994}
    COP [81] ( #07, #04 ) ; {1035996}
    COP [83]              ; {1036000}
    COP [85] ( @code_0FCF95 ) ; {1036002}
    COP [85] ( @code_0FCF9C ) ; {1036007}
    COP [85] ( @code_0FCFA3 ) ; {1036012}
    COP [80] ( #08 )      ; {1036017}
    COP [82]              ; {1036020}
    COP [80] ( #02 )      ; {1036022}
    COP [82]              ; {1036025}
    BRA code_0FCF55       ; {1036027}

  loc_0FCEFD:
    LDA $0374             ; {1036029}
    SEC                   ; {1036032}
    SBC #$0020            ; {1036033}
    BMI code_0FCF6C       ; {1036036}
    AND #$FFF0            ; {1036038}
    STA $0000, X          ; {1036041}
    LDA $0376             ; {1036044}
    STA $0002, X          ; {1036047}
    COP [28] ( &code_0FCF6C ) ; {1036050}
    LDA $0016, X          ; {1036054}
    AND #$DFFF            ; {1036057}
    STA $0016, X          ; {1036060}
    COP [80] ( #0A )      ; {1036063}
    COP [82]              ; {1036066}
    LDA $0016, X          ; {1036068}
    AND #$FDFF            ; {1036071}
    STA $0016, X          ; {1036074}
    COP [96]              ; {1036077}
    COP [80] ( #02 )      ; {1036079}
    COP [82]              ; {1036082}
    COP [81] ( #07, #04 ) ; {1036084}
    COP [83]              ; {1036088}
    COP [85] ( @code_0FCF79 ) ; {1036090}
    COP [85] ( @code_0FCF80 ) ; {1036095}
    COP [85] ( @code_0FCF87 ) ; {1036100}
    COP [80] ( #08 )      ; {1036105}
    COP [82]              ; {1036108}
    COP [80] ( #02 )      ; {1036110}
    COP [82]              ; {1036113}
    COP [97]              ; {1036115}
}

code_0FCF55 {
    LDA $0016, X          ; {1036117}
    ORA #$0200            ; {1036120}
    STA $0016, X          ; {1036123}
    COP [80] ( #09 )      ; {1036126}
    COP [82]              ; {1036129}
    LDA $0016, X          ; {1036131}
    ORA #$2000            ; {1036134}
    STA $0016, X          ; {1036137}
}

code_0FCF6C {
    COP [1B] ( &code_0FCDD1, #$0020 ) ; {1036140}
}

code_0FCF72 {
    COP [97]              ; {1036146}
    LDA #$0011            ; {1036148}
    BRA loc_0FCFA8        ; {1036151}
}

code_0FCF79 {
    COP [96]              ; {1036153}
    LDA #$0014            ; {1036155}
    BRA loc_0FCFA8        ; {1036158}
}

code_0FCF80 {
    COP [96]              ; {1036160}
    LDA #$0012            ; {1036162}
    BRA loc_0FCFA8        ; {1036165}
}

code_0FCF87 {
    COP [96]              ; {1036167}
    LDA #$0013            ; {1036169}
    BRA loc_0FCFA8        ; {1036172}
}

code_0FCF8E {
    COP [97]              ; {1036174}
    LDA #$0010            ; {1036176}
    BRA loc_0FCFA8        ; {1036179}
}

code_0FCF95 {
    COP [97]              ; {1036181}
    LDA #$0013            ; {1036183}
    BRA loc_0FCFA8        ; {1036186}
}

code_0FCF9C {
    COP [97]              ; {1036188}
    LDA #$0012            ; {1036190}
    BRA loc_0FCFA8        ; {1036193}
}

code_0FCFA3 {
    COP [97]              ; {1036195}
    LDA #$0014            ; {1036197}

  loc_0FCFA8:
    STA $001E, X          ; {1036200}
    STZ $0020, X          ; {1036203}
    LDA #$0200            ; {1036206}
    STA $0016, X          ; {1036209}
    COP [AA] ( #00 )      ; {1036212}
    COP [A3]              ; {1036215}
    COP [A2] ( #30 )      ; {1036217}
    LDA #$0004            ; {1036220}
    STA $002A, X          ; {1036223}
    BRK #$52              ; {1036226}
    COP [91]              ; {1036228}
    COP [83]              ; {1036230}
    COP [80] ( #15 )      ; {1036232}
    COP [82]              ; {1036235}
    COP [81] ( #2F, #08 ) ; {1036237}
    COP [83]              ; {1036241}
    COP [86]              ; {1036243}
    RTL                   ; {1036245}
}

code_0FCFD6 {
    COP [AD] ( #08 )      ; {1036246}
    COP [80] ( #18 )      ; {1036249}
    COP [82]              ; {1036252}
    COP [81] ( #19, #08 ) ; {1036254}
    COP [83]              ; {1036258}
    COP [85] ( @code_0FD000 ) ; {1036260}
    COP [85] ( @code_0FD005 ) ; {1036265}
    COP [85] ( @code_0FD01D ) ; {1036270}
    COP [85] ( @code_0FD022 ) ; {1036275}
    COP [81] ( #18, #0C ) ; {1036280}
    COP [83]              ; {1036284}
    BRA code_0FCFD6       ; {1036286}
}

code_0FD000 {
    LDA #$FFE0            ; {1036288}
    BRA loc_0FD008        ; {1036291}
}

code_0FD005 {
    LDA #$0020            ; {1036293}

  loc_0FD008:
    CLC                   ; {1036296}
    ADC $0376             ; {1036297}
    AND #$FFF0            ; {1036300}
    STA $0002, X          ; {1036303}
    LDA $0374             ; {1036306}
    AND #$FFF0            ; {1036309}
    STA $0000, X          ; {1036312}
    BRA loc_0FD038        ; {1036315}
}

code_0FD01D {
    LDA #$FFE0            ; {1036317}
    BRA loc_0FD025        ; {1036320}
}

code_0FD022 {
    LDA #$0020            ; {1036322}

  loc_0FD025:
    CLC                   ; {1036325}
    ADC $0374             ; {1036326}
    AND #$FFF0            ; {1036329}
    STA $0000, X          ; {1036332}
    LDA $0376             ; {1036335}
    AND #$FFF0            ; {1036338}
    STA $0002, X          ; {1036341}

  loc_0FD038:
    COP [28] ( &code_0FD055 ) ; {1036344}
    LDA #$0300            ; {1036348}
    STA $0016, X          ; {1036351}
    COP [81] ( #16, #02 ) ; {1036354}
    COP [83]              ; {1036358}
    LDA #$0200            ; {1036360}
    STA $0016, X          ; {1036363}
    BRK #$5B              ; {1036366}
    COP [80] ( #17 )      ; {1036368}
    COP [82]              ; {1036371}
}

code_0FD055 {
    COP [86]              ; {1036373}
    RTL                   ; {1036375}
}

code_0FD058 {
    LDA $001A, X          ; {1036376}
    ORA #$0100            ; {1036379}
    STA $001A, X          ; {1036382}

  loc_0FD061:
    COP [AD] ( #08 )      ; {1036385}
    LDA #$0008            ; {1036388}
    STA $002C, X          ; {1036391}

  loc_0FD06A:
    COP [80] ( #1A )      ; {1036394}
    COP [82]              ; {1036397}
    LDA $0025, X          ; {1036399}
    AND #$00FF            ; {1036402}
    CMP #$0018            ; {1036405}
    BNE loc_0FD086        ; {1036408}
    DEC $002C, X          ; {1036410}
    BNE loc_0FD06A        ; {1036413}
    COP [80] ( #1B )      ; {1036415}
    COP [82]              ; {1036418}
    BRA loc_0FD061        ; {1036420}

  loc_0FD086:
    LDA #$0200            ; {1036422}
    STA $0016, X          ; {1036425}
    COP [81] ( #1C, #14 ) ; {1036428}
    COP [83]              ; {1036432}
    BRK #$64              ; {1036434}
    COP [85] ( @code_0FD0C4 ) ; {1036436}
    COP [85] ( @code_0FD0C9 ) ; {1036441}
    COP [85] ( @code_0FD0D0 ) ; {1036446}
    COP [85] ( @code_0FD0D7 ) ; {1036451}
    COP [85] ( @code_0FD0DE ) ; {1036456}
    COP [85] ( @code_0FD0E3 ) ; {1036461}
    COP [85] ( @code_0FD0E8 ) ; {1036466}
    COP [85] ( @code_0FD0ED ) ; {1036471}
    COP [80] ( #1D )      ; {1036476}
    COP [82]              ; {1036479}
    COP [86]              ; {1036481}
    RTL                   ; {1036483}
}

code_0FD0C4 {
    LDA #$001F            ; {1036484}
    BRA loc_0FD0F2        ; {1036487}
}

code_0FD0C9 {
    COP [96]              ; {1036489}
    LDA #$0022            ; {1036491}
    BRA loc_0FD0F2        ; {1036494}
}

code_0FD0D0 {
    COP [96]              ; {1036496}
    LDA #$0020            ; {1036498}
    BRA loc_0FD0F2        ; {1036501}
}

code_0FD0D7 {
    COP [96]              ; {1036503}
    LDA #$0021            ; {1036505}
    BRA loc_0FD0F2        ; {1036508}
}

code_0FD0DE {
    LDA #$001E            ; {1036510}
    BRA loc_0FD0F2        ; {1036513}
}

code_0FD0E3 {
    LDA #$0021            ; {1036515}
    BRA loc_0FD0F2        ; {1036518}
}

code_0FD0E8 {
    LDA #$0020            ; {1036520}
    BRA loc_0FD0F2        ; {1036523}
}

code_0FD0ED {
    LDA #$0022            ; {1036525}
    BRA loc_0FD0F2        ; {1036528}

  loc_0FD0F2:
    STA $001E, X          ; {1036530}
    STZ $0020, X          ; {1036533}
    LDA #$0200            ; {1036536}
    STA $0016, X          ; {1036539}
    LDA #$0002            ; {1036542}
    STA $002A, X          ; {1036545}
    COP [A3]              ; {1036548}
    COP [A2] ( #30 )      ; {1036550}
    COP [A1] ( #$0008, #$FFF8 ) ; {1036553}
    COP [91]              ; {1036559}
    COP [83]              ; {1036561}
    COP [80] ( #23 )      ; {1036563}
    COP [82]              ; {1036566}
    COP [86]              ; {1036568}
    RTL                   ; {1036570}
}

code_0FD11B {
    COP [A3]              ; {1036571}
    COP [1B] ( &code_0FD123, #$0000 ) ; {1036573}
}

code_0FD123 {
    COP [AD] ( #08 )      ; {1036579}
    BRL loc_0FD195        ; {1036582}

  code_0FD129:
    COP [97]              ; {1036585}
    COP [80] ( #29 )      ; {1036587}
    COP [82]              ; {1036590}
    BRA loc_0FD195        ; {1036592}

  code_0FD132:
    COP [96]              ; {1036594}
    COP [80] ( #26 )      ; {1036596}
    COP [82]              ; {1036599}
    BRA loc_0FD1A9        ; {1036601}

  code_0FD13B:
    COP [96]              ; {1036603}
    COP [80] ( #25 )      ; {1036605}
    COP [82]              ; {1036608}
    BRA loc_0FD195        ; {1036610}

  code_0FD144:
    COP [96]              ; {1036612}
    COP [80] ( #2A )      ; {1036614}
    COP [82]              ; {1036617}
    BRA loc_0FD1A9        ; {1036619}

  code_0FD14D:
    COP [96]              ; {1036621}
    COP [80] ( #27 )      ; {1036623}
    COP [82]              ; {1036626}
    BRA loc_0FD1BD        ; {1036628}

  code_0FD156:
    COP [96]              ; {1036630}
    COP [80] ( #24 )      ; {1036632}
    COP [82]              ; {1036635}
    BRA loc_0FD1A9        ; {1036637}

  code_0FD15F:
    COP [97]              ; {1036639}
    COP [80] ( #28 )      ; {1036641}
    COP [82]              ; {1036644}
    BRA loc_0FD1BD        ; {1036646}

  code_0FD168:
    COP [97]              ; {1036648}
    COP [80] ( #24 )      ; {1036650}
    COP [82]              ; {1036653}
    BRA loc_0FD1D1        ; {1036655}

  code_0FD171:
    COP [97]              ; {1036657}
    COP [80] ( #27 )      ; {1036659}
    COP [82]              ; {1036662}
    BRA loc_0FD1BD        ; {1036664}

  code_0FD17A:
    COP [97]              ; {1036666}
    COP [80] ( #2A )      ; {1036668}
    COP [82]              ; {1036671}
    BRA loc_0FD1D1        ; {1036673}

  code_0FD183:
    COP [97]              ; {1036675}
    COP [80] ( #25 )      ; {1036677}
    COP [82]              ; {1036680}
    BRA loc_0FD195        ; {1036682}

  code_0FD18C:
    COP [97]              ; {1036684}
    COP [80] ( #26 )      ; {1036686}
    COP [82]              ; {1036689}
    BRA loc_0FD1D1        ; {1036691}

  loc_0FD195:
    COP [9B] ( #$0000, &code_0FD129, &code_0FD19F, &code_0FD19F ) ; {1036693}
}

code_0FD19F {
    COP [9A] ( #$0000, &code_0FD18C, &code_0FD132, &code_0FD132 ) ; {1036703}

  loc_0FD1A9:
    COP [9A] ( #$0000, &code_0FD1B3, &code_0FD1B3, &code_0FD144 ) ; {1036713}
}

code_0FD1B3 {
    COP [9B] ( #$0000, &code_0FD13B, &code_0FD14D, &code_0FD14D ) ; {1036723}

  loc_0FD1BD:
    COP [9B] ( #$0000, &code_0FD1C7, &code_0FD1C7, &code_0FD15F ) ; {1036733}
}

code_0FD1C7 {
    COP [9A] ( #$0000, &code_0FD168, &code_0FD168, &code_0FD156 ) ; {1036743}

  loc_0FD1D1:
    COP [9A] ( #$0000, &code_0FD17A, &code_0FD1DB, &code_0FD1DB ) ; {1036753}
}

code_0FD1DB {
    COP [9B] ( #$0000, &code_0FD183, &code_0FD183, &code_0FD171 ) ; {1036763}
}

code_0FD1E5 {
    COP [AD] ( #08 )      ; {1036773}
    COP [0C] ( #00, #05, &code_0FD1F5 ) ; {1036776}
    COP [80] ( #2B )      ; {1036782}
    COP [82]              ; {1036785}
    BRA code_0FD1E5       ; {1036787}
}

code_0FD1F5 {
    COP [1F]              ; {1036789}
    LDA $0302             ; {1036791}
    BPL loc_0FD21A        ; {1036794}
    COP [9A] ( #$0000, &code_0FD206, &code_0FD210, &code_0FD210 ) ; {1036796}
}

code_0FD206 {
    COP [9B] ( #$0000, &code_0FD261, &code_0FD24E, &code_0FD24E ) ; {1036806}
}

code_0FD210 {
    COP [9B] ( #$0000, &code_0FD228, &code_0FD23B, &code_0FD23B ) ; {1036816}

  loc_0FD21A:
    AND #$0003            ; {1036826}
    BEQ code_0FD228       ; {1036829}
    DEC                   ; {1036831}
    BEQ code_0FD23B       ; {1036832}
    DEC                   ; {1036834}
    BEQ code_0FD24E       ; {1036835}
    DEC                   ; {1036837}
    BEQ code_0FD261       ; {1036838}
}

code_0FD228 {
    COP [96]              ; {1036840}
    COP [80] ( #2C )      ; {1036842}
    COP [82]              ; {1036845}
    COP [80] ( #2E )      ; {1036847}
    COP [82]              ; {1036850}
    COP [80] ( #2C )      ; {1036852}
    COP [82]              ; {1036855}
    BRA code_0FD1E5       ; {1036857}
}

code_0FD23B {
    COP [96]              ; {1036859}
    COP [80] ( #2C )      ; {1036861}
    COP [82]              ; {1036864}
    COP [80] ( #2D )      ; {1036866}
    COP [82]              ; {1036869}
    COP [80] ( #2C )      ; {1036871}
    COP [82]              ; {1036874}
    BRA code_0FD1E5       ; {1036876}
}

code_0FD24E {
    COP [97]              ; {1036878}
    COP [80] ( #2C )      ; {1036880}
    COP [82]              ; {1036883}
    COP [80] ( #2D )      ; {1036885}
    COP [82]              ; {1036888}
    COP [80] ( #2C )      ; {1036890}
    COP [82]              ; {1036893}
    BRA code_0FD1E5       ; {1036895}
}

code_0FD261 {
    COP [97]              ; {1036897}
    COP [80] ( #2C )      ; {1036899}
    COP [82]              ; {1036902}
    COP [80] ( #2E )      ; {1036904}
    COP [82]              ; {1036907}
    COP [80] ( #2C )      ; {1036909}
    COP [82]              ; {1036912}
    BRL code_0FD1E5       ; {1036914}
}

code_0FD275 {
    LDA $001A, X          ; {1036917}
    ORA #$0400            ; {1036920}
    STA $001A, X          ; {1036923}
    COP [A5] ( &code_0FD316, &code_0FD2EA, &code_0FD288, &code_0FD2BC ) ; {1036926}
}

code_0FD288 {
    COP [21] ( &code_0FD29C ) ; {1036936}
    COP [96]              ; {1036940}
    COP [80] ( #02 )      ; {1036942}
    COP [82]              ; {1036945}
    COP [97]              ; {1036947}
    COP [80] ( #01 )      ; {1036949}
    COP [82]              ; {1036952}
    BRA loc_0FD2D2        ; {1036954}
}

code_0FD29C {
    COP [24] ( &code_0FD2AC ) ; {1036956}

  loc_0FD2A0:
    COP [96]              ; {1036960}
    COP [81] ( #05, #02 ) ; {1036962}
    COP [83]              ; {1036966}
    COP [97]              ; {1036968}
    BRA code_0FD288       ; {1036970}
}

code_0FD2AC {
    COP [96]              ; {1036972}
    COP [80] ( #02 )      ; {1036974}
    COP [82]              ; {1036977}
    COP [97]              ; {1036979}
    COP [80] ( #00 )      ; {1036981}
    COP [82]              ; {1036984}
    BRA code_0FD316       ; {1036986}
}

code_0FD2BC {
    COP [23] ( &code_0FD2CE ) ; {1036988}
    COP [97]              ; {1036992}
    COP [80] ( #01 )      ; {1036994}
    COP [82]              ; {1036997}
    COP [80] ( #02 )      ; {1036999}
    COP [82]              ; {1037002}
    BRA loc_0FD300        ; {1037004}
}

code_0FD2CE {
    COP [21] ( &code_0FD2DA ) ; {1037006}

  loc_0FD2D2:
    COP [81] ( #04, #02 ) ; {1037010}
    COP [83]              ; {1037014}
    BRA code_0FD2BC       ; {1037016}
}

code_0FD2DA {
    COP [97]              ; {1037018}
    COP [80] ( #01 )      ; {1037020}
    COP [82]              ; {1037023}
    COP [96]              ; {1037025}
    COP [80] ( #02 )      ; {1037027}
    COP [82]              ; {1037030}
    BRA code_0FD288       ; {1037032}
}

code_0FD2EA {
    COP [22] ( &code_0FD2FC ) ; {1037034}
    COP [97]              ; {1037038}
    COP [80] ( #02 )      ; {1037040}
    COP [82]              ; {1037043}
    COP [80] ( #00 )      ; {1037045}
    COP [82]              ; {1037048}
    BRA loc_0FD32F        ; {1037050}
}

code_0FD2FC {
    COP [23] ( &code_0FD308 ) ; {1037052}

  loc_0FD300:
    COP [81] ( #05, #02 ) ; {1037056}
    COP [83]              ; {1037060}
    BRA code_0FD2EA       ; {1037062}
}

code_0FD308 {
    COP [97]              ; {1037064}
    COP [80] ( #02 )      ; {1037066}
    COP [82]              ; {1037069}
    COP [80] ( #01 )      ; {1037071}
    COP [82]              ; {1037074}
    BRA code_0FD2BC       ; {1037076}
}

code_0FD316 {
    COP [24] ( &code_0FD32B ) ; {1037078}
    COP [97]              ; {1037082}
    COP [80] ( #00 )      ; {1037084}
    COP [82]              ; {1037087}
    COP [96]              ; {1037089}
    COP [80] ( #02 )      ; {1037091}
    COP [82]              ; {1037094}
    BRL loc_0FD2A0        ; {1037096}
}

code_0FD32B {
    COP [22] ( &code_0FD337 ) ; {1037099}

  loc_0FD32F:
    COP [81] ( #03, #02 ) ; {1037103}
    COP [83]              ; {1037107}
    BRA code_0FD316       ; {1037109}
}

code_0FD337 {
    COP [97]              ; {1037111}
    COP [80] ( #00 )      ; {1037113}
    COP [82]              ; {1037116}
    COP [80] ( #02 )      ; {1037118}
    COP [82]              ; {1037121}
    BRA code_0FD2EA       ; {1037123}
}

code_0FD345 {
    LDA $001A, X          ; {1037125}
    ORA #$0400            ; {1037128}
    STA $001A, X          ; {1037131}

  code_0FD34E:
    LDA $0016, X          ; {1037134}
    BIT #$8000            ; {1037137}
    BEQ loc_0FD35C        ; {1037140}

  code_0FD356:
    COP [1B] ( &code_0FD34E, #$0004 ) ; {1037142}

  loc_0FD35C:
    COP [9A] ( #$0010, &code_0FD366, &code_0FD370, &code_0FD366 ) ; {1037148}
}

code_0FD366 {
    COP [9B] ( #$0010, &code_0FD356, &code_0FD37A, &code_0FD356 ) ; {1037158}
}

code_0FD370 {
    COP [9B] ( #$0000, &code_0FD3C2, &code_0FD3E2, &code_0FD3E2 ) ; {1037168}
}

code_0FD37A {
    COP [9A] ( #$0000, &code_0FD384, &code_0FD3A3, &code_0FD3A3 ) ; {1037178}
}

code_0FD384 {
    COP [97]              ; {1037188}
    COP [80] ( #08 )      ; {1037190}
    COP [82]              ; {1037193}
    COP [81] ( #0D, #04 ) ; {1037195}
    COP [83]              ; {1037199}
    COP [80] ( #08 )      ; {1037201}
    COP [82]              ; {1037204}
    COP [81] ( #0E, #10 ) ; {1037206}
    COP [83]              ; {1037210}
    COP [80] ( #08 )      ; {1037212}
    COP [82]              ; {1037215}
    BRA code_0FD34E       ; {1037217}
}

code_0FD3A3 {
    COP [96]              ; {1037219}
    COP [80] ( #08 )      ; {1037221}
    COP [82]              ; {1037224}
    COP [81] ( #0D, #04 ) ; {1037226}
    COP [83]              ; {1037230}
    COP [80] ( #08 )      ; {1037232}
    COP [82]              ; {1037235}
    COP [81] ( #0E, #10 ) ; {1037237}
    COP [83]              ; {1037241}
    COP [80] ( #08 )      ; {1037243}
    COP [82]              ; {1037246}
    BRA code_0FD34E       ; {1037248}
}

code_0FD3C2 {
    COP [97]              ; {1037250}
    COP [80] ( #07 )      ; {1037252}
    COP [82]              ; {1037255}
    COP [81] ( #0B, #04 ) ; {1037257}
    COP [83]              ; {1037261}
    COP [80] ( #07 )      ; {1037263}
    COP [82]              ; {1037266}
    COP [81] ( #0C, #10 ) ; {1037268}
    COP [83]              ; {1037272}
    COP [80] ( #07 )      ; {1037274}
    COP [82]              ; {1037277}
    BRL code_0FD34E       ; {1037279}
}

code_0FD3E2 {
    COP [97]              ; {1037282}
    COP [80] ( #06 )      ; {1037284}
    COP [82]              ; {1037287}
    COP [81] ( #09, #04 ) ; {1037289}
    COP [83]              ; {1037293}
    COP [80] ( #06 )      ; {1037295}
    COP [82]              ; {1037298}
    COP [81] ( #0A, #10 ) ; {1037300}
    COP [83]              ; {1037304}
    COP [80] ( #06 )      ; {1037306}
    COP [82]              ; {1037309}
    BRL code_0FD34E       ; {1037311}
}

code_0FD402 {
    LDA $001A, X          ; {1037314}
    ORA #$0400            ; {1037317}
    STA $001A, X          ; {1037320}

  loc_0FD40B:
    COP [AD] ( #08 )      ; {1037323}
    COP [9C] ( &code_0FD414, &code_0FD41E ) ; {1037326}
}

code_0FD414 {
    COP [9A] ( #$0000, &code_0FD428, &code_0FD440, &code_0FD440 ) ; {1037332}
}

code_0FD41E {
    COP [9B] ( #$0000, &code_0FD458, &code_0FD470, &code_0FD470 ) ; {1037342}
}

code_0FD428 {
    COP [97]              ; {1037352}

  code_0FD42A:
    COP [81] ( #18, #02 ) ; {1037354}
    COP [83]              ; {1037358}
    COP [28] ( &code_0FD436 ) ; {1037360}
    BRA loc_0FD488        ; {1037364}
}

code_0FD436 {
    COP [9A] ( #$0008, &code_0FD42A, &code_0FD41E, &code_0FD440 ) ; {1037366}
}

code_0FD440 {
    COP [97]              ; {1037376}

  code_0FD442:
    COP [81] ( #19, #02 ) ; {1037378}
    COP [83]              ; {1037382}
    COP [28] ( &code_0FD44E ) ; {1037384}
    BRA loc_0FD488        ; {1037388}
}

code_0FD44E {
    COP [9A] ( #$0008, &code_0FD428, &code_0FD41E, &code_0FD442 ) ; {1037390}
}

code_0FD458 {
    COP [97]              ; {1037400}

  code_0FD45A:
    COP [81] ( #17, #02 ) ; {1037402}
    COP [83]              ; {1037406}
    COP [28] ( &code_0FD466 ) ; {1037408}
    BRA loc_0FD488        ; {1037412}
}

code_0FD466 {
    COP [9B] ( #$0008, &code_0FD45A, &code_0FD414, &code_0FD470 ) ; {1037414}
}

code_0FD470 {
    COP [97]              ; {1037424}

  code_0FD472:
    COP [81] ( #16, #02 ) ; {1037426}
    COP [83]              ; {1037430}
    COP [28] ( &code_0FD47E ) ; {1037432}
    BRA loc_0FD488        ; {1037436}
}

code_0FD47E {
    COP [9B] ( #$0008, &code_0FD458, &code_0FD414, &code_0FD472 ) ; {1037438}

  loc_0FD488:
    COP [80] ( #15 )      ; {1037448}
    COP [82]              ; {1037451}

  loc_0FD48D:
    COP [AD] ( #08 )      ; {1037453}
    COP [9C] ( &code_0FD496, &code_0FD4A0 ) ; {1037456}
}

code_0FD496 {
    COP [9A] ( #$0000, &code_0FD4AA, &code_0FD4C0, &code_0FD4C0 ) ; {1037462}
}

code_0FD4A0 {
    COP [9B] ( #$0000, &code_0FD4D6, &code_0FD4EC, &code_0FD4EC ) ; {1037472}
}

code_0FD4AA {
    COP [97]              ; {1037482}
    COP [23] ( &code_0FD4B8 ) ; {1037484}
    COP [81] ( #14, #04 ) ; {1037488}
    COP [83]              ; {1037492}
    BRA loc_0FD48D        ; {1037494}
}

code_0FD4B8 {
    COP [80] ( #11 )      ; {1037496}
    COP [82]              ; {1037499}
    BRL loc_0FD40B        ; {1037501}
}

code_0FD4C0 {
    COP [96]              ; {1037504}
    COP [24] ( &code_0FD4CE ) ; {1037506}
    COP [81] ( #14, #04 ) ; {1037510}
    COP [83]              ; {1037514}
    BRA loc_0FD48D        ; {1037516}
}

code_0FD4CE {
    COP [80] ( #11 )      ; {1037518}
    COP [82]              ; {1037521}
    BRL loc_0FD40B        ; {1037523}
}

code_0FD4D6 {
    COP [97]              ; {1037526}
    COP [21] ( &code_0FD4E4 ) ; {1037528}
    COP [81] ( #13, #04 ) ; {1037532}
    COP [83]              ; {1037536}
    BRA loc_0FD48D        ; {1037538}
}

code_0FD4E4 {
    COP [80] ( #10 )      ; {1037540}
    COP [82]              ; {1037543}
    BRL loc_0FD40B        ; {1037545}
}

code_0FD4EC {
    COP [97]              ; {1037548}
    COP [22] ( &code_0FD4FA ) ; {1037550}
    COP [81] ( #12, #04 ) ; {1037554}
    COP [83]              ; {1037558}
    BRA loc_0FD48D        ; {1037560}
}

code_0FD4FA {
    COP [80] ( #0F )      ; {1037562}
    COP [82]              ; {1037565}
    BRL loc_0FD40B        ; {1037567}
}

code_0FD502 {
    COP [A5] ( &code_0FD673, &code_0FD583, &code_0FD50C, &code_0FD5FA ) ; {1037570}
}

code_0FD50C {
    COP [97]              ; {1037580}
    COP [80] ( #1B )      ; {1037582}
    COP [82]              ; {1037585}

  loc_0FD513:
    COP [AD] ( #08 )      ; {1037587}
    COP [9A] ( #$0020, &code_0FD520, &code_0FD52B, &code_0FD520 ) ; {1037590}
}

code_0FD520 {
    COP [23] ( &code_0FD583 ) ; {1037600}
    COP [80] ( #1E )      ; {1037604}
    COP [82]              ; {1037607}
    BRA loc_0FD513        ; {1037609}
}

code_0FD52B {
    COP [9B] ( #$0000, &code_0FD535, &code_0FD558, &code_0FD558 ) ; {1037611}
}

code_0FD535 {
    COP [AE] ( #$0000, #$FFD0, &code_0FD520 ) ; {1037621}
    COP [AE] ( #$0000, #$FFF0, &code_0FD547 ) ; {1037629}
    BRA code_0FD520       ; {1037637}
}

code_0FD547 {
    COP [80] ( #21 )      ; {1037639}
    COP [82]              ; {1037642}
    COP [80] ( #23 )      ; {1037644}
    COP [82]              ; {1037647}
    COP [80] ( #21 )      ; {1037649}
    COP [82]              ; {1037652}
    BRA loc_0FD579        ; {1037654}
}

code_0FD558 {
    COP [AE] ( #$0000, #$0030, &code_0FD520 ) ; {1037656}
    COP [AE] ( #$0000, #$0010, &code_0FD56A ) ; {1037664}
    BRA code_0FD520       ; {1037672}
}

code_0FD56A {
    COP [80] ( #21 )      ; {1037674}
    COP [82]              ; {1037677}
    COP [80] ( #22 )      ; {1037679}
    COP [82]              ; {1037682}
    COP [80] ( #21 )      ; {1037684}
    COP [82]              ; {1037687}

  loc_0FD579:
    COP [9A] ( #$0000, &code_0FD50C, &code_0FD583, &code_0FD583 ) ; {1037689}
}

code_0FD583 {
    COP [96]              ; {1037699}
    COP [80] ( #1B )      ; {1037701}
    COP [82]              ; {1037704}

  loc_0FD58A:
    COP [AD] ( #08 )      ; {1037706}
    COP [9A] ( #$0020, &code_0FD597, &code_0FD5A2, &code_0FD597 ) ; {1037709}
}

code_0FD597 {
    COP [24] ( &code_0FD50C ) ; {1037719}
    COP [80] ( #1E )      ; {1037723}
    COP [82]              ; {1037726}
    BRA loc_0FD58A        ; {1037728}
}

code_0FD5A2 {
    COP [9B] ( #$0000, &code_0FD5AC, &code_0FD5CF, &code_0FD5CF ) ; {1037730}
}

code_0FD5AC {
    COP [AE] ( #$0000, #$FFD0, &code_0FD597 ) ; {1037740}
    COP [AE] ( #$0000, #$FFF0, &code_0FD5BE ) ; {1037748}
    BRA code_0FD597       ; {1037756}
}

code_0FD5BE {
    COP [80] ( #21 )      ; {1037758}
    COP [82]              ; {1037761}
    COP [80] ( #23 )      ; {1037763}
    COP [82]              ; {1037766}
    COP [80] ( #21 )      ; {1037768}
    COP [82]              ; {1037771}
    BRA loc_0FD5F0        ; {1037773}
}

code_0FD5CF {
    COP [AE] ( #$0000, #$0030, &code_0FD597 ) ; {1037775}
    COP [AE] ( #$0000, #$0010, &code_0FD5E1 ) ; {1037783}
    BRA code_0FD597       ; {1037791}
}

code_0FD5E1 {
    COP [80] ( #21 )      ; {1037793}
    COP [82]              ; {1037796}
    COP [80] ( #22 )      ; {1037798}
    COP [82]              ; {1037801}
    COP [80] ( #21 )      ; {1037803}
    COP [82]              ; {1037806}

  loc_0FD5F0:
    COP [9A] ( #$0000, &code_0FD50C, &code_0FD583, &code_0FD583 ) ; {1037808}
}

code_0FD5FA {
    COP [97]              ; {1037818}
    COP [80] ( #1A )      ; {1037820}
    COP [82]              ; {1037823}

  loc_0FD601:
    COP [AD] ( #08 )      ; {1037825}
    COP [9B] ( #$0020, &code_0FD60E, &code_0FD619, &code_0FD60E ) ; {1037828}
}

code_0FD60E {
    COP [21] ( &code_0FD673 ) ; {1037838}
    COP [80] ( #1C )      ; {1037842}
    COP [82]              ; {1037845}
    BRA loc_0FD601        ; {1037847}
}

code_0FD619 {
    COP [9A] ( #$0000, &code_0FD623, &code_0FD646, &code_0FD646 ) ; {1037849}
}

code_0FD623 {
    COP [AE] ( #$FFD0, #$0000, &code_0FD60E ) ; {1037859}
    COP [AE] ( #$FFF0, #$0000, &code_0FD635 ) ; {1037867}
    BRA code_0FD60E       ; {1037875}
}

code_0FD635 {
    COP [80] ( #1F )      ; {1037877}
    COP [82]              ; {1037880}
    COP [80] ( #20 )      ; {1037882}
    COP [82]              ; {1037885}
    COP [80] ( #1F )      ; {1037887}
    COP [82]              ; {1037890}
    BRA loc_0FD669        ; {1037892}
}

code_0FD646 {
    COP [AE] ( #$0030, #$0000, &code_0FD60E ) ; {1037894}
    COP [AE] ( #$0010, #$0000, &code_0FD658 ) ; {1037902}
    BRA code_0FD60E       ; {1037910}
}

code_0FD658 {
    COP [96]              ; {1037912}
    COP [80] ( #1F )      ; {1037914}
    COP [82]              ; {1037917}
    COP [80] ( #20 )      ; {1037919}
    COP [82]              ; {1037922}
    COP [80] ( #1F )      ; {1037924}
    COP [82]              ; {1037927}

  loc_0FD669:
    COP [9B] ( #$0000, &code_0FD5FA, &code_0FD673, &code_0FD673 ) ; {1037929}
}

code_0FD673 {
    COP [97]              ; {1037939}
    COP [80] ( #1A )      ; {1037941}
    COP [82]              ; {1037944}

  loc_0FD67A:
    COP [AD] ( #08 )      ; {1037946}
    COP [9B] ( #$0020, &code_0FD687, &code_0FD692, &code_0FD687 ) ; {1037949}
}

code_0FD687 {
    COP [22] ( &code_0FD5FA ) ; {1037959}
    COP [80] ( #1D )      ; {1037963}
    COP [82]              ; {1037966}
    BRA loc_0FD67A        ; {1037968}
}

code_0FD692 {
    COP [9A] ( #$0000, &code_0FD69C, &code_0FD6BF, &code_0FD6BF ) ; {1037970}
}

code_0FD69C {
    COP [AE] ( #$FFD0, #$0000, &code_0FD687 ) ; {1037980}
    COP [AE] ( #$FFF0, #$0000, &code_0FD6AE ) ; {1037988}
    BRA code_0FD687       ; {1037996}
}

code_0FD6AE {
    COP [80] ( #1F )      ; {1037998}
    COP [82]              ; {1038001}
    COP [80] ( #20 )      ; {1038003}
    COP [82]              ; {1038006}
    COP [80] ( #1F )      ; {1038008}
    COP [82]              ; {1038011}
    BRA loc_0FD6E2        ; {1038013}
}

code_0FD6BF {
    COP [AE] ( #$0030, #$0000, &code_0FD687 ) ; {1038015}
    COP [AE] ( #$0010, #$0000, &code_0FD6D1 ) ; {1038023}
    BRA code_0FD687       ; {1038031}
}

code_0FD6D1 {
    COP [96]              ; {1038033}
    COP [80] ( #1F )      ; {1038035}
    COP [82]              ; {1038038}
    COP [80] ( #20 )      ; {1038040}
    COP [82]              ; {1038043}
    COP [80] ( #1F )      ; {1038045}
    COP [82]              ; {1038048}

  loc_0FD6E2:
    COP [9B] ( #$0000, &code_0FD5FA, &code_0FD673, &code_0FD673 ) ; {1038050}
}

code_0FD6EC {
    COP [A5] ( &code_0FD6F6, &code_0FD6FC, &code_0FD724, &code_0FD72A ) ; {1038060}
}

code_0FD6F6 {
    COP [9F] ( #$FFF0 )   ; {1038070}
    BRA loc_0FD711        ; {1038074}
}

code_0FD6FC {
    COP [9F] ( #$0010 )   ; {1038076}

  loc_0FD700:
    LDA $0016, X          ; {1038080}
    ORA #$0100            ; {1038083}
    STA $0016, X          ; {1038086}
    COP [A2] ( #20 )      ; {1038089}
    COP [80] ( #25 )      ; {1038092}
    COP [82]              ; {1038095}

  loc_0FD711:
    LDA $0016, X          ; {1038097}
    AND #$FEFF            ; {1038100}
    STA $0016, X          ; {1038103}
    COP [A2] ( #30 )      ; {1038106}
    COP [80] ( #24 )      ; {1038109}
    COP [82]              ; {1038112}
    BRA loc_0FD700        ; {1038114}
}

code_0FD724 {
    COP [A0] ( #$FFF8 )   ; {1038116}
    BRA loc_0FD73F        ; {1038120}
}

code_0FD72A {
    COP [A0] ( #$0018 )   ; {1038122}

  loc_0FD72E:
    LDA $0016, X          ; {1038126}
    ORA #$0100            ; {1038129}
    STA $0016, X          ; {1038132}
    COP [A2] ( #20 )      ; {1038135}
    COP [80] ( #27 )      ; {1038138}
    COP [82]              ; {1038141}

  loc_0FD73F:
    LDA $0016, X          ; {1038143}
    AND #$FEFF            ; {1038146}
    STA $0016, X          ; {1038149}
    COP [A2] ( #30 )      ; {1038152}
    COP [80] ( #26 )      ; {1038155}
    COP [82]              ; {1038158}
    BRA loc_0FD72E        ; {1038160}
}

code_0FD752 {
    COP [A5] ( &code_0FD75C, &code_0FD81C, &code_0FD7DC, &code_0FD79C ) ; {1038162}
}

code_0FD75C {
    JSR $&code_0FD85C     ; {1038172}
    COP [24] ( &code_0FD76B ) ; {1038175}
    COP [81] ( #2F, #04 ) ; {1038179}
    COP [83]              ; {1038183}
    BRA code_0FD75C       ; {1038185}
}

code_0FD76B {
    COP [1B] ( &code_0FD771, #$0000 ) ; {1038187}
}

code_0FD771 {
    COP [AD] ( #08 )      ; {1038193}
    COP [22] ( &code_0FD7CD ) ; {1038196}
    COP [81] ( #2C, #04 ) ; {1038200}
    COP [83]              ; {1038204}

  loc_0FD77E:
    JSR $&code_0FD85C     ; {1038206}
    COP [23] ( &code_0FD78D ) ; {1038209}
    COP [81] ( #2E, #04 ) ; {1038213}
    COP [83]              ; {1038217}
    BRA loc_0FD77E        ; {1038219}
}

code_0FD78D {
    COP [AD] ( #08 )      ; {1038221}
    COP [22] ( &code_0FD7AB ) ; {1038224}
    COP [81] ( #2C, #04 ) ; {1038228}
    COP [83]              ; {1038232}
    BRA code_0FD75C       ; {1038234}
}

code_0FD79C {
    JSR $&code_0FD85C     ; {1038236}
    COP [23] ( &code_0FD7AB ) ; {1038239}
    COP [81] ( #2E, #04 ) ; {1038243}
    COP [83]              ; {1038247}
    BRA code_0FD79C       ; {1038249}
}

code_0FD7AB {
    COP [1B] ( &code_0FD7B1, #$0000 ) ; {1038251}
}

code_0FD7B1 {
    COP [AD] ( #08 )      ; {1038257}
    COP [21] ( &code_0FD78D ) ; {1038260}
    COP [81] ( #2D, #04 ) ; {1038264}
    COP [83]              ; {1038268}

  loc_0FD7BE:
    JSR $&code_0FD85C     ; {1038270}
    COP [24] ( &code_0FD7CD ) ; {1038273}
    COP [81] ( #2F, #04 ) ; {1038277}
    COP [83]              ; {1038281}
    BRA loc_0FD7BE        ; {1038283}
}

code_0FD7CD {
    COP [AD] ( #08 )      ; {1038285}
    COP [21] ( &code_0FD76B ) ; {1038288}
    COP [81] ( #2D, #04 ) ; {1038292}
    COP [83]              ; {1038296}
    BRA code_0FD79C       ; {1038298}
}

code_0FD7DC {
    JSR $&code_0FD85C     ; {1038300}
    COP [22] ( &code_0FD7EB ) ; {1038303}
    COP [81] ( #2C, #04 ) ; {1038307}
    COP [83]              ; {1038311}
    BRA code_0FD7DC       ; {1038313}
}

code_0FD7EB {
    COP [1B] ( &code_0FD7F1, #$0000 ) ; {1038315}
}

code_0FD7F1 {
    COP [AD] ( #08 )      ; {1038321}
    COP [24] ( &code_0FD84D ) ; {1038324}
    COP [81] ( #2F, #04 ) ; {1038328}
    COP [83]              ; {1038332}

  loc_0FD7FE:
    JSR $&code_0FD85C     ; {1038334}
    COP [21] ( &code_0FD80D ) ; {1038337}
    COP [81] ( #2D, #04 ) ; {1038341}
    COP [83]              ; {1038345}
    BRA loc_0FD7FE        ; {1038347}
}

code_0FD80D {
    COP [AD] ( #08 )      ; {1038349}
    COP [24] ( &code_0FD82B ) ; {1038352}
    COP [81] ( #2F, #04 ) ; {1038356}
    COP [83]              ; {1038360}
    BRA code_0FD7DC       ; {1038362}
}

code_0FD81C {
    JSR $&code_0FD85C     ; {1038364}
    COP [21] ( &code_0FD82B ) ; {1038367}
    COP [81] ( #2D, #04 ) ; {1038371}
    COP [83]              ; {1038375}
    BRA code_0FD81C       ; {1038377}
}

code_0FD82B {
    COP [1B] ( &code_0FD831, #$0000 ) ; {1038379}
}

code_0FD831 {
    COP [AD] ( #08 )      ; {1038385}
    COP [23] ( &code_0FD80D ) ; {1038388}
    COP [81] ( #2E, #04 ) ; {1038392}
    COP [83]              ; {1038396}

  loc_0FD83E:
    JSR $&code_0FD85C     ; {1038398}
    COP [22] ( &code_0FD84D ) ; {1038401}
    COP [81] ( #2C, #04 ) ; {1038405}
    COP [83]              ; {1038409}
    BRA loc_0FD83E        ; {1038411}
}

code_0FD84D {
    COP [AD] ( #08 )      ; {1038413}
    COP [23] ( &code_0FD7EB ) ; {1038416}
    COP [81] ( #2E, #04 ) ; {1038420}
    COP [83]              ; {1038424}
    BRA code_0FD81C       ; {1038426}
}

code_0FD85C {
    COP [0C] ( #00, #02, &code_0FD863 ) ; {1038428}
    RTS                   ; {1038434}
}

code_0FD863 {
    PLA                   ; {1038435}
    STA $0030, X          ; {1038436}
    COP [80] ( #30 )      ; {1038439}
    COP [82]              ; {1038442}
    LDA $0016, X          ; {1038444}
    ORA #$0200            ; {1038447}
    STA $0016, X          ; {1038450}
    BRK #$56              ; {1038453}
    COP [B2] ( &code_0FD8E8, #1F, #$0000, #$0008, #$0200 ) ; {1038455}
    COP [B2] ( &code_0FD8FE, #1F, #$0010, #$FFF8, #$0200 ) ; {1038466}
    COP [B2] ( &code_0FD916, #1F, #$0000, #$FFE8, #$0200 ) ; {1038477}
    COP [B2] ( &code_0FD92A, #1F, #$FFF0, #$FFF8, #$0200 ) ; {1038488}
    COP [1B] ( &code_0FD8A9, #$0001 ) ; {1038499}
}

code_0FD8A9 {
    COP [B2] ( &code_0FD8F2, #1F, #$0010, #$0008, #$0200 ) ; {1038505}
    COP [B2] ( &code_0FD90A, #1F, #$0010, #$FFE8, #$0200 ) ; {1038516}
    COP [B2] ( &code_0FD920, #1F, #$FFF0, #$FFE8, #$0200 ) ; {1038527}
    COP [B2] ( &code_0FD934, #1F, #$FFF0, #$0008, #$0200 ) ; {1038538}
    COP [80] ( #31 )      ; {1038549}
    COP [82]              ; {1038552}
    LDA $0016, X          ; {1038554}
    AND #$FDFF            ; {1038557}
    STA $0016, X          ; {1038560}
    LDA $0030, X          ; {1038563}
    PHA                   ; {1038566}
    RTS                   ; {1038567}
}

code_0FD8E8 {
    COP [A3]              ; {1038568}
    COP [81] ( #32, #03 ) ; {1038570}
    COP [83]              ; {1038574}
    BRA loc_0FD93C        ; {1038576}
}

code_0FD8F2 {
    COP [A3]              ; {1038578}
    COP [96]              ; {1038580}
    COP [81] ( #35, #03 ) ; {1038582}
    COP [83]              ; {1038586}
    BRA loc_0FD93C        ; {1038588}
}

code_0FD8FE {
    COP [A3]              ; {1038590}
    COP [96]              ; {1038592}
    COP [81] ( #34, #03 ) ; {1038594}
    COP [83]              ; {1038598}
    BRA loc_0FD93C        ; {1038600}
}

code_0FD90A {
    COP [A3]              ; {1038602}
    COP [96]              ; {1038604}
    COP [81] ( #36, #03 ) ; {1038606}
    COP [83]              ; {1038610}
    BRA loc_0FD93C        ; {1038612}
}

code_0FD916 {
    COP [A3]              ; {1038614}
    COP [81] ( #33, #03 ) ; {1038616}
    COP [83]              ; {1038620}
    BRA loc_0FD93C        ; {1038622}
}

code_0FD920 {
    COP [A3]              ; {1038624}
    COP [81] ( #36, #03 ) ; {1038626}
    COP [83]              ; {1038630}
    BRA loc_0FD93C        ; {1038632}
}

code_0FD92A {
    COP [A3]              ; {1038634}
    COP [81] ( #34, #03 ) ; {1038636}
    COP [83]              ; {1038640}
    BRA loc_0FD93C        ; {1038642}
}

code_0FD934 {
    COP [A3]              ; {1038644}
    COP [81] ( #35, #03 ) ; {1038646}
    COP [83]              ; {1038650}

  loc_0FD93C:
    COP [80] ( #37 )      ; {1038652}
    COP [82]              ; {1038655}
    COP [86]              ; {1038657}
    RTL                   ; {1038659}
}

code_0FD944 {
    LDA $0016, X          ; {1038660}
    BIT #$8000            ; {1038663}
    BEQ loc_0FD952        ; {1038666}

  code_0FD94C:
    COP [1B] ( &code_0FD944, #$0004 ) ; {1038668}

  loc_0FD952:
    COP [9B] ( #$0008, &code_0FD95C, &code_0FD976, &code_0FD969 ) ; {1038674}
}

code_0FD95C {
    COP [21] ( &code_0FD99C ) ; {1038684}
    COP [97]              ; {1038688}
    COP [80] ( #04 )      ; {1038690}
    COP [82]              ; {1038693}
    BRA code_0FD944       ; {1038695}
}

code_0FD969 {
    COP [22] ( &code_0FD99C ) ; {1038697}
    COP [97]              ; {1038701}
    COP [80] ( #03 )      ; {1038703}
    COP [82]              ; {1038706}
    BRA code_0FD944       ; {1038708}
}

code_0FD976 {
    COP [9A] ( #$0000, &code_0FD980, &code_0FD98A, &code_0FD98A ) ; {1038710}
}

code_0FD980 {
    COP [97]              ; {1038720}
    COP [81] ( #02, #02 ) ; {1038722}
    COP [83]              ; {1038726}
    BRA code_0FD994       ; {1038728}
}

code_0FD98A {
    COP [96]              ; {1038730}
    COP [81] ( #02, #02 ) ; {1038732}
    COP [83]              ; {1038736}
    BRA code_0FD994       ; {1038738}

  code_0FD994:
    LDA $0016, X          ; {1038740}
    BIT #$8000            ; {1038743}
    BEQ loc_0FD9A2        ; {1038746}
}

code_0FD99C {
    COP [1B] ( &code_0FD994, #$0004 ) ; {1038748}

  loc_0FD9A2:
    COP [9A] ( #$0008, &code_0FD9AC, &code_0FD9C6, &code_0FD9B9 ) ; {1038754}
}

code_0FD9AC {
    COP [23] ( &code_0FD94C ) ; {1038764}
    COP [97]              ; {1038768}
    COP [80] ( #05 )      ; {1038770}
    COP [82]              ; {1038773}
    BRA code_0FD994       ; {1038775}
}

code_0FD9B9 {
    COP [24] ( &code_0FD94C ) ; {1038777}
    COP [96]              ; {1038781}
    COP [80] ( #05 )      ; {1038783}
    COP [82]              ; {1038786}
    BRA code_0FD994       ; {1038788}
}

code_0FD9C6 {
    COP [9B] ( #$0000, &code_0FD9D0, &code_0FD9DB, &code_0FD9DB ) ; {1038790}
}

code_0FD9D0 {
    COP [97]              ; {1038800}
    COP [81] ( #01, #02 ) ; {1038802}
    COP [83]              ; {1038806}
    BRL code_0FD944       ; {1038808}
}

code_0FD9DB {
    COP [97]              ; {1038811}
    COP [81] ( #00, #02 ) ; {1038813}
    COP [83]              ; {1038817}
    BRL code_0FD944       ; {1038819}
}

code_0FD9E6 {
    LDA $0016, X          ; {1038822}
    BIT #$8000            ; {1038825}
    BEQ loc_0FD9F4        ; {1038828}

  code_0FD9EE:
    COP [1B] ( &code_0FD9E6, #$0004 ) ; {1038830}

  loc_0FD9F4:
    COP [9B] ( #$0008, &code_0FD9FE, &code_0FDA18, &code_0FDA0B ) ; {1038836}
}

code_0FD9FE {
    COP [21] ( &code_0FDA5C ) ; {1038846}
    COP [97]              ; {1038850}
    COP [80] ( #07 )      ; {1038852}
    COP [82]              ; {1038855}
    BRA code_0FD9E6       ; {1038857}
}

code_0FDA0B {
    COP [22] ( &code_0FDA5C ) ; {1038859}
    COP [97]              ; {1038863}
    COP [80] ( #06 )      ; {1038865}
    COP [82]              ; {1038868}
    BRA code_0FD9E6       ; {1038870}
}

code_0FDA18 {
    COP [9A] ( #$0000, &code_0FDA22, &code_0FDA3B, &code_0FDA3B ) ; {1038872}
}

code_0FDA22 {
    COP [97]              ; {1038882}
    COP [80] ( #0D )      ; {1038884}
    COP [82]              ; {1038887}
    COP [B2] ( &code_0FDAC4, #1F, #$FFF8, #$0000, #$0200 ) ; {1038889}
    COP [80] ( #0E )      ; {1038900}
    COP [82]              ; {1038903}
    BRA code_0FDA54       ; {1038905}
}

code_0FDA3B {
    COP [96]              ; {1038907}
    COP [80] ( #0D )      ; {1038909}
    COP [82]              ; {1038912}
    COP [B2] ( &code_0FDACE, #1F, #$0008, #$0000, #$0200 ) ; {1038914}
    COP [80] ( #0E )      ; {1038925}
    COP [82]              ; {1038928}
    BRA code_0FDA54       ; {1038930}

  code_0FDA54:
    LDA $0016, X          ; {1038932}
    BIT #$8000            ; {1038935}
    BEQ loc_0FDA62        ; {1038938}
}

code_0FDA5C {
    COP [1B] ( &code_0FDA54, #$0004 ) ; {1038940}

  loc_0FDA62:
    COP [9A] ( #$0008, &code_0FDA6C, &code_0FDA86, &code_0FDA79 ) ; {1038946}
}

code_0FDA6C {
    COP [23] ( &code_0FD9EE ) ; {1038956}
    COP [97]              ; {1038960}
    COP [80] ( #08 )      ; {1038962}
    COP [82]              ; {1038965}
    BRA code_0FDA54       ; {1038967}
}

code_0FDA79 {
    COP [24] ( &code_0FD9EE ) ; {1038969}
    COP [96]              ; {1038973}
    COP [80] ( #08 )      ; {1038975}
    COP [82]              ; {1038978}
    BRA code_0FDA54       ; {1038980}
}

code_0FDA86 {
    COP [9B] ( #$0000, &code_0FDA90, &code_0FDAAA, &code_0FDAAA ) ; {1038982}
}

code_0FDA90 {
    COP [97]              ; {1038992}
    COP [80] ( #0B )      ; {1038994}
    COP [82]              ; {1038997}
    COP [B2] ( &code_0FDAD8, #1F, #$0002, #$FFF8, #$0200 ) ; {1038999}
    COP [80] ( #0C )      ; {1039010}
    COP [82]              ; {1039013}
    BRL code_0FD9E6       ; {1039015}
}

code_0FDAAA {
    COP [97]              ; {1039018}
    COP [80] ( #09 )      ; {1039020}
    COP [82]              ; {1039023}
    COP [B2] ( &code_0FDAE2, #1F, #$FFFD, #$0008, #$0200 ) ; {1039025}
    COP [80] ( #0A )      ; {1039036}
    COP [82]              ; {1039039}
    BRL code_0FD9E6       ; {1039041}
}

code_0FDAC4 {
    BRK #$5B              ; {1039044}
    COP [81] ( #11, #08 ) ; {1039046}
    COP [83]              ; {1039050}
    BRA loc_0FDAEA        ; {1039052}
}

code_0FDACE {
    BRK #$5B              ; {1039054}
    COP [81] ( #11, #08 ) ; {1039056}
    COP [83]              ; {1039060}
    BRA loc_0FDAEA        ; {1039062}
}

code_0FDAD8 {
    BRK #$5B              ; {1039064}
    COP [81] ( #10, #08 ) ; {1039066}
    COP [83]              ; {1039070}
    BRA loc_0FDAEA        ; {1039072}
}

code_0FDAE2 {
    BRK #$5B              ; {1039074}
    COP [81] ( #0F, #08 ) ; {1039076}
    COP [83]              ; {1039080}

  loc_0FDAEA:
    COP [86]              ; {1039082}
    RTL                   ; {1039084}
}

code_0FDAED {
    LDA $0016, X          ; {1039085}
    BIT #$8000            ; {1039088}
    BEQ loc_0FDAFB        ; {1039091}

  code_0FDAF5:
    COP [1B] ( &code_0FDAED, #$0004 ) ; {1039093}

  loc_0FDAFB:
    COP [9B] ( #$0008, &code_0FDB05, &code_0FDB1F, &code_0FDB12 ) ; {1039099}
}

code_0FDB05 {
    COP [21] ( &code_0FDB7B ) ; {1039109}
    COP [97]              ; {1039113}
    COP [80] ( #16 )      ; {1039115}
    COP [82]              ; {1039118}
    BRA code_0FDAED       ; {1039120}
}

code_0FDB12 {
    COP [22] ( &code_0FDB7B ) ; {1039122}
    COP [97]              ; {1039126}
    COP [80] ( #12 )      ; {1039128}
    COP [82]              ; {1039131}
    BRA code_0FDAED       ; {1039133}
}

code_0FDB1F {
    COP [9A] ( #$0000, &code_0FDB29, &code_0FDB4E, &code_0FDB4E ) ; {1039135}
}

code_0FDB29 {
    COP [97]              ; {1039145}
    LDA $0016, X          ; {1039147}
    ORA #$1000            ; {1039150}
    STA $0016, X          ; {1039153}
    COP [80] ( #1B )      ; {1039156}
    COP [82]              ; {1039159}
    COP [80] ( #1C )      ; {1039161}
    COP [82]              ; {1039164}
    COP [80] ( #1D )      ; {1039166}
    COP [82]              ; {1039169}
    LDA $0016, X          ; {1039171}
    AND #$EFFF            ; {1039174}
    STA $0016, X          ; {1039177}
    BRA code_0FDB73       ; {1039180}
}

code_0FDB4E {
    COP [96]              ; {1039182}
    LDA $0016, X          ; {1039184}
    ORA #$1000            ; {1039187}
    STA $0016, X          ; {1039190}
    COP [80] ( #1B )      ; {1039193}
    COP [82]              ; {1039196}
    COP [80] ( #1C )      ; {1039198}
    COP [82]              ; {1039201}
    COP [80] ( #1D )      ; {1039203}
    COP [82]              ; {1039206}
    LDA $0016, X          ; {1039208}
    AND #$EFFF            ; {1039211}
    STA $0016, X          ; {1039214}
    BRA code_0FDB73       ; {1039217}

  code_0FDB73:
    LDA $0016, X          ; {1039219}
    BIT #$8000            ; {1039222}
    BEQ loc_0FDB81        ; {1039225}
}

code_0FDB7B {
    COP [1B] ( &code_0FDB73, #$0004 ) ; {1039227}

  loc_0FDB81:
    COP [9A] ( #$0008, &code_0FDB8B, &code_0FDBA5, &code_0FDB98 ) ; {1039233}
}

code_0FDB8B {
    COP [23] ( &code_0FDAF5 ) ; {1039243}
    COP [97]              ; {1039247}
    COP [80] ( #1A )      ; {1039249}
    COP [82]              ; {1039252}
    BRA code_0FDB73       ; {1039254}
}

code_0FDB98 {
    COP [24] ( &code_0FDAF5 ) ; {1039256}
    COP [96]              ; {1039260}
    COP [80] ( #1A )      ; {1039262}
    COP [82]              ; {1039265}
    BRA code_0FDB73       ; {1039267}
}

code_0FDBA5 {
    COP [9B] ( #$0000, &code_0FDBAF, &code_0FDBD5, &code_0FDBD5 ) ; {1039269}
}

code_0FDBAF {
    COP [97]              ; {1039279}
    LDA $0016, X          ; {1039281}
    ORA #$1000            ; {1039284}
    STA $0016, X          ; {1039287}
    COP [80] ( #17 )      ; {1039290}
    COP [82]              ; {1039293}
    COP [80] ( #18 )      ; {1039295}
    COP [82]              ; {1039298}
    COP [80] ( #19 )      ; {1039300}
    COP [82]              ; {1039303}
    LDA $0016, X          ; {1039305}
    AND #$EFFF            ; {1039308}
    STA $0016, X          ; {1039311}
    BRL code_0FDAED       ; {1039314}
}

code_0FDBD5 {
    COP [97]              ; {1039317}
    LDA $0016, X          ; {1039319}
    ORA #$1000            ; {1039322}
    STA $0016, X          ; {1039325}
    COP [80] ( #13 )      ; {1039328}
    COP [82]              ; {1039331}
    COP [80] ( #14 )      ; {1039333}
    COP [82]              ; {1039336}
    COP [80] ( #15 )      ; {1039338}
    COP [82]              ; {1039341}
    LDA $0016, X          ; {1039343}
    AND #$EFFF            ; {1039346}
    STA $0016, X          ; {1039349}
    BRL code_0FDAED       ; {1039352}
}

code_0FDBFB {
    COP [A2] ( #20 )      ; {1039355}

  code_0FDBFE:
    LDA $0016, X          ; {1039358}
    BIT #$8000            ; {1039361}
    BEQ loc_0FDC0C        ; {1039364}

  code_0FDC06:
    COP [1B] ( &code_0FDBFE, #$0020 ) ; {1039366}

  loc_0FDC0C:
    COP [9A] ( #$0010, &code_0FDC16, &code_0FDC20, &code_0FDC16 ) ; {1039372}
}

code_0FDC16 {
    COP [9B] ( #$0010, &code_0FDC06, &code_0FDC2A, &code_0FDC06 ) ; {1039382}
}

code_0FDC20 {
    COP [9B] ( #$0000, &code_0FDC70, &code_0FDC8F, &code_0FDC8F ) ; {1039392}
}

code_0FDC2A {
    COP [9A] ( #$0000, &code_0FDC34, &code_0FDC52, &code_0FDC52 ) ; {1039402}
}

code_0FDC34 {
    COP [97]              ; {1039412}
    COP [80] ( #27 )      ; {1039414}
    COP [82]              ; {1039417}
    COP [B2] ( &code_0FDCAE, #1F, #$FFF8, #$FFF8, #$0300 ) ; {1039419}
    COP [80] ( #29 )      ; {1039430}
    COP [82]              ; {1039433}
    COP [80] ( #26 )      ; {1039435}
    COP [82]              ; {1039438}
    BRA code_0FDC06       ; {1039440}
}

code_0FDC52 {
    COP [96]              ; {1039442}
    COP [80] ( #27 )      ; {1039444}
    COP [82]              ; {1039447}
    COP [B2] ( &code_0FDCBB, #1F, #$0008, #$FFF8, #$0300 ) ; {1039449}
    COP [80] ( #29 )      ; {1039460}
    COP [82]              ; {1039463}
    COP [80] ( #26 )      ; {1039465}
    COP [82]              ; {1039468}
    BRA code_0FDC06       ; {1039470}
}

code_0FDC70 {
    COP [97]              ; {1039472}
    COP [80] ( #23 )      ; {1039474}
    COP [82]              ; {1039477}
    COP [B2] ( &code_0FDCC8, #1F, #$0000, #$FFF0, #$0300 ) ; {1039479}
    COP [80] ( #25 )      ; {1039490}
    COP [82]              ; {1039493}
    COP [80] ( #22 )      ; {1039495}
    COP [82]              ; {1039498}
    BRL code_0FDC06       ; {1039500}
}

code_0FDC8F {
    COP [97]              ; {1039503}
    COP [80] ( #1F )      ; {1039505}
    COP [82]              ; {1039508}
    COP [B2] ( &code_0FDCD5, #1F, #$0000, #$FFF8, #$0300 ) ; {1039510}
    COP [80] ( #21 )      ; {1039521}
    COP [82]              ; {1039524}
    COP [80] ( #1E )      ; {1039526}
    COP [82]              ; {1039529}
    BRL code_0FDC06       ; {1039531}
}

code_0FDCAE {
    COP [97]              ; {1039534}
    COP [A3]              ; {1039536}
    BRK #$52              ; {1039538}
    COP [80] ( #28 )      ; {1039540}
    COP [82]              ; {1039543}
    BRA loc_0FDCE0        ; {1039545}
}

code_0FDCBB {
    COP [96]              ; {1039547}
    COP [A3]              ; {1039549}
    BRK #$52              ; {1039551}
    COP [80] ( #28 )      ; {1039553}
    COP [82]              ; {1039556}
    BRA loc_0FDCE0        ; {1039558}
}

code_0FDCC8 {
    COP [97]              ; {1039560}
    COP [A3]              ; {1039562}
    BRK #$52              ; {1039564}
    COP [80] ( #24 )      ; {1039566}
    COP [82]              ; {1039569}
    BRA loc_0FDCE0        ; {1039571}
}

code_0FDCD5 {
    COP [97]              ; {1039573}
    COP [A3]              ; {1039575}
    BRK #$52              ; {1039577}
    COP [80] ( #20 )      ; {1039579}
    COP [82]              ; {1039582}

  loc_0FDCE0:
    LDA $0016, X          ; {1039584}
    AND #$FEFF            ; {1039587}
    STA $0016, X          ; {1039590}
    COP [A2] ( #30 )      ; {1039593}
    COP [A1] ( #$FFF8, #$0008 ) ; {1039596}
    BRK #$61              ; {1039602}
    COP [80] ( #2A )      ; {1039604}
    COP [82]              ; {1039607}
    COP [86]              ; {1039609}
    RTL                   ; {1039611}
}

code_0FDCFC {
    COP [A2] ( #20 )      ; {1039612}
    COP [A5] ( &code_0FDD09, &code_0FDDD9, &code_0FDD94, &code_0FDD4E ) ; {1039615}
}

code_0FDD09 {
    COP [AD] ( #08 )      ; {1039625}
    COP [22] ( &code_0FDD33 ) ; {1039628}
    COP [81] ( #2D, #04 ) ; {1039632}
    COP [83]              ; {1039636}
    COP [22] ( &code_0FDD33 ) ; {1039638}
    COP [81] ( #2D, #04 ) ; {1039642}
    COP [83]              ; {1039646}

  loc_0FDD20:
    COP [B2] ( &code_0FDE3B, #1F, #$0000, #$FFFA, #$0200 ) ; {1039648}
    COP [81] ( #2B, #08 ) ; {1039659}
    COP [83]              ; {1039663}
    BRA code_0FDD09       ; {1039665}
}

code_0FDD33 {
    COP [80] ( #2B )      ; {1039667}
    COP [82]              ; {1039670}
    COP [80] ( #32 )      ; {1039672}
    COP [82]              ; {1039675}
    COP [80] ( #2C )      ; {1039677}
    COP [82]              ; {1039680}
    COP [80] ( #31 )      ; {1039682}
    COP [82]              ; {1039685}
    COP [80] ( #2B )      ; {1039687}
    COP [82]              ; {1039690}
    BRA loc_0FDD65        ; {1039692}
}

code_0FDD4E {
    COP [AD] ( #08 )      ; {1039694}
    COP [21] ( &code_0FDD78 ) ; {1039697}
    COP [81] ( #2E, #04 ) ; {1039701}
    COP [83]              ; {1039705}
    COP [21] ( &code_0FDD78 ) ; {1039707}
    COP [81] ( #2E, #04 ) ; {1039711}
    COP [83]              ; {1039715}

  loc_0FDD65:
    COP [B2] ( &code_0FDE2E, #1F, #$0000, #$FFE6, #$0200 ) ; {1039717}
    COP [81] ( #2B, #08 ) ; {1039728}
    COP [83]              ; {1039732}
    BRA code_0FDD4E       ; {1039734}
}

code_0FDD78 {
    COP [80] ( #2B )      ; {1039736}
    COP [82]              ; {1039739}
    COP [80] ( #32 )      ; {1039741}
    COP [82]              ; {1039744}
    COP [80] ( #2C )      ; {1039746}
    COP [82]              ; {1039749}
    COP [80] ( #31 )      ; {1039751}
    COP [82]              ; {1039754}
    COP [80] ( #2B )      ; {1039756}
    COP [82]              ; {1039759}
    BRL loc_0FDD20        ; {1039761}
}

code_0FDD94 {
    COP [AD] ( #08 )      ; {1039764}
    COP [24] ( &code_0FDDBE ) ; {1039767}
    COP [81] ( #30, #04 ) ; {1039771}
    COP [83]              ; {1039775}
    COP [24] ( &code_0FDDBE ) ; {1039777}
    COP [81] ( #30, #04 ) ; {1039781}
    COP [83]              ; {1039785}

  loc_0FDDAB:
    COP [B2] ( &code_0FDE1F, #1F, #$0012, #$FFF9, #$0200 ) ; {1039787}
    COP [81] ( #2C, #08 ) ; {1039798}
    COP [83]              ; {1039802}
    BRA code_0FDD94       ; {1039804}
}

code_0FDDBE {
    COP [80] ( #2C )      ; {1039806}
    COP [82]              ; {1039809}
    COP [80] ( #32 )      ; {1039811}
    COP [82]              ; {1039814}
    COP [80] ( #2B )      ; {1039816}
    COP [82]              ; {1039819}
    COP [80] ( #31 )      ; {1039821}
    COP [82]              ; {1039824}
    COP [80] ( #2C )      ; {1039826}
    COP [82]              ; {1039829}
    BRA loc_0FDDF0        ; {1039831}
}

code_0FDDD9 {
    COP [AD] ( #08 )      ; {1039833}
    COP [23] ( &code_0FDE03 ) ; {1039836}
    COP [81] ( #2F, #04 ) ; {1039840}
    COP [83]              ; {1039844}
    COP [23] ( &code_0FDE03 ) ; {1039846}
    COP [81] ( #2F, #04 ) ; {1039850}
    COP [83]              ; {1039854}

  loc_0FDDF0:
    COP [B2] ( &code_0FDE21, #1F, #$FFFB, #$FFF9, #$0200 ) ; {1039856}
    COP [81] ( #2C, #08 ) ; {1039867}
    COP [83]              ; {1039871}
    BRA code_0FDDD9       ; {1039873}
}

code_0FDE03 {
    COP [80] ( #2C )      ; {1039875}
    COP [82]              ; {1039878}
    COP [80] ( #32 )      ; {1039880}
    COP [82]              ; {1039883}
    COP [80] ( #2B )      ; {1039885}
    COP [82]              ; {1039888}
    COP [80] ( #31 )      ; {1039890}
    COP [82]              ; {1039893}
    COP [80] ( #2C )      ; {1039895}
    COP [82]              ; {1039898}
    BRL loc_0FDDAB        ; {1039900}
}

code_0FDE1F {
    COP [96]              ; {1039903}
}

code_0FDE21 {
    COP [A3]              ; {1039905}
    COP [A2] ( #30 )      ; {1039907}
    COP [80] ( #35 )      ; {1039910}
    COP [82]              ; {1039913}
    COP [86]              ; {1039915}
    RTL                   ; {1039917}
}

code_0FDE2E {
    COP [A3]              ; {1039918}
    COP [A2] ( #30 )      ; {1039920}
    COP [80] ( #34 )      ; {1039923}
    COP [82]              ; {1039926}
    COP [86]              ; {1039928}
    RTL                   ; {1039930}
}

code_0FDE3B {
    COP [A3]              ; {1039931}
    COP [A2] ( #30 )      ; {1039933}
    COP [80] ( #33 )      ; {1039936}
    COP [82]              ; {1039939}
    COP [86]              ; {1039941}
    RTL                   ; {1039943}
}

code_0FDE48 {
    LDA $001A, X          ; {1039944}
    ORA #$0200            ; {1039947}
    STA $001A, X          ; {1039950}
    COP [A5] ( &code_0FDE5B, &code_0FDE65, &code_0FDE5B, &code_0FDE65 ) ; {1039953}
}

code_0FDE5B {
    COP [80] ( #01 )      ; {1039963}
    COP [82]              ; {1039966}
    COP [AD] ( #10 )      ; {1039968}
    BRA code_0FDE5B       ; {1039971}
}

code_0FDE65 {
    COP [96]              ; {1039973}

  loc_0FDE67:
    COP [80] ( #00 )      ; {1039975}
    COP [82]              ; {1039978}
    COP [AD] ( #10 )      ; {1039980}
    BRA loc_0FDE67        ; {1039983}
}

code_0FDE71 {
    COP [A5] ( &code_0FDE7B, &code_0FDEC7, &code_0FDF13, &code_0FDF61 ) ; {1039985}
}

code_0FDE7B {
    LDA $0016, X          ; {1039995}
    BIT #$8000            ; {1039998}
    BEQ loc_0FDE89        ; {1040001}

  code_0FDE83:
    COP [1B] ( &code_0FDE7B, #$0078 ) ; {1040003}

  loc_0FDE89:
    COP [0C] ( #00, #07, &code_0FDE91 ) ; {1040009}
    BRA code_0FDE83       ; {1040015}
}

code_0FDE91 {
    COP [9B] ( #$0010, &code_0FDE83, &code_0FDE83, &code_0FDE9B ) ; {1040017}
}

code_0FDE9B {
    COP [28] ( &code_0FDEA3 ) ; {1040027}
    COP [27] ( &code_0FDE83 ) ; {1040031}
}

code_0FDEA3 {
    LDA $0016, X          ; {1040035}
    AND #$DFFF            ; {1040038}
    STA $0016, X          ; {1040041}
    COP [80] ( #02 )      ; {1040044}
    COP [82]              ; {1040047}
    COP [B2] ( &code_0FDFAD, #1F, #$0000, #$0010, #$0200 ) ; {1040049}
    LDA $0016, X          ; {1040060}
    ORA #$2000            ; {1040063}
    STA $0016, X          ; {1040066}
    BRA code_0FDE83       ; {1040069}
}

code_0FDEC7 {
    LDA $0016, X          ; {1040071}
    BIT #$8000            ; {1040074}
    BEQ loc_0FDED5        ; {1040077}

  code_0FDECF:
    COP [1B] ( &code_0FDEC7, #$0078 ) ; {1040079}

  loc_0FDED5:
    COP [0C] ( #00, #07, &code_0FDEDD ) ; {1040085}
    BRA code_0FDECF       ; {1040091}
}

code_0FDEDD {
    COP [9A] ( #$0010, &code_0FDEE7, &code_0FDECF, &code_0FDECF ) ; {1040093}
}

code_0FDEE7 {
    COP [28] ( &code_0FDEEF ) ; {1040103}
    COP [27] ( &code_0FDECF ) ; {1040107}
}

code_0FDEEF {
    LDA $0016, X          ; {1040111}
    AND #$DFFF            ; {1040114}
    STA $0016, X          ; {1040117}
    COP [80] ( #04 )      ; {1040120}
    COP [82]              ; {1040123}
    COP [B2] ( &code_0FDFAD, #1F, #$FFF0, #$0000, #$0200 ) ; {1040125}
    LDA $0016, X          ; {1040136}
    ORA #$2000            ; {1040139}
    STA $0016, X          ; {1040142}
    BRA code_0FDECF       ; {1040145}
}

code_0FDF13 {
    LDA $0016, X          ; {1040147}
    BIT #$8000            ; {1040150}
    BEQ loc_0FDF21        ; {1040153}

  code_0FDF1B:
    COP [1B] ( &code_0FDF13, #$0078 ) ; {1040155}

  loc_0FDF21:
    COP [0C] ( #00, #07, &code_0FDF29 ) ; {1040161}
    BRA code_0FDF1B       ; {1040167}
}

code_0FDF29 {
    COP [9A] ( #$0010, &code_0FDF1B, &code_0FDF1B, &code_0FDF33 ) ; {1040169}
}

code_0FDF33 {
    COP [28] ( &code_0FDF3B ) ; {1040179}
    COP [27] ( &code_0FDF1B ) ; {1040183}
}

code_0FDF3B {
    COP [96]              ; {1040187}
    LDA $0016, X          ; {1040189}
    AND #$DFFF            ; {1040192}
    STA $0016, X          ; {1040195}
    COP [80] ( #04 )      ; {1040198}
    COP [82]              ; {1040201}
    COP [B2] ( &code_0FDFAD, #1F, #$0010, #$0000, #$0200 ) ; {1040203}
    LDA $0016, X          ; {1040214}
    ORA #$2000            ; {1040217}
    STA $0016, X          ; {1040220}
    BRA code_0FDF1B       ; {1040223}
}

code_0FDF61 {
    LDA $0016, X          ; {1040225}
    BIT #$8000            ; {1040228}
    BEQ loc_0FDF6F        ; {1040231}

  code_0FDF69:
    COP [1B] ( &code_0FDF61, #$0078 ) ; {1040233}

  loc_0FDF6F:
    COP [0C] ( #00, #07, &code_0FDF77 ) ; {1040239}
    BRA code_0FDF69       ; {1040245}
}

code_0FDF77 {
    COP [9B] ( #$0010, &code_0FDF81, &code_0FDF69, &code_0FDF69 ) ; {1040247}
}

code_0FDF81 {
    COP [28] ( &code_0FDF89 ) ; {1040257}
    COP [27] ( &code_0FDF69 ) ; {1040261}
}

code_0FDF89 {
    LDA $0016, X          ; {1040265}
    AND #$DFFF            ; {1040268}
    STA $0016, X          ; {1040271}
    COP [80] ( #03 )      ; {1040274}
    COP [82]              ; {1040277}
    COP [B2] ( &code_0FDFAD, #1F, #$0000, #$FFF0, #$0200 ) ; {1040279}
    LDA $0016, X          ; {1040290}
    ORA #$2000            ; {1040293}
    STA $0016, X          ; {1040296}
    BRA code_0FDF69       ; {1040299}
}

code_0FDFAD {
    COP [A3]              ; {1040301}
    BRK #$64              ; {1040303}
    LDY #$0005            ; {1040305}
    SEP #$20              ; {1040308}
    LDA #$^chunk_000000.code_002D67 ; {1040310}
    PHA                   ; {1040312}
    REP #$20              ; {1040313}
    LDA #$&chunk_000000.code_002D67-1 ; {1040315}
    PHA                   ; {1040318}
    RTL                   ; {1040319}
}

code_0FDFC0 {
    COP [86]              ; {1040320}
    RTL                   ; {1040322}
}

code_0FDFC3 {
    COP [AD] ( #08 )      ; {1040323}
    COP [0C] ( #00, #04, &code_0FDFD3 ) ; {1040326}
    COP [80] ( #0A )      ; {1040332}
    COP [82]              ; {1040335}
    BRA code_0FDFC3       ; {1040337}
}

code_0FDFD3 {
    COP [9A] ( #$0000, &code_0FDFE1, &code_0FDFDD, &code_0FDFDD ) ; {1040339}
}

code_0FDFDD {
    COP [96]              ; {1040349}
    BRA loc_0FDFE3        ; {1040351}
}

code_0FDFE1 {
    COP [97]              ; {1040353}

  loc_0FDFE3:
    COP [9B] ( #$0028, &code_0FDFF7, &code_0FDFED, &code_0FE00C ) ; {1040355}
}

code_0FDFED {
    COP [9B] ( #$0000, &code_0FDFFE, &code_0FE005, &code_0FE005 ) ; {1040365}
}

code_0FDFF7 {
    COP [80] ( #0E )      ; {1040375}
    COP [82]              ; {1040378}
    BRA loc_0FE011        ; {1040380}
}

code_0FDFFE {
    COP [80] ( #0D )      ; {1040382}
    COP [82]              ; {1040385}
    BRA loc_0FE011        ; {1040387}
}

code_0FE005 {
    COP [80] ( #0C )      ; {1040389}
    COP [82]              ; {1040392}
    BRA loc_0FE011        ; {1040394}
}

code_0FE00C {
    COP [80] ( #0B )      ; {1040396}
    COP [82]              ; {1040399}

  loc_0FE011:
    COP [81] ( #0A, #02 ) ; {1040401}
    COP [83]              ; {1040405}
    COP [0C] ( #00, #02, &code_0FDFC3 ) ; {1040407}
    COP [81] ( #0F, #04 ) ; {1040413}
    COP [83]              ; {1040417}
    COP [B0] ( @code_0FE032, #$0200 ) ; {1040419}
    COP [81] ( #0A, #02 ) ; {1040426}
    COP [83]              ; {1040430}
    BRA code_0FDFC3       ; {1040432}
}

code_0FE032 {
    COP [A3]              ; {1040434}
    BRK #$64              ; {1040436}
    LDY #$0010            ; {1040438}
    SEP #$20              ; {1040441}
    LDA #$^chunk_000000.code_002D67 ; {1040443}
    PHA                   ; {1040445}
    REP #$20              ; {1040446}
    LDA #$&chunk_000000.code_002D67-1 ; {1040448}
    PHA                   ; {1040451}
    RTL                   ; {1040452}
}

code_0FE045 {
    LDA $001A, X          ; {1040453}
    ORA #$0800            ; {1040456}
    STA $001A, X          ; {1040459}
    COP [AD] ( #08 )      ; {1040462}

  loc_0FE051:
    COP [9B] ( #$0008, &code_0FE05B, &code_0FE0CC, &code_0FE073 ) ; {1040465}
}

code_0FE05B {
    COP [97]              ; {1040475}

  code_0FE05D:
    COP [80] ( #19 )      ; {1040477}
    COP [82]              ; {1040480}
    COP [9B] ( #$0018, &code_0FE05D, &code_0FE06C, &code_0FE073 ) ; {1040482}
}

code_0FE06C {
    COP [80] ( #16 )      ; {1040492}
    COP [82]              ; {1040495}
    BRA loc_0FE089        ; {1040497}
}

code_0FE073 {
    COP [97]              ; {1040499}

  code_0FE075:
    COP [80] ( #18 )      ; {1040501}
    COP [82]              ; {1040504}
    COP [9B] ( #$0018, &code_0FE05B, &code_0FE084, &code_0FE075 ) ; {1040506}
}

code_0FE084 {
    COP [80] ( #15 )      ; {1040516}
    COP [82]              ; {1040519}

  loc_0FE089:
    COP [1F]              ; {1040521}
    LDA $0302             ; {1040523}
    BPL code_0FE0CC       ; {1040526}
    LDA $0016, X          ; {1040528}
    BIT #$0200            ; {1040531}
    BEQ loc_0FE0B3        ; {1040534}
    LDA $0016, X          ; {1040536}
    AND #$DFFF            ; {1040539}
    STA $0016, X          ; {1040542}
    BRK #$60              ; {1040545}
    COP [80] ( #1C )      ; {1040547}
    COP [82]              ; {1040550}
    LDA $0016, X          ; {1040552}
    AND #$FDFF            ; {1040555}
    STA $0016, X          ; {1040558}
    BRA code_0FE0CC       ; {1040561}

  loc_0FE0B3:
    LDA $0016, X          ; {1040563}
    ORA #$0200            ; {1040566}
    STA $0016, X          ; {1040569}
    BRK #$60              ; {1040572}
    COP [80] ( #1B )      ; {1040574}
    COP [82]              ; {1040577}
    LDA $0016, X          ; {1040579}
    ORA #$2000            ; {1040582}
    STA $0016, X          ; {1040585}
}

code_0FE0CC {
    COP [9A] ( #$0008, &code_0FE0D6, &code_0FE104, &code_0FE0EE ) ; {1040588}
}

code_0FE0D6 {
    COP [97]              ; {1040598}

  code_0FE0D8:
    COP [80] ( #1A )      ; {1040600}
    COP [82]              ; {1040603}
    COP [9A] ( #$0018, &code_0FE0D8, &code_0FE0E7, &code_0FE0EE ) ; {1040605}
}

code_0FE0E7 {
    COP [80] ( #17 )      ; {1040615}
    COP [82]              ; {1040618}
    BRA code_0FE104       ; {1040620}
}

code_0FE0EE {
    COP [96]              ; {1040622}

  code_0FE0F0:
    COP [80] ( #1A )      ; {1040624}
    COP [82]              ; {1040627}
    COP [9A] ( #$0018, &code_0FE0D6, &code_0FE0FF, &code_0FE0F0 ) ; {1040629}
}

code_0FE0FF {
    COP [80] ( #17 )      ; {1040639}
    COP [82]              ; {1040642}
}

code_0FE104 {
    COP [1F]              ; {1040644}
    LDA $0302             ; {1040646}
    BMI loc_0FE10E        ; {1040649}
    BRL loc_0FE051        ; {1040651}

  loc_0FE10E:
    LDA $0016, X          ; {1040654}
    BIT #$0200            ; {1040657}
    BEQ loc_0FE132        ; {1040660}
    LDA $0016, X          ; {1040662}
    AND #$DFFF            ; {1040665}
    STA $0016, X          ; {1040668}
    BRK #$60              ; {1040671}
    COP [80] ( #1C )      ; {1040673}
    COP [82]              ; {1040676}
    LDA $0016, X          ; {1040678}
    AND #$FDFF            ; {1040681}
    STA $0016, X          ; {1040684}
    BRL loc_0FE051        ; {1040687}

  loc_0FE132:
    LDA $0016, X          ; {1040690}
    ORA #$0200            ; {1040693}
    STA $0016, X          ; {1040696}
    BRK #$60              ; {1040699}
    COP [80] ( #1B )      ; {1040701}
    COP [82]              ; {1040704}
    LDA $0016, X          ; {1040706}
    ORA #$2000            ; {1040709}
    STA $0016, X          ; {1040712}
    BRL loc_0FE051        ; {1040715}
}

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

code_0FE22C {
    COP [80] ( #23 )      ; {1040940}
    COP [82]              ; {1040943}
    COP [AD] ( #08 )      ; {1040945}
    BRA code_0FE22C       ; {1040948}
}

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

code_0FE413 {
    COP [AA] ( #00 )      ; {1041427}

  loc_0FE416:
    COP [AD] ( #08 )      ; {1041430}
    COP [9B] ( #$0000, &code_0FE423, &code_0FE441, &code_0FE441 ) ; {1041433}
}

code_0FE423 {
    COP [97]              ; {1041443}
    COP [9B] ( #$0018, &code_0FE42F, &code_0FE4C0, &code_0FE42F ) ; {1041445}
}

code_0FE42F {
    COP [21] ( &code_0FE43A ) ; {1041455}
    COP [80] ( #08 )      ; {1041459}
    COP [82]              ; {1041462}
    BRA loc_0FE416        ; {1041464}
}

code_0FE43A {
    COP [80] ( #02 )      ; {1041466}
    COP [82]              ; {1041469}
    BRA loc_0FE416        ; {1041471}
}

code_0FE441 {
    COP [97]              ; {1041473}
    COP [9B] ( #$0018, &code_0FE44D, &code_0FE4A8, &code_0FE44D ) ; {1041475}
}

code_0FE44D {
    COP [22] ( &code_0FE458 ) ; {1041485}
    COP [80] ( #06 )      ; {1041489}
    COP [82]              ; {1041492}
    BRA loc_0FE416        ; {1041494}
}

code_0FE458 {
    COP [80] ( #00 )      ; {1041496}
    COP [82]              ; {1041499}
    BRA loc_0FE416        ; {1041501}

  loc_0FE45F:
    COP [AD] ( #08 )      ; {1041503}
    COP [9A] ( #$0000, &code_0FE46C, &code_0FE48A, &code_0FE48A ) ; {1041506}
}

code_0FE46C {
    COP [9A] ( #$0018, &code_0FE476, &code_0FE4D9, &code_0FE476 ) ; {1041516}
}

code_0FE476 {
    COP [97]              ; {1041526}
    COP [23] ( &code_0FE483 ) ; {1041528}
    COP [80] ( #0A )      ; {1041532}
    COP [82]              ; {1041535}
    BRA loc_0FE45F        ; {1041537}
}

code_0FE483 {
    COP [80] ( #04 )      ; {1041539}
    COP [82]              ; {1041542}
    BRA loc_0FE45F        ; {1041544}
}

code_0FE48A {
    COP [9A] ( #$0018, &code_0FE494, &code_0FE4D9, &code_0FE494 ) ; {1041546}
}

code_0FE494 {
    COP [96]              ; {1041556}
    COP [24] ( &code_0FE4A1 ) ; {1041558}
    COP [80] ( #0A )      ; {1041562}
    COP [82]              ; {1041565}
    BRA loc_0FE45F        ; {1041567}
}

code_0FE4A1 {
    COP [80] ( #04 )      ; {1041569}
    COP [82]              ; {1041572}
    BRA loc_0FE45F        ; {1041574}
}

code_0FE4A8 {
    BRK #$41              ; {1041576}
    COP [80] ( #0C )      ; {1041578}
    COP [82]              ; {1041581}
    COP [B0] ( @code_0FE4B8, #$0200 ) ; {1041583}
    BRA loc_0FE45F        ; {1041590}
}

code_0FE4B8 {
    COP [80] ( #19 )      ; {1041592}
    COP [82]              ; {1041595}
    COP [86]              ; {1041597}
    RTL                   ; {1041599}
}

code_0FE4C0 {
    BRK #$41              ; {1041600}
    COP [80] ( #0D )      ; {1041602}
    COP [82]              ; {1041605}
    COP [B0] ( @code_0FE4D1, #$0200 ) ; {1041607}
    BRL loc_0FE45F        ; {1041614}
}

code_0FE4D1 {
    COP [80] ( #1A )      ; {1041617}
    COP [82]              ; {1041620}
    COP [86]              ; {1041622}
    RTL                   ; {1041624}
}

code_0FE4D9 {
    BRK #$41              ; {1041625}
    COP [80] ( #0E )      ; {1041627}
    COP [82]              ; {1041630}
    COP [B0] ( @code_0FE4EA, #$0200 ) ; {1041632}
    BRL loc_0FE416        ; {1041639}
}

code_0FE4EA {
    COP [80] ( #1B )      ; {1041642}
    COP [82]              ; {1041645}
    COP [86]              ; {1041647}
    RTL                   ; {1041649}
}

code_0FE4F2 {
    COP [AA] ( #02 )      ; {1041650}

  loc_0FE4F5:
    COP [AD] ( #08 )      ; {1041653}
    COP [9B] ( #$0000, &code_0FE502, &code_0FE520, &code_0FE520 ) ; {1041656}
}

code_0FE502 {
    COP [97]              ; {1041666}
    COP [9B] ( #$0018, &code_0FE50E, &code_0FE5B2, &code_0FE50E ) ; {1041668}
}

code_0FE50E {
    COP [21] ( &code_0FE519 ) ; {1041678}
    COP [80] ( #08 )      ; {1041682}
    COP [82]              ; {1041685}
    BRA loc_0FE4F5        ; {1041687}
}

code_0FE519 {
    COP [80] ( #02 )      ; {1041689}
    COP [82]              ; {1041692}
    BRA loc_0FE4F5        ; {1041694}
}

code_0FE520 {
    COP [97]              ; {1041696}
    COP [9B] ( #$0018, &code_0FE52C, &code_0FE587, &code_0FE52C ) ; {1041698}
}

code_0FE52C {
    COP [22] ( &code_0FE537 ) ; {1041708}
    COP [80] ( #06 )      ; {1041712}
    COP [82]              ; {1041715}
    BRA loc_0FE4F5        ; {1041717}
}

code_0FE537 {
    COP [80] ( #00 )      ; {1041719}
    COP [82]              ; {1041722}
    BRA loc_0FE4F5        ; {1041724}

  loc_0FE53E:
    COP [AD] ( #08 )      ; {1041726}
    COP [9A] ( #$0000, &code_0FE54B, &code_0FE569, &code_0FE569 ) ; {1041729}
}

code_0FE54B {
    COP [9A] ( #$0018, &code_0FE555, &code_0FE5DE, &code_0FE555 ) ; {1041739}
}

code_0FE555 {
    COP [97]              ; {1041749}
    COP [23] ( &code_0FE562 ) ; {1041751}
    COP [80] ( #0A )      ; {1041755}
    COP [82]              ; {1041758}
    BRA loc_0FE53E        ; {1041760}
}

code_0FE562 {
    COP [80] ( #04 )      ; {1041762}
    COP [82]              ; {1041765}
    BRA loc_0FE53E        ; {1041767}
}

code_0FE569 {
    COP [9A] ( #$0018, &code_0FE573, &code_0FE5DE, &code_0FE573 ) ; {1041769}
}

code_0FE573 {
    COP [96]              ; {1041779}
    COP [24] ( &code_0FE580 ) ; {1041781}
    COP [80] ( #0A )      ; {1041785}
    COP [82]              ; {1041788}
    BRA loc_0FE53E        ; {1041790}
}

code_0FE580 {
    COP [80] ( #04 )      ; {1041792}
    COP [82]              ; {1041795}
    BRA loc_0FE53E        ; {1041797}
}

code_0FE587 {
    BRK #$52              ; {1041799}
    COP [80] ( #0F )      ; {1041801}
    COP [82]              ; {1041804}
    COP [B0] ( @code_0FE59C, #$0200 ) ; {1041806}
    COP [80] ( #10 )      ; {1041813}
    COP [82]              ; {1041816}
    BRA loc_0FE53E        ; {1041818}
}

code_0FE59C {
    COP [A3]              ; {1041820}
    COP [9A] ( #$0000, &code_0FE5AA, &code_0FE5A8, &code_0FE5A8 ) ; {1041822}
}

code_0FE5A8 {
    COP [96]              ; {1041832}
}

code_0FE5AA {
    COP [80] ( #15 )      ; {1041834}
    COP [82]              ; {1041837}
    COP [86]              ; {1041839}
    RTL                   ; {1041841}
}

code_0FE5B2 {
    BRK #$52              ; {1041842}
    COP [80] ( #11 )      ; {1041844}
    COP [82]              ; {1041847}
    COP [B0] ( @code_0FE5C8, #$0200 ) ; {1041849}
    COP [80] ( #12 )      ; {1041856}
    COP [82]              ; {1041859}
    BRL loc_0FE53E        ; {1041861}
}

code_0FE5C8 {
    COP [A3]              ; {1041864}
    COP [9A] ( #$0000, &code_0FE5D6, &code_0FE5D4, &code_0FE5D4 ) ; {1041866}
}

code_0FE5D4 {
    COP [96]              ; {1041876}
}

code_0FE5D6 {
    COP [80] ( #18 )      ; {1041878}
    COP [82]              ; {1041881}
    COP [86]              ; {1041883}
    RTL                   ; {1041885}
}

code_0FE5DE {
    BRK #$52              ; {1041886}
    COP [80] ( #13 )      ; {1041888}
    COP [82]              ; {1041891}
    COP [B0] ( @code_0FE5F4, #$0200 ) ; {1041893}
    COP [80] ( #14 )      ; {1041900}
    COP [82]              ; {1041903}
    BRL loc_0FE4F5        ; {1041905}
}

code_0FE5F4 {
    COP [A3]              ; {1041908}
    COP [9B] ( #$0000, &code_0FE600, &code_0FE608, &code_0FE608 ) ; {1041910}
}

code_0FE600 {
    COP [80] ( #17 )      ; {1041920}
    COP [82]              ; {1041923}
    COP [86]              ; {1041925}
    RTL                   ; {1041927}
}

code_0FE608 {
    COP [80] ( #16 )      ; {1041928}
    COP [82]              ; {1041931}
    COP [86]              ; {1041933}
    RTL                   ; {1041935}
}

code_0FE610 {
    COP [80] ( #1C )      ; {1041936}
    COP [82]              ; {1041939}
    COP [AD] ( #08 )      ; {1041941}
    BRA code_0FE610       ; {1041944}
}

code_0FE61A {
    COP [A5] ( &code_0FE624, &code_0FE670, &code_0FE6BC, &code_0FE70A ) ; {1041946}
}

code_0FE624 {
    LDA $0016, X          ; {1041956}
    BIT #$8000            ; {1041959}
    BEQ loc_0FE632        ; {1041962}

  code_0FE62C:
    COP [1B] ( &code_0FE624, #$0078 ) ; {1041964}

  loc_0FE632:
    COP [0C] ( #00, #07, &code_0FE63A ) ; {1041970}
    BRA code_0FE62C       ; {1041976}
}

code_0FE63A {
    COP [9B] ( #$0010, &code_0FE62C, &code_0FE62C, &code_0FE644 ) ; {1041978}
}

code_0FE644 {
    COP [28] ( &code_0FE64C ) ; {1041988}
    COP [27] ( &code_0FE62C ) ; {1041992}
}

code_0FE64C {
    LDA $0016, X          ; {1041996}
    AND #$DFFF            ; {1041999}
    STA $0016, X          ; {1042002}
    COP [80] ( #1D )      ; {1042005}
    COP [82]              ; {1042008}
    COP [B2] ( &code_0FE756, #1F, #$0000, #$0010, #$0200 ) ; {1042010}
    LDA $0016, X          ; {1042021}
    ORA #$2000            ; {1042024}
    STA $0016, X          ; {1042027}
    BRA code_0FE62C       ; {1042030}
}

code_0FE670 {
    LDA $0016, X          ; {1042032}
    BIT #$8000            ; {1042035}
    BEQ loc_0FE67E        ; {1042038}

  code_0FE678:
    COP [1B] ( &code_0FE670, #$0078 ) ; {1042040}

  loc_0FE67E:
    COP [0C] ( #00, #07, &code_0FE686 ) ; {1042046}
    BRA code_0FE678       ; {1042052}
}

code_0FE686 {
    COP [9A] ( #$0010, &code_0FE690, &code_0FE678, &code_0FE678 ) ; {1042054}
}

code_0FE690 {
    COP [28] ( &code_0FE698 ) ; {1042064}
    COP [27] ( &code_0FE678 ) ; {1042068}
}

code_0FE698 {
    LDA $0016, X          ; {1042072}
    AND #$DFFF            ; {1042075}
    STA $0016, X          ; {1042078}
    COP [80] ( #1F )      ; {1042081}
    COP [82]              ; {1042084}
    COP [B2] ( &code_0FE756, #1F, #$FFF0, #$0000, #$0200 ) ; {1042086}
    LDA $0016, X          ; {1042097}
    ORA #$2000            ; {1042100}
    STA $0016, X          ; {1042103}
    BRA code_0FE678       ; {1042106}
}

code_0FE6BC {
    LDA $0016, X          ; {1042108}
    BIT #$8000            ; {1042111}
    BEQ loc_0FE6CA        ; {1042114}

  code_0FE6C4:
    COP [1B] ( &code_0FE6BC, #$0078 ) ; {1042116}

  loc_0FE6CA:
    COP [0C] ( #00, #07, &code_0FE6D2 ) ; {1042122}
    BRA code_0FE6C4       ; {1042128}
}

code_0FE6D2 {
    COP [9A] ( #$0010, &code_0FE6C4, &code_0FE6C4, &code_0FE6DC ) ; {1042130}
}

code_0FE6DC {
    COP [28] ( &code_0FE6E4 ) ; {1042140}
    COP [27] ( &code_0FE6C4 ) ; {1042144}
}

code_0FE6E4 {
    COP [96]              ; {1042148}
    LDA $0016, X          ; {1042150}
    AND #$DFFF            ; {1042153}
    STA $0016, X          ; {1042156}
    COP [80] ( #1F )      ; {1042159}
    COP [82]              ; {1042162}
    COP [B2] ( &code_0FE756, #1F, #$0010, #$0000, #$0200 ) ; {1042164}
    LDA $0016, X          ; {1042175}
    ORA #$2000            ; {1042178}
    STA $0016, X          ; {1042181}
    BRA code_0FE6C4       ; {1042184}
}

code_0FE70A {
    LDA $0016, X          ; {1042186}
    BIT #$8000            ; {1042189}
    BEQ loc_0FE718        ; {1042192}

  code_0FE712:
    COP [1B] ( &code_0FE70A, #$0078 ) ; {1042194}

  loc_0FE718:
    COP [0C] ( #00, #07, &code_0FE720 ) ; {1042200}
    BRA code_0FE712       ; {1042206}
}

code_0FE720 {
    COP [9B] ( #$0010, &code_0FE72A, &code_0FE712, &code_0FE712 ) ; {1042208}
}

code_0FE72A {
    COP [28] ( &code_0FE732 ) ; {1042218}
    COP [27] ( &code_0FE712 ) ; {1042222}
}

code_0FE732 {
    LDA $0016, X          ; {1042226}
    AND #$DFFF            ; {1042229}
    STA $0016, X          ; {1042232}
    COP [80] ( #1E )      ; {1042235}
    COP [82]              ; {1042238}
    COP [B2] ( &code_0FE756, #1F, #$0000, #$FFF0, #$0200 ) ; {1042240}
    LDA $0016, X          ; {1042251}
    ORA #$2000            ; {1042254}
    STA $0016, X          ; {1042257}
    BRA code_0FE712       ; {1042260}
}

code_0FE756 {
    COP [A3]              ; {1042262}
    BRK #$64              ; {1042264}
    LDY #$0020            ; {1042266}
    SEP #$20              ; {1042269}
    LDA #$^chunk_000000.code_002D67 ; {1042271}
    PHA                   ; {1042273}
    REP #$20              ; {1042274}
    LDA #$&chunk_000000.code_002D67-1 ; {1042276}
    PHA                   ; {1042279}
    RTL                   ; {1042280}
}

code_0FE769 {
    COP [86]              ; {1042281}
    RTL                   ; {1042283}
}

code_0FE76C {
    LDA $0016, X          ; {1042284}
    ORA #$2000            ; {1042287}
    STA $0016, X          ; {1042290}

  code_0FE775:
    COP [28] ( &code_0FE77B ) ; {1042293}
    BRA loc_0FE781        ; {1042297}
}

code_0FE77B {
    COP [1B] ( &code_0FE775, #$0008 ) ; {1042299}

  loc_0FE781:
    LDA $0016, X          ; {1042305}
    AND #$DFFF            ; {1042308}
    STA $0016, X          ; {1042311}

  code_0FE78A:
    COP [AD] ( #08 )      ; {1042314}
    LDA $0016, X          ; {1042317}
    ORA #$0200            ; {1042320}
    STA $0016, X          ; {1042323}
    COP [15]              ; {1042326}
    COP [97]              ; {1042328}
    COP [03] ( #32 )      ; {1042330}
    COP [0C] ( #00, #01, &code_0FE7E1 ) ; {1042333}
    COP [80] ( #25 )      ; {1042339}
    COP [82]              ; {1042342}
    COP [04]              ; {1042344}
    COP [80] ( #29 )      ; {1042346}
    COP [82]              ; {1042349}
    COP [16]              ; {1042351}
    LDA $0016, X          ; {1042353}
    AND #$FDFF            ; {1042356}
    STA $0016, X          ; {1042359}
    COP [1F]              ; {1042362}
    LDA $0302             ; {1042364}
    AND #$0003            ; {1042367}
    BEQ loc_0FE7CC        ; {1042370}
    DEC                   ; {1042372}
    BEQ loc_0FE7D3        ; {1042373}
    DEC                   ; {1042375}
    BEQ loc_0FE7DA        ; {1042376}
    COP [96]              ; {1042378}

  loc_0FE7CC:
    COP [80] ( #28 )      ; {1042380}
    COP [82]              ; {1042383}
    BRA code_0FE78A       ; {1042385}

  loc_0FE7D3:
    COP [80] ( #27 )      ; {1042387}
    COP [82]              ; {1042390}
    BRA code_0FE78A       ; {1042392}

  loc_0FE7DA:
    COP [80] ( #26 )      ; {1042394}
    COP [82]              ; {1042397}
    BRA code_0FE78A       ; {1042399}
}

code_0FE7E1 {
    COP [81] ( #25, #0A ) ; {1042401}
    COP [83]              ; {1042405}
    COP [16]              ; {1042407}
    LDA $0016, X          ; {1042409}
    AND #$FDFF            ; {1042412}
    STA $0016, X          ; {1042415}

  code_0FE7F2:
    COP [1B] ( &code_0FE7F8, #$0008 ) ; {1042418}
}

code_0FE7F8 {
    COP [9C] ( &code_0FE7FE, &code_0FE808 ) ; {1042424}
}

code_0FE7FE {
    COP [9A] ( #$0008, &code_0FE828, &code_0FE808, &code_0FE833 ) ; {1042430}
}

code_0FE808 {
    COP [9B] ( #$0008, &code_0FE812, &code_0FE7F2, &code_0FE81D ) ; {1042440}
}

code_0FE812 {
    COP [97]              ; {1042450}
    COP [9D] ( #2B )      ; {1042452}
    COP [9E] ( &code_0FE78A ) ; {1042455}

  loc_0FE81B:
    BRA code_0FE7F2       ; {1042459}
}

code_0FE81D {
    COP [97]              ; {1042461}
    COP [9D] ( #2A )      ; {1042463}
    COP [9E] ( &code_0FE78A ) ; {1042466}

  loc_0FE826:
    BRA code_0FE7F2       ; {1042470}
}

code_0FE828 {
    COP [97]              ; {1042472}
    COP [9D] ( #2C )      ; {1042474}
    COP [9E] ( &code_0FE78A ) ; {1042477}

  loc_0FE831:
    BRA code_0FE7F2       ; {1042481}
}

code_0FE833 {
    COP [96]              ; {1042483}
    COP [9D] ( #2C )      ; {1042485}
    COP [9E] ( &code_0FE78A ) ; {1042488}

  loc_0FE83C:
    BRA code_0FE7F2       ; {1042492}
}

code_0FE83E {
    COP [AD] ( #08 )      ; {1042494}

  loc_0FE841:
    COP [80] ( #2E )      ; {1042497}
    COP [82]              ; {1042500}
    COP [80] ( #30 )      ; {1042502}
    COP [82]              ; {1042505}
    COP [80] ( #2E )      ; {1042507}
    COP [82]              ; {1042510}
    COP [96]              ; {1042512}
    COP [80] ( #2F )      ; {1042514}
    COP [82]              ; {1042517}
    COP [80] ( #2E )      ; {1042519}
    COP [82]              ; {1042522}
    COP [96]              ; {1042524}
    COP [80] ( #30 )      ; {1042526}
    COP [82]              ; {1042529}
    COP [80] ( #2E )      ; {1042531}
    COP [82]              ; {1042534}
    COP [97]              ; {1042536}
    COP [80] ( #2F )      ; {1042538}
    COP [82]              ; {1042541}
    COP [80] ( #2E )      ; {1042543}
    COP [82]              ; {1042546}
    COP [80] ( #30 )      ; {1042548}
    COP [82]              ; {1042551}
    COP [96]              ; {1042553}
    COP [80] ( #30 )      ; {1042555}
    COP [82]              ; {1042558}
    COP [80] ( #2F )      ; {1042560}
    COP [82]              ; {1042563}
    COP [97]              ; {1042565}
    COP [80] ( #2F )      ; {1042567}
    COP [82]              ; {1042570}
    BRA loc_0FE841        ; {1042572}
}

code_0FE88E {
    LDA $0016, X          ; {1042574}
    BIT #$8000            ; {1042577}
    BEQ loc_0FE89C        ; {1042580}
    COP [1B] ( &code_0FE88E, #$0008 ) ; {1042582}

  loc_0FE89C:
    COP [9A] ( #$0000, &code_0FE8A6, &code_0FE8B0, &code_0FE8B0 ) ; {1042588}
}

code_0FE8A6 {
    COP [9B] ( #$0000, &code_0FE936, &code_0FE90E, &code_0FE90E ) ; {1042598}
}

code_0FE8B0 {
    COP [9B] ( #$0000, &code_0FE8BA, &code_0FE8E4, &code_0FE8E4 ) ; {1042608}
}

code_0FE8BA {
    COP [1F]              ; {1042618}
    LDA $0302             ; {1042620}
    BMI loc_0FE8D3        ; {1042623}
    COP [97]              ; {1042625}
    COP [AE] ( #$0010, #$FFE0, &code_0FE990 ) ; {1042627}
    COP [80] ( #43 )      ; {1042635}
    COP [82]              ; {1042638}
    BRL code_0FE990       ; {1042640}

  loc_0FE8D3:
    COP [96]              ; {1042643}
    COP [AE] ( #$0020, #$FFF0, &code_0FE95D ) ; {1042645}
    COP [80] ( #45 )      ; {1042653}
    COP [82]              ; {1042656}
    BRA code_0FE95D       ; {1042658}
}

code_0FE8E4 {
    COP [1F]              ; {1042660}
    LDA $0302             ; {1042662}
    BMI loc_0FE8FC        ; {1042665}
    COP [96]              ; {1042667}
    COP [AE] ( #$0020, #$0010, &code_0FE95D ) ; {1042669}
    COP [80] ( #44 )      ; {1042677}
    COP [82]              ; {1042680}
    BRA code_0FE95D       ; {1042682}

  loc_0FE8FC:
    COP [97]              ; {1042684}
    COP [AE] ( #$0010, #$0020, &code_0FE9C3 ) ; {1042686}
    COP [80] ( #41 )      ; {1042694}
    COP [82]              ; {1042697}
    BRL code_0FE9C3       ; {1042699}
}

code_0FE90E {
    COP [97]              ; {1042702}
    COP [1F]              ; {1042704}
    LDA $0302             ; {1042706}
    BMI loc_0FE927        ; {1042709}
    COP [AE] ( #$FFF0, #$0020, &code_0FE9C3 ) ; {1042711}
    COP [80] ( #40 )      ; {1042719}
    COP [82]              ; {1042722}
    BRL code_0FE9C3       ; {1042724}

  loc_0FE927:
    COP [AE] ( #$FFE0, #$0010, &code_0FE95D ) ; {1042727}
    COP [80] ( #44 )      ; {1042735}
    COP [82]              ; {1042738}
    BRA code_0FE95D       ; {1042740}
}

code_0FE936 {
    COP [97]              ; {1042742}
    COP [1F]              ; {1042744}
    LDA $0302             ; {1042746}
    BMI loc_0FE94E        ; {1042749}
    COP [AE] ( #$FFE0, #$FFF0, &code_0FE95D ) ; {1042751}
    COP [80] ( #45 )      ; {1042759}
    COP [82]              ; {1042762}
    BRA code_0FE95D       ; {1042764}

  loc_0FE94E:
    COP [AE] ( #$FFF0, #$FFE0, &code_0FE990 ) ; {1042766}
    COP [80] ( #42 )      ; {1042774}
    COP [82]              ; {1042777}
    BRA code_0FE990       ; {1042779}
}

code_0FE95D {
    COP [81] ( #3F, #04 ) ; {1042781}
    COP [83]              ; {1042785}
    LDA $0016, X          ; {1042787}
    ORA #$0200            ; {1042790}
    STA $0016, X          ; {1042793}
    COP [80] ( #4C )      ; {1042796}
    COP [82]              ; {1042799}
    JSR $&code_0FE9F6     ; {1042801}
    COP [80] ( #4D )      ; {1042804}
    COP [82]              ; {1042807}
    COP [80] ( #4E )      ; {1042809}
    COP [82]              ; {1042812}
    LDA $0016, X          ; {1042814}
    AND #$FDFF            ; {1042817}
    STA $0016, X          ; {1042820}
    COP [81] ( #3F, #04 ) ; {1042823}
    COP [83]              ; {1042827}
    BRL code_0FE88E       ; {1042829}
}

code_0FE990 {
    COP [81] ( #3E, #04 ) ; {1042832}
    COP [83]              ; {1042836}
    LDA $0016, X          ; {1042838}
    ORA #$0200            ; {1042841}
    STA $0016, X          ; {1042844}
    COP [80] ( #49 )      ; {1042847}
    COP [82]              ; {1042850}
    JSR $&code_0FE9F6     ; {1042852}
    COP [80] ( #4A )      ; {1042855}
    COP [82]              ; {1042858}
    COP [80] ( #4B )      ; {1042860}
    COP [82]              ; {1042863}
    LDA $0016, X          ; {1042865}
    AND #$FDFF            ; {1042868}
    STA $0016, X          ; {1042871}
    COP [81] ( #3E, #04 ) ; {1042874}
    COP [83]              ; {1042878}
    BRL code_0FE88E       ; {1042880}
}

code_0FE9C3 {
    COP [81] ( #3D, #04 ) ; {1042883}
    COP [83]              ; {1042887}
    LDA $0016, X          ; {1042889}
    ORA #$0200            ; {1042892}
    STA $0016, X          ; {1042895}
    COP [80] ( #46 )      ; {1042898}
    COP [82]              ; {1042901}
    JSR $&code_0FE9F6     ; {1042903}
    COP [80] ( #47 )      ; {1042906}
    COP [82]              ; {1042909}
    COP [80] ( #48 )      ; {1042911}
    COP [82]              ; {1042914}
    LDA $0016, X          ; {1042916}
    AND #$FDFF            ; {1042919}
    STA $0016, X          ; {1042922}
    COP [81] ( #3D, #04 ) ; {1042925}
    COP [83]              ; {1042929}
    BRL code_0FE88E       ; {1042931}
}

code_0FE9F6 {
    COP [B2] ( &code_0FEA0D, #1F, #$0000, #$0010, #$0200 ) ; {1042934}
    COP [B2] ( &code_0FEA15, #1F, #$FFF0, #$0000, #$0200 ) ; {1042945}
    RTS                   ; {1042956}
}

code_0FEA0D {
    COP [80] ( #4F )      ; {1042957}
    COP [82]              ; {1042960}
    COP [86]              ; {1042962}
    RTL                   ; {1042964}
}

code_0FEA15 {
    COP [80] ( #50 )      ; {1042965}
    COP [82]              ; {1042968}
    COP [86]              ; {1042970}
    RTL                   ; {1042972}
}

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
    COP [B2] ( &code_0FEB7B, #1F, #$FFF8, #$FFE8, #$0200 ) ; {1043134}
    COP [80] ( #0F )      ; {1043145}
    COP [82]              ; {1043148}
    BRL code_0FEA1D       ; {1043150}
}

code_0FEAD1 {
    COP [80] ( #10 )      ; {1043153}
    COP [82]              ; {1043156}
    COP [B2] ( &code_0FEB88, #1F, #$FFF8, #$0008, #$0200 ) ; {1043158}
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
    COP [B2] ( &code_0FEB5D, #1F, #$FFF8, #$0008, #$0200 ) ; {1043192}
    COP [80] ( #0D )      ; {1043203}
    COP [82]              ; {1043206}
    BRL loc_0FEA66        ; {1043208}
}

code_0FEB0B {
    COP [80] ( #0A )      ; {1043211}
    COP [82]              ; {1043214}
    COP [B2] ( &code_0FEB6C, #1F, #$0018, #$0008, #$0200 ) ; {1043216}
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
    COP [B2] ( &code_0FEB5D, #1F, #$FFF8, #$0008, #$0200 ) ; {1043250}
    COP [80] ( #07 )      ; {1043261}
    COP [82]              ; {1043264}
    BRL loc_0FEA66        ; {1043266}
}

code_0FEB45 {
    COP [80] ( #08 )      ; {1043269}
    COP [82]              ; {1043272}
    COP [B2] ( &code_0FEB6C, #1F, #$0018, #$0008, #$0200 ) ; {1043274}
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

code_0FEB95 {
    COP [AD] ( #10 )      ; {1043349}

  loc_0FEB98:
    COP [9A] ( #$0018, &code_0FEBA2, &code_0FEBB6, &code_0FEBAC ) ; {1043352}
}

code_0FEBA2 {
    COP [9B] ( #$0018, &code_0FEBC4, &code_0FECA3, &code_0FEBFD ) ; {1043362}
}

code_0FEBAC {
    COP [9B] ( #$0018, &code_0FEBC0, &code_0FEC9F, &code_0FEBF9 ) ; {1043372}
}

code_0FEBB6 {
    COP [9B] ( #$0000, &code_0FEC69, &code_0FEC33, &code_0FEC33 ) ; {1043382}
}

code_0FEBC0 {
    COP [96]              ; {1043392}
    BRA loc_0FEBC6        ; {1043394}
}

code_0FEBC4 {
    COP [97]              ; {1043396}

  loc_0FEBC6:
    COP [80] ( #26 )      ; {1043398}
    COP [82]              ; {1043401}
    LDA $0016, X          ; {1043403}
    ORA #$0200            ; {1043406}
    STA $0016, X          ; {1043409}
    COP [80] ( #27 )      ; {1043412}
    COP [82]              ; {1043415}
    COP [81] ( #28, #04 ) ; {1043417}
    COP [83]              ; {1043421}
    COP [80] ( #27 )      ; {1043423}
    COP [82]              ; {1043426}
    LDA $0016, X          ; {1043428}
    AND #$FDFF            ; {1043431}
    STA $0016, X          ; {1043434}
    COP [80] ( #26 )      ; {1043437}
    COP [82]              ; {1043440}
    COP [80] ( #19 )      ; {1043442}
    COP [82]              ; {1043445}
    BRA loc_0FEB98        ; {1043447}
}

code_0FEBF9 {
    COP [96]              ; {1043449}
    BRA loc_0FEBFF        ; {1043451}
}

code_0FEBFD {
    COP [97]              ; {1043453}

  loc_0FEBFF:
    COP [80] ( #23 )      ; {1043455}
    COP [82]              ; {1043458}
    LDA $0016, X          ; {1043460}
    ORA #$0200            ; {1043463}
    STA $0016, X          ; {1043466}
    COP [80] ( #24 )      ; {1043469}
    COP [82]              ; {1043472}
    COP [81] ( #25, #04 ) ; {1043474}
    COP [83]              ; {1043478}
    COP [80] ( #24 )      ; {1043480}
    COP [82]              ; {1043483}
    LDA $0016, X          ; {1043485}
    AND #$FDFF            ; {1043488}
    STA $0016, X          ; {1043491}
    COP [80] ( #23 )      ; {1043494}
    COP [82]              ; {1043497}
    COP [80] ( #18 )      ; {1043499}
    COP [82]              ; {1043502}
    BRL loc_0FEB98        ; {1043504}
}

code_0FEC33 {
    COP [97]              ; {1043507}
    COP [80] ( #1A )      ; {1043509}
    COP [82]              ; {1043512}
    LDA $0016, X          ; {1043514}
    ORA #$0200            ; {1043517}
    STA $0016, X          ; {1043520}
    COP [80] ( #1B )      ; {1043523}
    COP [82]              ; {1043526}
    COP [81] ( #1C, #04 ) ; {1043528}
    COP [83]              ; {1043532}
    COP [80] ( #1B )      ; {1043534}
    COP [82]              ; {1043537}
    LDA $0016, X          ; {1043539}
    AND #$FDFF            ; {1043542}
    STA $0016, X          ; {1043545}
    COP [80] ( #1A )      ; {1043548}
    COP [82]              ; {1043551}
    COP [80] ( #15 )      ; {1043553}
    COP [82]              ; {1043556}
    BRL loc_0FEB98        ; {1043558}
}

code_0FEC69 {
    COP [97]              ; {1043561}
    COP [80] ( #1D )      ; {1043563}
    COP [82]              ; {1043566}
    LDA $0016, X          ; {1043568}
    ORA #$0200            ; {1043571}
    STA $0016, X          ; {1043574}
    COP [80] ( #1E )      ; {1043577}
    COP [82]              ; {1043580}
    COP [81] ( #1F, #04 ) ; {1043582}
    COP [83]              ; {1043586}
    COP [80] ( #1E )      ; {1043588}
    COP [82]              ; {1043591}
    LDA $0016, X          ; {1043593}
    AND #$FDFF            ; {1043596}
    STA $0016, X          ; {1043599}
    COP [80] ( #1D )      ; {1043602}
    COP [82]              ; {1043605}
    COP [80] ( #16 )      ; {1043607}
    COP [82]              ; {1043610}
    BRL loc_0FEB98        ; {1043612}
}

code_0FEC9F {
    COP [96]              ; {1043615}
    BRA loc_0FECA5        ; {1043617}
}

code_0FECA3 {
    COP [97]              ; {1043619}

  loc_0FECA5:
    COP [80] ( #20 )      ; {1043621}
    COP [82]              ; {1043624}
    LDA $0016, X          ; {1043626}
    ORA #$0200            ; {1043629}
    STA $0016, X          ; {1043632}
    COP [80] ( #21 )      ; {1043635}
    COP [82]              ; {1043638}
    COP [81] ( #22, #04 ) ; {1043640}
    COP [83]              ; {1043644}
    COP [80] ( #21 )      ; {1043646}
    COP [82]              ; {1043649}
    LDA $0016, X          ; {1043651}
    AND #$FDFF            ; {1043654}
    STA $0016, X          ; {1043657}
    COP [80] ( #20 )      ; {1043660}
    COP [82]              ; {1043663}
    COP [80] ( #17 )      ; {1043665}
    COP [82]              ; {1043668}
    BRL loc_0FEB98        ; {1043670}
}

code_0FECD9 {
    LDA $001A, X          ; {1043673}
    ORA #$0200            ; {1043676}
    STA $001A, X          ; {1043679}
    COP [A5] ( &code_0FECEC, &code_0FECF9, &code_0FED06, &code_0FED06 ) ; {1043682}
}

code_0FECEC {
    COP [99]              ; {1043692}

  loc_0FECEE:
    COP [22] ( &code_0FECF9 ) ; {1043694}
    COP [80] ( #2A )      ; {1043698}
    COP [82]              ; {1043701}
    BRA loc_0FECEE        ; {1043703}
}

code_0FECF9 {
    COP [98]              ; {1043705}

  loc_0FECFB:
    COP [21] ( &code_0FECEC ) ; {1043707}
    COP [80] ( #2A )      ; {1043711}
    COP [82]              ; {1043714}
    BRA loc_0FECFB        ; {1043716}
}

code_0FED06 {
    COP [86]              ; {1043718}
    RTL                   ; {1043720}
}

code_0FED09 {
    PHX                   ; {1043721}
    LDA $0000, X          ; {1043722}
    STA $16               ; {1043725}
    LDA $0002, X          ; {1043727}
    SEC                   ; {1043730}
    SBC #$0010            ; {1043731}
    STA $18               ; {1043734}
    JSL $@chunk_0270E4.code_0272B8 ; {1043736}
    TXA                   ; {1043740}
    PLX                   ; {1043741}
    STA $0030, X          ; {1043742}
    COP [A1] ( #$0008, #$FFF1 ) ; {1043745}

  code_0FED27:
    COP [AD] ( #10 )      ; {1043751}
    PHX                   ; {1043754}
    LDA $0030, X          ; {1043755}
    TAX                   ; {1043758}
    LDA $7F8000, X        ; {1043759}
    PLX                   ; {1043763}
    AND #$00FF            ; {1043764}
    BEQ loc_0FED6E        ; {1043767}
    LDA $0016, X          ; {1043769}
    AND #$DFFF            ; {1043772}
    STA $0016, X          ; {1043775}
    COP [80] ( #2C )      ; {1043778}
    COP [82]              ; {1043781}
    COP [A0] ( #$0008 )   ; {1043783}
    COP [B2] ( &code_0FED71, #1F, #$0000, #$0000, #$0200 ) ; {1043787}
    COP [80] ( #2D )      ; {1043798}
    COP [82]              ; {1043801}
    COP [A0] ( #$FFF8 )   ; {1043803}
    LDA $0016, X          ; {1043807}
    ORA #$2000            ; {1043810}
    STA $0016, X          ; {1043813}
    COP [1B] ( &code_0FED27, #$0078 ) ; {1043816}

  loc_0FED6E:
    COP [86]              ; {1043822}
    RTL                   ; {1043824}
}

code_0FED71 {
    COP [A3]              ; {1043825}
    BRK #$64              ; {1043827}
    COP [80] ( #2B )      ; {1043829}
    COP [82]              ; {1043832}
    COP [81] ( #2E, #04 ) ; {1043834}
    COP [83]              ; {1043838}
    LDY #$002E            ; {1043840}
    SEP #$20              ; {1043843}
    LDA #$^chunk_000000.code_002D67 ; {1043845}
    PHA                   ; {1043847}
    REP #$20              ; {1043848}
    LDA #$&chunk_000000.code_002D67-1 ; {1043850}
    PHA                   ; {1043853}
    RTL                   ; {1043854}
}

code_0FED8F {
    COP [A5] ( &code_0FED99, &code_0FEDC8, &code_0FEDF7, &code_0FEE26 ) ; {1043855}
}

code_0FED99 {
    COP [AD] ( #10 )      ; {1043865}
    COP [1B] ( &code_0FEDA2, #$0078 ) ; {1043868}
}

code_0FEDA2 {
    STZ $0030, X          ; {1043874}
    BRK #$5D              ; {1043877}
    COP [03] ( #07 )      ; {1043879}
    COP [B0] ( @code_0FEE55, #$0200 ) ; {1043882}
    LDA $0030, X          ; {1043889}
    CLC                   ; {1043892}
    ADC $0000, Y          ; {1043893}
    STA $0000, Y          ; {1043896}
    JSR $&code_0FEE5D     ; {1043899}
    COP [1B] ( &code_0FEDC4, #$0001 ) ; {1043902}
}

code_0FEDC4 {
    COP [04]              ; {1043908}
    BRA code_0FED99       ; {1043910}
}

code_0FEDC8 {
    COP [AD] ( #10 )      ; {1043912}
    COP [1B] ( &code_0FEDD1, #$0078 ) ; {1043915}
}

code_0FEDD1 {
    STZ $0030, X          ; {1043921}
    BRK #$5D              ; {1043924}
    COP [03] ( #07 )      ; {1043926}
    COP [B0] ( @code_0FEE55, #$0200 ) ; {1043929}
    LDA $0000, Y          ; {1043936}
    SEC                   ; {1043939}
    SBC $0030, X          ; {1043940}
    STA $0000, Y          ; {1043943}
    JSR $&code_0FEE5D     ; {1043946}
    COP [1B] ( &code_0FEDF3, #$0001 ) ; {1043949}
}

code_0FEDF3 {
    COP [04]              ; {1043955}
    BRA code_0FEDC8       ; {1043957}
}

code_0FEDF7 {
    COP [AD] ( #10 )      ; {1043959}
    COP [1B] ( &code_0FEE00, #$0078 ) ; {1043962}
}

code_0FEE00 {
    STZ $0030, X          ; {1043968}
    BRK #$5D              ; {1043971}
    COP [03] ( #07 )      ; {1043973}
    COP [B0] ( @code_0FEE55, #$0200 ) ; {1043976}
    LDA $0030, X          ; {1043983}
    CLC                   ; {1043986}
    ADC $0000, Y          ; {1043987}
    STA $0000, Y          ; {1043990}
    JSR $&code_0FEE83     ; {1043993}
    COP [1B] ( &code_0FEE22, #$0001 ) ; {1043996}
}

code_0FEE22 {
    COP [04]              ; {1044002}
    BRA code_0FEDF7       ; {1044004}
}

code_0FEE26 {
    COP [AD] ( #10 )      ; {1044006}
    COP [1B] ( &code_0FEE2F, #$0078 ) ; {1044009}
}

code_0FEE2F {
    STZ $0030, X          ; {1044015}
    BRK #$5D              ; {1044018}
    COP [03] ( #07 )      ; {1044020}
    COP [B0] ( @code_0FEE55, #$0200 ) ; {1044023}
    LDA $0000, Y          ; {1044030}
    SEC                   ; {1044033}
    SBC $0030, X          ; {1044034}
    STA $0000, Y          ; {1044037}
    JSR $&code_0FEE83     ; {1044040}
    COP [1B] ( &code_0FEE51, #$0001 ) ; {1044043}
}

code_0FEE51 {
    COP [04]              ; {1044049}
    BRA code_0FEE26       ; {1044051}
}

code_0FEE55 {
    COP [80] ( #29 )      ; {1044053}
    COP [82]              ; {1044056}
    COP [86]              ; {1044058}
    RTL                   ; {1044060}
}

code_0FEE5D {
    PHY                   ; {1044061}
    LDY $0030, X          ; {1044062}
    LDA $&data_00F9F7.binary_00FC84+10, Y ; {1044065}
    PLY                   ; {1044068}
    AND #$00FF            ; {1044069}
    LSR                   ; {1044072}
    EOR #$FFFF            ; {1044073}
    INC                   ; {1044076}
    CLC                   ; {1044077}
    ADC $0002, Y          ; {1044078}
    CLC                   ; {1044081}
    ADC #$0008            ; {1044082}
    STA $0002, Y          ; {1044085}
    LDA $0030, X          ; {1044088}
    CLC                   ; {1044091}
    ADC #$0010            ; {1044092}
    STA $0030, X          ; {1044095}
    RTS                   ; {1044098}
}

code_0FEE83 {
    PHY                   ; {1044099}
    LDY $0030, X          ; {1044100}
    LDA $&data_00F9F7.binary_00FC84+10, Y ; {1044103}
    PLY                   ; {1044106}
    AND #$00FF            ; {1044107}
    LSR                   ; {1044110}
    CLC                   ; {1044111}
    ADC $0002, Y          ; {1044112}
    SEC                   ; {1044115}
    SBC #$0008            ; {1044116}
    STA $0002, Y          ; {1044119}
    LDA $0030, X          ; {1044122}
    CLC                   ; {1044125}
    ADC #$0010            ; {1044126}
    STA $0030, X          ; {1044129}
    RTS                   ; {1044132}
}

code_0FEEA5 {
    RTL                   ; {1044133}
}

code_0FEEA6 {
    COP [A5] ( &code_0FEEB0, &code_0FEEDF, &code_0FEF0E, &code_0FEF3D ) ; {1044134}
}

code_0FEEB0 {
    COP [AD] ( #10 )      ; {1044144}
    COP [1B] ( &code_0FEEB9, #$0078 ) ; {1044147}
}

code_0FEEB9 {
    STZ $0030, X          ; {1044153}
    BRK #$5D              ; {1044156}
    COP [03] ( #07 )      ; {1044158}
    COP [B0] ( @code_0FEF6C, #$0200 ) ; {1044161}
    LDA $0030, X          ; {1044168}
    CLC                   ; {1044171}
    ADC $0002, Y          ; {1044172}
    STA $0002, Y          ; {1044175}
    JSR $&code_0FEF74     ; {1044178}
    COP [1B] ( &code_0FEEDB, #$0001 ) ; {1044181}
}

code_0FEEDB {
    COP [04]              ; {1044187}
    BRA code_0FEEB0       ; {1044189}
}

code_0FEEDF {
    COP [AD] ( #10 )      ; {1044191}
    COP [1B] ( &code_0FEEE8, #$0078 ) ; {1044194}
}

code_0FEEE8 {
    STZ $0030, X          ; {1044200}
    BRK #$5D              ; {1044203}
    COP [03] ( #07 )      ; {1044205}
    COP [B0] ( @code_0FEF6C, #$0200 ) ; {1044208}
    LDA $0002, Y          ; {1044215}
    SEC                   ; {1044218}
    SBC $0030, X          ; {1044219}
    STA $0002, Y          ; {1044222}
    JSR $&code_0FEF74     ; {1044225}
    COP [1B] ( &code_0FEF0A, #$0001 ) ; {1044228}
}

code_0FEF0A {
    COP [04]              ; {1044234}
    BRA code_0FEEDF       ; {1044236}
}

code_0FEF0E {
    COP [AD] ( #10 )      ; {1044238}
    COP [1B] ( &code_0FEF17, #$0078 ) ; {1044241}
}

code_0FEF17 {
    STZ $0030, X          ; {1044247}
    BRK #$5D              ; {1044250}
    COP [03] ( #07 )      ; {1044252}
    COP [B0] ( @code_0FEF6C, #$0200 ) ; {1044255}
    LDA $0030, X          ; {1044262}
    CLC                   ; {1044265}
    ADC $0002, Y          ; {1044266}
    STA $0002, Y          ; {1044269}
    JSR $&code_0FEF96     ; {1044272}
    COP [1B] ( &code_0FEF39, #$0001 ) ; {1044275}
}

code_0FEF39 {
    COP [04]              ; {1044281}
    BRA code_0FEF0E       ; {1044283}
}

code_0FEF3D {
    COP [AD] ( #10 )      ; {1044285}
    COP [1B] ( &code_0FEF46, #$0078 ) ; {1044288}
}

code_0FEF46 {
    STZ $0030, X          ; {1044294}
    BRK #$5D              ; {1044297}
    COP [03] ( #07 )      ; {1044299}
    COP [B0] ( @code_0FEF6C, #$0200 ) ; {1044302}
    LDA $0002, Y          ; {1044309}
    SEC                   ; {1044312}
    SBC $0030, X          ; {1044313}
    STA $0002, Y          ; {1044316}
    JSR $&code_0FEF96     ; {1044319}
    COP [1B] ( &code_0FEF68, #$0001 ) ; {1044322}
}

code_0FEF68 {
    COP [04]              ; {1044328}
    BRA code_0FEF3D       ; {1044330}
}

code_0FEF6C {
    COP [80] ( #29 )      ; {1044332}
    COP [82]              ; {1044335}
    COP [86]              ; {1044337}
    RTL                   ; {1044339}
}

code_0FEF74 {
    PHY                   ; {1044340}
    LDY $0030, X          ; {1044341}
    LDA $&data_00F9F7.binary_00FC84+10, Y ; {1044344}
    PLY                   ; {1044347}
    AND #$00FF            ; {1044348}
    LSR                   ; {1044351}
    CLC                   ; {1044352}
    ADC $0000, Y          ; {1044353}
    SEC                   ; {1044356}
    SBC #$000C            ; {1044357}
    STA $0000, Y          ; {1044360}
    LDA $0030, X          ; {1044363}
    CLC                   ; {1044366}
    ADC #$0010            ; {1044367}
    STA $0030, X          ; {1044370}
    RTS                   ; {1044373}
}

code_0FEF96 {
    PHY                   ; {1044374}
    LDY $0030, X          ; {1044375}
    LDA $&data_00F9F7.binary_00FC84+10, Y ; {1044378}
    PLY                   ; {1044381}
    AND #$00FF            ; {1044382}
    LSR                   ; {1044385}
    EOR #$FFFF            ; {1044386}
    INC                   ; {1044389}
    CLC                   ; {1044390}
    ADC $0000, Y          ; {1044391}
    CLC                   ; {1044394}
    ADC #$000C            ; {1044395}
    STA $0000, Y          ; {1044398}
    LDA $0030, X          ; {1044401}
    CLC                   ; {1044404}
    ADC #$0010            ; {1044405}
    STA $0030, X          ; {1044408}
    RTS                   ; {1044411}
}

code_0FEFBC {
    LDX #$&spc_0FF14E     ; {1044412}
    STX $29               ; {1044415}
    LDA #$^spc_0FF14E     ; {1044417}
    STA $2B               ; {1044419}
    JSR $&code_0FF0E6     ; {1044421}
    JSL $@chunk_010000.code_0131B7 ; {1044424}
    JSL $@chunk_010000.code_0131B7 ; {1044428}
    LDA #$FF              ; {1044432}
    STA $APUIO0           ; {1044434}
    LDX #$&spc_030000     ; {1044437}
    STX $29               ; {1044440}
    LDA #$^spc_030000     ; {1044442}
    STA $2B               ; {1044444}
    LDX #$3000            ; {1044446}
    STX $0320             ; {1044449}
    JSL $@code_0FEFF5     ; {1044452}
    REP #$20              ; {1044456}
    LDA $02               ; {1044458}
    CLC                   ; {1044460}
    ADC $08               ; {1044461}
    STA $0320             ; {1044463}
    SEP #$20              ; {1044466}
    RTL                   ; {1044468}
}

code_0FEFF5 {
    PHP                   ; {1044469}
    PHY                   ; {1044470}
    JSR $&code_0FF0E6     ; {1044471}
    DEY                   ; {1044474}
    DEY                   ; {1044475}
    SEP #$20              ; {1044476}
    JSL $@chunk_010000.code_0131B7 ; {1044478}
    JSL $@chunk_010000.code_0131B7 ; {1044482}
    LDA #$FF              ; {1044486}
    STA $2140             ; {1044488}
    LDA #$CC              ; {1044491}
    STA $04               ; {1044493}
    REP #$20              ; {1044495}
    LDA #$BBAA            ; {1044497}

  loc_0FF014:
    CMP $2140             ; {1044500}
    BNE loc_0FF014        ; {1044503}
    LDA [$29], Y          ; {1044505}
    INY                   ; {1044507}
    STY $06               ; {1044508}
    AND #$00FF            ; {1044510}
    STA $0C               ; {1044513}
    LDX $0320             ; {1044515}
    STX $02               ; {1044518}
    STZ $00               ; {1044520}

  loc_0FF02A:
    REP #$20              ; {1044522}
    LDX #$8000            ; {1044524}
    STX $2C               ; {1044527}
    SEP #$20              ; {1044529}
    LDA #$07              ; {1044531}
    STA $2E               ; {1044533}
    REP #$20              ; {1044535}
    LDY $06               ; {1044537}
    LDA [$29], Y          ; {1044539}
    INY                   ; {1044541}
    STY $06               ; {1044542}
    AND #$00FF            ; {1044544}
    STA $0E               ; {1044547}
    LDA $02               ; {1044549}
    CLC                   ; {1044551}
    ADC $00               ; {1044552}
    STA $02               ; {1044554}

  loc_0FF04C:
    LDA [$2C]             ; {1044556}
    STA $00               ; {1044558}
    STA $08               ; {1044560}
    INC $2C               ; {1044562}
    INC $2C               ; {1044564}
    LDA $0E               ; {1044566}
    BEQ loc_0FF06E        ; {1044568}
    DEC $0E               ; {1044570}
    LDA $2C               ; {1044572}
    CLC                   ; {1044574}
    ADC $00               ; {1044575}
    STA $2C               ; {1044577}
    BCC loc_0FF04C        ; {1044579}
    ORA #$8000            ; {1044581}
    STA $2C               ; {1044584}
    INC $2E               ; {1044586}
    BRA loc_0FF04C        ; {1044588}

  loc_0FF06E:
    LDY $2C               ; {1044590}
    STZ $2C               ; {1044592}
    SEP #$20              ; {1044594}
    LDA $04               ; {1044596}
    BRA loc_0FF0B9        ; {1044598}

  loc_0FF078:
    LDA [$2C], Y          ; {1044600}
    INY                   ; {1044602}
    BNE loc_0FF082        ; {1044603}
    LDY #$8000            ; {1044605}
    INC $2E               ; {1044608}

  loc_0FF082:
    XBA                   ; {1044610}
    LDA #$00              ; {1044611}
    BRA loc_0FF099        ; {1044613}

  loc_0FF087:
    XBA                   ; {1044615}
    LDA [$2C], Y          ; {1044616}
    INY                   ; {1044618}
    BNE loc_0FF092        ; {1044619}
    LDY #$8000            ; {1044621}
    INC $2E               ; {1044624}

  loc_0FF092:
    XBA                   ; {1044626}

  loc_0FF093:
    CMP $2140             ; {1044627}
    BNE loc_0FF093        ; {1044630}
    INC                   ; {1044632}

  loc_0FF099:
    REP #$20              ; {1044633}
    STA $2140             ; {1044635}
    SEP #$20              ; {1044638}
    DEX                   ; {1044640}
    BNE loc_0FF087        ; {1044641}

  loc_0FF0A3:
    CMP $2140             ; {1044643}
    BNE loc_0FF0A3        ; {1044646}

  loc_0FF0A8:
    ADC #$03              ; {1044648}
    BEQ loc_0FF0A8        ; {1044650}
    STA $04               ; {1044652}
    DEC $0C               ; {1044654}
    BEQ loc_0FF0B5        ; {1044656}
    BRL loc_0FF02A        ; {1044658}

  loc_0FF0B5:
    STZ $00               ; {1044661}
    STZ $01               ; {1044663}

  loc_0FF0B9:
    PHA                   ; {1044665}
    REP #$20              ; {1044666}
    LDA $00               ; {1044668}
    TAX                   ; {1044670}
    LDA $02               ; {1044671}
    STA $2142             ; {1044673}
    SEP #$20              ; {1044676}
    CPX #$0001            ; {1044678}
    LDA #$00              ; {1044681}
    ROL                   ; {1044683}
    STA $2141             ; {1044684}
    ADC #$7F              ; {1044687}
    PLA                   ; {1044689}
    STA $2140             ; {1044690}

  loc_0FF0D5:
    CMP $2140             ; {1044693}
    BNE loc_0FF0D5        ; {1044696}
    BVS loc_0FF078        ; {1044698}
    LDA #$7E              ; {1044700}
    STA $2E               ; {1044702}
    STZ $2142             ; {1044704}
    PLY                   ; {1044707}
    PLP                   ; {1044708}
    RTL                   ; {1044709}
}

code_0FF0E6 {
    PHP                   ; {1044710}
    PHX                   ; {1044711}
    REP #$30              ; {1044712}
    LDY #$0000            ; {1044714}
    LDA #$BBAA            ; {1044717}

  loc_0FF0F0:
    CMP $APUIO0           ; {1044720}
    BNE loc_0FF0F0        ; {1044723}
    SEP #$20              ; {1044725}
    LDA #$CC              ; {1044727}
    BRA loc_0FF121        ; {1044729}

  loc_0FF0FB:
    LDA [$29], Y          ; {1044731}
    INY                   ; {1044733}
    XBA                   ; {1044734}
    LDA #$00              ; {1044735}
    BRA loc_0FF10E        ; {1044737}

  loc_0FF103:
    XBA                   ; {1044739}
    LDA [$29], Y          ; {1044740}
    INY                   ; {1044742}
    XBA                   ; {1044743}

  loc_0FF108:
    CMP $APUIO0           ; {1044744}
    BNE loc_0FF108        ; {1044747}
    INC                   ; {1044749}

  loc_0FF10E:
    REP #$20              ; {1044750}
    STA $APUIO0           ; {1044752}
    SEP #$20              ; {1044755}
    DEX                   ; {1044757}
    BNE loc_0FF103        ; {1044758}

  loc_0FF118:
    CMP $APUIO0           ; {1044760}
    BNE loc_0FF118        ; {1044763}

  loc_0FF11D:
    ADC #$03              ; {1044765}
    BEQ loc_0FF11D        ; {1044767}

  loc_0FF121:
    PHA                   ; {1044769}
    REP #$20              ; {1044770}
    LDA [$29], Y          ; {1044772}
    INY                   ; {1044774}
    INY                   ; {1044775}
    TAX                   ; {1044776}
    LDA [$29], Y          ; {1044777}
    INY                   ; {1044779}
    INY                   ; {1044780}
    STA $APUIO2           ; {1044781}
    SEP #$20              ; {1044784}
    CPX #$0001            ; {1044786}
    LDA #$00              ; {1044789}
    ROL                   ; {1044791}
    STA $APUIO1           ; {1044792}
    ADC #$7F              ; {1044795}
    PLA                   ; {1044797}
    STA $APUIO0           ; {1044798}

  loc_0FF141:
    CMP $APUIO0           ; {1044801}
    BNE loc_0FF141        ; {1044804}
    BVS loc_0FF0FB        ; {1044806}
    STZ $APUIO2           ; {1044808}
    PLX                   ; {1044811}
    PLP                   ; {1044812}
    RTS                   ; {1044813}
}
---------------------------------------------

spc_0FF14E [
  #470B000420CDCFBDE8005DAFC8F0D0FB   ;00
  #C5FF0FBC3FA909A248E8608D0C3FB805   ;01
  #8D1C3FB805E82C8D5D3FB805E830C4F1   ;02
  #E810C4FAC453E801C4F1E43648FF244A   ;03
  #C4388D0AAD05F007B008694D4CD00FE3   ;04
  #4C0CF65D0DC4F2F6670D5DE6C4F3FEE4   ;05
  #CB45CB46EBFDF0FC6DE840CF608443C4   ;06
  #43900A3FA00D694D4CF002AB4CE453EE   ;07
  #CF608451C45190193F8306E430F00A8B   ;08
  #31D0068F00043FE805CD003FB6045F36   ;09
  #04E404F012CD008F0147F4D5F0033F34   ;0A
  #0C3D3D0B47D0F35F3604F404D4F4F4F4   ;0B
  #74F4D0FAD4006FADCA90053FDF078DA4   ;0C
  #ADC8B0F2E41A2447D0ECDD287F608450   ;0D
  #6095F002D57D03F5A503D57C03F5A102   ;0E
  #5CE8007CD58C02E800D4ACD50001D5C8   ;0F
  #02D4C009475E094745F56402D498F01E   ;10
  #F56502D499F57802D00AF57D0380B579   ;11
  #02D57D03F5790260957D033F150A3F2D   ;12
  #0A8D00E41180A834B009E41180A813B0   ;13
  #06DC1C7A10DA104DE4111C8D00CD189E   ;14
  #5DF6730DC415F6720DC414F6750D2DF6   ;15
  #740DEE9A14EB10CFDD8D007A14CB151C   ;16
  #2B15C4142F044B157C3DC806D0F8C414   ;17
  #CEF52802EB15CFDA16F52802EB14CF6D   ;18
  #F52902EB14CF7A16DA16F52902EB15CF   ;19
  #FDAE7A16DA16F58C0D0802FDE4163FB0   ;1A
  #05FCE4172DE447241AAED004CBF2C4F3   ;1B
  #6F8D00F7403A402DF7403A40FDAE6F8F   ;1C
  #FF308F7F31C4046F2DE5FD0FECFE0FDA   ;1D
  #3BE8005DC73B3A3BD0FAAE6F8FFF468F   ;1E
  #0004A248C248E800C4E5C4E7E8013FA9   ;1F
  #096FC2486F3F060FC408C4046F68F0F0   ;20
  #DB68F1F0BA68F2F0E968FFF0E86FC404   ;21
  #1CF0263FD4055DF5FF0FFDF5FE0FDA40   ;22
  #8F020CE800C430C45FC439C435C436C4   ;23
  #E5C4E7D248E8FFC4F7E41A48FF0E4600   ;24
  #6FCD0E8F8047E8FFD50503E80A3F4908   ;25
  #D51502D5A503D5F002D56402D4ADD4C1   ;26
  #1D1D4B47D0E0C45AC468C454C450C442   ;27
  #8FC0598F20536FEB08E40068F090035F   ;28
  #0906C4087E00D086E404F0EAD248E40C   ;29
  #F0526E0CAC3FBD05D019FDD005C4F75F   ;2A
  #1A068B421002C4423FBD05F842F0E6DA   ;2B
  #402FE2DA168D0FF716D6D400DC10F8CD   ;2C
  #008F0147F4D5F00AF51502D005E8003F   ;2D
  #DF07E800D5B803D484D485BCD4703D3D   ;2E
  #0B47D0E0CD00D85E8F0147D844F4D5F0   ;2F
  #6C9B70D0623FD507D01DF5B803F0963F   ;30
  #4109F5B8039CD5B803D0EAF53C02D4D4   ;31
  #F53D02D4D52FDE3020D500023FD50730   ;32
  #182D9F2807FDF6002FD50102AE280FFD   ;33
  #F6082FD514023FD50768E090053FC307   ;34
  #2FB33FC304F50002D470FDF50102CFDD   ;35
  #D001BCD4712F033F5C0B3FF5093D3D0B   ;36
  #47D088E430F0038FFF5EE454F00BBA56   ;37
  #7A526E5402BA54DA52E468F015BA647A   ;38
  #60DA60BA667A626E6806BA68DA60EB6A   ;39
  #DA62E45AF00EBA5C7A586E5A02BA5ADA   ;3A
  #588FFF5ECD008F0147F4D5F0033FA50A   ;3B
  #3D3D0B47D0F36F1CFDF695092DF69409   ;3C
  #2DDD5CFDF62A0AF008E7D4BBD4D002BB   ;3D
  #D5FD6FD51502EB34D00FFD100680A8CA   ;3E
  #60845F6085FF0F2F09FD100680A8CA60   ;3F
  #84398D06CFDA1460980014982E15E41A   ;40
  #2447D0384DF58C0D08045D8D00F71410   ;41
  #0E281F3820480E4800094749DD2F07E4   ;42
  #474E4900F714D8F2C4F33DFCAD04D0F4   ;43
  #CEF714D52902FCF714D528026FD56903   ;44
  #281FD54103E800D540036FD4852D3FD5   ;45
  #07D5680380B54103CE3F380AD55403DD   ;46
  #D555036FD5A0023FD507D58D023FD507   ;47
  #D4ADD5B502E800D5A1026FD5A1022D8D   ;48
  #00F4ADCE9EF844D5B4026FDD80A800FD   ;49
  #E800DA586FC45A3FD507C45B80A459F8   ;4A
  #5A3F380ADA5C6FE434D004E800DA526F   ;4B
  #C4543FD507C45580A453F8543F380ADA   ;4C
  #566FC4506FD5F0026FD5DC023FD507D5   ;4D
  #C9023FD507D4C16FE8012F02E800D578   ;4E
  #02DDD565023FD507D564023FD507D579   ;4F
  #026FD564026FD50503E800D504036FD4   ;50
  #842D3FD507D52C0380B50503CE3F380A   ;51
  #D51803DDD519036FD5A5036FD550023F   ;52
  #D507D551023FD507D5B803F4D4D53C02   ;53
  #F4D5D53D02F55002D4D4F55102D4D56F   ;54
  #C44A3FD507E800DA603FD507E800DA62   ;55
  #B2486FC4683FD507C46980A461F8683F   ;56
  #380ADA643FD507C46A80A463F8683F38   ;57
  #0ADA666FDA60DA62A2486F3FA9093FD5   ;58
  #07C44E3FD5078D08CF5D8D0FF53E0D3F   ;59
  #B8053DDD608810FD10F2F8446FC44D8D   ;5A
  #7DCBF2E4F3644DF029280F48FFF34C03   ;5B
  #60844CC44C8D04F65D0DC4F2E800C4F3   ;5C
  #FEF5E44808208D6C3FB805E44D8D7D3F   ;5D
  #B8051C1C1C48FF8088FF8D6D5FB805EB   ;5E
  #34D003C45F6FC4396FF498D033E7D468   ;5F
  #F9D02D3FD7073FD507D4993FD507D498   ;60
  #3FD50760845095F002287FD5A40380B5   ;61
  #7D03FB986DCE3F380AD59003DDD59103   ;62
  #6FF57D03C411F57C03C4106FED6B1210   ;63
  #0348FFBC8D009E2DE8009EEEF844F312   ;64
  #06DA14BA0E9A146FDF07490857087008   ;65
  #7C089708A108B308BC08CE08D108D508   ;66
  #E10802090B0928098708E408E808FE08   ;67
  #24094C09800987095F09050AEB090101   ;68
  #02030001020102010103000102030103   ;69
  #030001030003030301F484F009E8048D   ;6A
  #039B843F380BFBC1F023F5DC02DEC01B   ;6B
  #09475EF5C8021007FCD004E8802F0460   ;6C
  #95C902D5C8023FC00C2F07BBC0E8FF3F   ;6D
  #CB0CF485F009E8408D039B853F380BE4   ;6E
  #47245EF046F54103FDF54003DA10F58C   ;6F
  #0DC412EB11F6EA0C80B6E90CEB10CFDD   ;70
  #EB116096E90CFDF52D03CFF569031C13   ;71
  #12011CDD900348FFBCEB123FB0058D14   ;72
  #E8009A10DA10AB123312C86F09475EDA   ;73
  #14DA164DEE60D00A982716E800D714FC   ;74
  #2F099814163F550BFCF7149716D7146F   ;75
  #F471F0649B71F005E802DE705BF5B803   ;76
  #C417F4D4FBD5DA148D00F714F01C3005   ;77
  #FCF71410FB68C8F03F68EFF02968E090   ;78
  #306DFDAE96AA09FD2FE0E417F0238B17   ;79
  #D00AF53D022DF53C02EE2FCAF551022D   ;7A
  #F55002EE2FC0FCF7142DFCF714FDAE2F   ;7B
  #B5E4478D5C3FB005F213F498F013F499   ;7C
  #F0049B992F0BE213E87C8D039B983F3B   ;7D
  #0B3F2D0AF4ADF04CF5A002DEAC44F500   ;7E
  #0175A102D005F5B5022F0D40BB0020FD   ;7F
  #F002F4AD6095B402D4ADF58C0260958D   ;80
  #02D58C02C4121C1C900248FFFDF4AD68   ;81
  #F19005280FCF2F04CFDD8D003FAB0C5F   ;82
  #2D05BBACE313F86FF213F4C1F009F5DC   ;83
  #02DEC0033FB30CF54103FDF54003DA10   ;84
  #F485F00AF55503FDF554033F950CF313   ;85
  #033FFA0AF213F57D03FDF57C03DA10F4   ;86
  #98F00EF499D00AF59103FDF590033F95   ;87
  #0CF4ADF0AFF5A002DEACA9EB51F58D02   ;88
  #CFDD60958C025F100CE213CB123F4A0A   ;89
  #6DEB51CFCB148F0015EB51AECF7A143F   ;8A
  #4A0A7A10DA106FE213EB51F5C902CFDD   ;8B
  #6095C8021C900248FFFBC1CFDD48FFEB   ;8C
  #34D003EB59CFF51402CFF50503CFE430   ;8D
  #F004E4311CCFDDCFDDD52D036F000103   ;8E
  #070D151E293442515E676E73777A7C7D   ;8F
  #7E7F0A0B0C0D0E0F1011111212131313   ;90
  #141414141413131312121111100F0E0D   ;91
  #0C0B0A09080706050403030202010101   ;92
  #00000000000101010202030304050607   ;93
  #08097F0000000000000058BFDBF0FE07   ;94
  #0C0C0C212B2B13FEF3F9343300D9E501   ;95
  #FCEB2C3C0D4D6C4C5C3D2D5C61634E38   ;96
  #48450E494B465F08DE086509F4098C0A   ;97
  #2C0BD60B8B0C4A0D140EEA0ECD0FBE10   ;98
  #00001000200030004000500060007000   ;99
  #60007000FA1A37383F1A8FFF348F005E   ;9A
  #8F4047CD10E4F6F0393004EB35D0332D   ;9B
  #0D0947460947370947363F140E8E1021   ;9C
  #3F790E8FFF358F003F8F8047CD12AE09   ;9D
  #47460947370947363F140EE803D4702F   ;9E
  #1DAE3F790E8F8047CD12E435D010E4F7   ;9F
  #F00C0947460947370947363F140E3F79   ;A0
  #0E8F0034FA371A6F1C4D5DF50124FDF5   ;A1
  #0024CED4D4DBD5E8DCD50503E80A3F49   ;A2
  #08E800D51502D5A503D5F002D56402D4   ;A3
  #ADD4C1D5B803D484D485E802D4706FE4   ;A4
  #4748FFFD2437C437DD2436C43609475E   ;A5
  #FA475C8F00344D7D80A8045DF515023F   ;A6
  #DF07CE8FFF34E800D4D5C4356FF4D5D0   ;A7
  #016FE435F02809475EC812D012E43FAB   ;A8
  #3F5C283FFDF6FE0C08C03F49082F0FE4   ;A9
  #3F48FFBC5C283FFDF6FE0C3F4908D844   ;AA
  #9B70D0453FD507F0963020D500023FD5   ;AB
  #0730182D9F2807FDF6002FD50102AE28   ;AC
  #0FFDF6082FD514023FD50768E090053F   ;AD
  #C3072FD03FC304F50002D470FDF50102   ;AE
  #CFDDD001BCD4712F033F5C0B3FF509E4   ;AF
  #30F00309475E3FA50A6F8DBBE8AADAF4   ;B0
  #E4F468CCD0FA2F1EEBF4D0FC7EF4D010   ;B1
  #CBF4E4F5D60000FCD0F2AC220F5F180F   ;B2
  #10EA7EF410E6BAF6C5210FCC220FEBF4   ;B3
  #E4F5CBF4D0D2CD31D8F16F00000004   ;B4
]