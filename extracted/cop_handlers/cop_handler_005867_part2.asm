?BANK 00

?INCLUDE 'engine_0064F8'

!event_flags                    1A5E

---------------------------------------------

; Set or clear an event flag. In: A = flag word (low byte = bit number 0-7, bits 8-14 = byte index into $1A5E, bit 15 set = set the bit, clear = clear it). Preserves X.

code_0064CC {
    PHX                   ; {25804}
    STA $00               ; {25805}
    AND #$00FF            ; {25807}
    TAX                   ; {25810}
    LDA $01               ; {25811}
    AND #$007F            ; {25813}
    TAY                   ; {25816}
    SEP #$20              ; {25817}
    LDA $01               ; {25819}
    BPL loc_0064E8        ; {25821}
    LDA $@engine_0064F8.binary_006516, X ; {25823}
    ORA $event_flags, Y   ; {25827}
    BRA loc_0064F1        ; {25830}

  loc_0064E8:
    LDA $@engine_0064F8.binary_006516, X ; {25832}
    EOR #$FF              ; {25836}
    AND $event_flags, Y   ; {25838}

  loc_0064F1:
    STA $event_flags, Y   ; {25841}
    PLX                   ; {25844}
    REP #$20              ; {25845}
    RTS                   ; {25847}
}