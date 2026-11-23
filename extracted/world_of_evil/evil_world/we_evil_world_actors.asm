?BANK 03

?INCLUDE 'lib_system_helpers'

!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!scroll_bg2_y                   0340
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!player_actor                   039C

---------------------------------------------

code_01EE6D {
    COP [07] ( #$0A01, &code_01EEC2 )
    LDA #$FF80
    TSB $joy_block_mask
    LDA #$00F8
    STA $0000, X
    LDA #$0138
    STA $0002, X
    COP [11] ( #0C, #00, #01 )
    COP [11] ( #0D, #00, #01 )
    COP [11] ( #10, #00, #01 )
    COP [11] ( #11, #00, #01 )
    COP [34]
    COP [03] ( #03 )
    COP [04]
    BRK #$86
    COP [03] ( #FA )
    LDY $player_actor
    LDA $0002, X
    DEC 
    STA $0002, X
    STA $0002, Y
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$010A, #01, #$0100, #$0360 )
}

code_01EEC2 {
    COP [86]
    RTL 
}
---------------------------------------------

code_01EECA {
    COP [92] ( #37 )
    COP [94]
    COP [03] ( #60 )
    COP [07] ( #$8A01, &code_01EEEA )
    COP [19] ( #10, &code_01EEDF )
    BRA code_01EEEA
}

code_01EEDF {
    LDA $frame_counter
    AND #$0007
    BNE code_01EEEA
    COP [39] ( #01 )
}

code_01EEEA {
    COP [04]
    COP [92] ( #4F )
    COP [94]
    BRA code_01EECA
}
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
    JSL $@lib_system_helpers.QueueHdmaIndirect
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
---------------------------------------------

code_01F063 {
    PHX 
    LDX #$0000

  loc_01F067:
    LDA #$00A0
    STA $7E7800, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$0015
    BNE loc_01F067
    LDA #$0000
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    DEC $bg2_offset_x
    INC $bg2_offset_y
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $scroll_bg2_y
    AND #$001F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_01F0A8:
    LDA $@word_01F0CF, X
    CLC 
    ADC $0340
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0040
    BNE loc_01F0A8
    PLB 
    SEP #$20
    LDA #$10
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_01F0CF [
  #$0000   ;00
  #$0001   ;01
  #$0002   ;02
  #$0002   ;03
  #$0003   ;04
  #$0003   ;05
  #$0004   ;06
  #$0004   ;07
  #$0004   ;08
  #$0004   ;09
  #$0004   ;0A
  #$0003   ;0B
  #$0003   ;0C
  #$0002   ;0D
  #$0002   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFE   ;12
  #$FFFE   ;13
  #$FFFD   ;14
  #$FFFD   ;15
  #$FFFC   ;16
  #$FFFC   ;17
  #$FFFC   ;18
  #$FFFC   ;19
  #$FFFC   ;1A
  #$FFFD   ;1B
  #$FFFD   ;1C
  #$FFFE   ;1D
  #$FFFE   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0002   ;22
  #$0002   ;23
  #$0003   ;24
  #$0003   ;25
  #$0004   ;26
  #$0004   ;27
  #$0004   ;28
  #$0004   ;29
  #$0004   ;2A
  #$0003   ;2B
  #$0003   ;2C
  #$0002   ;2D
  #$0002   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFE   ;32
  #$FFFE   ;33
  #$FFFD   ;34
  #$FFFD   ;35
  #$FFFC   ;36
  #$FFFC   ;37
  #$FFFC   ;38
  #$FFFC   ;39
  #$FFFC   ;3A
  #$FFFD   ;3B
  #$FFFD   ;3C
  #$FFFE   ;3D
  #$FFFE   ;3E
  #$FFFF   ;3F
]