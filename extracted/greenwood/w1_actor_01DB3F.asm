?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01DB3F {
    COP [14] ( #$005C, &code_01DB46 ) ; {121663}
    RTL                   ; {121669}
}

code_01DB46 {
    COP [17] ( #$0000 )   ; {121670}
    COP [91]              ; {121674}
    COP [0D] ( #00, #05, #0B, &code_01DB69 ) ; {121676}
    COP [0D] ( #00, #05, #0F, &code_01DB69 ) ; {121683}
    COP [0D] ( #00, #0E, #0D, &code_01DBA5 ) ; {121690}
    COP [0D] ( #00, #0D, #12, &code_01DBA5 ) ; {121697}
    RTL                   ; {121704}
}

code_01DB69 {
    COP [2A] ( #$0010, #$0000 ) ; {121705}
    COP [9B] ( #$0000, &code_01DB79, &code_01DB79, &code_01DB87 ) ; {121711}
}

code_01DB79 {
    COP [80] ( #0B )      ; {121721}
    COP [82]              ; {121724}
    COP [81] ( #07, #10 ) ; {121726}
    COP [83]              ; {121730}
    BRL loc_01DB92        ; {121732}
}

code_01DB87 {
    COP [80] ( #0B )      ; {121735}
    COP [82]              ; {121738}
    COP [81] ( #06, #10 ) ; {121740}
    COP [83]              ; {121744}

  loc_01DB92:
    COP [01] ( &asciistring_01DBAD ) ; {121746}
    COP [16]              ; {121750}
    COP [87]              ; {121752}
    COP [80] ( #0B )      ; {121754}
    COP [82]              ; {121757}
    COP [15]              ; {121759}
    COP [17] ( &code_01DBA8 ) ; {121761}
}

code_01DBA5 {
    COP [91]              ; {121765}
    RTL                   ; {121767}
}

code_01DBA8 {
    COP [01] ( &asciistring_01DBDB ) ; {121768}
    RTL                   ; {121772}
}

asciistring_01DBAD |[10]BOO! [FIN]----------- [FIN]Come on! Aren t you [N]suprised? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DBDB |[10]Phew! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|