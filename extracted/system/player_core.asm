; The player: spawn script, input filter, action choice, per-frame motion finish, push zones, corner slide, Gem pull and return-trip facing, together with the 28 pose handlers, the four swings, PayPhoenixCost, PublishPlayerAnim and the four Phoenix projectiles (file offsets 5394-8143 and 9848-9959, SNES $00:9512-$9FCF and $00:A678-$A6E7, bank 00). The blade layer, soul orb, spells and level-up of the same hero are in player_spells_level_up.
; 
; === ONE ACTOR, FIVE HELPERS ===
; The hero is one actor per scene, created from the first record of the world's meta table (WorldMetaPointers: seven identical entries with animation 0, $16 = $1180, animation table PlayerAnims and the script InitPlayerActor). InitPlayerActor stores its slot in player_actor, selects the sprite tile source $7F:3000 (COP A9) and clones five helpers, each of which starts as a copy of the player: WatchForLevelUp (COP 84), RunSoulOrb (84; it spawns RunSoulOrbController), FilterPlayerInput (84), FinishPlayerMove (85) and RunWeaponLayer (85). Run order inside a frame: WatchForLevelUp, RunSoulOrb, RunSoulOrbController, FilterPlayerInput, the player, RunWeaponLayer, FinishPlayerMove. So the controller reads joy_pressed before the filter strips B and Y (spells work without a weapon), and it sees the position that FinishPlayerMove published in the previous frame.
; With return_active set (the scene is entered from a stored return point: return_area, return_scene, return_x, return_y and the switch record return_record) InitPlayerActor spawns only the level-up watcher and the hero becomes FacePlayerTowardReturnTarget: no orb, filter, weapon layer or camera follow. Every scene load builds the full set again.
; 
; === ANIMATION STEPS, NOT FRAMES ===
; An actor script resumes when its countdown $14 underflows. COP 82 steps the animation and the actor yields for the step duration plus one frame; the engine applies the step velocity ($04 dx, $06 dy) every frame. So the player script runs once per animation step, not once per frame: a walk cycle is six steps, and the first step of every walk handler moves 2 px per frame in all four directions (static reading, OQ-I032-15). The idle animations $00-$03 are one step of duration 0, so while the hero stands the script runs every frame and decides again at once. Whatever has to react between two steps (a released key, the sword button) must cut in from outside: that is the job of FilterPlayerInput, which writes ChoosePlayerAction into the resume pointer $18.
; Direction codes are the game's own: 0 up, 1 down, 2 right, 3 left for the facing (PlayerFacingByAnim) and for the movement direction (PlayerMoveDirByAnim). The idle animations $00-$03 are the poses facing down, up, left, right.
; 
; === CHOOSING THE ACTION ===
; ChoosePlayerAction runs after every animation. A dying hero ($16 bit $0400) goes to PlayPlayerDeath. With no weapon or in a no-combat scene the unarmed path is used, otherwise the armed path. Plain walking is a direct branch (Right, Left, Down, Up in that priority; BRL StartWalkRight and so on). Everything else goes through PlayerActionTable: 44 rows (one per animation $00-$2B) of 6 handler addresses, slot 0 = B (armed only), 1 = Right, 2 = Left, 3 = Down, 4 = Up, 5 = no key. The table path is taken when L or R is held, when B is held (armed), or when no direction is held (idle).
; The rows depend only on the facing of the current animation, except the twelve rows $14-$1F (all StartIdleUp). So the table says: keep the facing, choose the pose of the pressed key. With L or R held the hero keeps his facing, which is the crab-walk of the walkthrough (02-grass-valley.md: 'press and hold the L or R Button to basically move sideways', with a sword also a thrust). Pressing a direction without L or R turns him that way.
; The carry on entry to a handler picks between the two animation ids of the paired handlers: clear = pose family $00-$13 (unarmed, or armed with L or R held: the thrust, the blade stays out); set = armed without L or R, pose family $24-$2B (sword carried). The sword hurts only while the animation is below $24 (ApplySwordHit).
; 
; === MOTION ===
; FinishPlayerMove runs after the player: the push of a conveyor or wind (ScanPushZones reads an 8-byte record list: x0, x1, y0, y1 tile bounds, dx and dy words in pixels per frame, a first byte of $FF ends the list; 13 lists and 54 records in the game, 52 of them move 1 px per frame and two in St. Elles 4 px), else the corner slide, an even-pixel snap, the published position, the blade layer and the camera. The conveyor belts are in Grass Valley (walkthrough chapter 2), the wind in Magridd's Castle (chapter 7: 'the wind on the ship will be pushing you back').
; SlideAroundCorner lets the hero slide 2 px along a wall into a gap when his key is held and he is not tile aligned on the other axis. PullGemsToPlayer pulls Gems toward a hero who stands still with the sword out and L or R held (the thrust idle).
; 
; === NOTES ===
; - Walkthrough: crab-walk and thrust with L or R (chapters 1 and 2), the minimum level of a weapon applies to the B swing but not to thrusts (items.md), conveyor belts (chapter 2) and ship wind (chapter 7). The walkthrough does not name the hero (you choose a name), so the notes say 'the hero'.
; - An earlier reading called PullGemsToPlayer a 'sword push-back scan'; the code moves pickups toward the hero and touches no enemy (OQ-I032-1).
; - Dead or unexplained: SlideUnusedReturn is an unreferenced RTS; AnimKeepKeyMask words $14-$23 are never read; animations $14-$1B and $1D-$1F are protected by the filter but nothing identified plays them (OQ-I032-2).
; - Bank limits: every JSR inside the file is a 2-byte reference, so the filter, motion and Gem routines must stay in bank 00 with their callees; PlayerActionTable holds 2-byte handler addresses, so the table and the handlers share bank 00.
---------------------------------------------

?BANK 00

?INCLUDE 'data_engine_tables'
?INCLUDE 'engine_actor_scheduler_and_sprites'
?INCLUDE 'engine_tile_collision'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'lib_map_scroll_and_redraw'
?INCLUDE 'lib_menus'
?INCLUDE 'player_spells_level_up'

!scene_next                     0318
!joy_pressed                    0322
!joy_block_mask                 0326
!joy_release_latch              032A
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_anim                 0380
!player_actor                   039C
!player_weapon_actor            039E
!soul_orb_actor                 03A0
!subframe_active                03A6
!world_index                    03BA
!push_dx                        03D4
!push_dy                        03D6
!push_zone_list                 03D8
!push_zone_bank                 03DA
!return_active                  03FB
!return_record                  0405
!no_combat_scene                0439
!player_hidden_count            0464
!actor_list_tail                06A6
!equipped_weapon                1B5E
!equipped_armor                 1B60
!equipped_magic                 1B62
!player_level_bcd               1B6A
!gear_power                     1B70
!level_power                    1B72
!gear_defense                   1B74
!level_defense                  1B76
!attack_current                 1B8C
!defense_current                1B8E
!switch_owner_table             7F0483
!tile_type_map                  7F8000

---------------------------------------------

; Filters the buttons the player script may see and cuts an animation short when its key is released or B is pressed.
; 
; When: once per frame, before the player script (helper actor spawned by InitPlayerActor).
; Sees: no swing in towns and rooms without combat, no swing with a sword above the hero's level, a walk step ends the moment the key is let go, and a swing starts in the middle of a walk.
; Why: the player script runs once per animation step, so a key release or a button press has to cut in from outside: this actor writes ChoosePlayerAction into the player's resume pointer ($18).
; In: actor script, X = own slot, M = X = 16 bits. Reads player_hidden_count, no_combat_scene, equipped_weapon, player_level_bcd, WeaponMinLevelBcd, AnimKeepKeyMask and the player's $16 and $1E.
; Out: joy_pressed = 0 while player_hidden_count != 0 (cutscenes); B and Y cleared without a weapon or in a no-combat scene; with a weapon PullGemsToPlayer runs and B is cleared when the weapon's minimum level is above player_level_bcd (L and R are never touched: thrusts need no level); animations $14-$23 are never interrupted; otherwise B pressed, or the key of the current animation released: player $18 = ChoosePlayerAction. A dying hero ($16 bit $0400) gets the same $18 and COP 91, so this actor idles for good.
; Clobbers: A, Y (= player_actor); X restored (PHX / PLX around the weapon check); dp$00, $16 and $18 through PullGemsToPlayer.

