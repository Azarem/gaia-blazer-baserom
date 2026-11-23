?BANK 04

?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'

---------------------------------------------

code_0269F6 {
    COP [07] ( #$8702, &code_026A13 )
    COP [91]
    COP [0D] ( #00, #28, #05, &code_026A06 )
    RTL 
}

code_026A06 {
    COP [01] ( &asciistring_026A16 )
    BRK #$5E
    COP [0A] ( #1A )
    COP [09] ( #$8702 )
}

code_026A13 {
    COP [86]
    RTL 
}

asciistring_026A16 |[10]The body is holding [N]something- [FIN][02:2] found [N]"[03:24]harp string-[03:20]ˮ [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_026E9D {
    COP [14] ( #$0163, &code_026EA4 )
    RTL 
}

code_026EA4 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_026F29 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.code_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.code_022289-1
    PHA 
    RTL 
}
---------------------------------------------

asciistring_026EB8 |[10]The Zantetsu Sword is [N]found in Leo s [N]laboratory- [FIN]And the Spirit Sword [N]in this castle----- [FIN]try to remember where [N]the invincible [N]monsters are- [FIN][END]|
---------------------------------------------

code_026F29 {
    COP [01] ( &asciistring_026EB8 )
    BRL mc_return_prompt_and_chest_hint_texts.code_026E79
}
---------------------------------------------

code_026F30 {
    COP [19] ( #0F, &code_026F36 )
    RTL 
}

code_026F36 {
    LDA #$0088
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCS loc_026F40
    RTL 

  loc_026F40:
    COP [39] ( #03 )
    RTL 
}