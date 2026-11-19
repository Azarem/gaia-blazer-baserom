?BANK 02

?INCLUDE 'data_00F9F7'
?INCLUDE 'data_048000'
?INCLUDE 'engine_000000'
?INCLUDE 'engine_0029EC'
?INCLUDE 'lib_0118FC_part10'
?INCLUDE 'lib_0118FC_part11'
?INCLUDE 'lib_0118FC_part12'
?INCLUDE 'lib_0118FC_part13'
?INCLUDE 'lib_0118FC_part2'
?INCLUDE 'lib_0118FC_part3'
?INCLUDE 'lib_0118FC_part4'
?INCLUDE 'lib_0118FC_part5'
?INCLUDE 'lib_0118FC_part6'
?INCLUDE 'lib_0118FC_part7'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_0118FC_part9'
?INCLUDE 'lib_0273D4'
?INCLUDE 'lib_0273EB'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027781_part1'
?INCLUDE 'lib_shared_012390'
?INCLUDE 'lib_shared_012416'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131B7'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'meta_tables_008000'

!frame_counter                  0312
!joy_pressed                    0322
!joy_release_latch              032A
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!player_actor                   039C
!vram_upload_flags              03B8
!actor_list_tail                06A6
!inventory                      1B1E
!player_hp                      1B88
!player_max_hp                  1B8A
!INIDISP                        2100
!BG2SC                          2108
!BG12NBA                        210B
!W12SEL                         2123
!TM                             212C
!CGADSUB                        2131
!S_bg3_tilemap_buffer           7000
!tile_type_map                  7F8000

---------------------------------------------

code_0118FC {
    LDA $0323             ; {71932}
    BIT #$20              ; {71935}
    BEQ loc_011906        ; {71937}
    BRL loc_011B97        ; {71939}

  loc_011906:
    BIT #$80              ; {71942}
    BEQ loc_01190D        ; {71944}
    BRL loc_0119D8        ; {71946}

  loc_01190D:
    BIT #$0F              ; {71949}
    BNE loc_011918        ; {71951}
    LDA $joy_pressed      ; {71953}
    BIT #$80              ; {71956}
    BNE loc_011919        ; {71958}

  loc_011918:
    RTL                   ; {71960}

  loc_011919:
    LDA $player_hp        ; {71961}
    LDX #$1B6C            ; {71964}
    JSL $@lib_0118FC_part10.code_013215 ; {71967}
    LDA $player_max_hp    ; {71971}
    LDX #$1B6E            ; {71974}
    JSL $@lib_0118FC_part10.code_013215 ; {71977}
    LDA $1B72             ; {71981}
    PHA                   ; {71984}
    CMP #$0C              ; {71985}
    BCC loc_01193A        ; {71987}
    LDA #$0C              ; {71989}
    STA $1B72             ; {71991}

  loc_01193A:
    LDA $1B76             ; {71994}
    PHA                   ; {71997}
    CMP #$0C              ; {71998}
    BCC loc_011947        ; {72000}
    LDA #$0C              ; {72002}
    STA $1B76             ; {72004}

  loc_011947:
    LDY #$&lib_0118FC_part11.asciistring_014571 ; {72007}
    JSL $@lib_shared_012769.code_012769 ; {72010}
    PLA                   ; {72014}
    STA $1B76             ; {72015}
    PLA                   ; {72018}
    STA $1B72             ; {72019}
    BRK #$07              ; {72022}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72024}

  loc_01195C:
    JSR $&code_0119A8     ; {72028}
    BIT #$80              ; {72031}
    BNE loc_01195C        ; {72033}
    REP #$20              ; {72035}

  loc_011965:
    JSR $&code_0119A8     ; {72037}
    BIT #$CF80            ; {72040}
    BEQ loc_011965        ; {72043}
    SEP #$20              ; {72045}
    LDY #$&lib_0118FC_part11.asciistring_014624 ; {72047}
    JSL $@lib_shared_012769.code_012769 ; {72050}
    JSR $&code_0119B7     ; {72054}
    REP #$20              ; {72057}

  loc_01197B:
    JSR $&code_0119A8     ; {72059}
    BIT #$CF80            ; {72062}
    BNE loc_01197B        ; {72065}

  loc_011983:
    JSR $&code_0119A8     ; {72067}
    BIT #$CF80            ; {72070}
    BEQ loc_011983        ; {72073}
    LDA #$C0C0            ; {72075}
    TRB $joy_release_latch ; {72078}
    STZ $joy_pressed      ; {72081}
    SEP #$20              ; {72084}
    BRK #$07              ; {72086}
    JSR $&lib_0118FC_part3.code_012350 ; {72088}
    LDA #$1F              ; {72091}
    STA $0332             ; {72093}
    JSL $@lib_0118FC_part6.code_012659 ; {72096}
    JSR $&code_0119A8     ; {72100}
    RTL                   ; {72103}
}

code_0119A8 {
    JSL $@lib_shared_0131B7.code_0131B7 ; {72104}
    LDX $frame_counter    ; {72108}
    DEX                   ; {72111}
    STX $frame_counter    ; {72112}
    LDA $joy_pressed      ; {72115}
    RTS                   ; {72118}
}

