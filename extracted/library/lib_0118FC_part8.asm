?BANK 02

!NMITIMEN                       4200
!RDNMI                          4210

---------------------------------------------

code_0131A2 {
    LDA $RDNMI            ; {78242}
    LDA #$A1              ; {78245}
    STA $NMITIMEN         ; {78247}
    INC $03D2             ; {78250}
    RTL                   ; {78253}
}

code_0131AE {
    LDA #$01              ; {78254}
    STA $NMITIMEN         ; {78256}
    STZ $03D2             ; {78259}
    RTL                   ; {78262}
}