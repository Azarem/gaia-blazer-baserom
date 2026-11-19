?BANK 02

?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_shared_0131B7'
?INCLUDE 'lib_shared_014789'
?INCLUDE 'string_lookup_080000'

!frame_counter                  0312
!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_012769 {
    PHP                   ; {75625}
    PHB                   ; {75626}
    SEP #$20              ; {75627}
    LDA #$02              ; {75629}
    PHA                   ; {75631}
    PLB                   ; {75632}
    LDA $03F9             ; {75633}
    PHA                   ; {75636}
    LDA $03E9             ; {75637}
    PHA                   ; {75640}
    LDA #$20              ; {75641}
    STA $03E9             ; {75643}
    STZ $03F9             ; {75646}
    PHX                   ; {75649}

  loc_012782:
    JSR $&code_0129DA     ; {75650}
    CMP #$14              ; {75653}
    BNE loc_01278C        ; {75655}
    BRL loc_012814        ; {75657}

  loc_01278C:
    CMP #$13              ; {75660}
    BEQ loc_012809        ; {75662}
    CMP #$0D              ; {75664}
    BNE loc_012797        ; {75666}
    BRL loc_0129BB        ; {75668}

  loc_012797:
    BCS loc_0127E4        ; {75671}
    CMP #$00              ; {75673}
    BNE loc_0127A0        ; {75675}
    BRL loc_0129C9        ; {75677}

  loc_0127A0:
    DEC                   ; {75680}
    BNE loc_0127A6        ; {75681}
    BRL loc_0129AA        ; {75683}

  loc_0127A6:
    DEC                   ; {75686}
    BNE loc_0127AC        ; {75687}
    BRL loc_01298D        ; {75689}

  loc_0127AC:
    DEC                   ; {75692}
    BNE loc_0127B2        ; {75693}
    BRL loc_01297E        ; {75695}

  loc_0127B2:
    DEC                   ; {75698}
    BNE loc_0127B8        ; {75699}
    BRL loc_01295A        ; {75701}

  loc_0127B8:
    DEC                   ; {75704}
    BNE loc_0127BE        ; {75705}
    BRL loc_012931        ; {75707}

  loc_0127BE:
    DEC                   ; {75710}
    BNE loc_0127C4        ; {75711}
    BRL loc_0128A2        ; {75713}

  loc_0127C4:
    DEC                   ; {75716}
    BNE loc_0127CA        ; {75717}
    BRL loc_012882        ; {75719}

  loc_0127CA:
    DEC                   ; {75722}
    BNE loc_0127D0        ; {75723}
    BRL loc_012870        ; {75725}

  loc_0127D0:
    DEC                   ; {75728}
    BNE loc_0127D6        ; {75729}
    BRL loc_012865        ; {75731}

  loc_0127D6:
    DEC                   ; {75734}
    BNE loc_0127DC        ; {75735}
    BRL loc_01285A        ; {75737}

  loc_0127DC:
    DEC                   ; {75740}
    BNE loc_0127E2        ; {75741}
    BRL loc_012829        ; {75743}

  loc_0127E2:
    BRA loc_012782        ; {75746}

  loc_0127E4:
    ORA $03F9             ; {75748}
    STA $bg3_tilemap_buffer, X ; {75751}
    XBA                   ; {75755}
    LDA $03E9             ; {75756}
    STA $7F7001, X        ; {75759}
    INX                   ; {75763}
    INX                   ; {75764}
    BIT #$02              ; {75765}
    BEQ loc_0127FC        ; {75767}
    BRL loc_012782        ; {75769}

  loc_0127FC:
    INC                   ; {75772}
    STA $7F6FBF, X        ; {75773}
    XBA                   ; {75777}
    STA $7F6FBE, X        ; {75778}
    BRL loc_012782        ; {75782}

  loc_012809:
    LDA $0001, Y          ; {75785}
    XBA                   ; {75788}
    LDA $0000, Y          ; {75789}
    TAY                   ; {75792}
    BRL loc_012782        ; {75793}

  loc_012814:
    LDA #$20              ; {75796}
    XBA                   ; {75798}
    LDA $0000, Y          ; {75799}
    INY                   ; {75802}

  loc_01281B:
    XBA                   ; {75803}
    STA $bg3_tilemap_buffer, X ; {75804}
    INX                   ; {75808}
    INX                   ; {75809}
    XBA                   ; {75810}
    DEC                   ; {75811}
    BNE loc_01281B        ; {75812}
    BRL loc_012782        ; {75814}

  loc_012829:
    LDA $0000, Y          ; {75817}
    INY                   ; {75820}
    STA $00               ; {75821}
    REP #$20              ; {75823}
    LDA $0000, Y          ; {75825}
    INY                   ; {75828}
    INY                   ; {75829}
    PHY                   ; {75830}
    TAY                   ; {75831}
    LDA $0000, Y          ; {75832}
    AND #$00FF            ; {75835}
    SEP #$20              ; {75838}
    TAY                   ; {75840}
    BEQ loc_012856        ; {75841}
    LDA $03E9             ; {75843}
    XBA                   ; {75846}
    LDA $00               ; {75847}
    REP #$20              ; {75849}

  loc_01284B:
    STA $bg3_tilemap_buffer, X ; {75851}
    INX                   ; {75855}
    INX                   ; {75856}
    DEY                   ; {75857}
    BNE loc_01284B        ; {75858}
    SEP #$20              ; {75860}

  loc_012856:
    PLY                   ; {75862}
    BRL loc_012782        ; {75863}

  loc_01285A:
    LDA $03F9             ; {75866}
    EOR #$80              ; {75869}
    STA $03F9             ; {75871}
    BRL loc_012782        ; {75874}

  loc_012865:
    LDA $03E9             ; {75877}
    EOR #$02              ; {75880}
    STA $03E9             ; {75882}
    BRL loc_012782        ; {75885}

  loc_012870:
    PHX                   ; {75888}
    REP #$20              ; {75889}
    LDX $0000, Y          ; {75891}
    INY                   ; {75894}
    INY                   ; {75895}
    SEP #$20              ; {75896}
    JSL $@code_012BDA     ; {75898}
    PLX                   ; {75902}
    BRL loc_012782        ; {75903}

  loc_012882:
    LDA $0000, Y          ; {75906}
    INY                   ; {75909}
    STA $00               ; {75910}
    LDA $0000, Y          ; {75912}
    INY                   ; {75915}
    STA $02               ; {75916}
    STX $03F7             ; {75918}
    JSR $&code_012B5D     ; {75921}
    REP #$20              ; {75924}
    PLA                   ; {75926}
    CLC                   ; {75927}
    ADC #$0082            ; {75928}
    TAX                   ; {75931}
    PHX                   ; {75932}
    SEP #$20              ; {75933}
    BRL loc_012782        ; {75935}

  loc_0128A2:
    LDA $0000, Y          ; {75938}
    INY                   ; {75941}
    STA $00               ; {75942}
    STA $02               ; {75944}
    REP #$20              ; {75946}
    DEC                   ; {75948}
    AND #$00FF            ; {75949}
    ASL                   ; {75952}
    PHX                   ; {75953}
    CLC                   ; {75954}
    ADC $01, S            ; {75955}
    STA $01, S            ; {75957}
    TAX                   ; {75959}
    LDA $0000, Y          ; {75960}
    INY                   ; {75963}
    INY                   ; {75964}
    PHY                   ; {75965}
    TAY                   ; {75966}
    SEP #$20              ; {75967}
    LDA $03E9             ; {75969}
    XBA                   ; {75972}

  loc_0128C5:
    LDA $0000, Y          ; {75973}
    AND #$0F              ; {75976}
    ORA #$30              ; {75978}
    REP #$20              ; {75980}
    STA $bg3_tilemap_buffer, X ; {75982}
    DEX                   ; {75986}
    DEX                   ; {75987}
    SEP #$20              ; {75988}
    DEC $00               ; {75990}
    BEQ loc_0128F4        ; {75992}
    LDA $0000, Y          ; {75994}
    INY                   ; {75997}
    AND #$F0              ; {75998}
    LSR                   ; {76000}
    LSR                   ; {76001}
    LSR                   ; {76002}
    LSR                   ; {76003}
    ORA #$30              ; {76004}
    REP #$20              ; {76006}
    STA $bg3_tilemap_buffer, X ; {76008}
    DEX                   ; {76012}
    DEX                   ; {76013}
    SEP #$20              ; {76014}
    DEC $00               ; {76016}
    BNE loc_0128C5        ; {76018}

  loc_0128F4:
    INX                   ; {76020}
    INX                   ; {76021}
    DEC $02               ; {76022}
    BEQ loc_01290A        ; {76024}
    LDA $bg3_tilemap_buffer, X ; {76026}
    CMP #$30              ; {76030}
    BNE loc_01290A        ; {76032}
    LDA #$20              ; {76034}
    STA $bg3_tilemap_buffer, X ; {76036}
    BRA loc_0128F4        ; {76040}

  loc_01290A:
    XBA                   ; {76042}
    BIT #$02              ; {76043}
    BNE loc_01292A        ; {76045}
    XBA                   ; {76047}
    INC $02               ; {76048}

  loc_012912:
    LDA $bg3_tilemap_buffer, X ; {76050}
    REP #$20              ; {76054}
    ORA #$0100            ; {76056}
    STA $7F6FC0, X        ; {76059}
    AND #$FEFF            ; {76063}
    SEP #$20              ; {76066}
    INX                   ; {76068}
    INX                   ; {76069}
    DEC $02               ; {76070}
    BNE loc_012912        ; {76072}

  loc_01292A:
    PLY                   ; {76074}
    PLX                   ; {76075}
    INX                   ; {76076}
    INX                   ; {76077}
    BRL loc_012782        ; {76078}

  loc_012931:
    REP #$20              ; {76081}
    LDA $0000, Y          ; {76083}
    INY                   ; {76086}
    INY                   ; {76087}
    STA $00               ; {76088}
    LDA $0000, Y          ; {76090}
    INY                   ; {76093}
    INY                   ; {76094}
    PHY                   ; {76095}
    TAY                   ; {76096}
    LDA $0000, Y          ; {76097}
    ASL                   ; {76100}
    CLC                   ; {76101}
    ADC $00               ; {76102}
    TAY                   ; {76104}
    LDA $0000, Y          ; {76105}
    TAY                   ; {76108}
    SEP #$20              ; {76109}
    LDA $03E9             ; {76111}
    XBA                   ; {76114}
    JSR $&code_012A48     ; {76115}
    PLY                   ; {76118}
    BRL loc_012782        ; {76119}

  loc_01295A:
    REP #$20              ; {76122}
    PHY                   ; {76124}
    LDA $0000, Y          ; {76125}
    TAY                   ; {76128}
    LDA $0000, Y          ; {76129}
    STA $00               ; {76132}
    PLY                   ; {76134}
    PHY                   ; {76135}
    LDA $0002, Y          ; {76136}
    TAY                   ; {76139}
    LDA $0000, Y          ; {76140}
    STA $02               ; {76143}
    SEP #$20              ; {76145}
    JSR $&code_012ABF     ; {76147}
    PLY                   ; {76150}
    INY                   ; {76151}
    INY                   ; {76152}
    INY                   ; {76153}
    INY                   ; {76154}
    BRL loc_012782        ; {76155}

  loc_01297E:
    LDA $03E9             ; {76158}
    AND #$E3              ; {76161}
    ORA $0000, Y          ; {76163}
    INY                   ; {76166}
    STA $03E9             ; {76167}
    BRL loc_012782        ; {76170}

  loc_01298D:
    LDA $0000, Y          ; {76173}
    INY                   ; {76176}
    PHY                   ; {76177}
    REP #$20              ; {76178}
    AND #$00FF            ; {76180}
    ASL                   ; {76183}
    TAY                   ; {76184}
    LDA $&lib_shared_014789.binary_list_014789, Y ; {76185}
    TAY                   ; {76188}
    SEP #$20              ; {76189}
    LDA $03E9             ; {76191}
    XBA                   ; {76194}
    JSR $&code_012A92     ; {76195}
    PLY                   ; {76198}
    BRL loc_012782        ; {76199}

  loc_0129AA:
    LDA $0001, Y          ; {76202}
    STA $02, S            ; {76205}
    XBA                   ; {76207}
    LDA $0000, Y          ; {76208}
    STA $01, S            ; {76211}
    INY                   ; {76213}
    INY                   ; {76214}
    TAX                   ; {76215}
    BRL loc_012782        ; {76216}

  loc_0129BB:
    REP #$20              ; {76219}
    PLA                   ; {76221}
    CLC                   ; {76222}
    ADC #$0040            ; {76223}
    TAX                   ; {76226}
    PHA                   ; {76227}
    SEP #$20              ; {76228}
    BRL loc_012782        ; {76230}

  loc_0129C9:
    PLX                   ; {76233}
    PLA                   ; {76234}
    STA $03E9             ; {76235}
    PLA                   ; {76238}
    STA $03F9             ; {76239}
    LDA #$01              ; {76242}
    TSB $vram_upload_flags ; {76244}
    PLB                   ; {76247}
    PLP                   ; {76248}
    RTL                   ; {76249}
}

