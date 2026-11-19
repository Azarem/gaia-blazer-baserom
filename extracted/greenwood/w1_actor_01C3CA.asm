?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01C3CA {
    COP [14] ( #$0046, &code_01C3D1 ) ; {115658}
    RTL                   ; {115664}
}

code_01C3D1 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {115665}
    COP [AC] ( @code_01C495, #$0220, #$02E0, #$2040 ) ; {115670}
    COP [17] ( &code_01C41C ) ; {115681}

  loc_01C3E5:
    COP [80] ( #1D )      ; {115685}
    COP [82]              ; {115688}
    COP [1B] ( &code_01C3F0, #$0028 ) ; {115690}
}

code_01C3F0 {
    COP [87]              ; {115696}
    COP [80] ( #1D )      ; {115698}
    COP [82]              ; {115701}
    COP [1B] ( &code_01C3FD, #$003C ) ; {115703}
}

code_01C3FD {
    COP [A3]              ; {115709}
    COP [80] ( #1E )      ; {115711}
    COP [82]              ; {115714}
    COP [81] ( #1F, #04 ) ; {115716}
    COP [83]              ; {115720}
    COP [87]              ; {115722}
    COP [81] ( #1F, #04 ) ; {115724}
    COP [83]              ; {115728}
    COP [80] ( #20 )      ; {115730}
    COP [82]              ; {115733}
    COP [A6]              ; {115735}
    BRL loc_01C3E5        ; {115737}
}

code_01C41C {
    COP [01] ( &asciistring_01C421 ) ; {115740}
    RTL                   ; {115744}
}

asciistring_01C421 |[10]We tell the trees [N]what is taking place [N]and in turn they give [N]us seeds to eat- [FIN]So I guess you could [N]say we have sort of a [N]give+and+take [N]relationship- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C495 {
    COP [17] ( &code_01C4A1 ) ; {115861}
    COP [91]              ; {115865}
    COP [80] ( #23 )      ; {115867}
    COP [82]              ; {115870}
    RTL                   ; {115872}
}

code_01C4A1 {
    COP [01] ( &asciistring_01C4A6 ) ; {115873}
    RTL                   ; {115877}
}

asciistring_01C4A6 |[10][0A]The█birds█tell█me█many[N]stories-[FIN]I█am█thankful█for[N]them█because█I█can t[N]move█from█this█spot-[FIN]The█birds█tell█me█the[N]Lostside█Marsh█has[N]three█shrines-[FIN]One█is█called█Water,[FIN]another█is█Fire[FIN]and█the█third█is[N]Light-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|