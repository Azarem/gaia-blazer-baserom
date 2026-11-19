?BANK 02

?INCLUDE 'lib_01010B_part2'
?INCLUDE 'lib_shared_01032F'
?INCLUDE 'lib_shared_0131D1'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_width_pages                0343
!map_height_pages               0345

---------------------------------------------

code_01010B {
    LDA #$1C80            ; {65803}
    STX $03, Y            ; {65806}
    BEQ loc_010118        ; {65808}
    LDX #$0000            ; {65810}
    JSR $&code_010163     ; {65813}

  loc_010118:
    LDA #$1C40            ; {65816}
    STX $03, Y            ; {65819}
    BEQ loc_010125        ; {65821}
    LDX #$0000            ; {65823}
    JSR $&code_0101C2     ; {65826}

  loc_010125:
    LDX $038E             ; {65829}
    STX $0382             ; {65832}
    LDX $0390             ; {65835}
    STX $0384             ; {65838}
    LDA #$1C20            ; {65841}
    STX $03, Y            ; {65844}
    BEQ loc_010145        ; {65846}
    LDX #$0004            ; {65848}
    LDA $map_width_pages, X ; {65851}
    CMP #$9003            ; {65854}
    ORA $20, S            ; {65857}
    ADC $81, S            ; {65859}

  loc_010145:
    LDA #$1C10            ; {65861}
    STX $03, Y            ; {65864}
    BEQ loc_010159        ; {65866}
    LDX #$0004            ; {65868}
    LDA $map_height_pages, X ; {65871}
    CMP #$9003            ; {65874}
    ORA $20, S            ; {65877}
    REP #$81              ; {65879}

  loc_010159:
    LDX #$0000            ; {65881}
    STX $0382             ; {65884}
    STX $0384             ; {65887}
    RTL                   ; {65890}
}

code_010163 {
    REP #$20              ; {65891}
    LDA #$0000            ; {65893}
    LDY $0382             ; {65896}
    BEQ loc_0101BF        ; {65899}
    BMI loc_010172        ; {65901}
    LDA #$0100            ; {65903}

  loc_010172:
    CLC                   ; {65906}
    ADC $scroll_bg1_x, X  ; {65907}
    AND #$0FF0            ; {65910}
    STA $16               ; {65913}
    LDA $scroll_bg1_y, X  ; {65915}
    AND #$0F00            ; {65918}
    STA $18               ; {65921}
    SEP #$20              ; {65923}
    LDY $0354, X          ; {65925}
    STY $00               ; {65928}
    LDY $0352, X          ; {65930}
    STY $02               ; {65933}
    LDY $map_width_px, X  ; {65935}
    STY $04               ; {65938}
    LDA $036B, X          ; {65940}
    STZ $06               ; {65943}
    STA $07               ; {65945}
    LDA $map_width_pages, X ; {65947}
    XBA                   ; {65950}
    LDA $map_height_pages, X ; {65951}
    JSL $@lib_shared_0131D1.code_0131D1 ; {65954}
    CLC                   ; {65958}
    ADC $0353, X          ; {65959}
    STZ $08               ; {65962}
    STA $09               ; {65964}
    LDY $035C, X          ; {65966}
    STY $0A               ; {65969}
    LDY $035A, X          ; {65971}
    STY $29               ; {65974}
    LDY $0362, X          ; {65976}
    TYX                   ; {65979}
    JSR $&lib_shared_01032F.code_01032F ; {65980}

  loc_0101BF:
    SEP #$20              ; {65983}
    RTS                   ; {65985}
}

code_0101C2 {
    REP #$20              ; {65986}
    LDA $scroll_bg1_x, X  ; {65988}
    AND #$0F00            ; {65991}
    STA $16               ; {65994}
    LDA #$0000            ; {65996}
    LDY $0384             ; {65999}
    BEQ loc_01020B        ; {66002}
    BMI loc_0101D9        ; {66004}
    LDA #$0100            ; {66006}

  loc_0101D9:
    CLC                   ; {66009}
    ADC $scroll_bg1_y, X  ; {66010}
    AND #$0FF0            ; {66013}
    STA $18               ; {66016}
    SEP #$20              ; {66018}
    LDY $0354, X          ; {66020}
    STY $00               ; {66023}
    LDY $0352, X          ; {66025}
    STY $02               ; {66028}
    LDY $map_width_px, X  ; {66030}
    STY $04               ; {66033}
    LDA $036B, X          ; {66035}
    STZ $06               ; {66038}
    STA $07               ; {66040}
    LDY $035C, X          ; {66042}
    STY $0A               ; {66045}
    LDY $035A, X          ; {66047}
    STY $29               ; {66050}
    LDY $0364, X          ; {66052}
    TYX                   ; {66055}
    JSR $&lib_01010B_part2.code_0103AB ; {66056}

  loc_01020B:
    SEP #$20              ; {66059}
    RTS                   ; {66061}
}