?BANK 1F

?INCLUDE 'lib_014F5B'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0

---------------------------------------------

code_0FA46D {
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9F0 ) ; {1025133}
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_0FA48F ) ; {1025137}
    LDA $L_choice_result  ; {1025144}
    BEQ code_0FA48F       ; {1025148}
    COP [01] ( &w2_shared_0FA945.asciistring_0FAA15 ) ; {1025150}
    INC $042D             ; {1025154}
    COP [10] ( #$0106, #00, #$01F8, #$0200 ) ; {1025157}
    RTL                   ; {1025166}
}

code_0FA48F {
    COP [01] ( &w2_shared_0FA945.asciistring_0FAA29 ) ; {1025167}
    RTL                   ; {1025171}
}