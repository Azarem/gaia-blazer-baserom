; Field talk: the B-button interaction that starts the script of an NPC in front of the player (file offsets 72152-72598, SNES $02:99D8-$9B96, bank 02).
; 
; === MODEL ===
; RunTalkInteraction (B) disables NMI, runs FindAndTalkToActorInFront and enables NMI: the script drives its own frames. The probe point depends on the facing code (from lib_player_helpers.GetPlayerFacing): code 0 (x+8, y-$10), 1 (x+8, y), 2 (x+$10, y-8), 3 (x, y-8) relative to the player's (x, y); facing 0 probes a second point two tiles up when the tile type there is 6. FindTalkableActorAt walks the actors from actor_list_tail through the $3E links and accepts the first one whose $16 has bit $0040 and whose box contains the point (x is the left edge, y the bottom edge, $10 and $12 width and height). ActivateTalkTarget needs $30,X (the script address, stored by Cop17_SetOwnParam, for example the first actor of gv_village_actors_018000) and calls it through an RTL frame: pushed bank $02 and ReturnFromTalk - 1, then the script bank (byte +$D of the actor's meta entry at $38,X) and $30,X - 1. With $16 bit $0008 the NPC first turns to face the player: TalkFacingPlayer copies the whole slot ($40 bytes) to $1A1E, ChooseFacingAnim picks the animation, the script runs, RestoreTalkedActor copies the slot back. So $16 bit $0040 = talkable and bit $0008 = turn to face the player (OQ-I005-14, OQ-I009-17).
; 
; === NOTES ===
; - The only entry is RunTalkInteraction: DispatchFieldButtons (lib_menus) branches to it with one BRL when B is pressed. GetPlayerFacing and FlipActorX come from lib_player_helpers. The parts are RunTalkInteraction, FindAndTalkToActorInFront, FindTalkableActorAt (with the sub-labels ActivateTalkTarget and TalkFacingPlayer), RestoreTalkedActor, ReturnFromTalk and ChooseFacingAnim.
---------------------------------------------

?BANK 02

?INCLUDE 'engine_actor_scheduler_and_sprites'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'lib_player_helpers'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'WorldMetaPointers'

!player_actor                   039C
!actor_list_tail                06A6
!tile_type_map                  7F8000

---------------------------------------------

; Runs the NPC talk lookup with NMI off.
; 
; When: DispatchFieldButtons, B pressed.
; Sees: the NPC in front of the player starts its text (walkthrough: 'speak with him (B Button)').
; Why: the talk script drives its own frames (text boxes, yes/no menus), so the NMI must be off while it runs.
; In: long call from DispatchFieldButtons.
; Out: DisableNmi, FindAndTalkToActorInFront, EnableNmi, RTL.
; Clobbers: as FindAndTalkToActorInFront.

RunTalkInteraction {
    JSL $@lib_system_helpers.DisableNmi ; The talk script runs with NMI off and drives its own frames
    JSR $&FindAndTalkToActorInFront
    JSL $@lib_system_helpers.EnableNmi
    RTL 
}

---------------------------------------------
; Probes the point in front of the player for a talkable actor and starts its script.
; 
; When: RunTalkInteraction.
; Sees: the NPC, sign or object in front of the player speaks; nothing happens when no talkable actor is there.
; Why: talking needs no marker: any actor whose $16 has bit $0040 and a script address in $30 can be spoken to; the probe point depends on the facing.
; In: JSR; M = 8 (REP inside); player slot = player_actor; the facing code A comes from lib_player_helpers.GetPlayerFacing (carry set = animation id $2C or more: no probe, return).
; Out: dp$00 = facing code; probe point (dp$16, dp$18) from the player's (x, y): code 0 (x+8, y-$10), 1 (x+8, y), 2 (x+$10, y-8), 3 (x, y-8); code 0 probes a second point (x+8, y-$20) when the tile type of the cell at (x, y-$20) is 6 (OQ-I009-7). On a hit FindTalkableActorAt's actor goes to ActivateTalkTarget (BRL, which ends in ReturnFromTalk); P is restored on the no-hit paths.
; Clobbers: A, X, Y, dp$00, dp$16, dp$18.

