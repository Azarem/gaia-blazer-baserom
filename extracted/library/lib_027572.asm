; Pause with the location banner (file offsets 161138-161260, SNES $04:F572-$F5EC, bank 04).
; 
; === MODEL ===
; HandlePauseBanner is called once per frame from RunMainLoop (after the field buttons). It is a latch: pause_latch ($03A2) negative = return; non-zero = Start was already handled, return while Start is still held and clear the latch when it is released; zero and Start newly pressed (joy_pressed+1 bit $10) = pause.
; A pause runs inside the routine: it sets the latch, writes $F2 to APUIO0 (a request to the sound driver, OQ-I013-6), prints the location name (LocationBannerText) and, when no_combat_scene is clear, the lair counter (lairs_left as two BCD digits at $1B80 through ByteToPackedBcd, then LairCounterText), flushes the text with vram_upload_flags = 1, waits until Start is released and then pressed again (WaitFrameForStart each frame), prints PauseCloseText to erase the text (OQ-I013-10), writes $01 to APUIO0 and returns. The banner is skipped when the A button is held at the moment of pausing (JOY1L bit 7, OQ-I013-7): the game still pauses, without text.
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
!no_combat_scene                0439
!lairs_left                     0456
!APUIO0                         2140
!JOY1L                          4218

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
    LDA #$F2              ; APUIO0 = $F2: pause request to the sound driver (OQ-I013-6)
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