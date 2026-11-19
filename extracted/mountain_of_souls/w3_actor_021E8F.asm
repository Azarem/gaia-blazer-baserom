?BANK 04

?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021E8F {
    COP [07] ( #$9A05, &code_021EAC )
    COP [91]
    COP [0D] ( #00, #20, #2E, &code_021E9F )
    RTL 
}

code_021E9F {
    COP [01] ( &asciistring_021EAF )
    BRK #$5E
    COP [0A] ( #2F )
    COP [09] ( #$9A05 )
}

code_021EAC {
    COP [86]
    RTL 
}

asciistring_021EAF |[10][02:2] found [N][03:24]Master s Emblem F- [03:20][JMP:&w3_shared_02249A.asciistring_02251E]|