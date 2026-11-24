; Player death check, held-until-released actors, the Soul of Shield sweep and the boss map patch (file offsets 12293-12716, SNES $00:B005-$B1AC, bank 00).
; 
; === DEATH CHECK ===
; CheckPlayerDeath runs every frame from RunMainLoop. While the player actor is not yet dying ($16 bit $0400 clear) and player_hp and heal_pending are both 0 it tests three equipped items in this order (Cop19 reads the inventory entry id, bit 7 = equipped, OQ-I006-2): Medical Herb ($38): heal_pending = player_max_hp, the entry is removed (Cop0B) and the player lives. Strange Bottle ($39): the entry is removed and the player dies with his Gems. Magic Bell ($40): not removed, the player dies with his Gems (OQ-I006-1: the walkthrough says the Bottle keeps the Gems and says nothing about the Bell). No item: gems_low and gems_high = 0 and the player dies. 'Dies' is MarkPlayerDead: $16 bit $0400 set and $0800 cleared, joy_block_mask = $2080 (Select/X and A), player_died + 1; the player's own script then runs PlayPlayerDeath (player_core).
; 
; === HELD ACTORS ===
; HoldActorUntilReleased is the tail of about a dozen NPC and object scripts (entered by an RTS trick pushed by the actor): the actor blocks its own tiles (COP 15), plays animation 0D and waits until the release switch of its lair record (+$1E of LairRecords, record index in $34, bit array at $1ADE) is set. Then it frees its tiles (COP 16), sets the bits in the arrays at $1A9E and $1ADE, clears bit $40 of lair_state[$34] and becomes the actor of its meta entry (animation, banks, flags, script, SetActorAnimFrame). The walkthrough's 'the switch beneath the lair releases the old woman / the tool shop owner' is this routine.
; 
; === SOUL OF SHIELD ===
; DestroyHazardsNearOrb is spawned by lib_hdma_window_effects (souls_flags bit $0004, the Soul of Shield per OQ-I006-10) with flags $2010 and runs every frame: every actor whose $16 is exactly $0301 inside a box of +-$30 pixels around soul_orb_actor gets the script RunHazardPuff and a $14 of 0, so it bursts. The walkthrough says the Shield soul protects from the magma bombs on Durean (the link between the $0301 actors and those bombs is inferred).
; 
; === BOSS MAP PATCH ===
; RunBossMapPatch is spawned (COP 85) by five boss scripts (gv_boss_metal_mantis, gw_boss_light_water_fire_statues, ms_boss_poseidon, ll_boss_tin_doll, we_deathtolls_shrine_actors), which set the patch id (0-4) in $30 of the new actor. It blocks all buttons (joy_block_mask = $FFFF), waits one frame, then ApplyBossMapPatch waits for an empty VRAM write queue, plays BRK #$83, calls lib_map_tile_patches.ApplyMapPatchRect with the id and ReleaseInputAndKill clears the mask and ends the actor. Whether the patch closes or opens the boss room is OQ-I024-3.
---------------------------------------------

?BANK 00

?INCLUDE 'data_lair_records'
?INCLUDE 'engine_actor_scheduler_and_sprites'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_bit_array'
?INCLUDE 'lib_map_tile_patches'
?INCLUDE 'WorldMetaPointers'

!joy_block_mask                 0326
!player_actor                   039C
!soul_orb_actor                 03A0
!heal_pending                   043B
!player_died                    043F
!actor_list_tail                06A6
!gems_low                       1B66
!gems_high                      1B68
!player_hp                      1B88
!player_max_hp                  1B8A
!vram_write_queue               1C7B
!lair_state                     7F0203

---------------------------------------------

; Decides what happens when the player's HP hits zero.
; 
; When: every frame in RunMainLoop (JSL after the hit and contact tests).
; Sees: the Medical Herb is used up and the player is healed, or the player dies and the Gems are lost (or kept with the Strange Bottle and Magic Bell equipped).
; Why: the death items need a single place that runs after all damage of the frame.
; In: player_actor, player_hp, heal_pending. M becomes 16.
; Out: see the block note: heal_pending, inventory entries, gems_low/high, player $16 bit $0400, joy_block_mask, player_died.
; Clobbers: A, X; P restored.

