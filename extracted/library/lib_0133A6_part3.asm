?BANK 02

?INCLUDE 'asset_list_028000'
?INCLUDE 'common_shared_0FEEA6'
?INCLUDE 'lib_0133A6_part1'
?INCLUDE 'lib_0133A6_part2'
?INCLUDE 'lib_0133A6_part4'
?INCLUDE 'lib_shared_0131D1'

!area_current                   0314
!scene_current                  0316
!map_width_px                   0342
!map_height_px                  0344
!location_id                    1C6A
!INIDISP                        2100
!OBJSEL                         2101
!OAMADDL                        2102
!OAMADDH                        2103
!BGMODE                         2105
!MOSAIC                         2106
!BG1SC                          2107
!BG2SC                          2108
!BG3SC                          2109
!BG4SC                          210A
!BG12NBA                        210B
!BG34NBA                        210C
!BG1HOFS                        210D
!BG1VOFS                        210E
!BG2HOFS                        210F
!BG2VOFS                        2110
!BG3HOFS                        2111
!BG3VOFS                        2112
!BG4HOFS                        2113
!BG4VOFS                        2114
!VMAIN                          2115
!VMADDL                         2116
!VMADDH                         2117
!VMDATAL                        2118
!VMDATAH                        2119
!M7SEL                          211A
!M7A                            211B
!M7B                            211C
!M7C                            211D
!M7D                            211E
!M7X                            211F
!M7Y                            2120
!CGADD                          2121
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!WH0                            2126
!WH1                            2127
!WH2                            2128
!WH3                            2129
!WBGLOG                         212A
!WOBJLOG                        212B
!TM                             212C
!TS                             212D
!TMW                            212E
!TSW                            212F
!CGWSEL                         2130
!CGADSUB                        2131
!COLDATA                        2132
!SETINI                         2133
!APUIO0                         2140
!NMITIMEN                       4200
!WRIO                           4201
!WRMPYA                         4202
!WRMPYB                         4203
!WRDIVL                         4204
!WRDIVH                         4205
!WRDIVB                         4206
!HTIMEL                         4207
!HTIMEH                         4208
!VTIMEL                         4209
!VTIMEH                         420A
!MDMAEN                         420B
!HDMAEN                         420C
!MEMSEL                         420D
!cgram_buffer                   7F0000

---------------------------------------------

code_013272 {
    PHP                   ; {78450}
    PHB                   ; {78451}
    PHX                   ; {78452}
    PHY                   ; {78453}
    REP #$10              ; {78454}
    SEP #$20              ; {78456}
    LDA #$7E              ; {78458}
    PHA                   ; {78460}
    PLB                   ; {78461}
    LDX #$0100            ; {78462}
    STX $1F               ; {78465}
    STX $21               ; {78467}
    LDA #$20              ; {78469}

  loc_013287:
    STA ($1F)             ; {78471}
    INC $1F               ; {78473}
    BNE loc_013287        ; {78475}
    LDA #$EF              ; {78477}
    STA $1F               ; {78479}
    LDA #$80              ; {78481}
    STA $1E               ; {78483}
    LDX $25               ; {78485}
    LDY $23               ; {78487}

  loc_013299:
    LDA [$29]             ; {78489}
    AND $1E               ; {78491}
    PHA                   ; {78493}
    LSR $1E               ; {78494}
    BCC loc_0132AA        ; {78496}
    ROR $1E               ; {78498}
    INC $29               ; {78500}
    BNE loc_0132AA        ; {78502}
    INC $2A               ; {78504}

  loc_0132AA:
    PLA                   ; {78506}
    BEQ loc_0132BD        ; {78507}
    JSR $&code_0132E2     ; {78509}
    STA $0000, X          ; {78512}
    INX                   ; {78515}
    STA ($1F)             ; {78516}
    INC $1F               ; {78518}
    DEY                   ; {78520}
    BNE loc_013299        ; {78521}
    BRA loc_0132DD        ; {78523}

  loc_0132BD:
    JSR $&code_0132E2     ; {78525}
    STA $21               ; {78528}
    JSR $&code_01333F     ; {78530}
    INC                   ; {78533}
    INC                   ; {78534}

  loc_0132C7:
    XBA                   ; {78535}
    LDA ($21)             ; {78536}
    INC $21               ; {78538}
    STA ($1F)             ; {78540}
    INC $1F               ; {78542}
    STA $0000, X          ; {78544}
    INX                   ; {78547}
    DEY                   ; {78548}
    BEQ loc_0132DD        ; {78549}
    XBA                   ; {78551}
    DEC                   ; {78552}
    BNE loc_0132C7        ; {78553}
    BRA loc_013299        ; {78555}

  loc_0132DD:
    PLY                   ; {78557}
    PLX                   ; {78558}
    PLB                   ; {78559}
    PLP                   ; {78560}
    RTL                   ; {78561}
}

