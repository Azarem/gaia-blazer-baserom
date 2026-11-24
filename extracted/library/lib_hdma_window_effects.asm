; HDMA effects of the main loop and the four Soul window effects (file offsets 71317-71773, SNES $02:9695-$985D, bank 02).
; 
; === BG3 SCROLL HDMA ===
; QueueBg3ScrollHdma is called at the end of each of the five sub-frame runners of the main loop (engine_boot_main_loop). In every location except $10-$12 (location_id - $10 below 3) it queues Bg3ScrollHdmaTable for PPU register $12 (BG3VOFS, a byte written twice per line) on the next free HDMA channel (lib_system_helpers.QueueHdmaDirect). The table covers 48 lines: scroll offset -4 for 20 lines, 0 for 12, +4 for 12, then +3, +2, +1 and 0 for one line each. HDMA has to be queued again every frame (ResetHdmaQueue empties the queue at the start of each work phase), which is why the call repeats. What the table is for is open (OQ-I042-1).
; 
; === SOUL WINDOW EFFECTS ===
; RunSoulOfLightEffect, RunSoulOfRealityEffect, RunSoulOfDetectionEffect and RunSoulOfShieldEffect are actor scripts: each is the script address of meta entries of WorldMetaPointers (flags $2010, EffectAnims). Each tests its bit in souls_flags ($1B82: $02 Light, $10 Reality, $08 Detection, $04 Shield, see docs/wram-memory-map.md and OQ-I006-10) and returns at once while the soul is not recruited, so the actor polls every frame. Once the bit is set it writes the window and colour-math registers of its soul one time:
; - Light ($02): W12SEL = 0, W34SEL = 0, WOBJSEL = $30, CGWSEL = $12.
; - Reality ($10): W12SEL = $20 (and its shadow w12sel_shadow), W34SEL = 0, WOBJSEL = 0, bg2_offset_x and bg2_offset_y = 1.
; - Detection ($08): W12SEL = $20 (and the shadow), W34SEL = 0, WOBJSEL = 1, bg2_offset_x and bg2_offset_y = 1.
; - Shield ($04): W12SEL = $33 (and the shadow), W34SEL = 0, WOBJSEL = 0, TMW = 0, TSW = 3, CGWSEL = $82, and it spawns the Soul of Shield sweep (COP B0, engine_player_death_and_actor_helpers.DestroyHazardsNearOrb).
; All four then fall into BuildSoulOrbCircleWindow. Its first command is COP 91 (Cop91_SetEntryHere), so from the next frame on the actor runs only the circle rebuild.
; 
; === THE CIRCLE ===
; BuildSoulOrbCircleWindow takes the soul orb actor (soul_orb_actor, $03A0) and turns its position into screen coordinates (x - scroll_bg1_x + 8 clamped to 0-$FF, y - scroll_bg1_y - 8 clamped to 0-$DF). It writes two HDMA tables to $7E:7000 and $7E:7800: for each pair of scanlines the left and right edge of window 1 from data_engine_tables.CircleHalfWidths (a circle of radius $40 pixels around the orb), clipped to the screen, closed by one line with both edges $FF (WH0 = WH1 = $FF, a window one pixel wide at x = 255, OQ-I051-3) and a zero terminator. Both tables are queued for PPU registers $26 (WH0) and $27 (WH1). What each soul does with that window (which layers it clips) is not decoded here (OQ-I042-2).
; 
; === NOTES ===
; - The extraction has no reference to the four entries from code; they are reached through the meta entries of WorldMetaPointers (the 4 table references).
---------------------------------------------

?BANK 02

?INCLUDE 'data_engine_tables'
?INCLUDE 'engine_player_death_and_actor_helpers'
?INCLUDE 'lib_system_helpers'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!soul_orb_actor                 03A0
!w12sel_shadow                  03C3
!souls_flags                    1B82
!location_id                    1C6A
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!TMW                            212E
!TSW                            212F
!CGWSEL                         2130

---------------------------------------------

; Queues the BG3 vertical scroll HDMA table, except in locations $10-$12.
; 
; When: five call sites in engine_boot_main_loop, once per sub-frame runner (every frame).
; Sees: BG3 gets a scroll offset of -4, 0 and +4 in horizontal bands of the screen (see the block note).
; Why: HDMA is per frame; the queue is emptied at the start of every work phase, so the table is queued again every frame. The purpose of the table is open (OQ-I042-1).
; In: long call; location_id.
; Out: nothing in locations $10-$12; otherwise one HDMA channel is programmed for register $12 in direct mode with Bg3ScrollHdmaTable.
; Clobbers: A, B (and what QueueHdmaDirect uses).

QueueBg3ScrollHdma {
    LDA $location_id
    SEC 
    SBC #$10
    CMP #$03
    BCS loc_0116A0
    RTL 

  loc_0116A0:
    LDA #$12
    XBA 
    LDA #$^Bg3ScrollHdmaTable
    LDY #$&Bg3ScrollHdmaTable
    JSL $@lib_system_helpers.QueueHdmaDirect
    RTL 
}
---------------------------------------------

