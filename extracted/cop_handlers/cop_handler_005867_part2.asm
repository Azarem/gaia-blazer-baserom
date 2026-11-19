?BANK 00

?INCLUDE 'engine_0064F8'

!event_flags                    1A5E

---------------------------------------------

; Set or clear an event flag. In: A = flag word (low byte = bit number 0-7, bits 8-14 = byte index into $1A5E, bit 15 set = set the bit, clear = clear it). Preserves X.

code_0064CC {
    PHX 
    STA $00
    AND #$00FF
    TAX 
    LDA $01
    AND #$007F
    TAY 
    SEP #$20
    LDA $01
    BPL loc_0064E8
    LDA $@engine_0064F8.binary_006516, X
    ORA $event_flags, Y
    BRA loc_0064F1

  loc_0064E8:
    LDA $@engine_0064F8.binary_006516, X
    EOR #$FF
    AND $event_flags, Y

  loc_0064F1:
    STA $event_flags, Y
    PLX 
    REP #$20
    RTS 
}