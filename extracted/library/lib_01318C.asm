?BANK 02

?INCLUDE 'lib_shared_0131B7'

!INIDISP                        2100
!NMITIMEN                       4200

---------------------------------------------

code_01318C {
    PHP                   ; {78220}
    SEP #$20              ; {78221}
    JSL $@lib_shared_0131B7.code_0131B7 ; {78223}
    LDA #$01              ; {78227}
    STA $NMITIMEN         ; {78229}
    LDA #$80              ; {78232}
    STA $INIDISP          ; {78234}
    STZ $03D2             ; {78237}
    PLP                   ; {78240}
    RTL                   ; {78241}
}