; The BG3 vertical scroll HDMA table (direct mode, register $12 written twice per line).
; 
; When: QueueBg3ScrollHdma.
; Sees: a scroll offset of -4 for 20 lines, 0 for 12, +4 for 12, then +3, +2, +1, 0 for one line each (48 lines in all).
; Why: see QueueBg3ScrollHdma.
; In: n/a (data): 22 bytes, each group a line count and the scroll word (low, high): 14 FC FF, 0C 00 00, 0C 04 00, 01 03 00, 01 02 00, 01 01 00, 01 00 00, then 00 (end).
; Out: n/a.
; Clobbers: n/a.

Bg3ScrollHdmaTable #14FCFF0C00000C040001030001020001010001000000
---------------------------------------------

; Soul of Light effect actor: sets the window registers once the soul is recruited, then follows the soul orb with a circle window.
; 
; When: the script of a WorldMetaPointers meta entry; runs every frame, and returns at once while souls_flags bit $02 is clear.
; Sees: with the Soul of Light the circle window around the soul orb appears (the walkthrough gets the soul in the Woods of GreenWood and needs it on B1F of the Light Shrine, which is entered from the Lostside marsh; the registers withhold colour math inside the circle, a reading of the bits that OQ-I051-2 asks to check; what the window clips is OQ-I042-2).
; Why: the effect belongs to the scene, not to the player actor, so it lives in a scene actor that checks the soul bit itself.
; In: actor entry (returns with RTL), X = actor slot; souls_flags.
; Out: bit clear: RTL. Bit set: W12SEL = 0, W34SEL = 0, WOBJSEL = $30, CGWSEL = $12 (8-bit writes, then M = 16) and a branch to BuildSoulOrbCircleWindow.
; Clobbers: A, P.

