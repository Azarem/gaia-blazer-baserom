?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01DB3F {
    COP [14] ( #$005C, &code_01DB46 )
    RTL 
}

code_01DB46 {
    COP [17] ( #$0000 )
    COP [91]
    COP [0D] ( #00, #05, #0B, &code_01DB69 )
    COP [0D] ( #00, #05, #0F, &code_01DB69 )
    COP [0D] ( #00, #0E, #0D, &code_01DBA5 )
    COP [0D] ( #00, #0D, #12, &code_01DBA5 )
    RTL 
}

code_01DB69 {
    COP [2A] ( #$0010, #$0000 )
    COP [9B] ( #$0000, &code_01DB79, &code_01DB79, &code_01DB87 )
}

code_01DB79 {
    COP [80] ( #0B )
    COP [82]
    COP [81] ( #07, #10 )
    COP [83]
    BRL loc_01DB92
}

code_01DB87 {
    COP [80] ( #0B )
    COP [82]
    COP [81] ( #06, #10 )
    COP [83]

  loc_01DB92:
    COP [01] ( &asciistring_01DBAD )
    COP [16]
    COP [87]
    COP [80] ( #0B )
    COP [82]
    COP [15]
    COP [17] ( &code_01DBA8 )
}

code_01DBA5 {
    COP [91]
    RTL 
}

code_01DBA8 {
    COP [01] ( &asciistring_01DBDB )
    RTL 
}

asciistring_01DBAD |[10]BOO! [FIN]----------- [FIN]Come on! Aren t you [N]suprised? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DBDB |[10]Phew! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|