code_0132E2 {
    LDA $1E               ; {78562}
    BMI loc_013329        ; {78564}
    ASL                   ; {78566}
    BMI loc_013322        ; {78567}
    ASL                   ; {78569}
    BMI loc_01331B        ; {78570}
    ASL                   ; {78572}
    BMI loc_013314        ; {78573}
    ASL                   ; {78575}
    BMI loc_01330D        ; {78576}
    ASL                   ; {78578}
    BMI loc_013306        ; {78579}
    ASL                   ; {78581}
    BMI loc_0132FF        ; {78582}
    REP #$20              ; {78584}
    LDA [$29]             ; {78586}
    XBA                   ; {78588}
    BRA loc_013332        ; {78589}

  loc_0132FF:
    REP #$20              ; {78591}
    LDA [$29]             ; {78593}
    XBA                   ; {78595}
    BRA loc_013333        ; {78596}

  loc_013306:
    REP #$20              ; {78598}
    LDA [$29]             ; {78600}
    XBA                   ; {78602}
    BRA loc_013334        ; {78603}

  loc_01330D:
    REP #$20              ; {78605}
    LDA [$29]             ; {78607}
    XBA                   ; {78609}
    BRA loc_013335        ; {78610}

  loc_013314:
    REP #$20              ; {78612}
    LDA [$29]             ; {78614}
    XBA                   ; {78616}
    BRA loc_013336        ; {78617}

  loc_01331B:
    REP #$20              ; {78619}
    LDA [$29]             ; {78621}
    XBA                   ; {78623}
    BRA loc_013337        ; {78624}

  loc_013322:
    REP #$20              ; {78626}
    LDA [$29]             ; {78628}
    XBA                   ; {78630}
    BRA loc_013338        ; {78631}

  loc_013329:
    LDA [$29]             ; {78633}
    REP #$20              ; {78635}
    INC $29               ; {78637}
    SEP #$20              ; {78639}
    RTS                   ; {78641}

  loc_013332:
    ASL                   ; {78642}

  loc_013333:
    ASL                   ; {78643}

  loc_013334:
    ASL                   ; {78644}

  loc_013335:
    ASL                   ; {78645}

  loc_013336:
    ASL                   ; {78646}

  loc_013337:
    ASL                   ; {78647}

  loc_013338:
    ASL                   ; {78648}
    INC $29               ; {78649}
    XBA                   ; {78651}
    SEP #$20              ; {78652}
    RTS                   ; {78654}
}

code_01333F {
    LDA $1E               ; {78655}
    CMP #$10              ; {78657}
    BCC loc_013361        ; {78659}
    LSR                   ; {78661}
    LSR                   ; {78662}
    LSR                   ; {78663}
    LSR                   ; {78664}
    STA $1E               ; {78665}
    XBA                   ; {78667}
    LDA [$29]             ; {78668}
    XBA                   ; {78670}
    REP #$20              ; {78671}
    LSR                   ; {78673}
    BCS loc_01335B        ; {78674}
    LSR                   ; {78676}
    BCS loc_01335B        ; {78677}
    LSR                   ; {78679}
    BCS loc_01335B        ; {78680}
    LSR                   ; {78682}

  loc_01335B:
    SEP #$20              ; {78683}
    XBA                   ; {78685}
    AND #$0F              ; {78686}
    RTS                   ; {78688}

  loc_013361:
    LSR                   ; {78689}
    BCS loc_013392        ; {78690}
    LSR                   ; {78692}
    BCS loc_013385        ; {78693}
    LSR                   ; {78695}
    BCS loc_013379        ; {78696}
    LDA #$80              ; {78698}
    STA $1E               ; {78700}
    LDA [$29]             ; {78702}
    REP #$20              ; {78704}
    INC $29               ; {78706}
    SEP #$20              ; {78708}
    AND #$0F              ; {78710}
    RTS                   ; {78712}

  loc_013379:
    LDA #$40              ; {78713}
    STA $1E               ; {78715}
    REP #$20              ; {78717}
    LDA [$29]             ; {78719}
    XBA                   ; {78721}
    ASL                   ; {78722}
    BRA loc_01339E        ; {78723}

  loc_013385:
    LDA #$20              ; {78725}
    STA $1E               ; {78727}
    REP #$20              ; {78729}
    LDA [$29]             ; {78731}
    XBA                   ; {78733}
    ASL                   ; {78734}
    ASL                   ; {78735}
    BRA loc_01339E        ; {78736}

  loc_013392:
    LDA #$10              ; {78738}
    STA $1E               ; {78740}
    REP #$20              ; {78742}
    LDA [$29]             ; {78744}
    XBA                   ; {78746}
    ASL                   ; {78747}
    ASL                   ; {78748}
    ASL                   ; {78749}

  loc_01339E:
    INC $29               ; {78750}
    SEP #$20              ; {78752}
    XBA                   ; {78754}
    AND #$0F              ; {78755}
    RTS                   ; {78757}
}

code_0133A6 {
    PHP                   ; {78758}
    SEP #$20              ; {78759}
    REP #$10              ; {78761}
    JSR $&code_0133FF     ; {78763}

  loc_0133AE:
    JSR $&code_01393F     ; {78766}
    CMP #$00              ; {78769}
    BEQ loc_0133FD        ; {78771}
    BIT #$80              ; {78773}
    BEQ loc_0133BE        ; {78775}
    JSR $&code_01343F     ; {78777}
    BRA loc_0133AE        ; {78780}

  loc_0133BE:
    BIT #$40              ; {78782}
    BEQ loc_0133C7        ; {78784}
    JSR $&code_013532     ; {78786}
    BRA loc_0133AE        ; {78789}

  loc_0133C7:
    BIT #$20              ; {78791}
    BEQ loc_0133D0        ; {78793}
    JSR $&code_013571     ; {78795}
    BRA loc_0133AE        ; {78798}

  loc_0133D0:
    BIT #$10              ; {78800}
    BEQ loc_0133D9        ; {78802}
    JSR $&code_01362B     ; {78804}
    BRA loc_0133AE        ; {78807}

  loc_0133D9:
    BIT #$08              ; {78809}
    BEQ loc_0133E2        ; {78811}
    JSR $&code_013759     ; {78813}
    BRA loc_0133AE        ; {78816}

  loc_0133E2:
    BIT #$04              ; {78818}
    BEQ loc_0133EB        ; {78820}
    JSR $&code_013894     ; {78822}
    BRA loc_0133AE        ; {78825}

  loc_0133EB:
    BIT #$02              ; {78827}
    BEQ loc_0133F4        ; {78829}
    JSR $&code_01389E     ; {78831}
    BRA loc_0133AE        ; {78834}

  loc_0133F4:
    BIT #$01              ; {78836}
    BEQ loc_0133AE        ; {78838}
    JSR $&code_0138FB     ; {78840}
    BRA loc_0133AE        ; {78843}

  loc_0133FD:
    PLP                   ; {78845}
    RTL                   ; {78846}
}

