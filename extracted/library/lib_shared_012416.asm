?BANK 02

?INCLUDE 'data_04F000'

!VMADDL                         2116
!MDMAEN                         420B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305

---------------------------------------------

code_012416 {
    LDX #$2000            ; {74774}
    STX $VMADDL           ; {74777}
    LDA #$01              ; {74780}
    STA $DMAP0            ; {74782}
    LDA #$18              ; {74785}
    STA $BBAD0            ; {74787}
    LDX #$&graphics_04B000 ; {74790}
    STX $A1T0L            ; {74793}
    LDA #$^graphics_04B000 ; {74796}
    STA $A1B0             ; {74798}
    LDX #$2000            ; {74801}
    STX $DAS0L            ; {74804}
    LDA #$01              ; {74807}
    STA $MDMAEN           ; {74809}
    RTS                   ; {74812}
}

code_01243D {
    PHB                   ; {74813}
    REP #$20              ; {74814}
    LDX #$&data_04F000.binary_04F100 ; {74816}
    LDY #$0000            ; {74819}
    LDA #$00FF            ; {74822}
    MVN #$7F, #$^data_04F000.binary_04F100 ; {74825}
    SEP #$20              ; {74828}
    PLB                   ; {74830}
    RTS                   ; {74831}
}