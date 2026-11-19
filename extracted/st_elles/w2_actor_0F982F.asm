?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F982F {
    COP [3B] ( #$008E, &code_0F9845 ) ; {1021999}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1022005}
    SEP #$20              ; {1022009}
    LDA #$^engine_003005.code_00305F ; {1022011}
    PHA                   ; {1022013}
    REP #$20              ; {1022014}
    LDA #$&engine_003005.code_00305F-1 ; {1022016}
    PHA                   ; {1022019}
    RTL                   ; {1022020}
}

code_0F9845 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1022021}
    COP [17] ( &code_0F9858 ) ; {1022026}
    COP [15]              ; {1022030}
    COP [91]              ; {1022032}
    COP [80] ( #06 )      ; {1022034}
    COP [82]              ; {1022037}
    RTL                   ; {1022039}
}

code_0F9858 {
    COP [18] ( #18, &code_0F985F ) ; {1022040}
    BRA loc_0F9864        ; {1022045}
}

code_0F985F {
    COP [18] ( #34, &code_0F9869 ) ; {1022047}

  loc_0F9864:
    COP [01] ( &asciistring_0F98C6 ) ; {1022052}
    RTL                   ; {1022056}
}

code_0F9869 {
    COP [01] ( &asciistring_0F9873 ) ; {1022057}
    BRK #$5E              ; {1022061}
    COP [0A] ( #34 )      ; {1022063}
    RTL                   ; {1022066}
}

asciistring_0F9873 |[10]Thank you very [N]much for releasing me![FIN]I will give you [03:24]the [N]Red+Hot Stick- [N][03:20]The Phoenix resides on[N]the Stick- [FIN][JMP:&asciistring_0F98C6+M]|

asciistring_0F98C6 |[10][::]Take the Red+Hot Stick[N]and visit the Mountain[N]King- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|