code_0133FF {
    LDY #$0000            ; {78847}

  loc_013402:
    LDA [$2F], Y          ; {78850}
    INY                   ; {78852}
    XBA                   ; {78853}
    LDA [$2F], Y          ; {78854}
    INY                   ; {78856}
    CMP $scene_current    ; {78857}
    BNE loc_013415        ; {78860}
    XBA                   ; {78862}
    CMP $area_current     ; {78863}
    BNE loc_013415        ; {78866}
    RTS                   ; {78868}

  loc_013415:
    JSR $&code_01393F     ; {78869}
    CMP #$00              ; {78872}
    BEQ loc_013402        ; {78874}
    ASL                   ; {78876}
    BCS loc_013437        ; {78877}
    ASL                   ; {78879}
    BCS loc_013437        ; {78880}
    ASL                   ; {78882}
    BCS loc_013436        ; {78883}
    ASL                   ; {78885}
    BCS loc_013439        ; {78886}
    ASL                   ; {78888}
    BCS loc_01343C        ; {78889}
    ASL                   ; {78891}
    BCS loc_01343A        ; {78892}
    ASL                   ; {78894}
    BCS loc_013438        ; {78895}
    ASL                   ; {78897}
    BCS loc_013437        ; {78898}
    BRA loc_0134AA        ; {78900}

  loc_013436:
    INY                   ; {78902}

  loc_013437:
    INY                   ; {78903}

  loc_013438:
    INY                   ; {78904}

  loc_013439:
    INY                   ; {78905}

  loc_01343A:
    INY                   ; {78906}
    INY                   ; {78907}

  loc_01343C:
    INY                   ; {78908}
    BRA loc_013415        ; {78909}
}

code_01343F {
    LDA $03B4             ; {78911}
    BIT #$08              ; {78914}
    BEQ loc_01344D        ; {78916}
    INY                   ; {78918}
    INY                   ; {78919}
    INY                   ; {78920}
    INY                   ; {78921}
    INY                   ; {78922}
    INY                   ; {78923}
    RTS                   ; {78924}

  loc_01344D:
    PHP                   ; {78925}
    REP #$20              ; {78926}
    JSR $&code_01393F     ; {78928}
    XBA                   ; {78931}
    STA $00               ; {78932}
    JSR $&code_01393F     ; {78934}
    XBA                   ; {78937}
    ASL                   ; {78938}
    STA $02               ; {78939}
    JSR $&code_01393F     ; {78941}
    PHA                   ; {78944}
    XBA                   ; {78945}
    CLC                   ; {78946}
    ADC #$0000            ; {78947}
    STA $VMADDL           ; {78950}
    LDX #$0029            ; {78953}
    JSR $&code_013731     ; {78956}
    LDA $01, S            ; {78959}
    BEQ loc_013484        ; {78961}
    CMP #$0010            ; {78963}
    BEQ loc_01348E        ; {78966}
    CMP #$0020            ; {78968}
    BEQ loc_013498        ; {78971}
    CMP #$0030            ; {78973}
    BEQ loc_0134A2        ; {78976}
    BRA loc_0134AD        ; {78978}

  loc_013484:
    LDX #$0407            ; {78980}
    JSR $&code_013983     ; {78983}
    BCS loc_0134B9        ; {78986}
    BRA loc_0134AA        ; {78988}

  loc_01348E:
    LDX #$040A            ; {78990}
    JSR $&code_013983     ; {78993}
    BCS loc_0134B9        ; {78996}
    BRA loc_0134AA        ; {78998}

  loc_013498:
    LDX #$040D            ; {79000}
    JSR $&code_013983     ; {79003}
    BCS loc_0134B9        ; {79006}
    BRA loc_0134AA        ; {79008}

  loc_0134A2:
    LDX #$0410            ; {79010}
    JSR $&code_013983     ; {79013}
    BCS loc_0134B9        ; {79016}

  loc_0134AA:
    PLA                   ; {79018}
    PLP                   ; {79019}
    RTS                   ; {79020}

  loc_0134AD:
    STZ $0407             ; {79021}
    STZ $040A             ; {79024}
    STZ $040D             ; {79027}
    STZ $0410             ; {79030}

  loc_0134B9:
    ASL $00               ; {79033}
    BCC loc_0134F0        ; {79035}
    PLA                   ; {79037}
    CMP #$00FF            ; {79038}
    BEQ loc_0134D4        ; {79041}
    PHY                   ; {79043}
    LDY $00               ; {79044}

  loc_0134C6:
    LDA [$29], Y          ; {79046}
    STA $VMDATAL          ; {79048}
    INY                   ; {79051}
    INY                   ; {79052}
    CPY $02               ; {79053}
    BNE loc_0134C6        ; {79055}
    PLY                   ; {79057}
    PLP                   ; {79058}
    RTS                   ; {79059}

  loc_0134D4:
    LDX #$0000            ; {79060}
    STX $VMADDL           ; {79063}
    PHY                   ; {79066}
    SEP #$20              ; {79067}
    LDY #$0000            ; {79069}

  loc_0134E0:
    LDA [$29], Y          ; {79072}
    STA $VMDATAH          ; {79074}
    INY                   ; {79077}
    CPY #$4000            ; {79078}
    BNE loc_0134E0        ; {79081}
    REP #$20              ; {79083}
    PLY                   ; {79085}
    PLP                   ; {79086}
    RTS                   ; {79087}

  loc_0134F0:
    LDA [$29]             ; {79088}
    STA $23               ; {79090}
    INC $29               ; {79092}
    INC $29               ; {79094}
    LDX #$6000            ; {79096}
    STX $25               ; {79099}
    JSL $@code_013272     ; {79101}
    PLA                   ; {79105}
    CMP #$00FF            ; {79106}
    BEQ loc_013518        ; {79109}
    LDX $00               ; {79111}

  loc_013509:
    LDA $7E6000, X        ; {79113}
    STA $VMDATAL          ; {79117}
    INX                   ; {79120}
    INX                   ; {79121}
    CPX $02               ; {79122}
    BNE loc_013509        ; {79124}
    PLP                   ; {79126}
    RTS                   ; {79127}

  loc_013518:
    LDX #$0000            ; {79128}
    STX $VMADDL           ; {79131}
    SEP #$20              ; {79134}
    LDX #$0000            ; {79136}

  loc_013523:
    LDA $7E6000, X        ; {79139}
    STA $VMDATAH          ; {79143}
    INX                   ; {79146}
    CPX #$4000            ; {79147}
    BNE loc_013523        ; {79150}
    PLP                   ; {79152}
    RTS                   ; {79153}
}

