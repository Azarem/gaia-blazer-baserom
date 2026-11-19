?BANK 02

?INCLUDE 'lib_shared_0131B7'

!INIDISP                        2100
!NMITIMEN                       4200

---------------------------------------------

code_01318C {
    PHP 
    SEP #$20
    JSL $@lib_shared_0131B7.code_0131B7
    LDA #$01
    STA $NMITIMEN
    LDA #$80
    STA $INIDISP
    STZ $03D2
    PLP 
    RTL 
}