?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0202BA {
    COP [14] ( #$00F8, &code_0202C1 ) ; {131770}
    RTL                   ; {131776}
}

code_0202C1 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {131777}
    COP [17] ( &code_0202CF ) ; {131782}
    COP [15]              ; {131786}
    COP [91]              ; {131788}
    RTL                   ; {131790}
}

code_0202CF {
    COP [01] ( &asciistring_0202D4 ) ; {131791}
    RTL                   ; {131795}
}

asciistring_0202D4 |[10]Make sure you search [N]Laynole very [N]carefully- [FIN]If you move too fast [N]you may overlook [N]things--- [JMP:&w3_shared_02249A.asciistring_02251E]|