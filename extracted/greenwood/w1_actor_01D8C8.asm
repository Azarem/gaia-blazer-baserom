?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D8C8 {
    COP [14] ( #$0051, &code_01D8CF ) ; {121032}
    RTL                   ; {121038}
}

code_01D8CF {
    COP [07] ( #$8403, &code_01D905 ) ; {121039}
    COP [15]              ; {121045}
    COP [17] ( &code_01D908 ) ; {121047}
    COP [91]              ; {121051}
    RTL                   ; {121053}
}

code_01D8DE {
    COP [17] ( #$0000 )   ; {121054}
    COP [03] ( #20 )      ; {121058}
    LDA $0016, X          ; {121061}
    AND #$DFFF            ; {121064}
    STA $0016, X          ; {121067}
    COP [80] ( #07 )      ; {121070}
    COP [82]              ; {121073}
    LDA $0016, X          ; {121075}
    ORA #$2000            ; {121078}
    STA $0016, X          ; {121081}
    COP [80] ( #07 )      ; {121084}
    COP [82]              ; {121087}
    COP [04]              ; {121089}
    COP [16]              ; {121091}
}

code_01D905 {
    COP [86]              ; {121093}
    RTL                   ; {121095}
}

code_01D908 {
    COP [19] ( #1F, &code_01D91C ) ; {121096}
    COP [01] ( &asciistring_01D94B ) ; {121101}
    COP [0B] ( #1F )      ; {121105}
    COP [09] ( #$8403 )   ; {121108}
    COP [27] ( &code_01D8DE ) ; {121112}
}

code_01D91C {
    COP [01] ( &asciistring_01D921 ) ; {121116}
    RTL                   ; {121120}
}

asciistring_01D921 |[10]You must bring [N]me something that once[N]belonged to Monmo- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D94B |[10]Th-- that s Monmo s [N]ribbon! [FIN]Al-- allright, I will [N]move if you give that [N]to me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|