?BANK 04

?INCLUDE 'lib_014F5B'
?INCLUDE 'w4_shared_023F33'

!L_choice_result                0003D0

---------------------------------------------

code_023E00 {
    COP [01] ( &w4_shared_023F33.asciistring_023F59 ) ; {146944}
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_023E22 ) ; {146948}
    LDA $L_choice_result  ; {146955}
    BEQ code_023E22       ; {146959}
    COP [01] ( &w4_shared_023F33.asciistring_023F7D ) ; {146961}
    INC $042D             ; {146965}
    COP [10] ( #$010D, #00, #$0188, #$0190 ) ; {146968}
    RTL                   ; {146977}
}

code_023E22 {
    COP [01] ( &w4_shared_023F33.asciistring_023F8B ) ; {146978}
    RTL                   ; {146982}
}