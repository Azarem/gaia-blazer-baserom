?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F905C {
    COP [3B] ( #$00B5, &code_0F9072 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F9072 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F9085 )
    COP [15]
    COP [91]
    COP [80] ( #02 )
    COP [82]
    RTL 
}

code_0F9085 {
    COP [18] ( #13, &code_0F908F )
    COP [01] ( &asciistring_0F90B5 )
    RTL 
}

code_0F908F {
    COP [01] ( &asciistring_0F9099 )
    BRK #$5E
    COP [0A] ( #13 )
    RTL 
}

asciistring_0F9099 |[10]I will give you [N][03:24]the Magic Flair- [FIN][03:20][JMP:&asciistring_0F90B5+M]|

asciistring_0F90B5 |[10][::]Magic Flair is useful [N]against monsters that [N]fly and have a large [N]amount of hit points- [FIN]You know which [N]monsters I am [N]referring to, right? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|