?BANK 1F

?INCLUDE 'lib_01186E'

!frame_counter                  0312
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C

---------------------------------------------

code_0FA7C4 {
    PHX 
    LDX #$0000

  loc_0FA7C8:
    LDA #$0090
    STA $7E7000, X
    LDA #$7100
    STA $7E7001, X
    INX 
    INX 
    INX 
    CPX #$002A
    BNE loc_0FA7C8
    LDA #$0000
    STA $7E7000, X
    PLX 
    COP [91]
    PHX 
    LDA $scroll_bg1_x
    LSR 
    STA $00
    LDA $scroll_bg1_y
    LSR 
    STA $02
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $02
    AND #$000F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_0FA80E:
    LDA $@word_0FA834, X
    CLC 
    ADC $00
    STA $7100, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0020
    BNE loc_0FA80E
    PLB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_01186E.code_01186E
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_0FA834 [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0000   ;03
  #$0001   ;04
  #$0001   ;05
  #$0001   ;06
  #$0001   ;07
  #$0000   ;08
  #$0000   ;09
  #$0000   ;0A
  #$0000   ;0B
  #$FFFF   ;0C
  #$FFFF   ;0D
  #$FFFF   ;0E
  #$FFFF   ;0F
  #$0000   ;10
  #$0000   ;11
  #$0000   ;12
  #$0000   ;13
  #$0001   ;14
  #$0001   ;15
  #$0001   ;16
  #$0001   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$FFFF   ;1C
  #$FFFF   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
]