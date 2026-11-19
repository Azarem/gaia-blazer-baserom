?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020452 {
    COP [14] ( #$00E6, &code_020459 )
    RTL 
}

code_020459 {
    COP [17] ( &code_0204D2 )
    COP [14] ( #$0103, &code_020481 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_020473 )
    RTL 
}

code_020473 {
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #08 )
    COP [83]
    COP [91]
    RTL 
}

code_020481 {
    COP [11] ( #0B, #0F, #37 )
    COP [85] ( @engine_0026F3.code_00299D )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [15]
    COP [05] ( #$0004 )
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #29, #04 )
    COP [83]
    COP [81] ( #2A, #08 )
    COP [83]
    COP [81] ( #2B, #10 )
    COP [83]
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_0204D2 {
    COP [14] ( #$0103, &code_0204DD )
    COP [01] ( &asciistring_0204EC )
    RTL 
}

code_0204DD {
    COP [18] ( #18, &code_0204E7 )
    COP [01] ( &asciistring_020545 )
    RTL 
}

code_0204E7 {
    COP [01] ( &asciistring_0204FD )
    RTL 
}

asciistring_0204EC |[10]Please save the King! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0204FD |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020545 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&w3_shared_02249A.asciistring_02251E]|