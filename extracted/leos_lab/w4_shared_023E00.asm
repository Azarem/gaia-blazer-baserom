?BANK 04

?INCLUDE 'lib_014F5B'
?INCLUDE 'w4_shared_023F33'

!L_choice_result                0003D0

---------------------------------------------

code_023E00 {
    COP [01] ( &w4_shared_023F33.asciistring_023F59 )
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_023E22 )
    LDA $L_choice_result
    BEQ code_023E22
    COP [01] ( &w4_shared_023F33.asciistring_023F7D )
    INC $042D
    COP [10] ( #$010D, #00, #$0188, #$0190 )
    RTL 
}

code_023E22 {
    COP [01] ( &w4_shared_023F33.asciistring_023F8B )
    RTL 
}