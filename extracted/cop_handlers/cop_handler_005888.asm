?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

!inventory                      1B1E

---------------------------------------------

Cop0B_ClearInventoryEntry {
    TYX                   ; {22664}
    LDA [$38]             ; {22665}
    INC $38               ; {22667}
    AND #$00FF            ; {22669}
    JSR $&engine_0064F8.code_00651E ; {22672}
    BCS loc_0058A6        ; {22675}
    SEP #$20              ; {22677}
    BPL loc_00589E        ; {22679}
    AND #$7F              ; {22681}
    STZ $1B64             ; {22683}

  loc_00589E:
    EOR $inventory, Y     ; {22686}
    STA $inventory, Y     ; {22689}
    REP #$20              ; {22692}

  loc_0058A6:
    BRL cop_handler_006473.loc_0064BF ; {22694}
}