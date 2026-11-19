?BANK 00

?INCLUDE 'lib_0118FC_part9'

!player_x                       0374
!player_y                       0376

---------------------------------------------

code_002D67 {
    TYA                   ; {11623}
    STA $001E, X          ; {11624}
    STZ $0020, X          ; {11627}
    COP [85] ( @code_002D96 ) ; {11630}
    CPY #$06AA            ; {11635}
    BEQ loc_002D93        ; {11638}
    SEP #$20              ; {11640}
    LDA #$00              ; {11642}
    STA $0036, X          ; {11644}
    REP #$20              ; {11647}
    COP [91]              ; {11649}

  loc_002D83:
    COP [82]              ; {11651}
    LDA $0016, X          ; {11653}
    BIT #$8000            ; {11656}
    BEQ loc_002D83        ; {11659}
    LDY $003E, X          ; {11661}
    STA $0030, Y          ; {11664}

  loc_002D93:
    COP [86]              ; {11667}
    RTL                   ; {11669}
}

code_002D96 {
    LDA $003C, X          ; {11670}
    STA $0030, X          ; {11673}
    LDA $player_x         ; {11676}
    SEC                   ; {11679}
    SBC $0000, X          ; {11680}
    BMI loc_002DC4        ; {11683}
    STA $16               ; {11685}
    LDA $player_y         ; {11687}
    SEC                   ; {11690}
    SBC $0002, X          ; {11691}
    BMI loc_002DB8        ; {11694}
    STA $18               ; {11696}
    CMP $16               ; {11698}
    BCS loc_002E23        ; {11700}
    BRA loc_002E11        ; {11702}

  loc_002DB8:
    EOR #$FFFF            ; {11704}
    INC                   ; {11707}
    STA $18               ; {11708}
    CMP $16               ; {11710}
    BCS loc_002DEA        ; {11712}
    BRA loc_002DFF        ; {11714}

  loc_002DC4:
    EOR #$FFFF            ; {11716}
    INC                   ; {11719}
    STA $16               ; {11720}
    LDA $player_y         ; {11722}
    SEC                   ; {11725}
    SBC $0002, X          ; {11726}
    BMI loc_002DDB        ; {11729}
    STA $18               ; {11731}
    CMP $16               ; {11733}
    BCS loc_002E35        ; {11735}
    BRA loc_002E47        ; {11737}

  loc_002DDB:
    EOR #$FFFF            ; {11739}
    INC                   ; {11742}
    STA $18               ; {11743}
    CMP $16               ; {11745}
    BCC loc_002DE8        ; {11747}
    BRL loc_002E6B        ; {11749}

  loc_002DE8:
    BRA loc_002E59        ; {11752}

  loc_002DEA:
    JSR $&code_002E9C     ; {11754}
    COP [91]              ; {11757}
    DEC $0002, X          ; {11759}
    DEC $0010, X          ; {11762}
    BEQ loc_002DFA        ; {11765}
    BRL loc_002E83        ; {11767}

  loc_002DFA:
    INC $0000, X          ; {11770}
    BRA loc_002E7D        ; {11773}

  loc_002DFF:
    JSR $&code_002EA4     ; {11775}
    COP [91]              ; {11778}
    INC $0000, X          ; {11780}
    DEC $0010, X          ; {11783}
    BNE loc_002E83        ; {11786}
    DEC $0002, X          ; {11788}
    BRA loc_002E7D        ; {11791}

  loc_002E11:
    JSR $&code_002EA4     ; {11793}
    COP [91]              ; {11796}
    INC $0000, X          ; {11798}
    DEC $0010, X          ; {11801}
    BNE loc_002E83        ; {11804}
    INC $0002, X          ; {11806}
    BRA loc_002E7D        ; {11809}

  loc_002E23:
    JSR $&code_002E9C     ; {11811}
    COP [91]              ; {11814}
    INC $0002, X          ; {11816}
    DEC $0010, X          ; {11819}
    BNE loc_002E83        ; {11822}
    INC $0000, X          ; {11824}
    BRA loc_002E7D        ; {11827}

  loc_002E35:
    JSR $&code_002E9C     ; {11829}
    COP [91]              ; {11832}
    INC $0002, X          ; {11834}
    DEC $0010, X          ; {11837}
    BNE loc_002E83        ; {11840}
    DEC $0000, X          ; {11842}
    BRA loc_002E7D        ; {11845}

  loc_002E47:
    JSR $&code_002EA4     ; {11847}
    COP [91]              ; {11850}
    DEC $0000, X          ; {11852}
    DEC $0010, X          ; {11855}
    BNE loc_002E83        ; {11858}
    INC $0002, X          ; {11860}
    BRA loc_002E7D        ; {11863}

  loc_002E59:
    JSR $&code_002EA4     ; {11865}
    COP [91]              ; {11868}
    DEC $0000, X          ; {11870}
    DEC $0010, X          ; {11873}
    BNE loc_002E83        ; {11876}
    DEC $0002, X          ; {11878}
    BRA loc_002E7D        ; {11881}

  loc_002E6B:
    JSR $&code_002E9C     ; {11883}
    COP [91]              ; {11886}
    DEC $0002, X          ; {11888}
    DEC $0010, X          ; {11891}
    BNE loc_002E83        ; {11894}
    DEC $0000, X          ; {11896}
    BRA loc_002E7D        ; {11899}

  loc_002E7D:
    LDA $0012, X          ; {11901}
    STA $0010, X          ; {11904}

  loc_002E83:
    LDA $003C, X          ; {11907}
    CMP $0030, X          ; {11910}
    BNE loc_002E99        ; {11913}
    TAY                   ; {11915}
    LDA $0000, X          ; {11916}
    STA $0000, Y          ; {11919}
    LDA $0002, X          ; {11922}
    STA $0002, Y          ; {11925}
    RTL                   ; {11928}

  loc_002E99:
    COP [86]              ; {11929}
    RTL                   ; {11931}
}

code_002E9C {
    SEP #$20              ; {11932}
    LDY $18               ; {11934}
    LDA $16               ; {11936}
    BRA loc_002EAA        ; {11938}
}

code_002EA4 {
    SEP #$20              ; {11940}
    LDY $16               ; {11942}
    LDA $18               ; {11944}

  loc_002EAA:
    BNE loc_002EAD        ; {11946}
    INC                   ; {11948}

  loc_002EAD:
    JSL $@lib_0118FC_part9.code_0131E8 ; {11949}
    REP #$20              ; {11953}
    AND #$00FF            ; {11955}
    BNE loc_002EB9        ; {11958}
    INC                   ; {11960}

  loc_002EB9:
    STA $0010, X          ; {11961}
    STA $0012, X          ; {11964}
    RTS                   ; {11967}
}