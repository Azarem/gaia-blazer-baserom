; COP commands for text, menus, items, Gems, EXP and HP. Commands (id, uses): 01 ShowText (608), 02 PromptYesNo (0), 0A GiveItemIfNotOwned (47), 0B RemoveItem (27), 18 JumpIfItemMissing (55), 19 JumpUnlessItemEquipped (36), 1A ChoiceMenu (27), 25 AddGems (0), 26 PayGemsOrJump (8), 36 AddExp (0), 37 HealPlayerToFull (12), 38 QueueExp (13), 39 DamagePlayer (6), 3A EnterPlayerName (1). Conventions shared by all handlers: cop_core block note.
; 
; === INVENTORY ===
; The inventory is the byte array inventory ($1B1E); entry n (1-based, the item id) is at $1B1E + n - 1: bits 0-6 hold the value (the entry number itself when owned; the engine's give routine lib_0109D6_part3.StoreInventoryEntry writes it), bit 7 is the 'equipped' flag (OQ-I006-2). cop_core.LookupInventoryEntry reads an entry for Cop0A, Cop0B, Cop18 and Cop19. Ids seen in the scripts: $38 Medical Herb, $39 Strange Bottle, $40 Magic Bell (CheckPlayerDeath, engine_003005), $20-$29 (Cop19 in scene actors; names in plans/doc-audit/walkthrough-crosswalk.md section 4).
; 
; === GEMS, EXP, HP ===
; All three counters are BCD. Gems: gems_low ($1B66) and gems_high ($1B68), capped at 999999 by lib_player_stats.AddGems; the price check is SubtractGems (carry set = not enough). EXP: player_exp ($1B78 low word, $1B7A high word). Cop38 does not add EXP directly: it stores the amount in exp_pending ($043D) and the main loop's DrainPendingExp pays it out one digit step per 8 frames with sound. Cop37 sets heal_pending ($043B) = max HP - HP and DrainPendingHeal heals one point every 4 frames. hud_dirty_flags ($0332) bit $04 redraws the HP bar, bit $02 the EXP and bit $10 the Gem counter.
; 
; === TEXT AND MENUS ===
; Cop01 passes a 16-bit string pointer in the script bank to lib_text_render.ShowDialogueText (DBR = script bank). Cop1A prints the option text (PrintTextString), runs lib_012281.RunChoiceMenu (A = number of entries; returns the chosen index in A, carry set = cancelled; sound $18 on choosing, $07 on cancelling), redraws (EraseWindowFrame) and stores the index in choice_result ($03D0). The option strings are in shared_choice_prompt_texts (ChoiceYesNoText ' Yes / No' with 2 entries, ChoiceYesOnlyText a single 'Yes', ChoiceRecordMoveQuitText 'Record / Move / Quit' with 3 entries, ChoiceRecordQuitText 'Record / Quit' with 2, ChoiceStayGoBackText 'Stay / Go back' with 2; layout rule in the block note of shared_choice_prompt_texts). Cop3A opens the name-entry screen (lib_name_entry.RunNameEntryScreen, name buffer from $1B92), used once at the start of the game after the Master's speech (the walkthrough: 'you will then get to pick a name for yourself').
---------------------------------------------

?BANK 00

?INCLUDE 'cop_core'
?INCLUDE 'lib_0109D6_part3'
?INCLUDE 'lib_012281'
?INCLUDE 'lib_name_entry'
?INCLUDE 'lib_player_stats'
?INCLUDE 'lib_text_render'
?INCLUDE 'shared_choice_prompt_texts'

!hud_dirty_flags                0332
!player_actor                   039C
!vram_upload_flags              03B8
!choice_result                  03D0
!text_last_window_origin        03F7
!heal_pending                   043B
!exp_pending                    043D
!inventory                      1B1E
!equipped_armor                 1B60
!equipped_bracelet              1B64
!player_exp                     1B78
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

; Shows a text box with a string.
; 
; When: 608 scripts (every NPC line, sign and chest message).
; Sees: the text window with the string.
; Why: all text goes through one routine; the string is a 16-bit pointer in the script's own bank.
; In: &ASCIIString = word pointer in the script bank.
; Out: calls lib_text_render.ShowDialogueText with Y = pointer and DBR = script bank ($3A), then restores DBR and X and continues. The box, typing delay, paging and resume are described in lib_text_render.ShowDialogueText.
; Clobbers: A, Y; dp$38.

Cop01_ShowText {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    TAY 
    SEP #$20
    PHX 
    PHB 
    LDA $3A
    PHA 
    PLB 
    JSL $@lib_text_render.ShowDialogueText
    PLB 
    PLX 
    REP #$20
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Yes/No prompt with the fixed string ChoiceYesNoText; jumps unless Yes is chosen.
; 
; When: no script uses it (0 uses; OQ-I025-4); the same prompt is made by Cop1A with the same string.
; Sees: ' Yes / No' with a cursor.
; Why: probably the first version of Cop1A (inferred).
; In: &Code = target.
; Out: runs the 2-entry menu (lib_012281.RunChoiceMenu, A = 2); cancelled or choice not 0: jump; Yes: CopExitSkip2.
; Clobbers: A, Y; dp$38.

Cop02_PromptYesNo {
    TYX 
    PHX 
    LDY #$&shared_choice_prompt_texts.ChoiceYesNoText
    JSL $@lib_text_render.PrintTextString
    SEP #$20
    LDA #$00
    XBA 
    LDA #$02
    JSL $@lib_012281.RunChoiceMenu
    PHP 
    LDX $text_last_window_origin
    JSL $@lib_text_render.EraseWindowFrame
    LDA #$01
    STA $vram_upload_flags
    PLP 
    REP #$20
    PLX 
    BCS loc_0057EC
    AND #$00FF
    BNE loc_0057EC
    BRL cop_core.CopExitSkip2

  loc_0057EC:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Gives an item or progress entry unless the player already has it.
; 
; When: 47 scripts (chests, NPC gifts, shops): entry $38 (Medical Herb) in 7 of them, $39 (Strange Bottle) in 2.
; Sees: the item is in the inventory afterwards; the pickup message is a separate Cop01.
; Why: an owned entry stores its own number as value, so giving means writing the number into an empty entry.
; In: Byte = entry number (item id, 1-based).
; Out: LookupInventoryEntry; value bits zero: lib_0109D6_part3.StoreInventoryEntry stores the entry (see its part note); already owned: nothing. Continues.
; Clobbers: A, Y; dp$38.

Cop0A_GiveItemIfNotOwned {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.LookupInventoryEntry
    BCC loc_005885
    JSL $@lib_0109D6_part3.StoreInventoryEntry

  loc_005885:
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Removes an item (clears the value bits of its entry).
; 
; When: 27 scripts (CheckPlayerDeath removes the used Medical Herb or Strange Bottle; the others are in scene scripts).
; Sees: the item disappears from the inventory.
; Why: the counterpart of Cop0A.
; In: Byte = entry number.
; Out: value bits 0-6 = 0; when bit 7 (equipped) was set the entry keeps $80 and equipped_bracelet ($1B64) is cleared; an empty entry is left alone. Continues.
; Clobbers: A, Y; dp$38.

Cop0B_RemoveItem {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.LookupInventoryEntry
    BCS loc_0058A6
    SEP #$20
    BPL loc_00589E
    AND #$7F
    STZ $equipped_bracelet

  loc_00589E:
    EOR $inventory, Y
    STA $inventory, Y
    REP #$20

  loc_0058A6:
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Jumps when the player does not own an item.
; 
; When: 55 scripts.
; Sees: NPCs and doors answer differently when the player lacks the item.
; Why: one-command ownership test.
; In: Byte = entry number, &Code = target.
; Out: value bits 0-6 zero: jump; owned: CopExitSkip2.
; Clobbers: A, Y; dp$38.

Cop18_JumpIfItemMissing {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.LookupInventoryEntry
    BCS loc_005A1F
    BRL cop_core.CopExitSkip2

  loc_005A1F:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps unless the item is owned and its bit 7 is set.
; 
; When: 36 scripts: CheckPlayerDeath (Medical Herb $38, Strange Bottle $39, Magic Bell $40) and scene actors testing the ids $20-$29.
; Sees: the death check consumes or ignores the item; actors react to a worn item.
; Why: bit 7 is the equipped flag (OQ-I006-2).
; In: Byte = entry number, &Code = target.
; Out: missing or bit 7 clear: jump; owned and bit 7 set: CopExitSkip2.
; Clobbers: A, Y; dp$38.

Cop19_JumpUnlessItemEquipped {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.LookupInventoryEntry
    BCS loc_005A3A
    BPL loc_005A3A
    BRL cop_core.CopExitSkip2

  loc_005A3A:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Shows a text with a choice menu and jumps when the player cancels.
; 
; When: 27 scripts: 18 Yes / No questions (ChoiceYesNoText), 6 Stay / Go back return prompts (ChoiceStayGoBackText), a single 'Yes' (ChoiceYesOnlyText), 'Record / Move / Quit' (ChoiceRecordMoveQuitText) and 'Record / Quit' (ChoiceRecordQuitText).
; Sees: the question with a cursor list; the player picks and confirms, or cancels.
; Why: one menu command for every prompt; the choice is read later from choice_result.
; In: &ASCIIString = option text, Byte = number of entries, &Code = target when cancelled.
; Out: prints the string (lib_text_render.PrintTextString), runs lib_012281.RunChoiceMenu (A = entries; returns A = chosen index, carry set = cancelled), redraws (EraseWindowFrame), vram_upload_flags = 1. Chosen: choice_result ($03D0) = index, CopExitSkip2; cancelled: jump.
; Clobbers: A, Y; dp$38.

Cop1A_ChoiceMenu {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    INC $38
    TAY 
    JSL $@lib_text_render.PrintTextString
    SEP #$20
    LDA #$00
    XBA 
    LDA [$38]
    INC $38
    BNE loc_005A5D
    INC $39

  loc_005A5D:
    JSL $@lib_012281.RunChoiceMenu
    PHA 
    PHP 
    LDX $text_last_window_origin
    JSL $@lib_text_render.EraseWindowFrame
    LDA #$01
    STA $vram_upload_flags
    PLP 
    PLA 
    REP #$20
    PLX 
    BCS loc_005A7F
    AND #$00FF
    STA $choice_result
    BRL cop_core.CopExitSkip2

  loc_005A7F:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Adds Gems to the player.
; 
; When: no script uses it (0 uses; OQ-I025-4); Gem pickups use lib_player_stats.AddGems directly.
; Sees: the Gem counter would rise.
; Why: unknown; complete command set.
; In: Word = amount in BCD (copdef lists two Bytes).
; Out: lib_player_stats.AddGems (BCD add, capped at 999999); hud_dirty_flags bit $10; continues.
; Clobbers: A, Y; dp$38.

Cop25_AddGems {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    JSL $@lib_player_stats.AddGems
    LDA #$0010
    TSB $hud_dirty_flags
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Charges the Gem cost of a spell, or jumps when the player cannot pay.
; 
; When: 8 uses: PayPhoenixCost (cost 2) and the spell scripts of player_spells_level_up (costs 1, 4, 8 and $20).
; Sees: casting makes the Gem counter drop; with too few Gems the spell does not fire. The walkthrough: the Magic Bell prevents magic from using Gems, Magic Armor halves the consumption.
; Why: every spell goes through one price check, and the two items change the price here.
; In: Word = cost in BCD, &Code = target when the player is too poor.
; Out: Magic Bell ($1B64 = $40): cost 0; Magic Armor ($1B60 = $0C): cost halved, at least 1; then lib_player_stats.SubtractGems (BCD subtract; carry set = not enough, nothing taken). Paid: hud_dirty_flags bit $10 and CopExitSkip2; short: jump.
; Clobbers: A, Y; dp$00-$05; dp$38.

Cop26_PayGemsOrJump {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    LDY $equipped_bracelet ; Magic Bell ($40) equipped: the cost becomes 0 (the walkthrough: it prevents magic from using Gems)
    CPY #$0040
    BNE loc_005B8D
    LDA #$0000
    BRA loc_005B99

  loc_005B8D:
    LDY $equipped_armor
    CPY #$000C
    BNE loc_005B99
    LSR                   ; Magic Armor ($0C) equipped: the cost is halved but never below 1 (the walkthrough: it halves Gem consumption)
    BNE loc_005B99
    INC 

  loc_005B99:
    JSL $@lib_player_stats.SubtractGems ; BCD subtract of A from the Gems; carry set = not enough, nothing taken
    BCS loc_005BA8
    LDA #$0010
    TSB $hud_dirty_flags
    BRL cop_core.CopExitSkip2

  loc_005BA8:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Adds to the EXP counter without a cap.
; 
; When: no script uses it (0 uses; OQ-I025-4); EXP is awarded by Cop38.
; Sees: nothing.
; Why: unknown; unlike lib_player_stats.AddExp it does not cap the sum at 99999999.
; In: Word = EXP in BCD.
; Out: player_exp ($1B78) + word in decimal mode, the carry into $1B7A.
; Clobbers: A, Y; D flag restored; dp$38.

Cop36_AddExp {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    SED                   ; EXP is BCD; unlike lib_player_stats.AddExp this add has no cap at 99999999
    CLC 
    ADC $player_exp
    STA $player_exp
    LDA $player_exp+2
    ADC #$0000
    STA $player_exp+2
    CLD 
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Refills the player's HP over time.
; 
; When: 12 scripts (healing scenes in the Mountain of Souls, Leo's Laboratory, Greenwood, the Seabed Sanctuary and Magridd's Castle, and a shared helper).
; Sees: the HP bar fills one point every 4 frames with a sound.
; Why: the command only queues the amount; lib_player_stats.DrainPendingHeal does the stepping.
; In: no operand.
; Out: heal_pending ($043B) = max HP - HP.
; Clobbers: A, Y.

Cop37_HealPlayerToFull {
    TYX 
    LDA $player_max_hp
    SEC 
    SBC $player_hp
    STA $heal_pending     ; Missing HP; DrainPendingHeal then heals one point every 4 frames until heal_pending is 0
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Awards EXP to the player.
; 
; When: 13 scripts, amounts $0001, $0150, $0180, $0200, $0250, $0300 and $0400 (Lostside Marsh, Seabed of St. Elles, Leo's Laboratory, Mountain of Souls).
; Sees: the EXP counter climbs in steps with a sound (one digit step per 8 frames, lib_player_stats.DrainPendingExp).
; Why: rewards other than monster kills (the amount is queued, not added at once).
; In: Word = EXP in BCD.
; Out: exp_pending ($043D) = word (replaces an amount still waiting).
; Clobbers: A, Y; dp$38.

Cop38_QueueExp {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $exp_pending      ; exp_pending: BCD EXP waiting to be paid out, replaced (not added) by this command
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Hurts the player by a fixed amount.
; 
; When: 6 scripts (hazards: World of Evil, Leo's Laboratory dungeon, the St. Elles coast, Lostside Marsh, Seabed of St. Elles).
; Sees: HP drops and the player flinches.
; Why: environmental damage that does not go through the contact-damage code.
; In: Byte = damage.
; Out: low byte of player_hp minus the damage (floor 0); hud_dirty_flags bit $04; the player actor's $26 = $FFE0; BRK #$04 (sound request); the player actor's $16 |= $0800 (hit stun). Death is detected by CheckPlayerDeath next frame.
; Clobbers: A, Y; X restored; dp$38.

Cop39_DamagePlayer {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    PHA 
    LDA $player_hp
    SEC 
    SBC $01, S
    BPL loc_005DE1
    LDA #$00

  loc_005DE1:
    STA $player_hp
    PLA 
    REP #$20
    LDA #$0004
    TSB $hud_dirty_flags
    LDX $player_actor
    LDA #$FFE0
    STA $0026, X
    BRK #$04
    LDA $0016, X
    ORA #$0800
    STA $0016, X
    PLX 
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Opens the name-entry screen.
; 
; When: once, in gv_up_above_actors_and_name_entry (code_00798B), between 'you should have a name' and 'What an interesting name'.
; Sees: the player chooses a name for himself (the walkthrough, In the Beginning: 'you will then get to pick a name for yourself').
; Why: the name is typed into the buffer at $1B92 and printed later by the text codes.
; In: no operand.
; Out: lib_name_entry.RunNameEntryScreen runs the screen; continues.
; Clobbers: A, Y.

Cop3A_EnterPlayerName {
    TYX 
    JSL $@lib_name_entry.RunNameEntryScreen
    BRL cop_core.CopExitContinue
}