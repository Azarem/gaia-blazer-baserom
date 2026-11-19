?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_02032B {
    COP [14] ( #$00E1, &code_020332 )
    RTL 
}

code_020332 {
    COP [17] ( &code_0203B4 )
    COP [14] ( #$0103, &code_02035A )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_02034C )
    RTL 
}

code_02034C {
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #08 )
    COP [83]
    COP [91]
    RTL 
}

code_02035A {
    COP [11] ( #0A, #11, #37 )
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
    COP [85] ( @code_020445 )
    COP [81] ( #29, #04 )
    COP [83]
    COP [81] ( #2A, #08 )
    COP [83]
    COP [81] ( #2B, #10 )
    COP [83]
    COP [09] ( #$8005 )
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_0203B4 {
    COP [14] ( #$0103, &code_0203BF )
    COP [01] ( &asciistring_0203CE )
    RTL 
}

code_0203BF {
    COP [18] ( #18, &code_0203C9 )
    COP [01] ( &asciistring_020427 )
    RTL 
}

code_0203C9 {
    COP [01] ( &asciistring_0203DF )
    RTL 
}

asciistring_0203CE |[10]Please save the King! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0203DF |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020427 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&w3_shared_02249A.asciistring_02251E]|

code_020445 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #49 )
    COP [94]
    COP [86]
    RTL 
}