code_0129DA {
    LDA $0000, Y          ; {76250}
    BMI loc_0129E1        ; {76253}
    INY                   ; {76255}
    RTS                   ; {76256}

  loc_0129E1:
    INY                   ; {76257}
    PHB                   ; {76258}
    PHY                   ; {76259}
    REP #$20              ; {76260}
    AND #$007F            ; {76262}
    PHA                   ; {76265}
    ASL                   ; {76266}
    CLC                   ; {76267}
    ADC $01, S            ; {76268}
    ASL                   ; {76270}
    ASL                   ; {76271}
    TAY                   ; {76272}
    PLA                   ; {76273}
    SEP #$20              ; {76274}
    LDA #$^string_lookup_080000.lookup_080000 ; {76276}
    PHA                   ; {76278}
    PLB                   ; {76279}
    LDA #$0C              ; {76280}
    STA $0C               ; {76282}
    LDA $03E9             ; {76284}
    XBA                   ; {76287}

  loc_012A00:
    LDA $&string_lookup_080000.lookup_080000, Y ; {76288}
    BEQ loc_012A26        ; {76291}
    INY                   ; {76293}
    ORA $03F9             ; {76294}
    REP #$20              ; {76297}
    STA $bg3_tilemap_buffer, X ; {76299}
    INX                   ; {76303}
    INX                   ; {76304}
    BIT #$0200            ; {76305}
    BNE loc_012A20        ; {76308}
    ORA #$0100            ; {76310}
    STA $7F6FBE, X        ; {76313}
    AND #$FEFF            ; {76317}

  loc_012A20:
    SEP #$20              ; {76320}
    DEC $0C               ; {76322}
    BNE loc_012A00        ; {76324}

  loc_012A26:
    LDA #$20              ; {76326}
    ORA $03F9             ; {76328}
    REP #$20              ; {76331}
    STA $bg3_tilemap_buffer, X ; {76333}
    INX                   ; {76337}
    INX                   ; {76338}
    BIT #$0200            ; {76339}
    BNE loc_012A42        ; {76342}
    ORA #$0100            ; {76344}
    STA $7F6FBE, X        ; {76347}
    AND #$FEFF            ; {76351}

  loc_012A42:
    SEP #$20              ; {76354}
    PLY                   ; {76356}
    PLB                   ; {76357}
    BRA code_0129DA       ; {76358}
}

