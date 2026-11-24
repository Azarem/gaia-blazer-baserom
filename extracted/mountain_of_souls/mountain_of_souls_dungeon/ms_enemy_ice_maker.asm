; The Ice Maker and its ice spikes (file offsets 1036246-1036375, SNES $1F:CFD6-$D057).
; 
; === WHAT RUNS HERE ===
; Type $34 (attack 14, defence 7, HP 24, EXP 70; placed in A0BS04 and A0BS05, four times each; no lair): waits for the screen (COP AD), plays animation $18, animation $19 eight times (the cast), spawns four spikes, plays animation $18 twelve times and repeats. Each spike is an actor that places itself on the tile 2 tiles ($20 pixels) above, below, left or right of the hero and grows there. The walkthrough: 'Ice Maker enemies ... will make icy spikes appear from the ground to hurt you; if you don't move fast, you will get hurt.' (the bestiary: 24 HP, 70 EXP, 'makes ice spikes').
; 
; === OPEN ===
; Which animation frames hurt the hero (the spike's hitbox is $16 = $0200 during animation $17) was not checked at runtime.
---------------------------------------------

?BANK 1F

!player_x                       0374
!player_y                       0376

---------------------------------------------

; Ice Maker: casts four spikes around the hero every cycle.
; 
; When: placed monster (type $34, HP 24).
; Sees: COP AD, animation $18, animation $19 for 8 repeats (COP 81 / 83), four COP 85 spawns (spike above, below, left, right), animation $18 for 12 repeats, BRA to the start.
; Why: the walkthrough: 'make icy spikes appear from the ground'.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_ice_maker_0FCFD6 {
    COP [AD] ( #08 )
    COP [80] ( #18 )
    COP [82]
    COP [81] ( #19, #08 )
    COP [83]
    COP [85] ( @ms_enemy_ice_spike_above_0FD000 )
    COP [85] ( @ms_enemy_ice_spike_below_0FD005 )
    COP [85] ( @ms_enemy_ice_spike_left_0FD01D )
    COP [85] ( @ms_enemy_ice_spike_right_0FD022 )
    COP [81] ( #18, #0C )
    COP [83]
    BRA ms_enemy_ice_maker_0FCFD6
}

---------------------------------------------
; Ice spike 2 tiles above the hero.
; 
; When: spawned by the Ice Maker (COP 85).
; Sees: A = $FFE0 added to player_y, aligned to 16 pixels; X = the hero's x aligned; then the shared tail loc_0FD038: COP 28 (tile occupied) kills the spike; otherwise $16 = $0300 while animation $16 grows (2 repeats), $16 = $0200 (hostile), sound $5B, animation $17, then COP 86.
; Why: the four spikes surround the hero at distance 2 tiles; those on solid tiles do not appear.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_ice_spike_above_0FD000 {
    LDA #$FFE0
    BRA loc_0FD008
}

---------------------------------------------
; Ice spike 2 tiles below the hero: the same as ms_enemy_ice_spike_above_0FD000 with $0020.
; 
; When: spawned by the Ice Maker (COP 85).
; Sees: A = $0020 added to player_y, then the shared tail.
; Why: see ms_enemy_ice_spike_above_0FD000.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_ice_spike_below_0FD005 {
    LDA #$0020

  loc_0FD008:
    CLC 
    ADC $player_y
    AND #$FFF0
    STA $0002, X
    LDA $player_x
    AND #$FFF0
    STA $0000, X
    BRA loc_0FD038
}

---------------------------------------------
; Ice spike 2 tiles left of the hero.
; 
; When: spawned by the Ice Maker (COP 85).
; Sees: A = $FFE0 added to player_x, aligned to 16 pixels, y = the hero's aligned; then the shared tail loc_0FD038.
; Why: see ms_enemy_ice_spike_above_0FD000.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_ice_spike_left_0FD01D {
    LDA #$FFE0
    BRA loc_0FD025
}

---------------------------------------------
; Ice spike 2 tiles right of the hero.
; 
; When: spawned by the Ice Maker (COP 85).
; Sees: A = $0020 added to player_x, then the left spike's tail.
; Why: see ms_enemy_ice_spike_above_0FD000.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_ice_spike_right_0FD022 {
    LDA #$0020

  loc_0FD025:
    CLC 
    ADC $player_x
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    AND #$FFF0
    STA $0002, X

  loc_0FD038:
    COP [28] ( &code_0FD055 ) ; COP 28: the tile here is occupied: the spike does not appear
    LDA #$0300            ; $0300: not hittable while the spike grows
    STA $0016, X
    COP [81] ( #16, #02 )
    COP [83]
    LDA #$0200            ; $0200: hostile hitbox for the finished spike
    STA $0016, X
    BRK #$5B
    COP [80] ( #17 )
    COP [82]
}

code_0FD055 {
    COP [86]
    RTL 
}