?BANK 04

?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0239F8 {
    COP [14] ( #$0145, &code_0239FF )
    RTL 
}

code_0239FF {
    COP [17] ( &code_023A06 )
    COP [91]
    RTL 
}

code_023A06 {
    COP [01] ( &asciistring_023A14 )
    COP [10] ( #$020F, #01, #$01F8, #$03E0 )
    RTL 
}

asciistring_023A14 |[10][0F][02:2] is [N]swallowed into the [N]model- [JMP:&w4_shared_023F33.asciistring_023FA3]|