code_012A48 {
    LDA $0000, Y          ; {76360}
    BMI loc_012A73        ; {76363}
    BNE loc_012A50        ; {76365}
    RTS                   ; {76367}

  loc_012A50:
    CMP #$14              ; {76368}
    BEQ loc_012A79        ; {76370}
    INY                   ; {76372}
    ORA $03F9             ; {76373}
    REP #$20              ; {76376}
    STA $bg3_tilemap_buffer, X ; {76378}
    INX                   ; {76382}
    INX                   ; {76383}
    BIT #$0200            ; {76384}
    BNE loc_012A6F        ; {76387}
    ORA #$0100            ; {76389}
    STA $7F6FBE, X        ; {76392}
    AND #$FEFF            ; {76396}

  loc_012A6F:
    SEP #$20              ; {76399}
    BRA code_012A48       ; {76401}

  loc_012A73:
    JSR $&code_0129DA     ; {76403}
    DEY                   ; {76406}
    BRA code_012A48       ; {76407}

  loc_012A79:
    LDA #$20              ; {76409}
    ORA $03F9             ; {76411}
    XBA                   ; {76414}
    INY                   ; {76415}
    LDA $0000, Y          ; {76416}
    INY                   ; {76419}

  loc_012A84:
    XBA                   ; {76420}
    STA $bg3_tilemap_buffer, X ; {76421}
    INX                   ; {76425}
    INX                   ; {76426}
    XBA                   ; {76427}
    DEC                   ; {76428}
    BNE loc_012A84        ; {76429}
    BRL code_012A48       ; {76431}
}

code_012A92 {
    LDA $0000, Y          ; {76434}
    BMI loc_012AB9        ; {76437}
    BNE loc_012A9A        ; {76439}
    RTS                   ; {76441}

  loc_012A9A:
    INY                   ; {76442}
    ORA $03F9             ; {76443}
    REP #$20              ; {76446}
    STA $bg3_tilemap_buffer, X ; {76448}
    INX                   ; {76452}
    INX                   ; {76453}
    BIT #$0200            ; {76454}
    BNE loc_012AB5        ; {76457}
    ORA #$0100            ; {76459}
    STA $7F6FBE, X        ; {76462}
    AND #$FEFF            ; {76466}

  loc_012AB5:
    SEP #$20              ; {76469}
    BRA code_012A92       ; {76471}

  loc_012AB9:
    JSR $&code_0129DA     ; {76473}
    DEY                   ; {76476}
    BRA code_012A92       ; {76477}
}

code_012ABF {
    PHX                   ; {76479}
    LDX #$0000            ; {76480}
    LDA $00               ; {76483}

  loc_012AC5:
    SEC                   ; {76485}
    SBC #$0A              ; {76486}
    BMI loc_012ACE        ; {76488}
    INX                   ; {76490}
    INX                   ; {76491}
    BRA loc_012AC5        ; {76492}

  loc_012ACE:
    LDA $01, S            ; {76494}
    CMP #$CC              ; {76496}
    BNE loc_012AE6        ; {76498}
    LDA $@data_00F9F7.word_00FB2F, X ; {76500}
    STA $7F0014           ; {76504}
    LDA $@data_00F9F7.word_00FB2F+1, X ; {76508}
    STA $7F0015           ; {76512}
    BRA loc_012AF6        ; {76516}

  loc_012AE6:
    LDA $@data_00F9F7.word_00FB2F, X ; {76518}
    STA $7F001C           ; {76522}
    LDA $@data_00F9F7.word_00FB2F+1, X ; {76526}
    STA $7F001D           ; {76530}

  loc_012AF6:
    LDA $00               ; {76534}
    CMP #$33              ; {76536}
    BCC loc_012AFE        ; {76538}
    LDA #$32              ; {76540}

  loc_012AFE:
    STA $00               ; {76542}
    LDA $02               ; {76544}
    CMP #$33              ; {76546}
    BCC loc_012B08        ; {76548}
    LDA #$32              ; {76550}

  loc_012B08:
    STA $02               ; {76552}
    PLX                   ; {76554}
    LDA $00               ; {76555}
    LSR                   ; {76557}
    BEQ loc_012B1F        ; {76558}
    PHP                   ; {76560}

  loc_012B11:
    XBA                   ; {76561}
    LDA #$1B              ; {76562}
    STA $bg3_tilemap_buffer, X ; {76564}
    INX                   ; {76568}
    INX                   ; {76569}
    XBA                   ; {76570}
    DEC                   ; {76571}
    BNE loc_012B11        ; {76572}
    PLP                   ; {76574}

  loc_012B1F:
    BCS loc_012B28        ; {76575}
    LDA $02               ; {76577}
    SEC                   ; {76579}
    SBC $00               ; {76580}
    BRA loc_012B42        ; {76582}

  loc_012B28:
    LDA #$1C              ; {76584}
    STA $bg3_tilemap_buffer, X ; {76586}
    LDA $02               ; {76590}
    SEC                   ; {76592}
    SBC $00               ; {76593}
    BEQ loc_012B5C        ; {76595}
    XBA                   ; {76597}
    LDA #$1D              ; {76598}
    STA $bg3_tilemap_buffer, X ; {76600}
    XBA                   ; {76604}
    INX                   ; {76605}
    INX                   ; {76606}
    DEC                   ; {76607}
    BEQ loc_012B5C        ; {76608}

  loc_012B42:
    LSR                   ; {76610}
    BEQ loc_012B54        ; {76611}
    PHP                   ; {76613}

  loc_012B46:
    XBA                   ; {76614}
    LDA #$1E              ; {76615}
    STA $bg3_tilemap_buffer, X ; {76617}
    INX                   ; {76621}
    INX                   ; {76622}
    XBA                   ; {76623}
    DEC                   ; {76624}
    BNE loc_012B46        ; {76625}
    PLP                   ; {76627}

  loc_012B54:
    BCC loc_012B5C        ; {76628}
    LDA #$1F              ; {76630}
    STA $bg3_tilemap_buffer, X ; {76632}

  loc_012B5C:
    RTS                   ; {76636}
}

