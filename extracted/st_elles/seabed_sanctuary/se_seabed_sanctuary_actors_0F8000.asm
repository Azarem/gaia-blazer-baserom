?BANK 1F

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'shared_choice_prompt_texts'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0
!joy_block_mask                 0326
!asset_skip_mask                03B4
!souls_flags                    1B82
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_0F8000 {
    COP [3B] ( #$007C, &code_0F8016 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F8016 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_0F8029 )

  loc_0F8021:
    COP [80] ( #11 )
    COP [82]
    BRL loc_0F8021
}

code_0F8029 {
    COP [07] ( #$8704, &code_0F804A )
    COP [19] ( #1C, &code_0F8045 )
    COP [01] ( &asciistring_0F8059 )
    COP [3C] ( #04 )
    COP [10] ( #$0209, #01, #$0078, #$0410 )
    RTL 
}

code_0F8045 {
    COP [01] ( &asciistring_0F804F )
    RTL 
}

code_0F804A {
    COP [01] ( &asciistring_0F8080 )
    RTL 
}

asciistring_0F804F |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8059 |[10][02:2] placed [N]the Dream Rod on [N]the dolphin s nose- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8080 |[10]I always have the same[N]dream- Isn t that [N]strange! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F80A4 {
    COP [14] ( #$00B1, &code_0F80AB )
    RTL 
}

code_0F80AB {
    COP [30] ( #$00B1, &code_0F8108, #1F )
    COP [07] ( #$8701, &code_0F80D4 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F80DC )

  loc_0F80C1:
    COP [81] ( #14, #02 )
    COP [83]
    COP [87]
    COP [81] ( #13, #02 )
    COP [83]
    COP [87]
    BRL loc_0F80C1
}

code_0F80D4 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [86]
    RTL 
}

code_0F80DC {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F814A )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    SEP #$20
    LDA $souls_flags
    ORA #$04
    STA $souls_flags
    REP #$20
    COP [09] ( #$8701 )
    BRK #$4E
    COP [27] ( &code_0F80D4 )
}

code_0F8108 {
    COP [01] ( &asciistring_0F810F )
    COP [86]
    RTL 
}

asciistring_0F810F |[10][0E:3C]I have the power to [N]stop the Magma Rain- [N]I will help you if you[N]return to me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F814A |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]I will protect you [N]from the Magma- [FIN]Please try and protect[N]all creatures- [FIN]Let s work together so[N]we may revive the [N]world! [FIN]The creature that [N]enables you to avoid [N]Magma has joined you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8209 {
    COP [3B] ( #$0083, &code_0F821F )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F821F {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F826B )
    COP [80] ( #12 )
    COP [82]

  loc_0F822D:
    COP [A3]
    COP [84] ( @code_0F824F )
    COP [80] ( #1F )
    COP [82]
    COP [84] ( @code_0F824F )
    COP [A6]
    COP [17] ( &code_0F8266 )
    COP [81] ( #12, #02 )
    COP [83]
    COP [87]
    BRL loc_0F822D
}

code_0F824F {
    LDA #$0310
    STA $0016, X
    LDA #$002A
    STA $001E, X
    STZ $0020, X
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}

code_0F8266 {
    COP [01] ( &asciistring_0F8270 )
    RTL 
}

code_0F826B {
    COP [01] ( &asciistring_0F82A8 )
    RTL 
}

asciistring_0F8270 |[10]I didn t know the [N]world under water [N]looked different from [N]the world above- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F82A8 |[10]Please don t talk to [N]me while I m jumping, [N]I will not be able to [N]breathe- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F82DD {
    COP [14] ( #$0084, &code_0F82E4 )
    RTL 
}

code_0F82E4 {
    COP [17] ( &code_0F82F2 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F82F2 {
    COP [01] ( &asciistring_0F831C )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0F8317 )
    LDA $L_choice_result
    BNE code_0F8317
    COP [18] ( #38, &code_0F830D )
    COP [01] ( &asciistring_0F836C )
    RTL 
}

code_0F830D {
    COP [01] ( &asciistring_0F8355 )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

code_0F8317 {
    COP [01] ( &asciistring_0F8395 )
    RTL 
}

asciistring_0F831C |[10]Hello, I have some [N]Medical Herbs made [N]from seaweed- [N]Would you like one? [END]|

asciistring_0F8355 |[10]Come back to me [N]when you don t have [N]one- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F836C |[10]Medical herbs are [N]really rare- [N]I can t give you many-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8395 |[10]Come see me when you [N]need another- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F83AD {
    COP [14] ( #$0086, &code_0F83B4 )
    RTL 
}

code_0F83B4 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F841B )

  loc_0F83BD:
    COP [81] ( #13, #04 )
    COP [83]
    COP [07] ( #$8007, &code_0F83D6 )

  loc_0F83C9:
    COP [87]
    COP [81] ( #14, #04 )
    COP [83]
    COP [87]
    BRL loc_0F83BD
}

code_0F83D6 {
    COP [17] ( #$0000 )
    COP [03] ( #3D )
    COP [04]
    BRK #$56
    COP [A2] ( #30 )
    COP [A3]
    COP [84] ( @code_0F8404 )
    COP [80] ( #15 )
    COP [82]
    COP [84] ( @code_0F8404 )
    COP [A6]
    COP [A2] ( #20 )
    COP [09] ( #$0007 )
    COP [17] ( &code_0F841B )
    BRA loc_0F83C9
}

code_0F8404 {
    LDA #$0310
    STA $0016, X
    LDA #$002A
    STA $001E, X
    STZ $0020, X
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}

code_0F841B {
    COP [01] ( &asciistring_0F8424 )
    COP [09] ( #$8007 )
    RTL 
}

asciistring_0F8424 |[10]I am the best jumper! [N]I ll show you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8446 {
    COP [14] ( #$0099, &code_0F844D )
    RTL 
}

code_0F844D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [14] ( #$00C2, &code_0F845B )
    BRL loc_0F8474
}

code_0F845B {
    COP [14] ( #$00A5, &code_0F8464 )
    BRL loc_0F8474
}

code_0F8464 {
    COP [14] ( #$008B, &code_0F846D )
    BRL loc_0F8474
}

code_0F846D {
    COP [17] ( &code_0F8493 )
    BRL loc_0F8478

  loc_0F8474:
    COP [17] ( &code_0F848E )

  loc_0F8478:
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F8482 {
    COP [09] ( #$8003 )
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F848E {
    COP [01] ( &asciistring_0F849B )
    RTL 
}

code_0F8493 {
    COP [01] ( &asciistring_0F84F1 )
    COP [27] ( &code_0F8482 )
}

asciistring_0F849B |[10]Mermaids have to be [N]very good at dancing- [FIN]If three of my [N]students return, I [N]will show you our [N]great dance- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F84F1 |[10]Thank you very much- [N]Three of my students [N]came back- [FIN]I was going to show [N]you our dance-I think [N]it will be more fun if[N]you join us- [FIN]I will show you the [N]easiest dance, just [N]move like they do- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8577 {
    COP [3B] ( #$00C2, &code_0F858D )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F858D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F85B2 )
    COP [15]

  code_0F8598:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F8598 )
    COP [16]

  loc_0F85A5:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F85A5
}

code_0F85B2 {
    COP [01] ( &asciistring_0F85B7 )
    RTL 
}

asciistring_0F85B7 |[10]My name is Anna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F85E1 {
    COP [3B] ( #$00A5, &code_0F85F7 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F85F7 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F861C )
    COP [15]

  code_0F8602:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F8602 )
    COP [16]

  loc_0F860F:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F860F
}

code_0F861C {
    COP [07] ( #$8503, &code_0F8627 )
    COP [01] ( &asciistring_0F862C )
    RTL 
}

code_0F8627 {
    COP [01] ( &asciistring_0F86E3 )
    RTL 
}

asciistring_0F862C |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]As a reward for saving[N]us I will tell you a [N]secret- [FIN]No armor will protect [N]you against the Magma [N]off the volcanic [N]island, Durean- [FIN]You must find a way to[N]stop the volcano- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F86E3 |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]You have seized the [N]volcano, right? [N]You are a very brave [N]person- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F873E {
    COP [3B] ( #$008B, &code_0F8754 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F8754 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F8779 )
    COP [15]

  code_0F875F:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F875F )
    COP [16]

  loc_0F876C:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F876C
}

code_0F8779 {
    COP [01] ( &asciistring_0F877E )
    RTL 
}

asciistring_0F877E |[10]My name is Nanna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F87A9 {
    COP [14] ( #$008D, &code_0F87B0 )
    RTL 
}

code_0F87B0 {
    COP [30] ( #$008D, &code_0F87F9, #1F )
    COP [17] ( &code_0F87D5 )
    COP [91]
    COP [0D] ( #00, #22, #1C, &code_0F87C5 )
    RTL 
}

code_0F87C5 {
    COP [11] ( #00, #23, #1E )
    COP [33]
    LDA #$EF80
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F87D5 {
    COP [01] ( &asciistring_0F8800 )
    COP [07] ( #$8407, &code_0F87F8 )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$06A0, #$0040 )
}

code_0F87F8 {
    RTL 
}

code_0F87F9 {
    COP [01] ( &asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8800 |[10]I will open a passage [N]for you- [FIN]Travel up the seabed [N]to reach the island of[N]rain, Blester- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8850 {
    COP [14] ( #$00AD, &code_0F8857 )
    RTL 
}

code_0F8857 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F886A )

  loc_0F8860:
    COP [81] ( #12, #04 )
    COP [83]
    COP [87]
    BRA loc_0F8860
}

code_0F886A {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F8881 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

asciistring_0F8881 |[10][0A]If█you█travel[N]the█coral█reef█you[N]will█find█a█passage█to[N]a█small█creek-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F88CC {
    COP [3B] ( #$00BE, &code_0F88E2 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F88E2 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F88F5 )

  loc_0F88EB:
    COP [81] ( #12, #04 )
    COP [83]
    COP [87]
    BRA loc_0F88EB
}

code_0F88F5 {
    COP [01] ( &asciistring_0F88FA )
    RTL 
}

asciistring_0F88FA |[10]The coral reef [N]hides many dangerous [N]monsters- Make sure [N]to use magic there- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8941 {
    COP [14] ( #$0092, &code_0F8948 )
    RTL 
}

code_0F8948 {
    COP [07] ( #$9F02, &code_0F8984 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F8987 )
    COP [15]

  loc_0F8959:
    COP [14] ( #$00B6, &code_0F8967 )
    COP [80] ( #08 )
    COP [82]
    BRL loc_0F8959
}

code_0F8967 {
    COP [16]
    COP [81] ( #0A, #03 )
    COP [83]
    COP [96]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_0F898C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F8984 {
    COP [86]
    RTL 
}

code_0F8987 {
    COP [01] ( &asciistring_0F8991 )
    RTL 
}

code_0F898C {
    COP [01] ( &asciistring_0F89BB )
    RTL 
}

asciistring_0F8991 |[10]This used to be the [N]Queen s palace- I am [N]the Queen s maid- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F89BB |[10]I am glad you came [N]back- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F89CF {
    COP [14] ( #$0095, &code_0F89D6 )
    RTL 
}

code_0F89D6 {
    COP [17] ( &code_0F89E4 )
    COP [15]

  loc_0F89DC:
    COP [80] ( #06 )
    COP [82]
    BRL loc_0F89DC
}

code_0F89E4 {
    COP [01] ( &asciistring_0F89E9 )
    RTL 
}

asciistring_0F89E9 |[10]Servas is the name of [N]my friend the dolphin-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8A0E {
    COP [14] ( #$009B, &code_0F8A15 )
    RTL 
}

code_0F8A15 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_0F8A28 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F8A28 {
    COP [01] ( &asciistring_0F8A2D )
    RTL 
}

asciistring_0F8A2D |[10]There used to be [N]4 mermaid statues in [N]this place- [FIN]Those statues [N]prevented all [N]creatures from getting[N]lost- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8A7E {
    COP [14] ( #$009D, &code_0F8A85 )
    RTL 
}

code_0F8A85 {
    COP [30] ( #$009D, &code_0F8ACE, #1F )
    COP [17] ( &code_0F8AAA )
    COP [91]
    COP [0D] ( #00, #22, #22, &code_0F8A9A )
    RTL 
}

code_0F8A9A {
    COP [11] ( #00, #23, #24 )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F8AAA {
    COP [01] ( &asciistring_0F8AD5 )
    COP [07] ( #$8406, &code_0F8ACD )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$05B0, #$0240 )
}

code_0F8ACD {
    RTL 
}

code_0F8ACE {
    COP [01] ( &asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8AD5 |[10]I will open a passage [N]for you- [FIN]Proceed right along [N]the seabed to the [N]shore reef, Rockbird- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

asciistring_0F8B27 |[10][0E:3C][02:2] hears [N]a small voice- [FIN]I will open the [N]passage for you, [N]return to me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0F8B6A {
    COP [14] ( #$00A1, &code_0F8B71 )
    RTL 
}

code_0F8B71 {
    COP [30] ( #$00A1, &code_0F8BB5, #1F )
    COP [B0] ( @code_0F8C9A, #$2000 )
    COP [17] ( &code_0F8B8D )
    COP [15]
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F8B8D {
    COP [07] ( #$8405, &code_0F8BA1 )
    COP [09] ( #$8405 )
    COP [01] ( &asciistring_0F8BF7 )
    BRK #$5E
    COP [0A] ( #0B )
    RTL 
}

code_0F8BA1 {
    LDA $player_hp
    CMP $player_max_hp
    BEQ loc_0F8BB0
    COP [01] ( &asciistring_0F8C60 )
    COP [37]
    RTL 

  loc_0F8BB0:
    COP [01] ( &asciistring_0F8C75 )
    RTL 
}

code_0F8BB5 {
    COP [01] ( &asciistring_0F8BBC )
    COP [86]
    RTL 
}

asciistring_0F8BBC |[10][0E:3C]You hear a mermaid-[FIN]Is there anyone who [N]needs to use the [N]Bubble Armor? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8BF7 |[10]Oh! I have not had a [N]human guest in a long [N]time- [FIN]I know you can t [N]breathe under water, [N]so please take this- [FIN][02:2] received [N][03:24]Bubble Armor- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C60 |[10]Have you been hurt? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C75 |[10]If you get hurt, [N]return to me and I [N]will heal you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

code_0F8C9A {
    COP [07] ( #$8A02, &code_0F8CC8 )
    COP [91]
    COP [18] ( #21, &code_0F8CA9 )
    BRA loc_0F8CAA
}

code_0F8CA9 {
    RTL 

  loc_0F8CAA:
    LDA #$02A0
    STA $16
    LDA #$0B80
    STA $18
    PHX 
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA #$FC
    STA $7E8000, X
    REP #$20
    PLX 
    COP [09] ( #$8A02 )
}

code_0F8CC8 {
    COP [86]
    RTL 
}
---------------------------------------------

code_0F8CCB {
    COP [14] ( #$00A4, &code_0F8CD2 )
    RTL 
}

code_0F8CD2 {
    COP [17] ( &code_0F8D02 )
    COP [11] ( #13, #35, #26 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]

  loc_0F8CE4:
    COP [0C] ( #00, #02, &code_0F8CF1 )

  code_0F8CEA:
    COP [80] ( #01 )
    COP [82]
    BRA loc_0F8CE4
}

code_0F8CF1 {
    COP [9B] ( #$0000, &code_0F8CEA, &code_0F8CEA, &code_0F8CFB )
}

code_0F8CFB {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0F8CE4
}

code_0F8D02 {
    COP [0D] ( #00, #35, #26, &code_0F8D0E )
    COP [01] ( &asciistring_0F8D13 )
    RTL 
}

code_0F8D0E {
    COP [01] ( &asciistring_0F8D44 )
    RTL 
}

asciistring_0F8D13 |[10]Sorry, I have orders [N]from the Queen not to [N]let anyone pass- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8D44 |[10]How did you get here? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|