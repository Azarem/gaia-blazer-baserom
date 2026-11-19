?BANK 00

?INCLUDE 'cop_handler_006473'

!player_actor                   039C
!player_hp                      1B88

---------------------------------------------

Cop39_DamagePlayer {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    PHA 
    LDA $player_hp
    SEC 
    SBC $01, S
    BPL loc_005DE1
    LDA #$00

  loc_005DE1:
    STA $player_hp
    PLA 
    REP #$20
    LDA #$0004
    TSB $0332
    LDX $player_actor
    LDA #$FFE0
    STA $0026, X
    BRK #$04
    LDA $0016, X
    ORA #$0800
    STA $0016, X
    PLX 
    BRL cop_handler_006473.loc_0064BF
}