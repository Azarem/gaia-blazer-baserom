?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C

---------------------------------------------

Cop34_PlayerActorsSetBit7 {
    TYX                   ; {23891}
    LDY $player_actor     ; {23892}
    JSR $&code_005D6C     ; {23895}
    LDY $039E             ; {23898}
    JSR $&code_005D6C     ; {23901}
    LDY $03A0             ; {23904}
    JSR $&code_005D6C     ; {23907}
    INC $0464             ; {23910}
    BRL cop_handler_006473.loc_0064BF ; {23913}
}

code_005D6C {
    LDA $001A, Y          ; {23916}
    ORA #$0080            ; {23919}
    STA $001A, Y          ; {23922}
    RTS                   ; {23925}
}