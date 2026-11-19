?BANK 03

?INCLUDE 'lib_01186E'

!frame_counter                  0312
!scroll_bg2_y                   0340

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
    DEC $038A
    INC $038C
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
    JSL $@lib_01186E.code_01186E
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