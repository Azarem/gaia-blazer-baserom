?BANK 03

?INCLUDE 'w0_shared_01ABB9'
?INCLUDE 'w0_shared_01AD1B'
?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01AC32 {
    JSL $@w0_shared_01B161.code_01B161 ; {109618}
    COP [17] ( &code_01AD09 ) ; {109622}

  loc_01AC3A:
    COP [14] ( #$0004, &code_01AC47 ) ; {109626}
    COP [80] ( #07 )      ; {109632}
    COP [82]              ; {109635}
    BRA loc_01AC3A        ; {109637}
}

code_01AC47 {
    COP [07] ( #$8505, &code_01AC5E ) ; {109639}
    COP [09] ( #$8505 )   ; {109645}
    LDA $0016, X          ; {109649}
    AND #$FFEF            ; {109652}
    STA $0016, X          ; {109655}
    COP [01] ( &asciistring_01AC73 ) ; {109658}
}

code_01AC5E {
    LDA $0016, X          ; {109662}
    ORA #$0010            ; {109665}
    STA $0016, X          ; {109668}
    SEP #$20              ; {109671}
    LDA #$^w0_shared_01B161.code_01B17C ; {109673}
    PHA                   ; {109675}
    REP #$20              ; {109676}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {109678}
    PHA                   ; {109681}
    RTL                   ; {109682}
}

asciistring_01AC73 |[10][02:2] heard a [N]faint voice coming [N]from the jewel in the [N]< corner- [FIN]Allright, come over [N]here- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01ACBA |[10]I will give you some [N]advice- [FIN]Don t forget to equip [N]the things that you [N]wish to use or they [N]will not work- [FIN][JMP:&w0_shared_01ABB9.asciistring_01ABB9+M]|

code_01AD09 {
    COP [07] ( #$9C02, &w0_shared_01AD1B.code_01AD1B ) ; {109833}
    COP [01] ( &asciistring_01ACBA ) ; {109839}
    COP [38] ( #$0030 )   ; {109843}
    COP [09] ( #$9C02 )   ; {109847}
}