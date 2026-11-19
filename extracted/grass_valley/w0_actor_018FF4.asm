?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_018FF4 {
    COP [14] ( #$0011, &code_018FFB )
    RTL 
}

code_018FFB {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01900D )
    COP [15]

  loc_019006:
    COP [80] ( #1E )
    COP [82]
    BRA loc_019006
}

code_01900D {
    COP [18] ( #1C, &code_019017 )
    COP [01] ( &asciistring_01901C )
    RTL 
}

code_019017 {
    COP [01] ( &asciistring_019098 )
    RTL 
}

asciistring_01901C |[10]The Dream Rod you [N]possess is a magical [N]stick that enables you[N]to look into dreams- [FIN]Equip this stick when [N]you wish to speak with[N]someone who is [N]sleeping- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019098 |[10]I have heard of a [N]strange stick that [N]enables anyone who [N]possesses it [FIN]to speak with those [N]that are asleep- It is[N]hidden in the [N]Underground Castle- [JMP:&w0_shared_01B988.asciistring_01B988]|