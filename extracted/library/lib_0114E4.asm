?BANK 02

?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'table_00A9DE'

!map_width_pages                0343
!map_height_pages               0345
!location_id                    1C6A

---------------------------------------------

code_0114E4 {
    REP #$20              ; {70884}
    LDA $location_id      ; {70886}
    ASL                   ; {70889}
    TAX                   ; {70890}
    LDA $&table_00A9DE, X ; {70891}
    SEC                   ; {70894}
    SBC #$&table_00A9DE   ; {70895}
    STA $03AE             ; {70898}
    SEP #$20              ; {70901}
    LDX $03AE             ; {70903}

  loc_0114FA:
    LDA $&table_00A9DE, X ; {70906}
    CMP #$FF              ; {70909}
    BEQ loc_01157D        ; {70911}
    LDA #$00              ; {70913}
    XBA                   ; {70915}
    LDA $&table_00A9DE+2, X ; {70916}
    AND #$7F              ; {70919}
    LDY #$1A7E            ; {70921}
    JSL $@lib_0273A2.code_0273A2 ; {70924}
    BCC loc_011570        ; {70928}
    PHX                   ; {70930}
    LDA $&table_00A9DE+2, X ; {70931}
    STA $02               ; {70934}
    REP #$20              ; {70936}
    LDA $&table_00A9DE, X ; {70938}
    AND #$00FF            ; {70941}
    ASL                   ; {70944}
    ASL                   ; {70945}
    ASL                   ; {70946}
    ASL                   ; {70947}
    STA $16               ; {70948}
    LDA $&table_00A9DE+1, X ; {70950}
    AND #$00FF            ; {70953}
    DEC                   ; {70956}
    ASL                   ; {70957}
    ASL                   ; {70958}
    ASL                   ; {70959}
    ASL                   ; {70960}
    STA $18               ; {70961}
    JSL $@lib_027462_part1.code_0272B8 ; {70963}
    SEP #$20              ; {70967}
    LDA $map_width_pages  ; {70969}
    XBA                   ; {70972}
    LDA $map_height_pages ; {70973}
    JSL $@lib_shared_0131D1.code_0131D1 ; {70976}
    STA $01               ; {70980}
    XBA                   ; {70982}
    STA $00               ; {70983}

  loc_011549:
    LDA $7E8000, X        ; {70985}
    CMP #$FB              ; {70989}
    BNE loc_011561        ; {70991}
    LDA #$FC              ; {70993}
    STA $7E8000, X        ; {70995}
    LDA $02               ; {70999}
    BPL loc_011561        ; {71001}
    LDA #$FC              ; {71003}
    STA $7EC000, X        ; {71005}

  loc_011561:
    REP #$20              ; {71009}
    TXA                   ; {71011}
    CLC                   ; {71012}
    ADC $00               ; {71013}
    TAX                   ; {71015}
    CPX #$4000            ; {71016}
    SEP #$20              ; {71019}
    BCC loc_011549        ; {71021}
    PLX                   ; {71023}

  loc_011570:
    REP #$20              ; {71024}
    TXA                   ; {71026}
    CLC                   ; {71027}
    ADC #$0006            ; {71028}
    TAX                   ; {71031}
    SEP #$20              ; {71032}
    BRL loc_0114FA        ; {71034}

  loc_01157D:
    RTL                   ; {71037}
}