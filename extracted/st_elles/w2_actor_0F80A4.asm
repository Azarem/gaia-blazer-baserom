?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F80A4 {
    COP [14] ( #$00B1, &code_0F80AB ) ; {1015972}
    RTL                   ; {1015978}
}

code_0F80AB {
    COP [30] ( #$00B1, &code_0F8108, #1F ) ; {1015979}
    COP [07] ( #$8701, &code_0F80D4 ) ; {1015986}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1015992}
    COP [17] ( &code_0F80DC ) ; {1015997}

  loc_0F80C1:
    COP [81] ( #14, #02 ) ; {1016001}
    COP [83]              ; {1016005}
    COP [87]              ; {1016007}
    COP [81] ( #13, #02 ) ; {1016009}
    COP [83]              ; {1016013}
    COP [87]              ; {1016015}
    BRL loc_0F80C1        ; {1016017}
}

code_0F80D4 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1016020}
    COP [86]              ; {1016025}
    RTL                   ; {1016027}
}

code_0F80DC {
    LDA $0016, X          ; {1016028}
    AND #$FFEF            ; {1016031}
    STA $0016, X          ; {1016034}
    COP [01] ( &asciistring_0F814A ) ; {1016037}
    LDA $0016, X          ; {1016041}
    ORA #$0010            ; {1016044}
    STA $0016, X          ; {1016047}
    SEP #$20              ; {1016050}
    LDA $1B82             ; {1016052}
    ORA #$04              ; {1016055}
    STA $1B82             ; {1016057}
    REP #$20              ; {1016060}
    COP [09] ( #$8701 )   ; {1016062}
    BRK #$4E              ; {1016066}
    COP [27] ( &code_0F80D4 ) ; {1016068}
}

code_0F8108 {
    COP [01] ( &asciistring_0F810F ) ; {1016072}
    COP [86]              ; {1016076}
    RTL                   ; {1016078}
}

asciistring_0F810F |[10][0E:3C]I have the power to [N]stop the Magma Rain- [N]I will help you if you[N]return to me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F814A |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]I will protect you [N]from the Magma- [FIN]Please try and protect[N]all creatures- [FIN]Let s work together so[N]we may revive the [N]world! [FIN]The creature that [N]enables you to avoid [N]Magma has joined you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|