?BANK 02

?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_003005'
?INCLUDE 'lib_01186E'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!TMW                            212E
!TSW                            212F
!CGWSEL                         2130

---------------------------------------------

code_0116C3 {
    LDA $1B82             ; {71363}
    AND #$0002            ; {71366}
    BNE loc_0116CC        ; {71369}
    RTL                   ; {71371}

  loc_0116CC:
    SEP #$20              ; {71372}
    STZ $W12SEL           ; {71374}
    STZ $W34SEL           ; {71377}
    LDA #$30              ; {71380}
    STA $WOBJSEL          ; {71382}
    LDA #$12              ; {71385}
    STA $CGWSEL           ; {71387}
    REP #$20              ; {71390}
    BRA loc_01175D        ; {71392}

  code_0116E2:
    LDA $1B82             ; {71394}
    AND #$0010            ; {71397}
    BNE loc_0116EB        ; {71400}
    RTL                   ; {71402}

  loc_0116EB:
    SEP #$20              ; {71403}
    LDA #$20              ; {71405}
    STA $W12SEL           ; {71407}
    STA $03C3             ; {71410}
    STZ $W34SEL           ; {71413}
    STZ $WOBJSEL          ; {71416}
    LDA #$01              ; {71419}
    STA $038A             ; {71421}
    STA $038C             ; {71424}
    REP #$20              ; {71427}
    BRA loc_01175D        ; {71429}

  code_011707:
    LDA $1B82             ; {71431}
    AND #$0008            ; {71434}
    BNE loc_011710        ; {71437}
    RTL                   ; {71439}

  loc_011710:
    SEP #$20              ; {71440}
    LDA #$20              ; {71442}
    STA $W12SEL           ; {71444}
    STA $03C3             ; {71447}
    STZ $W34SEL           ; {71450}
    LDA #$01              ; {71453}
    STA $WOBJSEL          ; {71455}
    LDA #$01              ; {71458}
    STA $038A             ; {71460}
    STA $038C             ; {71463}
    REP #$20              ; {71466}
    BRA loc_01175D        ; {71468}

  code_01172E:
    LDA $1B82             ; {71470}
    AND #$0004            ; {71473}
    BNE loc_011737        ; {71476}
    RTL                   ; {71478}

  loc_011737:
    SEP #$20              ; {71479}
    LDA #$33              ; {71481}
    STA $W12SEL           ; {71483}
    STA $03C3             ; {71486}
    STZ $W34SEL           ; {71489}
    STZ $WOBJSEL          ; {71492}
    STZ $TMW              ; {71495}
    LDA #$03              ; {71498}
    STA $TSW              ; {71500}
    LDA #$82              ; {71503}
    STA $CGWSEL           ; {71505}
    REP #$20              ; {71508}
    COP [B0] ( @engine_003005.code_00310F, #$2010 ) ; {71510}

  loc_01175D:
    COP [91]              ; {71517}
    PHX                   ; {71519}
    LDY $03A0             ; {71520}
    LDA $0000, Y          ; {71523}
    SEC                   ; {71526}
    SBC $scroll_bg1_x     ; {71527}
    CLC                   ; {71530}
    ADC #$0008            ; {71531}
    BMI loc_01177A        ; {71534}
    CMP #$0100            ; {71536}
    BCC loc_01177D        ; {71539}
    LDA #$00FF            ; {71541}
    BRA loc_01177D        ; {71544}

  loc_01177A:
    LDA #$0000            ; {71546}

  loc_01177D:
    STA $16               ; {71549}
    LDA $0002, Y          ; {71551}
    SEC                   ; {71554}
    SBC $scroll_bg1_y     ; {71555}
    SEC                   ; {71558}
    SBC #$0008            ; {71559}
    BMI loc_011796        ; {71562}
    CMP #$00E0            ; {71564}
    BCC loc_011799        ; {71567}
    LDA #$00DF            ; {71569}
    BRA loc_011799        ; {71572}

  loc_011796:
    LDA #$0000            ; {71574}

  loc_011799:
    STA $18               ; {71577}
    LDX #$0000            ; {71579}
    TXY                   ; {71582}
    LDA #$00E0            ; {71583}
    STA $0C               ; {71586}
    LDA $18               ; {71588}
    SEC                   ; {71590}
    SBC #$0040            ; {71591}
    BEQ loc_0117ED        ; {71594}
    BPL loc_0117BA        ; {71596}
    EOR #$FFFF            ; {71598}
    INC                   ; {71601}
    CMP #$0080            ; {71602}
    BCS loc_011822        ; {71605}
    TAY                   ; {71607}
    BRA loc_0117ED        ; {71608}

  loc_0117BA:
    TAY                   ; {71610}
    SEC                   ; {71611}
    SBC $0C               ; {71612}
    EOR #$FFFF            ; {71614}
    INC                   ; {71617}
    STA $0C               ; {71618}
    TYA                   ; {71620}
    CMP #$0080            ; {71621}
    BCC loc_0117DD        ; {71624}
    SEC                   ; {71626}
    SBC #$007F            ; {71627}
    TAY                   ; {71630}
    LDA #$FF7F            ; {71631}
    STA $7E7000, X        ; {71634}
    STA $7E7800, X        ; {71638}
    INX                   ; {71642}
    INX                   ; {71643}
    TYA                   ; {71644}

  loc_0117DD:
    ORA #$FF00            ; {71645}
    STA $7E7000, X        ; {71648}
    STA $7E7800, X        ; {71652}
    INX                   ; {71656}
    INX                   ; {71657}
    LDY #$0002            ; {71658}

  loc_0117ED:
    SEP #$20              ; {71661}

  loc_0117EF:
    LDA #$02              ; {71663}
    STA $7E7000, X        ; {71665}
    STA $7E7800, X        ; {71669}
    LDA $16               ; {71673}
    SEC                   ; {71675}
    SBC $&data_00F9F7.binary_00FDC4, Y ; {71676}
    BCS loc_011803        ; {71679}
    LDA #$00              ; {71681}

  loc_011803:
    STA $7E7001, X        ; {71683}
    LDA $16               ; {71687}
    CLC                   ; {71689}
    ADC $&data_00F9F7.binary_00FDC4, Y ; {71690}
    BCC loc_011811        ; {71693}
    LDA #$FF              ; {71695}

  loc_011811:
    STA $7E7801, X        ; {71697}
    INX                   ; {71701}
    INX                   ; {71702}
    INY                   ; {71703}
    INY                   ; {71704}
    DEC $0C               ; {71705}
    BEQ loc_011822        ; {71707}
    CPY #$0080            ; {71709}
    BCC loc_0117EF        ; {71712}

  loc_011822:
    SEP #$20              ; {71714}
    LDA #$01              ; {71716}
    STA $7E7000, X        ; {71718}
    STA $7E7800, X        ; {71722}
    LDA #$FF              ; {71726}
    STA $7E7001, X        ; {71728}
    STA $7E7801, X        ; {71732}
    LDA #$00              ; {71736}
    STA $7E7002, X        ; {71738}
    STA $7E7802, X        ; {71742}
    LDA #$26              ; {71746}
    XBA                   ; {71748}
    LDA #$7E              ; {71749}
    LDY #$7000            ; {71751}
    JSL $@lib_01186E.code_01188A ; {71754}
    LDA #$27              ; {71758}
    XBA                   ; {71760}
    LDA #$7E              ; {71761}
    LDY #$7800            ; {71763}
    JSL $@lib_01186E.code_01188A ; {71766}
    PLX                   ; {71770}
    REP #$20              ; {71771}
    RTL                   ; {71773}
}