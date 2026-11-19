?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F905C {
    COP [3B] ( #$00B5, &code_0F9072 ) ; {1019996}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1020002}
    SEP #$20              ; {1020006}
    LDA #$^engine_003005.code_00305F ; {1020008}
    PHA                   ; {1020010}
    REP #$20              ; {1020011}
    LDA #$&engine_003005.code_00305F-1 ; {1020013}
    PHA                   ; {1020016}
    RTL                   ; {1020017}
}

code_0F9072 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1020018}
    COP [17] ( &code_0F9085 ) ; {1020023}
    COP [15]              ; {1020027}
    COP [91]              ; {1020029}
    COP [80] ( #02 )      ; {1020031}
    COP [82]              ; {1020034}
    RTL                   ; {1020036}
}

code_0F9085 {
    COP [18] ( #13, &code_0F908F ) ; {1020037}
    COP [01] ( &asciistring_0F90B5 ) ; {1020042}
    RTL                   ; {1020046}
}

code_0F908F {
    COP [01] ( &asciistring_0F9099 ) ; {1020047}
    BRK #$5E              ; {1020051}
    COP [0A] ( #13 )      ; {1020053}
    RTL                   ; {1020056}
}

asciistring_0F9099 |[10]I will give you [N][03:24]the Magic Flair- [FIN][03:20][JMP:&asciistring_0F90B5+M]|

asciistring_0F90B5 |[10][::]Magic Flair is useful [N]against monsters that [N]fly and have a large [N]amount of hit points- [FIN]You know which [N]monsters I am [N]referring to, right? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|