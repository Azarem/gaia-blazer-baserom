?BANK 02

?INCLUDE 'lib_shared_0104AF'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_height_px                  0344

---------------------------------------------

code_010069 {
    PHP                   ; {65641}
    REP #$20              ; {65642}
    LDA $0382             ; {65644}
    BEQ loc_0100AE        ; {65647}
    BPL loc_010084        ; {65649}
    LDA $scroll_bg1_x     ; {65651}
    BEQ loc_0100AE        ; {65654}
    PHA                   ; {65656}
    CLC                   ; {65657}
    ADC $0382             ; {65658}
    BPL loc_01009C        ; {65661}
    LDA #$0000            ; {65663}
    BRA loc_01009C        ; {65666}

  loc_010084:
    LDA $scroll_bg1_x     ; {65668}
    PHA                   ; {65671}
    CLC                   ; {65672}
    ADC $0382             ; {65673}
    CLC                   ; {65676}
    ADC #$0100            ; {65677}
    CMP $map_width_px     ; {65680}
    BCC loc_010098        ; {65683}
    LDA $map_width_px     ; {65685}

  loc_010098:
    SEC                   ; {65688}
    SBC #$0100            ; {65689}

  loc_01009C:
    STA $scroll_bg1_x     ; {65692}
    PLA                   ; {65695}
    EOR $scroll_bg1_x     ; {65696}
    AND #$0010            ; {65699}
    BEQ loc_0100AE        ; {65702}
    LDA #$0080            ; {65704}
    TSB $0396             ; {65707}

  loc_0100AE:
    LDA $0384             ; {65710}
    BEQ loc_0100F0        ; {65713}
    BPL loc_0100C6        ; {65715}
    LDA $scroll_bg1_y     ; {65717}
    BEQ loc_0100F0        ; {65720}
    PHA                   ; {65722}
    CLC                   ; {65723}
    ADC $0384             ; {65724}
    BPL loc_0100DE        ; {65727}
    LDA #$0000            ; {65729}
    BRA loc_0100DE        ; {65732}

  loc_0100C6:
    LDA $scroll_bg1_y     ; {65734}
    PHA                   ; {65737}
    CLC                   ; {65738}
    ADC $0384             ; {65739}
    CLC                   ; {65742}
    ADC $03CA             ; {65743}
    CMP $map_height_px    ; {65746}
    BCC loc_0100DA        ; {65749}
    LDA $map_height_px    ; {65751}

  loc_0100DA:
    SEC                   ; {65754}
    SBC $03CA             ; {65755}

  loc_0100DE:
    STA $scroll_bg1_y     ; {65758}
    PLA                   ; {65761}
    EOR $scroll_bg1_y     ; {65762}
    AND #$0010            ; {65765}
    BEQ loc_0100F0        ; {65768}
    LDA #$0040            ; {65770}
    TSB $0396             ; {65773}

  loc_0100F0:
    LDX #$0004            ; {65776}
    LDA $034E             ; {65779}
    BEQ loc_0100FE        ; {65782}
    LDA #$0020            ; {65784}
    JSR $&lib_shared_0104AF.code_0104E1 ; {65787}

  loc_0100FE:
    LDA $0350             ; {65790}
    BEQ loc_010109        ; {65793}
    LDA #$0010            ; {65795}
    JSR $&lib_shared_0104AF.code_01052F ; {65798}

  loc_010109:
    PLP                   ; {65801}
    RTL                   ; {65802}
}