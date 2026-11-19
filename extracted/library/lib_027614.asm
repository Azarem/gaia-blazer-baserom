?BANK 04

!frame_counter                  0312
!player_exp                     1B78

---------------------------------------------

code_027614 {
    LDA $043D
    ORA $043E
    BEQ loc_027686
    LDA $frame_counter
    AND #$07
    BNE loc_027686
    REP #$20
    BRK #$48
    SED 
    LDA $043D
    AND #$000F
    BNE loc_02766D
    LDA $043D
    AND #$00F0
    BNE loc_02765E
    LDA $043D
    AND #$0F00
    BNE loc_02764F
    LDA $043D
    SEC 
    SBC #$1000
    STA $043D
    LDA #$1000
    BRA loc_02767A

  loc_02764F:
    LDA $043D
    SEC 
    SBC #$0100
    STA $043D
    LDA #$0100
    BRA loc_02767A

  loc_02765E:
    LDA $043D
    SEC 
    SBC #$0010
    STA $043D
    LDA #$0010
    BRA loc_02767A

  loc_02766D:
    LDA $043D
    SEC 
    SBC #$0001
    STA $043D
    LDA #$0001

  loc_02767A:
    CLD 
    JSL $@code_027687
    SEP #$20
    LDA #$02
    TSB $0332

  loc_027686:
    RTL 
}

code_027687 {
    SED 
    CLC 
    ADC $player_exp
    STA $player_exp
    LDA $1B7A
    ADC #$0000
    STA $1B7A
    BCC loc_0276A3
    LDA #$9999
    STA $player_exp
    STA $1B7A

  loc_0276A3:
    CLD 
    RTL 
}