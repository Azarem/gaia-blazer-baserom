?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0109D6_part1'
?INCLUDE 'lib_0109D6_part3'
?INCLUDE 'lib_0109D6_part4'
?INCLUDE 'lib_0109D6_part5'
?INCLUDE 'lib_027348'
?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_0273D4'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_0276A5'
?INCLUDE 'lib_shared_01112A'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_016246'
?INCLUDE 'table_00A9DE'
?INCLUDE 'table_00AC96'
?INCLUDE 'table_00B69A'

!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!player_actor                   039C
!transition_type                03E3
!return_active                  03FB
!return_area                    03FD
!return_scene                   03FF
!return_x                       0401
!return_y                       0403
!location_id                    1C6A
!tile_type_map                  7F8000

---------------------------------------------

code_0109D6 {
    LDA $player_x         ; {68054}
    ORA $player_y         ; {68057}
    AND #$0F              ; {68060}
    BNE loc_010A15        ; {68062}
    REP #$20              ; {68064}
    LDA $player_x         ; {68066}
    STA $16               ; {68069}
    LDA $player_y         ; {68071}
    SEC                   ; {68074}
    SBC #$0010            ; {68075}
    STA $18               ; {68078}
    JSL $@lib_027462_part1.code_0272B8 ; {68080}
    SEP #$20              ; {68084}
    LDA $7E8000, X        ; {68086}
    CMP #$FE              ; {68090}
    BNE loc_010A09        ; {68092}
    LDA $0458             ; {68094}
    BNE loc_010A28        ; {68097}
    JSL $@code_010C25     ; {68099}
    BRA loc_010A1B        ; {68103}

  loc_010A09:
    JSL $@code_010B9B     ; {68105}
    BCS loc_010A1B        ; {68109}
    JSL $@code_010A29     ; {68111}
    BCS loc_010A1B        ; {68115}

  loc_010A15:
    JSL $@code_010AF2     ; {68117}
    BCC loc_010A28        ; {68121}

  loc_010A1B:
    REP #$20              ; {68123}
    LDX $player_actor     ; {68125}
    STZ $0004, X          ; {68128}
    STZ $0006, X          ; {68131}
    SEP #$20              ; {68134}

  loc_010A28:
    RTL                   ; {68136}
}

