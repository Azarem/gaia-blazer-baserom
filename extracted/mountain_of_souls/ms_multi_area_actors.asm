?BANK 04

?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!push_zone_list                 03D8
!push_zone_bank                 03DA
!contact_lock                   042D
!location_id                    1C6A

---------------------------------------------

code_021ECE {
    COP [14] ( #$00EC, &code_021ED5 )
    RTL 
}

code_021ED5 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_021EE9 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.code_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.code_022289-1
    PHA 
    RTL 
}

code_021EE9 {
    COP [07] ( #$9E00, &code_021EFB )
    COP [01] ( &shared_actor_helpers_bank4.asciistring_02249A )
    COP [38] ( #$0300 )
    COP [09] ( #$9E00 )
}
---------------------------------------------

code_021EFB {
    COP [01] ( &shared_actor_helpers_bank4.asciistring_0224C2 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_021F1D )
    LDA $L_choice_result
    BEQ code_021F1D
    COP [01] ( &shared_actor_helpers_bank4.asciistring_0224F4 )
    INC $contact_lock
    COP [10] ( #$010A, #00, #$01D8, #$0040 )
    RTL 
}

code_021F1D {
    COP [01] ( &shared_actor_helpers_bank4.asciistring_022507 )
    RTL 
}
---------------------------------------------

code_021F22 {
    COP [14] ( #$00D9, &code_021F29 )
    RTL 
}

code_021F29 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_021F3D )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.code_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.code_022289-1
    PHA 
    RTL 
}

code_021F3D {
    COP [07] ( #$9D05, &code_021EFB )
    COP [01] ( &shared_actor_helpers_bank4.asciistring_02249A )
    COP [38] ( #$0400 )
    COP [09] ( #$9D05 )
    BRL code_021EFB
}
---------------------------------------------

code_02220D {
    SEP #$20
    LDA $location_id
    LDY #$&unk16_022267
    CMP #$46
    BEQ loc_022230
    LDY #$&unk16_022280
    CMP #$47
    BEQ loc_022230
    LDY #$&unk16_02223D
    CMP #$3E
    BEQ loc_022230
    LDY #$&unk16_022256
    CMP #$3F
    BEQ loc_022230
    BRA loc_022238

  loc_022230:
    STY $push_zone_list
    LDA #$^unk16_02223D
    STA $push_zone_bank

  loc_022238:
    REP #$20
    COP [86]
    RTL 
}
---------------------------------------------

unk16_02223D [
  unk16 < #1A, #1C, #0A, #11, #$0000, #$0001 >   ;00
  unk16 < #16, #18, #19, #27, #$0000, #$0001 >   ;01
  unk16 < #2B, #2D, #2F, #36, #$0000, #$0001 >   ;02
]

unk16_022256 [
  unk16 < #13, #15, #14, #1B, #$0000, #$0001 >   ;00
  unk16 < #1C, #1E, #0A, #11, #$0000, #$0001 >   ;01
]

unk16_022267 [
  unk16 < #02, #1E, #08, #11, #$0000, #$0001 >   ;00
  unk16 < #02, #1E, #2C, #42, #$0000, #$0001 >   ;01
  unk16 < #02, #1E, #4F, #59, #$0000, #$0001 >   ;02
]

unk16_022280 [
  unk16 < #2F, #3E, #21, #36, #$0000, #$0001 >
]