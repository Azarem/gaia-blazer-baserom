?BANK 00

?INCLUDE 'engine_007A52'

---------------------------------------------

code_00797B {
    COP [07] ( #$9F06, &code_007995 )
    COP [09] ( #$9F06 )
    COP [1B] ( &code_00798B, #$0002 )
}

code_00798B {
    COP [01] ( &asciistring_007998 )
    COP [3A]
    COP [01] ( &asciistring_007A06 )
}

code_007995 {
    COP [86]
    RTL 
}

asciistring_007998 |[10]A voice came from [N]above- [FIN]"My follower, since [N]you will be able to [N]speak with all living [N]things, [FIN]you should have a [N]name- Please choose a [N]name for yourself- [JMP:&engine_007A52.asciistring_007A52]|

asciistring_007A06 |[10][02:2],------- [N]What an interesting [N]name- [FIN]Allright, go and save [N]the world for all [N]creatures- [JMP:&engine_007A52.asciistring_007A52]|