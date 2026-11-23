; Reset of the actor sort buckets (file offsets 160352-160374, SNES $04:F260-$F276, bank 04).
; 
; === MODEL ===
; ResetSortBuckets zeroes $0100-$02FF (256 bucket words) and writes the end marker $FFFF at $0300. The page is the bucket table of the actor sort (FillSortBuckets and FlattenSortBuckets in engine_scheduler_sprites_combat_collision); an empty table with the marker is the start state.
; 
; === NOTES ===
; - Callers: the end of LoadBootGraphicsBuffers and the end of InitSceneState.
; - BuildTileTypeMap builds its metatile mask table in the same page ($0200-$02FF, FillTileTypeMap) during the scene load; ResetSortBuckets at the end of InitSceneState wipes it again.
; - The writes are DBR-relative ($0100,X): they hit WRAM $0100 with the engine's DBR $01.
---------------------------------------------

?BANK 04

---------------------------------------------

; Empties the actor sort buckets.
; 
; When: at the end of LoadBootGraphicsBuffers and at the end of InitSceneState.
; Sees: nothing; the first frame of a scene starts with no actors in the sort order.
; Why: leftover bucket entries or the mask table of BuildTileTypeMap in the page would be read as actors.
; In: JSL; any M (PHP, REP inside); DBR in $00-$3F (the engine's $01).
; Out: $0100-$02FF = 0, $0300 = $FFFF (end marker). P restored.
; Clobbers: A, X.

ResetSortBuckets {
    PHP 
    REP #$20
    LDX #$0000
    TXA 

  ResetSortBucketsLoop:
    STA $0100, X
    INX 
    INX 
    CPX #$0200
    BNE ResetSortBucketsLoop
    DEC 
    STA $0100, X
    PLP 
    RTL 
}