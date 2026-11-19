?BANK 02

?INCLUDE 'engine_000000'

!scroll_bg3_y                   0388
!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_0126CF {
    PHP                   ; {75471}
    PHB                   ; {75472}
    SEP #$20              ; {75473}
    LDA #$02              ; {75475}
    PHA                   ; {75477}
    PLB                   ; {75478}
    LDX #$0702            ; {75479}
    PHX                   ; {75482}

  loc_0126DB:
    LDA $0000, Y          ; {75483}
    BNE loc_0126E3        ; {75486}
    BRL loc_012765        ; {75488}

  loc_0126E3:
    INY                   ; {75491}
    CMP #$0D              ; {75492}
    BEQ loc_012715        ; {75494}
    CMP #$14              ; {75496}
    BEQ loc_01274F        ; {75498}
    PHX                   ; {75500}
    PHA                   ; {75501}
    STA $bg3_tilemap_buffer, X ; {75502}
    LDA #$21              ; {75506}
    STA $7F7001, X        ; {75508}
    REP #$20              ; {75512}
    TXA                   ; {75514}
    CLC                   ; {75515}
    ADC #$0040            ; {75516}
    AND #$07FF            ; {75519}
    TAX                   ; {75522}
    SEP #$20              ; {75523}
    PLA                   ; {75525}
    STA $bg3_tilemap_buffer, X ; {75526}
    LDA #$20              ; {75530}
    STA $7F7001, X        ; {75532}
    PLX                   ; {75536}
    INX                   ; {75537}
    INX                   ; {75538}
    BRA loc_0126DB        ; {75539}

  loc_012715:
    LDA #$01              ; {75541}
    TSB $vram_upload_flags ; {75543}
    LDA #$20              ; {75546}

  loc_01271C:
    INC $scroll_bg3_y     ; {75548}
    JSL $@engine_000000.code_0001BE ; {75551}
    DEC                   ; {75555}
    BNE loc_01271C        ; {75556}
    REP #$20              ; {75558}
    PLA                   ; {75560}
    CLC                   ; {75561}
    ADC #$0100            ; {75562}
    AND #$07FF            ; {75565}
    TAX                   ; {75568}
    PHA                   ; {75569}
    SEP #$20              ; {75570}
    PHX                   ; {75572}
    LDA #$80              ; {75573}
    STA $0C               ; {75575}

  loc_012739:
    LDA #$00              ; {75577}
    STA $bg3_tilemap_buffer, X ; {75579}
    LDA #$20              ; {75583}
    STA $7F7001, X        ; {75585}
    INX                   ; {75589}
    INX                   ; {75590}
    DEC $0C               ; {75591}
    BNE loc_012739        ; {75593}
    PLX                   ; {75595}
    BRL loc_0126DB        ; {75596}

  loc_01274F:
    LDA $0000, Y          ; {75599}
    INY                   ; {75602}
    REP #$20              ; {75603}
    AND #$00FF            ; {75605}
    ASL                   ; {75608}
    PHX                   ; {75609}
    CLC                   ; {75610}
    ADC $01, S            ; {75611}
    STA $01, S            ; {75613}
    PLX                   ; {75615}
    SEP #$20              ; {75616}
    BRL loc_0126DB        ; {75618}

  loc_012765:
    PLX                   ; {75621}
    PLB                   ; {75622}
    PLP                   ; {75623}
    RTL                   ; {75624}
}