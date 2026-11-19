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
    PHP                   ; {74539}
    SEP #$20              ; {74540}
    LDA #$5C              ; {74542}
    STA $BG2SC            ; {74544}
    LDA #$20              ; {74547}
    STA $BG12NBA          ; {74549}
    LDA #$06              ; {74552}
    STA $TM               ; {74554}
    STZ $CGADSUB          ; {74557}
    LDA #$09              ; {74560}
    STA $BGMODE           ; {74562}
    JSR $&lib_shared_012416.code_012416 ; {74565}
    JSR $&lib_shared_012416.code_01243D ; {74568}
    JSR $&lib_shared_012390.code_012390 ; {74571}
    PLP                   ; {74574}
    RTL                   ; {74575}
}