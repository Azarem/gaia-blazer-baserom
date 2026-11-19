?BANK 04

?INCLUDE 'lib_014F5B'
?INCLUDE 'w5_shared_02706C'

!L_choice_result                0003D0

---------------------------------------------

asciistring_026DF2 |[10]There are many [N]treasure chests hidden[N]in the basements and [N]towers- [FIN]If a soldier, the one [N]who knows a lot about [N]the Magridd castle [N]joins you, [FIN]then the treasures [N]will be found easily- [FIN][END]|
---------------------------------------------

code_026E75 {
    COP [01] ( &asciistring_026DF2 )

  code_026E79:
    COP [01] ( &w5_shared_02706C.asciistring_027090 )
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_026E98 )
    LDA $L_choice_result
    BEQ code_026E98
    COP [01] ( &w5_shared_02706C.asciistring_0270B8 )
    COP [10] ( #$0110, #00, #$01F0, #$0140 )
    RTL 
}

code_026E98 {
    COP [01] ( &w5_shared_02706C.asciistring_0270CB )
    RTL 
}