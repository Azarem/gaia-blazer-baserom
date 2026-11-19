?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA5_JumpByFlipState {
    TYX                   ; {25186}
    LDA $001C, X          ; {25187}
    PHA                   ; {25190}
    AND #$3FFF            ; {25191}
    STA $001C, X          ; {25194}
    PLA                   ; {25197}
    LDY #$0000            ; {25198}
    AND #$C000            ; {25201}
    BEQ loc_006286        ; {25204}
    INY                   ; {25206}
    INY                   ; {25207}
    CMP #$4000            ; {25208}
    BEQ loc_006286        ; {25211}
    INY                   ; {25213}
    INY                   ; {25214}
    CMP #$8000            ; {25215}
    BEQ loc_006286        ; {25218}
    INY                   ; {25220}
    INY                   ; {25221}

  loc_006286:
    LDA [$38], Y          ; {25222}
    BRL cop_handler_006473.loc_0064C1 ; {25224}
}