?BANK 02

?INCLUDE 'lib_0118FC'
?INCLUDE 'lib_shared_01230B'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_012138 {
    STA $03C4             ; {74040}
    XBA                   ; {74043}
    PHA                   ; {74044}
    STZ $03C6             ; {74045}

  loc_012140:
    LDA #$2B              ; {74048}
    STA $7F6FC0, X        ; {74050}
    STA $bg3_tilemap_buffer, X ; {74054}
    LDA #$01              ; {74058}
    TSB $vram_upload_flags ; {74060}

  loc_01214F:
    JSR $&lib_shared_012769.code_013169 ; {74063}
    BEQ loc_012159        ; {74066}
    JSR $&lib_shared_01230B.code_01230B ; {74068}
    BRA loc_01214F        ; {74071}

  loc_012159:
    JSR $&lib_shared_012769.code_013169 ; {74073}
    BIT #$08              ; {74076}
    BNE loc_012185        ; {74078}
    BIT #$04              ; {74080}
    BNE loc_01219A        ; {74082}
    BIT #$40              ; {74084}
    BNE loc_012176        ; {74086}
    BIT #$80              ; {74088}
    BNE loc_012171        ; {74090}
    JSR $&lib_shared_01230B.code_01230B ; {74092}
    BRA loc_012159        ; {74095}

  loc_012171:
    BRK #$07              ; {74097}
    CLC                   ; {74099}
    BRA loc_012179        ; {74100}

  loc_012176:
    BRK #$07              ; {74102}
    SEC                   ; {74104}

  loc_012179:
    LDA #$2B              ; {74105}
    STA $7F6FC0, X        ; {74107}
    STA $bg3_tilemap_buffer, X ; {74111}
    PLA                   ; {74115}
    RTS                   ; {74116}

  loc_012185:
    LDA $01, S            ; {74117}
    BEQ loc_01214F        ; {74119}
    DEC                   ; {74121}
    STA $01, S            ; {74122}
    TXY                   ; {74124}
    REP #$20              ; {74125}
    TYA                   ; {74127}
    SEC                   ; {74128}
    SEC                   ; {74129}
    SBC #$0080            ; {74130}
    TAY                   ; {74133}
    SEP #$20              ; {74134}
    BRA loc_0121AF        ; {74136}

  loc_01219A:
    LDA $01, S            ; {74138}
    INC                   ; {74140}
    CMP $03C4             ; {74141}
    BCS loc_01214F        ; {74144}
    STA $01, S            ; {74146}
    TXY                   ; {74148}
    REP #$20              ; {74149}
    TYA                   ; {74151}
    CLC                   ; {74152}
    ADC #$0080            ; {74153}
    TAY                   ; {74156}
    SEP #$20              ; {74157}

  loc_0121AF:
    BRK #$07              ; {74159}
    LDA #$20              ; {74161}
    STA $7F6FC0, X        ; {74163}
    STA $bg3_tilemap_buffer, X ; {74167}
    STZ $03C6             ; {74171}
    TYX                   ; {74174}
    LDA $042F             ; {74175}
    BEQ loc_0121D6        ; {74178}
    LDA $01, S            ; {74180}
    CMP #$03              ; {74182}
    BNE loc_0121CD        ; {74184}
    BRL loc_012140        ; {74186}

  loc_0121CD:
    JSR $&lib_0118FC.code_011D46 ; {74189}
    STZ $042F             ; {74192}
    BRL loc_012140        ; {74195}

  loc_0121D6:
    LDA $01, S            ; {74198}
    CMP #$03              ; {74200}
    BEQ loc_0121DF        ; {74202}
    BRL loc_012140        ; {74204}

  loc_0121DF:
    JSR $&lib_0118FC.code_011D76 ; {74207}
    INC $042F             ; {74210}
    BRL loc_012140        ; {74213}

  code_0121E8:
    PHX                   ; {74216}
    SEP #$20              ; {74217}
    STA $03C4             ; {74219}
    XBA                   ; {74222}
    PHA                   ; {74223}

  loc_0121F0:
    LDA $01, S            ; {74224}
    REP #$20              ; {74226}
    AND #$00FF            ; {74228}
    ASL                   ; {74231}
    TAX                   ; {74232}
    LDA $@word_012277, X  ; {74233}
    TAX                   ; {74237}
    SEP #$20              ; {74238}
    STZ $03C6             ; {74240}
    LDA #$2B              ; {74243}
    STA $7F6FC0, X        ; {74245}
    STA $bg3_tilemap_buffer, X ; {74249}
    LDA #$01              ; {74253}
    TSB $vram_upload_flags ; {74255}

  loc_012212:
    JSR $&lib_shared_012769.code_013169 ; {74258}
    BEQ loc_01221C        ; {74261}
    JSR $&lib_shared_01230B.code_01230B ; {74263}
    BRA loc_012212        ; {74266}

  loc_01221C:
    JSR $&lib_shared_012769.code_013169 ; {74268}
    BIT #$08              ; {74271}
    BNE loc_012255        ; {74273}
    BIT #$04              ; {74275}
    BNE loc_01225E        ; {74277}
    BIT #$40              ; {74279}
    BNE loc_012243        ; {74281}
    BIT #$80              ; {74283}
    BNE loc_012234        ; {74285}
    JSR $&lib_shared_01230B.code_01230B ; {74287}
    BRA loc_01221C        ; {74290}

  loc_012234:
    BRK #$18              ; {74292}
    CLC                   ; {74294}
    LDA #$2B              ; {74295}
    STA $7F6FC0, X        ; {74297}
    STA $bg3_tilemap_buffer, X ; {74301}
    BRA loc_012250        ; {74305}

  loc_012243:
    BRK #$07              ; {74307}
    SEC                   ; {74309}
    LDA #$20              ; {74310}
    STA $7F6FC0, X        ; {74312}
    STA $bg3_tilemap_buffer, X ; {74316}

  loc_012250:
    PLA                   ; {74320}
    PLX                   ; {74321}
    REP #$20              ; {74322}
    RTL                   ; {74324}

  loc_012255:
    LDA $01, S            ; {74325}
    BEQ loc_012212        ; {74327}
    DEC                   ; {74329}
    STA $01, S            ; {74330}
    BRA loc_012268        ; {74332}

  loc_01225E:
    LDA $01, S            ; {74334}
    INC                   ; {74336}
    CMP $03C4             ; {74337}
    BCS loc_012212        ; {74340}
    STA $01, S            ; {74342}

  loc_012268:
    BRK #$07              ; {74344}
    LDA #$20              ; {74346}
    STA $7F6FC0, X        ; {74348}
    STA $bg3_tilemap_buffer, X ; {74352}
    BRL loc_0121F0        ; {74356}
}
---------------------------------------------

word_012277 [
  #$02CA   ;00
  #$038A   ;01
  #$044A   ;02
  #$050A   ;03
  #$05CA   ;04
]