?BANK 02

!NMITIMEN                       4200
!RDNMI                          4210

---------------------------------------------

code_0131A2 {
    LDA $RDNMI
    LDA #$A1
    STA $NMITIMEN
    INC $03D2
    RTL 
}

code_0131AE {
    LDA #$01
    STA $NMITIMEN
    STZ $03D2
    RTL 
}