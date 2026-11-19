?BANK 04

?INCLUDE 'lib_014F5B'
?INCLUDE 'w3_shared_02249A'

!L_choice_result                0003D0

---------------------------------------------

code_021EFB {
    COP [01] ( &w3_shared_02249A.asciistring_0224C2 )
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_021F1D )
    LDA $L_choice_result
    BEQ code_021F1D
    COP [01] ( &w3_shared_02249A.asciistring_0224F4 )
    INC $042D
    COP [10] ( #$010A, #00, #$01D8, #$0040 )
    RTL 
}

code_021F1D {
    COP [01] ( &w3_shared_02249A.asciistring_022507 )
    RTL 
}