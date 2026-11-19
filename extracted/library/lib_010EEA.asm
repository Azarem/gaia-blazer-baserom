?BANK 02

?INCLUDE 'lib_010EEA_part2'
?INCLUDE 'lib_shared_0131D1'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_pages                0343
!vram_write_queue               1C7B

---------------------------------------------

code_010EEA {
    LDA $1C75             ; {69354}
    BNE loc_010EF0        ; {69357}
    RTL                   ; {69359}

  loc_010EF0:
    LDA $1C6C             ; {69360}
    BNE loc_010EF8        ; {69363}
    BRL loc_010FAD        ; {69365}

  loc_010EF8:
    PHP                   ; {69368}
    REP #$20              ; {69369}
    LDY #$0000            ; {69371}
    LDA $scroll_bg1_x     ; {69374}
    AND #$FFF0            ; {69377}
    STA $1C77             ; {69380}
    LDA $scroll_bg1_y     ; {69383}
    AND #$FFF0            ; {69386}
    STA $1C79             ; {69389}
    LDA $1C75             ; {69392}
    DEC                   ; {69395}
    ASL                   ; {69396}
    ASL                   ; {69397}
    ASL                   ; {69398}
    ASL                   ; {69399}
    ASL                   ; {69400}
    TAX                   ; {69401}
    LDA #$0010            ; {69402}
    STA $0C               ; {69405}

  loc_010F1F:
    LDA $@lib_010EEA_part2.binary_016E2D, X ; {69407}
    AND #$00FF            ; {69411}
    ASL                   ; {69414}
    ASL                   ; {69415}
    ASL                   ; {69416}
    ASL                   ; {69417}
    CLC                   ; {69418}
    ADC $1C77             ; {69419}
    STA $16               ; {69422}
    LDA $@lib_010EEA_part2.binary_016E2D+10, X ; {69424}
    AND #$00FF            ; {69428}
    ASL                   ; {69431}
    ASL                   ; {69432}
    ASL                   ; {69433}
    ASL                   ; {69434}
    CLC                   ; {69435}
    ADC $1C79             ; {69436}
    STA $18               ; {69439}
    PHX                   ; {69441}
    JSR $&code_011062     ; {69442}
    STA $vram_write_queue, Y ; {69445}
    INC                   ; {69448}
    STA $1C7F, Y          ; {69449}
    CLC                   ; {69452}
    ADC #$001F            ; {69453}
    STA $1C83, Y          ; {69456}
    INC                   ; {69459}
    STA $1C87, Y          ; {69460}
    LDA $7E2000, X        ; {69463}
    AND $035C             ; {69467}
    ORA $036A             ; {69470}
    STA $1C7D, Y          ; {69473}
    LDA $7E2002, X        ; {69476}
    AND $035C             ; {69480}
    ORA $036A             ; {69483}
    STA $1C81, Y          ; {69486}
    LDA $7E2004, X        ; {69489}
    AND $035C             ; {69493}
    ORA $036A             ; {69496}
    STA $1C85, Y          ; {69499}
    LDA $7E2006, X        ; {69502}
    AND $035C             ; {69506}
    ORA $036A             ; {69509}
    STA $1C89, Y          ; {69512}
    PLX                   ; {69515}
    TYA                   ; {69516}
    CLC                   ; {69517}
    ADC #$0010            ; {69518}
    TAY                   ; {69521}
    INX                   ; {69522}
    DEC $0C               ; {69523}
    BNE loc_010F1F        ; {69525}
    LDA #$0000            ; {69527}
    STA $vram_write_queue, Y ; {69530}
    INC $1C75             ; {69533}
    LDA $1C75             ; {69536}
    CMP #$0024            ; {69539}
    BCC loc_010FAB        ; {69542}
    STZ $1C75             ; {69544}

  loc_010FAB:
    PLP                   ; {69547}
    RTL                   ; {69548}

  loc_010FAD:
    PHP                   ; {69549}
    REP #$20              ; {69550}
    LDY #$0000            ; {69552}
    LDA $scroll_bg1_x     ; {69555}
    AND #$FFF0            ; {69558}
    STA $1C77             ; {69561}
    LDA $scroll_bg1_y     ; {69564}
    AND #$FFF0            ; {69567}
    STA $1C79             ; {69570}
    LDA $1C75             ; {69573}
    DEC                   ; {69576}
    ASL                   ; {69577}
    ASL                   ; {69578}
    ASL                   ; {69579}
    ASL                   ; {69580}
    ASL                   ; {69581}
    TAX                   ; {69582}
    LDA #$0010            ; {69583}
    STA $0C               ; {69586}

  loc_010FD4:
    LDA $@lib_010EEA_part2.binary_016E2D, X ; {69588}
    AND #$00FF            ; {69592}
    ASL                   ; {69595}
    ASL                   ; {69596}
    ASL                   ; {69597}
    ASL                   ; {69598}
    CLC                   ; {69599}
    ADC $1C77             ; {69600}
    STA $16               ; {69603}
    LDA $@lib_010EEA_part2.binary_016E2D+10, X ; {69605}
    AND #$00FF            ; {69609}
    ASL                   ; {69612}
    ASL                   ; {69613}
    ASL                   ; {69614}
    ASL                   ; {69615}
    CLC                   ; {69616}
    ADC $1C79             ; {69617}
    STA $18               ; {69620}
    PHX                   ; {69622}
    JSR $&code_0110C6     ; {69623}
    STA $vram_write_queue, Y ; {69626}
    INC                   ; {69629}
    STA $1C7F, Y          ; {69630}
    CLC                   ; {69633}
    ADC #$001F            ; {69634}
    STA $1C83, Y          ; {69637}
    INC                   ; {69640}
    STA $1C87, Y          ; {69641}
    LDA $7E2800, X        ; {69644}
    AND $0360             ; {69648}
    ORA $036E             ; {69651}
    STA $1C7D, Y          ; {69654}
    LDA $7E2802, X        ; {69657}
    AND $0360             ; {69661}
    ORA $036E             ; {69664}
    STA $1C81, Y          ; {69667}
    LDA $7E2804, X        ; {69670}
    AND $0360             ; {69674}
    ORA $036E             ; {69677}
    STA $1C85, Y          ; {69680}
    LDA $7E2806, X        ; {69683}
    AND $0360             ; {69687}
    ORA $036E             ; {69690}
    STA $1C89, Y          ; {69693}
    PLX                   ; {69696}
    TYA                   ; {69697}
    CLC                   ; {69698}
    ADC #$0010            ; {69699}
    TAY                   ; {69702}
    INX                   ; {69703}
    DEC $0C               ; {69704}
    BNE loc_010FD4        ; {69706}
    LDA #$0000            ; {69708}
    STA $vram_write_queue, Y ; {69711}
    INC $1C75             ; {69714}
    LDA $1C75             ; {69717}
    CMP #$0024            ; {69720}
    BCC loc_011060        ; {69723}
    STZ $1C75             ; {69725}

  loc_011060:
    PLP                   ; {69728}
    RTL                   ; {69729}
}