code_0119B7 {
    LDA $1B82             ; {72119}
    LDY #$&lib_0118FC_part11.asciistring_014636 ; {72122}

  loc_0119BD:
    LSR                   ; {72125}
    PHA                   ; {72126}
    BCC loc_0119C7        ; {72127}
    PHY                   ; {72129}
    JSL $@lib_shared_012769.code_012769 ; {72130}
    PLY                   ; {72134}

  loc_0119C7:
    REP #$20              ; {72135}
    TYA                   ; {72137}
    CLC                   ; {72138}
    ADC #$0015            ; {72139}
    TAY                   ; {72142}
    SEP #$20              ; {72143}
    PLA                   ; {72145}
    CPY #$&lib_0118FC_part12.asciistring_01469F ; {72146}
    BNE loc_0119BD        ; {72149}
    RTS                   ; {72151}

  loc_0119D8:
    JSL $@lib_0118FC_part8.code_0131AE ; {72152}
    JSR $&code_0119E4     ; {72156}
    JSL $@lib_0118FC_part8.code_0131A2 ; {72159}
    RTL                   ; {72163}
}

code_0119E4 {
    JSL $@lib_0273D4.code_0273D4 ; {72164}
    BCC loc_0119EB        ; {72168}
    RTS                   ; {72170}

  loc_0119EB:
    PHP                   ; {72171}
    REP #$20              ; {72172}
    LDY $player_actor     ; {72174}
    AND #$00FF            ; {72177}
    BEQ loc_011A43        ; {72180}
    DEC                   ; {72182}
    BNE loc_0119FC        ; {72183}
    BRL loc_011AA7        ; {72185}

  loc_0119FC:
    DEC                   ; {72188}
    BNE loc_011A02        ; {72189}
    BRL loc_011A05        ; {72191}

  loc_011A02:
    BRL loc_011A26        ; {72194}

  loc_011A05:
    LDA #$0002            ; {72197}
    STA $00               ; {72200}
    LDA $0000, Y          ; {72202}
    CLC                   ; {72205}
    ADC #$0010            ; {72206}
    STA $16               ; {72209}
    LDA $0002, Y          ; {72211}
    SEC                   ; {72214}
    SBC #$0008            ; {72215}
    STA $18               ; {72218}
    JSR $&code_011AC4     ; {72220}
    BCC loc_011A24        ; {72223}
    BRL loc_011AF9        ; {72225}

  loc_011A24:
    PLP                   ; {72228}
    RTS                   ; {72229}

  loc_011A26:
    LDA #$0003            ; {72230}
    STA $00               ; {72233}
    LDA $0000, Y          ; {72235}
    STA $16               ; {72238}
    LDA $0002, Y          ; {72240}
    SEC                   ; {72243}
    SBC #$0008            ; {72244}
    STA $18               ; {72247}
    JSR $&code_011AC4     ; {72249}
    BCC loc_011A41        ; {72252}
    BRL loc_011AF9        ; {72254}

  loc_011A41:
    PLP                   ; {72257}
    RTS                   ; {72258}

  loc_011A43:
    LDA #$0000            ; {72259}
    STA $00               ; {72262}
    LDA $0000, Y          ; {72264}
    CLC                   ; {72267}
    ADC #$0008            ; {72268}
    STA $16               ; {72271}
    LDA $0002, Y          ; {72273}
    SEC                   ; {72276}
    SBC #$0010            ; {72277}
    STA $18               ; {72280}
    JSR $&code_011AC4     ; {72282}
    BCC loc_011A62        ; {72285}
    BRL loc_011AF9        ; {72287}

  loc_011A62:
    PHX                   ; {72290}
    LDX $player_actor     ; {72291}
    LDA $0000, X          ; {72294}
    AND #$FFF0            ; {72297}
    STA $16               ; {72300}
    LDA $0002, X          ; {72302}
    SEC                   ; {72305}
    SBC #$0020            ; {72306}
    AND #$FFF0            ; {72309}
    STA $18               ; {72312}
    JSL $@lib_027462_part1.code_0272B8 ; {72314}
    LDA $tile_type_map, X ; {72318}
    PLX                   ; {72322}
    AND #$000F            ; {72323}
    CMP #$0006            ; {72326}
    BNE loc_011AA5        ; {72329}
    LDA $0000, Y          ; {72331}
    CLC                   ; {72334}
    ADC #$0008            ; {72335}
    STA $16               ; {72338}
    LDA $0002, Y          ; {72340}
    SEC                   ; {72343}
    SBC #$0020            ; {72344}
    STA $18               ; {72347}
    JSR $&code_011AC4     ; {72349}
    BCC loc_011AA5        ; {72352}
    BRL loc_011AF9        ; {72354}

  loc_011AA5:
    PLP                   ; {72357}
    RTS                   ; {72358}

  loc_011AA7:
    LDA #$0001            ; {72359}
    STA $00               ; {72362}
    LDA $0000, Y          ; {72364}
    CLC                   ; {72367}
    ADC #$0008            ; {72368}
    STA $16               ; {72371}
    LDA $0002, Y          ; {72373}
    STA $18               ; {72376}
    JSR $&code_011AC4     ; {72378}
    BCC loc_011AC2        ; {72381}
    BRL loc_011AF9        ; {72383}

  loc_011AC2:
    PLP                   ; {72386}
    RTS                   ; {72387}
}

