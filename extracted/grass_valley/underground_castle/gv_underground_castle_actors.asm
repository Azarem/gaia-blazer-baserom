?BANK 03

?INCLUDE 'data_engine_tables'
?INCLUDE 'gv_watching_over_world_texts'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!frame_counter                  0312
!scene_variant                  031E
!joy_pressed                    0322
!joy_block_mask                 0326
!player_actor                   039C
!player_weapon_actor            039E
!contact_lock                   042D

---------------------------------------------

code_01A440 {
    COP [14] ( #$0010, &code_01A447 )
    RTL 
}

code_01A447 {
    COP [07] ( #$9F02, &code_01A491 )
    COP [17] ( &code_01A4DF )
    COP [15]
    COP [91]
    COP [14] ( #$0032, &code_01A45C )
    RTL 
}

code_01A45C {
    COP [01] ( &asciistring_01A521 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #21, #02 )
    COP [83]
    COP [80] ( #22 )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [01] ( &asciistring_01A59F )
    COP [17] ( &code_01A4E4 )
    COP [91]
    COP [0D] ( #00, #12, #35, &code_01A489 )
    RTL 
}

code_01A489 {
    COP [80] ( #1F )
    COP [82]
    COP [91]
    RTL 
}

code_01A491 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [9F] ( #$0018 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_01A604 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesOnlyText, #01, &code_01A4B1 )
}

code_01A4B1 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [01] ( &asciistring_01A77E )
    COP [03] ( #B5 )
    COP [04]
    COP [09] ( #$9F01 )
    LDA #$0003
    STA $scene_variant
    COP [3C] ( #04 )
    COP [10] ( #$0101, #01, #$03B0, #$01D8 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_01A4DF {
    COP [01] ( &asciistring_01A50A )
    RTL 
}

code_01A4E4 {
    COP [01] ( &asciistring_01A5E9 )
    COP [09] ( #$8104 )
    COP [3C] ( #04 )
    COP [10] ( #$0101, #03, #$03B0, #$01E0 )
    RTL 
}
---------------------------------------------

asciistring_01A50A |[10]Daddy, where are you?![JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A521 |[10]A voice, full of [N]sadness, came from [N]somewhere- [FIN]"Lisa, you must tell [N]everything that you [N]know to the person in [N]front of you- [FIN]They will also need my[N]paintbrush to continue[N]on-ˮ [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A59F |[10]Daddy! Is that you? [FIN]Where are you daddy?! [N]I miss you so [N]much----- [FIN][0F]There was no answer- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A5E9 |[10]Who are you? [N]Why am I here? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A604 |[10][0F][02:2], [N][0E:3C]I thought I would meet[N]you here- [N][0E:78]I am all alone- [N][0E:1E]I know that as time [N]passes I will stop [N]feeling lonely- [N][0E:5A]My father used to tell[N]me the key to [N]happiness lies in [N]patience not in haste-[N][0E:5A]I don t know whether [N]you are an angel or [N]human, but I must ask [N]you to do me a favor- [N][0E:5A]I will not ask you to [N]stay with me, [N][0E:5A]only promise me you [N]will return someday- [N][0E:5A]You could tell me a [N]lie, [0E:1E]but I feel our [N]promise will give me [N]hope for the future- [N][0E:5A]Please! [0E:28]Please promise[N]me that you will one [N]day return- [END]|

asciistring_01A77E |[0F]Thank you- [N][0E:5A]I wish this dream [N]would never end- [0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|
---------------------------------------------

code_01AC32 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01AD09 )

  loc_01AC3A:
    COP [14] ( #$0004, &code_01AC47 )
    COP [80] ( #07 )
    COP [82]
    BRA loc_01AC3A
}

code_01AC47 {
    COP [07] ( #$8505, &code_01AC5E )
    COP [09] ( #$8505 )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_01AC73 )
}

code_01AC5E {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

asciistring_01AC73 |[10][02:2] heard a [N]faint voice coming [N]from the jewel in the [N]< corner- [FIN]Allright, come over [N]here- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01ACBA |[10]I will give you some [N]advice- [FIN]Don t forget to equip [N]the things that you [N]wish to use or they [N]will not work- [FIN][JMP:&gv_watching_over_world_texts.asciistring_01ABB9+M]|

code_01AD09 {
    COP [07] ( #$9C02, &code_01AD1B )
    COP [01] ( &asciistring_01ACBA )
    COP [38] ( #$0030 )
    COP [09] ( #$9C02 )
}
---------------------------------------------

code_01AD1B {
    COP [01] ( &asciistring_01B2D2 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_01AD3D )
    LDA $L_choice_result
    BEQ code_01AD3D
    COP [01] ( &asciistring_01B2F5 )
    INC $contact_lock
    COP [10] ( #$0101, #00, #$0138, #$03A0 )
    RTL 
}

code_01AD3D {
    COP [01] ( &asciistring_01B30E )
    RTL 
}
---------------------------------------------

code_01ADF8 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01AE0C )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01AE0C {
    COP [01] ( &asciistring_01AE13 )
    BRL code_01AD1B
}

asciistring_01AE13 |[10]This is the heart [N]of the Underground [N]Castle- [FIN]You may meet many [N]monsters that cannot [N]be defeated with that [N]sword- [FIN]You will be able to [N]save those creatures [N]once you return with [N]the correct sword- [FIN][END]|
---------------------------------------------

code_01AE99 {
    COP [A0] ( #$0002 )

  loc_01AE9D:
    COP [91]
    COP [07] ( #$8404, &code_01AEAD )
    COP [0D] ( #00, #47, #38, &code_01AEFA )
    RTL 
}

code_01AEAD {
    LDY $player_actor
    LDA $0000, Y
    CMP #$04B0
    BCC code_01AEC0
    COP [A0] ( #$FFB0 )
    COP [27] ( &code_01AEDD )

  code_01AEC0:
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AECA )
    RTL 
}

code_01AECA {
    LDA $joy_pressed
    AND #$0800
    BNE loc_01AED3
    RTL 

  loc_01AED3:
    COP [81] ( #2A, #14 )
    COP [83]
    COP [27] ( &code_01AEDD )
}

code_01AEDD {
    COP [91]
    COP [0D] ( #00, #47, #33, &code_01AEE7 )
    RTL 
}

code_01AEE7 {
    LDA $joy_pressed
    AND #$0400
    BNE loc_01AEF0
    RTL 

  loc_01AEF0:
    COP [81] ( #2C, #14 )
    COP [83]
    COP [27] ( &code_01AEC0 )
}

code_01AEFA {
    COP [01] ( &asciistring_01AF0A )
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AF09 )
    BRA loc_01AE9D
}

code_01AF09 {
    RTL 
}

asciistring_01AF0A |[10]I am an elevator [N]invented by Dr-Leo- [FIN]I cannot move unless [N]the water mill is [N]turning- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01AF5C {
    COP [A4]
    COP [05] ( #$0404 )
    LDY $player_actor
    LDA $0000, Y
    CMP #$04B0
    BCC code_01AF75
    COP [A0] ( #$FFB0 )
    COP [27] ( &code_01AF97 )

  code_01AF75:
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AF7F )
    RTL 
}

code_01AF7F {
    LDA $joy_pressed
    AND #$0800
    BNE loc_01AF88
    RTL 

  loc_01AF88:
    COP [85] ( @code_01AFB9 )
    COP [81] ( #2B, #14 )
    COP [83]
    COP [27] ( &code_01AF97 )
}

code_01AF97 {
    COP [91]
    COP [0D] ( #00, #47, #33, &code_01AFA1 )
    RTL 
}

code_01AFA1 {
    LDA $joy_pressed
    AND #$0400
    BNE loc_01AFAA
    RTL 

  loc_01AFAA:
    COP [85] ( @code_01AFB9 )
    COP [81] ( #2D, #14 )
    COP [83]
    COP [27] ( &code_01AF75 )
}

code_01AFB9 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #51 )
    LDY $003C, X
    LDA $0002, Y
    LDY $player_actor
    STA $0002, Y
    LDY $player_weapon_actor
    STA $0002, Y
    PHX 
    LDX $player_actor
    LDA $001E, X
    ASL 
    TAX 
    LDA $&data_engine_tables.WeaponYOffsetByAnim, X
    CLC 
    ADC $0002, Y
    STA $0002, Y
    PLX 
    LDA $frame_counter
    AND #$0003
    BNE loc_01AFF2
    BRK #$63

  loc_01AFF2:
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

code_01B23D {
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^binary_01B24E
    LDY #$&binary_01B24E
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLP 
    RTL 
}
---------------------------------------------

binary_01B24E #7FE020E004E104E204E304E404E504E604E704E804E904EA04EB04EC04ED04EE04EF04F000
---------------------------------------------

asciistring_01B2AB |[10]I am watching over the[N]world- [N]Please take this- [FIN][02:2]  received [N]EXP! [FIN][END]|

asciistring_01B2D2 |[10]Would you like to [N]return to Grass [N]Valley? [END]|

asciistring_01B2F5 |Allright, please [N]continue- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01B30E |Come back [N]whenever you feel like[N]returning [N]to Grass Valley- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|