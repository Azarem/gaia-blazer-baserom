?BANK 02

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'
?INCLUDE 'lib_shared_0131D1'

!map_width_pages                0343
!map_height_pages               0345
!tile_type_map                  7F8000

---------------------------------------------

code_01112A {
    PHP                   ; {69930}
    REP #$20              ; {69931}
    LDA $1C71             ; {69933}
    AND #$00FF            ; {69936}
    ASL                   ; {69939}
    ASL                   ; {69940}
    ASL                   ; {69941}
    ASL                   ; {69942}
    STA $16               ; {69943}
    LDA $1C72             ; {69945}
    AND #$00FF            ; {69948}
    ASL                   ; {69951}
    ASL                   ; {69952}
    ASL                   ; {69953}
    ASL                   ; {69954}
    STA $18               ; {69955}
    JSL $@lib_027462_part1.code_0272B8 ; {69957}
    STX $1C66             ; {69961}
    STX $1C68             ; {69964}
    SEP #$20              ; {69967}
    SEP #$20              ; {69969}
    LDA $map_width_pages  ; {69971}
    XBA                   ; {69974}
    LDA $map_height_pages ; {69975}
    JSL $@lib_shared_0131D1.code_0131D1 ; {69978}
    XBA                   ; {69982}
    LDA $1C6E             ; {69983}
    JSL $@lib_shared_0131D1.code_0131D1 ; {69986}
    STA $1C65             ; {69990}
    XBA                   ; {69993}
    STA $1C64             ; {69994}
    LDA $1C74             ; {69997}
    CMP #$80              ; {70000}

  loc_011172:
    BCS loc_011172        ; {70002}
    STA $10               ; {70004}

  loc_011176:
    LDA $1C73             ; {70006}
    CMP #$80              ; {70009}

  loc_01117B:
    BCS loc_01117B        ; {70011}
    STA $0E               ; {70013}

  loc_01117F:
    REP #$20              ; {70015}
    LDA $1C66             ; {70017}
    CLC                   ; {70020}
    ADC $1C64             ; {70021}
    TAX                   ; {70024}
    SEP #$20              ; {70025}
    LDA $7E8000, X        ; {70027}
    PHA                   ; {70031}
    LDA $tile_type_map, X ; {70032}
    PHA                   ; {70036}
    LDX $1C66             ; {70037}
    LDA $tile_type_map, X ; {70040}
    AND #$F0              ; {70044}
    ORA $01, S            ; {70046}
    STA $tile_type_map, X ; {70048}
    PLA                   ; {70052}
    PLA                   ; {70053}
    STA $7E8000, X        ; {70054}
    LDX $1C66             ; {70058}
    JSL $@lib_027462_part2.code_02731A ; {70061}
    STX $1C66             ; {70065}
    DEC $0E               ; {70068}
    BNE loc_01117F        ; {70070}
    LDX $1C68             ; {70072}
    JSL $@lib_027462_part2.code_027331 ; {70075}
    STX $1C68             ; {70079}
    STX $1C66             ; {70082}
    DEC $10               ; {70085}
    BNE loc_011176        ; {70087}
    PLP                   ; {70089}
    RTS                   ; {70090}
}

