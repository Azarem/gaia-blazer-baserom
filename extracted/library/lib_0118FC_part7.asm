?BANK 02

?INCLUDE 'lib_shared_0131B7'

!INIDISP                        2100
!NMITIMEN                       4200

---------------------------------------------

code_013176 {
    PHP                   ; {78198}
    SEP #$20              ; {78199}
    JSL $@lib_shared_0131B7.code_0131B7 ; {78201}
    LDA #$A1              ; {78205}
    STA $NMITIMEN         ; {78207}
    LDA #$0F              ; {78210}
    STA $INIDISP          ; {78212}
    INC $03D2             ; {78215}
    PLP                   ; {78218}
    RTL                   ; {78219}
}