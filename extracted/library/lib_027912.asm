?BANK 04

?INCLUDE 'data_00BA0D'

!player_level_bcd               1B6A
!player_level                   1B86
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_027912 {
    LDX #$8000
    STX $0352
    LDX #$C000
    STX $0356
    LDX #$6000
    STX $0354
    LDX #$7000
    STX $0358
    LDX #$2000
    STX $035A
    LDX #$2800
    STX $035E
    LDX #$3000
    STX $0362
    LDX #$3102
    STX $0364
    LDX #$3204
    STX $0366
    LDX #$3306
    STX $0368
    LDA #$7E
    STA $34
    STA $37
    STA $002E
    LDA #$8B
    STA $1C5C
    LDA #$54
    STA $1C5D
    LDA #$AB
    STA $1C60
    LDA #$60
    STA $1C61
    LDA #$03
    STA $1B84
    LDX #$3000
    STX $1A02
    LDA #$7F
    STA $1A04
    REP #$20
    LDA #$0080
    STA $1A7D
    SEP #$20
    LDA #$08
    STA $player_max_hp
    STA $player_hp
    LDA #$01
    STA $player_level
    STA $player_level_bcd
    LDX #$0000
    TXY 

  loc_027999:
    LDA $&data_00BA0D, Y
    CMP #$FF
    BEQ loc_0279B4
    LDA $&data_00BA0D+13, Y
    STA $7F0203, X
    REP #$20
    INX 
    TYA 
    CLC 
    ADC #$0020
    TAY 
    SEP #$20
    BRA loc_027999

  loc_0279B4:
    RTL 
}