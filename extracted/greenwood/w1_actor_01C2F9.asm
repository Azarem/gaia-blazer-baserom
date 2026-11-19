?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01C2F9 {
    COP [14] ( #$0058, &code_01C300 )
    RTL 
}

code_01C300 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [AC] ( @code_01C372, #$0070, #$02D0, #$2040 )
    COP [17] ( &code_01C335 )
    COP [91]

  loc_01C316:
    COP [81] ( #05, #03 )
    COP [83]
    COP [81] ( #03, #03 )
    COP [83]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [81] ( #04, #03 )
    COP [83]
    COP [87]
    BRL loc_01C316
}

code_01C335 {
    COP [01] ( &asciistring_01C33A )
    RTL 
}

asciistring_01C33A |[10]I hear someone [N]snoring- [N]I cannot tell who is [N]making the noise- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C372 {
    COP [17] ( &code_01C37E )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C37E {
    COP [19] ( #1C, &code_01C397 )
    COP [01] ( &asciistring_01C3A7 )
    STZ $0419
    COP [3C] ( #04 )
    COP [10] ( #$0604, #02, #$0120, #$0040 )
    RTL 
}

code_01C397 {
    COP [01] ( &asciistring_01C39C )
    RTL 
}

asciistring_01C39C |[10][0A]Zzzzz [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C3A7 |[10][02:2] placed the [N]Dream Rod upon the [N]stump- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|