code_011AC4 {
    LDA $actor_list_tail  ; {72388}

  loc_011AC7:
    TAX                   ; {72391}
    BEQ loc_011AF5        ; {72392}
    LDA $0016, X          ; {72394}
    BIT #$0040            ; {72397}
    BEQ loc_011AF0        ; {72400}
    LDA $16               ; {72402}
    SEC                   ; {72404}
    SBC $0000, X          ; {72405}
    CMP $0010, X          ; {72408}
    BEQ loc_011ADF        ; {72411}
    BCS loc_011AF0        ; {72413}

  loc_011ADF:
    LDA $18               ; {72415}
    SEC                   ; {72417}
    SBC $0002, X          ; {72418}
    CLC                   ; {72421}
    ADC $0012, X          ; {72422}
    CMP $0012, X          ; {72425}
    BEQ loc_011AF7        ; {72428}
    BCC loc_011AF7        ; {72430}

  loc_011AF0:
    LDA $003E, X          ; {72432}
    BRA loc_011AC7        ; {72435}

  loc_011AF5:
    CLC                   ; {72437}
    RTS                   ; {72438}

  loc_011AF7:
    SEC                   ; {72439}
    RTS                   ; {72440}

  loc_011AF9:
    LDA $0030, X          ; {72441}
    BEQ code_011B5A       ; {72444}
    LDA $0016, X          ; {72446}
    BIT #$0008            ; {72449}
    BNE loc_011B1D        ; {72452}
    SEP #$20              ; {72454}
    LDA #$02              ; {72456}
    PHA                   ; {72458}
    PEA $&code_011B5A-1   ; {72459}
    LDY $0038, X          ; {72462}
    LDA $&meta_tables_008000+D, Y ; {72465}
    PHA                   ; {72468}
    LDY $0030, X          ; {72469}
    DEY                   ; {72472}
    PHY                   ; {72473}
    REP #$20              ; {72474}
    RTL                   ; {72476}

  loc_011B1D:
    PHX                   ; {72477}
    LDY #$1A1E            ; {72478}
    LDA #$003F            ; {72481}
    MVN #$01, #$01        ; {72484}
    PLX                   ; {72487}
    PHX                   ; {72488}
    JSR $&code_011B5C     ; {72489}
    AND #$00FF            ; {72492}
    STA $001E, X          ; {72495}
    STZ $0020, X          ; {72498}
    JSL $@engine_000000.code_0008F3 ; {72501}
    SEP #$20              ; {72505}
    LDA #$02              ; {72507}
    PHA                   ; {72509}
    PEA $&code_011B50-1   ; {72510}
    LDY $0038, X          ; {72513}
    LDA $&meta_tables_008000+D, Y ; {72516}
    PHA                   ; {72519}
    LDY $0030, X          ; {72520}
    DEY                   ; {72523}
    PHY                   ; {72524}
    REP #$20              ; {72525}
    RTL                   ; {72527}
}

code_011B50 {
    LDX #$1A1E            ; {72528}
    PLY                   ; {72531}
    LDA #$003F            ; {72532}
    MVN #$01, #$01        ; {72535}
}

code_011B5A {
    PLP                   ; {72538}
    RTS                   ; {72539}
}

