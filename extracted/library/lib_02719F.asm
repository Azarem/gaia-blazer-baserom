; Boot-time expansion of three graphics blocks into fixed WRAM buffers (file offsets 160159-160290, SNES $04:F19F-$F222, bank 04).
; 
; === MODEL ===
; LoadBootGraphicsBuffers decompresses graphics_054000 ($4000 bytes), graphics_05C000 and graphics_04D000 ($2000 bytes each) with DecompressQuintetLz into the scratch area $7E:8000 and moves each result with MVN #$7F,#$7E to its buffer: $7F:3000, $7F:1000 and $7F:C000. The source pointer in dp$29-$2B skips the 2-byte length header of each block (+2); dp$23 is the output length and dp$25 the destination offset. It ends with ResetSortBuckets, so the actor sort buckets start empty.
; 
; === NOTES ===
; - The only caller is the boot actor of the front end (code_0066DE in gv_front_end), once per start-up, after the SPC upload and RestoreSceneBgGfxAndPalette; it then jumps to the title scene with COP [10].
; - The consumers are elsewhere: QueueAnimatedTileStrip reads its strips from $7F:1000 (frame x $80), the equipment menu copies $7F:C000 to VRAM word $2000 (RestoreSceneBgGfxAndPalette), and the engine's initial dynamic-tile pointer $1A02/$1A04 is $7F:3000 (InitFixedState; BuildDynamicTileSprites overwrites it before reading it, static reading). What graphics_054000 holds is open; this routine only places it.
; - $7E:8000 is also the BG1 id map of the field; the buffer is free at boot and rebuilt by the first scene load.
---------------------------------------------

?BANK 04

?INCLUDE 'lib_scene_asset_loader'
?INCLUDE 'lib_shared_027260'

---------------------------------------------

; Expands the three boot graphics blocks into their WRAM buffers and resets the sort buckets.
; 
; When: once per start-up, from the boot actor of the front end (code_0066DE in gv_front_end).
; Sees: nothing directly (the boot actor printed TileBlockText before this).
; Why: later scenes and the equipment menu take these blocks from WRAM, so they are decompressed once instead of at every scene load (inferred from the readers named in the block note).
; In: JSL; M and X as the caller (REP #$20 inside; X = 16-bit); the three LZ blocks in ROM.
; Out: $7F:3000-$6FFF = graphics_054000, $7F:1000-$2FFF = graphics_05C000, $7F:C000-$DFFF = graphics_04D000; $7E:8000-$9FFF holds the last block; $0100-$02FF cleared and $0300 = $FFFF (ResetSortBuckets). DBR and P restored.
; Clobbers: A, X, Y; dp$23, $25, $29, $2B and the decompressor's scratch (DecompressQuintetLz).

LoadBootGraphicsBuffers {
    PHP 
    REP #$20
    LDA #$&graphics_054000+2 ; source = block + 2: skips the 2-byte length header
    STA $29
    SEP #$20
    LDA #$^graphics_054000
    STA $2B
    REP #$20
    LDA #$4000
    STA $23
    LDX #$8000
    STX $25
    JSL $@lib_scene_asset_loader.DecompressQuintetLz
    PHB 
    LDX #$8000
    LDY #$3000
    LDA #$3FFF
    MVN #$7F, #$7E        ; $4000 bytes to $7F:3000
    PLB 
    LDA #$&graphics_05C000+2
    STA $29
    SEP #$20
    LDA #$^graphics_05C000
    STA $2B
    REP #$20
    LDA #$2000
    STA $23
    LDX #$8000
    STX $25
    JSL $@lib_scene_asset_loader.DecompressQuintetLz
    PHB 
    LDX #$8000
    LDY #$1000
    LDA #$1FFF
    MVN #$7F, #$7E        ; $2000 bytes to $7F:1000 (animated tile strips)
    PLB 
    LDA #$&graphics_04D000+2
    STA $29
    SEP #$20
    LDA #$^graphics_04D000
    STA $2B
    REP #$20
    LDA #$2000
    STA $23
    LDX #$8000
    STX $25
    JSL $@lib_scene_asset_loader.DecompressQuintetLz
    PHB 
    LDX #$8000
    LDY #$C000
    LDA #$1FFF
    MVN #$7F, #$7E        ; $2000 bytes to $7F:C000
    PLB 
    JSL $@lib_shared_027260.ResetSortBuckets
    PLP 
    RTL 
}