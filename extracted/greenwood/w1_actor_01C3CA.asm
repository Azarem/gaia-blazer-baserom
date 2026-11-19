?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01C3CA {
    COP [14] ( #$0046, &code_01C3D1 )
    RTL 
}

code_01C3D1 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [AC] ( @code_01C495, #$0220, #$02E0, #$2040 )
    COP [17] ( &code_01C41C )

  loc_01C3E5:
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01C3F0, #$0028 )
}

code_01C3F0 {
    COP [87]
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01C3FD, #$003C )
}

code_01C3FD {
    COP [A3]
    COP [80] ( #1E )
    COP [82]
    COP [81] ( #1F, #04 )
    COP [83]
    COP [87]
    COP [81] ( #1F, #04 )
    COP [83]
    COP [80] ( #20 )
    COP [82]
    COP [A6]
    BRL loc_01C3E5
}

code_01C41C {
    COP [01] ( &asciistring_01C421 )
    RTL 
}

asciistring_01C421 |[10]We tell the trees [N]what is taking place [N]and in turn they give [N]us seeds to eat- [FIN]So I guess you could [N]say we have sort of a [N]give+and+take [N]relationship- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C495 {
    COP [17] ( &code_01C4A1 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C4A1 {
    COP [01] ( &asciistring_01C4A6 )
    RTL 
}

asciistring_01C4A6 |[10][0A]The█birds█tell█me█many[N]stories-[FIN]I█am█thankful█for[N]them█because█I█can t[N]move█from█this█spot-[FIN]The█birds█tell█me█the[N]Lostside█Marsh█has[N]three█shrines-[FIN]One█is█called█Water,[FIN]another█is█Fire[FIN]and█the█third█is[N]Light-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|