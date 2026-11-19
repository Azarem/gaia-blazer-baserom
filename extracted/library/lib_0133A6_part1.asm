?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'data_00F99A'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0133A6_part5'
?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_01112A'

!location_id                    1C6A

---------------------------------------------

code_01157E {
    LDX #$0000            ; {71038}
    TXY                   ; {71041}
    STZ $0456             ; {71042}

  loc_011585:
    LDA $&data_00BA0D, Y  ; {71045}
    CMP #$FF              ; {71048}
    BEQ loc_0115B0        ; {71050}
    LDA $&data_00BA0D+B, Y ; {71052}
    CMP $location_id      ; {71055}
    BNE loc_0115A3        ; {71058}
    INC $0456             ; {71060}
    LDA $7F0203, X        ; {71063}
    BMI loc_0115B1        ; {71067}
    BEQ loc_0115B1        ; {71069}
    JSL $@engine_000000.code_00144F ; {71071}

  loc_0115A3:
    REP #$20              ; {71075}
    TYA                   ; {71077}
    CLC                   ; {71078}
    ADC #$0020            ; {71079}
    TAY                   ; {71082}
    SEP #$20              ; {71083}
    INX                   ; {71085}
    BRA loc_011585        ; {71086}

  loc_0115B0:
    RTL                   ; {71088}

  loc_0115B1:
    PHX                   ; {71089}
    PHY                   ; {71090}
    PHP                   ; {71091}
    REP #$20              ; {71092}
    LDA $&data_00BA0D+C, Y ; {71094}
    AND #$00FF            ; {71097}
    ASL                   ; {71100}
    ASL                   ; {71101}
    ASL                   ; {71102}
    ASL                   ; {71103}
    STA $16               ; {71104}
    LDA $&data_00BA0D+D, Y ; {71106}
    AND #$00FF            ; {71109}
    ASL                   ; {71112}
    ASL                   ; {71113}
    ASL                   ; {71114}
    ASL                   ; {71115}
    STA $18               ; {71116}
    JSL $@lib_027462_part1.code_0272B8 ; {71118}
    SEP #$20              ; {71122}
    LDA #$FE              ; {71124}
    PLP                   ; {71126}
    BPL loc_0115DE        ; {71127}
    LDA #$FF              ; {71129}
    DEC $0456             ; {71131}

  loc_0115DE:
    STA $7E8000, X        ; {71134}
    XBA                   ; {71138}
    LDA $&data_00BA0D+8, Y ; {71139}
    BEQ loc_0115ED        ; {71142}
    XBA                   ; {71144}
    STA $7EC000, X        ; {71145}

  loc_0115ED:
    PLY                   ; {71149}
    PLX                   ; {71150}
    BRA loc_0115A3        ; {71151}

  code_0115F1:
    LDX #$0000            ; {71153}
    TXY                   ; {71156}

  loc_0115F5:
    LDA $@lib_0133A6_part5.unk13_01728D, X ; {71157}
    CMP #$FF              ; {71161}
    BEQ loc_011620        ; {71163}
    CMP $location_id      ; {71165}
    BNE loc_011614        ; {71168}
    LDA $@lib_0133A6_part5.unk13_01728D+2, X ; {71170}
    XBA                   ; {71174}
    LDA $@lib_0133A6_part5.unk13_01728D+1, X ; {71175}
    LDY #$1A5E            ; {71179}
    JSL $@lib_0273A2.code_0273A2 ; {71182}
    BCS loc_011621        ; {71186}

  loc_011614:
    REP #$20              ; {71188}
    TXA                   ; {71190}
    CLC                   ; {71191}
    ADC #$0009            ; {71192}
    TAX                   ; {71195}
    SEP #$20              ; {71196}
    BRA loc_0115F5        ; {71198}

  loc_011620:
    RTL                   ; {71200}

  loc_011621:
    PHX                   ; {71201}
    LDA $@lib_0133A6_part5.unk13_01728D+3, X ; {71202}
    STA $1C71             ; {71206}
    LDA $@lib_0133A6_part5.unk13_01728D+4, X ; {71209}
    STA $1C72             ; {71213}
    LDA $@lib_0133A6_part5.unk13_01728D+5, X ; {71216}
    STA $1C73             ; {71220}
    LDA $@lib_0133A6_part5.unk13_01728D+6, X ; {71223}
    STA $1C74             ; {71227}
    REP #$20              ; {71230}
    LDA $@lib_0133A6_part5.unk13_01728D+7, X ; {71232}
    AND #$00FF            ; {71236}
    ASL                   ; {71239}
    ASL                   ; {71240}
    ASL                   ; {71241}
    ASL                   ; {71242}
    STA $16               ; {71243}
    LDA $@lib_0133A6_part5.unk13_01728D+8, X ; {71245}
    AND #$00FF            ; {71249}
    ASL                   ; {71252}
    ASL                   ; {71253}
    ASL                   ; {71254}
    ASL                   ; {71255}
    STA $18               ; {71256}
    JSR $&lib_shared_01112A.code_0111CB ; {71258}
    SEP #$20              ; {71261}
    PLX                   ; {71263}
    BRA loc_011614        ; {71264}

  code_011662:
    PHX                   ; {71266}
    PHY                   ; {71267}
    LDX #$0000            ; {71268}

  loc_011667:
    LDA $&data_00F99A, X  ; {71271}
    BMI loc_011691        ; {71274}
    CMP $location_id      ; {71276}
    BNE loc_01168B        ; {71279}
    LDA $&data_00F99A+2, X ; {71281}
    XBA                   ; {71284}
    LDA $&data_00F99A+1, X ; {71285}
    LDY #$1ADE            ; {71288}
    JSL $@lib_0273A2.code_0273A2 ; {71291}
    BCC loc_01168B        ; {71295}
    LDA $&data_00F99A+3, X ; {71297}
    STA $031E             ; {71300}
    SEC                   ; {71303}
    PLY                   ; {71304}
    PLX                   ; {71305}
    RTL                   ; {71306}

  loc_01168B:
    INX                   ; {71307}
    INX                   ; {71308}
    INX                   ; {71309}
    INX                   ; {71310}
    BRA loc_011667        ; {71311}

  loc_011691:
    CLC                   ; {71313}
    PLY                   ; {71314}
    PLX                   ; {71315}
    RTL                   ; {71316}
}