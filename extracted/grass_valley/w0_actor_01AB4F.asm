?BANK 03

?INCLUDE 'w0_shared_01ABB9'
?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01AB4F {
    COP [14] ( #$002C, &code_01AB56 ) ; {109391}
    RTL                   ; {109397}
}

code_01AB56 {
    JSL $@w0_shared_01B161.code_01B161 ; {109398}
    COP [17] ( &code_01AB6A ) ; {109402}
    SEP #$20              ; {109406}
    LDA #$^w0_shared_01B161.code_01B17C ; {109408}
    PHA                   ; {109410}
    REP #$20              ; {109411}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {109413}
    PHA                   ; {109416}
    RTL                   ; {109417}
}

code_01AB6A {
    COP [07] ( #$9C00, &code_01AB7E ) ; {109418}
    COP [01] ( &asciistring_01AB83 ) ; {109424}
    BRK #$5E              ; {109428}
    COP [0A] ( #07 )      ; {109430}
    COP [09] ( #$9C00 )   ; {109433}
    RTL                   ; {109437}
}

code_01AB7E {
    COP [01] ( &w0_shared_01ABB9.asciistring_01ABE0 ) ; {109438}
    RTL                   ; {109442}
}

asciistring_01AB83 |[10]I am watching over [N]this world- Please [N]take this sword- [FIN][02:2] received [N][03:24]the Recover Sword- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|