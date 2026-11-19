?BANK 03

?INCLUDE 'lib_014F5B'
?INCLUDE 'w0_shared_01B2AB'

!L_choice_result                0003D0

---------------------------------------------

code_01AD1B {
    COP [01] ( &w0_shared_01B2AB.asciistring_01B2D2 ) ; {109851}
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_01AD3D ) ; {109855}
    LDA $L_choice_result  ; {109862}
    BEQ code_01AD3D       ; {109866}
    COP [01] ( &w0_shared_01B2AB.asciistring_01B2F5 ) ; {109868}
    INC $042D             ; {109872}
    COP [10] ( #$0101, #00, #$0138, #$03A0 ) ; {109875}
    RTL                   ; {109884}
}

code_01AD3D {
    COP [01] ( &w0_shared_01B2AB.asciistring_01B30E ) ; {109885}
    RTL                   ; {109889}
}