code_012B5D {
    PHX                   ; {76637}
    LDA #$01              ; {76638}
    STA $bg3_tilemap_buffer, X ; {76640}
    LDA $00               ; {76644}
    STA $0C               ; {76646}
    LDA #$03              ; {76648}

  loc_012B6A:
    STA $7F7002, X        ; {76650}
    INX                   ; {76654}
    INX                   ; {76655}
    DEC $0C               ; {76656}
    BNE loc_012B6A        ; {76658}
    LDA #$02              ; {76660}
    STA $7F7002, X        ; {76662}
    REP #$20              ; {76666}
    PLA                   ; {76668}
    CLC                   ; {76669}
    ADC #$0040            ; {76670}
    TAX                   ; {76673}
    SEP #$20              ; {76674}
    LDA $02               ; {76676}
    STA $0C               ; {76678}

  loc_012B88:
    PHX                   ; {76680}
    LDA #$07              ; {76681}
    STA $bg3_tilemap_buffer, X ; {76683}
    LDA $00               ; {76687}
    STA $0E               ; {76689}
    STZ $0F               ; {76691}
    LDA $03E9             ; {76693}
    XBA                   ; {76696}
    LDA #$20              ; {76697}
    REP #$20              ; {76699}

  loc_012B9D:
    STA $7F7002, X        ; {76701}
    INX                   ; {76705}
    INX                   ; {76706}
    DEC $0E               ; {76707}
    BNE loc_012B9D        ; {76709}
    SEP #$20              ; {76711}
    LDA #$08              ; {76713}
    STA $7F7002, X        ; {76715}
    REP #$20              ; {76719}
    PLA                   ; {76721}
    CLC                   ; {76722}
    ADC #$0040            ; {76723}
    TAX                   ; {76726}
    SEP #$20              ; {76727}
    DEC $0C               ; {76729}
    BNE loc_012B88        ; {76731}
    LDA #$05              ; {76733}
    STA $bg3_tilemap_buffer, X ; {76735}
    LDA $00               ; {76739}
    STA $0C               ; {76741}
    LDA #$04              ; {76743}

  loc_012BC9:
    STA $7F7002, X        ; {76745}
    INX                   ; {76749}
    INX                   ; {76750}
    DEC $0C               ; {76751}
    BNE loc_012BC9        ; {76753}
    LDA #$06              ; {76755}
    STA $7F7002, X        ; {76757}
    RTS                   ; {76761}
}

code_012BDA {
    PHY                   ; {76762}
    LDA $bg3_tilemap_buffer, X ; {76763}
    CMP #$01              ; {76767}
    BNE loc_012C25        ; {76769}
    STZ $00               ; {76771}
    STZ $01               ; {76773}
    PHX                   ; {76775}

  loc_012BE8:
    LDA $bg3_tilemap_buffer, X ; {76776}
    CMP #$02              ; {76780}
    BEQ loc_012BF6        ; {76782}
    INX                   ; {76784}
    INX                   ; {76785}
    INC $00               ; {76786}
    BRA loc_012BE8        ; {76788}

  loc_012BF6:
    PLX                   ; {76790}

  loc_012BF7:
    REP #$20              ; {76791}
    LDA $00               ; {76793}
    STA $0C               ; {76795}
    PHX                   ; {76797}
    LDA #$2000            ; {76798}

  loc_012C01:
    STA $bg3_tilemap_buffer, X ; {76801}
    INX                   ; {76805}
    INX                   ; {76806}
    DEC $0C               ; {76807}
    BNE loc_012C01        ; {76809}
    LDA $bg3_tilemap_buffer, X ; {76811}
    TAY                   ; {76815}
    LDA #$2000            ; {76816}
    STA $bg3_tilemap_buffer, X ; {76819}
    PLX                   ; {76823}
    TXA                   ; {76824}
    CLC                   ; {76825}
    ADC #$0040            ; {76826}
    TAX                   ; {76829}
    SEP #$20              ; {76830}
    TYA                   ; {76832}
    CMP #$06              ; {76833}
    BNE loc_012BF7        ; {76835}

  loc_012C25:
    PLY                   ; {76837}
    RTL                   ; {76838}
}

