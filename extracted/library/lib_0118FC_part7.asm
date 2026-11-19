?BANK 02

?INCLUDE 'lib_shared_0131B7'

!INIDISP                        2100
!NMITIMEN                       4200

---------------------------------------------

code_013176 {
    PHP 
    SEP #$20
    JSL $@lib_shared_0131B7.code_0131B7
    LDA #$A1
    STA $NMITIMEN
    LDA #$0F
    STA $INIDISP
    INC $03D2
    PLP 
    RTL 
}