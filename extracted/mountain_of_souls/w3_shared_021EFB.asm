?BANK 04

?INCLUDE 'lib_014F5B'
?INCLUDE 'w3_shared_02249A'

!L_choice_result                0003D0

---------------------------------------------

code_021EFB {
    COP [01] ( &w3_shared_02249A.asciistring_0224C2 ) ; {139003}
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_021F1D ) ; {139007}
    LDA $L_choice_result  ; {139014}
    BEQ code_021F1D       ; {139018}
    COP [01] ( &w3_shared_02249A.asciistring_0224F4 ) ; {139020}
    INC $042D             ; {139024}
    COP [10] ( #$010A, #00, #$01D8, #$0040 ) ; {139027}
    RTL                   ; {139036}
}

code_021F1D {
    COP [01] ( &w3_shared_02249A.asciistring_022507 ) ; {139037}
    RTL                   ; {139041}
}