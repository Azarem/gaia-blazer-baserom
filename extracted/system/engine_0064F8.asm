; Event-flag and inventory lookups used by the COP flag, wait and inventory commands.
; 
; Event flags are a bit array at $1A5E. A flag word has the bit number (0-7) in its low byte and the byte index in bits 8-14; bit 15 is a command-specific sense bit (Cop05_WaitFlag, Cop09_SetOrClearFlag). The inventory/progress bytes are at $1B1E (entry n at $1B1E + n - 1, bit 7 = flag, bits 0-6 = value).
---------------------------------------------

?BANK 00

!event_flags                    1A5E
!inventory                      1B1E

---------------------------------------------

; Test an event flag. In: A = flag word. Out: carry set when the flag bit is set, clear otherwise. Preserves X.

code_0064F8 {
    PHX 
    STA $00
    AND #$00FF
    TAX 
    LDA $01
    AND #$007F
    TAY 
    SEP #$20
    LDA $@binary_006516, X
    AND $event_flags, Y
    SEC 
    BNE loc_006512
    CLC 

  loc_006512:
    PLX 
    REP #$20
    RTS 
}
---------------------------------------------

; Bit masks $01..$80 indexed by the low byte of a flag word.

binary_006516 #0102040810204080
---------------------------------------------

; Look up an inventory/progress entry. In: A (8-bit) = entry number (1-based). Out: carry set and A preserved when the value bits (0-6) are zero; carry clear and A = the whole $1B1E byte when they are not.

code_00651E {
    SEP #$20
    PHA 
    TAY 
    DEY 
    LDA $inventory, Y
    AND #$7F
    BNE loc_00652F
    PLA 
    REP #$20
    SEC 
    RTS 

  loc_00652F:
    PLA 
    LDA $inventory, Y
    REP #$20
    CLC 
    RTS 
}