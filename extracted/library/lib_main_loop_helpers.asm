; Per-frame helpers of the main loop in bank 04: QueueAnimatedTileStrip, HandlePauseBanner and WaitFrameForStart (file offsets 160291-160351 and 161138-161260, SNES $04:F223-$F25F and $04:F572-$F5EC).
; 
; One file because both routines are called by engine_boot_main_loop only (QueueAnimatedTileStrip from five places, HandlePauseBanner once) and WaitFrameForStart is the wait of the pause loop. The sections below keep the notes of the two former files in file order.
; 
; Request of the animated background tile strip and its four VRAM destinations (file offsets 160291-160351, SNES $04:F223-$F25F, bank 04).
; 
; === MODEL ===
; Once per frame QueueAnimatedTileStrip prepares one strip for the NMI: vram_strip_src = $1000 + (frame_counter & $1F) x $80 (a source frame in the buffer at $7F:1000, 32 frames of $80 bytes), vram_strip_dest = AnimatedStripVramDests[frame_counter & 3] and vram_strip_pending is incremented. DmaAnimatedTileStrip (engine_vblank_nmi) then copies $40 bytes to the destination and the next $40 bytes to the destination + $100 words.
; So each of the four VRAM slots is refreshed every 4 frames, and each slot cycles through 8 of the 32 source frames. The destinations $2060, $2080, $20A0, $20C0 are 16-word (4bpp) tiles $206, $208, $20A, $20C; the second half lands one tile row (16 tiles) lower, so a slot is a 2 x 2 tile block (OQ-I013-14: which tiles the maps use).
; 
; === NOTES ===
; - Skipped in locations $0F-$12 (location_id - $0F below 4), the same locations that have no HUD.
; - It has no loop guard: it overwrites the three variables on every call, so several calls in one frame change nothing.
; 
; Pause with the location banner (file offsets 161138-161260, SNES $04:F572-$F5EC, bank 04).
; 
; === MODEL ===
; HandlePauseBanner is called once per frame from RunMainLoop (after the field buttons). It is a latch: pause_latch ($03A2) negative = return; non-zero = Start was already handled, return while Start is still held and clear the latch when it is released; zero and Start newly pressed (joy_pressed+1 bit $10) = pause.
; A pause runs inside the routine: it sets the latch, writes $F2 to APUIO0 (the SPC freezes the sequence and sets mute bit 6 while the port holds it; the $01 at the end resumes it, docs/code/spc-interface.md), prints the location name (LocationBannerText) and, when no_combat_scene is clear, the lair counter (lairs_left as two BCD digits at $1B80 through ByteToPackedBcd, then LairCounterText), flushes the text with vram_upload_flags = 1, waits until Start is released and then pressed again (WaitFrameForStart each frame), prints PauseCloseText to erase the text (OQ-I013-10), writes $01 to APUIO0 and returns. The banner is skipped when the A button is held at the moment of pausing (JOY1L bit 7, OQ-I013-7): the game still pauses, without text.
; WaitFrameForStart decrements frame_counter before it waits one vblank. The NMI increments it every frame, so the net change is 0: the game clock stands still during the pause.
; 
; === NOTES ===
; - Walkthrough 01-in-the-beginning.md: the number of lairs in the area is shown by pressing Start.
; - pause_latch stays 1 after the resume until Start is let go, so the Start that ends the pause does not start a new one.
---------------------------------------------

?BANK 04

?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_banner_texts'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'lib_text_render'

!frame_counter                  0312
!joy_pressed                    0322
!pause_latch                    03A2
!vram_upload_flags              03B8
!vram_strip_src                 03DD
!vram_strip_dest                03DF
!vram_strip_pending             03E1
!no_combat_scene                0439
!lairs_left                     0456
!location_id                    1C6A
!APUIO0                         2140
!JOY1L                          4218

---------------------------------------------

