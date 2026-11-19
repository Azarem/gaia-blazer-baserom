?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_010EA9_part3'
?INCLUDE 'lib_027348'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_01112A'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131D1'

!map_width_pages                0343
!map_height_pages               0345
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!location_id                    1C6A
!tile_type_map                  7F8000

---------------------------------------------

code_010DBD {
    LDX #$0000            ; {69053}
    TXY                   ; {69056}

  loc_010DC1:
    LDA $&data_00BA0D, X  ; {69057}
    BMI loc_010DE8        ; {69060}
    CMP $location_id      ; {69062}
    BNE loc_010DDB        ; {69065}
    LDA $&data_00BA0D+2, X ; {69067}
    CMP $player_tile_x    ; {69070}
    BNE loc_010DDB        ; {69073}
    LDA $&data_00BA0D+3, X ; {69075}
    CMP $player_tile_y    ; {69078}
    BEQ loc_010DE9        ; {69081}

  loc_010DDB:
    REP #$20              ; {69083}
    TXA                   ; {69085}
    CLC                   ; {69086}
    ADC #$0020            ; {69087}
    TAX                   ; {69090}
    INY                   ; {69091}
    SEP #$20              ; {69092}
    BRA loc_010DC1        ; {69094}

  loc_010DE8:
    RTL                   ; {69096}

  loc_010DE9:
    LDA $&data_00BA0D+9, X ; {69097}
    STA $03C8             ; {69100}
    STZ $03C9             ; {69103}
    PHX                   ; {69106}
    PHY                   ; {69107}
    LDY #$&lib_010EA9_part3.asciistring_016203 ; {69108}
    JSL $@lib_shared_012769.code_012C27 ; {69111}
    JSL $@engine_000000.code_000173 ; {69115}
    PLY                   ; {69119}
    PLX                   ; {69120}
    PHX                   ; {69121}
    TYX                   ; {69122}
    LDA $7F0203, X        ; {69123}
    AND #$BF              ; {69127}
    STA $7F0203, X        ; {69129}
    PLX                   ; {69133}
    REP #$20              ; {69134}
    TYA                   ; {69136}
    PHA                   ; {69137}
    TXA                   ; {69138}
    CLC                   ; {69139}
    ADC #$&data_00BA0D    ; {69140}
    TAX                   ; {69143}
    LDY #$1C6D            ; {69144}
    LDA #$0007            ; {69147}
    MVN #$01, #$^data_00BA0D ; {69150}
    LDA $1C6F             ; {69153}
    AND #$00FF            ; {69156}
    ASL                   ; {69159}
    ASL                   ; {69160}
    ASL                   ; {69161}
    ASL                   ; {69162}
    STA $16               ; {69163}
    LDA $1C70             ; {69165}
    AND #$00FF            ; {69168}
    ASL                   ; {69171}
    ASL                   ; {69172}
    ASL                   ; {69173}
    ASL                   ; {69174}
    STA $18               ; {69175}
    JSL $@lib_027462_part1.code_0272B8 ; {69177}
    PHX                   ; {69181}
    SEP #$20              ; {69182}
    LDA $map_width_pages  ; {69184}
    XBA                   ; {69187}
    LDA $map_height_pages ; {69188}
    JSL $@lib_shared_0131D1.code_0131D1 ; {69191}
    STA $01               ; {69195}
    STZ $00               ; {69197}
    LDY #$0004            ; {69199}

  loc_010E52:
    REP #$20              ; {69202}
    TXA                   ; {69204}
    CLC                   ; {69205}
    ADC $00               ; {69206}
    TAX                   ; {69208}
    SEP #$20              ; {69209}
    CPX #$4000            ; {69211}
    BCS loc_010E63        ; {69214}
    DEY                   ; {69216}
    BNE loc_010E52        ; {69217}

  loc_010E63:
    PLX                   ; {69219}
    BRK #$9C              ; {69220}
    LDA $1C73             ; {69222}
    BNE loc_010E74        ; {69225}
    STZ $1C75             ; {69227}
    JSL $@engine_000000.code_000173 ; {69230}
    BRA loc_010E95        ; {69234}

  loc_010E74:
    JSR $&lib_shared_01112A.code_01112A ; {69236}
    LDA #$01              ; {69239}
    STA $1C75             ; {69241}
    INC $1C6C             ; {69244}
    LDA #$23              ; {69247}

  loc_010E81:
    JSL $@engine_000000.code_000173 ; {69249}
    DEC                   ; {69253}
    BNE loc_010E81        ; {69254}
    STZ $1C6C             ; {69256}
    INC $1C6E             ; {69259}
    LDA $1C6E             ; {69262}
    CMP #$04              ; {69265}
    BCC loc_010E74        ; {69267}

  loc_010E95:
    REP #$20              ; {69269}
    PLA                   ; {69271}
    LDY #$1A9E            ; {69272}
    JSL $@lib_027348.code_027348 ; {69275}
    LDY #$1ADE            ; {69279}
    JSL $@lib_027348.code_027348 ; {69282}
    SEP #$20              ; {69286}
    RTL                   ; {69288}
}

code_010EA9 {
    REP #$20              ; {69289}
    LDA $player_x         ; {69291}
    STA $16               ; {69294}
    LDA $player_y         ; {69296}
    SEC                   ; {69299}
    SBC #$0010            ; {69300}
    STA $18               ; {69303}
    JSL $@lib_027462_part1.code_0272B8 ; {69305}
    SEP #$20              ; {69309}
    LDA $tile_type_map, X ; {69311}
    CMP #$01              ; {69315}
    BNE loc_010ECC        ; {69317}
    JSL $@code_010DBD     ; {69319}
    RTL                   ; {69323}

  loc_010ECC:
    REP #$20              ; {69324}
    LDA $0405             ; {69326}
    ASL                   ; {69329}
    ASL                   ; {69330}
    ASL                   ; {69331}
    ASL                   ; {69332}
    ASL                   ; {69333}
    TAX                   ; {69334}
    SEP #$20              ; {69335}
    LDA $&data_00BA0D+9, X ; {69337}
    STA $03C8             ; {69340}
    STZ $03C9             ; {69343}
    LDY #$&lib_010EA9_part3.asciistring_0161DE ; {69346}
    JSL $@lib_shared_012769.code_012C27 ; {69349}
    RTL                   ; {69353}
}