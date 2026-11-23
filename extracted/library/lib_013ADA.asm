; Default PPU layout written at boot (file offsets 80602-80678, SNES $02:BADA-$BB26, bank 02).
; 
; === MODEL ===
; ApplyBootPpuLayout runs once, right after InitHardwareAndClearWram (engine_boot_main_loop BootGame). InitHardwareAndClearWram zeroes every PPU register; this routine then sets the layout that the title screen and the first scenes expect before any scene profile is applied: Mode 1 with BG3 priority, BG1 map at VRAM word $6000 (BG1SC $63, 64x64), BG2 map at $7000 (BG2SC $73), BG3 map at $5800 (BG3SC $58), BG1 and BG2 characters at word 0, BG3 characters at $4000, windows 1 on every layer with the window spanning columns 0-255, CGWSEL = $82 and the main screen TM = $07 (BG1, BG2 and BG3).
; 
; === NOTES ===
; - The values are the ones a scene profile computes later (ApplySceneProfile), so the boot layout only matters until the first scene is loaded.
---------------------------------------------

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

; Writes the default PPU layout.
; 
; When: once at boot, after InitHardwareAndClearWram.
; Sees: nothing yet; the screen is still in forced blank.
; Why: the register reset leaves every layer off; this gives the title screen its layers and map bases.
; In: JSL; M = 8.
; Out: OBJSEL = $01, BGMODE = $09, BG1SC = $63, BG2SC = $73, BG3SC = $58, BG12NBA = 0, BG34NBA = 4, W12SEL = W34SEL = WOBJSEL = $33, WH0-WH3 (window 1 over columns 0-255), CGWSEL = $82, TM = $07.
; Clobbers: A.

ApplyBootPpuLayout {
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