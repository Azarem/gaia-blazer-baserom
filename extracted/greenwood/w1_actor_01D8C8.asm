?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D8C8 {
    COP [14] ( #$0051, &code_01D8CF )
    RTL 
}

code_01D8CF {
    COP [07] ( #$8403, &code_01D905 )
    COP [15]
    COP [17] ( &code_01D908 )
    COP [91]
    RTL 
}

code_01D8DE {
    COP [17] ( #$0000 )
    COP [03] ( #20 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    COP [04]
    COP [16]
}

code_01D905 {
    COP [86]
    RTL 
}

code_01D908 {
    COP [19] ( #1F, &code_01D91C )
    COP [01] ( &asciistring_01D94B )
    COP [0B] ( #1F )
    COP [09] ( #$8403 )
    COP [27] ( &code_01D8DE )
}

code_01D91C {
    COP [01] ( &asciistring_01D921 )
    RTL 
}

asciistring_01D921 |[10]You must bring [N]me something that once[N]belonged to Monmo- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D94B |[10]Th-- that s Monmo s [N]ribbon! [FIN]Al-- allright, I will [N]move if you give that [N]to me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|