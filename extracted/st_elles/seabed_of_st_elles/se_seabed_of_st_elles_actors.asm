?BANK 1F

?INCLUDE 'engine_scheduler_sprites_combat_collision'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'se_st_elles_coast_actors'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'w2_shared_0FA945'

!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!player_x                       0374
!player_y                       0376
!push_zone_list                 03D8
!push_zone_bank                 03DA
!return_active                  03FB

---------------------------------------------

code_0F9AFD {
    COP [14] ( #$00BB, &code_0F9B04 )
    RTL 
}

code_0F9B04 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_0F9B17 )

  loc_0F9B0F:
    COP [80] ( #11 )
    COP [82]
    BRL loc_0F9B0F
}

code_0F9B17 {
    COP [07] ( #$8506, &code_0F9B38 )
    COP [19] ( #1C, &code_0F9B33 )
    COP [01] ( &asciistring_0F9B47 )
    COP [3C] ( #04 )
    COP [10] ( #$0407, #00, #$0050, #$0200 )
    RTL 
}

code_0F9B33 {
    COP [01] ( &asciistring_0F9B3D )
    RTL 
}

code_0F9B38 {
    COP [01] ( &asciistring_0F9B69 )
    RTL 
}

asciistring_0F9B3D |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B47 |[10][02:2] touches [N]the dolphin with the [N]Dream Rod- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B69 |[10]Hey, didn t I meet you[N]in my dream? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F9B8B {
    COP [14] ( #$008F, &code_0F9B92 )
    RTL 
}

code_0F9B92 {
    COP [30] ( #$008F, &code_0F9BED, #1F )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9BB5 )

  loc_0F9BA2:
    COP [96]
    COP [81] ( #0E, #04 )
    COP [83]
    COP [97]
    COP [81] ( #0E, #04 )
    COP [83]
    BRL loc_0F9BA2
}

code_0F9BB5 {
    COP [18] ( #24, &code_0F9BD1 )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F9D86 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_0F9BD1 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F9C12 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRK #$5E
    COP [0A] ( #24 )
    RTL 
}

code_0F9BED {
    COP [14] ( #$008C, &code_0F9BF7 )
    COP [01] ( &asciistring_0F9BFA )
}

code_0F9BF7 {
    COP [86]
    RTL 
}

asciistring_0F9BFA |[10][0E:3C]Hey, somebody help me![JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9C12 |[10]My name is Lue- [N]I used to live with [N]the inventor, Dr-Leo-[FIN]The Blue Stone I [N]received from him is [N]a strange jewel- [FIN]It attracts anyone who[N]looks at it and then [N]changes their [N]personality- [FIN]If that person has a [N]good mind, they will [N]become a great person-[FIN]If they have a evil [N]mind, they will become[N]a bad person- [FIN]One day, the Queen [N]found the jewel and [N]took it- Then she [N]placed me in prison- [FIN]Please save the Queen [N]and get the Blue Stone[N]back- [FIN]I know this ring will [N]help please take it- [FIN][02:2] received [N][03:24]the Thunder Ring- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9D86 |[10]I heard that Dr-Leo [N]was taken to the [N]Magridd Castle- [N]I wonder how he is- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F9DBE {
    COP [14] ( #$008C, &code_0F9DC5 )
    RTL 
}

code_0F9DC5 {
    COP [30] ( #$008C, &code_0F9E32, #1F )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [1B] ( &code_0F9DD7, #$0002 )
}

code_0F9DD7 {
    COP [07] ( #$0000, &code_0F9E0D )
    LDA #$FFFF
    STA $return_active
    COP [09] ( #$8601 )
    COP [81] ( #0E, #09 )
    COP [83]
    COP [81] ( #0C, #03 )
    COP [83]
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    STZ $return_active

  loc_0F9E04:
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    BRA loc_0F9E04
}

code_0F9E0D {
    COP [11] ( #04, #12, #0B )
    COP [97]
    COP [15]
    COP [17] ( &code_0F9E22 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F9E22 {
    COP [14] ( #$008F, &code_0F9E2D )
    COP [01] ( &asciistring_0F9E55 )
    RTL 
}

code_0F9E2D {
    COP [01] ( &asciistring_0F9E7D )
    RTL 
}

code_0F9E32 {
    COP [09] ( #$8000 )
    COP [01] ( &asciistring_0F9E3D )
    COP [86]
    RTL 
}

asciistring_0F9E3D |[10][0E:1E]Lue! I m coming! [0E:28][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F9E55 |[10]I tried hard to save [N]Lue but he is not [N]here- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9E7D |[10]Lue told me many [N]things about the [N]Queen- [FIN]I don t think she was [N]a bad person- She was [N]just attracted to the [N]jewel- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F9ED4 {
    COP [07] ( #$8406, &code_0F9EE6 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #5B, #24, &code_0F9EF0 )
    RTL 
}

code_0F9EE6 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9EF0 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9EFE, #$0078 )
}

code_0F9EFE {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9F12, #$005A )
}

code_0F9F12 {
    COP [09] ( #$8406 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$0220, #$0220 )
    RTL 
}
---------------------------------------------

code_0F9F24 {
    COP [07] ( #$8407, &code_0F9F36 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #6A, #04, &code_0F9F40 )
    RTL 
}

code_0F9F36 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9F40 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9F4E, #$0078 )
}

code_0F9F4E {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9F62, #$005A )
}

code_0F9F62 {
    COP [09] ( #$8407 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$0220, #$01C0 )
    RTL 
}
---------------------------------------------

code_0F9F74 {
    COP [07] ( #$8500, &code_0F9F86 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #24, #2B, &code_0F9F90 )
    RTL 
}

code_0F9F86 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9F90 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9F9E, #$0078 )
}

code_0F9F9E {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9FB2, #$005A )
}

code_0F9FB2 {
    COP [09] ( #$8500 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$01C0, #$0220 )
    RTL 
}
---------------------------------------------

code_0F9FC4 {
    COP [07] ( #$8501, &code_0F9FD6 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #14, #04, &code_0F9FE0 )
    RTL 
}

code_0F9FD6 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9FE0 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9FEE, #$0078 )
}

code_0F9FEE {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0FA002, #$005A )
}

code_0FA002 {
    COP [09] ( #$8501 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$01C0, #$01C0 )
    RTL 
}
---------------------------------------------

code_0FA106 {
    COP [17] ( &code_0FA159 )
    COP [15]

  code_0FA10C:
    COP [80] ( #10 )
    COP [82]
    COP [07] ( #$0506, &code_0FA10C )
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #0D, #04 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]

  loc_0FA12D:
    COP [14] ( #$0079, &code_0FA13A )
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FA12D
}

code_0FA13A {
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #10, #02 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$0307, #02, #$0040, #$0080 )
    RTL 
}

code_0FA159 {
    COP [19] ( #20, &code_0FA16E )
    COP [01] ( &asciistring_0FA1E9 )
    COP [0B] ( #20 )
    COP [17] ( &code_0FA17F )
    COP [09] ( #$8506 )
    RTL 
}

code_0FA16E {
    COP [01] ( &asciistring_0FA184 )
    COP [3C] ( #04 )
    COP [10] ( #$0307, #00, #$0040, #$0070 )
    RTL 
}

code_0FA17F {
    COP [01] ( &asciistring_0FA237 )
    RTL 
}

asciistring_0FA184 |[10]I used to live [N]here- [FIN]I am trying to [N]remember something but[N]I cannot- [FIN]When I close my eyes, [N]I see something like [N]a ball, shiny and [N]black---- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA1E9 |[10]That Pearl! [FIN]Yes, I was going to [N]present that Pearl- [FIN][::]This is the Coral [N]Reef- I have missed [N]this place- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA237 |[10][JMP:&asciistring_0FA1E9+M]|
---------------------------------------------

code_0FA494 {
    COP [14] ( #$007F, &code_0FA49B )
    RTL 
}

code_0FA49B {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_0FA4AF )
    SEP #$20
    LDA #$^w2_shared_0FA945.code_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.code_0FA945-1
    PHA 
    RTL 
}

code_0FA4AF {
    COP [07] ( #$9D06, &se_st_elles_coast_actors.code_0FA46D )
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D06 )
    BRL se_st_elles_coast_actors.code_0FA46D
}
---------------------------------------------

code_0FA4C4 {
    COP [14] ( #$007A, &code_0FA4CB )
    RTL 
}

code_0FA4CB {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_0FA4DF )
    SEP #$20
    LDA #$^w2_shared_0FA945.code_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.code_0FA945-1
    PHA 
    RTL 
}

code_0FA4DF {
    COP [07] ( #$9D07, &se_st_elles_coast_actors.code_0FA46D )
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 )
    COP [38] ( #$0250 )
    COP [09] ( #$9D07 )
    BRL se_st_elles_coast_actors.code_0FA46D
}
---------------------------------------------

code_0FA59C {
    SEP #$20
    LDY #$&unk16_0FA5AE
    STY $push_zone_list
    LDA #$^unk16_0FA5AE
    STA $push_zone_bank
    REP #$20
    COP [86]
    RTL 
}
---------------------------------------------

unk16_0FA5AE [
  unk16 < #32, #7B, #0B, #16, #$FFFC, #$0000 >   ;00
  unk16 < #7B, #7D, #0E, #16, #$FFFC, #$0000 >   ;01
]
---------------------------------------------

code_0FA64B {
    COP [91]
    COP [07] ( #$8903, &code_0FA6A6 )
    COP [19] ( #0B, &code_0FA697 )
    COP [B0] ( @code_0FA6A9, #$0310 )
    COP [91]
    COP [19] ( #0B, &code_0FA68A )
    LDY $003E, X
    LDA $player_x
    STA $0000, Y
    LDA $player_y
    SEC 
    SBC #$0004
    STA $0002, Y
    LDA $frame_counter
    AND #$00FF
    BEQ loc_0FA682
    RTL 

  loc_0FA682:
    COP [AF] ( @code_0FA6CB, #$2040 )
    RTL 
}

code_0FA68A {
    LDY $003E, X
    LDA #$0000
    STA $0014, Y
    COP [27] ( &code_0FA64B )
}

code_0FA697 {
    LDA $frame_counter
    AND #$003F
    BNE loc_0FA6A2
    COP [39] ( #01 )

  loc_0FA6A2:
    COP [27] ( &code_0FA64B )
}

code_0FA6A6 {
    COP [91]
    RTL 
}

code_0FA6A9 {
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0024
    STA $001E, X
    STZ $0020, X
    JSL $@engine_scheduler_sprites_combat_collision.SetActorAnimFrame
    COP [A3]
    COP [91]

  loc_0FA6BF:
    COP [19] ( #0B, &code_0FA6C8 )
    COP [82]
    BRA loc_0FA6BF
}

code_0FA6C8 {
    COP [86]
    RTL 
}

code_0FA6CB {
    COP [A3]
    COP [A2] ( #30 )
    LDA $player_x
    CLC 
    ADC #$0004
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0010
    STA $0002, X
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #22 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FA874 {
    PHX 
    LDX #$0000

  loc_0FA878:
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
    BNE loc_0FA878
    LDA #$0000
    STA $7E7000, X
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    LDA $scroll_bg1_x
    LSR 
    STA $16
    LDA $scroll_bg1_y
    LSR 
    STA $18
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $18
    AND #$000F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 

  loc_0FA8CB:
    LDA $@word_0FA905, X
    CLC 
    ADC $16
    STA $7100, Y
    LDA $@word_0FA905, X
    CLC 
    ADC $18
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0020
    BNE loc_0FA8CB
    PLB 
    LDA #$0D
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaIndirect
    LDA #$0E
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_0FA905 [
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