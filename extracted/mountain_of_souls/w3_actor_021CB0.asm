?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021CB0 {
    COP [14] ( #$00CA, &code_021CB7 ) ; {138416}
    RTL                   ; {138422}
}

code_021CB7 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {138423}
    COP [15]              ; {138428}
    COP [17] ( &code_021CC5 ) ; {138430}
    COP [91]              ; {138434}
    RTL                   ; {138436}
}

code_021CC5 {
    COP [01] ( &asciistring_021CCA ) ; {138437}
    RTL                   ; {138441}
}

asciistring_021CCA |[10]This is where the [N]Mountain of Souls [N]exists- [FIN]It is quite warm [N]inside the mountain- [JMP:&w3_shared_02249A.asciistring_02251E]|