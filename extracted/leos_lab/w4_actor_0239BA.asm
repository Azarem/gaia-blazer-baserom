?BANK 04

?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0239BA {
    COP [14] ( #$011E, &code_0239C1 )
    RTL 
}

code_0239C1 {
    COP [17] ( &code_0239C8 )
    COP [91]
    RTL 
}

code_0239C8 {
    COP [01] ( &asciistring_0239D6 )
    COP [10] ( #$010F, #01, #$01F8, #$03E0 )
    RTL 
}

asciistring_0239D6 |[10][0F][02:2] is [N]swallowed into the [N]model- [JMP:&w4_shared_023F33.asciistring_023FA3]|