?BANK 04

?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021E8F {
    COP [07] ( #$9A05, &code_021EAC ) ; {138895}
    COP [91]              ; {138901}
    COP [0D] ( #00, #20, #2E, &code_021E9F ) ; {138903}
    RTL                   ; {138910}
}

code_021E9F {
    COP [01] ( &asciistring_021EAF ) ; {138911}
    BRK #$5E              ; {138915}
    COP [0A] ( #2F )      ; {138917}
    COP [09] ( #$9A05 )   ; {138920}
}

code_021EAC {
    COP [86]              ; {138924}
    RTL                   ; {138926}
}

asciistring_021EAF |[10][02:2] found [N][03:24]Master s Emblem F- [03:20][JMP:&w3_shared_02249A.asciistring_02251E]|