FindAndTalkToActorInFront {
    JSL $@lib_player_helpers.GetPlayerFacing ; A = facing code from the player's animation id; carry set = animation id $2C or more, no probe (OQ-I009-7)
    BCC loc_0119EB
    RTS 

  loc_0119EB:
    PHP 
    REP #$20
    LDY $player_actor
    AND #$00FF
    BEQ loc_011A43        ; Facing 0 (up) probes first at (x+8, y-$10)
    DEC 
    BNE loc_0119FC
    BRL loc_011AA7

  loc_0119FC:
    DEC 
    BNE loc_011A02
    BRL loc_011A05

  loc_011A02:
    BRL loc_011A26

  loc_011A05:
    LDA #$0002            ; Facing 2: probe point (x+$10, y-8)
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0008
    STA $18
    JSR $&FindTalkableActorAt
    BCC loc_011A24
    BRL ActivateTalkTarget

  loc_011A24:
    PLP 
    RTS 

  loc_011A26:
    LDA #$0003            ; Facing 3: probe point (x, y-8)
    STA $00
    LDA $0000, Y
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0008
    STA $18
    JSR $&FindTalkableActorAt
    BCC loc_011A41
    BRL ActivateTalkTarget

  loc_011A41:
    PLP 
    RTS 

  loc_011A43:
    LDA #$0000
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0008
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0010
    STA $18
    JSR $&FindTalkableActorAt
    BCC loc_011A62
    BRL ActivateTalkTarget

  loc_011A62:
    PHX 
    LDX $player_actor
    LDA $0000, X
    AND #$FFF0
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    AND #$FFF0
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    PLX 
    AND #$000F
    CMP #$0006            ; Facing 0 only, nothing found: when the tile type two tiles up is 6 (OQ-I009-7) a second probe at (x+8, y-$20) follows
    BNE loc_011AA5
    LDA $0000, Y
    CLC 
    ADC #$0008
    STA $16
    LDA $0002, Y
    SEC 
    SBC #$0020
    STA $18
    JSR $&FindTalkableActorAt
    BCC loc_011AA5
    BRL ActivateTalkTarget

  loc_011AA5:
    PLP 
    RTS 

  loc_011AA7:
    LDA #$0001            ; Facing 1: probe point (x+8, y)
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0008
    STA $16
    LDA $0002, Y
    STA $18
    JSR $&FindTalkableActorAt
    BCC loc_011AC2
    BRL ActivateTalkTarget

  loc_011AC2:
    PLP 
    RTS 
}

---------------------------------------------
; Finds the first talkable actor whose box contains a point.
; 
; When: five probes in FindAndTalkToActorInFront.
; Sees: n/a.
; Why: a small list walk replaces a collision test of the whole actor pool.
; In: JSR; M = 16; dp$16 = x, dp$18 = y of the point.
; Out: carry set and X = the actor, or carry clear (X = 0). Walks the run order from actor_list_tail through $3E; an actor matches when $16 has bit $0040, 0 <= x - $00,X <= $10,X (x is the left edge) and -$12,X <= y - $02,X <= 0 (y is the bottom edge).
; Clobbers: A, X.

