; The shared fairy texts and the return prompt of King Magridd's castle (file offsets 159349-159388 for the scripts, the texts around them). Used by the fairies of the dungeon (mc_npc_fairy_dungeon_hint_text_026F29) and the towers (mc_npc_fairy_chest_hint_026DD7), and every castle text ends with a jump to asciistring_0270DF (window clear and wait).
; 
; === FLOW ===
; mc_fairy_chest_hint_then_prompt_026E75 shows the chest hint, mc_fairy_return_prompt_026E79 shows 'Would you like to return to the outside of Magridd Castle?' with ChoiceStayGoBackText. Stay (result 0) or cancel: 'Come back to me when you feel like it.' Go back: 'Good luck then.' and COP 10 to A10S01 (the castle town) at pixel ($01F0,$0140).
; 
; === TEXTS ===
; asciistring_02706C ('I am watching over the world, here take this. <name> received EXP!') has no reference in the code of this region; its user is not identified (OQ-I039-12).
---------------------------------------------

?BANK 04

?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0

---------------------------------------------

asciistring_026DF2 |[10]There are many [N]treasure chests hidden[N]in the basements and [N]towers- [FIN]If a soldier, the one [N]who knows a lot about [N]the Magridd castle [N]joins you, [FIN]then the treasures [N]will be found easily- [FIN][END]|
---------------------------------------------

; Shows the chest hint, then the return prompt.
; 
; When: COP 17 handler of the prison fairy.
; Sees: the hint text of the treasure chests, then falls into mc_fairy_return_prompt_026E79.
; Why: the prison fairy always shows the prompt after the hint.
; In: X = D = the fairy.
; Out: see mc_fairy_return_prompt_026E79.
; Clobbers: A.

mc_fairy_chest_hint_then_prompt_026E75 {
    COP [01] ( &asciistring_026DF2 )

; Asks whether the hero wants to leave the castle.
; 
; When: the end of the dungeon fairy's talk handler (BRL) and of the chest hint.
; Sees: 'Would you like to return to the outside of Magridd Castle?' with ChoiceStayGoBackText (cancel = code_026E98). A result of 0 stays; any other result shows 'Good luck then.' and moves the hero to A10S01 at pixel ($01F0,$0140).
; Why: the way out of the dungeon and the towers.
; In: X = D = the fairy.
; Out: the scene changes when the hero leaves.
; Clobbers: A.

  mc_fairy_return_prompt_026E79:
    COP [01] ( &asciistring_027090 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_026E98 )
    LDA $L_choice_result  ; 0 = Stay, otherwise Go back
    BEQ code_026E98
    COP [01] ( &asciistring_0270B8 )
    COP [10] ( #$0110, #00, #$01F0, #$0140 ) ; scene change to A10S01 (castle town) at pixel ($01F0,$0140)
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