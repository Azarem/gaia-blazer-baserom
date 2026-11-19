?BANK 04

?INCLUDE 'lib_014F5B'
?INCLUDE 'w5_shared_02706C'

!L_choice_result                0003D0

---------------------------------------------

asciistring_026DF2 |[10]There are many [N]treasure chests hidden[N]in the basements and [N]towers- [FIN]If a soldier, the one [N]who knows a lot about [N]the Magridd castle [N]joins you, [FIN]then the treasures [N]will be found easily- [FIN][END]|
---------------------------------------------

code_026E75 {
    COP [01] ( &asciistring_026DF2 ) ; {159349}

  code_026E79:
    COP [01] ( &w5_shared_02706C.asciistring_027090 ) ; {159353}
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_026E98 ) ; {159357}
    LDA $L_choice_result  ; {159364}
    BEQ code_026E98       ; {159368}
    COP [01] ( &w5_shared_02706C.asciistring_0270B8 ) ; {159370}
    COP [10] ( #$0110, #00, #$01F0, #$0140 ) ; {159374}
    RTL                   ; {159383}
}

code_026E98 {
    COP [01] ( &w5_shared_02706C.asciistring_0270CB ) ; {159384}
    RTL                   ; {159388}
}