code_013532 {
    LDA $03B4             ; {79154}
    BIT #$04              ; {79157}
    BEQ loc_013540        ; {79159}
    INY                   ; {79161}
    INY                   ; {79162}
    INY                   ; {79163}
    INY                   ; {79164}
    INY                   ; {79165}
    INY                   ; {79166}
    RTS                   ; {79167}

  loc_013540:
    PHP                   ; {79168}
    REP #$20              ; {79169}
    JSR $&code_01393F     ; {79171}
    ASL                   ; {79174}
    STA $00               ; {79175}
    JSR $&code_01393F     ; {79177}
    ASL                   ; {79180}
    STA $02               ; {79181}
    JSR $&code_01393F     ; {79183}
    ASL                   ; {79186}
    STA $04               ; {79187}
    LDX #$0029            ; {79189}
    JSR $&code_013731     ; {79192}
    PHY                   ; {79195}
    LDY $00               ; {79196}
    LDX $04               ; {79198}

  loc_013560:
    LDA [$29], Y          ; {79200}
    STA $cgram_buffer, X  ; {79202}
    INY                   ; {79206}
    INY                   ; {79207}
    INX                   ; {79208}
    INX                   ; {79209}
    CPY $02               ; {79210}
    BNE loc_013560        ; {79212}
    PLY                   ; {79214}
    PLP                   ; {79215}
    RTS                   ; {79216}
}

code_013571 {
    LDA $03B4             ; {79217}
    BIT #$02              ; {79220}
    BEQ loc_013580        ; {79222}
    INY                   ; {79224}
    INY                   ; {79225}
    INY                   ; {79226}
    INY                   ; {79227}
    INY                   ; {79228}
    INY                   ; {79229}
    INY                   ; {79230}
    RTS                   ; {79231}

  loc_013580:
    PHP                   ; {79232}
    REP #$20              ; {79233}
    JSR $&code_01393F     ; {79235}
    XBA                   ; {79238}
    STA $06               ; {79239}
    AND #$7FFF            ; {79241}
    LSR                   ; {79244}
    LSR                   ; {79245}
    STA $00               ; {79246}
    JSR $&code_01393F     ; {79248}
    XBA                   ; {79251}
    LSR                   ; {79252}
    LSR                   ; {79253}
    STA $02               ; {79254}
    JSR $&code_01393F     ; {79256}
    XBA                   ; {79259}
    LSR                   ; {79260}
    LSR                   ; {79261}
    STA $04               ; {79262}
    JSR $&code_01393F     ; {79264}
    PHA                   ; {79267}
    LDX #$0029            ; {79268}
    JSR $&code_013731     ; {79271}
    LDA $01, S            ; {79274}
    CMP #$0001            ; {79276}
    BEQ loc_0135B8        ; {79279}
    CMP #$0002            ; {79281}
    BEQ loc_0135C2        ; {79284}
    BRA loc_0135CD        ; {79286}

  loc_0135B8:
    LDX #$0413            ; {79288}
    JSR $&code_013983     ; {79291}
    BCS loc_0135D3        ; {79294}
    BRA loc_0135CA        ; {79296}

  loc_0135C2:
    LDX #$0416            ; {79298}
    JSR $&code_013983     ; {79301}
    BCS loc_0135D3        ; {79304}

  loc_0135CA:
    PLA                   ; {79306}
    PLP                   ; {79307}
    RTS                   ; {79308}

  loc_0135CD:
    STZ $0413             ; {79309}
    STZ $0416             ; {79312}

  loc_0135D3:
    LDA $06               ; {79315}
    BPL loc_0135EE        ; {79317}
    LDA #$6000            ; {79319}
    STA $2C               ; {79322}
    PHY                   ; {79324}
    LDY #$0000            ; {79325}

  loc_0135E0:
    LDA [$29], Y          ; {79328}
    STA [$2C], Y          ; {79330}
    INY                   ; {79332}
    INY                   ; {79333}
    CPY #$0800            ; {79334}
    BNE loc_0135E0        ; {79337}
    PLY                   ; {79339}
    BRA loc_0135FF        ; {79340}

  loc_0135EE:
    LDA [$29]             ; {79342}
    STA $23               ; {79344}
    INC $29               ; {79346}
    INC $29               ; {79348}
    LDX #$6000            ; {79350}
    STX $25               ; {79353}
    JSL $@code_013272     ; {79355}

  loc_0135FF:
    PLA                   ; {79359}
    LDX #$2000            ; {79360}
    JSR $&code_01360E     ; {79363}
    LDX #$2800            ; {79366}
    JSR $&code_01360E     ; {79369}
    PLP                   ; {79372}
    RTS                   ; {79373}
}

code_01360E {
    LSR                   ; {79374}
    BCC loc_01362A        ; {79375}
    PHA                   ; {79377}
    PHY                   ; {79378}
    STX $2C               ; {79379}
    LDX $00               ; {79381}
    LDY $04               ; {79383}

  loc_013619:
    LDA $7E6000, X        ; {79385}
    XBA                   ; {79389}
    STA [$2C], Y          ; {79390}
    INX                   ; {79392}
    INX                   ; {79393}
    INY                   ; {79394}
    INY                   ; {79395}
    CPX $02               ; {79396}
    BNE loc_013619        ; {79398}
    PLY                   ; {79400}
    PLA                   ; {79401}

  loc_01362A:
    RTS                   ; {79402}
}

