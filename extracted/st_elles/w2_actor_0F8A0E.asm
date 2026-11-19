?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8A0E {
    COP [14] ( #$009B, &code_0F8A15 ) ; {1018382}
    RTL                   ; {1018388}
}

code_0F8A15 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1018389}
    COP [15]              ; {1018394}
    COP [17] ( &code_0F8A28 ) ; {1018396}
    COP [91]              ; {1018400}
    COP [80] ( #11 )      ; {1018402}
    COP [82]              ; {1018405}
    RTL                   ; {1018407}
}

code_0F8A28 {
    COP [01] ( &asciistring_0F8A2D ) ; {1018408}
    RTL                   ; {1018412}
}

asciistring_0F8A2D |[10]There used to be [N]4 mermaid statues in [N]this place- [FIN]Those statues [N]prevented all [N]creatures from getting[N]lost- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|