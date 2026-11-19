?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C
!player_hp                      1B88

---------------------------------------------

Cop39_DamagePlayer {
    TYX                   ; {24011}
    PHX                   ; {24012}
    LDA [$38]             ; {24013}
    INC $38               ; {24015}
    AND #$00FF            ; {24017}
    SEP #$20              ; {24020}
    PHA                   ; {24022}
    LDA $player_hp        ; {24023}
    SEC                   ; {24026}
    SBC $01, S            ; {24027}
    BPL loc_005DE1        ; {24029}
    LDA #$00              ; {24031}

  loc_005DE1:
    STA $player_hp        ; {24033}
    PLA                   ; {24036}
    REP #$20              ; {24037}
    LDA #$0004            ; {24039}
    TSB $0332             ; {24042}
    LDX $player_actor     ; {24045}
    LDA #$FFE0            ; {24048}
    STA $0026, X          ; {24051}
    BRK #$04              ; {24054}
    LDA $0016, X          ; {24056}
    ORA #$0800            ; {24059}
    STA $0016, X          ; {24062}
    PLX                   ; {24065}
    BRL cop_handler_006473.loc_0064BF ; {24066}
}