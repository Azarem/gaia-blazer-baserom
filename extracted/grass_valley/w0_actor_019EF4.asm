?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019EF4 {
    COP [14] ( #$0028, &code_019EFB )
    RTL 
}

code_019EFB {
    COP [17] ( &code_019F04 )
    COP [15]
    COP [91]
    RTL 
}

code_019F04 {
    COP [01] ( &asciistring_019F09 )
    RTL 
}

asciistring_019F09 |[10]Since losing my wife [N]to an illness, I [N]noticed a goat hanging[N]around my place- [FIN]I was so lonely [N]I decided to keep the [N]goat as a pet- [JMP:&w0_shared_01B988.asciistring_01B988]|