code_01362B {
    LDA $03B4             ; {79403}
    BIT #$01              ; {79406}
    BEQ loc_013637        ; {79408}
    INY                   ; {79410}
    INY                   ; {79411}
    INY                   ; {79412}
    INY                   ; {79413}
    RTS                   ; {79414}

  loc_013637:
    PHP                   ; {79415}
    REP #$20              ; {79416}
    JSR $&code_01393F     ; {79418}
    STA $04               ; {79421}
    LDX #$0029            ; {79423}
    JSR $&code_013731     ; {79426}
    LDA $04               ; {79429}
    CMP #$0001            ; {79431}
    BEQ loc_01365B        ; {79434}
    CMP #$0002            ; {79436}
    BNE loc_013665        ; {79439}
    LDX #$041C            ; {79441}
    JSR $&code_013983     ; {79444}
    BCS loc_01366B        ; {79447}
    PLP                   ; {79449}
    RTS                   ; {79450}

  loc_01365B:
    LDX #$0419            ; {79451}
    JSR $&code_013983     ; {79454}
    BCS loc_01366B        ; {79457}
    PLP                   ; {79459}
    RTS                   ; {79460}

  loc_013665:
    STZ $0419             ; {79461}
    STZ $041C             ; {79464}

  loc_01366B:
    LDA [$29]             ; {79467}
    INC $29               ; {79469}
    AND #$00FF            ; {79471}
    XBA                   ; {79474}
    STA $00               ; {79475}
    LDA [$29]             ; {79477}
    INC $29               ; {79479}
    AND #$00FF            ; {79481}
    XBA                   ; {79484}
    STA $02               ; {79485}
    SEP #$20              ; {79487}
    LDA $01               ; {79489}
    XBA                   ; {79491}
    LDA $03               ; {79492}
    JSL $@lib_shared_0131D1.code_0131D1 ; {79494}
    REP #$20              ; {79498}
    XBA                   ; {79500}
    STA $23               ; {79501}
    LDA $03               ; {79503}
    BMI loc_01369B        ; {79505}
    LDA [$29]             ; {79507}
    STA $23               ; {79509}
    INC $29               ; {79511}
    INC $29               ; {79513}

  loc_01369B:
    LDA $04               ; {79515}
    AND #$FF7F            ; {79517}
    BNE loc_0136A7        ; {79520}
    JSR $&code_0136EA     ; {79522}
    BRA loc_0136B7        ; {79525}

  loc_0136A7:
    LDX #$0000            ; {79527}
    JSR $&code_0136B9     ; {79530}
    BCS loc_0136B7        ; {79533}
    LDX #$0004            ; {79535}
    JSR $&code_0136B9     ; {79538}
    BCS loc_0136B7        ; {79541}

  loc_0136B7:
    PLP                   ; {79543}
    RTS                   ; {79544}
}

code_0136B9 {
    LSR                   ; {79545}
    BCC loc_0136E9        ; {79546}
    PHA                   ; {79548}
    PHY                   ; {79549}
    LDA $00               ; {79550}
    STA $map_width_px, X  ; {79552}
    LDA $02               ; {79555}
    STA $map_height_px, X ; {79557}
    LDY $0352, X          ; {79560}
    LDA $03               ; {79563}
    BPL loc_0136E0        ; {79565}
    STY $2C               ; {79567}
    LDY #$0000            ; {79569}

  loc_0136D4:
    LDA [$29], Y          ; {79572}
    STA [$2C], Y          ; {79574}
    INY                   ; {79576}
    INY                   ; {79577}
    CPY $23               ; {79578}
    BNE loc_0136D4        ; {79580}
    BRA loc_0136E6        ; {79582}

  loc_0136E0:
    STY $25               ; {79584}
    JSL $@code_013272     ; {79586}

  loc_0136E6:
    PLY                   ; {79590}
    PLA                   ; {79591}
    SEC                   ; {79592}

  loc_0136E9:
    RTS                   ; {79593}
}

code_0136EA {
    PHP                   ; {79594}
    PHY                   ; {79595}
    LDA $03               ; {79596}
    BPL loc_013705        ; {79598}
    LDY #$C000            ; {79600}
    STY $2C               ; {79603}
    LDY #$0000            ; {79605}

  loc_0136F8:
    LDA [$29], Y          ; {79608}
    STA [$2C], Y          ; {79610}
    INY                   ; {79612}
    INY                   ; {79613}
    CPY #$4000            ; {79614}
    BNE loc_0136F8        ; {79617}
    BRA loc_01370E        ; {79619}

  loc_013705:
    LDX #$C000            ; {79621}
    STX $25               ; {79624}
    JSL $@code_013272     ; {79626}

  loc_01370E:
    SEP #$20              ; {79630}
    LDX #$0000            ; {79632}
    STX $VMADDL           ; {79635}
    STZ $VMAIN            ; {79638}
    LDX #$0000            ; {79641}

  loc_01371C:
    LDA $7EC000, X        ; {79644}
    STA $VMDATAL          ; {79648}
    INX                   ; {79651}
    CPX #$4000            ; {79652}
    BNE loc_01371C        ; {79655}
    LDA #$80              ; {79657}
    STA $VMAIN            ; {79659}
    PLY                   ; {79662}
    PLP                   ; {79663}
    RTS                   ; {79664}
}

code_013731 {
    PHP                   ; {79665}
    REP #$20              ; {79666}
    LDA [$2F], Y          ; {79668}
    INY                   ; {79670}
    INY                   ; {79671}
    STA $29               ; {79672}
    SEP #$20              ; {79674}
    LDA [$2F], Y          ; {79676}
    INY                   ; {79678}
    STA $2B               ; {79679}
    REP #$20              ; {79681}
    LDA $0001, X          ; {79683}
    AND #$007F            ; {79686}
    PHA                   ; {79689}
    EOR $0001, X          ; {79690}
    ASL                   ; {79693}
    ORA #$0080            ; {79694}
    ORA $01, S            ; {79697}
    STA $0001, X          ; {79699}
    PLA                   ; {79702}
    PLP                   ; {79703}
    RTS                   ; {79704}
}