code_011B5C {
    PHP                   ; {72540}
    SEP #$20              ; {72541}
    LDY $001E, X          ; {72543}
    LDA #$06              ; {72546}
    JSL $@lib_0118FC_part9.code_0131E8 ; {72548}
    XBA                   ; {72552}
    LDA #$06              ; {72553}
    JSL $@lib_shared_0131D1.code_0131D1 ; {72555}
    STA $01               ; {72559}
    LDA $00               ; {72561}
    BEQ loc_011B93        ; {72563}
    DEC                   ; {72565}
    BEQ loc_011B91        ; {72566}
    DEC                   ; {72568}
    BEQ loc_011B84        ; {72569}
    LDA $001D, X          ; {72571}
    BIT #$40              ; {72574}
    BNE loc_011B8F        ; {72576}
    BRA loc_011B8B        ; {72578}

  loc_011B84:
    LDA $001D, X          ; {72580}
    BIT #$40              ; {72583}
    BEQ loc_011B8F        ; {72585}

  loc_011B8B:
    JSL $@lib_0273EB.code_0273EB ; {72587}

  loc_011B8F:
    INC $01               ; {72591}

  loc_011B91:
    INC $01               ; {72593}

  loc_011B93:
    LDA $01               ; {72595}
    PLP                   ; {72597}
    RTS                   ; {72598}

  loc_011B97:
    STZ $42               ; {72599}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72601}
    LDA #$80              ; {72605}
    STA $INIDISP          ; {72607}
    LDA #$5C              ; {72610}
    STA $BG2SC            ; {72612}
    LDA #$20              ; {72615}
    STA $BG12NBA          ; {72617}
    LDA #$06              ; {72620}
    STA $TM               ; {72622}
    STZ $CGADSUB          ; {72625}
    STZ $W12SEL           ; {72628}
    LDX $scroll_bg1_x     ; {72631}
    STX $045A             ; {72634}
    LDX $scroll_bg1_y     ; {72637}
    STX $045C             ; {72640}
    LDX $scroll_bg2_x     ; {72643}
    STX $045E             ; {72646}
    LDX $scroll_bg2_y     ; {72649}
    STX $0460             ; {72652}
    LDX #$0000            ; {72655}
    STX $scroll_bg1_x     ; {72658}
    STX $scroll_bg1_y     ; {72661}
    STX $scroll_bg2_x     ; {72664}
    STX $scroll_bg2_y     ; {72667}
    STZ $042F             ; {72670}
    LDA $1B62             ; {72673}
    STA $0435             ; {72676}
    JSR $&lib_0118FC_part4.code_0123EA ; {72679}
    JSR $&lib_shared_012416.code_012416 ; {72682}
    JSR $&lib_shared_012416.code_01243D ; {72685}
    JSR $&lib_shared_012390.code_012390 ; {72688}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72691}
    BRK #$07              ; {72695}
    JSR $&code_011C7B     ; {72697}
    LDA #$C0              ; {72700}
    TRB $032B             ; {72702}
    STZ $0323             ; {72705}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72708}
    LDX $045A             ; {72712}
    STX $scroll_bg1_x     ; {72715}
    LDX $045C             ; {72718}
    STX $scroll_bg1_y     ; {72721}
    LDX $045E             ; {72724}
    STX $scroll_bg2_x     ; {72727}
    LDX $0460             ; {72730}
    STX $scroll_bg2_y     ; {72733}
    LDA #$80              ; {72736}
    STA $INIDISP          ; {72738}
    LDA $03C2             ; {72741}
    STA $BG2SC            ; {72744}
    STZ $BG12NBA          ; {72747}
    LDA $03C0             ; {72750}
    STA $TM               ; {72753}
    LDA $03C1             ; {72756}
    STA $CGADSUB          ; {72759}
    LDA $03C3             ; {72762}
    STA $W12SEL           ; {72765}
    JSL $@lib_0118FC_part5.code_012463 ; {72768}
    JSR $&lib_0118FC_part4.code_012400 ; {72772}
    JSL $@lib_0118FC_part5.code_01249C ; {72775}
    LDA $1B62             ; {72779}
    CMP $0435             ; {72782}
    BEQ loc_011C5D        ; {72785}
    JSL $@engine_0029EC.code_002C7D ; {72787}
    STZ $0433             ; {72791}
    STZ $0434             ; {72794}

  loc_011C5D:
    JSL $@lib_027781_part1.code_0273F9 ; {72797}
    JSR $&lib_0118FC_part3.code_012350 ; {72801}
    LDA #$1F              ; {72804}
    STA $0332             ; {72806}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72809}
    JSL $@engine_000000.code_000127 ; {72813}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72817}
    LDA #$0F              ; {72821}
    STA $INIDISP          ; {72823}
    RTL                   ; {72826}
}

code_011C7B {
    JSR $&lib_0118FC_part3.code_012350 ; {72827}
    LDY #$&lib_0118FC_part12.asciistring_01469F ; {72830}
    JSL $@lib_shared_012769.code_012769 ; {72833}
    LDA #$01              ; {72837}
    STA $vram_upload_flags ; {72839}
    JSL $@lib_0118FC_part8.code_0131A2 ; {72842}
    JSL $@lib_0118FC_part7.code_013176 ; {72846}
    JSR $&code_011F18     ; {72850}
    LDA #$02              ; {72853}
    STA $vram_upload_flags ; {72855}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72858}
    LDA #$01              ; {72862}
    STA $vram_upload_flags ; {72864}
    JSL $@lib_shared_0131B7.code_0131B7 ; {72867}
    LDX #$048A            ; {72871}
    LDA #$00              ; {72874}
    XBA                   ; {72876}
    LDA #$04              ; {72877}

  loc_011CAF:
    JSR $&lib_0118FC_part2.code_012138 ; {72879}
    BCC loc_011CB7        ; {72882}
    BRL loc_011D44        ; {72884}

  loc_011CB7:
    CMP #$00              ; {72887}
    BEQ loc_011CC3        ; {72889}
    DEC                   ; {72891}
    BEQ loc_011CE4        ; {72892}
    DEC                   ; {72894}
    BEQ loc_011D05        ; {72895}
    BRA loc_011D23        ; {72897}

  loc_011CC3:
    LDA #$08              ; {72899}
    LDY #$1B1E            ; {72901}
    JSR $&code_011DA3     ; {72904}
    BCS loc_011CD3        ; {72907}
    STA $1B5E             ; {72909}
    JSR $&code_011EED     ; {72912}

  loc_011CD3:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M ; {72915}
    JSL $@lib_shared_012769.code_012769 ; {72918}
    LDX #$048A            ; {72922}
    LDA #$00              ; {72925}
    XBA                   ; {72927}
    LDA #$04              ; {72928}
    BRA loc_011CAF        ; {72930}

  loc_011CE4:
    LDA #$08              ; {72932}
    LDY #$1B26            ; {72934}
    JSR $&code_011DA3     ; {72937}
    BCS loc_011CF4        ; {72940}
    STA $1B60             ; {72942}
    JSR $&code_011EED     ; {72945}

  loc_011CF4:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M ; {72948}
    JSL $@lib_shared_012769.code_012769 ; {72951}
    LDX #$050A            ; {72955}
    LDA #$01              ; {72958}
    XBA                   ; {72960}
    LDA #$04              ; {72961}
    BRA loc_011CAF        ; {72963}

  loc_011D05:
    LDA #$08              ; {72965}
    LDY #$1B2E            ; {72967}
    JSR $&code_011DA3     ; {72970}
    BCS loc_011D12        ; {72973}
    STA $1B62             ; {72975}

  loc_011D12:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M ; {72978}
    JSL $@lib_shared_012769.code_012769 ; {72981}
    LDX #$058A            ; {72985}
    LDA #$02              ; {72988}
    XBA                   ; {72990}
    LDA #$04              ; {72991}
    BRA loc_011CAF        ; {72993}

  loc_011D23:
    LDA #$28              ; {72995}
    LDY #$1B36            ; {72997}
    JSR $&code_011FF2     ; {73000}
    BCS loc_011D30        ; {73003}
    STA $1B64             ; {73005}

  loc_011D30:
    LDY #$&lib_0118FC_part12.asciistring_01469F+M ; {73008}
    JSL $@lib_shared_012769.code_012769 ; {73011}
    LDX #$060A            ; {73015}
    LDA #$03              ; {73018}
    XBA                   ; {73020}
    LDA #$04              ; {73021}
    BRL loc_011CAF        ; {73023}

  loc_011D42:
    CLC                   ; {73026}
    RTS                   ; {73027}

  loc_011D44:
    SEC                   ; {73028}
    RTS                   ; {73029}
}

