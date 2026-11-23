?BANK 04

?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0

---------------------------------------------

asciistring_026DF2 |[10]There are many [N]treasure chests hidden[N]in the basements and [N]towers- [FIN]If a soldier, the one [N]who knows a lot about [N]the Magridd castle [N]joins you, [FIN]then the treasures [N]will be found easily- [FIN][END]|
---------------------------------------------

code_026E75 {
    COP [01] ( &asciistring_026DF2 )

  code_026E79:
    COP [01] ( &asciistring_027090 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_026E98 )
    LDA $L_choice_result
    BEQ code_026E98
    COP [01] ( &asciistring_0270B8 )
    COP [10] ( #$0110, #00, #$01F0, #$0140 )
    RTL 
}

code_026E98 {
    COP [01] ( &asciistring_0270CB )
    RTL 
}
---------------------------------------------

asciistring_02706C |[10]I am watching over [N]the world, [N]here take this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_027090 |[10]Would you like to [N]return to the outside [N]of Magridd Castle? [END]|

asciistring_0270B8 |Good luck then- [JMP:&asciistring_0270DF]|

asciistring_0270CB |Come back to me when [N]you feel like it- [JMP:&asciistring_0270DF]|

asciistring_0270DF |[12][::][08:408][END]|