?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01C2F9 {
    COP [14] ( #$0058, &code_01C300 ) ; {115449}
    RTL                   ; {115455}
}

code_01C300 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {115456}
    COP [AC] ( @code_01C372, #$0070, #$02D0, #$2040 ) ; {115461}
    COP [17] ( &code_01C335 ) ; {115472}
    COP [91]              ; {115476}

  loc_01C316:
    COP [81] ( #05, #03 ) ; {115478}
    COP [83]              ; {115482}
    COP [81] ( #03, #03 ) ; {115484}
    COP [83]              ; {115488}
    COP [87]              ; {115490}
    COP [81] ( #05, #03 ) ; {115492}
    COP [83]              ; {115496}
    COP [81] ( #04, #03 ) ; {115498}
    COP [83]              ; {115502}
    COP [87]              ; {115504}
    BRL loc_01C316        ; {115506}
}

code_01C335 {
    COP [01] ( &asciistring_01C33A ) ; {115509}
    RTL                   ; {115513}
}

asciistring_01C33A |[10]I hear someone [N]snoring- [N]I cannot tell who is [N]making the noise- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C372 {
    COP [17] ( &code_01C37E ) ; {115570}
    COP [91]              ; {115574}
    COP [80] ( #23 )      ; {115576}
    COP [82]              ; {115579}
    RTL                   ; {115581}
}

code_01C37E {
    COP [19] ( #1C, &code_01C397 ) ; {115582}
    COP [01] ( &asciistring_01C3A7 ) ; {115587}
    STZ $0419             ; {115591}
    COP [3C] ( #04 )      ; {115594}
    COP [10] ( #$0604, #02, #$0120, #$0040 ) ; {115597}
    RTL                   ; {115606}
}

code_01C397 {
    COP [01] ( &asciistring_01C39C ) ; {115607}
    RTL                   ; {115611}
}

asciistring_01C39C |[10][0A]Zzzzz [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C3A7 |[10][02:2] placed the [N]Dream Rod upon the [N]stump- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|