; One actor of the first world (file offsets 124091-124098, SNES $03:E4BB-$E4C2, bank 03): the spawner of a fixed Gem pickup. The meta type $3E points at it, but no scene of area 4 or 5 places the type, so the actor is unused in the US ROM (the Gems of GreenWood are in chests: the walkthrough lists '150 Gems', '50 Gems' twice).
---------------------------------------------

?BANK 03

?INCLUDE 'engine_spawn_lairs_death_drops'

---------------------------------------------

; Spawns a Gem that lies on the ground and removes itself.
; 
; When: meta type $3E (meta flags $2050, hidden until its switch); no placement row in any scene (checked PlacementA04S01-A05S0A).
; Sees: nothing (when it ran, a Gem pickup would appear next to its position).
; Why: the pickup is made by RunFixedGemPickup (10 Gems, OQ-I006-8); the spawner is the usual one-line wrapper (spawn, kill self).
; In: actor script, X = own slot.
; Out: COP 85 spawns engine_spawn_lairs_death_drops.RunFixedGemPickup, COP 86 kills the spawner, RTL.
; Clobbers: A.

gw_actor_fixed_gem_pickup_01E4BB {
    COP [85] ( @engine_spawn_lairs_death_drops.RunFixedGemPickup )
    COP [86]
    RTL 
}