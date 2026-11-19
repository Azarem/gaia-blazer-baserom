?BANK 1F

?INCLUDE 'lib_014F5B'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0

---------------------------------------------

code_0FA46D {
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9F0 )
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_0FA48F )
    LDA $L_choice_result
    BEQ code_0FA48F
    COP [01] ( &w2_shared_0FA945.asciistring_0FAA15 )
    INC $042D
    COP [10] ( #$0106, #00, #$01F8, #$0200 )
    RTL 
}

code_0FA48F {
    COP [01] ( &w2_shared_0FA945.asciistring_0FAA29 )
    RTL 
}