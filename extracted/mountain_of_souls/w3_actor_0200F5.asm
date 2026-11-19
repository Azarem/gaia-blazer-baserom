?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0200F5 {
    COP [14] ( #$00D3, &code_0200FC ) ; {131317}
    RTL                   ; {131323}
}

code_0200FC {
    COP [17] ( &code_020119 ) ; {131324}
    COP [14] ( #$00EA, &code_02010F ) ; {131328}
    LDA $0016, X          ; {131334}
    AND #$FFF7            ; {131337}
    STA $0016, X          ; {131340}
}

code_02010F {
    COP [85] ( @engine_0026F3.code_00299D ) ; {131343}
    COP [15]              ; {131348}
    COP [91]              ; {131350}
    RTL                   ; {131352}
}

code_020119 {
    COP [01] ( &asciistring_02011E ) ; {131353}
    RTL                   ; {131357}
}

asciistring_02011E |[10]My wife was able to [N]use magic at one time- [JMP:&w3_shared_02249A.asciistring_02251E]|