code_010A29 {
    JSL $@lib_0273D4.code_0273D4 ; {68137}
    BCS loc_010A5A        ; {68141}
    CMP #$00              ; {68143}
    BNE loc_010A5A        ; {68145}
    LDX $03AE             ; {68147}

  loc_010A36:
    LDA $&table_00A9DE, X ; {68150}
    CMP #$FF              ; {68153}
    BEQ loc_010A5A        ; {68155}
    LDA $player_tile_x    ; {68157}
    CMP $&table_00A9DE, X ; {68160}
    BNE loc_010A4D        ; {68163}
    LDA $player_tile_y    ; {68165}
    CMP $&table_00A9DE+1, X ; {68168}
    BEQ loc_010A5C        ; {68171}

  loc_010A4D:
    REP #$20              ; {68173}
    TXA                   ; {68175}
    CLC                   ; {68176}
    ADC #$0006            ; {68177}
    TAX                   ; {68180}
    SEP #$20              ; {68181}
    BRL loc_010A36        ; {68183}

  loc_010A5A:
    CLC                   ; {68186}
    RTL                   ; {68187}

  loc_010A5C:
    TXY                   ; {68188}
    REP #$20              ; {68189}
    LDA $player_x         ; {68191}
    STA $16               ; {68194}
    LDA $player_y         ; {68196}
    SEC                   ; {68199}
    SBC #$0020            ; {68200}
    STA $18               ; {68203}
    JSL $@lib_027462_part1.code_0272B8 ; {68205}
    SEP #$20              ; {68209}
    LDA $7E8000, X        ; {68211}
    CMP #$FB              ; {68215}
    BNE loc_010A5A        ; {68217}
    TYX                   ; {68219}
    LDA #$00              ; {68220}
    XBA                   ; {68222}
    LDA $&table_00A9DE+2, X ; {68223}
    AND #$7F              ; {68226}
    LDY #$1A7E            ; {68228}
    JSL $@lib_0273A2.code_0273A2 ; {68231}
    BCS loc_010A5A        ; {68235}
    JSL $@lib_027348.code_027348 ; {68237}
    BRK #$15              ; {68241}
    LDA $&table_00A9DE+2, X ; {68243}
    BMI loc_010AA0        ; {68246}
    LDA #$FC              ; {68248}
    JSL $@lib_0109D6_part1.code_0106F1 ; {68250}
    BRA loc_010AA6        ; {68254}

  loc_010AA0:
    LDA #$FC              ; {68256}
    JSL $@lib_0109D6_part1.code_0107AC ; {68258}

  loc_010AA6:
    LDA #$1E              ; {68262}
    JSL $@lib_shared_012769.code_013140 ; {68264}
    LDA $&table_00A9DE+3, X ; {68268}
    STA $03C8             ; {68271}
    STZ $03C9             ; {68274}
    BEQ loc_010ACA        ; {68277}
    CMP #$FF              ; {68279}
    BEQ loc_010AD3        ; {68281}
    JSL $@lib_0109D6_part3.code_0120F9 ; {68283}
    LDY #$&lib_0109D6_part4.asciistring_016216 ; {68287}
    JSL $@lib_shared_012769.code_012C27 ; {68290}
    BRK #$9E              ; {68294}
    SEC                   ; {68296}
    RTL                   ; {68297}

  loc_010ACA:
    LDY #$&lib_0109D6_part4.asciistring_016232 ; {68298}
    JSL $@lib_shared_012769.code_012C27 ; {68301}
    SEC                   ; {68305}
    RTL                   ; {68306}

  loc_010AD3:
    REP #$20              ; {68307}
    LDA $&table_00A9DE+4, X ; {68309}
    STA $03C8             ; {68312}
    JSL $@lib_0276A5.code_0276A5 ; {68315}
    LDA #$0010            ; {68319}
    TSB $0332             ; {68322}
    SEP #$20              ; {68325}
    LDY #$&lib_shared_016246.asciistring_016246 ; {68327}
    JSL $@lib_shared_012769.code_012C27 ; {68330}
    BRK #$8D              ; {68334}
    SEC                   ; {68336}
    RTL                   ; {68337}
}

code_010AF2 {
    PHP                   ; {68338}
    LDX $03B2             ; {68339}
    BEQ loc_010B23        ; {68342}

  loc_010AF8:
    LDA $&table_00AC96, X ; {68344}
    CMP #$FF              ; {68347}
    BEQ loc_010B23        ; {68349}
    LDA $player_tile_x    ; {68351}
    SEC                   ; {68354}
    SBC $&table_00AC96, X ; {68355}
    CMP $&table_00AC96+2, X ; {68358}
    BCS loc_010B17        ; {68361}
    LDA $player_tile_y    ; {68363}
    SEC                   ; {68366}
    SBC $&table_00AC96+1, X ; {68367}
    CMP $&table_00AC96+3, X ; {68370}
    BCC loc_010B26        ; {68373}

  loc_010B17:
    REP #$20              ; {68375}
    TXA                   ; {68377}
    CLC                   ; {68378}
    ADC #$000B            ; {68379}
    TAX                   ; {68382}
    SEP #$20              ; {68383}
    BRA loc_010AF8        ; {68385}

  loc_010B23:
    PLP                   ; {68387}
    CLC                   ; {68388}
    RTL                   ; {68389}

  loc_010B26:
    REP #$20              ; {68390}
    LDA $&table_00AC96, X ; {68392}
    AND #$00FF            ; {68395}
    ASL                   ; {68398}
    ASL                   ; {68399}
    ASL                   ; {68400}
    ASL                   ; {68401}
    STA $00               ; {68402}
    LDA $&table_00AC96+1, X ; {68404}
    AND #$00FF            ; {68407}
    ASL                   ; {68410}
    ASL                   ; {68411}
    ASL                   ; {68412}
    ASL                   ; {68413}
    CLC                   ; {68414}
    ADC #$0010            ; {68415}
    STA $02               ; {68418}
    LDA $&table_00AC96+2, X ; {68420}
    AND #$00FF            ; {68423}
    ASL                   ; {68426}
    ASL                   ; {68427}
    ASL                   ; {68428}
    ASL                   ; {68429}
    SEC                   ; {68430}
    SBC #$000F            ; {68431}
    STA $04               ; {68434}
    LDA $&table_00AC96+3, X ; {68436}
    AND #$00FF            ; {68439}
    ASL                   ; {68442}
    ASL                   ; {68443}
    ASL                   ; {68444}
    ASL                   ; {68445}
    SEC                   ; {68446}
    SBC #$000F            ; {68447}
    STA $06               ; {68450}
    LDA $player_x         ; {68452}
    SEC                   ; {68455}
    SBC $00               ; {68456}
    CMP $04               ; {68458}
    BCS loc_010B23        ; {68460}
    LDA $player_y         ; {68462}
    SEC                   ; {68465}
    SBC $02               ; {68466}
    CMP $06               ; {68468}
    BCS loc_010B23        ; {68470}
    SEP #$20              ; {68472}
    LDA $&table_00AC96+4, X ; {68474}
    STA $area_next        ; {68477}
    LDA $&table_00AC96+5, X ; {68480}
    STA $scene_next       ; {68483}
    LDA $&table_00AC96+6, X ; {68486}
    STA $warp_dest_anim   ; {68489}
    LDY $&table_00AC96+7, X ; {68492}
    STY $warp_dest_x      ; {68495}
    LDY $&table_00AC96+9, X ; {68498}
    STY $warp_dest_y      ; {68501}
    PLP                   ; {68504}
    SEC                   ; {68505}
    RTL                   ; {68506}
}

