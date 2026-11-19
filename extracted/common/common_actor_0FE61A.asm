?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FE61A {
    COP [A5] ( &code_0FE624, &code_0FE670, &code_0FE6BC, &code_0FE70A ) ; {1041946}
}

code_0FE624 {
    LDA $0016, X          ; {1041956}
    BIT #$8000            ; {1041959}
    BEQ loc_0FE632        ; {1041962}

  code_0FE62C:
    COP [1B] ( &code_0FE624, #$0078 ) ; {1041964}

  loc_0FE632:
    COP [0C] ( #00, #07, &code_0FE63A ) ; {1041970}
    BRA code_0FE62C       ; {1041976}
}

code_0FE63A {
    COP [9B] ( #$0010, &code_0FE62C, &code_0FE62C, &code_0FE644 ) ; {1041978}
}

code_0FE644 {
    COP [28] ( &code_0FE64C ) ; {1041988}
    COP [27] ( &code_0FE62C ) ; {1041992}
}

code_0FE64C {
    LDA $0016, X          ; {1041996}
    AND #$DFFF            ; {1041999}
    STA $0016, X          ; {1042002}
    COP [80] ( #1D )      ; {1042005}
    COP [82]              ; {1042008}
    COP [B2] ( @code_0FE756, #$0000, #$0010, #$0200 ) ; {1042010}
    LDA $0016, X          ; {1042021}
    ORA #$2000            ; {1042024}
    STA $0016, X          ; {1042027}
    BRA code_0FE62C       ; {1042030}
}

code_0FE670 {
    LDA $0016, X          ; {1042032}
    BIT #$8000            ; {1042035}
    BEQ loc_0FE67E        ; {1042038}

  code_0FE678:
    COP [1B] ( &code_0FE670, #$0078 ) ; {1042040}

  loc_0FE67E:
    COP [0C] ( #00, #07, &code_0FE686 ) ; {1042046}
    BRA code_0FE678       ; {1042052}
}

code_0FE686 {
    COP [9A] ( #$0010, &code_0FE690, &code_0FE678, &code_0FE678 ) ; {1042054}
}

code_0FE690 {
    COP [28] ( &code_0FE698 ) ; {1042064}
    COP [27] ( &code_0FE678 ) ; {1042068}
}

code_0FE698 {
    LDA $0016, X          ; {1042072}
    AND #$DFFF            ; {1042075}
    STA $0016, X          ; {1042078}
    COP [80] ( #1F )      ; {1042081}
    COP [82]              ; {1042084}
    COP [B2] ( @code_0FE756, #$FFF0, #$0000, #$0200 ) ; {1042086}
    LDA $0016, X          ; {1042097}
    ORA #$2000            ; {1042100}
    STA $0016, X          ; {1042103}
    BRA code_0FE678       ; {1042106}
}

code_0FE6BC {
    LDA $0016, X          ; {1042108}
    BIT #$8000            ; {1042111}
    BEQ loc_0FE6CA        ; {1042114}

  code_0FE6C4:
    COP [1B] ( &code_0FE6BC, #$0078 ) ; {1042116}

  loc_0FE6CA:
    COP [0C] ( #00, #07, &code_0FE6D2 ) ; {1042122}
    BRA code_0FE6C4       ; {1042128}
}

code_0FE6D2 {
    COP [9A] ( #$0010, &code_0FE6C4, &code_0FE6C4, &code_0FE6DC ) ; {1042130}
}

code_0FE6DC {
    COP [28] ( &code_0FE6E4 ) ; {1042140}
    COP [27] ( &code_0FE6C4 ) ; {1042144}
}

code_0FE6E4 {
    COP [96]              ; {1042148}
    LDA $0016, X          ; {1042150}
    AND #$DFFF            ; {1042153}
    STA $0016, X          ; {1042156}
    COP [80] ( #1F )      ; {1042159}
    COP [82]              ; {1042162}
    COP [B2] ( @code_0FE756, #$0010, #$0000, #$0200 ) ; {1042164}
    LDA $0016, X          ; {1042175}
    ORA #$2000            ; {1042178}
    STA $0016, X          ; {1042181}
    BRA code_0FE6C4       ; {1042184}
}

code_0FE70A {
    LDA $0016, X          ; {1042186}
    BIT #$8000            ; {1042189}
    BEQ loc_0FE718        ; {1042192}

  code_0FE712:
    COP [1B] ( &code_0FE70A, #$0078 ) ; {1042194}

  loc_0FE718:
    COP [0C] ( #00, #07, &code_0FE720 ) ; {1042200}
    BRA code_0FE712       ; {1042206}
}

code_0FE720 {
    COP [9B] ( #$0010, &code_0FE72A, &code_0FE712, &code_0FE712 ) ; {1042208}
}

code_0FE72A {
    COP [28] ( &code_0FE732 ) ; {1042218}
    COP [27] ( &code_0FE712 ) ; {1042222}
}

code_0FE732 {
    LDA $0016, X          ; {1042226}
    AND #$DFFF            ; {1042229}
    STA $0016, X          ; {1042232}
    COP [80] ( #1E )      ; {1042235}
    COP [82]              ; {1042238}
    COP [B2] ( @code_0FE756, #$0000, #$FFF0, #$0200 ) ; {1042240}
    LDA $0016, X          ; {1042251}
    ORA #$2000            ; {1042254}
    STA $0016, X          ; {1042257}
    BRA code_0FE712       ; {1042260}
}

code_0FE756 {
    COP [A3]              ; {1042262}
    BRK #$64              ; {1042264}
    LDY #$0020            ; {1042266}
    SEP #$20              ; {1042269}
    LDA #$^common_actor_004659_part1.code_002D67 ; {1042271}
    PHA                   ; {1042273}
    REP #$20              ; {1042274}
    LDA #$&common_actor_004659_part1.code_002D67-1 ; {1042276}
    PHA                   ; {1042279}
    RTL                   ; {1042280}
}