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
    SEP #$20
    LDA #$01
    STA $OBJSEL
    LDA #$09
    STA $BGMODE
    LDA #$63
    STA $BG1SC
    LDA #$73
    STA $BG2SC
    LDA #$58
    STA $BG3SC
    LDA #$00
    STA $BG12NBA
    LDA #$04
    STA $BG34NBA
    LDA #$33
    STA $W12SEL
    STA $W34SEL
    STA $WOBJSEL
    LDA #$00
    STA $WH0
    LDA #$FF
    STA $WH1
    LDA #$00
    STA $WH2
    STA $WH3
    LDA #$82
    STA $CGWSEL
    LDA #$07
    STA $TM
    RTL 
}