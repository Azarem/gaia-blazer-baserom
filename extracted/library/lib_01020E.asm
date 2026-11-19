?BANK 02

?INCLUDE 'lib_01020E_part2'
?INCLUDE 'lib_shared_01032F'
?INCLUDE 'lib_shared_0104AF'
?INCLUDE 'lib_shared_0131D1'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_width_pages                0343
!map_height_px                  0344
!map_height_pages               0345
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_01020E {
    REP #$20              ; {66062}
    LDA $player_x         ; {66064}
    SEC                   ; {66067}
    SBC #$0070            ; {66068}
    BPL loc_01021E        ; {66071}
    LDA #$0000            ; {66073}
    BRA loc_010234        ; {66076}

  loc_01021E:
    CLC                   ; {66078}
    ADC #$0100            ; {66079}
    CMP $map_width_px     ; {66082}
    BCS loc_01022D        ; {66085}
    SEC                   ; {66087}
    SBC #$0100            ; {66088}
    BRA loc_010234        ; {66091}

  loc_01022D:
    LDA $map_width_px     ; {66093}
    SEC                   ; {66096}
    SBC #$0100            ; {66097}

  loc_010234:
    STA $scroll_bg1_x     ; {66100}
    LDA $player_y         ; {66103}
    SEC                   ; {66106}
    SBC #$0090            ; {66107}
    BPL loc_010245        ; {66110}
    LDA #$0000            ; {66112}
    BRA loc_01025B        ; {66115}

  loc_010245:
    CLC                   ; {66117}
    ADC $03CA             ; {66118}
    CMP $map_height_px    ; {66121}
    BCS loc_010254        ; {66124}
    SEC                   ; {66126}
    SBC $03CA             ; {66127}
    BRA loc_01025B        ; {66130}

  loc_010254:
    LDA $map_height_px    ; {66132}
    SEC                   ; {66135}
    SBC $03CA             ; {66136}

  loc_01025B:
    STA $scroll_bg1_y     ; {66139}
    LDA $map_width_px     ; {66142}
    LSR                   ; {66145}
    LSR                   ; {66146}
    LSR                   ; {66147}
    LSR                   ; {66148}
    STA $0392             ; {66149}
    LDA $map_height_px    ; {66152}
    LSR                   ; {66155}
    LSR                   ; {66156}
    LSR                   ; {66157}
    LSR                   ; {66158}
    STA $0394             ; {66159}
    LDX #$0000            ; {66162}

  loc_010275:
    REP #$20              ; {66165}
    LDA #$0000            ; {66167}
    JSR $&lib_shared_0104AF.code_0104E1 ; {66170}
    LDA $map_width_px, X  ; {66173}
    BEQ loc_010290        ; {66176}
    LDA $scroll_bg1_x, X  ; {66178}

  loc_010285:
    SEC                   ; {66181}
    SBC $map_width_px, X  ; {66182}
    BCC loc_010290        ; {66185}
    STA $scroll_bg1_x, X  ; {66187}
    BRA loc_010285        ; {66190}

  loc_010290:
    LDA #$0000            ; {66192}
    JSR $&lib_shared_0104AF.code_01052F ; {66195}
    LDA $map_height_px, X ; {66198}
    BEQ loc_0102A9        ; {66201}
    LDA $scroll_bg1_y, X  ; {66203}

  loc_01029E:
    SEC                   ; {66206}
    SBC $map_height_px, X ; {66207}
    BCC loc_0102A9        ; {66210}
    STA $scroll_bg1_y, X  ; {66212}
    BRA loc_01029E        ; {66215}

  loc_0102A9:
    SEP #$20              ; {66217}
    REP #$20              ; {66219}
    LDA $scroll_bg1_x, X  ; {66221}
    AND #$FF00            ; {66224}
    STA $16               ; {66227}
    LDA $scroll_bg1_y, X  ; {66229}
    AND #$FF00            ; {66232}
    STA $18               ; {66235}
    SEP #$20              ; {66237}
    LDY $0354, X          ; {66239}
    STY $00               ; {66242}
    LDY $0352, X          ; {66244}
    STY $02               ; {66247}
    LDY $map_width_px, X  ; {66249}
    STY $04               ; {66252}
    LDA $036B, X          ; {66254}
    STZ $06               ; {66257}
    STA $07               ; {66259}
    LDA $map_width_pages, X ; {66261}
    XBA                   ; {66264}
    LDA $map_height_pages, X ; {66265}
    JSL $@lib_shared_0131D1.code_0131D1 ; {66268}
    CLC                   ; {66272}
    ADC $0353, X          ; {66273}
    STZ $08               ; {66276}
    STA $09               ; {66278}
    LDY $035C, X          ; {66280}
    STY $0A               ; {66283}
    LDY $035A, X          ; {66285}
    STY $29               ; {66288}
    LDY $0362, X          ; {66290}
    STY $32               ; {66293}
    LDY $0364, X          ; {66295}
    STY $35               ; {66298}
    LDA #$20              ; {66300}

  loc_0102FE:
    PHA                   ; {66302}
    PHX                   ; {66303}
    LDX $32               ; {66304}
    JSR $&lib_shared_01032F.code_01032F ; {66306}
    JSL $@lib_01020E_part2.code_01057D ; {66309}
    PLX                   ; {66313}
    REP #$20              ; {66314}
    LDA $16               ; {66316}
    CLC                   ; {66318}
    ADC #$0010            ; {66319}
    CMP $map_width_px, X  ; {66322}
    BCC loc_01031A        ; {66325}
    AND #$0100            ; {66327}

  loc_01031A:
    STA $16               ; {66330}
    SEP #$20              ; {66332}
    PLA                   ; {66334}
    DEC                   ; {66335}
    BNE loc_0102FE        ; {66336}
    INX                   ; {66338}
    INX                   ; {66339}
    INX                   ; {66340}
    INX                   ; {66341}
    CPX #$0008            ; {66342}
    BEQ loc_01032E        ; {66345}
    BRL loc_010275        ; {66347}

  loc_01032E:
    RTL                   ; {66350}
}