FilterPlayerInput {
    LDA $player_hidden_count
    BEQ FilterCheckWeapon
    STZ $joy_pressed

  FilterCheckWeapon:
    LDA $no_combat_scene
    BNE FilterNoWeapon
    LDA $equipped_weapon
    BNE FilterArmed

  FilterNoWeapon:
    LDY $player_actor
    LDA #$C000
    TRB $joy_pressed
    BRA FilterCheckDying

  FilterArmed:
    JSR $&PullGemsToPlayer
    PHX 
    DEC 
    ASL 
    TAX 
    LDA $@lib_menus.WeaponMinLevelBcd, X
    CMP $player_level_bcd ; weapon minimum level (BCD word at (id - 1) x 2) against the player level: from there on B swings; thrusts never need a level
    BEQ FilterAfterMinLevel
    BCC FilterAfterMinLevel
    LDA #$8000
    TRB $joy_pressed

  FilterAfterMinLevel:
    PLX 
    LDY $player_actor
    LDA $001E, Y
    SEC 
    SBC #$0014            ; animations $14-$23 (swings $20-$23, death $1C, others unidentified) are never interrupted: return at once
    CMP #$0010
    BCC FilterReturn
    LDA $joy_pressed
    AND #$8000            ; B pressed in any other animation: leave it now, so a swing can start in the middle of a walk
    BNE FilterLeaveAnimation

  FilterCheckDying:
    LDA $0016, Y
    BIT #$0400
    BNE FilterPlayerDying
    PHX 
    LDA $001E, Y
    ASL 
    TAX 
    LDA $@AnimKeepKeyMask, X
    PLX 
    AND $joy_pressed      ; AnimKeepKeyMask: the d-pad bit that keeps this animation going; zero here means the key was released
    BEQ FilterLeaveAnimation

  FilterReturn:
    RTL 

  FilterLeaveAnimation:
    LDA #$&ChoosePlayerAction ; force: the player script resumes at ChoosePlayerAction on its next run and abandons the animation
    STA $0018, Y
    RTL 

  FilterPlayerDying:
    LDA #$&ChoosePlayerAction
    STA $0018, Y
    COP [91]              ; dying: the entry point becomes the RTL below, so this actor idles for good
    RTL 
}
---------------------------------------------

; Per animation, the d-pad bit that keeps the animation going.
; 
; When: FilterPlayerInput, every frame, indexed by the player's animation x 2 (44 words).
; Sees: a walk step goes on only while its key is held; letting go cuts the step short.
; Why: data, one word per animation $00-$2B.
; In: n/a (data).
; Out: n/a. $0400 Down, $0800 Up, $0200 Left, $0100 Right. Animations $00-$13 name their movement direction (idle $00-$03 = Down, Up, Left, Right; the backstep and sidestep poses name the direction they move in); $14-$23 are $0000 and never read (the filter returns before the table for them); $24-$2B (armed idle and walk) = Right, Right, Left, Left, Down, Down, Up, Up.
; Clobbers: n/a.

AnimKeepKeyMask [
  #$0400   ;00
  #$0800   ;01
  #$0200   ;02
  #$0100   ;03
  #$0400   ;04
  #$0800   ;05
  #$0800   ;06
  #$0400   ;07
  #$0200   ;08
  #$0100   ;09
  #$0100   ;0A
  #$0200   ;0B
  #$0100   ;0C
  #$0200   ;0D
  #$0200   ;0E
  #$0100   ;0F
  #$0400   ;10
  #$0800   ;11
  #$0800   ;12
  #$0400   ;13
  #$0000   ;14
  #$0000   ;15
  #$0000   ;16
  #$0000   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$0000   ;1C
  #$0000   ;1D
  #$0000   ;1E
  #$0000   ;1F
  #$0000   ;20
  #$0000   ;21
  #$0000   ;22
  #$0000   ;23
  #$0100   ;24
  #$0100   ;25
  #$0200   ;26
  #$0200   ;27
  #$0400   ;28
  #$0400   ;29
  #$0800   ;2A
  #$0800   ;2B
]
---------------------------------------------