code_011D46 {
    PHX                   ; {73030}
    PHY                   ; {73031}
    JSR $&lib_0118FC_part3.code_012370 ; {73032}
    LDY #$&lib_0118FC_part12.asciistring_01469F ; {73035}
    JSL $@lib_shared_012769.code_012769 ; {73038}
    LDA #$01              ; {73042}
    STA $vram_upload_flags ; {73044}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73047}
    JSR $&lib_shared_012416.code_01243D ; {73051}
    JSR $&code_011F18     ; {73054}
    LDA #$02              ; {73057}
    STA $vram_upload_flags ; {73059}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73062}
    LDA #$01              ; {73066}
    STA $vram_upload_flags ; {73068}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73071}
    PLY                   ; {73075}
    PLX                   ; {73076}
    RTS                   ; {73077}
}

code_011D76 {
    PHX                   ; {73078}
    PHY                   ; {73079}
    LDY #$&lib_0118FC_part12.asciistring_014701 ; {73080}
    JSL $@lib_shared_012769.code_012769 ; {73083}
    LDA #$01              ; {73087}
    STA $vram_upload_flags ; {73089}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73092}
    JSR $&lib_0118FC_part5.code_012450 ; {73096}
    JSR $&code_011FD3     ; {73099}
    LDA #$02              ; {73102}
    STA $vram_upload_flags ; {73104}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73107}
    LDA #$01              ; {73111}
    STA $vram_upload_flags ; {73113}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73116}
    PLY                   ; {73120}
    PLX                   ; {73121}
    RTS                   ; {73122}
}

code_011DA3 {
    STA $03C4             ; {73123}
    STY $0056             ; {73126}
    STZ $03C6             ; {73129}
    JSR $&code_011EAB     ; {73132}
    LDX #$0000            ; {73135}
    TXY                   ; {73138}

  loc_011DB3:
    LDA ($56), Y          ; {73139}
    BMI loc_011DC6        ; {73141}
    INY                   ; {73143}
    CPY $03C4             ; {73144}
    BNE loc_011DB3        ; {73147}
    LDY #$0000            ; {73149}
    LDA ($56), Y          ; {73152}
    ORA #$80              ; {73154}
    STA ($56), Y          ; {73156}

  loc_011DC6:
    JSR $&code_011F18     ; {73158}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73161}
    PHY                   ; {73165}
    REP #$20              ; {73166}
    LDA ($56), Y          ; {73168}
    AND #$007F            ; {73170}
    PHA                   ; {73173}
    BEQ loc_011DEF        ; {73174}
    LDY #$&lib_0118FC_part13.asciistring_01553E ; {73176}
    CMP #$0009            ; {73179}
    BCC loc_011DEB        ; {73182}
    LDY #$&lib_0118FC_part13.asciistring_015558 ; {73184}
    CMP #$0011            ; {73187}
    BCC loc_011DEB        ; {73190}
    LDY #$&lib_0118FC_part13.asciistring_01556B ; {73192}

  loc_011DEB:
    JSL $@lib_shared_012769.code_012769 ; {73195}

  loc_011DEF:
    PLA                   ; {73199}
    ASL                   ; {73200}
    TAX                   ; {73201}
    LDA $@lib_0118FC_part13.asciistring_list_015572, X ; {73202}
    TAY                   ; {73206}
    SEP #$20              ; {73207}
    JSL $@lib_shared_012769.code_012769 ; {73209}
    PLY                   ; {73213}

  loc_011DFE:
    JSR $&lib_shared_012769.code_013169 ; {73214}
    BEQ loc_011E0B        ; {73217}
    JSR $&code_011ECF     ; {73219}
    JSR $&code_011F18     ; {73222}
    BRA loc_011DFE        ; {73225}

  loc_011E0B:
    JSR $&lib_shared_012769.code_013169 ; {73227}
    LSR                   ; {73230}
    BCS loc_011E57        ; {73231}
    LSR                   ; {73233}
    BCS loc_011E6A        ; {73234}
    LSR                   ; {73236}
    BCS loc_011E7A        ; {73237}
    LSR                   ; {73239}
    BCS loc_011E88        ; {73240}
    LSR                   ; {73242}
    LSR                   ; {73243}
    LSR                   ; {73244}
    BCS loc_011E2A        ; {73245}
    LSR                   ; {73247}
    BCS loc_011E2A        ; {73248}
    JSR $&code_011ECF     ; {73250}
    JSR $&code_011F18     ; {73253}
    BRA loc_011E0B        ; {73256}

  loc_011E2A:
    BRK #$18              ; {73258}
    LDA ($56), Y          ; {73260}
    ORA #$80              ; {73262}
    STA ($56), Y          ; {73264}
    JSR $&code_011F18     ; {73266}
    LDA #$01              ; {73269}
    TSB $vram_upload_flags ; {73271}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73274}
    LDA ($56), Y          ; {73278}
    AND #$7F              ; {73280}
    CLC                   ; {73282}
    RTS                   ; {73283}
}

