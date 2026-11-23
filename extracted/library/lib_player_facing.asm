; Facing code of the player and the horizontal flip of an actor (file offsets 160724-160760, SNES $04:F3D4-$F3F8, bank 04).
; 
; === MODEL ===
; GetPlayerFacing reads the player's animation id (actor $1E) and returns the facing code PlayerFacingByAnim[id] (a 44-byte table in data_engine_tables, ids $00-$2B): 0 up, 1 down, 2 right, 3 left (the probe points of RunTalkInteraction, OQ-I009-7). Animation ids of $2C or more have no facing: carry set. The animation id is read as a word, so $1F must be 0.
; FlipActorX toggles bit $4000 of the actor's $1C word, the horizontal flip flag.
; 
; === NOTES ===
; - Callers: RunTalkInteraction (lib_menus) for the probe point of the talk button and TryOpenChest (lib_tile_triggers_and_lair_return); ChooseFacingAnim (lib_menus) calls FlipActorX to show an NPC's side view mirrored.
; - ApplyPlayerWeaponPose reads the same table and xors the code with 1 to get the standing animation id of the unarmed set.
---------------------------------------------

?BANK 04

?INCLUDE 'data_engine_tables'

!player_actor                   039C

---------------------------------------------

; Gives the direction the player faces as a code 0-3.
; 
; When: RunTalkInteraction (the B button) and TryOpenChest.
; Sees: the player talks to or opens what is in front of him, and in no direction while an animation of the $2C or higher ids plays (no talk, no chest).
; Why: the facing is derived from the animation id, so every walking, standing and attack animation maps to one of four directions.
; In: JSL; M = 8, X = 16-bit; player_actor ($039C).
; Out: carry clear and A = PlayerFacingByAnim[$1E of the player actor] (0 up, 1 down, 2 right, 3 left); carry set when $1E >= $2C (A not valid). P restored apart from the carry.
; Clobbers: A, X, Y.

GetPlayerFacing {
    PHP 
    SEP #$20
    LDY $player_actor
    LDX $001E, Y
    CPX #$002C            ; animation ids of $2C or more have no facing: carry set
    BCS GetPlayerFacingNone
    LDA $&data_engine_tables.PlayerFacingByAnim, X
    PLP 
    CLC 
    RTL 

  GetPlayerFacingNone:
    PLP 
    SEC 
    RTL 
}
---------------------------------------------

; Mirrors an actor horizontally.
; 
; When: ChooseFacingAnim (lib_menus) when an actor turns toward the player and needs the side view the other way round.
; Sees: the actor's sprite is drawn flipped.
; Why: the side animations exist only once; the flip bit makes the second direction.
; In: JSL; X = actor.
; Out: bit $4000 of the actor's $1C word toggled. P restored.
; Clobbers: A.

FlipActorX {
    PHP 
    REP #$20
    LDA $001C, X
    EOR #$4000            ; bit $4000 of $1C is the horizontal flip flag
    STA $001C, X
    PLP 
    RTL 
}