?BANK 03

?INCLUDE 'lib_014F5B'
?INCLUDE 'w0_shared_01B2AB'

!L_choice_result                0003D0

---------------------------------------------

code_01AD1B {
    COP [01] ( &w0_shared_01B2AB.asciistring_01B2D2 )
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_01AD3D )
    LDA $L_choice_result
    BEQ code_01AD3D
    COP [01] ( &w0_shared_01B2AB.asciistring_01B2F5 )
    INC $042D
    COP [10] ( #$0101, #00, #$0138, #$03A0 )
    RTL 
}

code_01AD3D {
    COP [01] ( &w0_shared_01B2AB.asciistring_01B30E )
    RTL 
}