; Actor spawning, then lair, death and drop scripts (file offsets 4783-5393 are batch A1, SNES $00:92AF-$94D1; the scripts from RunLairRespawn on are batch A2 (SNES $00:A6F3 on) and are described in the sections below; the music-load actor MusicLoadSendFade .. MusicLoadFinish and RespawnOrKillActor (file offsets 11419-11622, SNES $00:AC9B-$AD66) are batch A3, see MUSIC LOAD AND RESPAWN at the end).
; 
; === SPAWN PIPELINE (A1 part) ===
; Scene load (the scene loader) calls InitActorPool (free-slot stack and pool cleared) and SpawnSceneActors, then the lair code spawns the lair actors. SpawnSceneActors reads world_index ($03BA) and sets $03B0 = offset of the world's meta list inside WorldMetaPointers (the table starts with one list pointer per world, seven in all); it finds the first 4-byte record of ScenePlacementIndex whose area and scene match (the table ends at a first byte of $80 or more) and calls SpawnPlacementList once.
; SpawnPlacementList reads 4-byte placement records (bank $01) until a $FF record, allocates an actor for each (PopFreeSlot), links it as the new head and calls InitActorFromPlacement. The actor with $16 bit $0080 is the player: it is placed at warp_dest_x and warp_dest_y + 16 when they are non-zero (anim warp_dest_anim), warp_dest_* are cleared, and player_tile_x/y, player_x/y and player_actor are set.
; 
; === STRUCTURES ===
; Placement record (4 bytes, bank $01): x tile, y tile, flags byte (bits 7 and 6 flip Y and X, bit 0 passes to $1C as $0100), meta type. Position = tile x 16, tile y x 16 + 16.
; Meta entry (14 bytes at WorldMetaPointers + $03B0 + type x 14): +0 attack, +1 defence, +2 HP, +3 word EXP, +5 animation id, +6 word flags (becomes $16, $8000 added at spawn), +8 word animation table, +A data bank, +B word script, +D script bank.
; Lair record (32 bytes in LairRecords, see its note): used by SpawnLairActor: +$C x tile, +$D y tile, +$10 script word, +$12 script bank, +$13 monster count (initial lair state), +$14 spawn interval or formation index, +$15 meta type, +$16 attribute word.
; 
; === NOTES ===
; - Names: the lair actor (SpawnLairActor) is the invisible object that runs the lair script and counts the monsters left in $2E and $2F; the monsters it spawns are made by the scripts that follow (batch A2).
; - A Monster Lair in the walkthrough loses its shield when its monsters are dead and shows a green switch; the tile $FE written by the lair code is that switch (see lib_map_tile_patches).
; 
; === LAIR SCRIPTS (A2) ===
; A lair actor (SpawnLairActor) runs one of six scripts, chosen by the script word of its record (+$10 of LairRecords; the reference counts in OQ-I006-5). All six start with RequireLairTile (the script only runs while the map byte under the lair is $FD, an intact lair, OQ-I006-23), then repeat: COP 91 (entry), wait while the lair is off screen ($16 bit $8000, set by CullAndSortActors), wait while no free actor slot exists (COP 27 retries next frame), BRK #$53, SpawnLairMonster, DelayBetweenSpawns, and SyncLairCount (each frame it compares the monsters left, $2E, with the last value seen, $2F). When $2E reaches 0, SealLair writes tile $FE (the green switch), plays an effect and ends the lair actor.
;   RunLairRespawn (156 records): one monster alive at a time; every death makes the lair spawn the next one until $2E is 0. The walkthrough's lairs that 'spit out one at a time'.
;   RunLairSpawnAll (139 records): spawns all $2E monsters one after the other (counter in $2C), then only waits for the deaths.
;   RunLairFormation (107 records): spawns all monsters at once from a formation list in FormationPointers (index in $26: x, y and flip bits per monster); the monsters skip the appear puff.
;   RunLairSpawnAllFlipping (7 records) and RunLairRespawnFlipping (no record, OQ-I006-5): the same patterns, but the lair's flip bits ($1C) step by $4000 after every monster so they alternate orientation.
;   RunLairProximity (8 records): waits until the Cop0C test succeeds, spawns one monster, waits for its death, then waits again.
; A monster made by SpawnLairMonster starts in RunMonsterAppearPuff (puff, then LoadMonsterFromMeta) and keeps the lair slot in $32; when it dies NotifyLairOfDeath decrements the lair's $2E. lair_state ($7F0203 + lair index) keeps the monster count between scene changes and is set to 0 only when the lair is cleared, so a half-cleared lair starts again with its full count (SyncLairCount).
; 
; === EFFECT PUFFS (A2) ===
; RunAppearPuff is the generic 'actor appears' puff, spawned with COP 85 by about 150 scene actor scripts in 137 files; it centres itself on the spawner's box and plays animation 02 of the effects bank ($0E, set by COP A8 #$8000, #0E), or just ends when scene_active is 0. RunHazardPuff replaces the script of a hazard (DestroyHazardsNearOrb) by animation $10 and removal. RunMonsterAppearPuff is the lair monster's first script.
; 
; === ENEMY DEATH AND DROPS (A2) ===
; KillTarget and KillOrSpareProjectileTarget (combat) give a killed actor the script RunEnemyDeath. The boss (boss_actor) is diverted to RunBossDeath. For anything else RunEnemyDeath plays the death puff (animation 03), spawns a Gem pickup before itself and shows the EXP earned:
;   Drop: w = world_index (world 6 counts as $19). random_mod_result = a random number below $64. t1 = 2w + 1 and t2 = 4w + 4, both doubled when equipped_weapon is 4 (the Lucky Blade; the walkthrough says it yields more Gems than usual, OQ-I006-9). Below t1: RunLargeGemPickup (10 Gems); below t2: RunMediumGemPickup (5 Gems); otherwise RunSmallGemPickup (1 Gem). The pickup is spawned with $16 flags $4000; ApplyContactDamageOrPickup calls ApplyGemPickup when the player touches it.
;   EXP number: the BCD word at +3 of the meta entry is drawn as 1-4 digit sprites (the value picks the digit count: below $10, $100, $1000, or more) in a sprite map reached through the pointer table at $7EF000 (slot number x 2); WriteHighNibbleDigit and WriteLowNibbleDigit write the digit tile (ExpDigitTiles) at $7EF005 + X in steps of 7, and the number's x is shifted by +5, +3, +1 or -1 so it stays centred. After $10 frames FinishEnemyDeath runs: with a lair ($32 non-zero) NotifyLairOfDeath counts the death and ends the actor; without one the A3 code at RespawnOrKillActor kills the actor or, when $1A bit $1000 is set, respawns it after $0258 + 1 frames spent off screen.
; 
; === BOSS DEATH AND ENDING (A2) ===
; RunBossDeath: $16 = $0700, velocities cleared, contact_lock + 1, the boss box is stored in boss_box_x/y/w/h (position minus the left and upper extents, width and height = the sums of the extents). Then 32 RunBossExplosion actors are spawned, 3 frames apart (COP 03/04 loop); each is placed at a random point inside the box and about half of them play BRK #$85. KillAllOtherActors removes every actor whose $16 has none of the bits $24D0 (the player group and the dying actors stay). At location_id $7D the script jumps (RTS trick) into RunEnding; elsewhere Cop31 spawns the A3 sound handshake actor (MusicLoadSendFade) and the boss ends through FinishEnemyDeath.
; RunEnding (SNES $00:D354): shows EndingTextDefeated, then EndingTextStaySingular when souls_flags and $1F is exactly 1 (only the Magician soul, OQ-I006-10) or EndingTextStayPlural otherwise (the singular text jumps into the plural one with [JMP]), clears souls_flags, waits, shows EndingTextWorldFades while RunEndingEffect runs, sets an event flag (COP 09 operand $9F02), writes text_delay ($1B84) = 6 and $031E = 1 and warps with Cop10 to scene 7 of area 0 (OQ-I006-11). KillAllProjectiles is used by the menu code (lib_menus) when the equipped magic changed.
; 
; === PICKUPS (A2) ===
; RunSmallGemPickup, RunMediumGemPickup and RunLargeGemPickup play animation 04, 05 or 06, then animation 09, 0A or 0B for a count of 4 (COP 81/83) and remove themselves, so an uncollected Gem disappears. ApplyGemPickup reads the current animation id ($1E): 06 and 0B give 10 Gems, 05 and 0A give 5, 04 and 09 give 1, any other id gives 10 (RunFixedGemPickup, a never-ending pickup with animation 07 spawned by gw_actor_fixed_gem_pickup, OQ-I006-8). The Gems are added in BCD to gems_low and gems_high by lib_player_helpers.AddGems and BRK #$4D is requested.
; 
; === MUSIC LOAD AND RESPAWN (A3) ===
; Music load. Cop31 (FadeAndLoadMusic) and Cop32 (StopAndLoadMusic) spawn an actor whose script is the chain below; $30 of that actor is the track number, an index into MusicPointerTable of data_engine_tables (21 long pointers, 3 bytes each). Every step ends with COP 27 or COP 1B, so the steps are one or more frames apart and the game keeps running between them. APUIO0 ($2140) is the CPU-to-SPC port; the command meanings come from docs/audio/spc-disassembly.md (DispatchCommand).
;   MusicLoadSendFade: writes $F1 (the SPC's HandleFadeIn handler in that document) and waits (MusicLoadWaitFadeAck) until APUIO0 reads $F1 back, answers with $01 and waits (MusicLoadWaitSilence) until the port reads 0.
;   MusicLoadSendStop (Cop32 starts here): writes $F0 (StopAllChannels) and waits (MusicLoadWaitStopped) until the port reads 0, then COP 1B waits 2 frames.
;   MusicLoadUpload: writes $FF (the SPC's boot handshake handler), copies MusicPointerTable[$30] to dp$29-$2B and $0422/$0424, waits for vblank, switches NMI off (lib_system_helpers.DisableNmi), runs engine_spc_ipl_upload.UploadSpcStream (the song data goes through the IPL transfer), waits for vblank and switches NMI on again (EnableNmi); COP 1B waits 2 frames.
;   MusicLoadFinish: writes $01, clears boss_fight_active ($0458, incremented by the boss scripts when the fight starts and read by the switch-tile code in lib_tile_triggers_and_lair_return) and kills the actor (COP 86). The $F1 / $01 / 0 sequence is explained from the SPC side in docs/code/spc-interface.md (OQ-I025-2): $F1 starts a fade-out, the echo $F1 confirms it, the $01 replaces the command because the SPC runs a command of $F0 or more on every tick, and the port reads 0 when the fade has ended; the track numbers used are listed in cop_script_flow_flags (OQ-I025-3).
; Respawn. RespawnOrKillActor is the tail of FinishEnemyDeath for enemies without a lair: with $1A bit $1000 clear the actor is killed (COP 86); with it set the actor stays dead until it has been off screen ($16 bit $8000) for $0258 + 1 frames ($26 counts down; on screen the count waits), then InitActorFromPlacement re-creates it in the same slot from its placement record ($3A). No code in extracted/ sets $1A bit $1000, so by static reading the respawn branch is never taken (OQ-I044-6).
---------------------------------------------

?BANK 00

?INCLUDE 'cop_core'
?INCLUDE 'data_engine_tables'
?INCLUDE 'data_lair_formations'
?INCLUDE 'data_lair_records'
?INCLUDE 'data_scene_placements'
?INCLUDE 'engine_actor_scheduler_and_sprites'
?INCLUDE 'engine_spc_ipl_upload'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'lib_map_tile_patches'
?INCLUDE 'lib_player_helpers'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'WorldMetaPointers'

!rng_state                      0301
!area_current                   0314
!scene_current                  0316
!scene_variant                  031E
!scene_active                   032E
!hud_dirty_flags                0332
!scene_sprite_attr              0372
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!boss_actor                     039A
!player_actor                   039C
!meta_table_offset              03B0
!world_index                    03BA
!asset_cache_music              0422
!boss_box_x                     0425
!boss_box_y                     0427
!boss_box_w                     0429
!boss_box_h                     042B
!contact_lock                   042D
!random_mod_result              0437
!boss_fight_active              0458
!actor_list_tail                06A6
!actor_list_head                06A8
!equipped_weapon                1B5E
!souls_flags                    1B82
!text_delay                     1B84
!location_id                    1C6A
!vram_write_queue               1C7B
!APUIO0                         2140
!lair_state                     7F0203

---------------------------------------------

; Resets the actor pool: free-slot stack, list tail and all slots.
; 
; When: once per scene load (the scene loader).
; Sees: nothing directly; every actor of the old scene is gone.
; Why: each scene starts with an empty pool.
; In: none.
; Out: $1800-$187F = the 64 slot addresses ($0800, $0840, ... $17C0); dp$4A = $1800; actor_list_tail = $0800; $0800-$17FF zeroed.
; Clobbers: A, X; P restored.

InitActorPool {
    PHP 
    REP #$20
    LDX #$1800            ; Free-slot stack at $1800-$187F: 64 words, one slot address each ($0800 + n x $40); dp$4A points to it
    STX $4A
    LDA #$0800

  FillFreeSlotStack:
    STA $0000, X
    INX 
    INX 
    CLC 
    ADC #$0040
    CPX #$1880
    BNE FillFreeSlotStack
    LDX #$0800
    STX $actor_list_tail
    LDA #$0000
    TAX 

  ClearActorPoolLoop:
    STA $0800, X
    INX 
    INX 
    CPX #$1000
    BNE ClearActorPoolLoop
    PLP 
    RTL 
}

---------------------------------------------
; Finds the actor placement list of the current scene and spawns it.
; 
; When: once per scene load, after InitActorPool.
; Sees: the monsters, NPCs, chests and the player of the new scene appear.
; Why: every scene's actors are listed in ScenePlacementIndex by area and scene.
; In: area_current, scene_current, world_index ($03BA).
; Out: $03B0 = offset of the world's meta list in WorldMetaPointers; SpawnPlacementList called for the first matching record.
; Clobbers: A, X; P restored.

SpawnSceneActors {
    PHP 
    REP #$20
    LDA $world_index
    ASL 
    TAX 
    LDA $&WorldMetaPointers, X ; WorldMetaPointers starts with one list pointer per world (indexed by world_index, $03BA)
    SEC 
    SBC #$&WorldMetaPointers
    STA $meta_table_offset
    SEP #$20
    LDX #$0000

  FindPlacementIndexRow:
    LDA $&data_scene_placements.ScenePlacementIndex, X ; ScenePlacementIndex: 4-byte records (area, scene, pointer to the placement list); a first byte of $80 or more ends the table
    BMI SpawnSceneActorsDone
    CMP $area_current
    BNE NextPlacementIndexRow
    LDA $&data_scene_placements.ScenePlacementIndex+1, X
    CMP $scene_current
    BNE NextPlacementIndexRow
    JSR $&SpawnPlacementList
    BRA SpawnSceneActorsDone

  NextPlacementIndexRow:
    INX 
    INX 
    INX 
    INX 
    BRA FindPlacementIndexRow

  SpawnSceneActorsDone:
    PLP 
    RTL 
}

---------------------------------------------
; Creates one actor per 4-byte placement record and places the player.
; 
; When: from SpawnSceneActors, once per scene.
; Sees: the scene's population.
; Why: records carry only position, flags and a meta type; this expands them.
; In: X = offset of the ScenePlacementIndex record (M = 1 on entry).
; Out: dp$29-$2B = long pointer to the placement records (bank $01); each actor allocated, linked as new head ($3E of the old head, $3C of the new one), record pointer in $3A, filled by InitActorFromPlacement; ends at the $FF record. Player: position from warp_dest_x and warp_dest_y + 16 when non-zero, animation from warp_dest_anim, warp_dest cleared, player_tile_x/y, player_x/y, player_actor set; actor_list_head set for each new actor.
; Clobbers: A, X, Y; dp$29-$2B.

SpawnPlacementList {
    LDA #$01
    STA $2B               ; dp$29-$2B = long pointer to the placement records (bank $01)
    REP #$20
    LDA $&data_scene_placements.ScenePlacementIndex+2, X
    STA $29
    JSL $@cop_core.PopFreeSlot
    BRA InitPlacementActor

; Reads the next placement record byte: $FF ends the list (RTS); otherwise allocates the next actor and links it in front of the previous one.

  NextPlacement:
    LDA [$29]
    AND #$00FF
    CMP #$00FF
    BNE LinkPlacementActor
    RTS 

  LinkPlacementActor:
    JSL $@cop_core.PopFreeSlot
    TYA 
    STA $003E, X          ; Link: the old actor's $3E = new slot (toward the head), the new actor's $3C = old (toward the tail)
    TXA 
    STA $003C, Y

  InitPlacementActor:
    STY $actor_list_head
    TYX 
    LDA $29
    STA $003A, X
    CLC 
    ADC #$0004
    STA $29
    JSL $@InitActorFromPlacement
    LDA $0016, X
    BIT #$0080            ; $16 bit $0080: the player's record
    BEQ NextPlacement
    LDA $warp_dest_x
    ORA $warp_dest_y      ; warp_dest_x and warp_dest_y both 0: keep the placement position
    BEQ PublishPlayerPosition
    LDA $warp_dest_x
    STA $0000, X
    LDA $warp_dest_y
    CLC 
    ADC #$0010            ; +16, as in InitActorFromPlacement (position y = tile y x 16 + 16)
    STA $0002, X
    LDA $warp_dest_anim
    STA $001E, X
    STZ $0020, X
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    STZ $0014, X
    LDA $warp_dest_x
    STZ $warp_dest_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $warp_dest_y
    STZ $warp_dest_y
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_y

  PublishPlayerPosition:
    LDA $0000, X
    STA $player_x
    LDA $0002, X
    STA $player_y
    STX $player_actor
    BRL NextPlacement
}

---------------------------------------------
; Fills a new actor from its placement record and its meta entry.
; 
; When: once per placed actor (SpawnPlacementList, and RespawnOrKillActor when a killed enemy comes back).
; Sees: the actor starts with the right position, graphics, HP and script.
; Why: the meta entry holds the per-monster-type data (attack, defence, HP, EXP, animation, script).
; In: X = new slot, $3A,X = record pointer in bank $01.
; Out: position = tile x 16 and tile y x 16 + 16; $1C = record bits ($C100) or scene_sprite_attr (the word stored at $0372: the scene's sprite priority); meta entry = $03B0 + type x 14: $38 pointer, $25 HP (+2), $1E animation (+5), $24 bank (+A), $36 script bank (+D), $16 flags (+6) or $8000, $22 animation table (+8), $18 script (+B); extents from SetActorAnimFrame, or a 16x16 box for actors with $16 bit $2000 and not $0040; $14, $04, $06 = 0.
; Clobbers: A, X (= slot on return), Y.

InitActorFromPlacement {
    TXY 
    LDX $003A, Y
    LDA $010000, X        ; Placement record (bank $01): x tile, y tile, flags byte, meta type
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $0000, Y
    LDA $010001, X
    PHA 
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$0010
    STA $0002, Y
    PLA 
    AND #$C100            ; Flags word: $C000 (flips) and $0100 pass to $1C; scene_sprite_attr (the word at $0372, the scene's sprite priority) is ORed in
    ORA $scene_sprite_attr
    STA $001C, Y
    SEP #$20
    LDA $010003, X
    XBA 
    LDA #$0E
    JSL $@lib_arithmetic.Multiply8x8 ; type x 14: entry size of WorldMetaPointers; $03B0 (list offset of this world) is added next
    REP #$20
    CLC 
    ADC $meta_table_offset
    TAX 
    STA $0038, Y
    SEP #$20
    LDA $&WorldMetaPointers+2, X
    STA $0025, Y
    LDA $&WorldMetaPointers+5, X
    STA $001E, Y
    LDA $&WorldMetaPointers+A, X
    STA $0024, Y
    LDA $&WorldMetaPointers+D, X
    STA $0036, Y
    REP #$20
    LDA $&WorldMetaPointers+6, X
    ORA #$8000            ; $8000 set: the actor starts flagged off screen until the first CullAndSortActors
    STA $0016, Y
    LDA $&WorldMetaPointers+8, X
    STA $0022, Y
    LDA $&WorldMetaPointers+B, X
    STA $0018, Y
    TYX 
    LDA $0016, X
    BIT #$0040
    BNE PlacementAnimFrame
    BIT #$2000
    BEQ PlacementAnimFrame
    LDA #$0010            ; Hidden actors without $0040: no animation, a 16x16 default box (size and extents set directly)
    STA $000C, X
    STA $000A, X
    STZ $0008, X
    STZ $000E, X
    BRA PlacementClearMotion

  PlacementAnimFrame:
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame

  PlacementClearMotion:
    STZ $0014, X
    STZ $0004, X
    STZ $0006, X
    RTL 
}

---------------------------------------------
; Creates the actor of one Monster Lair.
; 
; When: at scene load, for every lair of the location whose state byte is positive (monsters left).
; Sees: nothing by itself (the actor is hidden); its script releases the lair's monsters, and when they are all dead the lair opens (green switch).
; Why: a lair is a script actor with a monster counter: lair_state survives scene changes and the actor is rebuilt from it.
; In: X = lair index (byte table $7F0203), Y = lair record offset in LairRecords (32 bytes per record).
; Out: new actor allocated before the head (SpawnActorBefore), $16 = $A000 (off screen and hidden), $34 = lair index, position (+$C x 16, (+$D + 1) x 16), $1C and $30 = (+$16 or $0100 or scene_sprite_attr, the word stored at $0372), script $18 (+$10) and $36 (+$12), $2E and $2F = lair state byte, $26 = +$14, meta entry from +$15 ($38, $25, $1E, $24, $22), size and extents 16, $32 = 0.
; Clobbers: A, X, Y restored; P restored.

SpawnLairActor {
    PHP 
    PHX 
    PHY 
    REP #$20
    PHX 
    LDA $lair_state, X    ; State byte of this lair ($7F0203 + lair index), copied to $2E and $2F below
    STA $00
    LDA $&data_lair_records.LairRecords+C, Y ; Position from the lair record: x = +$C tile x 16, y = (+$D tile + 1) x 16
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_lair_records.LairRecords+D, Y
    AND #$00FF
    INC 
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    TYX 
    PHX 
    LDX $actor_list_head
    JSR $&cop_core.SpawnActorBefore
    PLX 
    LDA #$A000            ; $16 = $A000: off screen and hidden; the lair actor is invisible and only runs its script
    STA $0016, Y
    PLA 
    STA $0034, Y          ; $34 = lair index
    LDA $16
    STA $0000, Y
    LDA $18
    STA $0002, Y
    LDA $&data_lair_records.LairRecords+16, X
    ORA #$0100
    ORA $scene_sprite_attr
    STA $001C, Y
    STA $0030, Y
    LDA $&data_lair_records.LairRecords+10, X ; Script address from lair record +$10, script bank from +$12
    STA $0018, Y
    SEP #$20
    LDA $&data_lair_records.LairRecords+12, X
    STA $0036, Y
    LDA $00
    STA $002E, Y          ; $2E and $2F = the state byte (monsters left); a child's death decrements $2E of the parent
    STA $002F, Y
    REP #$20
    LDA $&data_lair_records.LairRecords+14, X ; $26 = lair record +$14: spawn interval or formation index, used by the lair scripts
    AND #$00FF
    STA $0026, Y
    SEP #$20
    LDA $&data_lair_records.LairRecords+15, X ; Meta entry from lair record +$15 (type x 14 + $03B0): HP, animation, bank and table; extents are 16
    XBA 
    LDA #$0E
    JSL $@lib_arithmetic.Multiply8x8
    REP #$20
    CLC 
    ADC $meta_table_offset
    STA $0038, Y
    TAX 
    SEP #$20
    LDA $&WorldMetaPointers+2, X
    STA $0025, Y
    LDA $&WorldMetaPointers+5, X
    STA $001E, Y
    LDA $&WorldMetaPointers+A, X
    STA $0024, Y
    REP #$20
    LDA $&WorldMetaPointers+8, X
    STA $0022, Y
    LDA #$0010
    STA $0010, Y
    STA $0012, Y
    STA $000C, Y
    STA $000A, Y
    LDA #$0000
    STA $0008, Y
    STA $000E, Y
    STA $0032, Y
    PLY 
    PLX 
    PLP 
    RTL 
}
---------------------------------------------

; Lair script: one monster alive at a time, a new one whenever one dies.
; 
; When: the lair actor starts here when its record's script word points here (156 of the 417 lair records).
; Sees: a Monster Lair that spits out its monsters one by one (Grass Valley's lairs, walkthrough); when the last one dies the lair opens and a green switch appears.
; Why: each lair record picks a pattern; this one keeps the fight small and sequential.
; In: X = lair actor ($2E monsters left, $26 spawn interval, $34 lair index).
; Out: ends in SealLair; between monsters it waits at COP 91 (SyncLairCount polls once per frame).
; Clobbers: A, Y.

RunLairRespawn {
    JSR $&RequireLairTile

  loc_0026F6:
    COP [91]              ; Entry point: from here on the script resumes at the next instruction every frame (until the next COP 91)

; Re-entry point of RunLairRespawn after COP 91: yields while the lair is off screen ($16 bit $8000) and retries next frame while no actor slot is free (COP 27), then plays BRK #$53 and spawns.

  LairRespawnWaitSlot:
    LDA $0016, X
    BIT #$8000            ; $16 bit $8000 = off screen (set by CullAndSortActors): the lair waits, so nothing spawns where the player cannot see
    BEQ loc_002701
    RTL 

  loc_002701:
    LDA ($4A)             ; Free-slot stack top is 0: no free actor slot, retry next frame (COP 27)
    BNE loc_002709
    COP [27] ( &LairRespawnWaitSlot )

  loc_002709:
    BRK #$53              ; BRK #$53 has bit 6 set, so $0399 = $13: the sound played before each spawn (OQ-I024-1)
    JSR $&SpawnLairMonster
    JSR $&DelayBetweenSpawns
    COP [91]
    JSR $&SyncLairCount
    BCC loc_0026F6
    JMP $&SealLair
}
---------------------------------------------

; Lair script: spawns all of the lair's monsters in a row, then waits for their deaths.
; 
; When: lair records with this script word (139 records).
; Sees: a lair that sends out a whole group, with the interval of $26 between monsters.
; Why: used for lairs that should flood the area at once.
; In: X = lair actor ($2E monsters, $26 interval). The counter $2C overwrites the tile offset cached by RequireLairTile.
; Out: after the last spawn it polls SyncLairCount each frame and ends in SealLair when $2E reaches 0.
; Clobbers: A, Y.

RunLairSpawnAll {
    JSR $&RequireLairTile
    LDA $002E, X          ; $2C = monsters still to spawn (= $2E); overwrites the tile offset RequireLairTile cached in $2C
    AND #$00FF
    STA $002C, X

  loc_002727:
    COP [91]

; Re-entry point of RunLairSpawnAll: waits while off screen or while no actor slot is free, then spawns the next monster.

  LairSpawnAllWaitSlot:
    LDA $0016, X
    BIT #$8000
    BEQ loc_002732
    RTL 

  loc_002732:
    LDA ($4A)
    BNE loc_00273A
    COP [27] ( &LairSpawnAllWaitSlot )

  loc_00273A:
    BRK #$53
    JSR $&SpawnLairMonster
    JSR $&DelayBetweenSpawns
    DEC $002C, X          ; One monster spawned: the counter in $2C counts down to 0
    BNE loc_002727
    COP [91]
    JSR $&SyncLairCount
    BCS loc_00274F
    RTL 

  loc_00274F:
    JMP $&SealLair
}
---------------------------------------------

; Lair script: places all monsters at once at fixed positions from a formation list.
; 
; When: lair records with this script word (107 records).
; Sees: a group of monsters standing in a set pattern (some mirrored) the moment the lair is first run.
; Why: formations in FormationPointers give exact x, y and flip bits, which the timed scripts cannot.
; In: X = lair actor ($2E = number of monsters, $26 = index of the formation in the pointer table FormationPointers).
; Out: for each entry (x, y, flip bits as three words): SpawnLairMonster, then the monster's script is LoadMonsterFromMeta (no puff), x and y are stored and the flip bits ORed into $1C; then it polls SyncLairCount and ends in SealLair.
; Clobbers: A, Y, dp$00, $0C.

RunLairFormation {
    JSR $&RequireLairTile
    LDA $002E, X
    AND #$00FF
    STA $0C
    LDA $0026, X
    ASL 
    TAY 
    LDA $&data_lair_formations.FormationPointers, Y ; FormationPointers is a pointer table indexed by the formation number $26 (x2); dp$00 reads the entries
    STA $00

  loc_002767:
    JSR $&SpawnLairMonster
    LDA #$&LoadMonsterFromMeta ; Formation monsters skip the appear puff: they start directly in LoadMonsterFromMeta
    STA $0018, Y
    LDA ($00)             ; Formation entry (three words): x and y in pixels, then flip bits ORed into $1C
    INC $00
    INC $00
    STA $0000, Y
    LDA ($00)
    INC $00
    INC $00
    STA $0002, Y
    LDA $001C, Y
    AND #$3FFF
    ORA ($00)
    INC $00
    INC $00
    STA $001C, Y
    DEC $0C
    BNE loc_002767
    COP [91]
    JSR $&SyncLairCount
    BCS loc_00279D
    RTL 

  loc_00279D:
    JMP $&SealLair
}

---------------------------------------------
; Lair script: like RunLairRespawn, with the monster orientation alternating.
; 
; When: no lair record uses it (OQ-I006-5); dead or reached some other way.
; Sees: monsters that come out mirrored every other time.
; Why: unknown; the same pattern as RunLairSpawnAllFlipping.
; In: X = lair actor. Out: as RunLairRespawn; after every monster $1C += $4000. Clobbers: A, Y.

RunLairRespawnFlipping {
    JSR $&RequireLairTile

  loc_0027A3:
    COP [91]

; Re-entry point of RunLairRespawnFlipping: waits while off screen or while no actor slot is free.

  LairRespawnFlippingWaitSlot:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0027AE
    RTL 

  loc_0027AE:
    LDA ($4A)
    BNE loc_0027B6
    COP [27] ( &LairRespawnFlippingWaitSlot )

  loc_0027B6:
    BRK #$53
    JSR $&SpawnLairMonster
    LDA $001C, X
    CLC 
    ADC #$4000            ; Adding $4000 steps the two flip bits of $1C through all four combinations: the next monster is mirrored
    STA $001C, X
    JSR $&DelayBetweenSpawns
    COP [91]
    JSR $&SyncLairCount
    BCC loc_0027A3
    JMP $&SealLair
}
---------------------------------------------

; Lair script: like RunLairSpawnAll, with the monster orientation alternating.
; 
; When: lair records with this script word (7 records).
; Sees: a group whose monsters face alternating directions.
; Why: mirrors the group so it does not march in one direction only.
; In: X = lair actor ($2E monsters, counter in $2C). Out: as RunLairSpawnAll; after every monster $1C += $4000 (the two flip bits count through all four combinations). Clobbers: A, Y.

RunLairSpawnAllFlipping {
    JSR $&RequireLairTile
    LDA $002E, X
    AND #$00FF
    STA $002C, X

  loc_0027DE:
    COP [91]

; Re-entry point of RunLairSpawnAllFlipping: waits while off screen or while no actor slot is free.

  LairSpawnAllFlippingWaitSlot:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0027E9
    RTL 

  loc_0027E9:
    LDA ($4A)
    BNE loc_0027F1
    COP [27] ( &LairSpawnAllFlippingWaitSlot )

  loc_0027F1:
    BRK #$53
    JSR $&SpawnLairMonster
    LDA $001C, X
    CLC 
    ADC #$4000            ; Same flip step as in RunLairRespawnFlipping
    STA $001C, X
    JSR $&DelayBetweenSpawns
    DEC $002C, X
    BNE loc_0027DE
    COP [91]
    JSR $&SyncLairCount
    BCS loc_002810
    RTL 

  loc_002810:
    JMP $&SealLair
}
---------------------------------------------

; Lair script: spawns a monster only when the player is near.
; 
; When: lair records with this script word (8 records).
; Sees: a lair that stays quiet until the player steps into its box, then sends one monster, then waits again once it is dead.
; Why: lets a room stay empty until the player walks in.
; In: X = lair actor.
; Out: waits at LairProximityPoll (RTL when off screen); Cop0C success continues at LairProximitySpawn.
; Clobbers: A, Y.

RunLairProximity {
    JSR $&RequireLairTile

  loc_002816:
    COP [91]

; Poll point of RunLairProximity (re-entered after COP 91 every frame): off screen = wait; otherwise Cop0C_JumpIfActorInBox continues at LairProximitySpawn when its test succeeds and falls into RTL when it does not.

  LairProximityPoll:
    LDA $0016, X
    BIT #$8000
    BEQ loc_002821
    RTL 

  loc_002821:
    COP [0C] ( #00, #02, &LairProximitySpawn ) ; Cop0C_JumpIfActorInBox: continue at LairProximitySpawn when the test succeeds, otherwise RTL and poll again next frame
    RTL 
}

---------------------------------------------
; Spawns the monster of a proximity lair and loops back to the poll.
; 
; When: Cop0C succeeded in RunLairProximity.
; Sees: one monster comes out of the lair.
; Why: the box test moved the spawn out of the main loop.
; In: X = lair actor. Out: monster spawned (BRK #$53), COP 91; when SyncLairCount reports 0 left it ends in SealLair, otherwise it goes back to the poll. Clobbers: A, Y.

LairProximitySpawn {
    LDA ($4A)
    BNE loc_002830
    COP [27] ( &LairProximityPoll )

  loc_002830:
    BRK #$53
    JSR $&SpawnLairMonster
    JSR $&DelayBetweenSpawns
    COP [91]
    JSR $&SyncLairCount
    BCC loc_002816
    JMP $&SealLair
}

---------------------------------------------
; Lets a lair script run only while its lair tile is intact.
; 
; When: first call of every lair script.
; Sees: a cleared lair stays quiet when the player returns.
; Why: the scene reloads the lair actor from lair_state; the map tile is the second source of truth (tile $FD intact, $FE sealed, OQ-I006-23).
; In: X = lair actor. $2C caches the map offset of the lair tile (0 = not looked up).
; Out: returns (RTS) when the map byte at $7E8000 + offset is $FD; otherwise PLA drops the return address and RTL leaves the script, which is run again next frame.
; Clobbers: A, Y (= X), dp$16, $18 and the scratch of lib_map_index_helpers; X preserved.

RequireLairTile {
    TXY 
    LDA $002C, X          ; $2C caches the map offset of the lair tile (0 = not looked up yet)
    BNE loc_00285E
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    TXA 
    STA $002C, Y

  loc_00285E:
    LDX $002C, Y
    LDA $7E8000, X        ; Map byte under the lair: $FD = intact, the script runs only then (OQ-I006-23)
    TYX 
    AND #$00FF
    CMP #$00FD
    BEQ loc_002870
    PLA                   ; Not $FD: PLA drops the JSR return address and RTL leaves the script; it is run again next frame
    RTL 

  loc_002870:
    RTS 
}

---------------------------------------------
; Opens a cleared lair: the green switch appears and the lair actor vanishes.
; 
; When: the last monster of the lair died (SyncLairCount carry set).
; Sees: the lair's shield disappears in a puff with a sound and the green switch tile shows (walkthrough: 'the switch beneath the lair'). The switch then releases the NPC or opens the path.
; Why: lair_state is already 0, so the lair stays open after a scene change.
; In: X = lair actor (position $00, $02 - 16, record index $34).
; Out: waits until the VRAM write queue is empty; writes tile $FE at the lair position through lib_map_tile_patches.SetMetatileBg1Bg2 or SetMetatileBg1 (chosen by record byte +8); $16 = $0310; effect animation 01 with BRK #$83; COP 86. Never returns to the caller (entered with JMP).
; Clobbers: A, X, Y, dp$16, $18.

SealLair {
    COP [91]
    LDA $vram_write_queue ; Wait until the VRAM write queue is empty before patching the map
    BEQ loc_002879
    RTL 

  loc_002879:
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    LDA $0034, X
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    SEP #$20
    LDA $&data_lair_records.LairRecords+8, X ; Record byte +8 picks the map-patch routine (SetMetatileBg1Bg2 or SetMetatileBg1); both write tile $FE
    BEQ loc_0028A0
    LDA #$FE
    JSL $@lib_map_tile_patches.SetMetatileBg1Bg2
    BRA loc_0028A6

  loc_0028A0:
    LDA #$FE
    JSL $@lib_map_tile_patches.SetMetatileBg1

  loc_0028A6:
    PLX 
    REP #$20
    COP [A8] ( #$8000, #0E )
    LDA #$0310
    STA $0016, X
    STZ $001C, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$83              ; BRK #$83 (bit 6 clear: sound_request = $83) as the lair opens
    COP [80] ( #01 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Compares the monsters left in the lair with the last value seen.
; 
; When: once per frame in every lair script, after each COP 91.
; Sees: the moment the lair opens or spawns the next monster follows from it.
; Why: monster deaths (NotifyLairOfDeath) only decrement $2E; this routine turns the change into script flow.
; In: X = lair actor ($2E = left, $2F = last seen, $34 = lair index).
; Out: unchanged: PLA drops the JSR return and RTL waits; changed: $2F = $2E; carry clear when $2E is still positive; carry set and lair_state[$34] = 0 when $2E is 0.
; Clobbers: A, Y (= lair), X restored; M = 16 on return.

SyncLairCount {
    SEP #$20
    LDA $002E, X          ; $2E = monsters left (NotifyLairOfDeath decrements it), $2F = the value seen last time
    CMP $002F, X
    REP #$20
    BNE loc_0028D4
    PLA                   ; Unchanged: PLA drops the JSR return and RTL waits; the script resumes at its last COP 91
    RTL 

  loc_0028D4:
    TXY 
    LDA $0034, X
    TAX 
    SEP #$20
    LDA $002E, Y
    STA $002F, Y
    CLC 
    BNE loc_0028E9
    SEC 
    STA $lair_state, X    ; Count is 0: lair_state[$34] = 0 and carry set; the cleared state survives scene changes

  loc_0028E9:
    REP #$20
    TYX 
    RTS 
}

---------------------------------------------
; Creates one monster for the lair.
; 
; When: in the lair scripts, every time a monster is due.
; Sees: a puff cloud appears at the lair, then the monster.
; Why: all lair scripts share the spawn code.
; In: X = lair actor ($38 = pointer to the meta entry of the monster).
; Out: SpawnActorBefore; Y = new monster, $16 = meta +6 or $8000, script = RunMonsterAppearPuff, $32 = lair slot; position and $1C flip bits come from the lair (InitSpawnedActor).
; Clobbers: A, Y; X preserved.

SpawnLairMonster {
    PHX 
    JSR $&cop_core.SpawnActorBefore
    LDA $0038, X
    TAX 
    LDA $&WorldMetaPointers+6, X ; Monster flags = meta entry +6 or $8000 (off screen until the culling clears the bit)
    ORA #$8000
    STA $0016, Y
    LDA #$&RunMonsterAppearPuff ; First script of the new monster: the appear puff, which then falls into LoadMonsterFromMeta
    STA $0018, Y
    SEP #$20
    LDA #$^RunMonsterAppearPuff
    STA $0036, Y
    REP #$20
    PLX 
    TXA 
    STA $0032, Y          ; $32 of the monster = lair slot; FinishEnemyDeath uses it to tell the lair
    RTS 
}

---------------------------------------------
; Waits between two spawns of a lair.
; 
; When: after each SpawnLairMonster.
; Sees: monsters come out at a steady pace (longer for a bigger $26).
; Why: the interval is data (record +$14), not code.
; In: X = lair actor ($26 = interval; 0 = no wait).
; Out: $14 = 3 * $26 - 1 and the resume point $18 = the instruction after the JSR; leaves the script with RTL, which continues there once $14 has counted down.
; Clobbers: A.

DelayBetweenSpawns {
    LDA $0026, X
    BEQ loc_002927
    ASL 
    CLC 
    ADC $0026, X
    DEC 
    STA $0014, X          ; $14 = 3 * interval - 1: the script sleeps this many frames (RunActorList counts $14 down)
    PLA 
    INC 
    STA $0018, X          ; Resume point = return address of the JSR: after the wait the script continues behind the call
    RTL 

  loc_002927:
    RTS 
}
---------------------------------------------

; First script of a lair monster: the appear puff.
; 
; When: the frame after SpawnLairMonster.
; Sees: a small cloud where the monster arrives (animation 00 of the effects bank), then the monster is standing there stunned for a moment.
; Why: hides the pop-in and lets the monster arrive with its own graphics.
; In: X = new monster ($38 = meta entry).
; Out: $16 = $0300, flip bits saved in $30, $1C = scene_sprite_attr (the word stored at $0372) while the puff plays; then flags = meta +6 or $8800, $26 = 60, and the shared half of LoadMonsterFromMeta (BRA loc_00296A) loads graphics and script.
; Clobbers: A, Y.

RunMonsterAppearPuff {
    COP [A8] ( #$8000, #0E )
    LDA #$0300
    STA $0016, X
    LDA $001C, X          ; Keep the monster's flip bits in $30 while the puff uses scene_sprite_attr (the word at $0372) as its $1C
    STA $0030, X
    LDA $scene_sprite_attr
    STA $001C, X
    COP [80] ( #00 )
    COP [82]
    LDA $0030, X
    STA $001C, X
    LDA #$003C
    STA $0026, X
    LDY $0038, X
    LDA $&WorldMetaPointers+6, Y
    ORA #$8800            ; Flags = meta +6 or $8800 (bit $0800 = hit stun); with $26 = $3C the new monster starts stunned for 60 frames
    STA $0016, X
    BRA loc_00296A        ; Join LoadMonsterFromMeta after its flags store: banks, animation and script from the meta entry
}
---------------------------------------------

; Gives the actor X the animation, banks and script of its meta entry and starts that script in the same frame.
; 
; When: after the appear puff (RunMonsterAppearPuff), or directly as the script of formation monsters (RunLairFormation).
; Sees: the monster starts acting.
; Why: lair monsters are created as generic actors; their behaviour comes from the meta table.
; In: X = actor, $38 = meta entry pointer.
; Out: $16 = meta +6 or $8000 (entry label only), $24 = bank (+A), $36 = script bank (+D), $1E = animation (+5), $20 = 0, $22 = animation table (+8), $18 = script (+B), SetActorAnimFrame, $04 = $06 = 0, then an RTS trick enters the script.
; Clobbers: A, Y.

LoadMonsterFromMeta {
    LDY $0038, X
    LDA $&WorldMetaPointers+6, Y
    ORA #$8000
    STA $0016, X

  loc_00296A:
    SEP #$20
    LDA $&WorldMetaPointers+A, Y
    STA $0024, X
    LDA $&WorldMetaPointers+D, Y
    STA $0036, X
    PHA 
    REP #$20
    LDA $&WorldMetaPointers+5, Y
    STA $001E, X
    STZ $0020, X
    LDA $&WorldMetaPointers+8, Y
    STA $0022, X
    LDA $&WorldMetaPointers+B, Y
    STA $0018, X
    DEC                   ; RTS trick: with the bank and script - 1 pushed, the final RTL jumps straight into the monster's script
    PHA 
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    STZ $0004, X
    STZ $0006, X
    RTL 
}

---------------------------------------------
; Generic puff for an actor that appears.
; 
; When: spawned with COP 85 by about 150 scene scripts (NPCs, chests, switches, bridges) at the moment they appear.
; Sees: a small cloud centred on the object that pops into the scene.
; Why: one shared effect instead of per-scene animations.
; In: X = the puff (a clone of its spawner: position and box come from it).
; Out: when scene_active is 0 it ends at once; otherwise the puff is centred on the spawner's box, plays animation 02 of the effects bank and ends (COP 86).
; Clobbers: A.

RunAppearPuff {
    LDA $scene_active     ; scene_active = 0: no puff, the actor just ends
    BEQ loc_0029E5
    COP [A8] ( #$8000, #0E )
    LDA $0016, X
    AND #$DFFF
    ORA #$0010
    STA $0016, X
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A3]
    COP [A2] ( #30 )
    LDA $0010, X
    SEC 
    SBC #$0010            ; Centre the 16x16 puff on its spawner's box: x += (width - 16) / 2
    LSR 
    CLC 
    ADC $0000, X
    STA $0000, X
    LDA $0012, X
    SEC 
    SBC #$0010            ; y -= (height - 16) / 2
    LSR 
    EOR #$FFFF
    INC 
    CLC 
    ADC $0002, X
    STA $0002, X
    COP [80] ( #02 )
    COP [82]

  loc_0029E5:
    COP [86]
    RTL 
}
---------------------------------------------

; Turns a hazard into a puff that disappears.
; 
; When: set as the script of every hazard in range by DestroyHazardsNearOrb.
; Sees: the hazard bursts in a cloud (animation $10 of the effects bank).
; Why: the Soul of Shield removes them without a kill routine of their own.
; In: X = the hazard actor. Out: $36 = 0, $16 = $0300, animation $10, then COP 86. Clobbers: A.

RunHazardPuff {
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    LDA #$0300
    STA $0016, X
    COP [A3]
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A8] ( #$8000, #0E )
    COP [80] ( #10 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; Death script of every enemy: puff, Gem drop and EXP number.
; 
; When: KillTarget and KillOrSpareProjectileTarget put it in $18/$36 of a killed actor (HP 0, $16 bit $0400).
; Sees: the enemy bursts in a cloud, a Gem may drop and the EXP earned floats up as a number.
; Why: the same death sequence for every enemy; only the meta entry differs.
; In: X = dying actor, $38 = its meta entry. The boss (boss_actor) branches to RunBossDeath instead.
; Out: death puff (animation 03, centred like RunAppearPuff), a pickup actor spawned before this actor (see the block note for the drop odds), the EXP digits written into the sprite map, then COP 1B waits $10 frames and continues at FinishEnemyDeath.
; Clobbers: A, X, Y (restored where noted), dp$00, $01, $16, $18.

RunEnemyDeath {
    CPX $boss_actor       ; The boss goes to RunBossDeath instead
    BNE loc_002A18
    BRL RunBossDeath

  loc_002A18:
    COP [A8] ( #$8000, #0E )
    LDA #$0300
    STA $0016, X
    STZ $001A, X
    LDA $scene_sprite_attr
    STA $001C, X
    LDA $0010, X
    SEC 
    SBC #$0010            ; Centre the death puff on the dying actor (same offsets as RunAppearPuff)
    LSR 
    CLC 
    ADC $0000, X
    STA $0000, X
    LDA $0012, X
    SEC 
    SBC #$0010
    LSR 
    EOR #$FFFF
    INC 
    CLC 
    ADC $0002, X
    STA $0002, X
    LDA $world_index      ; w = world_index; world 6 counts as $19
    CMP #$0006
    BNE loc_002A59
    LDA #$0019

  loc_002A59:
    ASL 
    PHA 
    INC 
    STA $16               ; $16 = 2w + 1: a random number below it drops the 10-Gem pickup
    PLA 
    ASL 
    CLC 
    ADC #$0004
    STA $18               ; $18 = 4w + 4: below it the 5-Gem pickup, otherwise the 1-Gem pickup
    LDA $equipped_weapon  ; Weapon 4 (Lucky Blade) doubles both thresholds, so bigger pickups drop more often
    CMP #$0004
    BNE loc_002A72
    ASL $16
    ASL $18

  loc_002A72:
    COP [1F]
    COP [35] ( #64 )      ; random_mod_result = random number below $64 (100)
    LDA $random_mod_result
    CMP $18
    BCS loc_002A94
    CMP $16
    BCS loc_002A8B
    COP [B0] ( @RunLargeGemPickup, #$4000 ) ; Spawn the pickup before this actor with flags $4000 (the pickup bit ApplyContactDamageOrPickup tests)
    BRA loc_002A9B

  loc_002A8B:
    COP [B0] ( @RunMediumGemPickup, #$4000 )
    BRA loc_002A9B

  loc_002A94:
    COP [B0] ( @RunSmallGemPickup, #$4000 )

  loc_002A9B:
    COP [80] ( #03 )
    COP [82]
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$F000, #7E )
    COP [A0] ( #$FFF0 )
    PHX 
    LDY $0038, X
    LDA $&WorldMetaPointers+3, Y ; EXP of the monster as a BCD word (meta entry +3) into $00/$01
    STA $00
    TXY 
    TXA 
    SEC 
    SBC #$0800
    LSR 
    LSR 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $001E, X
    STZ $0020, X
    ASL 
    TAX 
    LDA $7EF000, X        ; Pointer table at $7EF000 (slot number x 2) leads to the popup's sprite map (layout not traced)
    TAX 
    LDA $7E0006, X
    CLC 
    ADC #$000E
    SEC 
    SBC #$F000
    TAX 
    LDA $00
    CMP #$1000            ; Digit count from the BCD value: $1000 or more four digits, $100 three, $10 two, else one
    BCS loc_002B27
    CMP #$0100
    BCS loc_002B14
    CMP #$0010
    BCS loc_002B01
    LDA #$0001
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$0005            ; Shift x to keep the number centred: +5 for one digit, +3 for two, +1 for three, -1 for four
    STA $0000, Y
    BRA loc_002B47

  loc_002B01:
    LDA #$0002
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$0003
    STA $0000, Y
    BRA loc_002B42

  loc_002B14:
    LDA #$0003
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$0001
    STA $0000, Y
    BRA loc_002B3D

  loc_002B27:
    LDA #$0004
    STA $7EEFFE, X
    LDA $0000, Y
    CLC 
    ADC #$FFFF
    STA $0000, Y
    LDA $01
    JSR $&WriteHighNibbleDigit

  loc_002B3D:
    LDA $01
    JSR $&WriteLowNibbleDigit

  loc_002B42:
    LDA $00
    JSR $&WriteHighNibbleDigit

  loc_002B47:
    LDA $00
    JSR $&WriteLowNibbleDigit
    PLX 
    COP [91]
    COP [82]
    COP [1B] ( &FinishEnemyDeath, #$0010 ) ; Show the number for $10 frames, then continue at FinishEnemyDeath
}

---------------------------------------------
; Shifts the BCD byte in A right by four and falls into WriteLowNibbleDigit, so the high digit is written. In: A = BCD byte, X = offset into the EXP sprite map. Out: see WriteLowNibbleDigit.

WriteHighNibbleDigit {
    LSR 
    LSR 
    LSR 
    LSR 
}

---------------------------------------------
; Writes one EXP digit. In: A = BCD byte (low nibble used), X = offset into the sprite map. Out: the tile from ExpDigitTiles is stored at $7EF005 + X; X += 7 (the entries are 7 bytes apart). Clobbers: A; M = 16 on return.

WriteLowNibbleDigit {
    AND #$000F
    PHX 
    TAX 
    LDA $@ExpDigitTiles, X ; Digit 0-9 to tile id
    PLX 
    SEP #$20
    STA $7EF005, X        ; Digit tile into the sprite map; entries are 7 bytes apart (X += 7 below)
    REP #$20
    TXA 
    CLC 
    ADC #$0007
    TAX 
    RTS 
}
---------------------------------------------

; Tile ids of the digits 0-9 for the EXP number above a dying enemy (read by WriteLowNibbleDigit).

ExpDigitTiles #B7C8C9D8D9CECFDEDFA7
---------------------------------------------

; End of the death sequence.
; 
; When: 16 frames after the EXP number appears (and after the boss explosions).
; Sees: the number vanishes and the enemy is gone.
; Why: lair monsters must report their death, others take the A3 path.
; In: X = dying actor.
; Out: $32 non-zero (lair monster): NotifyLairOfDeath; zero: BRL RespawnOrKillActor (A3: kill, or respawn when $1A bit $1000).

FinishEnemyDeath {
    LDY $0032, X
    BNE NotifyLairOfDeath
    BRL RespawnOrKillActor ; No lair ($32 = 0): continue in the A3 code at RespawnOrKillActor (kill, or respawn when $1A bit $1000)
}
---------------------------------------------

; Counts a lair monster's death in its lair.
; 
; When: the death sequence of a monster that has a lair ($32).
; Sees: when the last monster of a lair dies the lair opens (via SyncLairCount).
; Why: the lair keeps the count; the monster only knows the lair's slot.
; In: X = monster, Y = lair slot.
; Out: lair $2E decremented unless already 0; the monster actor ends (COP 86).
; Clobbers: A (M = 16).

NotifyLairOfDeath {
    SEP #$20
    LDA $002E, Y          ; $2E = monsters left in the lair, never below 0
    BEQ loc_002B91
    DEC 
    STA $002E, Y

  loc_002B91:
    REP #$20
    COP [86]
    RTL 

; Death script of a boss: a chain of explosions, then the next step of the game.
; 
; When: RunEnemyDeath finds X = boss_actor.
; Sees: the boss freezes and explodes in 32 bursts over its body; afterwards every other monster vanishes, then the ending (final boss) or the next scene.
; Why: bosses end the area, so the stage is cleaned up here.
; In: X = the boss ($08/$0A left and up extents, $0C/$0E right and down extents).
; Out: boss_box_x/y/w/h set; 32 RunBossExplosion actors; KillAllOtherActors; location_id $7D: RunEnding by RTS trick; else Cop31 (A3 handshake actor) and FinishEnemyDeath.
; Clobbers: A, Y.

  RunBossDeath:
    LDA #$0700
    STA $0016, X
    STZ $0004, X
    STZ $0006, X
    INC $contact_lock
    LDA $0000, X
    SEC 
    SBC $0008, X
    STA $boss_box_x       ; Box of the boss: x and y minus the left and upper extents ($08, $0A), width and height = sums of the extents; the explosions use it
    LDA $0002, X
    SEC 
    SBC $000A, X
    STA $boss_box_y
    LDA $0008, X
    CLC 
    ADC $000C, X
    STA $boss_box_w
    LDA $000A, X
    CLC 
    ADC $000E, X
    STA $boss_box_h
    COP [03] ( #20 )      ; Loop $20 = 32 times, one explosion actor per pass (COP 04 below)
    COP [84] ( @RunBossExplosion )
    LDA #$0003
    STA $0014, X          ; 3 frames between explosions
    COP [04]
    CPX $boss_actor
    BNE FinishEnemyDeath
    JSR $&KillAllOtherActors ; All explosions are out: remove every other actor
    LDA $location_id
    CMP #$007D            ; location_id $7D: the last boss, the ending starts
    BNE loc_002BF9
    SEP #$20
    LDA #$^RunEnding      ; RTS trick: bank and RunEnding - 1 are pushed and the RTL below jumps into RunEnding
    PHA 
    REP #$20
    LDA #$&RunEnding-1
    PHA 
    RTL 

  loc_002BF9:
    COP [31] ( #02 )      ; Not the last boss: Cop31_FadeAndLoadMusic starts the A3 sound handshake actor (operand 2)
    BRA FinishEnemyDeath
}

---------------------------------------------
; One explosion of a boss's death.
; 
; When: spawned 32 times by RunBossDeath.
; Sees: a burst at a random spot on the boss's body, with a sound on about half of them.
; Why: a chain of random bursts makes a big enemy fall apart.
; In: X = explosion (clone of the boss), boss_box_x/y/w/h.
; Out: x = boss_box_x + a random number below the box width (rng_state+1 and $7F reduced by repeated subtraction), y likewise from the height; animation 00 of the effects bank; BRK #$85 when the low bit of the random y offset is 0; COP 86.
; Clobbers: A.

RunBossExplosion {
    COP [A8] ( #$8000, #0E )
    COP [A3]
    LDA $scene_sprite_attr
    STA $001C, X
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [1F]
    SEP #$20
    LDA $rng_state+1      ; Random x inside the box: a number 0-$7F reduced modulo the box width by repeated subtraction, plus boss_box_x
    AND #$7F

  loc_002C1D:
    SEC 
    SBC $boss_box_w
    BPL loc_002C1D
    CLC 
    ADC $boss_box_w
    REP #$20
    AND #$00FF
    CLC 
    ADC $boss_box_x
    STA $0000, X
    COP [1F]
    SEP #$20
    LDA $rng_state+1      ; Random y the same way from the box height and boss_box_y
    AND #$7F

  loc_002C3C:
    SEC 
    SBC $boss_box_h
    BPL loc_002C3C
    CLC 
    ADC $boss_box_h
    REP #$20
    PHA 
    AND #$00FF
    CLC 
    ADC $boss_box_y
    STA $0002, X
    PLA 
    AND #$0001
    BNE loc_002C5B
    BRK #$85              ; BRK #$85 on about half of the explosions (low bit of the random y offset is 0)

  loc_002C5B:
    COP [80] ( #00 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Removes every actor except the player group and dying actors.
; 
; When: RunBossDeath, after the 32 explosions.
; Sees: all remaining monsters and projectiles disappear at once.
; Why: the cleared stage must be safe while the boss ends.
; In: none. Out: walks the actor list from actor_list_tail through $3E and kills (COP 86) every actor whose $16 has none of $24D0 ($2000, $0400, $0080, $0040, $0010).
; Clobbers: A; X preserved (PHX/PLX).

KillAllOtherActors {
    PHX 
    LDA $actor_list_tail
    BRA KillOthersTest

  KillOthersNext:
    LDA $003E, X

  KillOthersTest:
    TAX 
    BEQ KillOthersDone
    LDA $0016, X
    BIT #$24D0            ; Keep actors with any of $2000, $0400, $0080, $0040, $0010 in $16 (the player group, dying actors); kill the rest
    BNE KillOthersNext
    COP [86]
    BRA KillOthersNext

  KillOthersDone:
    PLX 
    RTS 
}

---------------------------------------------
; Removes every projectile.
; 
; When: lib_menus, when the menu closes with a different equipped magic than before.
; Sees: the old magic's flying shots vanish.
; Why: leftover projectiles of the unequipped magic would keep acting.
; In: none (called with JSL). Out: kills every actor with $16 bit $0020 (COP 86).
; Clobbers: A; X and P preserved.

KillAllProjectiles {
    PHP 
    PHX 
    REP #$20
    LDA $actor_list_tail
    BRA KillProjectilesTest

  KillProjectilesNext:
    LDA $003E, X

  KillProjectilesTest:
    TAX 
    BEQ KillProjectilesDone
    LDA $0016, X
    BIT #$0020            ; $16 bit $0020 marks projectiles; each one is killed
    BEQ KillProjectilesNext
    COP [86]
    BRA KillProjectilesNext

  KillProjectilesDone:
    PLX 
    PLP 
    RTL 
}
---------------------------------------------

; Step 1 of a music change started by Cop31: sends command $F1 to the SPC.
; 
; When: first script of the actor spawned by Cop31_FadeAndLoadMusic.
; Sees: the running music is told to fade (the SPC handler is HandleFadeIn in docs/audio/spc-disassembly.md; a fade-out: the SPC counts $31 down from $7F, scales the volume with it and stops at 0; docs/code/spc-interface.md).
; Why: the SPC must be quiet before a new song can be uploaded through the IPL.
; In: X = the spawned actor, $30 = track number.
; Out: APUIO0 = $F1; COP 27 continues at MusicLoadWaitFadeAck next frame.
; Clobbers: A.

MusicLoadSendFade {
    SEP #$20
    LDA #$F1              ; APUIO0 command $F1 (HandleFadeIn in docs/audio/spc-disassembly.md); the SPC echoes it back
    STA $APUIO0
    REP #$20
    COP [27] ( &MusicLoadWaitFadeAck )
}

---------------------------------------------
; Waits for the SPC to echo $F1, then answers $01.
; 
; When: every frame after MusicLoadSendFade until the echo arrives (RTL re-runs it).
; Sees: nothing.
; Why: handshake: the command is only taken as delivered when the SPC returns it; the answer $01 is needed because the SPC runs a command of $F0 or more again on every tick while the port holds it, which would restart the fade each time.
; In: X = actor.
; Out: APUIO0 = $F1: APUIO0 = $01 and COP 27 continues at MusicLoadWaitSilence; otherwise RTL.
; Clobbers: A.

MusicLoadWaitFadeAck {
    LDA $APUIO0
    AND #$00FF
    CMP #$00F1            ; Wait for the echo of the command
    BEQ loc_002CB4
    RTL 

  loc_002CB4:
    SEP #$20
    LDA #$01              ; Answer $01: the SPC runs a command of $F0 or more on every tick while the port holds it, so $F1 must not stay; the port reads 0 when the fade has ended
    STA $APUIO0
    REP #$20
    COP [27] ( &MusicLoadWaitSilence )
}

---------------------------------------------
; Waits until APUIO0 reads 0, then goes on to MusicLoadSendStop.
; 
; When: every frame after the answer $01.
; Sees: nothing; the old music is already fading or silent.
; Why: at the end of the fade the SPC sets its current command to 0 and runs StopAllChannels, so the port reads 0 (docs/code/spc-interface.md).
; In: X = actor.
; Out: APUIO0 = 0: branches to MusicLoadSendStop; otherwise RTL.
; Clobbers: A.

MusicLoadWaitSilence {
    SEP #$20
    LDA $APUIO0
    REP #$20
    BEQ MusicLoadSendStop
    RTL 
}
---------------------------------------------

; Sends command $F0 (stop all channels) to the SPC.
; 
; When: after the fade handshake, or as the first script of the actor spawned by Cop32_StopAndLoadMusic.
; Sees: all channels are silent.
; Why: the upload may only start on a stopped SPC.
; In: X = actor.
; Out: APUIO0 = $F0; COP 27 continues at MusicLoadWaitStopped next frame.
; Clobbers: A.

MusicLoadSendStop {
    SEP #$20
    LDA #$F0              ; APUIO0 command $F0 (StopAllChannels in docs/audio/spc-disassembly.md)
    STA $APUIO0
    REP #$20
    COP [27] ( &MusicLoadWaitStopped )
}

---------------------------------------------
; Waits until APUIO0 reads 0, then waits 2 frames before the upload.
; 
; When: every frame after MusicLoadSendStop.
; Sees: nothing.
; Why: the SPC clears the port when the stop command is done.
; In: X = actor.
; Out: APUIO0 = 0: COP 1B continues at MusicLoadUpload after 2 frames; otherwise RTL.
; Clobbers: A.

MusicLoadWaitStopped {
    SEP #$20
    LDA $APUIO0
    REP #$20
    BEQ loc_002CE2
    RTL 

  loc_002CE2:
    COP [1B] ( &MusicLoadUpload, #$0002 )
}
---------------------------------------------

; Uploads the track to the SPC.
; 
; When: 2 frames after the SPC reported stopped.
; Sees: the new music starts shortly after; the upload itself runs with NMI off, so the game stalls for a moment.
; Why: this is the only way to change songs: the song records and samples go through the SPC's own copy of the IPL receive loop, entered by the $FF command (engine_spc_ipl_upload); the boot ROM is not used again.
; In: X = actor, $30 = track number.
; Out: APUIO0 = $FF; $30 = 0; the long pointer MusicPointerTable[track] is in dp$29-$2B and $0422/$0424; vblank wait, NMI off, UploadSpcStream upload, vblank wait, NMI on; COP 1B continues at MusicLoadFinish after 2 frames.
; Clobbers: A, Y; DP $29-$2B; X preserved (PHX/PLX).

MusicLoadUpload {
    SEP #$20
    LDA #$FF              ; APUIO0 command $FF: the SPC re-enters its boot handshake (HandleBootHandshake) so the IPL upload can start
    STA $APUIO0
    REP #$20
    LDA $0030, X
    ASL 
    CLC 
    ADC $0030, X
    TAY 
    STZ $0030, X
    LDA $&data_engine_tables.MusicPointerTable, Y ; MusicPointerTable: 21 long pointers (3 bytes) to the song data; Y = track number x 3
    STA $29
    STA $asset_cache_music
    SEP #$20
    LDA $&data_engine_tables.MusicPointerTable+2, Y
    STA $2B
    STA $asset_cache_music+2
    REP #$20
    PHX 
    SEP #$20
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@lib_system_helpers.DisableNmi ; NMITIMEN = $01: NMI off while the song goes through the IPL; EnableNmi switches it back on
    JSL $@engine_spc_ipl_upload.UploadSpcStream
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@lib_system_helpers.EnableNmi
    REP #$20
    PLX 
    COP [1B] ( &MusicLoadFinish, #$0002 )
}

---------------------------------------------
; Releases the SPC and ends the music-load actor.
; 
; When: 2 frames after the upload.
; Sees: the new song plays.
; Why: the SPC leaves the transfer with last song 0, so the $01 starts song 1, the song just uploaded; boss_fight_active is cleared because the boss track change marks the end of the boss fight.
; In: X = actor.
; Out: APUIO0 = $01, boss_fight_active ($0458) = 0, COP 86 kills the actor.
; Clobbers: A.

MusicLoadFinish {
    SEP #$20
    LDA #$01
    STA $APUIO0
    REP #$20
    STZ $boss_fight_active ; The boss scripts increment boss_fight_active when the fight starts; the boss's music change ends it
    COP [86]
    RTL 

; Last step of an enemy's death without a lair: kills it, or lets it come back later.
; 
; When: FinishEnemyDeath (BRL) for actors with $32 = 0.
; Sees: the enemy is gone. With $1A bit $1000 set it would return as a fresh copy after the player has left it off screen for about 10 seconds; no code in extracted/ sets that bit (OQ-I044-6), so by static reading every enemy without a lair is killed here.
; Why: $1A bit $1000 is the switch between a field enemy that comes back and a scripted actor or boss that does not.
; In: X = dying actor, $3A = its placement record.
; Out: $1A bit $1000 clear: COP 86. Set: $26 = $0258, COP 91; each frame while $16 bit $8000 (off screen) is set $26 is decremented and when it goes negative InitActorFromPlacement re-creates the actor in this slot; on screen nothing counts.
; Clobbers: A, Y.

  RespawnOrKillActor:
    LDA $001A, X
    BIT #$1000
    BEQ RespawnKill
    LDA #$0258            ; $0258 = 600: with the post-decrement test the actor returns after 601 off-screen frames
    STA $0026, X
    COP [91]              ; From here the actor re-enters at the next instruction every frame (resume pointer = address after this COP)
    LDA $0016, X
    BIT #$8000
    BNE RespawnCountDown
    RTL 

  RespawnCountDown:
    DEC $0026, X
    BMI RespawnRebuild
    RTL 

  RespawnRebuild:
    JSL $@InitActorFromPlacement
    RTL 

  RespawnKill:
    COP [86]
    RTL 
}
---------------------------------------------

; A Gem that lies on the ground until it is taken.
; 
; When: spawned with COP 85 by gw_actor_fixed_gem_pickup (Greenwood).
; Sees: a Gem that stays; touching it gives 10 Gems (OQ-I006-8).
; Why: fixed rewards need a pickup that never times out.
; In: X = the pickup. Out: $16 = $4000 (pickup), animation 07 forever; ApplyGemPickup removes it.
; Clobbers: A.

RunFixedGemPickup {
    COP [A8] ( #$8000, #0E )
    LDA #$4000
    STA $0016, X
    COP [A4]
    LDA $scene_sprite_attr
    STA $001C, X

  loc_002ED3:
    COP [80] ( #07 )
    COP [82]
    BRA loc_002ED3
}

---------------------------------------------
; A dropped 1-Gem pickup.
; 
; When: dropped by RunEnemyDeath (COP B0, flags $4000).
; Sees: a small Gem that animates, then blinks and disappears if left.
; Why: drops are timed so the field does not fill up.
; In: X = the pickup. Out: COP A4, animation 04, then animation 09 with count 4 (COP 81/83), COP 86. Touching it runs ApplyGemPickup (1 Gem).
; Clobbers: A.

RunSmallGemPickup {
    COP [A4]
    COP [80] ( #04 )
    COP [82]
    COP [81] ( #09, #04 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; A dropped 5-Gem pickup.
; 
; When: dropped by RunEnemyDeath.
; Sees: a larger Gem that animates, then blinks and disappears if left.
; Why: as RunSmallGemPickup.
; In: X = the pickup. Out: COP A4, animation 05, then animation 0A with count 4, COP 86. ApplyGemPickup gives 5 Gems.
; Clobbers: A.

RunMediumGemPickup {
    COP [A4]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #0A, #04 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; A dropped 10-Gem pickup.
; 
; When: dropped by RunEnemyDeath.
; Sees: the biggest Gem, animates, then blinks and disappears if left.
; Why: as RunSmallGemPickup.
; In: X = the pickup. Out: COP A4, animation 06, then animation 0B with count 4, COP 86. ApplyGemPickup gives 10 Gems.
; Clobbers: A.

RunLargeGemPickup {
    COP [A4]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0B, #04 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Gives the player the Gems of a pickup actor.
; 
; When: ApplyContactDamageOrPickup, when the player touches an actor with $16 bit $4000.
; Sees: a pickup sound and the Gem counter in the HUD rises; the pickup is gone.
; Why: one routine for the three sizes, chosen by the pickup's current animation id ($1E).
; In: X = pickup (called with JSL).
; Out: BRK #$4D; amount = 10 for animation 06 and 0B and for any unknown id, 5 for 05 and 0A, 1 for 04 and 09; lib_player_helpers.AddGems adds it in BCD to gems_low and gems_high; hud_dirty_flags bit $0010 set; $16 bit $2000 set; COP 86.
; Clobbers: A; P and Y restored.

ApplyGemPickup {
    PHP 
    PHY 
    REP #$20
    BRK #$4D
    LDA $001E, X          ; $1E = current animation id of the pickup: 06 and 0B give 10 Gems, 05 and 0A give 5, 04 and 09 give 1, anything else 10
    CMP #$0006
    BEQ loc_002F31
    CMP #$0005
    BEQ loc_002F36
    CMP #$0004
    BEQ loc_002F3B
    CMP #$000B
    BEQ loc_002F31
    CMP #$000A
    BEQ loc_002F36
    CMP #$0009
    BEQ loc_002F3B

  loc_002F31:
    LDA #$0010
    BRA loc_002F3E

  loc_002F36:
    LDA #$0005
    BRA loc_002F3E

  loc_002F3B:
    LDA #$0001

  loc_002F3E:
    JSL $@lib_player_helpers.AddGems ; A = Gems in BCD, added to gems_low and gems_high with a cap
    LDA #$0010
    TSB $hud_dirty_flags  ; HUD bit $0010: Gems changed (OQ-I006-18)
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [86]
    PLY 
    PLP 
    RTL 
}
---------------------------------------------

; The ending after the last boss: the farewell text, the souls and the warp.
; 
; When: RunBossDeath at location_id $7D, entered by RTS trick.
; Sees: 'Finally ... defeated Deathtoll!', the speech of the souls (singular or plural text), 'The World of Evil began to disappear', an effect, then the next scene.
; Why: the text depends on the souls recovered (OQ-I006-10).
; In: X = the boss actor. Out: texts through COP 01, souls_flags cleared, event flag byte $1F bit 2 set, text_delay ($1B84) = 6, $031E = 1, Cop10 warp to scene 7 (OQ-I006-11). The text fits the walkthrough ending in the Deathtoll chapter.
; Clobbers: A.

RunEnding {
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    LDA #$2010
    STA $0016, X
    INC $0466
    COP [37]
    COP [31] ( #00 )
    COP [03] ( #F1 )
    COP [04]
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &EndingTextDefeated )
    LDA $souls_flags      ; $1F masks the five soul bits; exactly 1 = only the Magician (OQ-I006-10): singular text 'I decided', else plural 'we decided'
    AND #$001F
    DEC 
    BEQ loc_00538C
    COP [01] ( &EndingTextStayPlural )
    BRA loc_005390

  loc_00538C:
    COP [01] ( &EndingTextStaySingular )

  loc_005390:
    SEP #$20
    STZ $souls_flags      ; All souls cleared after the text
    REP #$20
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &EndingTextWorldFades )
    COP [85] ( @RunEndingEffect )
    COP [03] ( #F1 )
    COP [04]
    COP [09] ( #$9F02 )   ; Cop09_SetOrClearFlag: set event flag byte $1F bit 2 (operand $9F02, bit 15 = set)
    LDA #$0006
    STA $text_delay       ; text_delay = 6: frames per printed glyph from now on (InitFixedState sets 3 once at boot, lib_boot_and_scene_init; OQ-I028-1)
    LDA #$0001
    STA $scene_variant
    COP [10] ( #$0700, #01, #$0070, #$0060 ) ; Cop10_SetNextScene: scene_next = 7 (area 0), warp animation 1, x = $70, y = $60 (OQ-I006-11)
    COP [91]
    RTL 
}

---------------------------------------------
; First ending text: the hero ([02:2], presumably the name from the name-entry strings) defeated Deathtoll and hears a small voice. Ends with [END].

EndingTextDefeated |[10]Finally, [02:2] [N]defeated Deathtoll! [FIN]Suddenly [02:2][N]heard a small voice- [FIN][END]|

---------------------------------------------
; Ending text when only one soul remains (the Magician): 'I decided to stay here and seal the World of Evil'. [JMP] continues in EndingTextStayPlural after its first sentence.

EndingTextStaySingular |[10][02:2],I decided to [N]stay here and seal the[N]World of Evil- [FIN][JMP:&EndingTextStayPlural+M]|

---------------------------------------------
; Ending text for several souls: 'we decided to stay here and seal the World of Evil', then the Master's message about the World of Evil, ending with [12][08:408][END] (OQ-I006-14).

EndingTextStayPlural |[10][02:2], we decided [N]to stay here and seal [N]the World of Evil-----[FIN][::]The World of Evil is [N]a dark world that [N]exists in the back of [N]creatures  minds- [FIN]As long as there are [N]inventions in this [N]world the same thing [N]will happen- [FIN]I will stay and try to[N]stop as much as [N]possible- [FIN]You are still young, [N]you should experience [N]more- [FIN]And if you figure out [N]reasons for, [N]all feelings, [FIN]all connections [FIN]and existences, [N]you will be wise like [N]the Master- [FIN][02:2], get going- [12][08:408][END]|

---------------------------------------------
; Last ending text: 'The World of Evil began to disappear', then [12][08:408][END].

EndingTextWorldFades |[10]The World of Evil [N]began to disappear- [12][08:408][END]|

---------------------------------------------
; Visual effect of the ending.
; 
; When: spawned with COP 85 by RunEnding after EndingTextWorldFades.
; Sees: the effect while the world disappears (animation $4D of the bank $0D, started with COP 92).
; Why: the text alone would not show the world fading.
; In: X = the effect actor. Out: COP A8 (#$8000, #0D), COP 92 (#4D), COP 94, then COP 86.
; Clobbers: A.

RunEndingEffect {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #4D )
    COP [94]
    COP [86]
    RTL 
}