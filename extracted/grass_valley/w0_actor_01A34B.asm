?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01A34B {
    COP [15]              ; {107339}
    COP [17] ( &code_01A362 ) ; {107341}
    COP [91]              ; {107345}
    COP [14] ( #$0009, &code_01A35F ) ; {107347}
    COP [80] ( #23 )      ; {107353}
    COP [82]              ; {107356}
    RTL                   ; {107358}
}

code_01A35F {
    COP [86]              ; {107359}
    RTL                   ; {107361}
}

code_01A362 {
    COP [01] ( &asciistring_01A367 ) ; {107362}
    RTL                   ; {107366}
}

asciistring_01A367 |[10]This is the room of [N]the village Chief- He [N]used to sit and rock [N]here for hours- [FIN]I wonder when he is [N]going to come back? [JMP:&w0_shared_01B988.asciistring_01B988]|