code_012C27 {
    PHP                   ; {76839}
    PHB                   ; {76840}
    SEP #$20              ; {76841}
    LDA $01, S            ; {76843}
    CMP #$01              ; {76845}
    BNE loc_012C35        ; {76847}
    LDA #$02              ; {76849}
    PHA                   ; {76851}
    PLB                   ; {76852}

  loc_012C35:
    LDA #$20              ; {76853}
    STA $03E9             ; {76855}
    LDA #$01              ; {76858}
    STA $03F5             ; {76860}
    STZ $03F9             ; {76863}
    LDA $0000, Y          ; {76866}
    CMP #$01              ; {76869}
    BEQ loc_012C6C        ; {76871}
    CMP #$10              ; {76873}
    BEQ loc_012C5C        ; {76875}
    LDX $03F3             ; {76877}
    PHX                   ; {76880}
    LDA $1B84             ; {76881}
    BEQ loc_012C59        ; {76884}
    BRL loc_012F3B        ; {76886}

  loc_012C59:
    BRL loc_012D6E        ; {76889}

  loc_012C5C:
    INY                   ; {76892}
    LDX #$0408            ; {76893}
    PHX                   ; {76896}
    LDA #$16              ; {76897}
    STA $00               ; {76899}
    LDA #$09              ; {76901}
    STA $02               ; {76903}
    BRL loc_012DDA        ; {76905}

  loc_012C6C:
    PHX                   ; {76908}

  loc_012C6D:
    JSR $&code_012F6E     ; {76909}
    CMP #$0D              ; {76912}
    BNE loc_012C77        ; {76914}
    BRL loc_012F3B        ; {76916}

  loc_012C77:
    CMP #$14              ; {76919}
    BNE loc_012C7E        ; {76921}
    BRL loc_012D53        ; {76923}

  loc_012C7E:
    BCS loc_012CF7        ; {76926}
    CMP #$00              ; {76928}
    BNE loc_012C87        ; {76930}
    BRL loc_012F5F        ; {76932}

  loc_012C87:
    DEC                   ; {76935}
    BNE loc_012C8D        ; {76936}
    BRL loc_012F07        ; {76938}

  loc_012C8D:
    DEC                   ; {76941}
    BNE loc_012C93        ; {76942}
    BRL loc_012EE0        ; {76944}

  loc_012C93:
    DEC                   ; {76947}
    BNE loc_012C99        ; {76948}
    BRL loc_012ED1        ; {76950}

  loc_012C99:
    DEC                   ; {76953}
    BNE loc_012C9F        ; {76954}
    BRL loc_012EAD        ; {76956}

  loc_012C9F:
    DEC                   ; {76959}
    BNE loc_012CA5        ; {76960}
    BRL loc_012E7A        ; {76962}

  loc_012CA5:
    DEC                   ; {76965}
    BNE loc_012CAB        ; {76966}
    BRL loc_012DEB        ; {76968}

  loc_012CAB:
    DEC                   ; {76971}
    BNE loc_012CB1        ; {76972}
    BRL loc_012DCE        ; {76974}

  loc_012CB1:
    DEC                   ; {76977}
    BNE loc_012CB7        ; {76978}
    BRL loc_012DBC        ; {76980}

  loc_012CB7:
    DEC                   ; {76983}
    BNE loc_012CBD        ; {76984}
    BRL loc_012DB1        ; {76986}

  loc_012CBD:
    DEC                   ; {76989}
    BNE loc_012CC3        ; {76990}
    BRL loc_012DA6        ; {76992}

  loc_012CC3:
    DEC                   ; {76995}
    BNE loc_012CC9        ; {76996}
    BRL loc_012DA0        ; {76998}

  loc_012CC9:
    DEC                   ; {77001}
    BNE loc_012CCF        ; {77002}
    BRL loc_012F62        ; {77004}

  loc_012CCF:
    DEC                   ; {77007}
    DEC                   ; {77008}
    BNE loc_012CD6        ; {77009}
    BRL loc_012D90        ; {77011}

  loc_012CD6:
    DEC                   ; {77014}
    BNE loc_012CDC        ; {77015}
    BRL loc_012D85        ; {77017}

  loc_012CDC:
    DEC                   ; {77020}
    BNE loc_012CE2        ; {77021}
    BRL loc_012D6E        ; {77023}

  loc_012CE2:
    DEC                   ; {77026}
    BNE loc_012CE8        ; {77027}
    BRL loc_012F18        ; {77029}

  loc_012CE8:
    DEC                   ; {77032}
    BNE loc_012CEE        ; {77033}
    BRL loc_012D68        ; {77035}

  loc_012CEE:
    DEC                   ; {77038}
    BNE loc_012CF4        ; {77039}
    BRL loc_012D48        ; {77041}

  loc_012CF4:
    BRL loc_012C6D        ; {77044}

  loc_012CF7:
    ORA $03F9             ; {77047}
    STA $bg3_tilemap_buffer, X ; {77050}
    XBA                   ; {77054}
    LDA $03E9             ; {77055}
    STA $7F7001, X        ; {77058}
    INX                   ; {77062}
    INX                   ; {77063}
    BIT #$02              ; {77064}
    BNE loc_012D18        ; {77066}
    INC                   ; {77068}
    STA $7F6FBF, X        ; {77069}
    XBA                   ; {77073}
    STA $7F6FBE, X        ; {77074}
    BRA loc_012D42        ; {77078}

  loc_012D18:
    LDA $7F6FBE, X        ; {77080}
    CMP #$FE              ; {77084}
    BCC loc_012D26        ; {77086}
    LDA #$20              ; {77088}
    STA $7F6FBE, X        ; {77090}

  loc_012D26:
    XBA                   ; {77094}
    CMP #$F4              ; {77095}
    BCS loc_012D33        ; {77097}
    CMP #$CC              ; {77099}
    BCC loc_012D42        ; {77101}
    LDA #$FE              ; {77103}
    BRA loc_012D35        ; {77105}

  loc_012D33:
    LDA #$FF              ; {77107}

  loc_012D35:
    STA $7F6FBE, X        ; {77109}
    XBA                   ; {77113}
    LDA $03E9             ; {77114}
    STA $7F6FBF, X        ; {77117}
    XBA                   ; {77121}

  loc_012D42:
    JSR $&code_013124     ; {77122}
    BRL loc_012C6D        ; {77125}

  loc_012D48:
    LDA $0001, Y          ; {77128}
    XBA                   ; {77131}
    LDA $0000, Y          ; {77132}
    TAY                   ; {77135}
    BRL loc_012C6D        ; {77136}

  loc_012D53:
    LDA #$20              ; {77139}
    XBA                   ; {77141}
    LDA $0000, Y          ; {77142}
    INY                   ; {77145}

  loc_012D5A:
    XBA                   ; {77146}
    STA $bg3_tilemap_buffer, X ; {77147}
    INX                   ; {77151}
    INX                   ; {77152}
    XBA                   ; {77153}
    DEC                   ; {77154}
    BNE loc_012D5A        ; {77155}
    BRL loc_012C6D        ; {77157}

  loc_012D68:
    JSR $&code_01314A     ; {77160}
    BRL loc_012C6D        ; {77163}

  loc_012D6E:
    PLX                   ; {77166}
    JSR $&code_0130CA     ; {77167}
    JSR $&code_01300F     ; {77170}
    REP #$20              ; {77173}
    LDA $03EB             ; {77175}
    CLC                   ; {77178}
    ADC #$0040            ; {77179}
    TAX                   ; {77182}
    PHX                   ; {77183}
    SEP #$20              ; {77184}
    BRL loc_012C6D        ; {77186}

  loc_012D85:
    LDA $03F5             ; {77189}
    EOR #$01              ; {77192}
    STA $03F5             ; {77194}
    BRL loc_012C6D        ; {77197}

  loc_012D90:
    LDA $1B84             ; {77200}
    BEQ loc_012D9C        ; {77203}
    LDA $0000, Y          ; {77205}
    JSL $@code_013140     ; {77208}

  loc_012D9C:
    INY                   ; {77212}
    BRL loc_012C6D        ; {77213}

  loc_012DA0:
    INY                   ; {77216}
    INY                   ; {77217}
    INY                   ; {77218}
    BRL loc_012C6D        ; {77219}

  loc_012DA6:
    LDA $03F9             ; {77222}
    EOR #$80              ; {77225}
    STA $03F9             ; {77227}
    BRL loc_012C6D        ; {77230}

  loc_012DB1:
    LDA $03E9             ; {77233}
    EOR #$02              ; {77236}
    STA $03E9             ; {77238}
    BRL loc_012C6D        ; {77241}

  loc_012DBC:
    PHX                   ; {77244}
    REP #$20              ; {77245}
    LDX $0000, Y          ; {77247}
    INY                   ; {77250}
    INY                   ; {77251}
    SEP #$20              ; {77252}
    JSL $@code_012BDA     ; {77254}
    PLX                   ; {77258}
    BRL loc_012C6D        ; {77259}

  loc_012DCE:
    LDA $0000, Y          ; {77262}
    INY                   ; {77265}
    STA $00               ; {77266}
    LDA $0000, Y          ; {77268}
    INY                   ; {77271}
    STA $02               ; {77272}

  loc_012DDA:
    JSR $&code_012B5D     ; {77274}
    REP #$20              ; {77277}
    PLA                   ; {77279}
    CLC                   ; {77280}
    ADC #$0082            ; {77281}
    TAX                   ; {77284}
    PHX                   ; {77285}
    SEP #$20              ; {77286}
    BRL loc_012C6D        ; {77288}

  loc_012DEB:
    LDA $0000, Y          ; {77291}
    INY                   ; {77294}
    STA $00               ; {77295}
    STA $02               ; {77297}
    REP #$20              ; {77299}
    DEC                   ; {77301}
    AND #$00FF            ; {77302}
    ASL                   ; {77305}
    PHX                   ; {77306}
    CLC                   ; {77307}
    ADC $01, S            ; {77308}
    STA $01, S            ; {77310}
    TAX                   ; {77312}
    LDA $0000, Y          ; {77313}
    INY                   ; {77316}
    INY                   ; {77317}
    PHY                   ; {77318}
    TAY                   ; {77319}
    SEP #$20              ; {77320}
    LDA $03E9             ; {77322}
    XBA                   ; {77325}

  loc_012E0E:
    LDA $0000, Y          ; {77326}
    AND #$0F              ; {77329}
    ORA #$30              ; {77331}
    REP #$20              ; {77333}
    STA $bg3_tilemap_buffer, X ; {77335}
    DEX                   ; {77339}
    DEX                   ; {77340}
    SEP #$20              ; {77341}
    DEC $00               ; {77343}
    BEQ loc_012E3D        ; {77345}
    LDA $0000, Y          ; {77347}
    INY                   ; {77350}
    AND #$F0              ; {77351}
    LSR                   ; {77353}
    LSR                   ; {77354}
    LSR                   ; {77355}
    LSR                   ; {77356}
    ORA #$30              ; {77357}
    REP #$20              ; {77359}
    STA $bg3_tilemap_buffer, X ; {77361}
    DEX                   ; {77365}
    DEX                   ; {77366}
    SEP #$20              ; {77367}
    DEC $00               ; {77369}
    BNE loc_012E0E        ; {77371}

  loc_012E3D:
    INX                   ; {77373}
    INX                   ; {77374}
    DEC $02               ; {77375}
    BEQ loc_012E53        ; {77377}
    LDA $bg3_tilemap_buffer, X ; {77379}
    CMP #$30              ; {77383}
    BNE loc_012E53        ; {77385}
    LDA #$20              ; {77387}
    STA $bg3_tilemap_buffer, X ; {77389}
    BRA loc_012E3D        ; {77393}

  loc_012E53:
    XBA                   ; {77395}
    BIT #$02              ; {77396}
    BNE loc_012E73        ; {77398}
    XBA                   ; {77400}
    INC $02               ; {77401}

  loc_012E5B:
    LDA $bg3_tilemap_buffer, X ; {77403}
    REP #$20              ; {77407}
    ORA #$0100            ; {77409}
    STA $7F6FC0, X        ; {77412}
    AND #$FEFF            ; {77416}
    SEP #$20              ; {77419}
    INX                   ; {77421}
    INX                   ; {77422}
    DEC $02               ; {77423}
    BNE loc_012E5B        ; {77425}

  loc_012E73:
    PLY                   ; {77427}
    PLX                   ; {77428}
    INX                   ; {77429}
    INX                   ; {77430}
    BRL loc_012C6D        ; {77431}

  loc_012E7A:
    REP #$20              ; {77434}
    LDA $0000, Y          ; {77436}
    INY                   ; {77439}
    INY                   ; {77440}
    STA $00               ; {77441}
    LDA $0000, Y          ; {77443}
    INY                   ; {77446}
    INY                   ; {77447}
    PHY                   ; {77448}
    TAY                   ; {77449}
    LDA $0000, Y          ; {77450}
    ASL                   ; {77453}
    CLC                   ; {77454}
    ADC $00               ; {77455}
    TAY                   ; {77457}
    SEP #$20              ; {77458}
    PHB                   ; {77460}
    LDA #$02              ; {77461}
    PHA                   ; {77463}
    PLB                   ; {77464}
    REP #$20              ; {77465}
    LDA $0000, Y          ; {77467}
    TAY                   ; {77470}
    SEP #$20              ; {77471}
    LDA $03E9             ; {77473}
    XBA                   ; {77476}
    JSR $&code_012FDF     ; {77477}
    PLB                   ; {77480}
    PLY                   ; {77481}
    BRL loc_012C6D        ; {77482}

  loc_012EAD:
    REP #$20              ; {77485}
    PHY                   ; {77487}
    LDA $0000, Y          ; {77488}
    TAY                   ; {77491}
    LDA $0000, Y          ; {77492}
    STA $00               ; {77495}
    PLY                   ; {77497}
    PHY                   ; {77498}
    LDA $0002, Y          ; {77499}
    TAY                   ; {77502}
    LDA $0000, Y          ; {77503}
    STA $02               ; {77506}
    SEP #$20              ; {77508}
    JSR $&code_012ABF     ; {77510}
    PLY                   ; {77513}
    INY                   ; {77514}
    INY                   ; {77515}
    INY                   ; {77516}
    INY                   ; {77517}
    BRL loc_012C6D        ; {77518}

  loc_012ED1:
    LDA $03E9             ; {77521}
    AND #$E3              ; {77524}
    ORA $0000, Y          ; {77526}
    INY                   ; {77529}
    STA $03E9             ; {77530}
    BRL loc_012C6D        ; {77533}

  loc_012EE0:
    LDA $0000, Y          ; {77536}
    INY                   ; {77539}
    PHY                   ; {77540}
    REP #$20              ; {77541}
    AND #$00FF            ; {77543}
    ASL                   ; {77546}
    TAY                   ; {77547}
    SEP #$20              ; {77548}
    PHB                   ; {77550}
    LDA #$^lib_shared_014789.binary_list_014789 ; {77551}
    PHA                   ; {77553}
    PLB                   ; {77554}
    REP #$20              ; {77555}
    LDA $&lib_shared_014789.binary_list_014789, Y ; {77557}
    TAY                   ; {77560}
    SEP #$20              ; {77561}
    LDA $03E9             ; {77563}
    XBA                   ; {77566}
    JSR $&code_012FDF     ; {77567}
    PLB                   ; {77570}
    PLY                   ; {77571}
    BRL loc_012C6D        ; {77572}

  loc_012F07:
    LDA $0001, Y          ; {77575}
    STA $02, S            ; {77578}
    XBA                   ; {77580}
    LDA $0000, Y          ; {77581}
    STA $01, S            ; {77584}
    INY                   ; {77586}
    INY                   ; {77587}
    TAX                   ; {77588}
    BRL loc_012C6D        ; {77589}

  loc_012F18:
    PLX                   ; {77592}

  loc_012F19:
    PHX                   ; {77593}
    JSR $&code_0130CA     ; {77594}
    REP #$20              ; {77597}
    LDA $03ED             ; {77599}
    DEC                   ; {77602}
    AND #$FFFE            ; {77603}
    CLC                   ; {77606}
    ADC $01, S            ; {77607}
    CLC                   ; {77609}
    ADC #$0040            ; {77610}
    TAX                   ; {77613}
    SEP #$20              ; {77614}
    JSR $&code_01303A     ; {77616}
    LDA $1B84             ; {77619}
    BNE loc_012F3B        ; {77622}
    BRL loc_012D6E        ; {77624}

  loc_012F3B:
    PLX                   ; {77627}
    LDA $7F7080, X        ; {77628}
    CMP #$04              ; {77632}
    BNE loc_012F51        ; {77634}
    LDA $1B84             ; {77636}
    BEQ loc_012F19        ; {77639}
    JSR $&code_0130CA     ; {77641}
    JSR $&code_013080     ; {77644}
    BRA loc_012F5B        ; {77647}

  loc_012F51:
    REP #$20              ; {77649}
    TXA                   ; {77651}
    CLC                   ; {77652}
    ADC #$0080            ; {77653}
    TAX                   ; {77656}
    SEP #$20              ; {77657}

  loc_012F5B:
    PHX                   ; {77659}
    BRL loc_012C6D        ; {77660}

  loc_012F5F:
    JSR $&code_01314A     ; {77663}

  loc_012F62:
    PLX                   ; {77666}
    STX $03F3             ; {77667}
    LDA #$01              ; {77670}
    TSB $vram_upload_flags ; {77672}
    PLB                   ; {77675}
    PLP                   ; {77676}
    RTL                   ; {77677}
}