code_010B9B {
    LDX $03AC             ; {68507}

  loc_010B9E:
    LDA $&table_00B69A, X ; {68510}
    CMP #$FF              ; {68513}
    BEQ loc_010C23        ; {68515}
    CMP $player_tile_x    ; {68517}
    BNE loc_010C1C        ; {68520}
    LDA $&table_00B69A+1, X ; {68522}
    CMP $player_tile_y    ; {68525}
    BNE loc_010C1C        ; {68528}
    LDA $&table_00B69A+3, X ; {68530}
    XBA                   ; {68533}
    LDA $&table_00B69A+2, X ; {68534}
    LDY #$1A9E            ; {68537}
    JSL $@lib_0273A2.code_0273A2 ; {68540}
    BCC loc_010C23        ; {68544}
    REP #$20              ; {68546}
    LDA $&table_00B69A+2, X ; {68548}
    ASL                   ; {68551}
    ASL                   ; {68552}
    ASL                   ; {68553}
    ASL                   ; {68554}
    ASL                   ; {68555}
    CLC                   ; {68556}
    ADC #$&data_00BA0D    ; {68557}
    TAX                   ; {68560}
    LDY #$1C6D            ; {68561}
    LDA #$0007            ; {68564}
    MVN #$01, #$^data_00BA0D ; {68567}
    SEP #$20              ; {68570}
    LDA $03A8             ; {68572}
    CLC                   ; {68575}
    ADC #$02              ; {68576}
    STA $1C6E             ; {68578}
    JSR $&lib_shared_01112A.code_01112A ; {68581}
    LDA #$01              ; {68584}
    STA $1C75             ; {68586}
    INC $1C6C             ; {68589}
    LDA #$23              ; {68592}

  loc_010BF2:
    JSL $@engine_000000.code_000173 ; {68594}
    DEC                   ; {68598}
    BNE loc_010BF2        ; {68599}
    STZ $1C6C             ; {68601}
    REP #$20              ; {68604}
    LDX $03AA             ; {68606}
    LDA $03A8             ; {68609}
    EOR #$0001            ; {68612}
    STA $03A8             ; {68615}
    BEQ loc_010C0E        ; {68618}
    INX                   ; {68620}
    INX                   ; {68621}

  loc_010C0E:
    LDA $&table_00B69A, X ; {68622}
    SEC                   ; {68625}
    SBC #$&table_00B69A   ; {68626}
    STA $03AC             ; {68629}
    SEP #$20              ; {68632}
    SEC                   ; {68634}
    RTL                   ; {68635}

  loc_010C1C:
    INX                   ; {68636}
    INX                   ; {68637}
    INX                   ; {68638}
    INX                   ; {68639}
    BRL loc_010B9E        ; {68640}

  loc_010C23:
    CLC                   ; {68643}
    RTL                   ; {68644}
}