FindTalkableActorAt {
    LDA $actor_list_tail  ; Walk the run order from actor_list_tail through the $3E links; X = 0 ends it

  loc_011AC7:
    TAX 
    BEQ loc_011AF5
    LDA $0016, X
    BIT #$0040            ; $16 bit $0040: the actor can be talked to (OQ-I009-17)
    BEQ loc_011AF0
    LDA $16
    SEC 
    SBC $0000, X
    CMP $0010, X          ; 0 <= point x - actor x <= width: x is the left edge
    BEQ loc_011ADF
    BCS loc_011AF0

  loc_011ADF:
    LDA $18
    SEC 
    SBC $0002, X
    CLC 
    ADC $0012, X          ; -height <= point y - actor y <= 0: y is the bottom edge
    CMP $0012, X
    BEQ loc_011AF7
    BCC loc_011AF7

  loc_011AF0:
    LDA $003E, X
    BRA loc_011AC7

  loc_011AF5:
    CLC 
    RTS 

  loc_011AF7:
    SEC 
    RTS 

; Calls the talk script of the actor found, optionally after turning it toward the player.
; 
; When: FindAndTalkToActorInFront (5 BRL).
; Sees: the NPC's lines start.
; Why: the script is a normal actor script run on the stack, so it can use every COP command and text box.
; In: X = the actor, M = 16.
; Out: $30,X = 0: nothing to say, to ReturnFromTalk. $16,X bit $0008: TalkFacingPlayer. Else a call frame is pushed (bank $02, ReturnFromTalk - 1, script bank = byte +$D of the actor's meta entry at $38,X, $30,X - 1) and RTL enters the script with X = the slot, M = 16; its final RTL returns to ReturnFromTalk.
; Clobbers: A, Y.

  ActivateTalkTarget:
    LDA $0030, X          ; $30,X = talk script address (Cop17_SetOwnParam); 0 = nothing to say
    BEQ ReturnFromTalk
    LDA $0016, X
    BIT #$0008            ; $16 bit $0008: turn to face the player first
    BNE TalkFacingPlayer
    SEP #$20
    LDA #$02              ; Build a call frame so the script's final RTL returns to ReturnFromTalk: bank $02 and ReturnFromTalk - 1, then the script bank and script address - 1; the RTL below enters the script
    PHA 
    PEA $&ReturnFromTalk-1
    LDY $0038, X
    LDA $&WorldMetaPointers+D, Y ; Script bank: byte +$D of the actor's meta entry ($38,X)
    PHA 
    LDY $0030, X
    DEY 
    PHY 
    REP #$20
    RTL 

; Turns the NPC toward the player, runs its script and restores the slot afterwards.
; 
; When: ActivateTalkTarget, for actors with $16 bit $0008.
; Sees: the NPC faces the player while speaking and goes back to its pose when the box closes.
; Why: the NPC animation is a side effect of the turn; the whole slot is copied so every field is restored exactly.
; In: X = the actor, M = 16.
; Out: slot (64 bytes) copied to $1A1E (MVN #$01,#$01), $1E,X = ChooseFacingAnim result, $20,X = 0, SetActorAnimFrame redraws it; then a call frame as in ActivateTalkTarget whose return address is RestoreTalkedActor, with the slot number on the stack.
; Clobbers: A, Y (X is pulled back after the MVN).

  TalkFacingPlayer:
    PHX 
    LDY #$1A1E            ; Save the whole slot ($40 bytes) to $1A1E: MVN copies X (slot) to Y ($1A1E)
    LDA #$003F
    MVN #$01, #$01
    PLX 
    PHX 
    JSR $&ChooseFacingAnim
    AND #$00FF            ; New animation id, step 0, then redraw the frame (SetActorAnimFrame)
    STA $001E, X
    STZ $0020, X
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    SEP #$20
    LDA #$02
    PHA 
    PEA $&RestoreTalkedActor-1
    LDY $0038, X
    LDA $&WorldMetaPointers+D, Y
    PHA 
    LDY $0030, X
    DEY 
    PHY 
    REP #$20
    RTL 
}

---------------------------------------------
; Copies the saved slot back over the NPC after its talk script.
; 
; When: return address of the call frame built by TalkFacingPlayer.
; Sees: the NPC returns to the animation it had before the talk.
; Why: see TalkFacingPlayer.
; In: the script returned; the slot number is on the stack.
; Out: $1A1E-$1A5D copied back over the slot (MVN #$01,#$01); falls into ReturnFromTalk.
; Clobbers: A, X, Y.

RestoreTalkedActor {
    LDX #$1A1E            ; Copy the saved slot back: X = $1A1E, Y = the slot pulled from the stack
    PLY 
    LDA #$003F
    MVN #$01, #$01
}

---------------------------------------------
; Common end of the talk call: restores P and returns to RunTalkInteraction.
; 
; When: the script's final RTL (through the pushed frame), or ActivateTalkTarget when $30,X is 0.
; Sees: n/a.
; Why: the P pushed by FindAndTalkToActorInFront has to be popped on every path.
; In: stack: P, then the return address of the JSR in RunTalkInteraction.
; Out: PLP, RTS.
; Clobbers: P restored.

ReturnFromTalk {
    PLP 
    RTS 
}

---------------------------------------------
; Picks the NPC animation that looks toward the player.
; 
; When: TalkFacingPlayer.
; Sees: an NPC turns to the player (down, up or sideways view, flipped toward the player's side).
; Why: NPC animations come in groups of six; the first of the group is the base and the facing code adds 0, 1 or 2.
; In: JSR; X = the actor; dp$00 = the player's facing code.
; Out: A and dp$01 = 6 x (anim / 6) + {0, 1, 2, 2}[facing] (anim = $1E,X; Divide and Multiply give the base). For facing 2 and 3 the flip bit ($1C bit $4000) is toggled only when it differs from 'facing is 3', through lib_player_helpers.FlipActorX: an unflipped side view looks left, a flipped one right. That +0, +1, +2 are the down, up and side views is inferred from the player's facing (OQ-I009-8).
; Clobbers: A, Y; dp$01.

ChooseFacingAnim {
    PHP 
    SEP #$20
    LDY $001E, X
    LDA #$06
    JSL $@lib_arithmetic.DivideWordByByte ; 6 x (anim / 6) = the first animation of the NPC's group of six
    XBA 
    LDA #$06
    JSL $@lib_arithmetic.Multiply8x8
    STA $01
    LDA $00
    BEQ loc_011B93
    DEC 
    BEQ loc_011B91
    DEC 
    BEQ loc_011B84
    LDA $001D, X          ; Facing 3 needs the flip bit set, facing 2 clear: toggle only when it differs (an unflipped side view looks left)
    BIT #$40
    BNE loc_011B8F
    BRA loc_011B8B

  loc_011B84:
    LDA $001D, X
    BIT #$40
    BEQ loc_011B8F

  loc_011B8B:
    JSL $@lib_player_helpers.FlipActorX

  loc_011B8F:
    INC $01

  loc_011B91:
    INC $01

  loc_011B93:
    LDA $01
    PLP 
    RTS 
}