?BANK 03

?INCLUDE 'w0_shared_01ABB9'
?INCLUDE 'w0_shared_01AD1B'
?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01AC32 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01AD09 )

  loc_01AC3A:
    COP [14] ( #$0004, &code_01AC47 )
    COP [80] ( #07 )
    COP [82]
    BRA loc_01AC3A
}

code_01AC47 {
    COP [07] ( #$8505, &code_01AC5E )
    COP [09] ( #$8505 )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_01AC73 )
}

code_01AC5E {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

asciistring_01AC73 |[10][02:2] heard a [N]faint voice coming [N]from the jewel in the [N]< corner- [FIN]Allright, come over [N]here- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01ACBA |[10]I will give you some [N]advice- [FIN]Don t forget to equip [N]the things that you [N]wish to use or they [N]will not work- [FIN][JMP:&w0_shared_01ABB9.asciistring_01ABB9+M]|

code_01AD09 {
    COP [07] ( #$9C02, &w0_shared_01AD1B.code_01AD1B )
    COP [01] ( &asciistring_01ACBA )
    COP [38] ( #$0030 )
    COP [09] ( #$9C02 )
}