code_0111CB {
    PHP                   ; {70091}
    REP #$20              ; {70092}
    JSL $@lib_027462_part1.code_0272B8 ; {70094}
    STX $1C62             ; {70098}
    STX $1C64             ; {70101}
    LDA $1C71             ; {70104}
    AND #$00FF            ; {70107}
    ASL                   ; {70110}
    ASL                   ; {70111}
    ASL                   ; {70112}
    ASL                   ; {70113}
    STA $16               ; {70114}
    LDA $1C72             ; {70116}
    AND #$00FF            ; {70119}
    ASL                   ; {70122}
    ASL                   ; {70123}
    ASL                   ; {70124}
    ASL                   ; {70125}
    STA $18               ; {70126}
    JSL $@lib_027462_part1.code_0272B8 ; {70128}
    STX $1C66             ; {70132}
    STX $1C68             ; {70135}
    SEP #$20              ; {70138}
    LDA $1C74             ; {70140}
    CMP #$80              ; {70143}

  loc_011201:
    BCS loc_011201        ; {70145}
    STA $10               ; {70147}

  loc_011205:
    LDA $1C73             ; {70149}
    CMP #$80              ; {70152}

  loc_01120A:
    BCS loc_01120A        ; {70154}
    STA $0E               ; {70156}

  loc_01120E:
    LDX $1C62             ; {70158}
    LDA $7E8000, X        ; {70161}
    PHA                   ; {70165}
    LDA $tile_type_map, X ; {70166}
    LDX $1C66             ; {70170}
    STA $tile_type_map, X ; {70173}
    PLA                   ; {70177}
    STA $7E8000, X        ; {70178}
    LDX $1C62             ; {70182}
    JSL $@lib_027462_part2.code_02731A ; {70185}
    STX $1C62             ; {70189}
    LDX $1C66             ; {70192}
    JSL $@lib_027462_part2.code_02731A ; {70195}
    STX $1C66             ; {70199}
    DEC $0E               ; {70202}
    BNE loc_01120E        ; {70204}
    LDX $1C64             ; {70206}
    JSL $@lib_027462_part2.code_027331 ; {70209}
    STX $1C64             ; {70213}
    STX $1C62             ; {70216}
    LDX $1C68             ; {70219}
    JSL $@lib_027462_part2.code_027331 ; {70222}
    STX $1C68             ; {70226}
    STX $1C66             ; {70229}
    DEC $10               ; {70232}
    BNE loc_011205        ; {70234}
    PLP                   ; {70236}
    RTS                   ; {70237}
}

code_01125E {
    PHP                   ; {70238}
    REP #$20              ; {70239}
    JSL $@lib_027462_part1.code_0272B8 ; {70241}
    STX $1C62             ; {70245}
    STX $1C64             ; {70248}
    LDA $1C71             ; {70251}
    AND #$00FF            ; {70254}
    ASL                   ; {70257}
    ASL                   ; {70258}
    ASL                   ; {70259}
    ASL                   ; {70260}
    STA $16               ; {70261}
    LDA $1C72             ; {70263}
    AND #$00FF            ; {70266}
    ASL                   ; {70269}
    ASL                   ; {70270}
    ASL                   ; {70271}
    ASL                   ; {70272}
    STA $18               ; {70273}
    JSL $@lib_027462_part1.code_0272B8 ; {70275}
    STX $1C66             ; {70279}
    STX $1C68             ; {70282}
    SEP #$20              ; {70285}
    LDA $1C74             ; {70287}
    CMP #$80              ; {70290}

  loc_011294:
    BCS loc_011294        ; {70292}
    STA $10               ; {70294}

  loc_011298:
    LDA $1C73             ; {70296}
    CMP #$80              ; {70299}

  loc_01129D:
    BCS loc_01129D        ; {70301}
    STA $0E               ; {70303}

  loc_0112A1:
    LDX $1C62             ; {70305}
    LDA $7E8000, X        ; {70308}
    PHA                   ; {70312}
    LDA $tile_type_map, X ; {70313}
    LDX $1C66             ; {70317}
    STA $tile_type_map, X ; {70320}
    PLA                   ; {70324}
    STA $7E8000, X        ; {70325}
    STA $7EC000, X        ; {70329}
    LDX $1C62             ; {70333}
    JSL $@lib_027462_part2.code_02731A ; {70336}
    STX $1C62             ; {70340}
    LDX $1C66             ; {70343}
    JSL $@lib_027462_part2.code_02731A ; {70346}
    STX $1C66             ; {70350}
    DEC $0E               ; {70353}
    BNE loc_0112A1        ; {70355}
    LDX $1C64             ; {70357}
    JSL $@lib_027462_part2.code_027331 ; {70360}
    STX $1C64             ; {70364}
    STX $1C62             ; {70367}
    LDX $1C68             ; {70370}
    JSL $@lib_027462_part2.code_027331 ; {70373}
    STX $1C68             ; {70377}
    STX $1C66             ; {70380}
    DEC $10               ; {70383}
    BNE loc_011298        ; {70385}
    PLP                   ; {70387}
    RTS                   ; {70388}
}