RunSoulOfLightEffect {
    LDA $souls_flags
    AND #$0002
    BNE loc_0116CC
    RTL 

  loc_0116CC:
    SEP #$20
    STZ $W12SEL
    STZ $W34SEL
    LDA #$30
    STA $WOBJSEL
    LDA #$12
    STA $CGWSEL
    REP #$20
    BRA BuildSoulOrbCircleWindow

; Soul of Reality effect actor: sets the window registers once the soul is recruited, then follows the soul orb with a circle window.
; 
; When: the script of a WorldMetaPointers meta entry; runs every frame, and returns at once while souls_flags bit $10 is clear.
; Sees: with the Soul of Reality the circle window around the soul orb appears (the walkthrough says the light orb lights up hidden passages in the Castle of King Magridd; what the window clips is OQ-I042-2).
; Why: as RunSoulOfLightEffect.
; In: actor entry (returns with RTL), X = actor slot; souls_flags.
; Out: bit clear: RTL. Bit set: W12SEL = $20 (and w12sel_shadow), W34SEL = 0, WOBJSEL = 0, bg2_offset_x = bg2_offset_y = 1, then a branch to BuildSoulOrbCircleWindow.
; Clobbers: A, P.

  RunSoulOfRealityEffect:
    LDA $souls_flags
    AND #$0010
    BNE loc_0116EB
    RTL 

  loc_0116EB:
    SEP #$20
    LDA #$20
    STA $W12SEL
    STA $w12sel_shadow
    STZ $W34SEL
    STZ $WOBJSEL
    LDA #$01
    STA $bg2_offset_x
    STA $bg2_offset_y
    REP #$20
    BRA BuildSoulOrbCircleWindow

; Soul of Detection effect actor: sets the window registers once the soul is recruited, then follows the soul orb with a circle window.
; 
; When: the script of a WorldMetaPointers meta entry; runs every frame, and returns at once while souls_flags bit $08 is clear.
; Sees: with the Soul of Detection the circle window around the soul orb appears (the walkthrough says the soul shows the invisible enemies of the model towns in Leo's Laboratory; what the window clips is OQ-I042-2).
; Why: as RunSoulOfLightEffect.
; In: actor entry (returns with RTL), X = actor slot; souls_flags.
; Out: bit clear: RTL. Bit set: W12SEL = $20 (and w12sel_shadow), W34SEL = 0, WOBJSEL = 1, bg2_offset_x = bg2_offset_y = 1, then a branch to BuildSoulOrbCircleWindow.
; Clobbers: A, P.

  RunSoulOfDetectionEffect:
    LDA $souls_flags
    AND #$0008
    BNE loc_011710
    RTL 

  loc_011710:
    SEP #$20
    LDA #$20
    STA $W12SEL
    STA $w12sel_shadow
    STZ $W34SEL
    LDA #$01
    STA $WOBJSEL
    LDA #$01
    STA $bg2_offset_x
    STA $bg2_offset_y
    REP #$20
    BRA BuildSoulOrbCircleWindow

; Soul of Shield effect actor: sets the window registers once the soul is recruited, starts the hazard sweep and follows the soul orb with a circle window.
; 
; When: the script of a WorldMetaPointers meta entry; runs every frame, and returns at once while souls_flags bit $04 is clear.
; Sees: with the Soul of Shield the circle window around the soul orb appears and a sweep actor is spawned that clears hazards near the orb; the walkthrough says the soul protects against the magma and lava bombs of Durean (OQ-I042-2).
; Why: as RunSoulOfLightEffect.
; In: actor entry (returns with RTL), X = actor slot; souls_flags.
; Out: bit clear: RTL. Bit set: W12SEL = $33 (and w12sel_shadow), W34SEL = 0, WOBJSEL = 0, TMW = 0, TSW = 3, CGWSEL = $82, COP B0 spawns engine_player_death_and_actor_helpers.DestroyHazardsNearOrb (flags $2010), then BuildSoulOrbCircleWindow.
; Clobbers: A, P.

  RunSoulOfShieldEffect:
    LDA $souls_flags
    AND #$0004
    BNE loc_011737
    RTL 

  loc_011737:
    SEP #$20
    LDA #$33
    STA $W12SEL
    STA $w12sel_shadow
    STZ $W34SEL
    STZ $WOBJSEL
    STZ $TMW
    LDA #$03
    STA $TSW
    LDA #$82
    STA $CGWSEL
    REP #$20
    COP [B0] ( @engine_player_death_and_actor_helpers.DestroyHazardsNearOrb, #$2010 )

; Builds the two HDMA tables of a circle window around the soul orb and queues them for window 1.
; 
; When: the shared tail of the four soul effect actors; every frame after the first (COP 91 sets it as the re-entry address).
; Sees: a circle of radius $40 pixels follows the soul orb.
; Why: window 1 edges per scanline come from a table, so a circle needs two tables rebuilt as the orb moves; HDMA is per frame.
; In: X = actor slot (COP rule), M = 16; soul_orb_actor ($03A0), scroll_bg1_x and scroll_bg1_y.
; Out: dp$16 / $18 = the orb's screen position (clamped), the left and right edge tables at $7E:7000 and $7E:7800 (entries: a line count of 2, the edge byte; closed by a one-line entry with both edges $FF, a window one pixel wide at x = 255 (OQ-I051-3), and a zero), both queued with QueueHdmaDirect for registers $26 and $27; PLX; RTL.
; Clobbers: A, Y, dp$0C, $16, $18 (X restored).

  BuildSoulOrbCircleWindow:
    COP [91]
    PHX 
    LDY $soul_orb_actor
    LDA $0000, Y
    SEC 
    SBC $scroll_bg1_x
    CLC 
    ADC #$0008
    BMI loc_01177A
    CMP #$0100
    BCC loc_01177D
    LDA #$00FF
    BRA loc_01177D

  loc_01177A:
    LDA #$0000

  loc_01177D:
    STA $16
    LDA $0002, Y
    SEC 
    SBC $scroll_bg1_y
    SEC 
    SBC #$0008
    BMI loc_011796
    CMP #$00E0
    BCC loc_011799
    LDA #$00DF
    BRA loc_011799

  loc_011796:
    LDA #$0000

  loc_011799:
    STA $18
    LDX #$0000
    TXY 
    LDA #$00E0
    STA $0C
    LDA $18
    SEC 
    SBC #$0040
    BEQ loc_0117ED
    BPL loc_0117BA
    EOR #$FFFF
    INC 
    CMP #$0080
    BCS loc_011822
    TAY 
    BRA loc_0117ED

  loc_0117BA:
    TAY 
    SEC 
    SBC $0C
    EOR #$FFFF
    INC 
    STA $0C
    TYA 
    CMP #$0080
    BCC loc_0117DD
    SEC 
    SBC #$007F
    TAY 
    LDA #$FF7F
    STA $7E7000, X
    STA $7E7800, X
    INX 
    INX 
    TYA 

  loc_0117DD:
    ORA #$FF00
    STA $7E7000, X
    STA $7E7800, X
    INX 
    INX 
    LDY #$0002

  loc_0117ED:
    SEP #$20

  loc_0117EF:
    LDA #$02
    STA $7E7000, X
    STA $7E7800, X
    LDA $16
    SEC 
    SBC $&data_engine_tables.CircleHalfWidths, Y
    BCS loc_011803
    LDA #$00

  loc_011803:
    STA $7E7001, X
    LDA $16
    CLC 
    ADC $&data_engine_tables.CircleHalfWidths, Y
    BCC loc_011811
    LDA #$FF

  loc_011811:
    STA $7E7801, X
    INX 
    INX 
    INY 
    INY 
    DEC $0C
    BEQ loc_011822
    CPY #$0080
    BCC loc_0117EF

  loc_011822:
    SEP #$20
    LDA #$01
    STA $7E7000, X
    STA $7E7800, X
    LDA #$FF
    STA $7E7001, X
    STA $7E7801, X
    LDA #$00
    STA $7E7002, X
    STA $7E7802, X
    LDA #$26
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaDirect
    LDA #$27
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLX 
    REP #$20
    RTL 
}