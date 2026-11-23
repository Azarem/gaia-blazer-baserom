?BANK 04

?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'

!bg2_offset_x                   038A

---------------------------------------------

code_026DD7 {
    COP [14] ( #$0184, &code_026DDE )
    RTL 
}

code_026DDE {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &mc_return_prompt_and_chest_hint_texts.code_026E75 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.code_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.code_022289-1
    PHA 
    RTL 
}
---------------------------------------------

code_026F44 {
    DEC $bg2_offset_x
    RTL 
}