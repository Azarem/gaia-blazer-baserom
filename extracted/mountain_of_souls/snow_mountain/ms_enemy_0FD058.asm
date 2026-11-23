; The Ice Crystal and its shards (file offsets 1036376-1036570, SNES $1F:D058-$D11A).
; 
; === WHAT RUNS HERE ===
; Type $35 (attack 13, defence 0, HP 24, EXP word $4000; placed in A0CS02 four times and A0CS03 eight times; no lair): the crystal sets bit $0100 of $1A, waits for the screen and loops animation $1A while it watches the byte at +$25, the actor's current HP (ApplySwordDamage subtracts from $25). While it equals the meta HP ($18 = 24) nothing happens (after eight watches the idle animation $1B is played); as soon as it differs, i.e. the crystal was hit, it becomes hostile ($16 = $0200), plays the burst animation $1C, makes sound $64, spawns eight shards in the eight directions (four animations, flipped) and dies after animation $1D. The walkthrough warns: 'four Ice Crystals around a Purple Wizard lair ... it's best to deal with them through sword slashes ... as you'll risk triggering the explosions of all four'; the bestiary: 'explodes when hit', '? HP, 0 EXP' (the ROM HP is 24 and the EXP word $4000: OQ-I033-3).
; 
; === OPEN ===
; Bit $0100 of $1A (set at the start) and the EXP word $4000 are not explained (OQ-I033-3 for the latter).
---------------------------------------------

?BANK 1F

---------------------------------------------

; Ice Crystal: explodes into eight shards the first time it is hit.
; 
; When: placed monster (type $35, HP 24).
; Sees: bit $0100 of $1A is set, COP AD, $2C = 8; loop: animation $1A, the byte at +$25 (HP) is compared with $18; equal: DEC $2C, after eight rounds animation $1B and the loop restarts; different (hit): $16 = $0200, animation $1C for 20 repeats, sound $64, eight shard actors (COP 85), animation $1D, COP 86.
; Why: the bestiary: 'explodes when hit'.
; In: X = D = slot.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_ice_crystal_0FD058 {
    LDA $001A, X
    ORA #$0100
    STA $001A, X

  loc_0FD061:
    COP [AD] ( #08 )
    LDA #$0008
    STA $002C, X

  loc_0FD06A:
    COP [80] ( #1A )
    COP [82]
    LDA $0025, X          ; byte +$25 is the HP of the actor (ApplySwordDamage subtracts from it); $18 is the meta HP, any other value means the crystal was hit
    AND #$00FF
    CMP #$0018
    BNE loc_0FD086
    DEC $002C, X
    BNE loc_0FD06A
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FD061

  loc_0FD086:
    LDA #$0200
    STA $0016, X          ; $0200: hostile hitbox for the burst
    COP [81] ( #1C, #14 )
    COP [83]
    BRK #$64
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0C4 ) ; eight shards, one per direction
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0C9 )
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0D0 )
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0D7 )
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0DE )
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0E3 )
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0E8 )
    COP [85] ( @ms_enemy_ice_crystal_shard_0FD0ED )
    COP [80] ( #1D )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Ice shard, animation $1F.
; 
; When: spawned by the crystal (COP 85); eight shards fly in eight directions: $0C4 animation $1F, $0C9 flip X / $22, $0D0 flip X / $20, $0D7 flip X / $21, $0DE $1E, $0E3 $21, $0E8 $20, $0ED $22.
; Sees: the shared tail loc_0FD0F2: animation id in $1E, $16 = $0200 (hostile), repeat count 2, drawn in front, priority $30, COP A1 shifts it by (+8,-8), COP 91, COP 83 (the flight animation), then animation $23 and COP 86.
; Why: the shard is an animated hitbox; the motion is in the animation (not verified).
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_ice_crystal_shard_0FD0C4 {
    LDA #$001F
    BRA loc_0FD0F2
}

ms_enemy_ice_crystal_shard_0FD0C9 {
    COP [96]
    LDA #$0022
    BRA loc_0FD0F2
}

ms_enemy_ice_crystal_shard_0FD0D0 {
    COP [96]
    LDA #$0020
    BRA loc_0FD0F2
}

ms_enemy_ice_crystal_shard_0FD0D7 {
    COP [96]
    LDA #$0021
    BRA loc_0FD0F2
}

ms_enemy_ice_crystal_shard_0FD0DE {
    LDA #$001E
    BRA loc_0FD0F2
}

ms_enemy_ice_crystal_shard_0FD0E3 {
    LDA #$0021
    BRA loc_0FD0F2
}

ms_enemy_ice_crystal_shard_0FD0E8 {
    LDA #$0020
    BRA loc_0FD0F2
}

ms_enemy_ice_crystal_shard_0FD0ED {
    LDA #$0022
    BRA loc_0FD0F2

  loc_0FD0F2:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    LDA #$0002
    STA $002A, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A1] ( #$0008, #$FFF8 )
    COP [91]
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [86]
    RTL 
}