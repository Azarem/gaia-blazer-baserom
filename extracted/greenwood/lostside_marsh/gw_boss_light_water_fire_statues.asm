; The boss of the Lostside marsh, the three Elemental Statues (file offsets 13254-15939, SNES $00:B3C6-$BE42, bank 00). One root script serves all three statues; the walkthrough calls them the Light Statue (far left, T-shaped thunderbolts), the Water Statue (rushes and leaves water that stays and hurts) and the Fire Statue (rushes and streams of fire). Each has 50 HP and gives 30 EXP (meta type $3D, 9/5/50 HP, EXP BCD $0030; 90 EXP in all, as in the bestiary).
; 
; === HOW THE FIGHT IS BUILT ===
; The lair is record $50 (A05S0A, the statue tomb, RunLairFormation, 3 monsters, formation $20): three rows, ($F0,$90) with no flip, ($40,$60) flip X and ($1A0,$60) flip Y. The root gw_boss_light_water_fire_statues_0033C6 runs in all three: it clears exit_list_ofs, increments boss_fight_active, sets $0200 in $16, spawns engine_player_death_and_actor_helpers.RunBossMapPatch with patch id 1 (the map patch of the boss room) and then COP A5 sends each statue to its own script by flip state: none to code_0033EA, flip X to code_003732, flip Y to code_003A3D.
; Only one statue is the boss at a time (boss_actor $039A). The Light Statue (code_003732) sets boss_actor at once; the other two sleep (animations $21 and $13, COP 91 loop) and wait until the boss_actor's $16 has bit $0400, which RunBossDeath sets when it writes $0700 into $16 of the dying boss. Then they wait 8 frames and write their own slot into boss_actor. Because the hand-over happens while the 32 explosions of the dead statue still run, RunBossDeath finds X != boss_actor at its end and skips KillAllOtherActors and the music change: only the last statue (boss_actor still its own) clears the room and ends the fight. The Water Statue takes over only when boss_actor is the actor in the slot after its own (code_0033EA: TXA / ADC #$0080 / CMP boss_actor), the Fire Statue (code_003A3D) after any boss_actor death (OQ-I035-12).
; A statue that has become the boss waits again until the hero is inside its box widened by 4 (COP 0C, slot 0), spawns a wake effect (code_003E1C animation $3A for the Water Statue, code_003E29 animation $3C for the Light Statue, code_003E36 animation $3E for the Fire Statue), clears $0300 in $16, zeroes contact_lock and starts its loop after 60 frames. The loops are tile and distance driven: COP 9A / 9B compare the distance to the hero, COP 21-24 and COP AE test tiles, COP 80 picks the animation per direction.
; 
; === THE THREE ATTACKS ===
; Light Statue (code_003732 ... code_003A15): rushes at the hero (the walkthrough: 'general rushing') and the T-shaped bolt. The bolt is eight children made one after the other (COP 85): two for each direction, south (code_0039AE, code_0039BD), west (code_0039CA, code_0039D9), north (code_0039E6, code_0039F5) and east (code_003A04, code_003A15), each a piece of the T (offsets in COP A1, direction in $1E, $2A = 4) that vanishes by itself. The order matches the walkthrough: south, west, north, east. A COP 27 loop starts the cycle again.
; Water Statue (code_0033EA ... code_00372B): rushes at the hero (the walkthrough: equal-length rushes, turns of 90 degrees); every so often (COP 07 #$9905 tests the lock, COP 09 sets it) it spawns a puddle trail (code_003661, code_0036BF, then the chain code_003630 ... code_0036A2 / code_0036CF). Each puddle spawns the next one step further (COP 21-24 decide when the trail ends) and counts the segments in byte 0 of event_flags (at most 4); the last one clears the lock flag $1905 and the counter. The walkthrough: the water stays for some time and hurts on touch.
; Fire Statue (code_003A3D ... code_003CFE): rushes at the hero (the walkthrough: rushes of varying length); when the tile test in its facing and the four probes ahead (COP AE, 64-80 pixels away) all pass it spawns a flame (code_003D3C, code_003D0D, code_003D6F, code_003DA1 by direction, which spawn the flame code_003DE4 with animations $22, $40 and $3F) and waits 30 frames.
; 
; === SHARED STATE ===
; boss_actor $039A (the active statue), boss_fight_active $0458, exit_list_ofs $03B2, contact_lock $042D, flag $1905 (puddle trail running), byte 0 of event_flags ($1A5E: flags $0000-$0007, the puddle counter; the statue clears it at the start and the trail at its end, OQ-I035-8). The statue tomb is entered from the Lostside; after the third statue the switch $50 releases the Guardian of the Woods (walkthrough: the switch under the lair in the north-west corner).
; 
; Open points: the position of the Water and the Fire Statue (the walkthrough puts the Water Statue at the far right; by the rows of formation $20 the far right row runs the Fire script, OQ-I035-13, DISCREPANCY), the exact hand-over order of the second and third statue (OQ-I035-12), the clearing of event_flags byte 0 (OQ-I035-8).
---------------------------------------------

?BANK 00

?INCLUDE 'engine_player_death_and_actor_helpers'

!boss_actor                     039A
!exit_list_ofs                  03B2
!contact_lock                   042D
!boss_fight_active              0458
!event_flags                    1A5E

---------------------------------------------

; The root of all three Elemental Statues: starts the boss fight and sends each statue to its own script.
; 
; When: meta type $3D, lair record $50 (A05S0A, 3 monsters, formation $20): every statue starts here.
; Sees: nothing yet; the statues are asleep until their turn (see the block note).
; Why: the three statues share the fight start (boss_fight_active, the map patch) and differ only after COP A5 by flip state. The patch actor RunBossMapPatch is spawned three times, once by each statue (it blocks the buttons while the room is patched; whether it closes or opens the room is OQ-I024-3).
; In: actor script, X = the statue's slot, Y = the new patch actor after COP 85.
; Out: STZ exit_list_ofs, boss_fight_active + 1, $16 bit $0200 set, patch id 1 in $30 of the patch actor; then a jump by COP A5 to code_0033EA, code_003732 or code_003A3D.
; Clobbers: A, Y.

gw_boss_light_water_fire_statues_0033C6 {
    STZ $exit_list_ofs
    INC $boss_fight_active ; ends with the boss music change (RunBossDeath of the last statue)
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [85] ( @engine_player_death_and_actor_helpers.RunBossMapPatch ) ; patch id 1 goes into its $30 (Y = the new actor)
    LDA #$0001
    STA $0030, Y
    COP [A5] ( &code_0033EA, &code_003732, &code_003A3D, &code_003A3D ) ; none: Water (0033EA), flip X: Light (003732), flip Y: Fire (003A3D)
}

code_0033EA {
    COP [80] ( #21 )
    COP [82]
    COP [91]
    TXA 
    CLC 
    ADC #$0080
    CMP $boss_actor       ; the Water Statue takes over only from the actor in the next slot
    BEQ loc_0033FC
    RTL 

  loc_0033FC:
    COP [91]
    LDY $boss_actor
    LDA $0016, Y
    BIT #$0400            ; $0400: RunBossDeath wrote $0700 into $16 of the dying boss
    BNE loc_00340A
    RTL 

  loc_00340A:
    COP [1B] ( &code_003410, #$0008 )
}

code_003410 {
    STX $boss_actor       ; this statue is now the boss: its death ends the fight
    COP [91]
    COP [0C] ( #00, #04, &code_00341C )
    RTL 
}

code_00341C {
    COP [85] ( @code_003E1C )
    COP [09] ( #$1905 )   ; no puddle trail is running
    SEP #$20
    STZ $event_flags      ; event_flags byte 0 = the puddle counter (OQ-I035-8)
    REP #$20
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    STZ $contact_lock
    COP [1B] ( &code_00347F, #$003C )

  loc_00343E:
    COP [9B] ( #$0060, &code_003448, &code_003448, &code_0035F4 )
}

code_003448 {
    COP [9A] ( #$0020, &code_0035EA, &code_0034C0, &code_003501 )

  loc_003452:
    COP [07] ( #$9905, &code_00346B )
    COP [24] ( &code_00346B )
    COP [09] ( #$9905 )   ; flag $1905 set: a puddle trail is out
    COP [85] ( @code_003661 )
    COP [1B] ( &code_00346B, #$0028 )
}

code_00346B {
    COP [9A] ( #$0060, &code_003621, &code_003475, &code_003475 )
}

code_003475 {
    COP [9B] ( #$0010, &code_00350B, &code_003515, &code_003553 )
}

code_00347F {
    COP [9B] ( #$0060, &code_003603, &code_003489, &code_003489 )
}

code_003489 {
    COP [9A] ( #$0020, &code_0035B2, &code_003567, &code_00355D )

  loc_003493:
    COP [07] ( #$9905, &code_0034AC )
    COP [23] ( &code_0034AC )
    COP [09] ( #$9905 )
    COP [85] ( @code_0036BF )
    COP [1B] ( &code_0034AC, #$0028 )
}

code_0034AC {
    COP [9A] ( #$0060, &code_0034B6, &code_0034B6, &code_003612 )
}

code_0034B6 {
    COP [9B] ( #$0010, &code_0035E0, &code_0035BC, &code_0035A8 )
}

code_0034C0 {
    COP [97]
    COP [80] ( #2C )
    COP [82]

  loc_0034C7:
    COP [9B] ( #$0000, &code_0034D1, &code_0034DA, &code_0034DA )
}

code_0034D1 {
    COP [9D] ( #1D )
    COP [9E] ( &code_0034E4 )

  loc_0034D8:
    BRA loc_0034C7
}

code_0034DA {
    COP [9D] ( #2D )
    COP [9E] ( &code_0034E4 )

  loc_0034E1:
    BRL loc_00343E
}

code_0034E4 {
    COP [9A] ( #$0000, &code_0034EE, &code_0034EE, &code_0034F8 )
}

code_0034EE {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRL code_0035BC
}

code_0034F8 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRA code_003515
}

code_003501 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRL code_003515
}

code_00350B {
    COP [96]
    COP [80] ( #09 )
    COP [82]
    BRL code_0034C0
}

code_003515 {
    COP [96]
    COP [80] ( #2A )
    COP [82]

  loc_00351C:
    COP [9A] ( #$0000, &code_003530, &code_003530, &code_003526 )
}

code_003526 {
    COP [9D] ( #1C )
    COP [9E] ( &code_00353A )

  loc_00352D:
    BRL loc_00351C
}

code_003530 {
    COP [9D] ( #2B )
    COP [9E] ( &code_00353A )

  loc_003537:
    BRL loc_003452
}

code_00353A {
    COP [9B] ( #$0000, &code_003544, &code_003544, &code_00354C )
}

code_003544 {
    COP [80] ( #09 )
    COP [82]
    BRL code_0034C0
}

code_00354C {
    COP [80] ( #0A )
    COP [82]
    BRA code_003567
}

code_003553 {
    COP [96]
    COP [80] ( #0A )
    COP [82]
    BRL code_003567
}

code_00355D {
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRL code_003515
}

code_003567 {
    COP [97]
    COP [80] ( #2E )
    COP [82]

  loc_00356E:
    COP [9B] ( #$0000, &code_003581, &code_003581, &code_003578 )
}

code_003578 {
    COP [9D] ( #1E )
    COP [9E] ( &code_00358B )

  loc_00357F:
    BRA loc_00356E
}

code_003581 {
    COP [9D] ( #2F )
    COP [9E] ( &code_00358B )

  loc_003588:
    BRL code_00347F
}

code_00358B {
    COP [9A] ( #$0000, &code_003595, &code_003595, &code_00359E )
}

code_003595 {
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRA code_0035BC
}

code_00359E {
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRL code_003515
}

code_0035A8 {
    COP [97]
    COP [80] ( #0A )
    COP [82]
    BRL code_003567
}

code_0035B2 {
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRL code_0035BC
}

code_0035BC {
    COP [97]
    COP [80] ( #2A )
    COP [82]

  loc_0035C3:
    COP [9A] ( #$0000, &code_0035CD, &code_0035D6, &code_0035D6 )
}

code_0035CD {
    COP [9D] ( #1C )
    COP [9E] ( &code_00353A )

  loc_0035D4:
    BRA loc_0035C3
}

code_0035D6 {
    COP [9D] ( #2B )
    COP [9E] ( &code_00353A )

  loc_0035DD:
    BRL loc_003493
}

code_0035E0 {
    COP [97]
    COP [80] ( #09 )
    COP [82]
    BRL code_0034C0
}

code_0035EA {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRL code_0035BC
}

code_0035F4 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #0A )
    COP [82]
    BRL code_003567
}

code_003603 {
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #09 )
    COP [82]
    BRL code_0034C0
}

code_003612 {
    COP [80] ( #09 )
    COP [82]
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRL code_003515
}

code_003621 {
    COP [80] ( #09 )
    COP [82]
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRL code_0035BC

  code_003630:
    JSR $&code_00372B
    COP [A0] ( #$FFF0 )
    COP [80] ( #27 )
    COP [82]
    LDA $event_flags      ; at most 4 puddle segments
    AND #$00FF
    CMP #$0004
    BCC loc_00364A
    BRL code_0036FF

  loc_00364A:
    COP [9C] ( &code_003650, &code_0036FF )
}

code_003650 {
    SEP #$20
    INC $event_flags      ; one more segment
    REP #$20
    COP [9A] ( #$0000, &code_003720, &code_003720, &code_00370A )
}

code_003661 {
    JSR $&code_00372B
    COP [9F] ( #$0020 )
    BRK #$5D
    COP [80] ( #29 )
    COP [82]
    BRA loc_003678

  code_003671:
    JSR $&code_00372B
    COP [9F] ( #$0010 )

  loc_003678:
    COP [80] ( #27 )
    COP [82]
    LDA $event_flags
    AND #$00FF
    CMP #$0004
    BCC loc_00368B
    BRL code_00370A

  loc_00368B:
    COP [9C] ( &code_00370A, &code_003691 )
}

code_003691 {
    SEP #$20
    INC $event_flags
    REP #$20
    COP [9B] ( #$0000, &code_0036FF, &code_0036FF, &code_003715 )

  code_0036A2:
    JSR $&code_00372B
    COP [A0] ( #$0010 )
    COP [80] ( #27 )
    COP [82]
    LDA $event_flags
    AND #$00FF
    CMP #$0004
    BCS code_003715
    COP [9C] ( &code_003650, &code_003715 )
}

code_0036BF {
    JSR $&code_00372B
    COP [9F] ( #$FFF0 )
    BRK #$5D
    COP [80] ( #29 )
    COP [82]
    BRA loc_0036D6

  code_0036CF:
    JSR $&code_00372B
    COP [9F] ( #$FFF0 )

  loc_0036D6:
    COP [80] ( #27 )
    COP [82]
    LDA $event_flags
    AND #$00FF
    CMP #$0004
    BCS code_003720
    COP [9C] ( &code_003720, &code_003691 )

  code_0036EC:
    COP [09] ( #$1905 )
    SEP #$20
    STZ $event_flags      ; trail over: counter cleared, lock cleared just before
    REP #$20

  loc_0036F7:
    COP [80] ( #28 )
    COP [82]
    COP [86]
    RTL 
}

code_0036FF {
    COP [21] ( &code_0036EC )
    COP [85] ( @code_003630 )
    BRA loc_0036F7
}

code_00370A {
    COP [24] ( &code_0036EC )
    COP [85] ( @code_003671 )
    BRA loc_0036F7
}

code_003715 {
    COP [22] ( &code_0036EC )
    COP [85] ( @code_0036A2 )
    BRA loc_0036F7
}

code_003720 {
    COP [23] ( &code_0036EC )
    COP [85] ( @code_0036CF )
    BRA loc_0036F7
}

code_00372B {
    LDA #$0200
    STA $0016, X
    RTS 
}

code_003732 {
    STX $boss_actor       ; the Light Statue is the boss from the start
    COP [80] ( #19 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #04, &code_003743 ) ; slot 0 (the hero) inside the box widened by 4: wake up
    RTL 
}

code_003743 {
    COP [85] ( @code_003E29 )
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    STZ $contact_lock
    COP [1B] ( &code_0037A3, #$003C )

  loc_00375A:
    COP [0C] ( #00, #04, &code_003774 )
    COP [9B] ( #$0060, &code_00376A, &code_00376A, &code_003972 )
}

code_00376A {
    COP [9A] ( #$0020, &code_003968, &code_003836, &code_003879 )
}

code_003774 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    BRA code_0037D7

  loc_003782:
    COP [0C] ( #00, #04, &code_00379C )
    COP [9A] ( #$0060, &code_00399F, &code_003792, &code_003792 )
}

code_003792 {
    COP [9B] ( #$0020, &code_003883, &code_00388D, &code_0038CD )
}

code_00379C {
    COP [80] ( #07 )
    COP [82]
    BRA code_0037D7
}

code_0037A3 {
    COP [0C] ( #00, #04, &code_0037D7 )

  code_0037A9:
    COP [9B] ( #$0060, &code_003981, &code_0037B3, &code_0037B3 )
}

code_0037B3 {
    COP [9A] ( #$0020, &code_00392E, &code_0038E1, &code_0038D7 )

  loc_0037BD:
    COP [0C] ( #00, #04, &code_00379C )
    COP [9A] ( #$0060, &code_0037CD, &code_0037CD, &code_003990 )
}

code_0037CD {
    COP [9B] ( #$0020, &code_00395E, &code_003938, &code_003924 )
}

code_0037D7 {
    COP [81] ( #19, #02 )
    COP [83]
    COP [85] ( @code_0039AE ) ; the T-shaped bolt: two pieces per direction, south, west, north, east
    COP [85] ( @code_0039BD )
    COP [80] ( #19 )
    COP [82]
    COP [97]
    COP [80] ( #04 )
    COP [82]
    COP [85] ( @code_0039CA )
    COP [85] ( @code_0039D9 )
    COP [80] ( #1A )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    COP [85] ( @code_0039E6 )
    COP [85] ( @code_0039F5 )
    COP [80] ( #1B )
    COP [82]
    COP [96]
    COP [80] ( #06 )
    COP [82]
    COP [85] ( @code_003A04 )
    COP [85] ( @code_003A15 )
    COP [81] ( #1A, #05 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    COP [27] ( &code_0037A9 )
}

code_003836 {
    COP [97]
    COP [80] ( #32 )
    COP [82]

  loc_00383D:
    COP [9B] ( #$0000, &code_003847, &code_003850, &code_003850 )
}

code_003847 {
    COP [9D] ( #18 )
    COP [9E] ( &code_00385C )

  loc_00384E:
    BRA loc_00383D
}

code_003850 {
    COP [21] ( &code_00385C )
    COP [80] ( #33 )
    COP [82]
    BRL loc_00375A
}

code_00385C {
    COP [9A] ( #$0000, &code_003866, &code_003866, &code_003870 )
}

code_003866 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRL code_003938
}

code_003870 {
    COP [96]
    COP [80] ( #06 )
    COP [82]
    BRA code_00388D
}

code_003879 {
    COP [96]
    COP [80] ( #06 )
    COP [82]
    BRL code_00388D
}

code_003883 {
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRL code_003836
}

code_00388D {
    COP [96]
    COP [80] ( #30 )
    COP [82]

  loc_003894:
    COP [9A] ( #$0000, &code_0038A8, &code_0038A8, &code_00389E )
}

code_00389E {
    COP [9D] ( #17 )
    COP [9E] ( &code_0038B4 )

  loc_0038A5:
    BRL loc_003894
}

code_0038A8 {
    COP [24] ( &code_0038B4 )
    COP [80] ( #31 )
    COP [82]
    BRL loc_003782
}

code_0038B4 {
    COP [9B] ( #$0000, &code_0038BE, &code_0038BE, &code_0038C6 )
}

code_0038BE {
    COP [80] ( #05 )
    COP [82]
    BRL code_003836
}

code_0038C6 {
    COP [80] ( #07 )
    COP [82]
    BRA code_0038E1
}

code_0038CD {
    COP [96]
    COP [80] ( #07 )
    COP [82]
    BRL code_0038E1
}

code_0038D7 {
    COP [96]
    COP [80] ( #04 )
    COP [82]
    BRL code_00388D
}

code_0038E1 {
    COP [97]
    COP [80] ( #34 )
    COP [82]

  loc_0038E8:
    COP [9B] ( #$0000, &code_0038FB, &code_0038FB, &code_0038F2 )
}

code_0038F2 {
    COP [9D] ( #16 )
    COP [9E] ( &code_003907 )

  loc_0038F9:
    BRA loc_0038E8
}

code_0038FB {
    COP [22] ( &code_003907 )
    COP [80] ( #35 )
    COP [82]
    BRL code_0037A3
}

code_003907 {
    COP [9A] ( #$0000, &code_003911, &code_003911, &code_00391A )
}

code_003911 {
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_003938
}

code_00391A {
    COP [96]
    COP [80] ( #04 )
    COP [82]
    BRL code_00388D
}

code_003924 {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRL code_0038E1
}

code_00392E {
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRL code_003938
}

code_003938 {
    COP [97]
    COP [80] ( #30 )
    COP [82]

  loc_00393F:
    COP [9A] ( #$0000, &code_003949, &code_003952, &code_003952 )
}

code_003949 {
    COP [9D] ( #17 )
    COP [9E] ( &code_0038B4 )

  loc_003950:
    BRA loc_00393F
}

code_003952 {
    COP [23] ( &code_0038B4 )
    COP [80] ( #31 )
    COP [82]
    BRL loc_0037BD
}

code_00395E {
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRL code_003836
}

code_003968 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRL code_003938
}

code_003972 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    BRL code_0038E1
}

code_003981 {
    COP [97]
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    BRL code_003836
}

code_003990 {
    COP [80] ( #05 )
    COP [82]
    COP [96]
    COP [80] ( #06 )
    COP [82]
    BRL code_00388D
}

code_00399F {
    COP [80] ( #05 )
    COP [82]
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRL code_003938
}

code_0039AE {
    BRK #$5A
    COP [A3]
    COP [A1] ( #$0008, #$0048 )
    LDA #$0000
    BRA loc_003A24
}

code_0039BD {
    COP [A3]
    COP [A1] ( #$FFE8, #$0048 )
    LDA #$0003
    BRA loc_003A24
}

code_0039CA {
    BRK #$5A
    COP [A3]
    COP [A1] ( #$FFC0, #$FFF8 )
    LDA #$0002
    BRA loc_003A24
}

code_0039D9 {
    COP [A3]
    COP [A1] ( #$FFC8, #$0018 )
    LDA #$0001
    BRA loc_003A24
}

code_0039E6 {
    BRK #$5A
    COP [A1] ( #$0008, #$FFE8 )
    COP [88]
    LDA #$0000
    BRA loc_003A24
}

code_0039F5 {
    COP [A3]
    COP [A1] ( #$FFE8, #$FFB0 )
    COP [88]
    LDA #$0003
    BRA loc_003A24
}

code_003A04 {
    BRK #$5A
    COP [A3]
    COP [A1] ( #$0020, #$FFF8 )
    COP [96]
    LDA #$0002
    BRA loc_003A24
}

code_003A15 {
    COP [A3]
    COP [A1] ( #$0050, #$0018 )
    COP [96]
    LDA #$0001
    BRA loc_003A24

  loc_003A24:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    LDA #$0004
    STA $002A, X
    COP [91]
    COP [83]
    COP [86]
    RTL 
}

code_003A3D {
    COP [80] ( #13 )
    COP [82]
    COP [91]
    LDY $boss_actor
    LDA $0016, Y
    BIT #$0400            ; $0400: the boss is dying; any statue may follow (OQ-I035-12)
    BNE loc_003A50
    RTL 

  loc_003A50:
    COP [1B] ( &code_003A56, #$0008 )
}

code_003A56 {
    STX $boss_actor       ; the Fire Statue is the boss now
    COP [91]
    COP [0C] ( #00, #04, &code_003A62 )
    RTL 
}

code_003A62 {
    COP [85] ( @code_003E36 )
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    STZ $contact_lock
    COP [1B] ( &code_003B0B, #$003C )

  loc_003A79:
    COP [0C] ( #00, #04, &code_003A93 )

  code_003A7F:
    COP [9B] ( #$0060, &code_003A89, &code_003A89, &code_003CD1 )
}

code_003A89 {
    COP [9A] ( #$0010, &code_003CC7, &code_003B9D, &code_003BDE )
}

code_003A93 {
    COP [21] ( &code_003A7F )
    COP [AE] ( #$0000, #$FFC0, &code_003A7F )
    COP [AE] ( #$0000, #$FFB0, &code_003A7F )
    COP [AE] ( #$0010, #$FFC0, &code_003A7F )
    COP [AE] ( #$0010, #$FFB0, &code_003A7F )
    COP [85] ( @code_003D3C ) ; the five tile tests ahead passed: place a flame
    COP [1B] ( &code_003A7F, #$001E )

  loc_003AC2:
    COP [0C] ( #00, #04, &code_003ADC )

  code_003AC8:
    COP [9A] ( #$0060, &code_003CFE, &code_003AD2, &code_003AD2 )
}

code_003AD2 {
    COP [9B] ( #$0010, &code_003BE8, &code_003BF2, &code_003C30 )
}

code_003ADC {
    COP [24] ( &code_003AC8 )
    COP [AE] ( #$0050, #$0000, &code_003AC8 )
    COP [AE] ( #$0050, #$FFF0, &code_003AC8 )
    COP [AE] ( #$0060, #$0000, &code_003AC8 )
    COP [AE] ( #$0060, #$FFF0, &code_003AC8 )
    COP [85] ( @code_003DA1 )
    COP [1B] ( &code_003AC8, #$001E )
}

code_003B0B {
    COP [0C] ( #00, #04, &code_003B25 )

  code_003B11:
    COP [9B] ( #$0060, &code_003CE0, &code_003B1B, &code_003B1B )
}

code_003B1B {
    COP [9A] ( #$0010, &code_003C8F, &code_003C44, &code_003C3A )
}

code_003B25 {
    COP [22] ( &code_003B11 )
    COP [AE] ( #$0000, #$0030, &code_003B11 )
    COP [AE] ( #$0000, #$0040, &code_003B11 )
    COP [AE] ( #$0010, #$0030, &code_003B11 )
    COP [AE] ( #$0010, #$0040, &code_003B11 )
    COP [85] ( @code_003D0D )
    COP [1B] ( &code_003B11, #$001E )

  loc_003B54:
    COP [0C] ( #00, #04, &code_003B6E )

  code_003B5A:
    COP [9A] ( #$0060, &code_003B64, &code_003B64, &code_003CEF )
}

code_003B64 {
    COP [9B] ( #$0010, &code_003CBD, &code_003C99, &code_003C85 )
}

code_003B6E {
    COP [23] ( &code_003B5A )
    COP [AE] ( #$FFC0, #$0000, &code_003B5A )
    COP [AE] ( #$FFC0, #$FFF0, &code_003B5A )
    COP [AE] ( #$FFB0, #$0000, &code_003B5A )
    COP [AE] ( #$FFB0, #$FFF0, &code_003B5A )
    COP [85] ( @code_003D6F )
    COP [1B] ( &code_003B5A, #$001E )
}

code_003B9D {
    COP [97]
    COP [80] ( #38 )
    COP [82]

  loc_003BA4:
    COP [9B] ( #$0000, &code_003BAE, &code_003BB7, &code_003BB7 )
}

code_003BAE {
    COP [9D] ( #11 )
    COP [9E] ( &code_003BC1 )

  loc_003BB5:
    BRA loc_003BA4
}

code_003BB7 {
    COP [9D] ( #39 )
    COP [9E] ( &code_003BC1 )

  loc_003BBE:
    BRL loc_003A79
}

code_003BC1 {
    COP [9A] ( #$0000, &code_003BCB, &code_003BCB, &code_003BD5 )
}

code_003BCB {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    BRL code_003C99
}

code_003BD5 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    BRA code_003BF2
}

code_003BDE {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    BRL code_003BF2
}

code_003BE8 {
    COP [96]
    COP [80] ( #0D )
    COP [82]
    BRL code_003B9D
}

code_003BF2 {
    COP [96]
    COP [80] ( #36 )
    COP [82]

  loc_003BF9:
    COP [9A] ( #$0000, &code_003C0D, &code_003C0D, &code_003C03 )
}

code_003C03 {
    COP [9D] ( #12 )
    COP [9E] ( &code_003C17 )

  loc_003C0A:
    BRL loc_003BF9
}

code_003C0D {
    COP [9D] ( #37 )
    COP [9E] ( &code_003C17 )

  loc_003C14:
    BRL loc_003AC2
}

code_003C17 {
    COP [9B] ( #$0000, &code_003C21, &code_003C21, &code_003C29 )
}

code_003C21 {
    COP [80] ( #0D )
    COP [82]
    BRL code_003B9D
}

code_003C29 {
    COP [80] ( #0E )
    COP [82]
    BRA code_003C44
}

code_003C30 {
    COP [96]
    COP [80] ( #0E )
    COP [82]
    BRL code_003C44
}

code_003C3A {
    COP [96]
    COP [80] ( #0C )
    COP [82]
    BRL code_003BF2
}

code_003C44 {
    COP [97]
    COP [80] ( #3A )
    COP [82]

  loc_003C4B:
    COP [9B] ( #$0000, &code_003C5E, &code_003C5E, &code_003C55 )
}

code_003C55 {
    COP [9D] ( #10 )
    COP [9E] ( &code_003C68 )

  loc_003C5C:
    BRA loc_003C4B
}

code_003C5E {
    COP [9D] ( #3B )
    COP [9E] ( &code_003C68 )

  loc_003C65:
    BRL code_003B0B
}

code_003C68 {
    COP [9A] ( #$0000, &code_003C72, &code_003C72, &code_003C7B )
}

code_003C72 {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    BRA code_003C99
}

code_003C7B {
    COP [96]
    COP [80] ( #0C )
    COP [82]
    BRL code_003BF2
}

code_003C85 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    BRL code_003C44
}

code_003C8F {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    BRL code_003C99
}

code_003C99 {
    COP [97]
    COP [80] ( #36 )
    COP [82]

  loc_003CA0:
    COP [9A] ( #$0000, &code_003CAA, &code_003CB3, &code_003CB3 )
}

code_003CAA {
    COP [9D] ( #12 )
    COP [9E] ( &code_003C17 )

  loc_003CB1:
    BRA loc_003CA0
}

code_003CB3 {
    COP [9D] ( #37 )
    COP [9E] ( &code_003C17 )

  loc_003CBA:
    BRL loc_003B54
}

code_003CBD {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    BRL code_003B9D
}

code_003CC7 {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    BRL code_003C99
}

code_003CD1 {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #0E )
    COP [82]
    BRL code_003C44
}

code_003CE0 {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    COP [80] ( #0D )
    COP [82]
    BRL code_003B9D
}

code_003CEF {
    COP [80] ( #0D )
    COP [82]
    COP [96]
    COP [80] ( #0F )
    COP [82]
    BRL code_003BF2
}

code_003CFE {
    COP [80] ( #0D )
    COP [82]
    COP [97]
    COP [80] ( #0F )
    COP [82]
    BRL code_003C99
}

code_003D0D {
    JSR $&code_003E02
    COP [9F] ( #$0008 )
    COP [80] ( #3C )
    COP [82]
    COP [85] ( @code_003D2C )
    COP [80] ( #25 )
    COP [82]
    COP [A1] ( #$FFF8, #$0010 )
    BRL loc_003E0D
}

code_003D2C {
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [80] ( #3E )
    COP [82]
    COP [86]
    RTL 
}

code_003D3C {
    LDA #$0200
    STA $0016, X
    COP [A1] ( #$0008, #$FFE8 )
    COP [98]
    COP [80] ( #3C )
    COP [82]
    BRK #$5B
    COP [80] ( #25 )
    COP [82]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [85] ( @code_003DE4 )
    COP [A0] ( #$FFE0 )
    COP [A4]
    COP [80] ( #26 )
    COP [82]
    COP [86]
    RTL 
}

code_003D6F {
    JSR $&code_003E02
    COP [A1] ( #$FFF8, #$FFF4 )
    COP [80] ( #3C )
    COP [82]
    COP [85] ( @code_003D8F )
    COP [80] ( #24 )
    COP [82]
    COP [A1] ( #$FFF0, #$0008 )
    BRA loc_003E0D
}

code_003D8F {
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [97]
    COP [80] ( #3D )
    COP [82]
    COP [86]
    RTL 
}

code_003DA1 {
    JSR $&code_003E02
    COP [A1] ( #$0020, #$FFF4 )
    COP [80] ( #3C )
    COP [82]
    COP [85] ( @code_003DD2 )
    COP [96]
    COP [80] ( #24 )
    COP [82]
    COP [A0] ( #$0008 )
    COP [85] ( @code_003DE4 )
    COP [9F] ( #$0018 )
    COP [A4]
    COP [80] ( #26 )
    COP [82]
    COP [86]
    RTL 
}

code_003DD2 {
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [96]
    COP [80] ( #3D )
    COP [82]
    COP [86]
    RTL 
}

code_003DE4 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    COP [99]
    COP [80] ( #22 )
    COP [82]
    COP [81] ( #40, #14 )
    COP [83]
    COP [81] ( #3F, #14 )
    COP [83]
    COP [86]
    RTL 
}

code_003E02 {
    LDA #$0200
    STA $0016, X
    COP [A3]
    BRK #$5B
    RTS 

  loc_003E0D:
    COP [85] ( @code_003DE4 )
    COP [A4]
    COP [80] ( #26 )
    COP [82]
    COP [86]
    RTL 
}

code_003E1C {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #3A )
    COP [94]
    COP [86]
    RTL 
}

code_003E29 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #3C )
    COP [94]
    COP [86]
    RTL 
}

code_003E36 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #3E )
    COP [94]
    COP [86]
    RTL 
}