code_013759 {
    JSR $&code_01393F     ; {79705}
    BIT #$80              ; {79708}
    BEQ loc_01376B        ; {79710}
    BIT #$40              ; {79712}
    BEQ loc_013765        ; {79714}
    RTS                   ; {79716}

  loc_013765:
    ORA #$40              ; {79717}
    JSR $&code_01394A     ; {79719}
    RTS                   ; {79722}

  loc_01376B:
    STA $location_id      ; {79723}
    PHY                   ; {79726}
    REP #$20              ; {79727}
    AND #$00FF            ; {79729}
    ASL                   ; {79732}
    TAX                   ; {79733}
    LDA $@lib_0133A6_part4.binary_list_0168A1, X ; {79734}
    SEC                   ; {79738}
    SBC #$&lib_0133A6_part4.binary_list_0168A1 ; {79739}
    TAX                   ; {79742}
    SEP #$20              ; {79743}
    LDA $@lib_0133A6_part4.binary_list_0168A1, X ; {79745}
    STA $TM               ; {79749}
    STA $TMW              ; {79752}
    STA $03C0             ; {79755}
    LDA $@lib_0133A6_part4.binary_list_0168A1+1, X ; {79758}
    STA $TS               ; {79762}
    STA $TSW              ; {79765}
    LDA $@lib_0133A6_part4.binary_list_0168A1+2, X ; {79768}
    STA $CGWSEL           ; {79772}
    LDA $@lib_0133A6_part4.binary_list_0168A1+3, X ; {79775}
    STA $CGADSUB          ; {79779}
    STA $03C1             ; {79782}
    LDA $@lib_0133A6_part4.binary_list_0168A1+4, X ; {79785}
    AND #$30              ; {79789}
    STA $0373             ; {79791}
    LDA $@lib_0133A6_part4.binary_list_0168A1+4, X ; {79794}
    STZ $036B             ; {79798}
    STZ $036F             ; {79801}
    LDY #$2000            ; {79804}
    ROR                   ; {79807}
    BCC loc_0137C5        ; {79808}
    STY $036A             ; {79810}

  loc_0137C5:
    ROR                   ; {79813}
    BCC loc_0137CB        ; {79814}
    STY $036E             ; {79816}

  loc_0137CB:
    ROR                   ; {79819}
    ROR                   ; {79820}
    ROR                   ; {79821}
    ROR                   ; {79822}
    LDY #$00E0            ; {79823}
    ROR                   ; {79826}
    BCC loc_0137D8        ; {79827}
    LDY #$0100            ; {79829}

  loc_0137D8:
    STY $03CA             ; {79832}
    ROR                   ; {79835}
    BCS loc_0137E3        ; {79836}
    LDA #$01              ; {79838}
    TSB $036F             ; {79840}

  loc_0137E3:
    LDY #$FDFF            ; {79843}
    STY $035C             ; {79846}
    STY $0360             ; {79849}
    STZ $03DB             ; {79852}
    LDA $@lib_0133A6_part4.binary_list_0168A1+5, X ; {79855}
    BPL loc_0137F8        ; {79859}
    INC $03DB             ; {79861}

  loc_0137F8:
    LDA $03DB             ; {79864}
    BNE loc_01381A        ; {79867}
    LDA $@lib_0133A6_part4.binary_list_0168A1+5, X ; {79869}
    PHA                   ; {79873}
    AND #$03              ; {79874}
    CLC                   ; {79876}
    ADC #$60              ; {79877}
    STA $BG1SC            ; {79879}
    PLA                   ; {79882}
    LSR                   ; {79883}
    LSR                   ; {79884}
    AND #$03              ; {79885}
    CLC                   ; {79887}
    ADC #$70              ; {79888}
    STA $BG2SC            ; {79890}
    STA $03C2             ; {79893}
    BRA loc_013835        ; {79896}

  loc_01381A:
    LDA $@lib_0133A6_part4.binary_list_0168A1+5, X ; {79898}
    PHA                   ; {79902}
    AND #$03              ; {79903}
    CLC                   ; {79905}
    ADC #$70              ; {79906}
    STA $BG1SC            ; {79908}
    PLA                   ; {79911}
    LSR                   ; {79912}
    LSR                   ; {79913}
    AND #$03              ; {79914}
    CLC                   ; {79916}
    ADC #$60              ; {79917}
    STA $BG2SC            ; {79919}
    STA $03C2             ; {79922}

  loc_013835:
    LDA $@lib_0133A6_part4.binary_list_0168A1+6, X ; {79925}
    STA $BGMODE           ; {79929}
    PHX                   ; {79932}
    LDY #$0000            ; {79933}

  loc_013840:
    LDA $@lib_0133A6_part4.binary_list_0168A1+7, X ; {79936}
    AND #$0F              ; {79940}
    STA $034B, Y          ; {79942}
    LDA $@lib_0133A6_part4.binary_list_0168A1+7, X ; {79945}
    AND #$F0              ; {79949}
    LSR                   ; {79951}
    LSR                   ; {79952}
    LSR                   ; {79953}
    LSR                   ; {79954}
    STA $034A, Y          ; {79955}
    INX                   ; {79958}
    INY                   ; {79959}
    INY                   ; {79960}
    CPY #$0008            ; {79961}
    BNE loc_013840        ; {79964}
    PLX                   ; {79966}
    LDA $031E             ; {79967}
    BEQ loc_013866        ; {79970}
    BRA loc_01386C        ; {79972}

  loc_013866:
    JSL $@lib_0133A6_part1.code_011662 ; {79974}
    BCC loc_013874        ; {79978}

  loc_01386C:
    LDA $@lib_0133A6_part4.binary_list_0168A1+B, X ; {79980}
    AND #$3F              ; {79984}
    BRA loc_01387D        ; {79986}

  loc_013874:
    LDA $@lib_0133A6_part4.binary_list_0168A1+B, X ; {79988}
    BPL loc_01387D        ; {79992}
    INC $031E             ; {79994}

  loc_01387D:
    ASL                   ; {79997}
    BPL loc_013883        ; {79998}
    INC $031E             ; {80000}

  loc_013883:
    ASL                   ; {80003}
    BPL loc_013889        ; {80004}
    INC $0439             ; {80006}

  loc_013889:
    LDA $@lib_0133A6_part4.binary_list_0168A1+B, X ; {80009}
    AND #$0F              ; {80013}
    STA $03BA             ; {80015}
    PLY                   ; {80018}
    RTS                   ; {80019}
}

