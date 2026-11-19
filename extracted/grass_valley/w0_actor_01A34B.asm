?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01A34B {
    COP [15]
    COP [17] ( &code_01A362 )
    COP [91]
    COP [14] ( #$0009, &code_01A35F )
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01A35F {
    COP [86]
    RTL 
}

code_01A362 {
    COP [01] ( &asciistring_01A367 )
    RTL 
}

asciistring_01A367 |[10]This is the room of [N]the village Chief- He [N]used to sit and rock [N]here for hours- [FIN]I wonder when he is [N]going to come back? [JMP:&w0_shared_01B988.asciistring_01B988]|