code_011062 {
    LDA $18               ; {69730}
    PHA                   ; {69732}
    SEP #$20              ; {69733}
    LDA $map_width_pages  ; {69735}
    JSL $@lib_shared_0131D1.code_0131D1 ; {69738}
    STA $02, S            ; {69742}
    LDA $16               ; {69744}
    LSR                   ; {69746}
    LSR                   ; {69747}
    LSR                   ; {69748}
    LSR                   ; {69749}
    AND #$0F              ; {69750}
    CLC                   ; {69752}
    ADC $01, S            ; {69753}
    STA $01, S            ; {69755}
    LDA $17               ; {69757}
    CLC                   ; {69759}
    ADC $02, S            ; {69760}
    STA $02, S            ; {69762}
    REP #$20              ; {69764}
    PLX                   ; {69766}
    LDA $7E8000, X        ; {69767}
    AND #$00FF            ; {69771}
    ASL                   ; {69774}
    ASL                   ; {69775}
    ASL                   ; {69776}
    TAX                   ; {69777}
    LDA $18               ; {69778}
    AND #$00F8            ; {69780}
    ASL                   ; {69783}
    ASL                   ; {69784}
    PHA                   ; {69785}
    LDA $16               ; {69786}
    AND #$00F8            ; {69788}
    LSR                   ; {69791}
    LSR                   ; {69792}
    LSR                   ; {69793}
    CLC                   ; {69794}
    ADC $01, S            ; {69795}
    STA $01, S            ; {69797}
    LDA $16               ; {69799}
    AND #$0100            ; {69801}
    ASL                   ; {69804}
    ASL                   ; {69805}
    CLC                   ; {69806}
    ADC $01, S            ; {69807}
    STA $01, S            ; {69809}
    LDA $18               ; {69811}
    AND #$0100            ; {69813}
    ASL                   ; {69816}
    ASL                   ; {69817}
    ASL                   ; {69818}
    CLC                   ; {69819}
    ADC $01, S            ; {69820}
    STA $01, S            ; {69822}
    PLA                   ; {69824}
    CLC                   ; {69825}
    ADC #$6000            ; {69826}
    RTS                   ; {69829}
}

code_0110C6 {
    LDA $18               ; {69830}
    PHA                   ; {69832}
    SEP #$20              ; {69833}
    LDA $map_width_pages  ; {69835}
    JSL $@lib_shared_0131D1.code_0131D1 ; {69838}
    STA $02, S            ; {69842}
    LDA $16               ; {69844}
    LSR                   ; {69846}
    LSR                   ; {69847}
    LSR                   ; {69848}
    LSR                   ; {69849}
    AND #$0F              ; {69850}
    CLC                   ; {69852}
    ADC $01, S            ; {69853}
    STA $01, S            ; {69855}
    LDA $17               ; {69857}
    CLC                   ; {69859}
    ADC $02, S            ; {69860}
    STA $02, S            ; {69862}
    REP #$20              ; {69864}
    PLX                   ; {69866}
    LDA $7EC000, X        ; {69867}
    AND #$00FF            ; {69871}
    ASL                   ; {69874}
    ASL                   ; {69875}
    ASL                   ; {69876}
    TAX                   ; {69877}
    LDA $18               ; {69878}
    AND #$00F8            ; {69880}
    ASL                   ; {69883}
    ASL                   ; {69884}
    PHA                   ; {69885}
    LDA $16               ; {69886}
    AND #$00F8            ; {69888}
    LSR                   ; {69891}
    LSR                   ; {69892}
    LSR                   ; {69893}
    CLC                   ; {69894}
    ADC $01, S            ; {69895}
    STA $01, S            ; {69897}
    LDA $16               ; {69899}
    AND #$0100            ; {69901}
    ASL                   ; {69904}
    ASL                   ; {69905}
    CLC                   ; {69906}
    ADC $01, S            ; {69907}
    STA $01, S            ; {69909}
    LDA $18               ; {69911}
    AND #$0100            ; {69913}
    ASL                   ; {69916}
    ASL                   ; {69917}
    ASL                   ; {69918}
    CLC                   ; {69919}
    ADC $01, S            ; {69920}
    STA $01, S            ; {69922}
    PLA                   ; {69924}
    CLC                   ; {69925}
    ADC #$7000            ; {69926}
    RTS                   ; {69929}
}