code_012F6E {
    LDA $0000, Y          ; {77678}
    BMI loc_012F75        ; {77681}
    INY                   ; {77683}
    RTS                   ; {77684}

  loc_012F75:
    INY                   ; {77685}
    PHB                   ; {77686}
    PHY                   ; {77687}
    REP #$20              ; {77688}
    AND #$007F            ; {77690}
    PHA                   ; {77693}
    ASL                   ; {77694}
    CLC                   ; {77695}
    ADC $01, S            ; {77696}
    ASL                   ; {77698}
    ASL                   ; {77699}
    TAY                   ; {77700}
    PLA                   ; {77701}
    SEP #$20              ; {77702}
    LDA #$^string_lookup_080000.lookup_080000 ; {77704}
    PHA                   ; {77706}
    PLB                   ; {77707}
    LDA #$0C              ; {77708}
    STA $14               ; {77710}
    LDA $03E9             ; {77712}
    XBA                   ; {77715}

  loc_012F94:
    LDA $&string_lookup_080000.lookup_080000, Y ; {77716}
    BEQ loc_012FBD        ; {77719}
    INY                   ; {77721}
    ORA $03F9             ; {77722}
    REP #$20              ; {77725}
    STA $bg3_tilemap_buffer, X ; {77727}
    INX                   ; {77731}
    INX                   ; {77732}
    BIT #$0200            ; {77733}
    BNE loc_012FB4        ; {77736}
    ORA #$0100            ; {77738}
    STA $7F6FBE, X        ; {77741}
    AND #$FEFF            ; {77745}

  loc_012FB4:
    SEP #$20              ; {77748}
    JSR $&code_013124     ; {77750}
    DEC $14               ; {77753}
    BNE loc_012F94        ; {77755}

  loc_012FBD:
    LDA #$20              ; {77757}
    ORA $03F9             ; {77759}
    REP #$20              ; {77762}
    STA $bg3_tilemap_buffer, X ; {77764}
    INX                   ; {77768}
    INX                   ; {77769}
    BIT #$0200            ; {77770}
    BNE loc_012FD9        ; {77773}
    ORA #$0100            ; {77775}
    STA $7F6FBE, X        ; {77778}
    AND #$FEFF            ; {77782}

  loc_012FD9:
    SEP #$20              ; {77785}
    PLY                   ; {77787}
    PLB                   ; {77788}
    BRA code_012F6E       ; {77789}
}