code_013894 {
    JSR $&code_01393F     ; {80020}
    JSR $&code_01393F     ; {80023}
    JSR $&code_01393F     ; {80026}
    RTS                   ; {80029}
}

code_01389E {
    LDA $03B4             ; {80030}
    BIT #$20              ; {80033}
    BEQ loc_0138AB        ; {80035}
    INY                   ; {80037}
    INY                   ; {80038}
    INY                   ; {80039}
    INY                   ; {80040}
    INY                   ; {80041}
    RTS                   ; {80042}

  loc_0138AB:
    JSR $&code_01393F     ; {80043}
    STA $031A             ; {80046}
    JSR $&code_01393F     ; {80049}
    STA $031C             ; {80052}
    LDX #$0029            ; {80055}
    JSR $&code_013731     ; {80058}
    LDA $031E             ; {80061}
    CMP $031C             ; {80064}
    BEQ loc_0138C6        ; {80067}
    RTS                   ; {80069}

  loc_0138C6:
    LDX #$0422            ; {80070}
    JSR $&code_013983     ; {80073}
    BCS loc_0138CF        ; {80076}
    RTS                   ; {80078}

  loc_0138CF:
    LDA #$F0              ; {80079}
    STA $APUIO0           ; {80081}

  loc_0138D4:
    LDA $APUIO0           ; {80084}
    BNE loc_0138D4        ; {80087}
    LDA #$02              ; {80089}
    JSL $@lib_0133A6_part2.code_0131C9 ; {80091}
    LDA #$FF              ; {80095}
    STA $APUIO0           ; {80097}
    LDA #$02              ; {80100}
    JSL $@lib_0133A6_part2.code_0131C9 ; {80102}
    JSL $@common_shared_0FEEA6.code_0FEFF5 ; {80106}
    LDA #$03              ; {80110}
    JSL $@lib_0133A6_part2.code_0131C9 ; {80112}
    LDA $031A             ; {80116}
    STA $APUIO0           ; {80119}
    RTS                   ; {80122}
}

code_0138FB {
    LDA $03B4             ; {80123}
    BIT #$10              ; {80126}
    BEQ loc_013909        ; {80128}
    INY                   ; {80130}
    INY                   ; {80131}
    INY                   ; {80132}
    INY                   ; {80133}
    INY                   ; {80134}
    INY                   ; {80135}
    RTS                   ; {80136}

  loc_013909:
    JSR $&code_01393F     ; {80137}
    PHA                   ; {80140}
    JSR $&code_01393F     ; {80141}
    JSR $&code_01393F     ; {80144}
    LDX #$0029            ; {80147}
    JSR $&code_013731     ; {80150}
    LDX #$041F            ; {80153}
    JSR $&code_013983     ; {80156}
    BCS loc_013923        ; {80159}
    PLA                   ; {80161}
    RTS                   ; {80162}

  loc_013923:
    REP #$20              ; {80163}
    LDA [$29]             ; {80165}
    STA $23               ; {80167}
    INC $29               ; {80169}
    INC $29               ; {80171}
    SEP #$20              ; {80173}
    LDX #$3800            ; {80175}
    PLA                   ; {80178}
    BEQ loc_013938        ; {80179}
    LDX #$F000            ; {80181}

  loc_013938:
    STX $25               ; {80184}
    JSL $@code_013272     ; {80186}
    RTS                   ; {80190}
}

code_01393F {
    PHP                   ; {80191}
    REP #$20              ; {80192}
    LDA [$2F], Y          ; {80194}
    INY                   ; {80196}
    AND #$00FF            ; {80197}
    PLP                   ; {80200}
    RTS                   ; {80201}
}

code_01394A {
    STA $00               ; {80202}
    LDY #$0000            ; {80204}

  loc_01394F:
    INY                   ; {80207}
    INY                   ; {80208}

  loc_013951:
    LDA [$2F], Y          ; {80209}
    INY                   ; {80211}
    CMP #$00              ; {80212}
    BEQ loc_01394F        ; {80214}
    ASL                   ; {80216}
    BCS loc_013973        ; {80217}
    ASL                   ; {80219}
    BCS loc_013973        ; {80220}
    ASL                   ; {80222}
    BCS loc_013972        ; {80223}
    ASL                   ; {80225}
    BCS loc_013975        ; {80226}
    ASL                   ; {80228}
    BCS loc_01397B        ; {80229}
    ASL                   ; {80231}
    BCS loc_013976        ; {80232}
    ASL                   ; {80234}
    BCS loc_013974        ; {80235}
    ASL                   ; {80237}
    BCS loc_013973        ; {80238}
    BRA loc_0139E6        ; {80240}

  loc_013972:
    INY                   ; {80242}

  loc_013973:
    INY                   ; {80243}

  loc_013974:
    INY                   ; {80244}

  loc_013975:
    INY                   ; {80245}

  loc_013976:
    INY                   ; {80246}
    INY                   ; {80247}
    INY                   ; {80248}
    BRA loc_013951        ; {80249}

  loc_01397B:
    LDA [$2F], Y          ; {80251}
    INY                   ; {80253}
    CMP $00               ; {80254}
    BNE loc_013951        ; {80256}
    RTS                   ; {80258}
}

