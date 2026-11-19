?BANK 02

?INCLUDE 'lib_shared_012390'
?INCLUDE 'lib_shared_012416'

!BGMODE                         2105
!BG2SC                          2108
!BG12NBA                        210B
!TM                             212C
!CGADSUB                        2131

---------------------------------------------

code_01232B {
    PHP 
    SEP #$20
    LDA #$5C
    STA $BG2SC
    LDA #$20
    STA $BG12NBA
    LDA #$06
    STA $TM
    STZ $CGADSUB
    LDA #$09
    STA $BGMODE
    JSR $&lib_shared_012416.code_012416
    JSR $&lib_shared_012416.code_01243D
    JSR $&lib_shared_012390.code_012390
    PLP 
    RTL 
}