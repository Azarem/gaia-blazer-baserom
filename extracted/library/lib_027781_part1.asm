?BANK 04

?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'

!player_actor                   039C
!location_id                    1C6A

---------------------------------------------

code_0273F9 {
    PHP 
    PHX 
    SEP #$20
    LDA $location_id
    SEC 
    SBC #$0F
    CMP #$04
    BCS loc_02740A
    BRL loc_02745F

  loc_02740A:
    LDA $0439
    BNE loc_027414
    LDA $1B5E
    BNE loc_027440

  loc_027414:
    LDX $player_actor
    LDA #$0A
    STA $0024, X
    LDY $001E, X
    LDA $&data_00F9F7.binary_00FA7F, Y
    EOR #$01
    STA $001E, X
    REP #$20
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    LDX $039E
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    SEP #$20
    BRA loc_02745F

  loc_027440:
    LDX $player_actor
    LDA #$0B
    STA $0024, X
    REP #$20
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    LDX $039E
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    SEP #$20

  loc_02745F:
    PLX 
    PLP 
    RTL 
}