?BANK 02

?INCLUDE 'lib_0118FC_part12'
?INCLUDE 'lib_0275ED'
?INCLUDE 'lib_027614'
?INCLUDE 'lib_shared_012769'

!location_id                    1C6A

---------------------------------------------

code_012659 {
    LDA $location_id      ; {75353}
    SEC                   ; {75356}
    SBC #$0F              ; {75357}
    CMP #$04              ; {75359}
    BCS loc_012666        ; {75361}
    BRL loc_0126CB        ; {75363}

  loc_012666:
    LDA $0330             ; {75366}
    BEQ loc_012675        ; {75369}
    BPL loc_01267C        ; {75371}
    DEC                   ; {75373}
    BMI loc_012682        ; {75374}
    LDY #$&lib_0118FC_part12.asciistring_01476F ; {75376}
    BRA loc_012678        ; {75379}

  loc_012675:
    LDY #$&lib_0118FC_part12.asciistring_014766 ; {75381}

  loc_012678:
    JSL $@lib_shared_012769.code_012769 ; {75384}

  loc_01267C:
    DEC $0330             ; {75388}
    DEC $0330             ; {75391}

  loc_012682:
    JSL $@lib_0275ED.code_0275ED ; {75394}
    JSL $@lib_027614.code_027614 ; {75398}
    LDA $0332             ; {75402}
    BEQ loc_0126CB        ; {75405}
    LSR $0332             ; {75407}
    BCC loc_01269B        ; {75410}
    LDY #$&lib_0118FC_part12.asciistring_01470E ; {75412}
    JSL $@lib_shared_012769.code_012769 ; {75415}

  loc_01269B:
    LSR $0332             ; {75419}
    BCC loc_0126A7        ; {75422}
    LDY #$&lib_0118FC_part12.asciistring_014739 ; {75424}
    JSL $@lib_shared_012769.code_012769 ; {75427}

  loc_0126A7:
    LSR $0332             ; {75431}
    BCC loc_0126B3        ; {75434}
    LDY #$&lib_0118FC_part12.asciistring_014744 ; {75436}
    JSL $@lib_shared_012769.code_012769 ; {75439}

  loc_0126B3:
    LSR $0332             ; {75443}
    BCC loc_0126BF        ; {75446}
    LDY #$&lib_0118FC_part12.asciistring_014750 ; {75448}
    JSL $@lib_shared_012769.code_012769 ; {75451}

  loc_0126BF:
    LSR $0332             ; {75455}
    BCC loc_0126CB        ; {75458}
    LDY #$&lib_0118FC_part12.asciistring_01475B ; {75460}
    JSL $@lib_shared_012769.code_012769 ; {75463}

  loc_0126CB:
    STZ $0332             ; {75467}
    RTL                   ; {75470}
}