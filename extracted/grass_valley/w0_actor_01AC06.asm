?BANK 03

?INCLUDE 'w0_shared_01ABB9'
?INCLUDE 'w0_shared_01B161'

---------------------------------------------

code_01AC06 {
    JSL $@w0_shared_01B161.code_01B161 ; {109574}
    COP [17] ( &code_01AC1A ) ; {109578}
    SEP #$20              ; {109582}
    LDA #$^w0_shared_01B161.code_01B17C ; {109584}
    PHA                   ; {109586}
    REP #$20              ; {109587}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {109589}
    PHA                   ; {109592}
    RTL                   ; {109593}
}

code_01AC1A {
    COP [07] ( #$9C01, &code_01AC2D ) ; {109594}
    COP [01] ( &w0_shared_01ABB9.asciistring_01ABB9 ) ; {109600}
    COP [38] ( #$0080 )   ; {109604}
    COP [09] ( #$9C01 )   ; {109608}
    RTL                   ; {109612}
}

code_01AC2D {
    COP [01] ( &w0_shared_01ABB9.asciistring_01ABE0 ) ; {109613}
    RTL                   ; {109617}
}