; Queues one animated background tile strip for the next NMI.
; 
; When: once per frame at the end of the work phase of RunMainLoop, RunReturnLoop and the three sub-frame runners (5 call sites in engine_boot_main_loop).
; Sees: animated background tiles move (the strips cycle through 32 source frames, one VRAM slot per frame).
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
---------------------------------------------

; Pauses the game on Start and shows the location banner.
; 
; When: once per frame from RunMainLoop.
; Sees: Start freezes the game and prints the location name and, in combat scenes, the number of monster lairs left; the second Start removes the text and resumes. Holding A while pressing Start pauses without the banner.
; Why: the pause needs no menu, only a text and a wait, so it runs as one routine inside the main loop.
; In: JSL, once per frame; M = 8, X = 16-bit; pause_latch ($03A2), joy_pressed+1 ($0323), no_combat_scene ($0439), lairs_left ($0456), JOY1L.
; Out: returns at once when nothing is to do; after a pause: APUIO0 = $F2 at the start and $01 at the end, the text drawn and erased, vram_upload_flags = 1, pause_latch = 1 (cleared later when Start is released), $1B80-$1B81 = the lair count in BCD.
; Clobbers: A, X, Y.

HandlePauseBanner {
    LDA $pause_latch
    BMI PauseDone
    BNE PauseLatchHeld
    LDA $joy_pressed+1
    BIT #$10
    BEQ PauseDone
    INC $pause_latch      ; latch = 1: the pause runs inside this routine
    LDA #$F2              ; APUIO0 = $F2: the SPC freezes the sequence and sets bit 6 of its byte $48 while the port holds it (docs/code/spc-interface.md)
    STA $APUIO0
    LDA $JOY1L
    BIT #$80              ; A held (JOY1L bit 7): no banner (OQ-I013-7)
    BNE PauseWaitStartRelease
    LDY #$&lib_banner_texts.LocationBannerText
    JSL $@lib_text_render.PrintTextString
    LDA $no_combat_scene
    BNE PauseBannerFlush
    LDA $lairs_left       ; lairs left, printed as two BCD digits at $1B80 for LairCounterText
    LDX #$1B80
    JSL $@lib_arithmetic.ByteToPackedBcd
    LDY #$&lib_banner_texts.LairCounterText
    JSL $@lib_text_render.PrintTextString

  PauseBannerFlush:
    LDA #$01
    STA $vram_upload_flags

  PauseWaitStartRelease:
    JSR $&WaitFrameForStart
    BNE PauseWaitStartRelease

  PauseWaitStartPress:
    JSR $&WaitFrameForStart
    BEQ PauseWaitStartPress
    LDY #$&lib_banner_texts.PauseCloseText
    JSL $@lib_text_render.PrintTextString
    LDA #$01
    STA $vram_upload_flags
    LDA #$01
    STA $APUIO0           ; APUIO0 = 1: resume
    JSL $@lib_system_helpers.WaitVBlank
    RTL 

  PauseLatchHeld:
    LDA $joy_pressed+1
    BIT #$10
    BNE PauseDone
    STZ $pause_latch

  PauseDone:
    RTL 
}

---------------------------------------------
; Waits one frame while the game is paused and tests Start.
; 
; When: the two wait loops of HandlePauseBanner (Start release and Start press).
; Sees: nothing; the screen stays as it was.
; Why: the frame counter must not advance during the pause, so it is decremented to cancel the increment of the NMI.
; In: JSR; M = 8, X = 16-bit.
; Out: frame_counter - 1 (before the NMI adds 1 again), one vblank waited; Z clear while Start (joy_pressed+1 bit $10) is down.
; Clobbers: A, X.

WaitFrameForStart {
    LDX $frame_counter
    DEX 
    STX $frame_counter    ; cancels the INC of the NMI: the game clock stops during the pause
    JSL $@lib_system_helpers.WaitVBlank
    LDA $joy_pressed+1
    BIT #$10
    RTS 
}