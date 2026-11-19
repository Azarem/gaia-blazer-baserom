?BANK 02

!inventory                      1B1E
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

; Store an entry number into the inventory/progress table $1B1E (entry n at $1B1E + n - 1). In: A (8-bit) = entry number. Entries below $19: the byte is overwritten with n. Others: bit 7 of the old byte is kept and n is ORed in; when bit 7 is set the value goes to $1B64 too; when the old value was $38, $043B = $1B8A - $1B88 is recomputed. Called by Cop0A_SetInventoryIfEmpty.

code_0120F9 {
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
    STA $1B64

  loc_012124:
    PLA 
    AND #$7F
    CMP #$38
    BNE loc_012135
    LDA $player_max_hp
    SEC 
    SBC $player_hp
    STA $043B

  loc_012135:
    PLA 
    PLP 
    RTL 
}