code_010C25 {
    STX $00               ; {68645}
    LDX #$0000            ; {68647}
    TXY                   ; {68650}

  loc_010C2B:
    LDA $&data_00BA0D, X  ; {68651}
    CMP #$FF              ; {68654}
    BEQ loc_010C57        ; {68656}
    LDA $&data_00BA0D+B, X ; {68658}
    CMP $location_id      ; {68661}
    BNE loc_010C4A        ; {68664}
    LDA $&data_00BA0D+C, X ; {68666}
    CMP $player_tile_x    ; {68669}
    BNE loc_010C4A        ; {68672}
    LDA $&data_00BA0D+D, X ; {68674}
    CMP $player_tile_y    ; {68677}
    BEQ loc_010C58        ; {68680}

  loc_010C4A:
    REP #$20              ; {68682}
    TXA                   ; {68684}
    CLC                   ; {68685}
    ADC #$0020            ; {68686}
    TAX                   ; {68689}
    SEP #$20              ; {68690}
    INY                   ; {68692}
    BRA loc_010C2B        ; {68693}

  loc_010C57:
    RTL                   ; {68695}

  loc_010C58:
    LDA $0456             ; {68696}
    BEQ loc_010C60        ; {68699}
    DEC $0456             ; {68701}

  loc_010C60:
    PHX                   ; {68704}
    LDA $&data_00BA0D+8, X ; {68705}
    PHP                   ; {68708}
    LDX $00               ; {68709}
    LDA #$FF              ; {68711}
    STA $7E8000, X        ; {68713}
    PLP                   ; {68717}
    BEQ loc_010C74        ; {68718}
    STA $7EC000, X        ; {68720}

  loc_010C74:
    PLX                   ; {68724}
    LDA $&data_00BA0D+E, X ; {68725}
    ORA $&data_00BA0D+F, X ; {68728}
    BNE loc_010C80        ; {68731}
    BRL loc_010D18        ; {68733}

  loc_010C80:
    PHX                   ; {68736}
    LDA $&data_00BA0D+A, X ; {68737}
    ORA #$80              ; {68740}
    TYX                   ; {68742}
    STA $7F0203, X        ; {68743}
    REP #$20              ; {68747}
    TYA                   ; {68749}
    LDY #$1ADE            ; {68750}
    JSL $@lib_027348.code_027348 ; {68753}
    LDY #$1A9E            ; {68757}
    JSL $@lib_027348.code_027348 ; {68760}
    SEP #$20              ; {68764}
    PLX                   ; {68766}
    LDA $&data_00BA0D, X  ; {68767}
    CMP $location_id      ; {68770}
    BNE loc_010CFD        ; {68773}
    REP #$20              ; {68775}
    LDA $&data_00BA0D+E, X ; {68777}
    AND #$00FF            ; {68780}
    ASL                   ; {68783}
    ASL                   ; {68784}
    ASL                   ; {68785}
    ASL                   ; {68786}
    STA $16               ; {68787}
    LDA $&data_00BA0D+F, X ; {68789}
    AND #$00FF            ; {68792}
    ASL                   ; {68795}
    ASL                   ; {68796}
    ASL                   ; {68797}
    ASL                   ; {68798}
    STA $18               ; {68799}
    PHX                   ; {68801}
    TXA                   ; {68802}
    CLC                   ; {68803}
    ADC #$&data_00BA0D    ; {68804}
    TAX                   ; {68807}
    LDY #$1C6D            ; {68808}
    LDA #$0007            ; {68811}
    MVN #$01, #$^data_00BA0D ; {68814}
    PLX                   ; {68817}
    SEP #$20              ; {68818}
    LDA $&data_00BA0D+8, X ; {68820}
    BEQ loc_010CFA        ; {68823}
    LSR                   ; {68825}
    BCC loc_010CE1        ; {68826}
    JSR $&lib_shared_01112A.code_01125E ; {68828}
    BRA loc_010CE4        ; {68831}

  loc_010CE1:
    JSR $&lib_shared_01112A.code_0111CB ; {68833}

  loc_010CE4:
    BRK #$94              ; {68836}
    JSL $@engine_000000.code_000173 ; {68838}
    LDA #$01              ; {68842}
    STA $1C75             ; {68844}
    LDA #$23              ; {68847}

  loc_010CF1:
    JSL $@engine_000000.code_000173 ; {68849}
    DEC                   ; {68853}
    BNE loc_010CF1        ; {68854}
    BRA loc_010D03        ; {68856}

  loc_010CFA:
    JSR $&lib_shared_01112A.code_0111CB ; {68858}

  loc_010CFD:
    JSL $@engine_000000.code_000173 ; {68861}
    BRK #$94              ; {68865}

  loc_010D03:
    LDA #$01              ; {68867}
    STA $1C75             ; {68869}
    INC $1C6C             ; {68872}
    LDA #$23              ; {68875}

  loc_010D0D:
    JSL $@engine_000000.code_000173 ; {68877}
    DEC                   ; {68881}
    BNE loc_010D0D        ; {68882}
    STZ $1C6C             ; {68884}
    RTL                   ; {68887}

  loc_010D18:
    PHX                   ; {68888}
    LDA $&data_00BA0D+A, X ; {68889}
    ORA #$C0              ; {68892}
    TYX                   ; {68894}
    STA $7F0203, X        ; {68895}
    PLX                   ; {68899}
    LDA $&data_00BA0D, X  ; {68900}
    CMP $location_id      ; {68903}
    BNE loc_010D54        ; {68906}
    REP #$20              ; {68908}
    LDA $&data_00BA0D+2, X ; {68910}
    AND #$00FF            ; {68913}
    ASL                   ; {68916}
    ASL                   ; {68917}
    ASL                   ; {68918}
    ASL                   ; {68919}
    STA $16               ; {68920}
    LDA $&data_00BA0D+3, X ; {68922}
    AND #$00FF            ; {68925}
    ASL                   ; {68928}
    ASL                   ; {68929}
    ASL                   ; {68930}
    ASL                   ; {68931}
    STA $18               ; {68932}
    JSL $@lib_027462_part1.code_0272B8 ; {68934}
    SEP #$20              ; {68938}
    LDA #$01              ; {68940}
    STA $tile_type_map, X ; {68942}
    BRA loc_010CFD        ; {68946}

  loc_010D54:
    BRK #$98              ; {68948}
    LDA $area_current     ; {68950}
    STA $return_area      ; {68953}
    LDA $scene_current    ; {68956}
    STA $return_scene     ; {68959}
    LDA $&data_00BA0D+1D, X ; {68962}
    STA $warp_dest_anim   ; {68965}
    REP #$20              ; {68968}
    LDA $player_x         ; {68970}
    STA $return_x         ; {68973}
    LDA $player_y         ; {68976}
    SEC                   ; {68979}
    SBC #$0010            ; {68980}
    STA $return_y         ; {68983}
    LDA $&data_00BA0D+2, X ; {68986}
    AND #$00FF            ; {68989}
    ASL                   ; {68992}
    ASL                   ; {68993}
    ASL                   ; {68994}
    ASL                   ; {68995}
    STA $warp_dest_x      ; {68996}
    LDA $&data_00BA0D+3, X ; {68999}
    AND #$00FF            ; {69002}
    ASL                   ; {69005}
    ASL                   ; {69006}
    ASL                   ; {69007}
    ASL                   ; {69008}
    STA $warp_dest_y      ; {69009}
    LDA $&data_00BA0D, X  ; {69012}
    AND #$00FF            ; {69015}
    ASL                   ; {69018}
    TAX                   ; {69019}
    SEP #$20              ; {69020}
    LDA #$80              ; {69022}
    STA $transition_type  ; {69024}
    LDA $@lib_0109D6_part5.word_01762C, X ; {69027}
    STA $area_next        ; {69031}
    LDA $@lib_0109D6_part5.word_01762C+1, X ; {69034}
    STA $scene_next       ; {69038}
    LDA #$20              ; {69041}
    STA $03B4             ; {69043}
    STY $0405             ; {69046}
    INC $return_active    ; {69049}
    RTL                   ; {69052}
}