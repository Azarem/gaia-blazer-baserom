; Inventory store (file offsets 73977-74039, SNES $02:A0F9-$A137, bank 02).
; 
; The inventory / progress table is the byte array inventory ($1B1E): entry n (1-based) is at $1B1E + n - 1, bits 0-6 hold the value (the entry number when owned), bit 7 is the 'equipped' flag (OQ-I006-2). StoreInventoryEntry is the only writer used by the item scripts (Cop0A_GiveItemIfNotOwned) and by the chest code (TryOpenChest).
---------------------------------------------

?BANK 02

!heal_pending                   043B
!inventory                      1B1E
!equipped_bracelet              1B64
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

; Stores an entry number into the inventory table, keeping the equipped flag.
; 
; When: Cop0A_GiveItemIfNotOwned (item given by a script or shop), TryOpenChest (item chests) and the unused DebugApplyItem.
; Sees: the item or progress entry is in the inventory afterwards; if the old entry was equipped (bit 7) the new value is also copied to equipped_bracelet.
; Why: entries from $19 upward are upgrades that replace the old value while keeping the equipped flag, so the table stores them with an OR.
; In: A (8 bits) = entry number n; M = 1.
; Out: n below $19: inventory[n - 1] = n. n from $19: inventory[n - 1] = (old bit 7) OR n; if bit 7 was set equipped_bracelet = n. Then, when the old value (bit 7 masked) was $38, heal_pending = player_max_hp - player_hp (OQ-I026-7: it tests the old value, not the new one).
; Clobbers: A, Y (P restored).

StoreInventoryEntry {
    PHP 
    SEP #$20
    CMP #$19
    BCS loc_01210B
    XBA 
    LDA #$00
    XBA 
    TAY 
    DEY 
    STA $inventory, Y
    PLP 
    RTL 

  loc_01210B:
    XBA 
    LDA #$00
    XBA 
    TAY 
    DEY 
    PHA 
    LDA $inventory, Y
    PHA 
    AND #$80
    ORA $02, S
    STA $inventory, Y
    BPL loc_012124
    AND #$7F
    STA $equipped_bracelet

  loc_012124:
    PLA 
    AND #$7F
    CMP #$38              ; Tests the OLD value of the entry (OQ-I026-7); $38 is the Medical Herb
    BNE loc_012135
    LDA $player_max_hp
    SEC 
    SBC $player_hp
    STA $heal_pending

  loc_012135:
    PLA 
    PLP 
    RTL 
}