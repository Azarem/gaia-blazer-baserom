; Save and load of the four save slots in SRAM, with the checksum that guards them (file offsets 159972-160158, SNES $04:F0E4-$F19E, bank 04).
; 
; === MODEL ===
; A slot is a $400-byte block at $70:slot x $400 (slot 0-3). The same image is kept a second time at +$1000, the backup mirror, and the word $70:1FFE is the last used slot.
; Layout of one slot: +$000 lair_state ($200 bytes, copied from $7F:0203); +$200 the progress image $1A5E-$1C57 ($1FA bytes: event_flags, Gems, level, EXP, HP, equipment, inventory, the player name at $1B92 = slot offset $334, saved_scene at $1B90); +$3FA the checksum sum word; +$3FC the checksum xor word.
; Checksum: both words start at $3652; for each of the first $1FD words of the slot the sum word adds it (16-bit wrap) and the xor word xors it. So the two stored words are not part of the checksum. A slot is valid when both stored words equal the recomputed ones.
; Save order: SaveGameToSlot first stores saved_scene ($1B90) = world_index + 1 into the live image (so it is saved too), then save_slot into $70:1FFE, copies lair_state and the image, stores the checksum and mirrors the slot ($3FE bytes, which include the checksum words) to +$1000. LoadGameFromSlot validates the main copy only: repairing a damaged main copy from the mirror is the job of the file select (DrawSaveSlotMenu in engine_title_file_select), which also refreshes the mirror.
; 
; === NOTES ===
; - Callers: the Master's record question (code_0076EF in shared_actor_helpers_bank0, after the answer Yes) calls SaveGameToSlot; the file select (engine_title_file_select) calls LoadGameFromSlot and ComputeSlotChecksum.
; - saved_scene = world_index + 1 is the scene of area 0 the file select loads after Continue: scene 1 to 7 of Up Above are the shrines of the worlds in world order (docs/areas-and-scenes.md). The walkthrough describes saving at the Master's Shrine (06-dr-leos-lab.md, 'go there to heal and save').
; - All three routines are JSL and need 16-bit index registers (LDX #$0203); X is preserved, DBR and P are restored.
---------------------------------------------

?BANK 04

!save_slot                      03A4
!world_index                    03BA
!saved_scene                    1B90

---------------------------------------------

; Writes the live game state into slot save_slot of SRAM, with checksum and backup copy.
; 
; When: after the player answers Yes to the Master's record question (code_0076EF in shared_actor_helpers_bank0, which plays BRK #$66 first); the only caller.
; Sees: nothing is drawn here; the Master's script goes on with its farewell. The saved game restarts in the shrine of the current world (saved_scene).
; Why: one routine owns the slot format, the checksum and the mirror, so a half-written slot can be recognised and repaired.
; In: JSL; X = 16-bit; save_slot ($03A4) = 0-3; world_index ($03BA, read as a word).
; Out: saved_scene ($1B90) = world_index + 1; $70:1FFE = save_slot; slot offset +$000 = lair_state ($200 bytes), +$200 = $1A5E-$1C57 ($1FA bytes), +$3FA / +$3FC = the checksum words; the whole slot (+$000 to +$3FD) copied to +$1000. X, DBR and P restored.
; Clobbers: A, Y; dp$0C, $16, $18 (ComputeSlotChecksum).

SaveGameToSlot {
    PHP 
    PHX 
    PHB 
    REP #$20
    LDA $world_index
    INC 
    STA $saved_scene      ; saved_scene: the scene the file select loads after Continue (scene world_index + 1 of area 0, the shrine); stored first so it is part of the image
    LDA $save_slot
    STA $701FFE           ; last used slot, read back by the file select to place the cursor
    XBA 
    ASL 
    ASL 
    TAY 
    PHY 
    LDX #$0203
    LDA #$01FF
    MVN #$70, #$7F        ; slot offset +$000: lair_state, $200 bytes from $7F:0203
    LDX #$1A5E
    LDA #$01F9
    MVN #$70, #$01        ; slot offset +$200: $1A5E-$1C57, $1FA bytes (event flags to inventory and name)
    PLX 
    PLB 
    JSL $@ComputeSlotChecksum
    LDA $16
    STA $7003FA, X        ; sum word at slot offset +$3FA
    LDA $18
    STA $7003FC, X        ; xor word at slot offset +$3FC
    PHB 
    TXY 
    TYA 
    CLC 
    ADC #$1000
    TAY 
    LDA #$03FD
    MVN #$70, #$70        ; backup mirror: $3FE bytes (checksum words included) to slot offset + $1000
    PLB 
    PLX 
    PLP 
    RTL 
}
---------------------------------------------

; Copies a validated slot back into the live state.
; 
; When: HandleFileSelectChoice (engine_title_file_select) after the player picks a slot; the only caller.
; Sees: the saved game starts: the file select goes on to scene_next = saved_scene. Carry set means no valid save (the file select then starts a new game, which is inferred, OQ-I024-5).
; Why: the checksum is tested before anything is written, so a damaged slot never overwrites the running state.
; In: JSL; X = 16-bit; save_slot = 0-3.
; Out: carry clear: lair_state ($200 bytes at $7F:0203) and $1A5E-$1C57 ($1FA bytes) replaced from the main copy of the slot. Carry set: sum or xor word differs, nothing changed. X, DBR and P restored (apart from carry).
; Clobbers: A, Y; dp$0C, $16, $18.

LoadGameFromSlot {
    PHP 
    PHB 
    PHX 
    REP #$20
    LDA $save_slot
    XBA 
    ASL 
    ASL 
    TAX 
    JSL $@ComputeSlotChecksum
    LDA $16
    CMP $7003FA, X        ; stored sum word against the computed one in dp$16
    BNE LoadSlotChecksumMismatch
    LDA $18
    CMP $7003FC, X
    BNE LoadSlotChecksumMismatch
    LDY #$0203
    LDA #$01FF
    MVN #$7F, #$70        ; lair_state back from the slot
    LDY #$1A5E
    LDA #$01F9
    MVN #$01, #$70        ; $1A5E-$1C57 back from the slot
    PLX 
    PLB 
    PLP 
    CLC 
    RTL 

  LoadSlotChecksumMismatch:
    PLX 
    PLB 
    PLP 
    SEC 
    RTL 
}
---------------------------------------------

; Computes the sum and xor checksum of a slot.
; 
; When: SaveGameToSlot and LoadGameFromSlot, and twice in the file select (DrawSaveSlotMenu and its repair path).
; Sees: nothing; a slot whose stored words differ from these is not listed in the file select.
; Why: detects a slot that is damaged or never written (the empty SRAM does not give $3652-based words).
; In: JSL; save_slot = 0-3.
; Out: dp$16 = $3652 + the sum of the first $1FD words of the slot (16-bit wrap), dp$18 = $3652 xor each of those words. The words at +$3FA and +$3FC are not included. X, Y and P restored.
; Clobbers: A; dp$0C (loop counter), $16, $18.

ComputeSlotChecksum {
    PHP 
    PHX 
    PHY 
    REP #$20
    LDA $save_slot
    XBA 
    ASL 
    ASL 
    TAX 
    LDA #$3652            ; start value of both running words
    STA $16
    STA $18
    LDA #$01FD            ; $1FD words = $3FA bytes: everything before the two checksum words
    STA $0C

  SlotChecksumLoop:
    LDA $700000, X
    PHA 
    CLC 
    ADC $16
    STA $16
    PLA 
    EOR $18
    STA $18
    INX 
    INX 
    DEC $0C
    BNE SlotChecksumLoop
    PLY 
    PLX 
    PLP 
    RTL 
}