code_011E44 {
    BRK #$07              ; {73284}
    JSR $&code_011EBD     ; {73286}
    JSR $&code_011F18     ; {73289}
    LDA #$01              ; {73292}
    TSB $vram_upload_flags ; {73294}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73297}
    SEC                   ; {73301}
    RTS                   ; {73302}

  loc_011E57:
    TYA                   ; {73303}
    CLC                   ; {73304}
    ADC #$04              ; {73305}
    CMP $03C4             ; {73307}
    BCC loc_011E63        ; {73310}
    BRL loc_011DC6        ; {73312}

  loc_011E63:
    TYX                   ; {73315}
    INY                   ; {73316}
    INY                   ; {73317}
    INY                   ; {73318}
    INY                   ; {73319}
    BRA loc_011E91        ; {73320}

  loc_011E6A:
    TYA                   ; {73322}
    SEC                   ; {73323}
    SBC #$04              ; {73324}
    BPL loc_011E73        ; {73326}
    BRL loc_011DC6        ; {73328}

  loc_011E73:
    TYX                   ; {73331}
    DEY                   ; {73332}
    DEY                   ; {73333}
    DEY                   ; {73334}
    DEY                   ; {73335}
    BRA loc_011E91        ; {73336}

  loc_011E7A:
    TYA                   ; {73338}
    INC                   ; {73339}
    CMP $03C4             ; {73340}
    BCC loc_011E84        ; {73343}
    BRL loc_011DC6        ; {73345}

  loc_011E84:
    TYX                   ; {73348}
    INY                   ; {73349}
    BRA loc_011E91        ; {73350}

  loc_011E88:
    TYA                   ; {73352}
    DEC                   ; {73353}
    BPL loc_011E8F        ; {73354}
    BRL loc_011DC6        ; {73356}

  loc_011E8F:
    TYX                   ; {73359}
    DEY                   ; {73360}

  loc_011E91:
    BRK #$07              ; {73361}
    PHY                   ; {73363}
    LDA ($56), Y          ; {73364}
    ORA #$80              ; {73366}
    STA ($56), Y          ; {73368}
    TXY                   ; {73370}
    LDA ($56), Y          ; {73371}
    AND #$7F              ; {73373}
    STA ($56), Y          ; {73375}
    STZ $03C6             ; {73377}
    PLY                   ; {73380}
    JSR $&code_011ECF     ; {73381}
    BRL loc_011DC6        ; {73384}
}

code_011EAB {
    LDX #$0000            ; {73387}
    TXY                   ; {73390}

  loc_011EAF:
    LDA ($56), Y          ; {73391}
    STA $7F0403, X        ; {73393}
    INY                   ; {73397}
    INX                   ; {73398}
    CPX $03C4             ; {73399}
    BNE loc_011EAF        ; {73402}
    RTS                   ; {73404}
}

code_011EBD {
    LDX #$0000            ; {73405}
    TXY                   ; {73408}

  loc_011EC1:
    LDA $7F0403, X        ; {73409}
    STA ($56), Y          ; {73413}
    INY                   ; {73415}
    INX                   ; {73416}
    CPX $03C4             ; {73417}
    BNE loc_011EC1        ; {73420}
    RTS                   ; {73422}
}

code_011ECF {
    LDA $03C6             ; {73423}
    AND #$1F              ; {73426}
    CMP #$18              ; {73428}
    BCC loc_011EDE        ; {73430}
    LDA ($56), Y          ; {73432}
    AND #$7F              ; {73434}
    BRA loc_011EE2        ; {73436}

  loc_011EDE:
    LDA ($56), Y          ; {73438}
    ORA #$80              ; {73440}

  loc_011EE2:
    STA ($56), Y          ; {73442}
    INC $03C6             ; {73444}
    LDA #$01              ; {73447}
    TSB $vram_upload_flags ; {73449}
    RTS                   ; {73452}
}

code_011EED {
    LDX $1B5E             ; {73453}
    LDA $@lib_0118FC_part13.binary_0161AC, X ; {73456}
    STA $1B70             ; {73460}
    LDA $@lib_0118FC_part13.binary_0161AC+11, X ; {73463}
    STA $1B74             ; {73467}
    LDX $1B60             ; {73470}
    LDA $@lib_0118FC_part13.binary_0161AC, X ; {73473}
    CLC                   ; {73477}
    ADC $1B70             ; {73478}
    STA $1B70             ; {73481}
    LDA $@lib_0118FC_part13.binary_0161AC+11, X ; {73484}
    CLC                   ; {73488}
    ADC $1B74             ; {73489}
    STA $1B74             ; {73492}
    RTS                   ; {73495}
}

