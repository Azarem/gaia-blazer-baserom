?BANK 00

?INCLUDE 'cop_handler_006473'

!actor_list_tail                06A6
!actor_list_head                06A8

---------------------------------------------

Cop86_KillSelf {
    TYX                   ; {24333}
    LDY $003C, X          ; {24334}
    BNE loc_005F23        ; {24337}
    LDY $003E, X          ; {24339}
    STY $actor_list_tail  ; {24342}
    BEQ loc_005F37        ; {24345}
    LDA #$0000            ; {24347}
    STA $003C, Y          ; {24350}
    BRA loc_005F37        ; {24353}

  loc_005F23:
    LDA $003E, X          ; {24355}
    STA $003E, Y          ; {24358}
    BNE loc_005F30        ; {24361}
    STY $actor_list_head  ; {24363}
    BRA loc_005F37        ; {24366}

  loc_005F30:
    TAY                   ; {24368}
    LDA $003C, X          ; {24369}
    STA $003C, Y          ; {24372}

  loc_005F37:
    SEP #$20              ; {24375}
    DEC $4A               ; {24377}
    DEC $4A               ; {24379}
    REP #$20              ; {24381}
    TXA                   ; {24383}
    STA ($4A)             ; {24384}
    BRL cop_handler_006473.loc_0064BF ; {24386}
}