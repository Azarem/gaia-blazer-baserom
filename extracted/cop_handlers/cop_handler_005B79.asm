?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_0276C9'

---------------------------------------------

Cop26_JumpIfLib0276C9 {
    TYX                   ; {23417}
    LDA [$38]             ; {23418}
    INC $38               ; {23420}
    INC $38               ; {23422}
    LDY $1B64             ; {23424}
    CPY #$0040            ; {23427}
    BNE loc_005B8D        ; {23430}
    LDA #$0000            ; {23432}
    BRA loc_005B99        ; {23435}

  loc_005B8D:
    LDY $1B60             ; {23437}
    CPY #$000C            ; {23440}
    BNE loc_005B99        ; {23443}
    LSR                   ; {23445}
    BNE loc_005B99        ; {23446}
    INC                   ; {23448}

  loc_005B99:
    JSL $@lib_0276C9.code_0276C9 ; {23449}
    BCS loc_005BA8        ; {23453}
    LDA #$0010            ; {23455}
    TSB $0332             ; {23458}
    BRL cop_handler_006473.loc_0064BB ; {23461}

  loc_005BA8:
    LDA [$38]             ; {23464}
    INC $38               ; {23466}
    INC $38               ; {23468}
    BRL cop_handler_006473.loc_0064C1 ; {23470}
}