?BANK 04

?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'll_watching_over_world_return_prompt_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!contact_lock                   042D

---------------------------------------------

code_023DD3 {
    COP [14] ( #$0127, &code_023DDA )
    RTL 
}

code_023DDA {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_023DEE )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.code_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.code_022289-1
    PHA 
    RTL 
}

code_023DEE {
    COP [07] ( #$9D01, &code_023E00 )
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F33 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D01 )
}
---------------------------------------------

code_023E00 {
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F59 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_023E22 )
    LDA $L_choice_result
    BEQ code_023E22
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F7D )
    INC $contact_lock
    COP [10] ( #$010D, #00, #$0188, #$0190 )
    RTL 
}

code_023E22 {
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F8B )
    RTL 
}
---------------------------------------------

code_023E57 {
    COP [14] ( #$0130, &code_023E5E )
    RTL 
}

code_023E5E {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_023E72 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.code_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.code_022289-1
    PHA 
    RTL 
}

code_023E72 {
    COP [07] ( #$9D03, &code_023E00 )
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F33 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D03 )
    BRL code_023E00
}
---------------------------------------------

code_023F17 {
    COP [19] ( #0A, &code_023F1D )
    RTL 
}

code_023F1D {
    LDA #$00F3
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCS loc_023F2F
    LDA #$00E1
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCC loc_023F32

  loc_023F2F:
    COP [39] ( #04 )

  loc_023F32:
    RTL 
}