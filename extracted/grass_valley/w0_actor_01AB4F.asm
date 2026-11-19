?BANK 03

?INCLUDE 'w0_shared_01ABB9'
?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01AB4F {
    COP [14] ( #$002C, &code_01AB56 )
    RTL 
}

code_01AB56 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01AB6A )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01AB6A {
    COP [07] ( #$9C00, &code_01AB7E )
    COP [01] ( &asciistring_01AB83 )
    BRK #$5E
    COP [0A] ( #07 )
    COP [09] ( #$9C00 )
    RTL 
}

code_01AB7E {
    COP [01] ( &w0_shared_01ABB9.asciistring_01ABE0 )
    RTL 
}

asciistring_01AB83 |[10]I am watching over [N]this world- Please [N]take this sword- [FIN][02:2] received [N][03:24]the Recover Sword- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|