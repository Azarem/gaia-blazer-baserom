?BANK 02

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_010000 {
    PHP                   ; {65536}
    REP #$30              ; {65537}
    LDX #$0000            ; {65539}
    TXY                   ; {65542}
    LDA $scroll_bg1_x     ; {65543}
    PHA                   ; {65546}
    LDA $player_x         ; {65547}
    SEC                   ; {65550}
    SBC #$0070            ; {65551}
    BPL loc_010019        ; {65554}
    LDA #$0000            ; {65556}
    BRA loc_01002F        ; {65559}

  loc_010019:
    CLC                   ; {65561}
    ADC #$0100            ; {65562}
    CMP $map_width_px     ; {65565}
    BCS loc_010028        ; {65568}
    SEC                   ; {65570}
    SBC #$0100            ; {65571}
    BRA loc_01002F        ; {65574}

  loc_010028:
    LDA $map_width_px     ; {65576}
    SEC                   ; {65579}
    SBC #$0100            ; {65580}

  loc_01002F:
    SEC                   ; {65583}
    SBC $01, S            ; {65584}
    TAX                   ; {65586}
    PLA                   ; {65587}
    LDA $scroll_bg1_y     ; {65588}
    PHA                   ; {65591}
    LDA $player_y         ; {65592}
    SEC                   ; {65595}
    SBC #$0080            ; {65596}
    BPL loc_010046        ; {65599}
    LDA #$0000            ; {65601}
    BRA loc_01005C        ; {65604}

  loc_010046:
    CLC                   ; {65606}
    ADC $03CA             ; {65607}
    CMP $map_height_px    ; {65610}
    BCS loc_010055        ; {65613}
    SEC                   ; {65615}
    SBC $03CA             ; {65616}
    BRA loc_01005C        ; {65619}

  loc_010055:
    LDA $map_height_px    ; {65621}
    SEC                   ; {65624}
    SBC $03CA             ; {65625}

  loc_01005C:
    SEC                   ; {65628}
    SBC $01, S            ; {65629}
    TAY                   ; {65631}
    PLA                   ; {65632}
    STX $0382             ; {65633}
    STY $0384             ; {65636}
    PLP                   ; {65639}
    RTL                   ; {65640}
}