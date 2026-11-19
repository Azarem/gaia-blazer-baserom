?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01CD6D {
    COP [14] ( #$003D, &code_01CD74 )
    RTL 
}

code_01CD74 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01CDE1 )
    COP [15]
    COP [91]
    RTL 
}

code_01CD82 {
    COP [17] ( &code_01CDE9 )
    COP [16]
    COP [80] ( #0F )
    COP [82]
    COP [9D] ( #0F )
    COP [9E] ( &code_01CD94 )
}

code_01CD94 {
    COP [87]
    COP [81] ( #11, #08 )
    COP [83]
    COP [80] ( #0E )
    COP [82]
    COP [17] ( &code_01CDEE )
    COP [15]
    COP [91]
    RTL 
}

code_01CDAA {
    COP [16]
    COP [17] ( &code_01CDF6 )
    COP [81] ( #10, #06 )
    COP [83]
    COP [81] ( #11, #02 )
    COP [83]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #0D )
    COP [82]
    COP [17] ( &code_01CDFB )
    COP [15]
    COP [91]
    COP [0D] ( #00, #1D, #09, &code_01CDD6 )
    RTL 
}

code_01CDD6 {
    COP [01] ( &asciistring_01CED5 )
    COP [09] ( #$8001 )
    COP [91]
    RTL 
}

code_01CDE1 {
    COP [01] ( &asciistring_01CE0B )
    COP [27] ( &code_01CD82 )
}

code_01CDE9 {
    COP [01] ( &asciistring_01CE0B )
    RTL 
}

code_01CDEE {
    COP [01] ( &asciistring_01CE48 )
    COP [27] ( &code_01CDAA )
}

code_01CDF6 {
    COP [01] ( &asciistring_01CEA7 )
    RTL 
}

code_01CDFB {
    COP [07] ( #$8001, &code_01CE06 )
    COP [01] ( &asciistring_01CEAB )
    RTL 
}

code_01CE06 {
    COP [01] ( &asciistring_01CEE6 )
    RTL 
}

asciistring_01CE0B |[10]I can tell what [N]something is just by [N]it s smell- [FIN]Allright, let me start[N]doing my job- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CE48 |[10]From >,[N][0E:3C]I smell fresh air- [FIN]From _, [0E:3C]I smell a [N]mole- [FIN]What is that smell!! [N][::]I smell something [N]strange coming from '-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CEA7 |[10][JMP:&asciistring_01CE48+M]|

asciistring_01CEAB |[10]It s around here [N]somewhere- [N]I smell something [N]really strange! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CED5 |[10]There is an outhouse- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CEE6 |[10]Oh, this is our [N]bathroom- [FIN]Thank you for walking [N]with me- [N]I will tell you a [N]secret- [FIN]I can smell some armor[N]north of here- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|