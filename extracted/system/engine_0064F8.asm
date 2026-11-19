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
    PHX                   ; {25848}
    STA $00               ; {25849}
    AND #$00FF            ; {25851}
    TAX                   ; {25854}
    LDA $01               ; {25855}
    AND #$007F            ; {25857}
    TAY                   ; {25860}
    SEP #$20              ; {25861}
    LDA $@binary_006516, X ; {25863}
    AND $event_flags, Y   ; {25867}
    SEC                   ; {25870}
    BNE loc_006512        ; {25871}
    CLC                   ; {25873}

  loc_006512:
    PLX                   ; {25874}
    REP #$20              ; {25875}
    RTS                   ; {25877}
}
---------------------------------------------

; Bit masks $01..$80 indexed by the low byte of a flag word.

binary_006516 #0102040810204080
---------------------------------------------

; Look up an inventory/progress entry. In: A (8-bit) = entry number (1-based). Out: carry set and A preserved when the value bits (0-6) are zero; carry clear and A = the whole $1B1E byte when they are not.

code_00651E {
    SEP #$20              ; {25886}
    PHA                   ; {25888}
    TAY                   ; {25889}
    DEY                   ; {25890}
    LDA $inventory, Y     ; {25891}
    AND #$7F              ; {25894}
    BNE loc_00652F        ; {25896}
    PLA                   ; {25898}
    REP #$20              ; {25899}
    SEC                   ; {25901}
    RTS                   ; {25902}

  loc_00652F:
    PLA                   ; {25903}
    LDA $inventory, Y     ; {25904}
    REP #$20              ; {25907}
    CLC                   ; {25909}
    RTS                   ; {25910}
}