code_012FDF {
    LDA $0000, Y          ; {77791}
    BMI loc_013009        ; {77794}
    BNE loc_012FE7        ; {77796}
    RTS                   ; {77798}

  loc_012FE7:
    INY                   ; {77799}
    ORA $03F9             ; {77800}
    REP #$20              ; {77803}
    STA $bg3_tilemap_buffer, X ; {77805}
    INX                   ; {77809}
    INX                   ; {77810}
    BIT #$0200            ; {77811}
    BNE loc_013002        ; {77814}
    ORA #$0100            ; {77816}
    STA $7F6FBE, X        ; {77819}
    AND #$FEFF            ; {77823}

  loc_013002:
    SEP #$20              ; {77826}
    JSR $&code_013124     ; {77828}
    BRA code_012FDF       ; {77831}

  loc_013009:
    JSR $&code_012F6E     ; {77833}
    DEY                   ; {77836}
    BRA code_012FDF       ; {77837}
}

code_01300F {
    REP #$20              ; {77839}
    LDX $03EB             ; {77841}
    LDA $03EF             ; {77844}
    STA $0E               ; {77847}

  loc_013019:
    LDA $03ED             ; {77849}
    STA $0C               ; {77852}
    PHX                   ; {77854}
    LDA #$2020            ; {77855}

  loc_013022:
    STA $bg3_tilemap_buffer, X ; {77858}
    INX                   ; {77862}
    INX                   ; {77863}
    DEC $0C               ; {77864}
    BNE loc_013022        ; {77866}
    PLX                   ; {77868}
    TXA                   ; {77869}
    CLC                   ; {77870}
    ADC #$0040            ; {77871}
    TAX                   ; {77874}
    DEC $0E               ; {77875}
    BNE loc_013019        ; {77877}
    SEP #$20              ; {77879}
    RTS                   ; {77881}
}

