?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F982F {
    COP [3B] ( #$008E, &code_0F9845 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F9845 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F9858 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F9858 {
    COP [18] ( #18, &code_0F985F )
    BRA loc_0F9864
}

code_0F985F {
    COP [18] ( #34, &code_0F9869 )

  loc_0F9864:
    COP [01] ( &asciistring_0F98C6 )
    RTL 
}

code_0F9869 {
    COP [01] ( &asciistring_0F9873 )
    BRK #$5E
    COP [0A] ( #34 )
    RTL 
}

asciistring_0F9873 |[10]Thank you very [N]much for releasing me![FIN]I will give you [03:24]the [N]Red+Hot Stick- [N][03:20]The Phoenix resides on[N]the Stick- [FIN][JMP:&asciistring_0F98C6+M]|

asciistring_0F98C6 |[10][::]Take the Red+Hot Stick[N]and visit the Mountain[N]King- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|