code_011F18 {
    PHP                   ; {73496}
    PHY                   ; {73497}
    REP #$20              ; {73498}
    LDX #$0000            ; {73500}

  loc_011F1F:
    PHX                   ; {73503}
    TXA                   ; {73504}
    ASL                   ; {73505}
    TAX                   ; {73506}
    LDA $&data_00F9F7.word_00F9F7, X ; {73507}
    TAY                   ; {73510}
    PLX                   ; {73511}
    LDA $inventory, X     ; {73512}
    JSR $&code_011F67     ; {73515}
    INX                   ; {73518}
    CPX #$0008            ; {73519}
    BNE loc_011F1F        ; {73522}
    LDX #$0000            ; {73524}

  loc_011F37:
    PHX                   ; {73527}
    TXA                   ; {73528}
    ASL                   ; {73529}
    TAX                   ; {73530}
    LDA $&data_00F9F7.word_00FA07, X ; {73531}
    TAY                   ; {73534}
    PLX                   ; {73535}
    LDA $1B26, X          ; {73536}
    JSR $&code_011F67     ; {73539}
    INX                   ; {73542}
    CPX #$0008            ; {73543}
    BNE loc_011F37        ; {73546}
    LDX #$0000            ; {73548}

  loc_011F4F:
    PHX                   ; {73551}
    TXA                   ; {73552}
    ASL                   ; {73553}
    TAX                   ; {73554}
    LDA $&data_00F9F7.word_00FA17, X ; {73555}
    TAY                   ; {73558}
    PLX                   ; {73559}
    LDA $1B2E, X          ; {73560}
    JSR $&code_011F67     ; {73563}
    INX                   ; {73566}
    CPX #$0008            ; {73567}
    BNE loc_011F4F        ; {73570}
    PLY                   ; {73572}
    PLP                   ; {73573}
    RTS                   ; {73574}
}

code_011F67 {
    PHB                   ; {73575}
    PHX                   ; {73576}
    XBA                   ; {73577}
    TAX                   ; {73578}
    SEP #$20              ; {73579}
    PHP                   ; {73581}
    LDA #$7F              ; {73582}
    PHA                   ; {73584}
    PLB                   ; {73585}
    PLP                   ; {73586}
    BMI loc_011F85        ; {73587}
    LDA #$00              ; {73589}
    STA $S_bg3_tilemap_buffer, Y ; {73591}
    STA $7002, Y          ; {73594}
    STA $7040, Y          ; {73597}
    STA $7042, Y          ; {73600}
    BRA loc_011FAA        ; {73603}

  loc_011F85:
    LDA #$2A              ; {73605}
    STA $S_bg3_tilemap_buffer, Y ; {73607}
    STA $7002, Y          ; {73610}
    STA $7040, Y          ; {73613}
    STA $7042, Y          ; {73616}
    LDA $7001, Y          ; {73619}
    ORA #$0C              ; {73622}
    STA $7001, Y          ; {73624}
    EOR #$40              ; {73627}
    STA $7003, Y          ; {73629}
    EOR #$C0              ; {73632}
    STA $7041, Y          ; {73634}
    EOR #$40              ; {73637}
    STA $7043, Y          ; {73639}

  loc_011FAA:
    REP #$20              ; {73642}
    XBA                   ; {73644}
    AND #$007F            ; {73645}
    ASL                   ; {73648}
    ASL                   ; {73649}
    ASL                   ; {73650}
    TAX                   ; {73651}
    LDA $@data_048000.unk17_048800, X ; {73652}
    STA $7800, Y          ; {73656}
    LDA $@data_048000.unk17_048800+2, X ; {73659}
    STA $7802, Y          ; {73663}
    LDA $@data_048000.unk17_048800+4, X ; {73666}
    STA $7840, Y          ; {73670}
    LDA $@data_048000.unk17_048800+6, X ; {73673}
    STA $7842, Y          ; {73677}
    PLX                   ; {73680}
    PLB                   ; {73681}
    RTS                   ; {73682}
}

code_011FD3 {
    PHP                   ; {73683}
    PHY                   ; {73684}
    REP #$20              ; {73685}
    LDX #$0000            ; {73687}

  loc_011FDA:
    PHX                   ; {73690}
    TXA                   ; {73691}
    ASL                   ; {73692}
    TAX                   ; {73693}
    LDA $&data_00F9F7.word_00FA27, X ; {73694}
    TAY                   ; {73697}
    PLX                   ; {73698}
    LDA $1B36, X          ; {73699}
    JSR $&code_011F67     ; {73702}
    INX                   ; {73705}
    CPX #$0028            ; {73706}
    BNE loc_011FDA        ; {73709}
    PLY                   ; {73711}
    PLP                   ; {73712}
    RTS                   ; {73713}
}

