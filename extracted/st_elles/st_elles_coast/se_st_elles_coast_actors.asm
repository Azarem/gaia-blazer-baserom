?BANK 1F

?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!contact_lock                   042D

---------------------------------------------

code_0FA440 {
    COP [14] ( #$00A6, &code_0FA447 )
    RTL 
}

code_0FA447 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_0FA45B )
    SEP #$20
    LDA #$^w2_shared_0FA945.code_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.code_0FA945-1
    PHA 
    RTL 
}

code_0FA45B {
    COP [07] ( #$9D00, &code_0FA46D )
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 )
    COP [38] ( #$0200 )
    COP [09] ( #$9D00 )
}
---------------------------------------------

code_0FA46D {
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9F0 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_0FA48F )
    LDA $L_choice_result
    BEQ code_0FA48F
    COP [01] ( &w2_shared_0FA945.asciistring_0FAA15 )
    INC $contact_lock
    COP [10] ( #$0106, #00, #$01F8, #$0200 )
    RTL 
}

code_0FA48F {
    COP [01] ( &w2_shared_0FA945.asciistring_0FAA29 )
    RTL 
}
---------------------------------------------

code_0FA4F4 {
    COP [14] ( #$00B8, &code_0FA4FB )
    RTL 
}

code_0FA4FB {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_0FA50F )
    SEP #$20
    LDA #$^w2_shared_0FA945.code_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.code_0FA945-1
    PHA 
    RTL 
}

code_0FA50F {
    COP [01] ( &asciistring_0FA516 )
    BRL code_0FA46D
}

asciistring_0FA516 |[10]The monuments on this [N]island are lightning [N]pyramids- [FIN]If you wear the [N]Thunder Ring and touch[N]them, [FIN]the Master will send [N]down lightning to [N]destroy the monsters- [FIN][END]|
---------------------------------------------

code_0FA5BF {
    COP [07] ( #$8503, &code_0FA5D3 )
    LDA #$0047
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCS loc_0FA5CF
    RTL 

  loc_0FA5CF:
    COP [39] ( #04 )
    RTL 
}

code_0FA5D3 {
    COP [86]
    RTL 
}
---------------------------------------------

code_0FA5D6 {
    COP [07] ( #$8503, &code_0FA5F7 )
    COP [B0] ( @code_0FA5FA, #$2240 )

  code_0FA5E3:
    COP [92] ( #19 )
    COP [94]
    COP [07] ( #$0503, &code_0FA5E3 )
    COP [05] ( #$0001 )
    COP [92] ( #39 )
    COP [94]
}

code_0FA5F7 {
    COP [86]
    RTL 
}

code_0FA5FA {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [91]
    COP [0D] ( #00, #1F, #21, &code_0FA60D )

  code_0FA60C:
    RTL 
}

code_0FA60D {
    COP [19] ( #21, &code_0FA60C )
    COP [09] ( #$8503 )
    COP [0B] ( #21 )
    COP [01] ( &asciistring_0FA626 )
    BRK #$86
    COP [09] ( #$8001 )
    COP [86]
    RTL 
}

asciistring_0FA626 |[10][02:2] poured [N]out the mermaid s [N]tears- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0FA7A1 {
    LDA $0000, X
    CLC 
    ADC #$0002
    CLC 
    ADC $scroll_delta_x
    STA $0000, X
    STA $scroll_bg2_x
    LDA $0002, X
    SEC 
    SBC #$0006
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}