; Finishes the hero's move each frame: applies the push of a conveyor or wind, makes the position even, publishes it, places the blade layer and aims the camera.
; 
; When: once per frame after the player script and RunWeaponLayer (helper actor, $16 bit $0010: it also runs in sub-frames, so the hero is published while a dialogue runs).
; Sees: conveyor belts carry the hero (Grass Valley, walkthrough chapter 2), the wind on the ship pushes him back (Magridd's Castle, chapter 7), two push records in St. Elles move him 4 px per frame; the screen follows him.
; Why: the position other code reads (player_x/y, tile x/y), the blade sprite and the camera must all come from one finished position, after the player's own step and the push.
; In: actor script, X = own slot (PHX / PLX around the body). Reads push_zone_list, push_dx, push_dy, joy_block_mask, player_weapon_actor, WeaponYOffsetByAnim.
; Out: under a push zone the hero's velocity is swapped for the zone speed for one MoveActorWithTileCollision, the clipped result is stored back in push_dx / push_dy and added to the position (no corner slide); otherwise SlideAroundCorner. When no d-pad bit of joy_block_mask is set, each axis without push is made even (AND #$FFFE). push_dx and push_dy are cleared; player_x, player_y, player_tile_x (x >> 4) and player_tile_y ((y >> 4) - 1) written; the blade actor is placed at the player's x and y + WeaponYOffsetByAnim[animation]; AimCameraAtPlayer.
; Clobbers: A, Y; X restored.

FinishPlayerMove {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    PHX 
    LDX $player_actor
    JSR $&ScanPushZones
    BCC MoveCornerSlide
    LDA $0004, X
    PHA 
    LDA $0006, X
    PHA 
    LDA $push_dx
    STA $0004, X
    LDA $push_dy
    STA $0006, X
    JSL $@engine_tile_collision.MoveActorWithTileCollision ; tile collision clips the zone speed; the clipped value goes back into push_dx and push_dy and is added to the position
    LDA $0004, X
    STA $push_dx
    CLC 
    ADC $0000, X
    STA $0000, X
    LDA $0006, X
    STA $push_dy
    CLC 
    ADC $0002, X
    STA $0002, X
    PLA 
    STA $0006, X
    PLA 
    STA $0004, X
    BRA MoveSnapToEven

  MoveCornerSlide:
    JSR $&SlideAroundCorner

  MoveSnapToEven:
    LDA $joy_block_mask
    BIT #$0F00
    BNE MovePublishPosition
    LDA $push_dx
    BNE MoveSnapY
    LDA $0000, X
    AND #$FFFE            ; free d-pad and no push on x: make x even again (walk steps are 2 px, an odd conveyor speed leaves odd pixels)
    STA $0000, X

  MoveSnapY:
    LDA $push_dy
    BNE MovePublishPosition
    LDA $0002, X
    AND #$FFFE            ; the same for y
    STA $0002, X

  MovePublishPosition:
    STZ $push_dx
    STZ $push_dy
    LDA $0000, X
    STA $player_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $0002, X
    STA $player_y
    LSR 
    LSR 
    LSR 
    LSR 
    DEC 
    STA $player_tile_y
    LDY $player_weapon_actor
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
    LDA $001E, X
    ASL 
    TAX 
    LDA $&data_engine_tables.WeaponYOffsetByAnim, X
    CLC 
    ADC $0002, Y
    STA $0002, Y
    JSL $@lib_map_scroll_and_redraw.AimCameraAtPlayer
    PLX 
    RTL 
}

---------------------------------------------
; Finds the push zone under the hero and publishes his position.
; 
; When: FinishPlayerMove, once per frame (JSR).
; Sees: nothing by itself; the zones are the conveyor belts of Grass Valley, the pushes of St. Elles and Mountain of Souls and the ship wind of Magridd's Castle (one-shot actors in those rooms store the list pointer in push_zone_list and push_zone_bank).
; Why: the zones are data (8-byte records: x0, x1, y0, y1 tile bounds, then dx and dy words in pixels per frame; a first byte of $FF ends the list), so each room only needs its own list.
; In: X = player slot, M = 16 bits.
; Out: player_x, player_y, player_tile_x and player_tile_y are written first. No list (push_zone_list = 0) or a sub-frame running (subframe_active): carry clear, nothing scanned. Otherwise each record whose tile rectangle overlaps the hero ((x + 15) >> 4 >= x0, x >> 4 < x1, (y - 1) >> 4 >= y0, (y >> 4) - 1 < y1) sets push_dx and push_dy from its non-zero words (per axis the last overlapping record wins). Carry set when either is non-zero. DBR is the list's bank while the records are read and is restored.
; Clobbers: A, Y, dp$16, dp$18; M = 16 on return.

ScanPushZones {
    LDA $0000, X
    STA $player_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $0002, X
    STA $player_y
    LSR 
    LSR 
    LSR 
    LSR 
    DEC 
    STA $player_tile_y
    CLC 
    LDY $push_zone_list   ; zone list pointer: zero outside the rooms that install a list, then carry stays clear
    BNE ScanCheckSubframe
    RTS 

  ScanCheckSubframe:
    LDA $subframe_active
    BEQ ScanStart
    RTS 

  ScanStart:
    LDA $0000, X
    CLC 
    ADC #$000F            ; right edge tile of the hero: (x + 15) >> 4 must not be left of the record's x0
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18               ; dp$18 = (y - 1) >> 4, the top row compared with the record's y0
    SEP #$20
    PHB 
    LDA $push_zone_bank   ; the records are read with DBR = the bank of the list (restored by PLB at the end)
    PHA 
    PLB 

  ScanNextRecord:
    LDA $0000, Y
    INC 
    BEQ ScanFinish
    LDA $16
    CMP $0000, Y
    BCC ScanSkipRecord
    LDA $player_tile_x
    CMP $0001, Y
    BCS ScanSkipRecord
    LDA $18
    CMP $0002, Y
    BCC ScanSkipRecord
    LDA $player_tile_y
    CMP $0003, Y
    BCS ScanSkipRecord
    REP #$20
    LDA $0004, Y
    BEQ ScanApplyDy
    STA $push_dx          ; the last overlapping record with a non-zero dx wins; dy below works the same way

  ScanApplyDy:
    LDA $0006, Y
    BEQ ScanSkipRecord
    STA $push_dy

  ScanSkipRecord:
    REP #$20
    TYA 
    CLC 
    ADC #$0008
    TAY 
    SEP #$20
    BRA ScanNextRecord

  ScanFinish:
    REP #$20
    PLB 
    SEC 
    LDA $push_dx
    ORA $push_dy
    BNE ScanReturn
    CLC 

  ScanReturn:
    RTS 
}

---------------------------------------------
; Slides the hero around the corner of a wall instead of stopping at it.
; 
; When: FinishPlayerMove, every frame the hero is not on a push zone (JSR).
; Sees: walking into a wall a few pixels beside a gap, the hero slides 2 px sideways into the opening.
; Why: the walk steps are 2 px and the maps are built from 16 px tiles; without the slide he would have to line up exactly with every doorway.
; In: X = player slot. Needs the blocked bit $0004 of $16 (set by the walk collision) and a movement direction from GetMoveDirectionOfAnim (0 up, 1 down, 2 right, 3 left).
; Out: only when the key of that direction is held and the hero is not tile aligned on the other axis (x low nibble for up and down, y low nibble for right and left): the tile beyond the corner is tested in tile_type_map with the quadrant masks $FC (up: the two bottom quadrants), $F3 (down: top), $F5 (right: left) and $FA (left: right), each plus the high nibble. The hero moves 2 px toward the side whose tile is free (left or up first, then right or down); if neither is free nothing happens. X is preserved through TXY / TYX.
; Clobbers: A, Y, dp$16, dp$18; X changes inside PixelToMapIndex and StepMapIndex and is restored.

SlideAroundCorner {
    LDA $0016, X
    BIT #$0004
    BNE SlideGetDirection
    RTS 

  SlideGetDirection:
    JSR $&GetMoveDirectionOfAnim
    BCC SlideDispatch
    RTS 

  SlideDispatch:
    AND #$00FF
    BEQ SlideUp
    DEC 
    BEQ SlideDown
    DEC 
    BNE SlideDispatchLeft
    BRL SlideRight

  SlideDispatchLeft:
    BRL SlideLeft

  SlideUnusedReturn:
    RTS 

  SlideUp:
    LDA $joy_pressed
    BIT #$0800            ; the key of the movement direction must still be held (Up $0800, Down $0400, Right $0100, Left $0200)
    BNE SlideUpProbe
    RTS 

  SlideUpProbe:
    TXY 
    LDA $0000, X
    AND #$000F            ; only when not tile aligned on the other axis: a hero standing exactly on a tile column does not slide
    BEQ SlideUpAbort
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    AND #$00FC            ; moving up: solid test of the two bottom quadrants (4, 8) plus the high nibble of the tile type
    BEQ SlideUpFreeLeft
    JSL $@lib_map_index_helpers.StepMapIndexEast
    LDA $tile_type_map, X
    AND #$00FC
    BEQ SlideUpFreeRight

  SlideUpAbort:
    TYX 
    RTS 

  SlideUpFreeLeft:
    LDA #$FFFE
    BRA SlideUpApply

  SlideUpFreeRight:
    LDA #$0002

  SlideUpApply:
    TYX 
    CLC 
    ADC $0000, X
    STA $0000, X
    RTS 

  SlideDown:
    LDA $joy_pressed
    BIT #$0400
    BNE SlideDownProbe
    RTS 

  SlideDownProbe:
    TXY 
    LDA $0000, X
    AND #$000F
    BEQ SlideDownAbort
    LDA $0000, X
    STA $16
    LDA $0002, X
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    AND #$00F3            ; moving down: the two top quadrants (1, 2) plus the high nibble
    BEQ SlideDownFreeLeft
    JSL $@lib_map_index_helpers.StepMapIndexEast
    LDA $tile_type_map, X
    AND #$00F3
    BEQ SlideDownFreeRight

  SlideDownAbort:
    TYX 
    RTS 

  SlideDownFreeLeft:
    LDA #$FFFE
    BRA SlideDownApply

  SlideDownFreeRight:
    LDA #$0002

  SlideDownApply:
    TYX 
    CLC 
    ADC $0000, X
    STA $0000, X
    RTS 

  SlideRight:
    LDA $joy_pressed
    BIT #$0100
    BNE SlideRightProbe
    RTS 

  SlideRightProbe:
    TXY 
    LDA $0002, X
    AND #$000F
    BEQ SlideRightAbort
    LDA $0000, X
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    AND #$00F5            ; moving right: the two left quadrants (1, 4) plus the high nibble
    BEQ SlideRightFreeUp
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    LDA $tile_type_map, X
    AND #$00F5
    BEQ SlideRightFreeDown

  SlideRightAbort:
    TYX 
    RTS 

  SlideRightFreeUp:
    LDA #$FFFE
    BRA SlideRightApply

  SlideRightFreeDown:
    LDA #$0002

  SlideRightApply:
    TYX 
    CLC 
    ADC $0002, X
    STA $0002, X
    RTS 

  SlideLeft:
    LDA $joy_pressed
    BIT #$0200
    BNE SlideLeftProbe
    RTS 

  SlideLeftProbe:
    TXY 
    LDA $0002, X
    AND #$000F
    BEQ SlideLeftAbort
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    AND #$00FA            ; moving left: the two right quadrants (2, 8) plus the high nibble
    BEQ SlideLeftFreeUp
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    LDA $tile_type_map, X
    AND #$00FA
    BEQ SlideLeftFreeDown

  SlideLeftAbort:
    TYX 
    RTS 

  SlideLeftFreeUp:
    LDA #$FFFE
    BRA SlideLeftApply

  SlideLeftFreeDown:
    LDA #$0002

  SlideLeftApply:
    TYX 
    CLC 
    ADC $0002, X
    STA $0002, X
    RTS 
}

---------------------------------------------
; Returns the movement direction of the player's animation.
; 
; When: SlideAroundCorner.
; Sees: nothing; the sidestep and backstep poses move in another direction than they face.
; Why: facing and movement direction are separate tables (PlayerFacingByAnim and PlayerMoveDirByAnim).
; In: X = player slot.
; Out: carry clear and A = PlayerMoveDirByAnim[$1E] (0 up, 1 down, 2 right, 3 left; a 16-bit load of a byte table, the caller masks $FF); carry set, A unchanged, when the animation id is $2C or more.
; Clobbers: A, Y.

GetMoveDirectionOfAnim {
    LDY $001E, X
    CPY #$002C
    BCS MoveDirectionInvalid
    LDA $&data_engine_tables.PlayerMoveDirByAnim, Y
    CLC 
    RTS 

  MoveDirectionInvalid:
    SEC 
    RTS 
}

---------------------------------------------
; Pulls Gems that lie in front of a thrusting hero toward him.
; 
; When: FilterPlayerInput, every frame, only with a weapon equipped.
; Sees: standing still with L or R held and the sword out, nearby Gems slide toward the hero (the small ones fastest). The walkthrough does not mention it (OQ-I032-1: an earlier reading called it a push-back).
; Why: the purpose is not stated anywhere; the effect is a Gem magnet for the thrust.
; In: A and X are saved and restored; the hero's animation must be $00-$03 (standing still: the armed hero idles in $24-$2B unless L or R is held).
; Out: for every actor of the list (from actor_list_tail through $3E) that is not off screen ($16 bit $8000), has the pickup flag $4000 and animation $04-$06 (the three Gem sizes), PullGemTowardPlayer runs with dp$00 = the hero's idle animation (0 down, 1 up, 2 left, 3 right) and dp$16, dp$18 = player x + 8 and y + 8.
; Clobbers: Y, dp$00, dp$16, dp$18; A and X restored.

PullGemsToPlayer {
    PHX 
    PHA 
    LDY $player_actor
    LDA $001E, Y
    CMP #$0004            ; only the idle animations $00-$03: the armed hero stands still with L or R held
    BCS PullGemsDone
    STA $00
    LDA $0000, Y
    CLC 
    ADC #$0008            ; dp$16 and dp$18 = the hero's centre (x + 8, y + 8)
    STA $16
    LDA $0002, Y
    CLC 
    ADC #$0008
    STA $18
    LDA $actor_list_tail
    BRA PullGemsCheckActor

  PullGemsNextActor:
    LDA $003E, X

  PullGemsCheckActor:
    TAX 
    BEQ PullGemsDone
    LDA $0016, X
    BMI PullGemsNextActor
    BIT #$4000
    BEQ PullGemsNextActor
    LDA $001E, X
    SEC 
    SBC #$0004            ; animations $04-$06 are the three Gem sizes
    CMP #$0003
    BCS PullGemsNextActor
    JSR $&PullGemTowardPlayer
    BRA PullGemsNextActor

  PullGemsDone:
    PLA 
    PLX 
    RTS 
}

---------------------------------------------
; Moves one Gem toward the hero when it lies in the lane in front of his thrust.
; 
; When: PullGemsToPlayer, once per Gem actor and frame.
; Sees: a Gem within the 17 px lane slides in: 3 px per frame for the small Gem (animation $04), 2 for the medium ($05), 1 for the large ($06).
; Why: four copies of the same test (one per facing) share a step chain: the label the code enters decides how many pixels the Gem moves.
; In: X = the Gem actor; dp$00 = the hero's idle animation (0 down, 1 up, 2 left, 3 right); dp$16, dp$18 = the hero's centre.
; Out: facing down: the Gem must be below (y >= dp$18) and within the lane on x (dp$16 - x < $11); its y is decremented 3, 2 or 1 times. Facing up: the Gem above, y incremented. Facing left: the Gem to the left (x < dp$16), within the lane on y, x incremented. Facing right: the Gem to the right, x decremented. Outside the lane or on the wrong side: nothing.
; Clobbers: A.

PullGemTowardPlayer {
    LDA $00               ; dp$00 = the hero's idle animation: 0 down, 1 up, 2 left, 3 right
    BEQ PullGemFacingDown
    DEC 
    BEQ PullGemFacingUp
    DEC 
    BEQ PullGemFacingLeft
    BRL PullGemFacingRight

  PullGemFacingUp:
    LDA $0002, X
    CMP $18
    BCC PullGemUpLane
    RTS 

  PullGemUpLane:
    LDA $16
    SEC 
    SBC $0000, X
    CMP #$0011            ; lane 17 px wide across the thrust
    BCC PullGemUpMove
    RTS 

  PullGemUpMove:
    LDA $001E, X
    CMP #$0006            ; large Gem (animation $06) moves 1 px, medium ($05) 2, small ($04) 3: the INC / DEC chain is entered at different labels
    BEQ PullGemUpStep1
    CMP #$0005
    BEQ PullGemUpStep2
    INC $0002, X

  PullGemUpStep2:
    INC $0002, X

  PullGemUpStep1:
    INC $0002, X
    RTS 

  PullGemFacingDown:
    LDA $0002, X
    CMP $18
    BCS PullGemDownLane
    RTS 

  PullGemDownLane:
    LDA $16
    SEC 
    SBC $0000, X
    CMP #$0011
    BCC PullGemDownMove
    RTS 

  PullGemDownMove:
    LDA $001E, X
    CMP #$0006
    BEQ PullGemDownStep1
    CMP #$0005
    BEQ PullGemDownStep2
    DEC $0002, X

  PullGemDownStep2:
    DEC $0002, X

  PullGemDownStep1:
    DEC $0002, X
    RTS 

  PullGemFacingLeft:
    LDA $0000, X
    CMP $16
    BCC PullGemLeftLane
    RTS 

  PullGemLeftLane:
    LDA $18
    SEC 
    SBC $0002, X
    CMP #$0011
    BCC PullGemLeftMove
    RTS 

  PullGemLeftMove:
    LDA $001E, X
    CMP #$0006
    BEQ PullGemLeftStep1
    CMP #$0005
    BEQ PullGemLeftStep2
    INC $0000, X

  PullGemLeftStep2:
    INC $0000, X

  PullGemLeftStep1:
    INC $0000, X
    RTS 

  PullGemFacingRight:
    LDA $0000, X
    CMP $16
    BCS PullGemRightLane
    RTS 

  PullGemRightLane:
    LDA $18
    SEC 
    SBC $0002, X
    CMP #$0011
    BCC PullGemRightMove
    RTS 

  PullGemRightMove:
    LDA $001E, X
    CMP #$0006
    BEQ PullGemRightStep1
    CMP #$0005
    BEQ PullGemRightStep2
    DEC $0000, X

  PullGemRightStep2:
    DEC $0000, X

  PullGemRightStep1:
    DEC $0000, X
    RTS 
}

---------------------------------------------
; The hero's whole script after a return trip: he waits, then turns to face the actor he came from and stands still.
; 
; When: InitPlayerActor, instead of the normal player, when return_active is set (the scene is entered from a stored return point, see the block note).
; Sees: back in the scene the hero looks toward the switch owner instead of a default pose (inferred from the code, OQ-I032-10).
; Why: the hero is rebuilt with every scene load and has to be put back in front of the thing he used.
; In: actor script, X = player slot.
; Out: it waits (COP 91, RTL, so the test repeats every frame) while warp_dest_anim != 0 or while switch_owner_table[return_record] is 0. Then the dominant axis of (player - owner) decides, a tie goes to the vertical axis: idle animation $00 (down), $01 (up), $02 (left) or $03 (right) toward the owner; $20 = 0, one animation step (SetActorAnimFrame), $14 = 0; COP 91 moves the entry to the final RTL, so the hero keeps that pose.
; Clobbers: A, Y, dp$16, dp$18.

FacePlayerTowardReturnTarget {
    COP [91]
    LDA $warp_dest_anim   ; wait while warp_dest_anim is non-zero (what it holds during a return trip: OQ-I032-10)
    BEQ ReturnFindTarget
    RTL 

  ReturnFindTarget:
    PHX 
    LDA $return_record
    ASL 
    TAX 
    LDA $switch_owner_table, X ; the actor that owns the switch record the hero came from; zero means none registered yet
    PLX 
    TAY 
    BNE ReturnMeasureOffset
    RTL 

  ReturnMeasureOffset:
    LDA $0000, X
    SEC 
    SBC $0000, Y
    BMI ReturnPlayerLeftOfTarget
    STA $16
    LDA $0002, X
    SEC 
    SBC $0002, Y
    BMI ReturnPlayerAboveTarget
    STA $18
    CMP $16               ; dominant axis decides; a tie (|dy| = |dx|) faces vertically
    BCS ReturnFaceUp
    BRA ReturnFaceLeft

  ReturnPlayerAboveTarget:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCS ReturnFaceDown
    BRA ReturnFaceLeft

  ReturnPlayerLeftOfTarget:
    EOR #$FFFF
    INC 
    STA $16
    LDA $0002, X
    SEC 
    SBC $0002, Y
    BMI ReturnPlayerAboveLeftOfTarget
    STA $18
    CMP $16
    BCS ReturnFaceUp
    BRA ReturnFaceRight

  ReturnPlayerAboveLeftOfTarget:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCS ReturnFaceDown
    BRA ReturnFaceRight

  ReturnFaceDown:
    LDA #$0000
    BRA ReturnApplyFacing

  ReturnFaceLeft:
    LDA #$0002
    BRA ReturnApplyFacing

  ReturnFaceUp:
    LDA #$0001
    BRA ReturnApplyFacing

  ReturnFaceRight:
    LDA #$0003

  ReturnApplyFacing:
    STA $001E, X
    STZ $0020, X
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    STZ $0014, X
    COP [91]
    RTL 
}

---------------------------------------------
; The player's spawn script: registers the hero, starts the helper actors and falls into the action loop.
; 
; When: once per scene load, from the hero record of the world's meta table (seven identical copies in WorldMetaPointers).
; Sees: the hero appears with his orb, his sword and the camera on him.
; Why: input filter, motion finish, blade layer, orb and level-up watcher are separate actors so that each runs at its own point of the frame (see the block note).
; In: X = player slot (meta entry: animation 0, $16 = $1180, animation table PlayerAnims).
; Out: player_actor = X; sprite tile source $7F:3000 (COP A9); WatchForLevelUp spawned (COP 84). With return_active set: BRL FacePlayerTowardReturnTarget. Otherwise RunSoulOrb (COP 84; soul_orb_actor = its slot, its $16 = ($16 and $CF7F) or $0310), FilterPlayerInput (84), FinishPlayerMove (85) and RunWeaponLayer (85; player_weapon_actor = its slot), then COP 91 with the re-entry at ChoosePlayerAction.
; Clobbers: A, Y.

InitPlayerActor {
    STX $player_actor
    COP [A9] ( #$3000, #7F ) ; sprite tiles are DMAed from $7F:3000
    COP [84] ( @player_spells_level_up.WatchForLevelUp )
    LDA $return_active
    BEQ PlayerSpawnHelpers
    BRL FacePlayerTowardReturnTarget

  PlayerSpawnHelpers:
    COP [84] ( @player_spells_level_up.RunSoulOrb )
    LDA $0016, Y
    AND #$CF7F            ; orb flags: clear tile collision ($1000), hidden ($2000) and the player bit ($0080)
    ORA #$0310            ; $0310 = not a hit source ($0100), not a hit target ($0200), runs in sub-frames ($0010)
    STA $0016, Y
    STY $soul_orb_actor
    COP [84] ( @FilterPlayerInput )
    COP [85] ( @FinishPlayerMove )
    COP [85] ( @player_spells_level_up.RunWeaponLayer )
    STY $player_weapon_actor
    COP [91]              ; the re-entry point is ChoosePlayerAction: the next run makes the first action choice

; Chooses the hero's next action after every animation step.
; 
; When: the player script resumes here after an animation (all 28 pose handlers end with BRL ChoosePlayerAction), when FilterPlayerInput forces it, and once from InitPlayerActor.
; Sees: the hero walks, turns, sidesteps, thrusts or swings according to the buttons held.
; Why: the whole player behaviour is a table of 44 animations x 6 key slots (PlayerActionTable) plus two direct paths for plain walking.
; In: X = player slot, M = 16 bits. Reads $16, no_combat_scene, equipped_weapon, joy_pressed and the animation $1E.
; Out: dying ($16 bit $0400): BRL PlayPlayerDeath. Unarmed (no weapon or a no-combat scene): L or R held goes to the table, otherwise the first held key of Right, Left, Down, Up starts its walk handler directly (BRL StartWalk*), and no key goes to the table (idle). Armed: B, L or R held goes to the table, otherwise Right, Left, Down, Up directly. Table: row = animation x 12 bytes, slot 0 B (armed only), 1 Right, 2 Left, 3 Down, 4 Up, 5 none; the handler is entered by DEC / PHA / RTS. Carry on entry: clear = pose family $00-$13 (unarmed, or L or R held: the thrust keeps the blade out), set = armed without L or R, pose family $24-$2B (sword carried).
; Clobbers: A; X restored (PLX) on the table paths.

  ChoosePlayerAction:
    LDA $0016, X
    BIT #$0400
    BEQ ChooseCheckWeapon
    BRL PlayPlayerDeath

  ChooseCheckWeapon:
    LDA $no_combat_scene
    BNE ChooseUnarmed
    LDA $equipped_weapon
    BNE ChooseArmed

  ChooseUnarmed:
    LDA $joy_pressed
    BIT #$0030            ; L or R held (thrust and crab-walk): use the table so the facing is kept
    BNE ChooseUnarmedTable
    EOR #$FFFF            ; inverted d-pad: after XBA and LSR the carry is set when the key is NOT held; priority Right, Left, Down, Up
    XBA 
    LSR 
    BCS ChooseUnarmedTestLeft
    BRL StartWalkRight

  ChooseUnarmedTestLeft:
    LSR 
    BCS ChooseUnarmedTestDown
    BRL StartWalkLeft

  ChooseUnarmedTestDown:
    LSR 
    BCS ChooseUnarmedTestUp
    BRL StartWalkDown

  ChooseUnarmedTestUp:
    LSR 
    BCS ChooseUnarmedTable
    BRL StartWalkUp

  ChooseUnarmedTable:
    PHX 
    LDA $001E, X          ; row offset = animation x 12 (6 words per row)
    ASL 
    CLC 
    ADC $001E, X
    ASL 
    ASL 
    TAX 
    LDA $joy_pressed
    INX                   ; skip slot 0 (B): the unarmed hero has no swing
    INX 
    XBA 
    LSR 
    BCS ChooseUnarmedJump
    INX 
    INX 
    LSR 
    BCS ChooseUnarmedJump
    INX 
    INX 
    LSR 
    BCS ChooseUnarmedJump
    INX 
    INX 
    LSR 
    BCS ChooseUnarmedJump
    INX 
    INX 

  ChooseUnarmedJump:
    LDA $@PlayerActionTable, X
    PLX 
    DEC                   ; table words are handler addresses: DEC, PHA and RTS jump there; carry clear = pose family $00-$13
    PHA 
    CLC 
    RTS 

  ChooseArmed:
    LDA $joy_pressed
    BIT #$8030            ; B, L or R held: table path; otherwise walk directly
    BNE ChooseArmedTable
    XBA 
    LSR 
    BCC ChooseArmedTestLeft
    BRL StartWalkRight

  ChooseArmedTestLeft:
    LSR 
    BCC ChooseArmedTestDown
    BRL StartWalkLeft

  ChooseArmedTestDown:
    LSR 
    BCC ChooseArmedTestUp
    BRL StartWalkDown

  ChooseArmedTestUp:
    LSR 
    BCC ChooseArmedTable
    BRL StartWalkUp

  ChooseArmedTable:
    PHX 
    LDA $001E, X
    ASL 
    CLC 
    ADC $001E, X
    ASL 
    ASL 
    TAX 
    LDA $joy_pressed
    BIT #$8000            ; B held: slot 0 (swing), X is not advanced
    BNE ChooseArmedSetCarry
    INX 
    INX 
    XBA 
    LSR 
    BCS ChooseArmedSetCarry
    INX 
    INX 
    LSR 
    BCS ChooseArmedSetCarry
    INX 
    INX 
    LSR 
    BCS ChooseArmedSetCarry
    INX 
    INX 
    LSR 
    BCS ChooseArmedSetCarry
    INX 
    INX 

  ChooseArmedSetCarry:
    CLC 
    LDA $joy_pressed
    BIT #$0030
    BNE ChooseArmedJump
    SEC                   ; no L or R: carry set = armed pose family $24-$2B (sword carried)

  ChooseArmedJump:
    LDA $@PlayerActionTable, X
    PLX 
    DEC 
    PHA 
    RTS 
}
---------------------------------------------

; The state table of the player: 44 rows (one per animation $00-$2B) of 6 handler addresses.
; 
; When: ChoosePlayerAction, table path (two LDA @PlayerActionTable,X).
; Sees: which pose follows which key: with L or R held the hero keeps his facing and sidesteps; B starts a swing when armed.
; Why: every row depends only on the facing of its animation (PlayerFacingByAnim), except the twelve rows $14-$1F (all StartIdleUp), so the table says: keep the facing, choose the pose of the pressed key.
; In: n/a (data). Row = animation x 12 bytes, slot x 2: B, Right, Left, Down, Up, none.
; Out: n/a. Resulting animations by facing (x or y = carry clear or carry set): facing down (rows $00 $04 $05 $0C $0D $20 $28 $29): swing $20, Right $0C, Left $0D, Down $04 or $28, Up $05, none $00 or $29. Facing up (rows $01 $06 $07 $0E $0F $21 $2A $2B): $21, $0F, $0E, $07, $06 or $2A, $01 or $2B. Facing left (rows $02 $08 $09 $10 $11 $22 $26 $27): $22, $09, $08 or $26, $10, $11, $02 or $27. Facing right (rows $03 $0A $0B $12 $13 $23 $24 $25): $23, $0A or $25, $0B, $13, $12, $03 or $24. The handlers are the 28 Start* and Swing* routines below.
; Clobbers: n/a.

PlayerActionTable [
  &SwingDown   ;00
  &StartSidestepDownRight   ;01
  &StartSidestepDownLeft   ;02
  &StartWalkDown   ;03
  &StartBackstepDown   ;04
  &StartIdleDown   ;05
  &SwingUp   ;06
  &StartSidestepUpRight   ;07
  &StartSidestepUpLeft   ;08
  &StartBackstepUp   ;09
  &StartWalkUp   ;0A
  &StartIdleUp   ;0B
  &SwingLeft   ;0C
  &StartBackstepLeft   ;0D
  &StartWalkLeft   ;0E
  &StartSidestepLeftDown   ;0F
  &StartSidestepLeftUp   ;10
  &StartIdleLeft   ;11
  &SwingRight   ;12
  &StartWalkRight   ;13
  &StartBackstepRight   ;14
  &StartSidestepRightDown   ;15
  &StartSidestepRightUp   ;16
  &StartIdleRight   ;17
  &SwingDown   ;18
  &StartSidestepDownRight   ;19
  &StartSidestepDownLeft   ;1A
  &StartWalkDown   ;1B
  &StartBackstepDown   ;1C
  &StartIdleDown   ;1D
  &SwingDown   ;1E
  &StartSidestepDownRight   ;1F
  &StartSidestepDownLeft   ;20
  &StartWalkDown   ;21
  &StartBackstepDown   ;22
  &StartIdleDown   ;23
  &SwingUp   ;24
  &StartSidestepUpRight   ;25
  &StartSidestepUpLeft   ;26
  &StartBackstepUp   ;27
  &StartWalkUp   ;28
  &StartIdleUp   ;29
  &SwingUp   ;2A
  &StartSidestepUpRight   ;2B
  &StartSidestepUpLeft   ;2C
  &StartBackstepUp   ;2D
  &StartWalkUp   ;2E
  &StartIdleUp   ;2F
  &SwingLeft   ;30
  &StartBackstepLeft   ;31
  &StartWalkLeft   ;32
  &StartSidestepLeftDown   ;33
  &StartSidestepLeftUp   ;34
  &StartIdleLeft   ;35
  &SwingLeft   ;36
  &StartBackstepLeft   ;37
  &StartWalkLeft   ;38
  &StartSidestepLeftDown   ;39
  &StartSidestepLeftUp   ;3A
  &StartIdleLeft   ;3B
  &SwingRight   ;3C
  &StartWalkRight   ;3D
  &StartBackstepRight   ;3E
  &StartSidestepRightDown   ;3F
  &StartSidestepRightUp   ;40
  &StartIdleRight   ;41
  &SwingRight   ;42
  &StartWalkRight   ;43
  &StartBackstepRight   ;44
  &StartSidestepRightDown   ;45
  &StartSidestepRightUp   ;46
  &StartIdleRight   ;47
  &SwingDown   ;48
  &StartSidestepDownRight   ;49
  &StartSidestepDownLeft   ;4A
  &StartWalkDown   ;4B
  &StartBackstepDown   ;4C
  &StartIdleDown   ;4D
  &SwingDown   ;4E
  &StartSidestepDownRight   ;4F
  &StartSidestepDownLeft   ;50
  &StartWalkDown   ;51
  &StartBackstepDown   ;52
  &StartIdleDown   ;53
  &SwingUp   ;54
  &StartSidestepUpRight   ;55
  &StartSidestepUpLeft   ;56
  &StartBackstepUp   ;57
  &StartWalkUp   ;58
  &StartIdleUp   ;59
  &SwingUp   ;5A
  &StartSidestepUpRight   ;5B
  &StartSidestepUpLeft   ;5C
  &StartBackstepUp   ;5D
  &StartWalkUp   ;5E
  &StartIdleUp   ;5F
  &SwingLeft   ;60
  &StartBackstepLeft   ;61
  &StartWalkLeft   ;62
  &StartSidestepLeftDown   ;63
  &StartSidestepLeftUp   ;64
  &StartIdleLeft   ;65
  &SwingLeft   ;66
  &StartBackstepLeft   ;67
  &StartWalkLeft   ;68
  &StartSidestepLeftDown   ;69
  &StartSidestepLeftUp   ;6A
  &StartIdleLeft   ;6B
  &SwingRight   ;6C
  &StartWalkRight   ;6D
  &StartBackstepRight   ;6E
  &StartSidestepRightDown   ;6F
  &StartSidestepRightUp   ;70
  &StartIdleRight   ;71
  &SwingRight   ;72
  &StartWalkRight   ;73
  &StartBackstepRight   ;74
  &StartSidestepRightDown   ;75
  &StartSidestepRightUp   ;76
  &StartIdleRight   ;77
  &StartIdleUp   ;78
  &StartIdleUp   ;79
  &StartIdleUp   ;7A
  &StartIdleUp   ;7B
  &StartIdleUp   ;7C
  &StartIdleUp   ;7D
  &StartIdleUp   ;7E
  &StartIdleUp   ;7F
  &StartIdleUp   ;80
  &StartIdleUp   ;81
  &StartIdleUp   ;82
  &StartIdleUp   ;83
  &StartIdleUp   ;84
  &StartIdleUp   ;85
  &StartIdleUp   ;86
  &StartIdleUp   ;87
  &StartIdleUp   ;88
  &StartIdleUp   ;89
  &StartIdleUp   ;8A
  &StartIdleUp   ;8B
  &StartIdleUp   ;8C
  &StartIdleUp   ;8D
  &StartIdleUp   ;8E
  &StartIdleUp   ;8F
  &StartIdleUp   ;90
  &StartIdleUp   ;91
  &StartIdleUp   ;92
  &StartIdleUp   ;93
  &StartIdleUp   ;94
  &StartIdleUp   ;95
  &StartIdleUp   ;96
  &StartIdleUp   ;97
  &StartIdleUp   ;98
  &StartIdleUp   ;99
  &StartIdleUp   ;9A
  &StartIdleUp   ;9B
  &StartIdleUp   ;9C
  &StartIdleUp   ;9D
  &StartIdleUp   ;9E
  &StartIdleUp   ;9F
  &StartIdleUp   ;A0
  &StartIdleUp   ;A1
  &StartIdleUp   ;A2
  &StartIdleUp   ;A3
  &StartIdleUp   ;A4
  &StartIdleUp   ;A5
  &StartIdleUp   ;A6
  &StartIdleUp   ;A7
  &StartIdleUp   ;A8
  &StartIdleUp   ;A9
  &StartIdleUp   ;AA
  &StartIdleUp   ;AB
  &StartIdleUp   ;AC
  &StartIdleUp   ;AD
  &StartIdleUp   ;AE
  &StartIdleUp   ;AF
  &StartIdleUp   ;B0
  &StartIdleUp   ;B1
  &StartIdleUp   ;B2
  &StartIdleUp   ;B3
  &StartIdleUp   ;B4
  &StartIdleUp   ;B5
  &StartIdleUp   ;B6
  &StartIdleUp   ;B7
  &StartIdleUp   ;B8
  &StartIdleUp   ;B9
  &StartIdleUp   ;BA
  &StartIdleUp   ;BB
  &StartIdleUp   ;BC
  &StartIdleUp   ;BD
  &StartIdleUp   ;BE
  &StartIdleUp   ;BF
  &SwingDown   ;C0
  &StartSidestepDownRight   ;C1
  &StartSidestepDownLeft   ;C2
  &StartWalkDown   ;C3
  &StartBackstepDown   ;C4
  &StartIdleDown   ;C5
  &SwingUp   ;C6
  &StartSidestepUpRight   ;C7
  &StartSidestepUpLeft   ;C8
  &StartBackstepUp   ;C9
  &StartWalkUp   ;CA
  &StartIdleUp   ;CB
  &SwingLeft   ;CC
  &StartBackstepLeft   ;CD
  &StartWalkLeft   ;CE
  &StartSidestepLeftDown   ;CF
  &StartSidestepLeftUp   ;D0
  &StartIdleLeft   ;D1
  &SwingRight   ;D2
  &StartWalkRight   ;D3
  &StartBackstepRight   ;D4
  &StartSidestepRightDown   ;D5
  &StartSidestepRightUp   ;D6
  &StartIdleRight   ;D7
  &SwingRight   ;D8
  &StartWalkRight   ;D9
  &StartBackstepRight   ;DA
  &StartSidestepRightDown   ;DB
  &StartSidestepRightUp   ;DC
  &StartIdleRight   ;DD
  &SwingRight   ;DE
  &StartWalkRight   ;DF
  &StartBackstepRight   ;E0
  &StartSidestepRightDown   ;E1
  &StartSidestepRightUp   ;E2
  &StartIdleRight   ;E3
  &SwingLeft   ;E4
  &StartBackstepLeft   ;E5
  &StartWalkLeft   ;E6
  &StartSidestepLeftDown   ;E7
  &StartSidestepLeftUp   ;E8
  &StartIdleLeft   ;E9
  &SwingLeft   ;EA
  &StartBackstepLeft   ;EB
  &StartWalkLeft   ;EC
  &StartSidestepLeftDown   ;ED
  &StartSidestepLeftUp   ;EE
  &StartIdleLeft   ;EF
  &SwingDown   ;F0
  &StartSidestepDownRight   ;F1
  &StartSidestepDownLeft   ;F2
  &StartWalkDown   ;F3
  &StartBackstepDown   ;F4
  &StartIdleDown   ;F5
  &SwingDown   ;F6
  &StartSidestepDownRight   ;F7
  &StartSidestepDownLeft   ;F8
  &StartWalkDown   ;F9
  &StartBackstepDown   ;FA
  &StartIdleDown   ;FB
  &SwingUp   ;FC
  &StartSidestepUpRight   ;FD
  &StartSidestepUpLeft   ;FE
  &StartBackstepUp   ;FF
  &StartWalkUp   ;100
  &StartIdleUp   ;101
  &SwingUp   ;102
  &StartSidestepUpRight   ;103
  &StartSidestepUpLeft   ;104
  &StartBackstepUp   ;105
  &StartWalkUp   ;106
  &StartIdleUp   ;107
]
---------------------------------------------

; Starts the idle pose facing up; the first of the 28 pose handlers of the player state table (PlayerActionTable).
; 
; When: the player script picks a handler from PlayerActionTable (44 rows of 6 words) whenever the pose must change; carry clear = no weapon drawn or L/R held (poses $00-$13), carry set = armed without L/R (poses $24-$2B). ChoosePlayerAction chooses the row (see the block note of player_core).
; Sees: the hero standing, walking or stepping with the matching animation.
; Why: one tiny handler per pose keeps the 44-row table free of animation ids. Names: Start + pose + facing (PlayerFacingByAnim: 0 up, 1 down, 2 right, 3 left); the sidestep names give the facing, then the direction of travel, and a backstep keeps the facing in its name while it moves the other way; anim $01 unarmed or $2B armed here.
; In: X = player actor, carry from the state table.
; Out: PublishPlayerAnim, COP 80 and COP 82 (set and step the animation), then BRL ChoosePlayerAction back into the common player loop.
; Clobbers: A, Y.

StartIdleUp {
    BCS loc_001D4B
    LDA #$0001
    JSR $&PublishPlayerAnim
    COP [80] ( #01 )
    COP [82]
    BRL ChoosePlayerAction

  loc_001D4B:
    LDA #$002B
    JSR $&PublishPlayerAnim
    COP [80] ( #2B )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Idle pose facing down: anim $00 (carry clear) or $29 (carry set). Family note: StartIdleUp.

StartIdleDown {
    BCS loc_001D69
    LDA #$0000
    JSR $&PublishPlayerAnim
    COP [80] ( #00 )
    COP [82]
    BRL ChoosePlayerAction

  loc_001D69:
    LDA #$0029
    JSR $&PublishPlayerAnim
    COP [80] ( #29 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Idle pose facing left: anim $02 (carry clear) or $27 (carry set). Family note: StartIdleUp.

StartIdleLeft {
    BCS loc_001D87
    LDA #$0002
    JSR $&PublishPlayerAnim
    COP [80] ( #02 )
    COP [82]
    BRL ChoosePlayerAction

  loc_001D87:
    LDA #$0027
    JSR $&PublishPlayerAnim
    COP [80] ( #27 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Idle pose facing right: anim $03 (carry clear) or $24 (carry set). Family note: StartIdleUp.

StartIdleRight {
    BCS loc_001DA5
    LDA #$0003
    JSR $&PublishPlayerAnim
    COP [80] ( #03 )
    COP [82]
    BRL ChoosePlayerAction

  loc_001DA5:
    LDA #$0024
    JSR $&PublishPlayerAnim
    COP [80] ( #24 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Walk pose up: anim $06 (carry clear) or $2A (carry set). Family note: StartIdleUp.

StartWalkUp {
    BCS loc_001DC3
    LDA #$0006
    JSR $&PublishPlayerAnim
    COP [80] ( #06 )
    COP [82]
    BRL ChoosePlayerAction

  loc_001DC3:
    LDA #$002A
    JSR $&PublishPlayerAnim
    COP [80] ( #2A )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Walk pose down: anim $04 (carry clear) or $28 (carry set). Family note: StartIdleUp.

StartWalkDown {
    BCS loc_001DE1
    LDA #$0004
    JSR $&PublishPlayerAnim
    COP [80] ( #04 )
    COP [82]
    BRL ChoosePlayerAction

  loc_001DE1:
    LDA #$0028
    JSR $&PublishPlayerAnim
    COP [80] ( #28 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Walk pose left: anim $08 (carry clear) or $26 (carry set). Family note: StartIdleUp.

StartWalkLeft {
    BCS loc_001DFF
    LDA #$0008
    JSR $&PublishPlayerAnim
    COP [80] ( #08 )
    COP [82]
    BRL ChoosePlayerAction

  loc_001DFF:
    LDA #$0026
    JSR $&PublishPlayerAnim
    COP [80] ( #26 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Walk pose right: anim $0A (carry clear) or $25 (carry set). Family note: StartIdleUp.

StartWalkRight {
    BCS loc_001E1D
    LDA #$000A
    JSR $&PublishPlayerAnim
    COP [80] ( #0A )
    COP [82]
    BRL ChoosePlayerAction

  loc_001E1D:
    LDA #$0025
    JSR $&PublishPlayerAnim
    COP [80] ( #25 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Backstep pose: the hero faces down and walks up (anim $05, no armed variant; PlayerFacingByAnim 1, PlayerMoveDirByAnim 0, step velocity dy = -2). Reached from the down-facing rows of PlayerActionTable with the Up key while L or R is held. Family note: StartIdleUp.

StartBackstepDown {
    LDA #$0005
    JSR $&PublishPlayerAnim
    COP [80] ( #05 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing left while moving up: anim $11. Names are facing, then direction of travel. Family note: StartIdleUp.

StartSidestepLeftUp {
    LDA #$0011
    JSR $&PublishPlayerAnim
    COP [80] ( #11 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing right while moving up: anim $12. Family note: StartIdleUp.

StartSidestepRightUp {
    LDA #$0012
    JSR $&PublishPlayerAnim
    COP [80] ( #12 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Backstep pose: the hero faces up and walks down (anim $07, no armed variant; PlayerFacingByAnim 0, PlayerMoveDirByAnim 1). Reached from the up-facing rows of PlayerActionTable with the Down key while L or R is held. Family note: StartIdleUp.

StartBackstepUp {
    LDA #$0007
    JSR $&PublishPlayerAnim
    COP [80] ( #07 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing left while moving down: anim $10. Family note: StartIdleUp.

StartSidestepLeftDown {
    LDA #$0010
    JSR $&PublishPlayerAnim
    COP [80] ( #10 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing right while moving down: anim $13. Family note: StartIdleUp.

StartSidestepRightDown {
    LDA #$0013
    JSR $&PublishPlayerAnim
    COP [80] ( #13 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing up while moving left: anim $0E. Family note: StartIdleUp.

StartSidestepUpLeft {
    LDA #$000E
    JSR $&PublishPlayerAnim
    COP [80] ( #0E )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing down while moving left: anim $0D. Family note: StartIdleUp.

StartSidestepDownLeft {
    LDA #$000D
    JSR $&PublishPlayerAnim
    COP [80] ( #0D )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Backstep pose: the hero faces right and walks left (anim $0B, no armed variant; PlayerFacingByAnim 2, PlayerMoveDirByAnim 3). Reached from the right-facing rows of PlayerActionTable with the Left key while L or R is held. Family note: StartIdleUp.

StartBackstepRight {
    LDA #$000B
    JSR $&PublishPlayerAnim
    COP [80] ( #0B )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing up while moving right: anim $0F. Family note: StartIdleUp.

StartSidestepUpRight {
    LDA #$000F
    JSR $&PublishPlayerAnim
    COP [80] ( #0F )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sidestep pose, facing down while moving right: anim $0C. Family note: StartIdleUp.

StartSidestepDownRight {
    LDA #$000C
    JSR $&PublishPlayerAnim
    COP [80] ( #0C )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Backstep pose: the hero faces left and walks right (anim $09, no armed variant; PlayerFacingByAnim 3, PlayerMoveDirByAnim 2). Reached from the left-facing rows of PlayerActionTable with the Right key while L or R is held. Family note: StartIdleUp.

StartBackstepLeft {
    LDA #$0009
    JSR $&PublishPlayerAnim
    COP [80] ( #09 )
    COP [82]
    BRL ChoosePlayerAction

; The player's death animation and the return to the next scene.
; 
; When: the player script finds $16 bit $0400 (set by MarkPlayerDead) at ChoosePlayerAction.
; Sees: the death animation $1C with BRK #$84, then a scene change.
; Why: the death items and Gem loss are decided in CheckPlayerDeath; this is the visible part.
; In: X = player actor. Out: data bank $24 = $0B for the player and $0C for the weapon actor, animation $1C, scene_next = world_index + 1 (OQ-I006-22: whether that is the world's shrine), COP 91.
; Clobbers: A, Y.

  PlayPlayerDeath:
    SEP #$20
    LDA #$0B
    STA $0024, X          ; Animation data bank $0B for the player; $0C for the weapon actor below (OQ-I006-22)
    LDY $player_weapon_actor
    LDA #$0C
    STA $0024, Y
    REP #$20
    BRK #$84
    LDA #$001C
    JSR $&PublishPlayerAnim
    COP [80] ( #1C )
    COP [82]
    LDA $world_index      ; scene_next = world_index + 1 (OQ-I006-22)
    INC 
    STA $scene_next
    COP [91]
    RTL 
}

---------------------------------------------
; Sword swing facing up (anim $21); fires the Phoenix shot when the Phoenix gear is complete.
; 
; When: the attack button is pressed while facing up with a weapon.
; Sees: the sword swing; with Soul Blade, Soul Armor and Phoenix magic equipped and 2 Gems paid, a Phoenix projectile flies up.
; Why: the swing, the sound (BRK #$01) and the optional shot belong to one pose.
; In: X = player actor. Out: PayPhoenixCost, COP 84 PhoenixProjectileUp when it succeeded, joy_release_latch bit $8000 cleared (a held button swings once), animation $21 through PublishPlayerAnim, BRL ChoosePlayerAction.
; Clobbers: A, Y.

SwingUp {
    BRK #$01
    JSR $&PayPhoenixCost
    BCS loc_001F07
    COP [84] ( @PhoenixProjectileUp )

  loc_001F07:
    LDA #$8000
    TRB $joy_release_latch ; Clear the release latch of the B button (joypad bit $8000): a held button swings only once
    LDA #$0021
    JSR $&PublishPlayerAnim
    COP [80] ( #21 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sword swing facing down (anim $20); same flow as SwingUp with PhoenixProjectileDown. Family note: SwingUp.

SwingDown {
    BRK #$01
    JSR $&PayPhoenixCost
    BCS loc_001F27
    COP [84] ( @PhoenixProjectileDown )

  loc_001F27:
    LDA #$8000
    TRB $joy_release_latch
    LDA #$0020
    JSR $&PublishPlayerAnim
    COP [80] ( #20 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sword swing facing left (anim $22); same flow as SwingUp with PhoenixProjectileLeft. Family note: SwingUp.

SwingLeft {
    BRK #$01
    JSR $&PayPhoenixCost
    BCS loc_001F47
    COP [84] ( @PhoenixProjectileLeft )

  loc_001F47:
    LDA #$8000
    TRB $joy_release_latch
    LDA #$0022
    JSR $&PublishPlayerAnim
    COP [80] ( #22 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Sword swing facing right (anim $23); same flow as SwingUp with PhoenixProjectileRight. Family note: SwingUp.

SwingRight {
    BRK #$01
    JSR $&PayPhoenixCost
    BCS loc_001F67
    COP [84] ( @PhoenixProjectileRight )

  loc_001F67:
    LDA #$8000
    TRB $joy_release_latch
    LDA #$0023
    JSR $&PublishPlayerAnim
    COP [80] ( #23 )
    COP [82]
    BRL ChoosePlayerAction
}

---------------------------------------------
; Checks the Phoenix gear and takes 2 Gems.
; 
; When: every sword swing (SwingUp, SwingDown, SwingLeft, SwingRight).
; Sees: a flying Phoenix shot appears only for the complete set at the price of 2 Gems.
; Why: the shot is a bonus of the full set; the cost keeps it from being free.
; In: equipped_weapon, equipped_armor, equipped_magic. Needs weapon $08, armor $10 and magic $18.
; Out: carry clear when the gear matches and Cop26 took 2 Gems; carry set otherwise (PhoenixCostFailed).
; Clobbers: A.

PayPhoenixCost {
    LDA $equipped_weapon
    CMP #$0008
    BNE PhoenixCostFailed
    LDA $equipped_armor
    CMP #$0010
    BNE PhoenixCostFailed
    LDA $equipped_magic
    CMP #$0018
    BNE PhoenixCostFailed
    COP [26] ( #$0002, &PhoenixCostFailed ) ; Cop26: take 2 Gems, or jump to PhoenixCostFailed when the player has fewer
    CLC 
    RTS 
}

---------------------------------------------
; Failure exit of PayPhoenixCost: SEC, RTS (also the jump target of Cop26 when the player has fewer than 2 Gems).

PhoenixCostFailed {
    SEC 
    RTS 
}

---------------------------------------------
; Shows an animation id to the weapon actor and refreshes the attack and defense values.
; 
; When: at the start of every pose handler.
; Sees: the weapon sprite follows the pose; sword hits use the swing's attack value.
; Why: the weapon actor (the actor linked before the player, $3E) reads the id from its $1E, and the damage code reads attack_current and defense_current.
; In: A = animation id, X = player actor.
; Out: weapon $1E = A, $20 = 0, $14 = 0; attack_current = gear_power + level_power for animations $20-$23 (swings), else gear_power; defense_current = gear_defense + level_defense.
; Clobbers: A, Y.

PublishPlayerAnim {
    LDY $003E, X
    STA $001E, Y
    SEC 
    SBC #$0020
    CMP #$0004            ; Animation $20-$23 = a sword swing: attack = gear_power + level_power, otherwise gear_power only
    BCS loc_001FB5
    LDA $gear_power
    CLC 
    ADC $level_power
    BRA loc_001FB8

  loc_001FB5:
    LDA $gear_power

  loc_001FB8:
    STA $attack_current
    LDA $gear_defense
    CLC 
    ADC $level_defense
    STA $defense_current
    LDA #$0000
    STA $0020, Y
    STA $0014, Y
    RTS 
}
---------------------------------------------

; Script of the Phoenix shot flying up: InitPhoenixProjectile, COP A0 (y -$10), animation $30, then animation $31 with count 8, COP 86. Spawned by SwingUp (OQ-I006-3).

PhoenixProjectileUp {
    JSR $&InitPhoenixProjectile
    COP [A0] ( #$FFF0 )
    COP [80] ( #30 )
    COP [82]
    COP [81] ( #31, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Script of the Phoenix shot flying down: as PhoenixProjectileUp with COP A0 (y +$10) and COP 98 (flip Y). Spawned by SwingDown.

PhoenixProjectileDown {
    JSR $&InitPhoenixProjectile
    COP [A0] ( #$0010 )
    COP [98]
    COP [80] ( #30 )
    COP [82]
    COP [81] ( #31, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Script of the Phoenix shot flying left: InitPhoenixProjectile, COP A0 (-$10), animations $2E and $2F, COP 86. Spawned by SwingLeft.

PhoenixProjectileLeft {
    JSR $&InitPhoenixProjectile
    COP [A0] ( #$FFF0 )
    COP [80] ( #2E )
    COP [82]
    COP [81] ( #2F, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Script of the Phoenix shot flying right: as PhoenixProjectileLeft with COP 96 (flip X). Spawned by SwingRight.

PhoenixProjectileRight {
    JSR $&InitPhoenixProjectile
    COP [96]
    COP [A0] ( #$FFF0 )
    COP [80] ( #2E )
    COP [82]
    COP [81] ( #2F, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Shared start of the four Phoenix shot scripts: $16 = $02A0, $30 = $0014 (OQ-I006-26), COP A3 and A2 (#30), COP A8 (#$8000, #0F) (animation bank $0F). Ends with RTS.

InitPhoenixProjectile {
    LDA #$02A0
    STA $0016, X
    LDA #$0014
    STA $0030, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    RTS 
}