CheckPlayerDeath {
    PHP 
    REP #$20
    LDX $player_actor
    LDA $0016, X
    BIT #$0400            ; $16 bit $0400 = already dying: do nothing
    BNE loc_00305D
    LDA $player_hp        ; Dead only when player_hp is 0 and no healing is pending (heal_pending)
    ORA $heal_pending
    BNE loc_00305D
    COP [19] ( #38, &TryStrangeBottle ) ; Cop19: inventory entry $38 (Medical Herb) must be equipped (bit 7); if not, jump to TryStrangeBottle
    LDA $player_max_hp
    STA $heal_pending     ; Herb: heal_pending = player_max_hp (a full heal); Cop0B below removes the Herb
    COP [0B] ( #38 )
    BRA loc_00305D
}

---------------------------------------------
; Second test of CheckPlayerDeath: with the Strange Bottle ($39) equipped (Cop19) the entry is removed (Cop0B) and the player dies with his Gems (BRA MarkPlayerDead); otherwise it goes on to TryMagicBell. OQ-I006-1.

TryStrangeBottle {
    COP [19] ( #39, &TryMagicBell )
    COP [0B] ( #39 )      ; Strange Bottle is used up, but the player still dies (with his Gems, OQ-I006-1)
    BRA MarkPlayerDead
}

---------------------------------------------
; Third test of CheckPlayerDeath: with the Magic Bell ($40) equipped (Cop19) the player dies with his Gems and the Bell stays (BRA MarkPlayerDead); otherwise it falls into ZeroGemsAndDie. OQ-I006-1, OQ-I006-2.

TryMagicBell {
    COP [19] ( #40, &ZeroGemsAndDie )
    BRA MarkPlayerDead
}

---------------------------------------------
; Death without protection: all Gems are lost.
; 
; When: no Herb, Bottle or Bell equipped when HP reaches 0.
; Sees: the Gem counter drops to 0 and the player dies.
; Why: the game's death penalty.
; In: X = player actor. Out: gems_low = gems_high = 0, then MarkPlayerDead. Clobbers: A.

ZeroGemsAndDie {
    STZ $gems_low         ; No death item: all Gems lost
    STZ $gems_high

; Puts the player actor X into the dying state: $16 bit $0800 cleared and bit $0400 set, joy_block_mask = $2080 (Select/X and A blocked) and player_died + 1. The player script reaches PlayPlayerDeath at its next main-loop pass. Ends with PLP and RTL.

  MarkPlayerDead:
    LDA $0016, X
    AND #$F7FF
    STA $0016, X
    LDA $0016, X
    ORA #$0400
    STA $0016, X
    LDA #$2080            ; $2080 = Select/X (menu) and A; these buttons are blocked while the player dies
    STA $joy_block_mask
    INC $player_died

  loc_00305D:
    PLP 
    RTL 
}
---------------------------------------------

; Keeps an NPC or object frozen until its release switch is set, then turns it into its real self.
; 
; When: tail-jumped (RTS trick) by about a dozen scene actors after they tested that they are not yet free.
; Sees: a shut-in villager, tulip or tool shop owner stands there; when the player clears the lair that frees it (the walkthrough: 'the switch beneath the lair will release ...') it starts its normal behaviour and dialogue.
; Why: the same script holds every released-by-a-lair actor; the record in LairRecords says which switch frees it.
; In: X = actor, $34 = lair record index, $38 = its meta entry.
; Out: while held: animation 0D and the actor's own tiles blocked; when released: tiles freed, the switch bits stored, lair_state[$34] bit $40 cleared, and the meta entry (+5, +A, +D, +6 and $DFFF, +8, +B) applied; $30, $20, $14, $04, $06 = 0.
; Clobbers: A, Y.

HoldActorUntilReleased {
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    LDA $0016, X
    AND #$DFF7
    STA $0016, X
    COP [A8] ( #$8000, #0E )
    LDA $001C, X
    STA $0032, X
    AND #$FEFF
    STA $001C, X
    COP [15]              ; Block the actor's own tiles while it is held (Cop15_BlockOwnTiles)

  loc_003084:
    COP [80] ( #0D )
    COP [82]
    LDA $0034, X
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAY 
    LDA $&data_lair_records.LairRecords+1E, Y ; Release switch word of the lair record $34 (bit index in the array at $1ADE)
    LDY #$1ADE
    JSL $@lib_bit_array.TestBitInArray ; Test that bit: carry clear = not released yet, keep waiting at loc_003084
    BCC loc_003084
    COP [16]              ; Released: free the tiles (Cop16_UnblockOwnTiles)
    LDA $0034, X
    LDY #$1A9E
    JSL $@lib_bit_array.SetBitInArray
    LDY #$1ADE
    JSL $@lib_bit_array.SetBitInArray
    PHX 
    TAX 
    LDA $lair_state, X
    AND #$FFBF            ; Clear bit $40 of lair_state[$34] (16-bit access)
    STA $lair_state, X
    PLX 
    COP [A8] ( #$3800, #7E )
    LDA $0032, X
    STA $001C, X
    LDY $0038, X
    SEP #$20
    LDA $&WorldMetaPointers+5, Y ; The actor is rebuilt from its meta entry (+5 animation, +A bank, +D script bank, +6 flags, +8 table, +B script), like LoadMonsterFromMeta
    STA $001E, X
    LDA $&WorldMetaPointers+A, Y
    STA $0024, X
    LDA $&WorldMetaPointers+D, Y
    STA $0036, X
    REP #$20
    LDA $&WorldMetaPointers+6, Y
    ORA #$8000
    AND #$DFFF
    STA $0016, X
    LDA $&WorldMetaPointers+8, Y
    STA $0022, X
    LDA $&WorldMetaPointers+B, Y
    STA $0018, X
    STZ $0030, X
    STZ $0020, X
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    STZ $0014, X
    STZ $0004, X
    STZ $0006, X
    RTL 
}

---------------------------------------------
; Soul of Shield: bursts every hazard near the orb.
; 
; When: spawned once by lib_hdma_window_effects when souls_flags bit $0004 is set; runs every frame afterwards.
; Sees: hazards near the player (the walkthrough names the magma bombs of Durean) pop in a puff instead of hurting him.
; Why: the Shield soul's protection is implemented by removing the hazard.
; In: soul_orb_actor. Box = orb position +-$30 (clamped at 0), $16/$18 = top left, $1A/$1C = size.
; Out: every actor in the list with $16 = $0301 inside the box gets script RunHazardPuff (bank in $36) and $14 = 0.
; Clobbers: A, dp$16-$1C; X preserved (PHX/PLX).

DestroyHazardsNearOrb {
    PHX 
    LDX $soul_orb_actor   ; Box of +-$30 pixels around the orb (left and top clamped at 0): $16/$18 = top left, $1A/$1C = width and height
    LDA $0000, X
    SEC 
    SBC #$0030
    BPL loc_00311F
    LDA #$0000

  loc_00311F:
    STA $16
    LDA $0000, X
    CLC 
    ADC #$0030
    SEC 
    SBC $16
    STA $1A
    BMI loc_003186
    LDA $0002, X
    SEC 
    SBC #$0030
    BPL loc_00313B
    LDA #$0000

  loc_00313B:
    STA $18
    LDA $0002, X
    CLC 
    ADC #$0030
    SEC 
    SBC $18
    STA $1C
    BMI loc_003186
    LDA $actor_list_tail
    BRA loc_003153

  loc_003150:
    LDA $003E, X

  loc_003153:
    TAX 
    BEQ loc_003186
    LDA $0016, X
    CMP #$0301            ; Only actors whose $16 is exactly $0301 are hit
    BNE loc_003150
    LDA $0000, X
    SEC 
    SBC $16
    CMP $1A
    BCS loc_003150
    LDA $0002, X
    SEC 
    SBC $18
    CMP $1C
    BCS loc_003150
    SEP #$20
    LDA #$^engine_spawn_lairs_death_drops.RunHazardPuff
    STA $0036, X
    REP #$20
    LDA #$&engine_spawn_lairs_death_drops.RunHazardPuff ; Replace the actor's script by RunHazardPuff; $14 = 0 below makes it run on the next frame
    STA $0018, X
    STZ $0014, X
    BRA loc_003150

  loc_003186:
    PLX 
    RTL 
}

---------------------------------------------
; Blocks the buttons while a boss room's map is patched.
; 
; When: spawned by five boss scripts at the start of the fight (OQ-I024-3).
; Sees: the map around the boss room changes; the player cannot move during the change.
; Why: the change needs the VRAM queue empty and no input.
; In: X = the patch actor, $30 = patch id 0-4 (set by the boss). Out: joy_block_mask = $FFFF, then COP 1B waits one frame and continues at ApplyBossMapPatch.
; Clobbers: A.

RunBossMapPatch {
    LDA #$FFFF
    STA $joy_block_mask   ; All buttons blocked while the map changes
    COP [1B] ( &ApplyBossMapPatch, #$0001 ) ; Wait one frame, then continue at ApplyBossMapPatch
}

---------------------------------------------
; Second step of RunBossMapPatch: waits (RTL) while the VRAM write queue is not empty, then BRK #$83 and lib_map_tile_patches.ApplyMapPatchRect with A = the patch id ($30); COP 27 continues at ReleaseInputAndKill.

ApplyBossMapPatch {
    LDA $vram_write_queue ; Wait for an empty VRAM write queue before the map patch
    BEQ loc_00319A
    RTL 

  loc_00319A:
    BRK #$83
    LDA $0030, X          ; $30 = patch id 0-4 (written by the boss script right after the COP 85 spawn)
    JSL $@lib_map_tile_patches.ApplyMapPatchRect ; Patch the map with id A (lib_map_tile_patches)
    COP [27] ( &ReleaseInputAndKill )
}

---------------------------------------------
; Last step of RunBossMapPatch: joy_block_mask = 0 (the player may move again) and the patch actor ends (COP 86).

ReleaseInputAndKill {
    STZ $joy_block_mask
    COP [86]
    RTL 
}