code_011FF2 {
    STA $03C4             ; {73714}
    STY $0056             ; {73717}
    STZ $03C6             ; {73720}
    JSR $&code_011EAB     ; {73723}
    LDX #$0000            ; {73726}
    TXY                   ; {73729}

  loc_012002:
    LDA ($56), Y          ; {73730}
    BMI loc_012015        ; {73732}
    INY                   ; {73734}
    CPY $03C4             ; {73735}
    BNE loc_012002        ; {73738}
    LDY #$0000            ; {73740}
    LDA ($56), Y          ; {73743}
    ORA #$80              ; {73745}
    STA ($56), Y          ; {73747}

  loc_012015:
    JSR $&code_011FD3     ; {73749}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73752}
    PHY                   ; {73756}
    REP #$20              ; {73757}
    LDA ($56), Y          ; {73759}
    AND #$007F            ; {73761}
    BEQ loc_01202F        ; {73764}
    PHA                   ; {73766}
    LDY #$&lib_0118FC_part13.asciistring_01556B ; {73767}
    JSL $@lib_shared_012769.code_012769 ; {73770}
    PLA                   ; {73774}

  loc_01202F:
    ASL                   ; {73775}
    TAX                   ; {73776}
    LDA $@lib_0118FC_part13.asciistring_list_015572, X ; {73777}
    TAY                   ; {73781}
    SEP #$20              ; {73782}
    JSL $@lib_shared_012769.code_012769 ; {73784}
    PLY                   ; {73788}

  loc_01203D:
    JSR $&lib_shared_012769.code_013169 ; {73789}
    BEQ loc_01204A        ; {73792}
    JSR $&code_011ECF     ; {73794}
    JSR $&code_011FD3     ; {73797}
    BRA loc_01203D        ; {73800}

  loc_01204A:
    JSR $&lib_shared_012769.code_013169 ; {73802}
    LSR                   ; {73805}
    BCS loc_0120C8        ; {73806}
    LSR                   ; {73808}
    BCC loc_012056        ; {73809}
    BRL loc_0120D6        ; {73811}

  loc_012056:
    LSR                   ; {73814}
    BCS loc_012099        ; {73815}
    LSR                   ; {73817}
    BCS loc_0120B2        ; {73818}
    LSR                   ; {73820}
    LSR                   ; {73821}
    LSR                   ; {73822}
    BCS loc_01206C        ; {73823}
    LSR                   ; {73825}
    BCS loc_01206C        ; {73826}
    JSR $&code_011ECF     ; {73828}
    JSR $&code_011FD3     ; {73831}
    BRA loc_01204A        ; {73834}

  loc_01206C:
    BRK #$18              ; {73836}
    LDA ($56), Y          ; {73838}
    ORA #$80              ; {73840}
    STA ($56), Y          ; {73842}
    JSR $&code_011FD3     ; {73844}
    LDA #$01              ; {73847}
    TSB $vram_upload_flags ; {73849}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73852}
    LDA ($56), Y          ; {73856}
    AND #$7F              ; {73858}
    CLC                   ; {73860}
    RTS                   ; {73861}
}

code_012086 {
    BRK #$07              ; {73862}
    JSR $&code_011EBD     ; {73864}
    JSR $&code_011FD3     ; {73867}
    LDA #$01              ; {73870}
    TSB $vram_upload_flags ; {73872}
    JSL $@lib_shared_0131B7.code_0131B7 ; {73875}
    SEC                   ; {73879}
    RTS                   ; {73880}

  loc_012099:
    TYA                   ; {73881}
    CLC                   ; {73882}
    ADC #$0A              ; {73883}
    CMP $03C4             ; {73885}
    BCC loc_0120A5        ; {73888}
    BRL loc_012015        ; {73890}

  loc_0120A5:
    TYX                   ; {73893}
    INY                   ; {73894}
    INY                   ; {73895}
    INY                   ; {73896}
    INY                   ; {73897}
    INY                   ; {73898}
    INY                   ; {73899}
    INY                   ; {73900}
    INY                   ; {73901}
    INY                   ; {73902}
    INY                   ; {73903}
    BRA loc_0120DF        ; {73904}

  loc_0120B2:
    TYA                   ; {73906}
    SEC                   ; {73907}
    SBC #$0A              ; {73908}
    BPL loc_0120BB        ; {73910}
    BRL loc_012015        ; {73912}

  loc_0120BB:
    TYX                   ; {73915}
    DEY                   ; {73916}
    DEY                   ; {73917}
    DEY                   ; {73918}
    DEY                   ; {73919}
    DEY                   ; {73920}
    DEY                   ; {73921}
    DEY                   ; {73922}
    DEY                   ; {73923}
    DEY                   ; {73924}
    DEY                   ; {73925}
    BRA loc_0120DF        ; {73926}

  loc_0120C8:
    TYA                   ; {73928}
    INC                   ; {73929}
    CMP $03C4             ; {73930}
    BCC loc_0120D2        ; {73933}
    BRL loc_012015        ; {73935}

  loc_0120D2:
    TYX                   ; {73938}
    INY                   ; {73939}
    BRA loc_0120DF        ; {73940}

  loc_0120D6:
    TYA                   ; {73942}
    DEC                   ; {73943}
    BPL loc_0120DD        ; {73944}
    BRL loc_012015        ; {73946}

  loc_0120DD:
    TYX                   ; {73949}
    DEY                   ; {73950}

  loc_0120DF:
    BRK #$07              ; {73951}
    PHY                   ; {73953}
    LDA ($56), Y          ; {73954}
    ORA #$80              ; {73956}
    STA ($56), Y          ; {73958}
    TXY                   ; {73960}
    LDA ($56), Y          ; {73961}
    AND #$7F              ; {73963}
    STA ($56), Y          ; {73965}
    STZ $03C6             ; {73967}
    PLY                   ; {73970}
    JSR $&code_011ECF     ; {73971}
    BRL loc_012015        ; {73974}
}