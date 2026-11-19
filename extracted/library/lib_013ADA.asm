?BANK 02

!OBJSEL                         2101
!BGMODE                         2105
!BG1SC                          2107
!BG2SC                          2108
!BG3SC                          2109
!BG12NBA                        210B
!BG34NBA                        210C
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!WH0                            2126
!WH1                            2127
!WH2                            2128
!WH3                            2129
!TM                             212C
!CGWSEL                         2130

---------------------------------------------

code_013ADA {
    SEP #$20              ; {80602}
    LDA #$01              ; {80604}
    STA $OBJSEL           ; {80606}
    LDA #$09              ; {80609}
    STA $BGMODE           ; {80611}
    LDA #$63              ; {80614}
    STA $BG1SC            ; {80616}
    LDA #$73              ; {80619}
    STA $BG2SC            ; {80621}
    LDA #$58              ; {80624}
    STA $BG3SC            ; {80626}
    LDA #$00              ; {80629}
    STA $BG12NBA          ; {80631}
    LDA #$04              ; {80634}
    STA $BG34NBA          ; {80636}
    LDA #$33              ; {80639}
    STA $W12SEL           ; {80641}
    STA $W34SEL           ; {80644}
    STA $WOBJSEL          ; {80647}
    LDA #$00              ; {80650}
    STA $WH0              ; {80652}
    LDA #$FF              ; {80655}
    STA $WH1              ; {80657}
    LDA #$00              ; {80660}
    STA $WH2              ; {80662}
    STA $WH3              ; {80665}
    LDA #$82              ; {80668}
    STA $CGWSEL           ; {80670}
    LDA #$07              ; {80673}
    STA $TM               ; {80675}
    RTL                   ; {80678}
}