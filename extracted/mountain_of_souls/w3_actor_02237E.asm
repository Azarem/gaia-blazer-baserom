?BANK 04

?INCLUDE 'lib_01186E'

!frame_counter                  0312

---------------------------------------------

code_02237E {
    PHX 
    LDX #$0000

  loc_022382:
    LDA #$00A0
    STA $7E7800, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$0015
    BNE loc_022382
    LDA #$0000
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    LDA $frame_counter
    LSR 
    AND #$001F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 

  loc_0223B6:
    LDA $@word_0223D7, X
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0040
    BNE loc_0223B6
    PLB 
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

word_0223D7 [
  #$0000   ;00
  #$0001   ;01
  #$0001   ;02
  #$0002   ;03
  #$0002   ;04
  #$0002   ;05
  #$0003   ;06
  #$0003   ;07
  #$0003   ;08
  #$0003   ;09
  #$0003   ;0A
  #$0002   ;0B
  #$0002   ;0C
  #$0002   ;0D
  #$0001   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFF   ;12
  #$FFFE   ;13
  #$FFFE   ;14
  #$FFFE   ;15
  #$FFFD   ;16
  #$FFFD   ;17
  #$FFFD   ;18
  #$FFFD   ;19
  #$FFFD   ;1A
  #$FFFE   ;1B
  #$FFFE   ;1C
  #$FFFE   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0001   ;22
  #$0002   ;23
  #$0002   ;24
  #$0002   ;25
  #$0003   ;26
  #$0003   ;27
  #$0003   ;28
  #$0003   ;29
  #$0003   ;2A
  #$0002   ;2B
  #$0002   ;2C
  #$0002   ;2D
  #$0001   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFF   ;32
  #$FFFE   ;33
  #$FFFE   ;34
  #$FFFE   ;35
  #$FFFD   ;36
  #$FFFD   ;37
  #$FFFD   ;38
  #$FFFD   ;39
  #$FFFD   ;3A
  #$FFFE   ;3B
  #$FFFE   ;3C
  #$FFFE   ;3D
  #$FFFF   ;3E
  #$FFFF   ;3F
]