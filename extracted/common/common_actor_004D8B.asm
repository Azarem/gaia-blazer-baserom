?BANK 00

?INCLUDE 'engine_003005'

!joy_block_mask                 0326
!map_height_px                  0344
!player_actor                   039C
!random_mod_result              0437

---------------------------------------------

code_004D8B {
    STX $039A             ; {19851}
    LDA $001A, X          ; {19854}
    ORA #$0200            ; {19857}
    STA $001A, X          ; {19860}
    COP [9F] ( #$0008 )   ; {19863}
    COP [91]              ; {19867}
    LDY $player_actor     ; {19869}
    LDA $0002, Y          ; {19872}
    CMP #$0080            ; {19875}
    BCC loc_004DA9        ; {19878}
    RTL                   ; {19880}

  loc_004DA9:
    COP [85] ( @engine_003005.code_003188 ) ; {19881}
    LDA #$0004            ; {19886}
    STA $0030, Y          ; {19889}
    COP [1B] ( &code_004DBA, #$0004 ) ; {19892}
}

code_004DBA {
    LDA #$2FC0            ; {19898}
    TSB $joy_block_mask   ; {19901}
    BRK #$A0              ; {19904}
    COP [80] ( #01 )      ; {19906}
    COP [82]              ; {19909}
    LDA #$0100            ; {19911}
    STA $map_height_px    ; {19914}
    COP [01] ( &asciistring_004EF8 ) ; {19917}
    LDA #$2FC0            ; {19921}
    TRB $joy_block_mask   ; {19924}
    LDA $0016, X          ; {19927}
    AND #$FDFF            ; {19930}
    STA $0016, X          ; {19933}
    COP [32] ( #0D )      ; {19936}
    BRA loc_004E44        ; {19939}

  loc_004DE5:
    COP [1F]              ; {19941}
    COP [35] ( #A0 )      ; {19943}
    LDA $random_mod_result ; {19946}
    CLC                   ; {19949}
    ADC #$0028            ; {19950}
    STA $0000, X          ; {19953}
    LDA #$0060            ; {19956}
    STA $0002, X          ; {19959}
    COP [80] ( #01 )      ; {19962}
    COP [82]              ; {19965}
    LDA $0016, X          ; {19967}
    AND #$FDFF            ; {19970}
    STA $0016, X          ; {19973}
    COP [80] ( #02 )      ; {19976}
    COP [82]              ; {19979}
    BRK #$4B              ; {19981}
    COP [B2] ( @code_004E4B, #$0000, #$FFEE, #$0200 ) ; {19983}
    COP [B2] ( @code_004E8A, #$0000, #$FFEE, #$0200 ) ; {19994}
    COP [B2] ( @code_004EC9, #$0000, #$FFEE, #$0200 ) ; {20005}
    COP [80] ( #03 )      ; {20016}
    COP [82]              ; {20019}
    COP [1B] ( &code_004E3B, #$0050 ) ; {20021}
}

code_004E3B {
    LDA $0016, X          ; {20027}
    ORA #$0200            ; {20030}
    STA $0016, X          ; {20033}

  loc_004E44:
    COP [80] ( #04 )      ; {20036}
    COP [82]              ; {20039}
    BRA loc_004DE5        ; {20041}
}

code_004E4B {
    COP [A3]              ; {20043}
    COP [97]              ; {20045}
    COP [90]              ; {20047}
    COP [88]              ; {20049}

  loc_004E53:
    COP [9A] ( #$0020, &code_004E5D, &code_004E64, &code_004E64 ) ; {20051}
}

code_004E5D {
    COP [80] ( #0A )      ; {20061}
    COP [82]              ; {20064}
    BRA loc_004E53        ; {20066}
}

code_004E64 {
    COP [80] ( #05 )      ; {20068}
    COP [82]              ; {20071}

  loc_004E69:
    COP [9B] ( #$0020, &code_004E73, &code_004E7A, &code_004E73 ) ; {20073}
}

code_004E73 {
    COP [80] ( #09 )      ; {20083}
    COP [82]              ; {20086}
    BRA loc_004E69        ; {20088}
}

code_004E7A {
    COP [96]              ; {20090}
    COP [80] ( #06 )      ; {20092}
    COP [82]              ; {20095}
    COP [81] ( #0A, #10 ) ; {20097}
    COP [83]              ; {20101}
    COP [86]              ; {20103}
    RTL                   ; {20105}
}

code_004E8A {
    COP [A3]              ; {20106}
    COP [96]              ; {20108}
    COP [90]              ; {20110}
    COP [88]              ; {20112}

  loc_004E92:
    COP [9A] ( #$0020, &code_004EA3, &code_004EA3, &code_004E9C ) ; {20114}
}

code_004E9C {
    COP [80] ( #0A )      ; {20124}
    COP [82]              ; {20127}
    BRA loc_004E92        ; {20129}
}

code_004EA3 {
    COP [80] ( #05 )      ; {20131}
    COP [82]              ; {20134}

  loc_004EA8:
    COP [9B] ( #$0020, &code_004EB2, &code_004EB9, &code_004EB2 ) ; {20136}
}

code_004EB2 {
    COP [80] ( #09 )      ; {20146}
    COP [82]              ; {20149}
    BRA loc_004EA8        ; {20151}
}

code_004EB9 {
    COP [97]              ; {20153}
    COP [80] ( #06 )      ; {20155}
    COP [82]              ; {20158}
    COP [81] ( #0A, #10 ) ; {20160}
    COP [83]              ; {20164}
    COP [86]              ; {20166}
    RTL                   ; {20168}
}

code_004EC9 {
    COP [A3]              ; {20169}
    COP [97]              ; {20171}

  loc_004ECD:
    COP [9B] ( #$0020, &code_004EDE, &code_004EDE, &code_004ED7 ) ; {20173}
}

code_004ED7 {
    COP [80] ( #08 )      ; {20183}
    COP [82]              ; {20186}
    BRA loc_004ECD        ; {20188}
}

code_004EDE {
    COP [9A] ( #$0000, &code_004EEA, &code_004EEA, &code_004EE8 ) ; {20190}
}

code_004EE8 {
    COP [96]              ; {20200}
}

code_004EEA {
    COP [80] ( #07 )      ; {20202}
    COP [82]              ; {20205}
    COP [81] ( #0B, #08 ) ; {20207}
    COP [83]              ; {20211}
    COP [86]              ; {20213}
    RTL                   ; {20215}
}

asciistring_004EF8 |[10]The poor creature that[N]repeats transmigration[N]of the soul and cannot[N]die- [FIN]I will put you in [N]a deep sleep- [12][08:408][END]|