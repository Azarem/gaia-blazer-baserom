; Request of the animated background tile strip and its four VRAM destinations (file offsets 160291-160351, SNES $04:F223-$F25F, bank 04).
; 
; === MODEL ===
; Once per frame QueueAnimatedTileStrip prepares one strip for the NMI: vram_strip_src = $1000 + (frame_counter & $1F) x $80 (a source frame in the buffer at $7F:1000, 32 frames of $80 bytes), vram_strip_dest = AnimatedStripVramDests[frame_counter & 3] and vram_strip_pending is incremented. DmaAnimatedTileStrip (engine_vblank_nmi) then copies $40 bytes to the destination and the next $40 bytes to the destination + $100 words.
; So each of the four VRAM slots is refreshed every 4 frames, and each slot cycles through 8 of the 32 source frames. The destinations $2060, $2080, $20A0, $20C0 are 16-word (4bpp) tiles $206, $208, $20A, $20C; the second half lands one tile row (16 tiles) lower, so a slot is a 2 x 2 tile block (OQ-I013-14: which tiles the maps use).
; 
; === NOTES ===
; - Skipped in locations $0F-$12 (location_id - $0F below 4), the same locations that have no HUD.
; - It has no loop guard: it overwrites the three variables on every call, so five calls in one frame (the main loop and four wait loops of the front end) change nothing.
---------------------------------------------

?BANK 04

!frame_counter                  0312
!vram_strip_src                 03DD
!vram_strip_dest                03DF
!vram_strip_pending             03E1
!location_id                    1C6A

---------------------------------------------

; Queues one animated background tile strip for the next NMI.
; 
; When: once per frame from the end of the main loop and from the wait loops of the front end (5 call sites in engine_boot_main_loop).
; Sees: water, lava and similar background tiles move (the strips cycle through 32 source frames, one VRAM slot per frame).
; Why: the work phase never touches VRAM, so it only sets the source, the destination and a pending counter for the NMI.
; In: JSL; any M (PHP, REP inside); frame_counter, location_id.
; Out: unless location_id - $0F < 4: vram_strip_src ($03DD) = $1000 + (frame_counter & $1F) x $80, vram_strip_dest ($03DF) = AnimatedStripVramDests[frame_counter & 3], vram_strip_pending ($03E1) + 1. P restored.
; Clobbers: A, X.

QueueAnimatedTileStrip {
    PHP 
    REP #$20
    LDA $location_id
    SEC 
    SBC #$000F            ; locations $0F-$12 are skipped (location_id - $0F below 4)
    CMP #$0004
    BCS AnimatedStripBuildRequest
    BRL AnimatedStripDone

  AnimatedStripBuildRequest:
    LDA $frame_counter
    AND #$001F
    XBA 
    LSR                   ; (frame_counter & $1F) x $80: one source frame of $80 bytes
    CLC 
    ADC #$1000
    STA $vram_strip_src
    LDA $frame_counter
    AND #$0003
    ASL 
    TAX 
    LDA $@AnimatedStripVramDests, X ; destination slot = frame_counter & 3
    STA $vram_strip_dest
    INC $vram_strip_pending

  AnimatedStripDone:
    PLP 
    RTL 
}
---------------------------------------------

; The four VRAM word destinations of the animated strips.
; 
; When: read by QueueAnimatedTileStrip with X = (frame_counter & 3) x 2.
; Sees: four 2-tile slots at VRAM tiles $206, $208, $20A and $20C (second halves at $216-$21C).
; Why: spreads the animation over four slots so only $80 bytes are copied per frame.
; In: n/a (data).
; Out: n/a. Four words $2060, $2080, $20A0, $20C0, spaced $20 words (two 4bpp tiles).
; Clobbers: n/a.

AnimatedStripVramDests [
  #$2060   ;00
  #$2080   ;01
  #$20A0   ;02
  #$20C0   ;03
]