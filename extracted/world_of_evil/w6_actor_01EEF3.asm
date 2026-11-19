?BANK 03

?INCLUDE 'lib_01186E'

!frame_counter                  0312
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C

---------------------------------------------

code_01EEF3 {
    PHX 
    LDX #$0000

  loc_01EEF7:
    LDA #$00C0
    STA $7E7800, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$000C
    BNE loc_01EEF7
    LDA #$0000
    STA $7E7800, X
    PLX 
    COP [91]
    LDA $scroll_bg1_x
    LSR 
    STA $16
    LDA $scroll_bg1_y
    LSR 
    STA $18
    PHX 
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $18
    AND #$003F
    ASL 
    TAX 
    LDY #$0000
    PHB 
    SEP #$20
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_01EF3D:
    LDA $@word_01EF63, X
    CLC 
    ADC $16
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0080
    BNE loc_01EF3D
    PLB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_01186E.code_01186E
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_01EF63 [
  #$0000   ;00
  #$0003   ;01
  #$0006   ;02
  #$0009   ;03
  #$000C   ;04
  #$000F   ;05
  #$0012   ;06
  #$0014   ;07
  #$0017   ;08
  #$0019   ;09
  #$001B   ;0A
  #$001C   ;0B
  #$001E   ;0C
  #$001F   ;0D
  #$001F   ;0E
  #$0020   ;0F
  #$0020   ;10
  #$0020   ;11
  #$001F   ;12
  #$001F   ;13
  #$001E   ;14
  #$001C   ;15
  #$001B   ;16
  #$0019   ;17
  #$0017   ;18
  #$0014   ;19
  #$0012   ;1A
  #$000F   ;1B
  #$000C   ;1C
  #$0009   ;1D
  #$0006   ;1E
  #$0003   ;1F
  #$0000   ;20
  #$FFFD   ;21
  #$FFFA   ;22
  #$FFF7   ;23
  #$FFF4   ;24
  #$FFF1   ;25
  #$FFEE   ;26
  #$FFEC   ;27
  #$FFE9   ;28
  #$FFE7   ;29
  #$FFE5   ;2A
  #$FFE4   ;2B
  #$FFE2   ;2C
  #$FFE1   ;2D
  #$FFE1   ;2E
  #$FFE0   ;2F
  #$FFE0   ;30
  #$FFE0   ;31
  #$FFE1   ;32
  #$FFE1   ;33
  #$FFE2   ;34
  #$FFE4   ;35
  #$FFE5   ;36
  #$FFE7   ;37
  #$FFE9   ;38
  #$FFEC   ;39
  #$FFEE   ;3A
  #$FFF1   ;3B
  #$FFF4   ;3C
  #$FFF7   ;3D
  #$FFFA   ;3E
  #$FFFD   ;3F
  #$0000   ;40
  #$0003   ;41
  #$0006   ;42
  #$0009   ;43
  #$000C   ;44
  #$000F   ;45
  #$0012   ;46
  #$0014   ;47
  #$0017   ;48
  #$0019   ;49
  #$001B   ;4A
  #$001C   ;4B
  #$001E   ;4C
  #$001F   ;4D
  #$001F   ;4E
  #$0020   ;4F
  #$0020   ;50
  #$0020   ;51
  #$001F   ;52
  #$001F   ;53
  #$001E   ;54
  #$001C   ;55
  #$001B   ;56
  #$0019   ;57
  #$0017   ;58
  #$0014   ;59
  #$0012   ;5A
  #$000F   ;5B
  #$000C   ;5C
  #$0009   ;5D
  #$0006   ;5E
  #$0003   ;5F
  #$0000   ;60
  #$FFFD   ;61
  #$FFFA   ;62
  #$FFF7   ;63
  #$FFF4   ;64
  #$FFF1   ;65
  #$FFEE   ;66
  #$FFEC   ;67
  #$FFE9   ;68
  #$FFE7   ;69
  #$FFE5   ;6A
  #$FFE4   ;6B
  #$FFE2   ;6C
  #$FFE1   ;6D
  #$FFE1   ;6E
  #$FFE0   ;6F
  #$FFE0   ;70
  #$FFE0   ;71
  #$FFE1   ;72
  #$FFE1   ;73
  #$FFE2   ;74
  #$FFE4   ;75
  #$FFE5   ;76
  #$FFE7   ;77
  #$FFE9   ;78
  #$FFEC   ;79
  #$FFEE   ;7A
  #$FFF1   ;7B
  #$FFF4   ;7C
  #$FFF7   ;7D
  #$FFFA   ;7E
  #$FFFD   ;7F
]