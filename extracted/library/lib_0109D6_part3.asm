?BANK 02

!inventory                      1B1E
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

; Store an entry number into the inventory/progress table $1B1E (entry n at $1B1E + n - 1). In: A (8-bit) = entry number. Entries below $19: the byte is overwritten with n. Others: bit 7 of the old byte is kept and n is ORed in; when bit 7 is set the value goes to $1B64 too; when the old value was $38, $043B = $1B8A - $1B88 is recomputed. Called by Cop0A_SetInventoryIfEmpty.

code_0120F9 {
    PHP                   ; {73977}
    SEP #$20              ; {73978}
    CMP #$19              ; {73980}
    BCS loc_01210B        ; {73982}
    XBA                   ; {73984}
    LDA #$00              ; {73985}
    XBA                   ; {73987}
    TAY                   ; {73988}
    DEY                   ; {73989}
    STA $inventory, Y     ; {73990}
    PLP                   ; {73993}
    RTL                   ; {73994}

  loc_01210B:
    XBA                   ; {73995}
    LDA #$00              ; {73996}
    XBA                   ; {73998}
    TAY                   ; {73999}
    DEY                   ; {74000}
    PHA                   ; {74001}
    LDA $inventory, Y     ; {74002}
    PHA                   ; {74005}
    AND #$80              ; {74006}
    ORA $02, S            ; {74008}
    STA $inventory, Y     ; {74010}
    BPL loc_012124        ; {74013}
    AND #$7F              ; {74015}
    STA $1B64             ; {74017}

  loc_012124:
    PLA                   ; {74020}
    AND #$7F              ; {74021}
    CMP #$38              ; {74023}
    BNE loc_012135        ; {74025}
    LDA $player_max_hp    ; {74027}
    SEC                   ; {74030}
    SBC $player_hp        ; {74031}
    STA $043B             ; {74034}

  loc_012135:
    PLA                   ; {74037}
    PLP                   ; {74038}
    RTL                   ; {74039}
}