code_013983 {
    PHP                   ; {80259}
    REP #$20              ; {80260}
    LDA $29               ; {80262}
    CMP $0000, X          ; {80264}
    BNE loc_01399B        ; {80267}
    SEP #$20              ; {80269}
    LDA $2B               ; {80271}
    CMP $0002, X          ; {80273}
    BNE loc_01399B        ; {80276}
    REP #$20              ; {80278}
    PLP                   ; {80280}
    CLC                   ; {80281}
    RTS                   ; {80282}

  loc_01399B:
    SEP #$20              ; {80283}
    LDA $2B               ; {80285}
    STA $0002, X          ; {80287}
    REP #$20              ; {80290}
    LDA $29               ; {80292}
    STA $0000, X          ; {80294}
    PLP                   ; {80297}
    SEC                   ; {80298}
    RTS                   ; {80299}
}

code_0139AC {
    PHP                   ; {80300}
    SEP #$20              ; {80301}
    REP #$10              ; {80303}
    LDA #$80              ; {80305}
    STA $INIDISP          ; {80307}
    STZ $OBJSEL           ; {80310}
    STZ $OAMADDL          ; {80313}
    STZ $OAMADDH          ; {80316}
    STZ $BGMODE           ; {80319}
    STZ $MOSAIC           ; {80322}
    STZ $BG1SC            ; {80325}
    STZ $BG2SC            ; {80328}
    STZ $BG3SC            ; {80331}
    STZ $BG4SC            ; {80334}
    STZ $BG12NBA          ; {80337}
    STZ $BG34NBA          ; {80340}
    STZ $BG1HOFS          ; {80343}
    STZ $BG1HOFS          ; {80346}
    STZ $BG1VOFS          ; {80349}
    STZ $BG1VOFS          ; {80352}
    STZ $BG2HOFS          ; {80355}

  loc_0139E6:
    STZ $BG2HOFS          ; {80358}
    STZ $BG2VOFS          ; {80361}
    STZ $BG2VOFS          ; {80364}
    STZ $BG3HOFS          ; {80367}
    STZ $BG3HOFS          ; {80370}
    STZ $BG3VOFS          ; {80373}
    STZ $BG3VOFS          ; {80376}
    STZ $BG4HOFS          ; {80379}
    STZ $BG4HOFS          ; {80382}
    STZ $BG4VOFS          ; {80385}
    STZ $BG4VOFS          ; {80388}
    LDA #$80              ; {80391}
    STA $VMAIN            ; {80393}
    STZ $VMADDL           ; {80396}
    STZ $VMADDH           ; {80399}
    LDA #$80              ; {80402}
    STA $M7SEL            ; {80404}
    LDA #$01              ; {80407}
    STZ $M7A              ; {80409}
    STA $M7A              ; {80412}
    STZ $M7B              ; {80415}
    STZ $M7B              ; {80418}
    STZ $M7C              ; {80421}
    STZ $M7C              ; {80424}
    STZ $M7D              ; {80427}
    STA $M7D              ; {80430}
    STZ $M7X              ; {80433}
    STZ $M7X              ; {80436}
    STZ $M7Y              ; {80439}
    STZ $M7Y              ; {80442}
    STZ $CGADD            ; {80445}
    STZ $W12SEL           ; {80448}
    STZ $W34SEL           ; {80451}
    STZ $WOBJSEL          ; {80454}
    STZ $WH0              ; {80457}
    STZ $WH1              ; {80460}
    STZ $WH2              ; {80463}
    STZ $WH3              ; {80466}
    STZ $WBGLOG           ; {80469}
    STZ $WOBJLOG          ; {80472}
    STZ $TM               ; {80475}
    STZ $TS               ; {80478}
    STZ $TMW              ; {80481}
    STZ $TSW              ; {80484}
    LDA #$02              ; {80487}
    STA $CGWSEL           ; {80489}
    STZ $CGADSUB          ; {80492}
    LDA #$E0              ; {80495}
    STA $COLDATA          ; {80497}
    STZ $SETINI           ; {80500}
    STZ $NMITIMEN         ; {80503}
    LDA #$FF              ; {80506}
    STA $WRIO             ; {80508}
    LDA #$00              ; {80511}
    STZ $WRMPYA           ; {80513}
    STZ $WRMPYB           ; {80516}
    STZ $WRDIVL           ; {80519}
    STZ $WRDIVH           ; {80522}
    STZ $WRDIVB           ; {80525}
    STZ $HTIMEL           ; {80528}
    STZ $HTIMEH           ; {80531}
    STZ $VTIMEL           ; {80534}
    STZ $VTIMEH           ; {80537}
    STZ $MDMAEN           ; {80540}
    STZ $HDMAEN           ; {80543}
    STZ $MEMSEL           ; {80546}
    REP #$20              ; {80549}
    LDX #$0000            ; {80551}
    LDA #$0000            ; {80554}

  loc_013AAD:
    STA $0000, X          ; {80557}
    INX                   ; {80560}
    INX                   ; {80561}
    CPX #$1F00            ; {80562}
    BNE loc_013AAD        ; {80565}
    LDX #$2000            ; {80567}

  loc_013ABA:
    STA $7E0000, X        ; {80570}
    INX                   ; {80574}
    INX                   ; {80575}
    BNE loc_013ABA        ; {80576}
    LDX #$0000            ; {80578}

  loc_013AC5:
    STA $cgram_buffer, X  ; {80581}
    INX                   ; {80585}
    INX                   ; {80586}
    BNE loc_013AC5        ; {80587}
    SEP #$20              ; {80589}
    LDX #$&asset_list_028000 ; {80591}
    STX $2F               ; {80594}
    LDA #$^asset_list_028000 ; {80596}
    STA $31               ; {80598}
    PLP                   ; {80600}
    RTL                   ; {80601}
}