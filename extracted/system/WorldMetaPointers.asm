; Actor meta tables: the 7-word world pointer table and the seven lists of 14-byte actor types, 469 entries in all (file offsets 32768-39347, SNES $01:8000-$99B3, bank 00; 6580 bytes).
; 
; === MODEL ===
; Every actor placed in a scene, every lair monster and the player is an instance of a meta type: one 14-byte row that gives its stats, first animation, animation table and script. There is one list per world (world_index 0-6: Grass Valley, GreenWood, St. Elles, Mountain of Souls, Leo's Laboratory, Magridd's Castle, World of Evil), so a type number means something different in each world: type $1F is the Metal Mantis in world 0 and a Mini Race Car in world 4. SpawnSceneActors stores the offset of the world's list in $03B0; every consumer reads its row at WorldMetaPointers + $03B0 + type x 14 (listings show $&WorldMetaPointers+N,Y with DBR $01 or $81). The type number comes from a placement row (+3, the PlacementAaaSss lists) or from a lair record (+$15, LairRecords).
; 
; === ENTRY LAYOUT (14 bytes) ===
; +0 attack, +1 defence, +2 HP (a binary byte), +3 word EXP (BCD), +5 animation id, +6 word flags (becomes $16; $8000 is added at spawn), +8 word animation table, +A animation bank, +B word script, +D script bank. +8..+A is the 3-byte Address field of structs.json and +B..+D the @Code field. Damage (comments in the combat code): the player's hit on a monster is max(1, attack_current - monster defence (+1)); a monster's hit on the player is attack (+0) - 1 - defense_current, at least 0. The EXP word is added in BCD by KillTarget and drawn as digits by RunEnemyDeath.
; HP is binary and EXP is BCD: the bestiary values of docs/walkthrough/enemy-bestiary.md match this reading for every enemy that could be matched (for example Metal Mantis 50 HP and 50 EXP = bytes $32 and $0050).
; 
; === WHAT THE OPERANDS SAY ===
; Animation table (+8..+A): 358 of the 469 entries use $7E3800 (the sprite map the scene loader expanded into WRAM: the step lists of ordinary actors travel with the scene), 69 use PaletteAnimLists (bank $0D, the colour animations: mostly types $01-$0F of every list, 14, 14, 13, 15, 5, 3 and 5 types in worlds 0-6; none of the enemies), 7 use PlayerAnims (entry 0 of every world, the hero), 4 use EffectAnims and 31 have $000000 (the actor selects its own table with COP A8). Flags word (+6): $2010 95 times, $2040 87, $0040 49, $0000 43, $2048 39, $2050 38, $1000 22, $3040 21 and 28 more values with fewer entries.
; Entry 0 of every list is the hero: attack 1, defence 2, HP 3, animation 0, flags $1180, table PlayerAnims, script InitPlayerActor. The seven copies are identical (the stats are not used; the player's own stats live in the $1B.. fields).
; 
; === ENEMY TYPES (matched by stats) ===
; The ROM names nothing. The part notes of the seven lists name the enemy types by matching HP and EXP against the walkthrough bestiary (inferred). Where the bestiary gives several enemies the same stats the ids cannot be told apart this way and the note says so. The four bosses whose ROM HP differs from the bestiary, the world 6 Purple Bull and the types that match no bestiary row are OQ-I033-1 to OQ-I033-4.
; 
; === NOTES ===
; - The names MetaGrassValley .. MetaWorldOfEvil label the list starts; a type number is the index of a row inside its list, so type $1F of world 0 is MetaGrassValley + 31 x 14.
; - engine_0026F3.code_00296A loads +5 as a word (so the low byte of the flags becomes the high byte of the animation id): harmless for rows whose flags low byte is 0 (OQ-I014-5).
; - Consumers: SpawnSceneActors (list offset), InitActorFromPlacement, SpawnLairActor, SpawnLairMonster, RunMonsterAppearPuff, LoadMonsterFromMeta, ApplySwordHit, ApplyProjectileHit, ApplyContactDamageOrPickup, KillTarget, RunEnemyDeath, SetEnemyGauge, HoldActorUntilReleased, FindTalkableActorAt.
---------------------------------------------

?BANK 01

?INCLUDE 'data_anim_effects'
?INCLUDE 'data_anim_palette_cycles'
?INCLUDE 'data_anim_player'
?INCLUDE 'gv_boss_metal_mantis'
?INCLUDE 'gv_enemy_0FAA49'
?INCLUDE 'gv_front_end'
?INCLUDE 'gv_leos_paintings_actors'
?INCLUDE 'gv_leos_paintings_enemies'
?INCLUDE 'gv_multi_area_actors'
?INCLUDE 'gv_underground_castle_actors'
?INCLUDE 'gv_underground_castle_enemies'
?INCLUDE 'gv_up_above_actors_and_name_entry'
?INCLUDE 'gv_up_above_trial_room_and_lisa_turbo_actors'
?INCLUDE 'gv_village_actors_018000'
?INCLUDE 'gv_village_actors_019475'
?INCLUDE 'gw_boss_light_water_fire_statues'
?INCLUDE 'gw_enemies_without_placement'
?INCLUDE 'gw_lostside_marsh_actors'
?INCLUDE 'gw_lostside_marsh_enemies'
?INCLUDE 'gw_woods_actors_01B98D'
?INCLUDE 'gw_woods_actors_01D045'
?INCLUDE 'lib_0116C3'
?INCLUDE 'll_boss_tin_doll'
?INCLUDE 'll_laboratory_actors'
?INCLUDE 'll_laboratory_dungeon_actors'
?INCLUDE 'll_laboratory_dungeon_enemies'
?INCLUDE 'll_town_models_actors'
?INCLUDE 'll_town_models_enemies'
?INCLUDE 'mc_airship_dock_actors'
?INCLUDE 'mc_boss_demon_falcon'
?INCLUDE 'mc_castle_actors'
?INCLUDE 'mc_castle_dungeon_actors'
?INCLUDE 'mc_castle_dungeon_enemies'
?INCLUDE 'mc_castle_towers_actors'
?INCLUDE 'mc_castle_towers_enemies'
?INCLUDE 'ms_boss_poseidon'
?INCLUDE 'ms_dungeon_actors'
?INCLUDE 'ms_enemy_0FCFD6'
?INCLUDE 'ms_enemy_0FD058'
?INCLUDE 'ms_multi_area_actors'
?INCLUDE 'ms_multi_area_enemies'
?INCLUDE 'ms_snow_mountain_actors'
?INCLUDE 'ms_soul_of_mountain_house_actors_020000'
?INCLUDE 'ms_soul_of_mountain_house_actors_02100B'
?INCLUDE 'player_core'
?INCLUDE 'se_boss_floating_skull'
?INCLUDE 'se_enemy_0FBB78'
?INCLUDE 'se_ghost_ship_actors'
?INCLUDE 'se_ghost_ship_enemies'
?INCLUDE 'se_seabed_of_st_elles_actors'
?INCLUDE 'se_seabed_of_st_elles_enemies'
?INCLUDE 'se_seabed_sanctuary_actors_0F8000'
?INCLUDE 'se_seabed_sanctuary_actors_0F8D58'
?INCLUDE 'se_st_elles_coast_actors'
?INCLUDE 'se_st_elles_coast_enemies'
?INCLUDE 'shared_actor_helpers_bank0'
?INCLUDE 'w1_actor_01E4BB'
?INCLUDE 'w2_actor_0FA6F5'
?INCLUDE 'w6_actor_01EC4B'
?INCLUDE 'w6_actor_01F14F'
?INCLUDE 'we_deathtolls_shrine_actors'
?INCLUDE 'we_evil_world_actors'
?INCLUDE 'we_evil_world_enemies'

---------------------------------------------

; The seven world pointers: one word per world_index, each the bank-$01 address of that world's meta list.
; 
; When: SpawnSceneActors reads word world_index x 2 once per scene load and keeps (word - $8000) in $03B0; the type offset is then added by every spawn.
; Sees: the same type number gives a different actor in each world (type $1F is the Metal Mantis in Grass Valley and a Mini Race Car in Leo's Laboratory).
; Why: the worlds share the type-number space of the placement and lair records, so each list only needs the types of its own world.
; In: n/a (data): 7 words, $&MetaGrassValley, $&MetaGreenwood, $&MetaStElles, $&MetaMountainOfSouls, $&MetaLeosLab, $&MetaMagriddsCastle, $&MetaWorldOfEvil (file offsets 32768-32781).
; Out: lists of 95, 81, 87, 68, 55, 62 and 21 entries (469 in all, 14 bytes each).
; Clobbers: n/a (data).

WorldMetaPointers [
  &MetaGrassValley   ;00
  &MetaGreenwood   ;01
  &MetaStElles   ;02
  &MetaMountainOfSouls   ;03
  &MetaLeosLab   ;04
  &MetaMagriddsCastle   ;05
  &MetaWorldOfEvil   ;06
]

---------------------------------------------
; World 0 (Grass Valley): 95 meta entries, types $00-$5E (file offsets 32782-34111).
; 
; When: world_index 0: the village, the Underground Castle, Leo's Paintings, the dream rooms and the intro scenes.
; Sees: the Grass Valley monsters, NPCs and objects.
; Why: see the block note; the list is the type space of this world.
; In: n/a (data); row = list + type x 14.
; Out: type $00 the hero. Enemy types matched by HP and EXP with the bestiary (inferred): $1F Metal Mantis (boss, HP 50, EXP 50; it is the monster of lair record $09, see LairRecords), $20, $22, $23 and $24 (HP 3, EXP 1: the bestiary gives Blue Liquid, Fly, Green Humanoid and Walking Bush the same stats, so the four ids cannot be assigned), $21 Yellow Humanoid, $25 Blue Torch, $26 Yellow Knight, $27 Metal Crawler, $28 and $2E Purple Bird (two types), $29 Green Torch. The other types are NPCs and objects.
; Clobbers: n/a (data).

MetaGrassValley [
  meta_entry < #01, #02, #03, #$0005, #00, #$1180, @data_anim_player.PlayerAnims, @player_core.InitPlayerActor >   ;00
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;01
  meta_entry < #00, #00, #00, #$0000, #01, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;02
  meta_entry < #00, #00, #00, #$0000, #02, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;03
  meta_entry < #00, #00, #00, #$0000, #03, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;04
  meta_entry < #00, #00, #00, #$0000, #04, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;05
  meta_entry < #00, #00, #00, #$0000, #05, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;06
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @gv_multi_area_actors.gv_obj_bg2_scroll_drift_01B1F7 >   ;07
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @gv_leos_paintings_actors.gv_obj_bg2_scroll_drift_01B21A >   ;08
  meta_entry < #00, #00, #00, #$0000, #06, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;09
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @gv_leos_paintings_actors.gv_fx_hdma_gradient_01B273 >   ;0A
  meta_entry < #00, #00, #00, #$0000, #02, #$3048, $7E3800, @gv_village_actors_018000.gv_npc_old_man_crab_walk_018000 >   ;0B
  meta_entry < #00, #00, #00, #$0000, #06, #$3048, $7E3800, @gv_village_actors_018000.gv_npc_old_woman_0180F7 >   ;0C
  meta_entry < #00, #00, #00, #$0000, #06, #$3058, $7E3800, @gv_village_actors_018000.gv_npc_tool_shop_owner_018353 >   ;0D
  meta_entry < #00, #00, #00, #$0000, #1E, #$3050, $7E3800, @gv_village_actors_018000.gv_npc_tulip_water_mill_01848A >   ;0E
  meta_entry < #00, #00, #00, #$0000, #02, #$3048, $7E3800, @gv_village_actors_018000.gv_npc_bridge_guard_0185B9 >   ;0F
  meta_entry < #00, #00, #00, #$0000, #01, #$3048, $7E3800, @gv_village_actors_018000.gv_npc_water_mill_keeper_0186A2 >   ;10
  meta_entry < #00, #00, #00, #$0000, #18, #$3040, $7E3800, @gv_village_actors_018000.gv_npc_goat_pen_01891A >   ;11
  meta_entry < #00, #00, #00, #$0000, #12, #$3040, $7E3800, @gv_village_actors_018000.gv_npc_lisa_018A59 >   ;12
  meta_entry < #00, #00, #00, #$0000, #1E, #$3050, $7E3800, @gv_village_actors_018000.gv_npc_tulip_dream_rod_018FF4 >   ;13
  meta_entry < #00, #00, #00, #$0000, #02, #$3048, $7E3800, @gv_village_actors_018000.gv_npc_architect_gaudi_01910C >   ;14
  meta_entry < #00, #00, #00, #$0000, #0C, #$3048, $7E3800, @gv_village_actors_018000.gv_npc_tool_shop_son_0191D2 >   ;15
  meta_entry < #00, #00, #00, #$0000, #1E, #$3050, $7E3800, @gv_village_actors_018000.gv_npc_tulip_dream_boundary_019365 >   ;16
  meta_entry < #00, #00, #00, #$0000, #00, #$2048, $7E3800, @gv_village_actors_019475.gv_obj_leos_painting_019475 >   ;17
  meta_entry < #00, #00, #00, #$0000, #1C, #$3050, $7E3800, @gv_village_actors_019475.gv_obj_water_mill_anim_1C_019644 >   ;18
  meta_entry < #00, #00, #00, #$0000, #1D, #$3050, $7E3800, @gv_village_actors_019475.gv_obj_water_mill_anim_1D_019656 >   ;19
  meta_entry < #00, #00, #00, #$0000, #0C, #$3040, $7E3800, @gv_village_actors_019475.gv_npc_boy_secret_hut_019668 >   ;1A
  meta_entry < #00, #00, #00, #$0000, #1E, #$3040, $7E3800, @gv_village_actors_019475.gv_npc_tulip_clubhouse_pass_0197DA >   ;1B
  meta_entry < #00, #00, #00, #$0000, #0C, #$3048, $7E3800, @gv_village_actors_019475.gv_npc_boy_secret_passage_0198A6 >   ;1C
  meta_entry < #00, #00, #00, #$0000, #18, #$3040, $7E3800, @gv_village_actors_019475.gv_npc_lonely_goat_guide_019A2C >   ;1D
  meta_entry < #00, #00, #00, #$0000, #18, #$2040, $7E3800, @gv_village_actors_019475.gv_npc_gourmet_goat_019CDE >   ;1E
  meta_entry < #06, #02, #32, #$0050, #00, #$1000, $7E3800, @gv_boss_metal_mantis.gv_boss_metal_mantis_0031AD >   ;1F
  meta_entry < #01, #00, #03, #$0001, #00, #$1000, $7E3800, @gv_enemy_0FAA49.gv_enemy_green_humanoid_0FAA49 >   ;20
  meta_entry < #01, #01, #04, #$0002, #06, #$1000, $7E3800, @gv_underground_castle_enemies.gv_enemy_yellow_humanoid_0FAA8F >   ;21
  meta_entry < #01, #01, #03, #$0001, #1B, #$0000, $7E3800, @gv_underground_castle_enemies.gv_enemy_walking_bush_0FAB9A >   ;22
  meta_entry < #01, #00, #03, #$0001, #12, #$1000, $7E3800, @gv_underground_castle_enemies.gv_enemy_fly_0FAC31 >   ;23
  meta_entry < #01, #00, #03, #$0001, #2E, #$1000, $7E3800, @gv_underground_castle_enemies.gv_enemy_blue_liquid_0FAC7A >   ;24
  meta_entry < #01, #00, #05, #$0002, #18, #$0000, $7E3800, @gv_underground_castle_enemies.gv_enemy_blue_torch_0FACF2 >   ;25
  meta_entry < #03, #00, #09, #$0005, #12, #$1000, $7E3800, @gv_leos_paintings_enemies.gv_enemy_yellow_knight_0FAD2A >   ;26
  meta_entry < #04, #08, #18, #$0250, #1E, #$0000, $7E3800, @gv_leos_paintings_enemies.gv_enemy_metal_crawler_0FAEE5 >   ;27
  meta_entry < #03, #00, #04, #$0003, #18, #$0000, $7E3800, @gv_leos_paintings_enemies.gv_enemy_purple_bird_0FAF44 >   ;28
  meta_entry < #03, #00, #09, #$0004, #22, #$0000, $7E3800, @gv_leos_paintings_enemies.gv_enemy_green_torch_0FAFAD >   ;29
  meta_entry < #00, #00, #00, #$0000, #1E, #$3040, $7E3800, @gv_leos_paintings_actors.gv_npc_tulip_dream_01A3B0 >   ;2A
  meta_entry < #00, #00, #00, #$0000, #1F, #$3040, $7E3800, @gv_underground_castle_actors.gv_npc_lisa_dream_01A440 >   ;2B
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @gv_multi_area_actors.gv_obj_push_zone_setup_01AFFD >   ;2C
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @gv_underground_castle_actors.gv_fx_hdma_gradient_01B23D >   ;2D
  meta_entry < #03, #02, #04, #$0003, #00, #$0000, $7E3800, @gv_leos_paintings_enemies.gv_enemy_monster_blocks_0FB04F >   ;2E
  meta_entry < #03, #00, #01, #$0000, #22, #$0002, $7E3800, @gv_leos_paintings_enemies.gv_enemy_spikes_0FB0D6 >   ;2F
  meta_entry < #00, #00, #00, #$0000, #28, #$0040, $7E3800, @gv_underground_castle_actors.gv_obj_elevator_01AE99 >   ;30
  meta_entry < #00, #00, #00, #$0000, #29, #$0040, $7E3800, @gv_underground_castle_actors.gv_obj_elevator_platform_01AF5C >   ;31
  meta_entry < #00, #00, #00, #$0000, #38, #$2040, $7E3800, @gv_up_above_trial_room_and_lisa_turbo_actors.gv_npc_magician_01A7AC >   ;32
  meta_entry < #00, #00, #00, #$0000, #00, #$3048, $7E3800, @gv_village_actors_019475.gv_npc_old_man_pet_goat_019EF4 >   ;33
  meta_entry < #00, #00, #00, #$0000, #18, #$3040, $7E3800, @gv_village_actors_019475.gv_npc_goat_reincarnation_019F7A >   ;34
  meta_entry < #00, #00, #00, #$0000, #1E, #$2050, $7E3800, @gv_village_actors_019475.gv_npc_tulip_hidden_item_hint_01A004 >   ;35
  meta_entry < #00, #00, #00, #$0000, #15, #$2040, $7E3800, @gv_village_actors_019475.gv_npc_village_chief_01A098 >   ;36
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @gv_village_actors_019475.gv_npc_fairy_recover_sword_01AB4F >   ;37
  meta_entry < #00, #00, #00, #$0000, #07, #$0050, $7E3800, @gv_village_actors_019475.gv_npc_fairy_exp_80_01AC06 >   ;38
  meta_entry < #00, #00, #00, #$0000, #07, #$0040, $7E3800, @gv_underground_castle_actors.gv_npc_fairy_exp_30_01AC32 >   ;39
  meta_entry < #00, #00, #00, #$0000, #2A, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;3A
  meta_entry < #00, #00, #00, #$0000, #2B, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;3B
  meta_entry < #00, #00, #00, #$0000, #2C, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;3C
  meta_entry < #00, #00, #00, #$0000, #2D, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @gv_up_above_actors_and_name_entry.gv_obj_up_above_backdrop_007127 >   ;3D
  meta_entry < #00, #00, #00, #$0000, #3F, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;3E
  meta_entry < #00, #00, #00, #$0000, #41, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;3F
  meta_entry < #00, #00, #00, #$0000, #19, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.gv_obj_up_above_scenery_gated_0070B3 >   ;40
  meta_entry < #00, #00, #00, #$0000, #1A, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070C5 >   ;41
  meta_entry < #00, #00, #00, #$0000, #1A, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070C6 >   ;42
  meta_entry < #00, #00, #00, #$0000, #19, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070C9 >   ;43
  meta_entry < #00, #00, #00, #$0000, #1A, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070CB >   ;44
  meta_entry < #00, #00, #00, #$0000, #19, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070CC >   ;45
  meta_entry < #00, #00, #00, #$0000, #19, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070CD >   ;46
  meta_entry < #00, #00, #00, #$0000, #04, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070CF >   ;47
  meta_entry < #00, #00, #00, #$0000, #05, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070D5 >   ;48
  meta_entry < #00, #00, #00, #$0000, #13, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070DB >   ;49
  meta_entry < #00, #00, #00, #$0000, #15, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070E1 >   ;4A
  meta_entry < #00, #00, #00, #$0000, #16, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_0070E2 >   ;4B
  meta_entry < #00, #00, #00, #$0000, #17, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.gv_obj_up_above_boss_marker_0070E3 >   ;4C
  meta_entry < #00, #00, #00, #$0000, #14, #$2040, $7E3800, @gv_up_above_actors_and_name_entry.gv_obj_up_above_boss_marker_0070F4 >   ;4D
  meta_entry < #00, #00, #00, #$0000, #06, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_007103 >   ;4E
  meta_entry < #00, #00, #00, #$0000, #11, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.gv_obj_up_above_boss_marker_007104 >   ;4F
  meta_entry < #00, #00, #00, #$0000, #1B, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_007115 >   ;50
  meta_entry < #00, #00, #00, #$0000, #1C, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_00711B >   ;51
  meta_entry < #00, #00, #00, #$0000, #1D, #$0040, $7E3800, @gv_up_above_actors_and_name_entry.code_007121 >   ;52
  meta_entry < #00, #00, #00, #$0000, #10, #$0380, $7E3800, @gv_up_above_actors_and_name_entry.gv_obj_up_above_map_walker_006E28 >   ;53
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @gv_up_above_actors_and_name_entry.gv_obj_name_entry_voice_00797B >   ;54
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C >   ;55
  meta_entry < #00, #00, #00, #$0000, #00, #$0380, $7E3800, @gv_front_end.gv_obj_title_and_prologue_0066FC >   ;56
  meta_entry < #00, #00, #00, #$0000, #00, #$0380, $7E3800, @gv_front_end.gv_obj_ending_sequence_00729D >   ;57
  meta_entry < #00, #00, #00, #$0000, #23, #$0040, $7E3800, @gv_village_actors_019475.gv_obj_chief_rocking_chair_01A34B >   ;58
  meta_entry < #00, #00, #00, #$0000, #1E, #$0040, $7E3800, @gv_village_actors_019475.gv_npc_castle_entrance_voice_01AA26 >   ;59
  meta_entry < #00, #00, #00, #$0000, #47, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;5A
  meta_entry < #00, #00, #00, #$0000, #00, #$0380, $7E3800, @gv_front_end.gv_obj_boot_loader_0066C6 >   ;5B
  meta_entry < #00, #00, #00, #$0000, #07, #$0050, $7E3800, @gv_underground_castle_actors.gv_npc_fairy_heart_of_castle_01ADF8 >   ;5C
  meta_entry < #00, #00, #00, #$0000, #25, #$0040, $7E3800, @gv_up_above_trial_room_and_lisa_turbo_actors.gv_npc_lisa_epilogue_01B33A >   ;5D
  meta_entry < #00, #00, #00, #$0000, #18, #$0050, $7E3800, @gv_up_above_trial_room_and_lisa_turbo_actors.gv_npc_turbo_01B967 >   ;5E
]

---------------------------------------------
; World 1 (GreenWood): 81 meta entries (file offsets 34112-35245).
; 
; When: world_index 1: the Woods of GreenWood, the mole and squirrel scenes, Lostside a marsh, the three shrines and the dream rooms 23 and 24.
; Sees: the GreenWood monsters, NPCs and objects.
; Why: see the block note.
; In: n/a (data); row = list + type x 14.
; Out: type $00 the hero. Enemy types matched by HP and EXP (inferred): $2C Water Lizard, $2D Mud Man, $2E Walking Plant, $2F Stone Statue, $30 Purple Flower (the Bee shares its stats), $33 Spirit Ball, $35 Ghost Head or Green Lizard Man (same stats), $3D Elemental Statues (boss: HP 50 and EXP 30 per statue, three of them; the monster of lair record $50), $48 Fire Man, $49 Metal Scorpion. $31 (EXP $3000), $37 (HP 12, EXP 12) and $38 (HP 15, EXP 15) match no bestiary row (OQ-I033-3).
; Clobbers: n/a (data).

MetaGreenwood [
  meta_entry < #01, #02, #03, #$0005, #00, #$1180, @data_anim_player.PlayerAnims, @player_core.InitPlayerActor >   ;00
  meta_entry < #00, #00, #00, #$0000, #03, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;01
  meta_entry < #00, #00, #00, #$0000, #07, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;02
  meta_entry < #00, #00, #00, #$0000, #08, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;03
  meta_entry < #00, #00, #00, #$0000, #09, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;04
  meta_entry < #00, #00, #00, #$0000, #0A, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;05
  meta_entry < #01, #02, #03, #$0000, #0B, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @gw_lostside_marsh_actors.gw_effect_fire_bridge_heat_01E98D >   ;06
  meta_entry < #00, #00, #00, #$0000, #0C, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;07
  meta_entry < #00, #00, #00, #$0000, #0D, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;08
  meta_entry < #00, #00, #00, #$0000, #0E, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;09
  meta_entry < #00, #00, #00, #$0000, #0F, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0A
  meta_entry < #00, #00, #00, #$0000, #10, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0B
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @gw_lostside_marsh_actors.gw_effect_water_ripple_hdma_01EAFB >   ;0C
  meta_entry < #00, #00, #00, #$0000, #0E, #$3040, $7E3800, @gw_woods_actors_01B98D.gw_npc_dog_restaurant_01B98D >   ;0D
  meta_entry < #00, #00, #00, #$0000, #14, #$3040, $7E3800, @gw_woods_actors_01B98D.gw_npc_deer_woodstin_trio_01BB3F >   ;0E
  meta_entry < #00, #00, #00, #$0000, #0E, #$3040, $7E3800, @gw_woods_actors_01B98D.gw_npc_dog_graveyard_guard_01BCEC >   ;0F
  meta_entry < #00, #00, #00, #$0000, #18, #$2048, $7E3800, @gw_woods_actors_01B98D.gw_npc_bird_shy_red_hot_mirror_01BDE5 >   ;10
  meta_entry < #00, #00, #00, #$0000, #13, #$2040, $7E3800, @gw_woods_actors_01B98D.gw_npc_deer_master_emblems_01BF32 >   ;11
  meta_entry < #00, #00, #00, #$0000, #02, #$3048, $7E3800, @gw_woods_actors_01B98D.gw_npc_squirrel_stump_circler_01C2F9 >   ;12
  meta_entry < #00, #00, #00, #$0000, #1A, #$2048, $7E3800, @gw_woods_actors_01B98D.gw_npc_bird_trees_and_seeds_01C3CA >   ;13
  meta_entry < #00, #00, #00, #$0000, #0E, #$3040, $7E3800, @gw_woods_actors_01B98D.gw_npc_dog_walk_01C57B >   ;14
  meta_entry < #00, #00, #00, #$0000, #18, #$2048, $7E3800, @gw_woods_actors_01B98D.gw_npc_bird_stump_hint_01C8A4 >   ;15
  meta_entry < #00, #00, #00, #$0000, #1A, #$2048, $7E3800, @gw_woods_actors_01B98D.gw_npc_bird_turbo_grave_01C98A >   ;16
  meta_entry < #00, #00, #00, #$0000, #21, #$2050, $7E3800, @gw_woods_actors_01B98D.gw_npc_crocodile_walk_over_01CC61 >   ;17
  meta_entry < #00, #00, #00, #$0000, #21, #$2050, $7E3800, @gw_woods_actors_01B98D.gw_npc_crocodile_bridge_01CD3D >   ;18
  meta_entry < #00, #00, #00, #$0000, #21, #$2050, $7E3800, @gw_woods_actors_01B98D.gw_npc_crocodile_bridge_01CD55 >   ;19
  meta_entry < #00, #00, #00, #$0000, #0D, #$3040, $7E3800, @gw_woods_actors_01B98D.gw_npc_dog_smell_01CD6D >   ;1A
  meta_entry < #00, #00, #00, #$0000, #02, #$3040, $7E3800, @gw_woods_actors_01B98D.gw_npc_squirrel_restaurant_01CF41 >   ;1B
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @gw_woods_actors_01D045.gw_npc_squirrel_billy_01D045 >   ;1C
  meta_entry < #00, #00, #00, #$0000, #0E, #$3040, $7E3800, @gw_woods_actors_01D045.gw_npc_dog_woodstin_trio_01D2F3 >   ;1D
  meta_entry < #00, #00, #00, #$0000, #18, #$2040, $7E3800, @gw_woods_actors_01D045.gw_npc_guardian_of_the_woods_01D4F9 >   ;1E
  meta_entry < #00, #00, #00, #$0000, #18, #$2048, $7E3800, @gw_woods_actors_01D045.gw_actor_empty_01D614 >   ;1F
  meta_entry < #00, #00, #00, #$0000, #18, #$2048, $7E3800, @gw_woods_actors_01D045.gw_npc_bird_phoenix_hint_01D615 >   ;20
  meta_entry < #00, #00, #00, #$0000, #08, #$3040, $7E3800, @gw_woods_actors_01D045.gw_npc_mole_soul_of_light_01D6AB >   ;21
  meta_entry < #00, #00, #00, #$0000, #07, #$3040, $7E3800, @gw_woods_actors_01D045.gw_npc_mole_ghost_ribbon_01D8C8 >   ;22
  meta_entry < #00, #00, #00, #$0000, #06, #$3040, $7E3800, @gw_woods_actors_01D045.gw_npc_mole_digger_01D98E >   ;23
  meta_entry < #00, #00, #00, #$0000, #08, #$2048, $7E3800, @gw_woods_actors_01D045.gw_npc_mole_prankster_01DB3F >   ;24
  meta_entry < #00, #00, #00, #$0000, #07, #$3048, $7E3800, @gw_woods_actors_01D045.gw_npc_mole_roommate_bracelet_01DBE5 >   ;25
  meta_entry < #00, #00, #00, #$0000, #06, #$3040, $7E3800, @gw_woods_actors_01D045.gw_npc_mole_monmo_01DDB7 >   ;26
  meta_entry < #00, #00, #00, #$0000, #02, #$3048, $7E3800, @gw_woods_actors_01D045.gw_npc_squirrel_turbo_raft_01DF73 >   ;27
  meta_entry < #00, #00, #00, #$0000, #00, #$3048, $7E3800, @gw_woods_actors_01D045.gw_npc_squirrel_exchanger_01E005 >   ;28
  meta_entry < #00, #00, #00, #$0000, #00, #$3048, $7E3800, @gw_woods_actors_01D045.gw_npc_squirrel_master_emblem_c_01E1C0 >   ;29
  meta_entry < #00, #00, #00, #$0000, #07, #$2010, @data_anim_effects.EffectAnims, @lib_0116C3.code_0116C3 >   ;2A
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @gw_lostside_marsh_actors.gw_effect_bg2_scroll_01E9C1 >   ;2B
  meta_entry < #04, #01, #0A, #$0010, #00, #$2200, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_water_lizard_0FB0F5 >   ;2C
  meta_entry < #04, #00, #0C, #$0011, #24, #$1000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_mud_man_0FB302 >   ;2D
  meta_entry < #04, #00, #06, #$0012, #0C, #$1000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_walking_plant_0FB348 >   ;2E
  meta_entry < #04, #01, #0D, #$0012, #1C, #$0200, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_stone_statue_0FB433 >   ;2F
  meta_entry < #04, #03, #03, #$0006, #14, #$0000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_purple_flower_0FB561 >   ;30
  meta_entry < #05, #00, #05, #$3000, #28, #$0001, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_floor_spears_0FB59C >   ;31
  meta_entry < #00, #00, #00, #$0000, #19, #$2040, $7E3800, @gw_lostside_marsh_actors.gw_raft_placer_01E5BA >   ;32
  meta_entry < #07, #05, #28, #$1100, #0F, #$0000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_spirit_ball_0FB5E3 >   ;33
  meta_entry < #01, #02, #05, #$0000, #12, #$0000, $7E3800, @gw_enemies_without_placement.gw_unused_enemy_still_0FB680 >   ;34
  meta_entry < #04, #03, #08, #$0014, #1A, #$0000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_ghost_head_0FB695 >   ;35
  meta_entry < #01, #02, #05, #$0000, #13, #$2000, $7E3800, @gw_enemies_without_placement.gw_unused_enemy_turret_0FB6F8 >   ;36
  meta_entry < #04, #01, #0C, #$0012, #00, #$1000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_lizard_man_chaser_0FB898 >   ;37
  meta_entry < #05, #01, #0F, #$0015, #00, #$1000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_lizard_man_wanderer_0FB8DE >   ;38
  meta_entry < #00, #00, #00, #$0000, #2D, #$0040, $7E3800, @gw_lostside_marsh_actors.gw_raft_north_entry_01E759 >   ;39
  meta_entry < #00, #00, #00, #$0000, #2D, #$0040, $7E3800, @gw_lostside_marsh_actors.gw_raft_west_entry_01E851 >   ;3A
  meta_entry < #00, #00, #00, #$0000, #2D, #$0040, $7E3800, @gw_lostside_marsh_actors.gw_raft_south_entry_01E7D5 >   ;3B
  meta_entry < #00, #00, #00, #$0000, #2D, #$0040, $7E3800, @gw_lostside_marsh_actors.gw_raft_east_entry_01E8ED >   ;3C
  meta_entry < #09, #05, #32, #$0030, #00, #$1000, $7E3800, @gw_boss_light_water_fire_statues.gw_boss_light_water_fire_statues_0033C6 >   ;3D
  meta_entry < #00, #00, #00, #$0000, #0C, #$2050, $7E3800, @w1_actor_01E4BB.gw_actor_fixed_gem_pickup_01E4BB >   ;3E
  meta_entry < #00, #00, #00, #$0000, #0C, #$0050, $7E3800, @gw_lostside_marsh_actors.gw_npc_fairy_gem_exp_150_01E4C3 >   ;3F
  meta_entry < #00, #00, #00, #$0000, #0C, #$2050, $7E3800, @gw_lostside_marsh_actors.gw_npc_fairy_gem_exp_180_01E510 >   ;40
  meta_entry < #00, #00, #00, #$0000, #0C, #$2050, $7E3800, @gw_lostside_marsh_actors.gw_npc_fairy_gem_light_arrow_01E540 >   ;41
  meta_entry < #00, #00, #00, #$0000, #2D, #$0040, $7E3800, @gw_lostside_marsh_actors.gw_raft_leaves_check_01E62A >   ;42
  meta_entry < #00, #00, #00, #$0000, #19, #$0040, $7E3800, @gw_woods_actors_01D045.gw_npc_bird_birds_dream_01E241 >   ;43
  meta_entry < #00, #00, #00, #$0000, #27, #$0040, $7E3800, @gw_woods_actors_01D045.gw_npc_turbo_ghost_01E2FB >   ;44
  meta_entry < #00, #00, #00, #$0000, #1A, #$0050, $7E3800, @gw_woods_actors_01D045.gw_npc_bird_stumps_dream_01E3E2 >   ;45
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @gw_woods_actors_01D045.gw_effect_wave_hdma_01E9D3 >   ;46
  meta_entry < #00, #00, #00, #$0000, #40, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;47
  meta_entry < #04, #01, #0C, #$0013, #1F, #$1000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_fire_man_0FB9D6 >   ;48
  meta_entry < #05, #09, #1E, #$0350, #25, #$0000, $7E3800, @gw_lostside_marsh_enemies.gw_enemy_metal_scorpion_0FBABC >   ;49
  meta_entry < #00, #00, #00, #$0000, #43, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;4A
  meta_entry < #00, #00, #00, #$0000, #0B, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;4B
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C >   ;4C
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @gw_lostside_marsh_actors.gw_npc_fairy_gem_return_only_01E594 >   ;4D
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $000000, @gw_woods_actors_01D045.gw_npc_mole_light_return_voice_01D857 >   ;4E
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $000000, @gw_woods_actors_01D045.gw_npc_squirrel_exchanger_return_voice_01E134 >   ;4F
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $000000, @gw_lostside_marsh_actors.gw_trigger_strange_bottle_01E47B >   ;50
]

---------------------------------------------
; World 2 (St. Elles): 87 meta entries (file offsets 35246-36463).
; 
; When: world_index 2: St. Elles shrine, the Seabed Sanctuary, the secret caves, Southerta, Durean, the ghost ship and the seabed.
; Sees: the St. Elles monsters, NPCs and objects.
; Why: see the block note.
; In: n/a (data); row = list + type x 14.
; Out: type $00 the hero. Enemy types matched by HP and EXP (inferred): $32 Sea Urchin, $34 Jellyfish, $35 Hermit Crab, $36 Manta Ray, $37 Yellow Seahorse, $3A Walking Tree, $3B Monster Rock, $3C Purple Fish, $3D Ape, $3E Metal Ape, $3F Tornadic Eagle, $41 Floating Skull (boss; ROM HP 69, the bestiary says 70: OQ-I033-1; the monster of lair record $B6), $44 and $46 Purple Worms (two types).
; Clobbers: n/a (data).

MetaStElles [
  meta_entry < #01, #02, #03, #$0005, #00, #$1180, @data_anim_player.PlayerAnims, @player_core.InitPlayerActor >   ;00
  meta_entry < #00, #00, #00, #$0000, #03, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;01
  meta_entry < #00, #00, #00, #$0000, #11, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;02
  meta_entry < #00, #00, #00, #$0000, #12, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;03
  meta_entry < #00, #00, #00, #$0000, #16, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;04
  meta_entry < #00, #00, #00, #$0000, #17, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;05
  meta_entry < #00, #00, #00, #$0000, #18, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;06
  meta_entry < #00, #00, #00, #$0000, #19, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @se_st_elles_coast_actors.se_obj_durean_volcano_0FA5D6 >   ;07
  meta_entry < #00, #00, #00, #$0000, #1A, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;08
  meta_entry < #00, #00, #00, #$0000, #1B, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;09
  meta_entry < #00, #00, #00, #$0000, #1C, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0A
  meta_entry < #00, #00, #00, #$0000, #1D, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0B
  meta_entry < #00, #00, #00, #$0000, #1E, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0C
  meta_entry < #00, #00, #00, #$0000, #11, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_dolphin_servas_dream_0F8000 >   ;0D
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_angelfish_soul_of_shield_0F80A4 >   ;0E
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_angelfish_jumper_0F8209 >   ;0F
  meta_entry < #00, #00, #00, #$0000, #06, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_medical_herb_0F82DD >   ;10
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_angelfish_best_jumper_0F83AD >   ;11
  meta_entry < #00, #00, #00, #$0000, #01, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_kanna_0F85E1 >   ;12
  meta_entry < #00, #00, #00, #$0000, #01, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_nanna_0F873E >   ;13
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_statue_blester_path_0F87A9 >   ;14
  meta_entry < #00, #00, #00, #$0000, #2B, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_statue_blester_path_0F87A9 >   ;15
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_angelfish_coral_reef_creek_0F8850 >   ;16
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_angelfish_coral_reef_monsters_0F88CC >   ;17
  meta_entry < #00, #00, #00, #$0000, #08, #$2050, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_queens_maid_0F8941 >   ;18
  meta_entry < #00, #00, #00, #$0000, #06, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_servas_friend_0F89CF >   ;19
  meta_entry < #00, #00, #00, #$0000, #06, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_dance_teacher_0F8446 >   ;1A
  meta_entry < #00, #00, #00, #$0000, #11, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_dolphin_four_statues_0F8A0E >   ;1B
  meta_entry < #00, #00, #00, #$0000, #2B, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_statue_rockbird_path_0F8A7E >   ;1C
  meta_entry < #00, #00, #00, #$0000, #08, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_bubble_armor_0F8B6A >   ;1D
  meta_entry < #00, #00, #00, #$0000, #02, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_guard_east_0F8CCB >   ;1E
  meta_entry < #00, #00, #00, #$0000, #06, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_tears_hint_0F8D58 >   ;1F
  meta_entry < #00, #00, #00, #$0000, #2B, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_statue_durean_path_0F8E99 >   ;20
  meta_entry < #00, #00, #00, #$0000, #10, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_dolphin_pearl_ride_0F8F45 >   ;21
  meta_entry < #00, #00, #00, #$0000, #02, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_magic_flair_0F905C >   ;22
  meta_entry < #00, #00, #00, #$0000, #18, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_queen_0F911E >   ;23
  meta_entry < #00, #00, #00, #$0000, #2B, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_statue_ghost_ship_path_0F961C >   ;24
  meta_entry < #00, #00, #00, #$0000, #0F, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_queen_dream_0F96B9 >   ;25
  meta_entry < #00, #00, #00, #$0000, #08, #$2050, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_queen_dream_0F96B9 >   ;26
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_coral_reef_pearls_0F9793 >   ;27
  meta_entry < #00, #00, #00, #$0000, #08, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_coral_reef_pearls_0F9793 >   ;28
  meta_entry < #00, #00, #00, #$0000, #06, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_red_hot_stick_0F982F >   ;29
  meta_entry < #00, #00, #00, #$0000, #01, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8000.se_npc_mermaid_anna_0F8577 >   ;2A
  meta_entry < #00, #00, #00, #$0000, #02, #$2040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_mermaid_guard_west_0F98F5 >   ;2B
  meta_entry < #00, #00, #00, #$0000, #0E, #$2050, $7E3800, @se_seabed_of_st_elles_actors.se_npc_dolphin_dream_cave_0F9AFD >   ;2C
  meta_entry < #00, #00, #00, #$0000, #0E, #$2050, $7E3800, @se_seabed_of_st_elles_actors.se_npc_dolphin_lue_0F9B8B >   ;2D
  meta_entry < #00, #00, #00, #$0000, #11, #$2050, $7E3800, @se_seabed_of_st_elles_actors.se_npc_dolphin_lue_friend_0F9DBE >   ;2E
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @se_st_elles_coast_actors.se_effect_bg2_scroll_follow_0FA7A1 >   ;2F
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $7E3800, @w2_actor_0FA6F5.w2_effect_player_overlay_0FA6F5 >   ;30
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @se_seabed_sanctuary_actors_0F8D58.se_effect_sanctuary_wave_hdma_0FA7C4 >   ;31
  meta_entry < #09, #02, #24, #$0020, #04, #$1000, $7E3800, @se_seabed_of_st_elles_enemies.se_enemy_sea_urchin_0FBB1F >   ;32
  meta_entry < #01, #02, #03, #$0000, #22, #$2310, $7E3800, @se_enemy_0FBB78.se_unused_enemy_drifting_0FBB78 >   ;33
  meta_entry < #06, #01, #0A, #$0025, #00, #$0000, $7E3800, @se_seabed_of_st_elles_enemies.se_enemy_jellyfish_0FBBA3 >   ;34
  meta_entry < #09, #04, #0F, #$0022, #1A, #$1000, $7E3800, @se_seabed_of_st_elles_enemies.se_enemy_hermit_crab_0FBC22 >   ;35
  meta_entry < #08, #03, #0A, #$0030, #08, #$0000, $7E3800, @se_seabed_of_st_elles_enemies.se_enemy_manta_ray_0FBD12 >   ;36
  meta_entry < #06, #03, #08, #$0021, #11, #$0000, $7E3800, @se_seabed_of_st_elles_enemies.se_enemy_yellow_seahorse_0FBE81 >   ;37
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $7E3800, @se_st_elles_coast_enemies.se_obj_lightning_pyramid_0FBF25 >   ;38
  meta_entry < #07, #00, #01, #$0000, #03, #$2000, $7E3800, @se_st_elles_coast_enemies.se_obj_durean_vent_0FBFA1 >   ;39
  meta_entry < #06, #02, #0A, #$0022, #06, #$1000, $7E3800, @se_st_elles_coast_enemies.se_enemy_walking_tree_0FC01E >   ;3A
  meta_entry < #08, #03, #14, #$0024, #1D, #$0000, $7E3800, @se_st_elles_coast_enemies.se_enemy_monster_rock_0FC0E5 >   ;3B
  meta_entry < #07, #02, #08, #$0020, #2F, #$2000, $7E3800, @se_st_elles_coast_enemies.se_enemy_purple_fish_0FC14E >   ;3C
  meta_entry < #07, #02, #0C, #$0023, #0E, #$1000, $7E3800, @se_st_elles_coast_enemies.se_enemy_ape_0FC296 >   ;3D
  meta_entry < #09, #01, #1E, #$0035, #0E, #$1000, $7E3800, @se_st_elles_coast_enemies.se_enemy_metal_ape_0FC3E8 >   ;3E
  meta_entry < #07, #00, #15, #$0028, #21, #$0000, $7E3800, @se_st_elles_coast_enemies.se_enemy_tornadic_eagle_0FC536 >   ;3F
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @se_seabed_of_st_elles_actors.se_effect_seabed_wave_hdma_0FA874 >   ;40
  meta_entry < #11, #08, #45, #$0200, #00, #$0000, $7E3800, @se_boss_floating_skull.se_boss_floating_skull_003E43 >   ;41
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @se_seabed_of_st_elles_actors.se_obj_water_current_0FA59C >   ;42
  meta_entry < #00, #00, #00, #$0000, #36, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;43
  meta_entry < #09, #08, #05, #$0010, #1A, #$0200, $7E3800, @se_ghost_ship_enemies.se_enemy_purple_worm_004102 >   ;44
  meta_entry < #0A, #00, #01, #$0000, #23, #$0201, $7E3800, @se_ghost_ship_enemies.se_enemy_ghost_ship_torch_0041A0 >   ;45
  meta_entry < #09, #08, #05, #$0010, #1A, #$0300, $7E3800, @se_ghost_ship_enemies.se_obj_worm_burst_004248 >   ;46
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $7E3800, @se_seabed_of_st_elles_actors.se_effect_underwater_breath_0FA64B >   ;47
  meta_entry < #00, #00, #00, #$0000, #25, #$0040, $7E3800, @se_seabed_of_st_elles_actors.se_obj_statue_gate_rockbird_0F9ED4 >   ;48
  meta_entry < #00, #00, #00, #$0000, #25, #$0040, $7E3800, @se_seabed_of_st_elles_actors.se_obj_statue_gate_blester_0F9F24 >   ;49
  meta_entry < #00, #00, #00, #$0000, #25, #$0040, $7E3800, @se_seabed_of_st_elles_actors.se_obj_statue_gate_durean_0F9F74 >   ;4A
  meta_entry < #00, #00, #00, #$0000, #25, #$0040, $7E3800, @se_seabed_of_st_elles_actors.se_obj_statue_gate_ghost_ship_0F9FC4 >   ;4B
  meta_entry < #00, #00, #00, #$0000, #2B, #$0040, $7E3800, @se_seabed_sanctuary_actors_0F8D58.se_npc_statue_arrival_hint_0FA014 >   ;4C
  meta_entry < #00, #00, #00, #$0000, #10, #$0040, $7E3800, @se_seabed_of_st_elles_actors.se_npc_dolphin_big_pearl_0FA106 >   ;4D
  meta_entry < #00, #00, #00, #$0000, #02, #$0040, $7E3800, @se_ghost_ship_actors.se_npc_servas_father_0FA23B >   ;4E
  meta_entry < #00, #00, #00, #$0000, #0E, #$0040, $7E3800, @se_ghost_ship_actors.se_npc_servas_son_0FA3A5 >   ;4F
  meta_entry < #00, #00, #00, #$0000, #0C, #$2050, $7E3800, @se_st_elles_coast_actors.se_npc_fairy_exp_200_0FA440 >   ;50
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C >   ;51
  meta_entry < #00, #00, #00, #$0000, #0C, #$2050, $7E3800, @se_seabed_of_st_elles_actors.se_npc_fairy_exp_300_0FA494 >   ;52
  meta_entry < #00, #00, #00, #$0000, #0C, #$2050, $7E3800, @se_seabed_of_st_elles_actors.se_npc_fairy_exp_250_0FA4C4 >   ;53
  meta_entry < #00, #00, #00, #$0000, #0C, #$2050, $7E3800, @se_st_elles_coast_actors.se_npc_fairy_pyramid_hint_0FA4F4 >   ;54
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @se_st_elles_coast_actors.se_obj_durean_hot_coals_0FA5BF >   ;55
  meta_entry < #00, #00, #00, #$0000, #07, #$2010, @data_anim_effects.EffectAnims, @lib_0116C3.code_01172E >   ;56
]

---------------------------------------------
; World 3 (Mountain of Souls): 68 meta entries (file offsets 36464-37415).
; 
; When: world_index 3: the Soul's Sanctuary, the mountain north slope, Aurora's Ridge, the lake of Lune, Poseidon, the snow mountain and the ice field.
; Sees: the Mountain of Souls monsters, NPCs and objects.
; Why: see the block note.
; In: n/a (data); row = list + type x 14.
; Out: type $00 the hero. Enemy types matched by HP and EXP (inferred): $2D Green Lizard, $2E Undead Caribou, $2F Yeti, $30 Fire Bat, $32 Purple Wizard, $33 Red Wizard, $34 Ice Maker, $36 Cave Bat, $37 Green Blob, $38 Poseidon (boss; ROM HP 79, the bestiary says 70: OQ-I033-1; the monster of lair record $103). $31 (EXP $2000) and $35 (EXP $4000) match no bestiary row (OQ-I033-3).
; Clobbers: n/a (data).

MetaMountainOfSouls [
  meta_entry < #01, #02, #03, #$0005, #00, #$1180, @data_anim_player.PlayerAnims, @player_core.InitPlayerActor >   ;00
  meta_entry < #00, #00, #00, #$0000, #03, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;01
  meta_entry < #00, #00, #00, #$0000, #13, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;02
  meta_entry < #00, #00, #00, #$0000, #14, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;03
  meta_entry < #00, #00, #00, #$0000, #15, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;04
  meta_entry < #00, #00, #00, #$0000, #1F, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;05
  meta_entry < #00, #00, #00, #$0000, #20, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;06
  meta_entry < #00, #00, #00, #$0000, #21, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;07
  meta_entry < #00, #00, #00, #$0000, #22, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;08
  meta_entry < #00, #00, #00, #$0000, #23, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;09
  meta_entry < #00, #00, #00, #$0000, #24, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0A
  meta_entry < #00, #00, #00, #$0000, #25, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0B
  meta_entry < #00, #00, #00, #$0000, #26, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0C
  meta_entry < #00, #00, #00, #$0000, #27, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0D
  meta_entry < #00, #00, #00, #$0000, #28, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0E
  meta_entry < #00, #00, #00, #$0000, #29, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;0F
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @ms_dungeon_actors.ms_effect_hdma_bg2_shear_02230A >   ;10
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @ms_dungeon_actors.ms_effect_hdma_bg2_wave_02237E >   ;11
  meta_entry < #00, #00, #00, #$0000, #0E, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_grandpa_room_invite_020000 >   ;12
  meta_entry < #00, #00, #00, #$0000, #0E, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_grandpa_wife_magic_0200F5 >   ;13
  meta_entry < #00, #00, #00, #$0000, #14, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_grandma_magic_demo_020143 >   ;14
  meta_entry < #00, #00, #00, #$0000, #02, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_boy_girlfriend_0201D2 >   ;15
  meta_entry < #00, #00, #00, #$0000, #08, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_girl_new_love_020237 >   ;16
  meta_entry < #00, #00, #00, #$0000, #0E, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_grandpa_search_laynole_0202BA >   ;17
  meta_entry < #00, #00, #00, #$0000, #14, #$2058, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_grandma_phoenix_east_02032B >   ;18
  meta_entry < #00, #00, #00, #$0000, #14, #$2058, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_grandma_phoenix_west_020452 >   ;19
  meta_entry < #00, #00, #00, #$0000, #24, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_king_phoenix_020563 >   ;1A
  meta_entry < #00, #00, #00, #$0000, #25, #$2050, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_mushroom_dream_secret_020C53 >   ;1B
  meta_entry < #00, #00, #00, #$0000, #00, #$2058, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_boy_mushroom_shoes_020CC6 >   ;1C
  meta_entry < #00, #00, #00, #$0000, #1E, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_snail_vehicle_020EE9 >   ;1D
  meta_entry < #00, #00, #00, #$0000, #25, #$2050, $7E3800, @ms_soul_of_mountain_house_actors_020000.ms_npc_mushroom_dream_rod_020F9B >   ;1E
  meta_entry < #00, #00, #00, #$0000, #00, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_boy_leo_lab_hint_02100B >   ;1F
  meta_entry < #00, #00, #00, #$0000, #1E, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_snail_nome_silver_stone_02108F >   ;20
  meta_entry < #00, #00, #00, #$0000, #0E, #$2058, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_grandpa_lucky_blade_021263 >   ;21
  meta_entry < #00, #00, #00, #$0000, #1A, #$2050, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_snail_jockey_legend_0212FE >   ;22
  meta_entry < #00, #00, #00, #$0000, #1A, #$2050, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_snail_jockey_flash_021455 >   ;23
  meta_entry < #00, #00, #00, #$0000, #1A, #$2050, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_snail_jockey_third_0215B1 >   ;24
  meta_entry < #00, #00, #00, #$0000, #25, #$2050, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_mushroom_short_lives_021711 >   ;25
  meta_entry < #00, #00, #00, #$0000, #0E, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_grandpa_lune_gate_0217D9 >   ;26
  meta_entry < #00, #00, #00, #$0000, #0C, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_grandpa_dream_rod_0218BF >   ;27
  meta_entry < #00, #00, #00, #$0000, #1E, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_snail_old_man_child_02195F >   ;28
  meta_entry < #00, #00, #00, #$0000, #25, #$2050, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_mushroom_prison_0219CE >   ;29
  meta_entry < #00, #00, #00, #$0000, #1E, #$2040, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_snail_master_emblem_e_021A4B >   ;2A
  meta_entry < #00, #00, #00, #$0000, #06, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_girl_race_starter_021ACA >   ;2B
  meta_entry < #00, #00, #00, #$0000, #06, #$2048, $7E3800, @ms_soul_of_mountain_house_actors_02100B.ms_npc_girl_mountain_warm_021CB0 >   ;2C
  meta_entry < #09, #06, #08, #$0065, #09, #$0300, $7E3800, @ms_multi_area_enemies.ms_enemy_green_lizard_0FC72F >   ;2D
  meta_entry < #0B, #06, #19, #$0070, #28, #$0000, $7E3800, @ms_multi_area_enemies.ms_enemy_undead_caribou_0FC845 >   ;2E
  meta_entry < #0A, #03, #14, #$0080, #00, #$0000, $7E3800, @ms_multi_area_enemies.ms_enemy_yeti_0FC8FE >   ;2F
  meta_entry < #09, #05, #0E, #$0085, #0F, #$0000, $7E3800, @ms_multi_area_enemies.ms_enemy_fire_bat_0FC9BC >   ;30
  meta_entry < #0A, #04, #28, #$2000, #12, #$0000, $7E3800, @ms_multi_area_enemies.ms_enemy_snowball_0FCA35 >   ;31
  meta_entry < #0E, #05, #11, #$0085, #00, #$0000, $7E3800, @ms_multi_area_enemies.ms_enemy_purple_wizard_0FCBDF >   ;32
  meta_entry < #0E, #04, #14, #$0100, #00, #$0000, $7E3800, @ms_multi_area_enemies.ms_enemy_red_wizard_0FCDBA >   ;33
  meta_entry < #0E, #07, #18, #$0070, #18, #$0000, $7E3800, @ms_enemy_0FCFD6.ms_enemy_ice_maker_0FCFD6 >   ;34
  meta_entry < #0D, #00, #18, #$4000, #1A, #$0001, $7E3800, @ms_enemy_0FD058.ms_enemy_ice_crystal_0FD058 >   ;35
  meta_entry < #0D, #06, #0E, #$0075, #28, #$0000, $7E3800, @ms_multi_area_enemies.ms_enemy_cave_bat_0FD11B >   ;36
  meta_entry < #0C, #06, #0C, #$0080, #2B, #$1000, $7E3800, @ms_multi_area_enemies.ms_enemy_green_blob_0FD1E5 >   ;37
  meta_entry < #10, #0C, #4F, #$0400, #14, #$0200, $7E3800, @ms_boss_poseidon.ms_boss_poseidon_004299 >   ;38
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @ms_multi_area_actors.ms_obj_push_zone_setup_02220D >   ;39
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @ms_snow_mountain_actors.ms_obj_ice_marker_scan_021F52 >   ;3A
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @ms_snow_mountain_actors.ms_obj_ice_slide_022007 >   ;3B
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @ms_dungeon_actors.ms_effect_hdma_coldata_gradient_022457 >   ;3C
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C >   ;3D
  meta_entry < #00, #00, #00, #$0000, #00, #$2050, $7E3800, @ms_multi_area_actors.ms_npc_fairy_exp_300_021ECE >   ;3E
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @ms_multi_area_actors.ms_npc_fairy_exp_400_021F22 >   ;3F
  meta_entry < #00, #00, #00, #$0000, #01, #$0040, $7E3800, @ms_dungeon_actors.ms_npc_old_man_dream_021D14 >   ;40
  meta_entry < #00, #00, #00, #$0000, #08, #$0040, $7E3800, @ms_dungeon_actors.ms_npc_old_man_dream_girl_021DF8 >   ;41
  meta_entry < #00, #00, #00, #$0000, #25, #$0040, $7E3800, @ms_dungeon_actors.ms_npc_mushroom_dream_021DF9 >   ;42
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @ms_dungeon_actors.ms_obj_master_emblem_f_021E8F >   ;43
]

---------------------------------------------
; World 4 (Leo's Laboratory): 55 meta entries (file offsets 37416-38185).
; 
; When: world_index 4: the laboratory, the attic, the mice nest, the basement, the power plant and the town models.
; Sees: the laboratory monsters, NPCs and objects.
; Why: see the block note.
; In: n/a (data); row = list + type x 14.
; Out: type $00 the hero. Enemy types matched by HP and EXP (inferred): $1E Tin Doll (boss; ROM HP 89, the bestiary says 80: OQ-I033-1; the monster of lair record $12F), $1F Mini Race Car, $20 Mini Bulldozer, $21 Mini Helicopter, $22 Ball Worm, $24 Sweeper Bot, $25 Toy Soldier, $28 Catapult, $29 Spike Launcher. $27 (HP 24, EXP 175) is the nearest to the Toy Calvary (29 HP, 175 EXP); $26 (HP 20, EXP 170) and $23 (EXP $1000) match nothing (OQ-I033-3).
; Clobbers: n/a (data).

MetaLeosLab [
  meta_entry < #01, #02, #03, #$0005, #00, #$1180, @data_anim_player.PlayerAnims, @player_core.InitPlayerActor >   ;00
  meta_entry < #00, #00, #00, #$0000, #03, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;01
  meta_entry < #00, #00, #00, #$0000, #2F, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;02
  meta_entry < #00, #00, #00, #$0000, #30, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;03
  meta_entry < #00, #00, #00, #$0000, #31, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;04
  meta_entry < #00, #00, #00, #$0000, #04, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_drawers_exercise_022523 >   ;05
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_door_silent_0225C4 >   ;06
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_door_locked_key_02260D >   ;07
  meta_entry < #00, #00, #00, #$0000, #0A, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_mouse_cats_scared_0226C0 >   ;08
  meta_entry < #00, #00, #00, #$0000, #10, #$3040, $7E3800, @ll_laboratory_actors.ll_npc_cat_follower_a_022794 >   ;09
  meta_entry < #00, #00, #00, #$0000, #14, #$3040, $7E3800, @ll_laboratory_actors.ll_npc_cat_follower_b_022886 >   ;0A
  meta_entry < #00, #00, #00, #$0000, #15, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_cat_door_hint_02297C >   ;0B
  meta_entry < #00, #00, #00, #$0000, #04, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_drawers_mystic_armor_0229DF >   ;0C
  meta_entry < #00, #00, #00, #$0000, #03, #$2050, $7E3800, @ll_laboratory_actors.ll_npc_plant_door_soul_hint_022AFB >   ;0D
  meta_entry < #00, #00, #00, #$0000, #03, #$2050, $7E3800, @ll_laboratory_actors.ll_npc_plant_medical_herb_022B80 >   ;0E
  meta_entry < #00, #00, #00, #$0000, #03, #$2050, $7E3800, @ll_laboratory_actors.ll_npc_plant_models_story_022C7C >   ;0F
  meta_entry < #00, #00, #00, #$0000, #0B, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_mouse_purify_022D05 >   ;10
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_door_silent_022DC6 >   ;11
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_door_soul_of_detection_022E10 >   ;12
  meta_entry < #00, #00, #00, #$0000, #14, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_cat_dream_key_022F68 >   ;13
  meta_entry < #00, #00, #00, #$0000, #0A, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_mouse_magic_hint_02312F >   ;14
  meta_entry < #00, #00, #00, #$0000, #03, #$2050, $7E3800, @ll_laboratory_actors.ll_npc_plant_actinidia_02317F >   ;15
  meta_entry < #00, #00, #00, #$0000, #16, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_doll_machines_story_023214 >   ;16
  meta_entry < #00, #00, #00, #$0000, #04, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_drawers_herb_storage_0232B3 >   ;17
  meta_entry < #00, #00, #00, #$0000, #12, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_cat_marie_room_02345D >   ;18
  meta_entry < #00, #00, #00, #$0000, #16, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_marie_purple_stone_0234EC >   ;19
  meta_entry < #00, #00, #00, #$0000, #0A, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_mouse_weak_timid_0237A7 >   ;1A
  meta_entry < #00, #00, #00, #$0000, #0B, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_mouse_born_plant_02382D >   ;1B
  meta_entry < #00, #00, #00, #$0000, #0C, #$2040, $7E3800, @ll_laboratory_actors.ll_npc_mouse_spark_bomb_0238A7 >   ;1C
  meta_entry < #00, #00, #00, #$0000, #2E, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;1D
  meta_entry < #16, #0F, #59, #$0800, #0A, #$0000, $7E3800, @ll_boss_tin_doll.ll_boss_tin_doll_004659 >   ;1E
  meta_entry < #0D, #08, #0C, #$0150, #00, #$0000, $7E3800, @ll_laboratory_dungeon_enemies.ll_enemy_mini_race_car_0FD275 >   ;1F
  meta_entry < #12, #08, #0E, #$0145, #06, #$0000, $7E3800, @ll_laboratory_dungeon_enemies.ll_enemy_mini_bulldozer_0FD345 >   ;20
  meta_entry < #0E, #09, #12, #$0160, #0F, #$0000, $7E3800, @ll_laboratory_dungeon_enemies.ll_enemy_mini_helicopter_0FD402 >   ;21
  meta_entry < #0E, #07, #12, #$0150, #1A, #$0000, $7E3800, @ll_laboratory_dungeon_enemies.ll_enemy_ball_worm_0FD502 >   ;22
  meta_entry < #15, #00, #01, #$1000, #24, #$0200, $7E3800, @ll_laboratory_dungeon_enemies.ll_enemy_flail_0FD6EC >   ;23
  meta_entry < #0E, #08, #18, #$0140, #28, #$0000, $7E3800, @ll_laboratory_dungeon_enemies.ll_enemy_sweeper_bot_0FD752 >   ;24
  meta_entry < #0F, #06, #10, #$0165, #00, #$0000, $7E3800, @ll_town_models_enemies.ll_enemy_toy_soldier_0FD944 >   ;25
  meta_entry < #10, #08, #14, #$0170, #06, #$0000, $7E3800, @ll_town_models_enemies.ll_enemy_toy_spear_0FD9E6 >   ;26
  meta_entry < #11, #09, #18, #$0175, #12, #$0000, $7E3800, @ll_town_models_enemies.ll_enemy_toy_lunge_0FDAED >   ;27
  meta_entry < #13, #09, #1E, #$0180, #1E, #$0000, $7E3800, @ll_town_models_enemies.ll_enemy_catapult_0FDBFB >   ;28
  meta_entry < #12, #0A, #24, #$0160, #2B, #$0000, $7E3800, @ll_town_models_enemies.ll_enemy_spike_launcher_0FDCFC >   ;29
  meta_entry < #00, #00, #00, #$0000, #07, #$2010, @data_anim_effects.EffectAnims, @lib_0116C3.code_011707 >   ;2A
  meta_entry < #00, #00, #00, #$0000, #19, #$2040, $7E3800, @ll_laboratory_actors.ll_obj_model_town_1_0239BA >   ;2B
  meta_entry < #00, #00, #00, #$0000, #19, #$2040, $7E3800, @ll_laboratory_actors.ll_obj_model_town_2_0239F8 >   ;2C
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C >   ;2D
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @ll_laboratory_dungeon_actors.ll_obj_fire_pit_023F17 >   ;2E
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @ll_laboratory_dungeon_actors.ll_npc_fairy_exp_300_023DD3 >   ;2F
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @ll_town_models_actors.ll_npc_fairy_exp_300_023E27 >   ;30
  meta_entry < #00, #00, #00, #$0000, #07, #$2040, $7E3800, @ll_town_models_actors.ll_effect_model_release_023E87 >   ;31
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @ll_laboratory_dungeon_actors.ll_npc_fairy_exp_300_023E57 >   ;32
  meta_entry < #00, #00, #00, #$0000, #00, #$0040, $7E3800, @ll_laboratory_actors.ll_npc_door_entrance_talk_023A36 >   ;33
  meta_entry < #00, #00, #00, #$0000, #20, #$0040, $7E3800, @ll_laboratory_actors.ll_dream_scene_023B0B >   ;34
  meta_entry < #00, #00, #00, #$0000, #14, #$0040, $7E3800, @ll_laboratory_actors.ll_dream_actor_a_023D6B >   ;35
  meta_entry < #00, #00, #00, #$0000, #13, #$0040, $7E3800, @ll_laboratory_actors.ll_dream_actor_b_023D84 >   ;36
]

---------------------------------------------
; World 5 (Magridd's Castle): 62 meta entries (file offsets 38186-39053).
; 
; When: world_index 5: the castle, the towers, the torture chamber, the basement, the dock and the deck.
; Sees: the castle monsters, NPCs and objects.
; Why: see the block note.
; In: n/a (data); row = list + type x 14.
; Out: type $00 the hero. Enemy types matched by HP and EXP (inferred): $09 Demon Falcon (boss; ROM HP 99, the bestiary says 90: OQ-I033-1; the monster of lair record $195), $0C Bouncing Ball, $0D Wraithe, $0E Green Snake, $11 Purple Knight, $12 Red Knight, $15 Mimic, $16 Bronze Robot, $17 Chess Knight. $0A (HP 5, EXP 800) and $10 (HP 23, EXP 750) match no bestiary row (OQ-I033-3).
; Clobbers: n/a (data).

MetaMagriddsCastle [
  meta_entry < #01, #02, #03, #$0005, #00, #$1180, @data_anim_player.PlayerAnims, @player_core.InitPlayerActor >   ;00
  meta_entry < #00, #00, #00, #$0000, #03, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;01
  meta_entry < #00, #00, #00, #$0000, #32, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;02
  meta_entry < #00, #00, #00, #$0000, #33, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;03
  meta_entry < #00, #00, #00, #$0000, #07, #$2010, @data_anim_effects.EffectAnims, @lib_0116C3.code_0116E2 >   ;04
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @mc_airship_dock_actors.mc_dock_key_wheel_026F57 >   ;05
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @mc_airship_dock_actors.mc_deck_bg2_scroll_y_fast_026F48 >   ;06
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @mc_airship_dock_actors.mc_dream_bg2_scroll_y_026F53 >   ;07
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @mc_castle_towers_actors.mc_towers_bg2_scroll_x_026F44 >   ;08
  meta_entry < #1A, #14, #63, #$5000, #08, #$0000, $7E3800, @mc_boss_demon_falcon.mc_boss_demon_falcon_004BEE >   ;09
  meta_entry < #15, #00, #05, #$0800, #00, #$0001, $7E3800, @mc_castle_dungeon_enemies.mc_obj_wall_spear_0FDE48 >   ;0A
  meta_entry < #12, #00, #01, #$0000, #02, #$2200, $7E3800, @mc_castle_dungeon_enemies.mc_obj_statue_shooter_0FDE71 >   ;0B
  meta_entry < #12, #08, #14, #$0900, #0A, #$0000, $7E3800, @mc_castle_dungeon_enemies.mc_enemy_bouncing_ball_0FDFC3 >   ;0C
  meta_entry < #14, #0A, #16, #$0700, #15, #$0000, $7E3800, @mc_castle_dungeon_enemies.mc_enemy_wraithe_0FE045 >   ;0D
  meta_entry < #14, #0A, #10, #$0600, #1D, #$1000, $7E3800, @mc_castle_dungeon_enemies.mc_enemy_green_snake_0FE14E >   ;0E
  meta_entry < #01, #02, #03, #$0000, #23, #$0210, $7E3800, @mc_castle_dungeon_enemies.mc_obj_wall_prop_0FE22C >   ;0F
  meta_entry < #13, #0B, #17, #$0750, #3C, #$1200, $7E3800, @mc_castle_dungeon_enemies.mc_enemy_skeleton_soldier_0FE236 >   ;10
  meta_entry < #16, #0A, #1E, #$0750, #00, #$1000, $7E3800, @mc_castle_towers_enemies.mc_enemy_purple_knight_0FE413 >   ;11
  meta_entry < #17, #0B, #24, #$0950, #00, #$1000, $7E3800, @mc_castle_towers_enemies.mc_enemy_red_knight_0FE4F2 >   ;12
  meta_entry < #01, #02, #03, #$0000, #1C, #$0210, $7E3800, @mc_castle_towers_enemies.mc_obj_static_prop_0FE610 >   ;13
  meta_entry < #12, #00, #00, #$0000, #1D, #$2200, $7E3800, @mc_castle_towers_enemies.mc_obj_statue_shooter_0FE61A >   ;14
  meta_entry < #18, #0C, #19, #$1000, #25, #$1200, $7E3800, @mc_castle_towers_enemies.mc_enemy_mimic_0FE76C >   ;15
  meta_entry < #15, #0B, #14, #$0800, #2D, #$0000, $7E3800, @mc_castle_towers_enemies.mc_enemy_bronze_robot_0FE83E >   ;16
  meta_entry < #17, #0D, #1C, #$0850, #3D, #$0000, $7E3800, @mc_castle_towers_enemies.mc_enemy_chess_knight_0FE88E >   ;17
  meta_entry < #00, #00, #00, #$0000, #14, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_ghost_hint_023FA8 >   ;18
  meta_entry < #00, #00, #00, #$0000, #13, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_gaudi_nephew_024027 >   ;19
  meta_entry < #00, #00, #00, #$0000, #0E, #$2048, $7E3800, @mc_castle_actors.mc_npc_inert_placeholder_0240E4 >   ;1A
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_elemental_hint_0240E5 >   ;1B
  meta_entry < #00, #00, #00, #$0000, #28, #$2040, $7E3800, @mc_castle_actors.mc_npc_soldier_elemental_mail_024259 >   ;1C
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_guard_patrol_024416 >   ;1D
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_king_shock_0244EF >   ;1E
  meta_entry < #00, #00, #00, #$0000, #1B, #$2040, $7E3800, @mc_castle_actors.mc_npc_singer_theater_harp_024597 >   ;1F
  meta_entry < #00, #00, #00, #$0000, #13, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_traitor_warning_02488E >   ;20
  meta_entry < #00, #00, #00, #$0000, #0C, #$2048, $7E3800, @mc_castle_actors.mc_npc_queen_vip_card_02494A >   ;21
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_platinum_gate_guard_024AF4 >   ;22
  meta_entry < #00, #00, #00, #$0000, #13, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_theater_guard_024BC8 >   ;23
  meta_entry < #00, #00, #00, #$0000, #1B, #$2040, $7E3800, @mc_castle_actors.mc_npc_singer_friend_story_024D59 >   ;24
  meta_entry < #00, #00, #00, #$0000, #0E, #$2048, $7E3800, @mc_castle_actors.mc_npc_maid_medical_herb_024E53 >   ;25
  meta_entry < #00, #00, #00, #$0000, #0D, #$2048, $7E3800, @mc_castle_actors.mc_npc_maid_music_listener_024F4A >   ;26
  meta_entry < #00, #00, #00, #$0000, #0C, #$2048, $7E3800, @mc_castle_actors.mc_npc_maid_dormitory_dust_024FD3 >   ;27
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_vip_gate_guard_025080 >   ;28
  meta_entry < #00, #00, #00, #$0000, #14, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_shiny_hint_02515B >   ;29
  meta_entry < #00, #00, #00, #$0000, #14, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_soul_of_reality_0251DC >   ;2A
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_emblem_h_025302 >   ;2B
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_airship_key_stolen_0253E2 >   ;2C
  meta_entry < #00, #00, #00, #$0000, #14, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_herb_maid_fan_0254A2 >   ;2D
  meta_entry < #00, #00, #00, #$0000, #13, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_river_scare_025502 >   ;2E
  meta_entry < #00, #00, #00, #$0000, #00, #$2050, $7E3800, @mc_castle_actors.mc_npc_king_magridd_025561 >   ;2F
  meta_entry < #00, #00, #00, #$0000, #12, #$2048, $7E3800, @mc_castle_actors.mc_npc_soldier_dust_in_eye_025AAA >   ;30
  meta_entry < #00, #00, #00, #$0000, #14, #$2048, $7E3800, @mc_airship_dock_actors.mc_dock_soldier_start_ship_025B1A >   ;31
  meta_entry < #00, #00, #00, #$0000, #14, #$2048, $7E3800, @mc_airship_dock_actors.mc_dock_soldier_outburst_025CA6 >   ;32
  meta_entry < #00, #00, #00, #$0000, #1F, #$2040, $7E3800, @mc_airship_dock_actors.mc_dock_dr_leo_025E61 >   ;33
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @mc_airship_dock_actors.mc_deck_airship_return_026D80 >   ;34
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @mc_castle_dungeon_actors.mc_obj_floor_spikes_026F30 >   ;35
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C >   ;36
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @mc_castle_towers_actors.mc_npc_fairy_chest_hint_026DD7 >   ;37
  meta_entry < #00, #00, #00, #$0000, #07, #$2050, $7E3800, @mc_castle_dungeon_actors.mc_npc_fairy_dungeon_hint_026E9D >   ;38
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @mc_airship_dock_actors.mc_deck_push_zones_027019 >   ;39
  meta_entry < #00, #00, #00, #$0000, #00, #$2000, $000000, @mc_castle_dungeon_actors.mc_obj_harp_string_pickup_0269F6 >   ;3A
  meta_entry < #00, #00, #00, #$0000, #23, #$0040, $7E3800, @mc_airship_dock_actors.mc_dream_soldier_dialogue_026A4E >   ;3B
  meta_entry < #00, #00, #00, #$0000, #14, #$0040, $7E3800, @mc_airship_dock_actors.mc_dream_actor_a_026D61 >   ;3C
  meta_entry < #00, #00, #00, #$0000, #13, #$0040, $7E3800, @mc_airship_dock_actors.mc_dream_actor_b_026D76 >   ;3D
]

---------------------------------------------
; World 6 (World of Evil): 21 meta entries (file offsets 39054-39347).
; 
; When: world_index 6: the shrine, the World of Evil, the Dazzling Space and the battle with Deathtoll.
; Sees: the last world's monsters and Deathtoll.
; Why: see the block note.
; In: n/a (data); row = list + type x 14.
; Out: type $00 the hero. Enemy types matched by HP and EXP (inferred): $09 Deathtoll (first form: HP 99, EXP 0), $0A Purple Bull (HP 45, EXP 2,700; the bestiary says 23 HP: OQ-I033-2), $0B Firefly, $0C Wall Tile, $11 Deathtoll (final form: HP 100, defence $FF). The two forms add up to 199 HP and the bestiary says 200 HP in total (OQ-I033-1).
; Clobbers: n/a (data).

MetaWorldOfEvil [
  meta_entry < #01, #02, #03, #$0005, #00, #$1180, @data_anim_player.PlayerAnims, @player_core.InitPlayerActor >   ;00
  meta_entry < #00, #00, #00, #$0000, #03, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;01
  meta_entry < #00, #00, #00, #$0000, #34, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;02
  meta_entry < #00, #00, #00, #$0000, #35, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;03
  meta_entry < #00, #00, #00, #$0000, #37, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @we_evil_world_actors.we_obj_dazzling_space_hazard_01EECA >   ;04
  meta_entry < #00, #00, #00, #$0000, #38, #$2010, @data_anim_palette_cycles.PaletteAnimLists, @shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 >   ;05
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @we_evil_world_actors.we_fx_bg2_hofs_wave_01EEF3 >   ;06
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @we_evil_world_actors.we_fx_bg2_vofs_wobble_01F063 >   ;07
  meta_entry < #00, #00, #00, #$0000, #00, #$2010, $000000, @w6_actor_01F14F.we_fx_battle_bg2_hofs_bands_01F14F >   ;08
  meta_entry < #1A, #15, #63, #$0000, #00, #$0200, $7E3800, @we_deathtolls_shrine_actors.we_boss_deathtoll_mage_004D8B >   ;09
  meta_entry < #19, #0C, #2D, #$2700, #00, #$1000, $7E3800, @we_evil_world_enemies.we_enemy_purple_bull_0FEA1D >   ;0A
  meta_entry < #18, #0C, #17, #$3000, #15, #$0000, $7E3800, @we_evil_world_enemies.we_enemy_firefly_0FEB95 >   ;0B
  meta_entry < #1D, #01, #0A, #$4000, #2A, #$0000, $7E3800, @we_evil_world_enemies.we_enemy_wall_tile_0FECD9 >   ;0C
  meta_entry < #19, #00, #01, #$0000, #2C, #$2300, $7E3800, @we_evil_world_enemies.we_enemy_popup_turret_0FED09 >   ;0D
  meta_entry < #19, #00, #01, #$0000, #29, #$2000, $7E3800, @we_evil_world_enemies.we_enemy_arc_jet_0FED8F >   ;0E
  meta_entry < #19, #00, #01, #$0000, #29, #$2000, $7E3800, @we_evil_world_enemies.we_enemy_static_hazard_0FEEA5 >   ;0F
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C >   ;10
  meta_entry < #1C, #FF, #64, #$0000, #0F, #$0201, $7E3800, @we_deathtolls_shrine_actors.we_boss_deathtoll_demon_005043 >   ;11
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @w6_actor_01EC4B.we_obj_master_shrine_event_01EC4B >   ;12
  meta_entry < #00, #00, #00, #$0000, #20, #$2050, $7E3800, @we_deathtolls_shrine_actors.we_boss_deathtoll_mage_handover_004F4D >   ;13
  meta_entry < #00, #00, #00, #$0000, #00, #$2040, $7E3800, @we_evil_world_actors.we_obj_phoenix_call_scene_01EE6D >   ;14
]