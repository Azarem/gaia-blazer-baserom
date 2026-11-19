?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0200F5 {
    COP [14] ( #$00D3, &code_0200FC )
    RTL 
}

code_0200FC {
    COP [17] ( &code_020119 )
    COP [14] ( #$00EA, &code_02010F )
    LDA $0016, X
    AND #$FFF7
    STA $0016, X
}

code_02010F {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [91]
    RTL 
}

code_020119 {
    COP [01] ( &asciistring_02011E )
    RTL 
}

asciistring_02011E |[10]My wife was able to [N]use magic at one time- [JMP:&w3_shared_02249A.asciistring_02251E]|