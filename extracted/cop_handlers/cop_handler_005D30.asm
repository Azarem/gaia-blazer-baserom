?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C

---------------------------------------------

Cop33_PlayerActorsClearBit7 {
    TYX                   ; {23856}
    LDY $player_actor     ; {23857}
    JSR $&code_005D49     ; {23860}
    LDY $039E             ; {23863}
    JSR $&code_005D49     ; {23866}
    LDY $03A0             ; {23869}
    JSR $&code_005D49     ; {23872}
    STZ $0464             ; {23875}
    BRL cop_handler_006473.loc_0064BF ; {23878}
}

code_005D49 {
    LDA $001A, Y          ; {23881}
    AND #$FF7F            ; {23884}
    STA $001A, Y          ; {23887}
    RTS                   ; {23890}
}