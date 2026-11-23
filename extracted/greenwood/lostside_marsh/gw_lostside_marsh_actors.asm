?BANK 03

?INCLUDE 'gw_watching_over_world_return_prompt_texts'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_y                   033C
!scroll_bg2_y                   0340
!scroll_delta_y                 0384
!player_actor                   039C
!contact_lock                   042D

---------------------------------------------

code_01E47B {
    COP [91]
    COP [0D] ( #00, #0F, #15, &code_01E485 )
    RTL 
}

code_01E485 {
    COP [07] ( #$0906, &code_01E48E )
    COP [86]
    RTL 
}

code_01E48E {
    COP [01] ( &asciistring_01E49E )
    BRK #$5E
    COP [0A] ( #39 )
    COP [09] ( #$8906 )
    COP [86]
    RTL 
}

asciistring_01E49E |[10][02:2] found [N][03:24]a Strange Bottle[03:20]-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E4C3 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01E4D7 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01E4D7 {
    COP [07] ( #$9C05, &code_01E4E9 )
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBC2 )
    COP [38] ( #$0150 )
    COP [09] ( #$9C05 )
}
---------------------------------------------

code_01E4E9 {
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBEA )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_01E50B )
    LDA $L_choice_result
    BEQ code_01E50B
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EC09 )
    INC $contact_lock
    COP [10] ( #$0104, #02, #$02E0, #$01A0 )
    RTL 
}

code_01E50B {
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EC1B )
    RTL 
}
---------------------------------------------

code_01E510 {
    COP [14] ( #$0048, &code_01E517 )
    RTL 
}

code_01E517 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01E52B )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01E52B {
    COP [07] ( #$9C06, &code_01E4E9 )
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBC2 )
    COP [38] ( #$0180 )
    COP [09] ( #$9C06 )
    BRL code_01E4E9
}
---------------------------------------------

code_01E540 {
    COP [14] ( #$005E, &code_01E547 )
    RTL 
}

code_01E547 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01E55B )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01E55B {
    COP [07] ( #$9C07, &code_01E4E9 )
    COP [01] ( &asciistring_01E571 )
    BRK #$5E
    COP [0A] ( #12 )
    COP [09] ( #$9C07 )
    BRL code_01E4E9
}

asciistring_01E571 |[10]Here, take this [N][03:24]Light Arrow Magic- [03:20][FIN][END]|
---------------------------------------------

code_01E594 {
    COP [14] ( #$0053, &code_01E59B )
    RTL 
}

code_01E59B {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01E5AF )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01E5AF {
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBC2 )
    COP [38] ( #$0001 )
    BRL code_01E4E9
}
---------------------------------------------

code_01E5BA {
    LDY $player_actor
    LDA $0002, Y
    CMP #$0060
    BCC loc_01E5F5
    COP [0D] ( #00, #1C, #20, &code_01E5D5 )
    COP [0D] ( #00, #03, #19, &code_01E5DF )
    BRA loc_01E627
}

code_01E5D5 {
    COP [11] ( #16, #17, #19 )
    COP [12] ( #16, &code_01E854 )
}

code_01E5DF {
    COP [11] ( #14, #0F, #14 )
    COP [12] ( #14, &code_01E7D8 )
    COP [11] ( #15, #06, #10 )
    COP [12] ( #15, &code_01E8F0 )
    BRA loc_01E627

  loc_01E5F5:
    COP [11] ( #14, #0F, #08 )
    COP [12] ( #14, &code_01E8F0 )
    COP [11] ( #15, #1C, #0D )
    COP [12] ( #15, &code_01E7D8 )
    COP [11] ( #16, #17, #19 )
    COP [12] ( #16, &code_01E854 )
    COP [11] ( #17, #06, #10 )
    COP [12] ( #17, &code_01E8F0 )
    COP [11] ( #18, #0F, #14 )
    COP [12] ( #18, &code_01E7D8 )

  loc_01E627:
    COP [86]
    RTL 
}
---------------------------------------------

code_01E62A {
    COP [07] ( #$8401, &code_01E682 )
    COP [91]
    COP [0C] ( #00, #01, &code_01E639 )
    RTL 
}

code_01E639 {
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0010, #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #1A, #02 )
    COP [83]
    COP [1B] ( &code_01E657, #$001E )
}

code_01E657 {
    COP [81] ( #30, #02 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [18] ( #1E, &code_01E686 )
    COP [01] ( &asciistring_01E712 )
    COP [81] ( #19, #02 )
    COP [83]
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0010, #$0000 )
    COP [09] ( #$8401 )
}

code_01E682 {
    COP [27] ( &code_01E75C )
}

code_01E686 {
    COP [01] ( &asciistring_01E68D )
    COP [91]
    RTL 
}

asciistring_01E68D |[10][02:2] began to [N]hear a small voice- [FIN]We are rafts made from[N]the branches of trees [N]in GreenWood- [FIN]If you cannot prove [N]that you are from [N]GreenWood, we will not[N]let you ride- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E712 |[10]Those are leaves from [N]GreenWood! [N]Turbo s symbol! [FIN]We will take you to [N]the Light Shrine- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01E759 {
    COP [AD] ( #08 )
}
---------------------------------------------

code_01E75C {
    COP [A4]
    COP [2A] ( #$FFF0, #$0000 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0010, #$0000 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E77B )
    BRL loc_01E77C
}

code_01E77B {
    RTL 

  loc_01E77C:
    COP [91]
    COP [0C] ( #00, #00, &code_01E785 )
    RTL 
}

code_01E785 {
    COP [85] ( @code_01E7AD )
    COP [2B] ( #$FFF0, #$0000 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0010, #$0000 )

  code_01E79C:
    COP [80] ( #1A )
    COP [82]
    COP [23] ( &code_01E79C )
    COP [09] ( #$8000 )
    COP [27] ( &code_01E7D5 )
}

code_01E7AD {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0000, #$FFFE )
    COP [07] ( #$8000, &code_01E7C2 )
    RTL 
}

code_01E7C2 {
    COP [2F] ( #$0000, #$FFFE )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

code_01E7D5 {
    COP [AD] ( #08 )
}
---------------------------------------------

code_01E7D8 {
    COP [A4]
    COP [2A] ( #$FFF0, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E7F7 )
    BRL loc_01E7F8
}

code_01E7F7 {
    RTL 

  loc_01E7F8:
    COP [91]
    COP [0C] ( #00, #00, &code_01E801 )
    RTL 
}

code_01E801 {
    COP [85] ( @code_01E829 )
    COP [2B] ( #$FFF0, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )
    COP [2A] ( #$0010, #$FFF0 )

  code_01E818:
    COP [80] ( #19 )
    COP [82]
    COP [23] ( &code_01E818 )
    COP [09] ( #$8000 )
    COP [27] ( &code_01E759 )
}

code_01E829 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0000, #$0002 )
    COP [07] ( #$8000, &code_01E83E )
    RTL 
}

code_01E83E {
    COP [2F] ( #$0000, #$0002 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

code_01E851 {
    COP [AD] ( #08 )
}
---------------------------------------------

code_01E854 {
    COP [A4]
    COP [2A] ( #$0000, #$0010 )
    COP [2B] ( #$0010, #$0000 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E87F )
    BRL loc_01E880
}

code_01E87F {
    RTL 

  loc_01E880:
    COP [91]
    COP [0C] ( #00, #00, &code_01E889 )
    RTL 
}

code_01E889 {
    COP [85] ( @code_01E8C5 )
    COP [2B] ( #$0000, #$0010 )
    COP [2A] ( #$0010, #$0000 )
    COP [2A] ( #$0010, #$FFF0 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )

  code_01E8AC:
    COP [80] ( #1B )
    COP [82]
    COP [22] ( &code_01E8AC )
    COP [09] ( #$8000 )
    COP [23] ( &code_01E8C1 )
    COP [27] ( &code_01E8ED )
}

code_01E8C1 {
    COP [27] ( &code_01E851 )
}

code_01E8C5 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$FFFE, #$0000 )
    COP [07] ( #$8000, &code_01E8DA )
    RTL 
}

code_01E8DA {
    COP [2F] ( #$FFFE, #$0000 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

code_01E8ED {
    COP [AD] ( #08 )
}
---------------------------------------------

code_01E8F0 {
    COP [A4]
    COP [87]
    COP [2A] ( #$0000, #$0010 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [2B] ( #$0010, #$0000 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E91D )
    BRL loc_01E91E
}

code_01E91D {
    RTL 

  loc_01E91E:
    COP [91]
    COP [0C] ( #00, #00, &code_01E927 )
    RTL 
}

code_01E927 {
    COP [85] ( @code_01E965 )
    COP [2B] ( #$0000, #$0010 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )
    COP [2A] ( #$0010, #$0000 )
    COP [2A] ( #$0010, #$FFF0 )

  code_01E94A:
    COP [80] ( #1B )
    COP [82]
    COP [22] ( &code_01E94A )
    COP [09] ( #$8000 )
    COP [87]
    COP [24] ( &code_01E961 )
    COP [27] ( &code_01E851 )
}

code_01E961 {
    COP [27] ( &code_01E8ED )
}

code_01E965 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0002, #$0000 )
    COP [07] ( #$8000, &code_01E97A )
    RTL 
}

code_01E97A {
    COP [2F] ( #$0002, #$0000 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

code_01E98D {
    COP [92] ( #3B )
    COP [94]
    COP [B0] ( @code_01E9A6, #$2040 )
    COP [1B] ( &code_01E99F, #$00F0 )
}

code_01E99F {
    COP [92] ( #3D )
    COP [94]
    BRA code_01E98D
}

code_01E9A6 {
    COP [03] ( #F0 )
    COP [19] ( #0A, &code_01E9B0 )
    BRA loc_01E9BC
}

code_01E9B0 {
    LDA #$0080
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCC loc_01E9BC
    COP [39] ( #01 )

  loc_01E9BC:
    COP [04]
    COP [86]
    RTL 
}
---------------------------------------------

code_01E9C1 {
    LDA $0002, X
    SEC 
    SBC #$0001
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}
---------------------------------------------

code_01EAFB {
    PHX 
    LDX #$0000

  loc_01EAFF:
    LDA #$0090
    STA $7E7000, X
    STA $7E7800, X
    LDA #$7100
    STA $7E7001, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$002A
    BNE loc_01EAFF
    LDA #$0000
    STA $7E7000, X
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    LDA $frame_counter
    LSR 
    CLC 
    ADC $scroll_bg1_y
    AND #$000F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 

  loc_01EB46:
    LDA $@word_01EB82, X
    CLC 
    ADC $033A
    STA $7100, Y
    LDA $@word_01EB82, X
    CLC 
    ADC $033C
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0020
    BNE loc_01EB46
    PLB 
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaIndirect
    LDA #$10
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_01EB82 [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0000   ;03
  #$0001   ;04
  #$0001   ;05
  #$0001   ;06
  #$0001   ;07
  #$0000   ;08
  #$0000   ;09
  #$0000   ;0A
  #$0000   ;0B
  #$FFFF   ;0C
  #$FFFF   ;0D
  #$FFFF   ;0E
  #$FFFF   ;0F
  #$0000   ;10
  #$0000   ;11
  #$0000   ;12
  #$0000   ;13
  #$0001   ;14
  #$0001   ;15
  #$0001   ;16
  #$0001   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$FFFF   ;1C
  #$FFFF   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
]