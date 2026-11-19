?BANK 03

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01E4E9'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E594 {
    COP [14] ( #$0053, &code_01E59B ) ; {124308}
    RTL                   ; {124314}
}

code_01E59B {
    JSL $@w0_shared_01B161.code_01B161 ; {124315}
    COP [17] ( &code_01E5AF ) ; {124319}
    SEP #$20              ; {124323}
    LDA #$^w0_shared_01B161.code_01B17C ; {124325}
    PHA                   ; {124327}
    REP #$20              ; {124328}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {124330}
    PHA                   ; {124333}
    RTL                   ; {124334}
}

code_01E5AF {
    COP [01] ( &w1_shared_01EBC2.asciistring_01EBC2 ) ; {124335}
    COP [38] ( #$0001 )   ; {124339}
    BRL w1_shared_01E4E9.code_01E4E9 ; {124343}
}