code_01303A {
    LDA #$3D              ; {77882}

  loc_01303C:
    STA $bg3_tilemap_buffer, X ; {77884}
    LDA #$01              ; {77888}
    STA $vram_upload_flags ; {77890}
    JSR $&code_013161     ; {77893}
    BIT #$C0              ; {77896}
    BEQ loc_013069        ; {77898}
    LDA $frame_counter    ; {77900}
    AND #$10              ; {77903}
    BNE code_01303A       ; {77905}
    LDA #$20              ; {77907}
    BRA loc_01303C        ; {77909}

  loc_013057:
    LDA #$3D              ; {77911}

  loc_013059:
    STA $bg3_tilemap_buffer, X ; {77913}
    LDA #$01              ; {77917}
    STA $vram_upload_flags ; {77919}
    JSR $&code_013161     ; {77922}
    BIT #$C0              ; {77925}
    BNE loc_013074        ; {77927}

  loc_013069:
    LDA $frame_counter    ; {77929}
    AND #$10              ; {77932}
    BNE loc_013057        ; {77934}
    LDA #$20              ; {77936}
    BRA loc_013059        ; {77938}

  loc_013074:
    LDA #$20              ; {77940}
    STA $bg3_tilemap_buffer, X ; {77942}
    LDA #$01              ; {77946}
    STA $vram_upload_flags ; {77948}
    RTS                   ; {77951}
}

code_013080 {
    REP #$20              ; {77952}
    PHX                   ; {77954}
    LDX $03EB             ; {77955}
    LDA $03EF             ; {77958}
    SEC                   ; {77961}
    SBC #$0003            ; {77962}
    BEQ loc_0130B0        ; {77965}
    STA $0E               ; {77967}

  loc_013091:
    LDA $03ED             ; {77969}
    STA $0C               ; {77972}
    PHX                   ; {77974}

  loc_013097:
    LDA $7F7080, X        ; {77975}
    STA $bg3_tilemap_buffer, X ; {77979}
    INX                   ; {77983}
    INX                   ; {77984}
    DEC $0C               ; {77985}
    BNE loc_013097        ; {77987}
    PLX                   ; {77989}
    TXA                   ; {77990}
    CLC                   ; {77991}
    ADC #$0040            ; {77992}
    TAX                   ; {77995}
    DEC $0E               ; {77996}
    BNE loc_013091        ; {77998}

  loc_0130B0:
    LDA $03ED             ; {78000}
    STA $0C               ; {78003}
    LDA #$2020            ; {78005}

  loc_0130B8:
    STA $bg3_tilemap_buffer, X ; {78008}
    STA $7F7040, X        ; {78012}
    INX                   ; {78016}
    INX                   ; {78017}
    DEC $0C               ; {78018}
    BNE loc_0130B8        ; {78020}
    PLX                   ; {78022}
    SEP #$20              ; {78023}
    RTS                   ; {78025}
}

code_0130CA {
    PHX                   ; {78026}
    PHY                   ; {78027}

  loc_0130CC:
    LDA $7F6FFE, X        ; {78028}
    CMP #$07              ; {78032}
    BEQ loc_0130D8        ; {78034}
    DEX                   ; {78036}
    DEX                   ; {78037}
    BRA loc_0130CC        ; {78038}

  loc_0130D8:
    LDA $7F6FC0, X        ; {78040}
    CMP #$03              ; {78044}
    BEQ loc_0130EC        ; {78046}
    REP #$20              ; {78048}
    TXA                   ; {78050}
    SEC                   ; {78051}
    SBC #$0040            ; {78052}
    TAX                   ; {78055}
    SEP #$20              ; {78056}
    BRA loc_0130D8        ; {78058}

  loc_0130EC:
    STX $03EB             ; {78060}
    STZ $00               ; {78063}

  loc_0130F1:
    LDA $bg3_tilemap_buffer, X ; {78065}
    CMP #$08              ; {78069}
    BEQ loc_0130FF        ; {78071}
    INX                   ; {78073}
    INX                   ; {78074}
    INC $00               ; {78075}
    BRA loc_0130F1        ; {78077}

  loc_0130FF:
    LDA $00               ; {78079}
    STA $03ED             ; {78081}
    STZ $00               ; {78084}

  loc_013106:
    LDA $bg3_tilemap_buffer, X ; {78086}
    CMP #$06              ; {78090}
    BEQ loc_01311C        ; {78092}
    REP #$20              ; {78094}
    TXA                   ; {78096}
    CLC                   ; {78097}
    ADC #$0040            ; {78098}
    TAX                   ; {78101}
    SEP #$20              ; {78102}
    INC $00               ; {78104}
    BRA loc_013106        ; {78106}

  loc_01311C:
    LDA $00               ; {78108}
    STA $03EF             ; {78110}
    PLY                   ; {78113}
    PLX                   ; {78114}
    RTS                   ; {78115}
}

code_013124 {
    AND #$7F              ; {78116}
    CMP #$20              ; {78118}
    BNE loc_01312B        ; {78120}
    RTS                   ; {78122}

  loc_01312B:
    LDA #$01              ; {78123}
    TSB $vram_upload_flags ; {78125}
    LDA $1B84             ; {78128}
    JSL $@code_013140     ; {78131}
    LDA $03F5             ; {78135}
    BNE loc_01313D        ; {78138}
    RTS                   ; {78140}

  loc_01313D:
    BRK #$07              ; {78141}
    RTS                   ; {78143}
}

code_013140 {
    BEQ loc_013149        ; {78144}
    JSL $@engine_000000.code_0001BE ; {78146}
    DEC                   ; {78150}
    BRA code_013140       ; {78151}

  loc_013149:
    RTL                   ; {78153}
}

code_01314A {
    JSR $&code_013161     ; {78154}
    BIT #$CF              ; {78157}
    BNE code_01314A       ; {78159}

  loc_013151:
    JSR $&code_013161     ; {78161}
    BIT #$CF              ; {78164}
    BEQ loc_013151        ; {78166}
    LDA #$C0              ; {78168}
    TRB $032B             ; {78170}
    STZ $0323             ; {78173}
    RTS                   ; {78176}
}

code_013161 {
    JSL $@engine_000000.code_0001BE ; {78177}
    LDA $0323             ; {78181}
    RTS                   ; {78184}
}

code_013169 {
    LDA $03D2             ; {78185}
    BEQ code_013161       ; {78188}
    JSL $@lib_shared_0131B7.code_0131B7 ; {78190}
    LDA $0323             ; {78194}
    RTS                   ; {78197}
}