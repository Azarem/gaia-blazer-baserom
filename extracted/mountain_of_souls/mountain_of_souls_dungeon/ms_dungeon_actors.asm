?BANK 04

?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank4'

!frame_counter                  0312
!joy_block_mask                 0326
!cgram_buffer                   7F0000

---------------------------------------------

code_021D14 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #02 )
    COP [04]
    COP [34]
    COP [03] ( #3D )
    COP [04]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [01] ( &asciistring_021D48 )
    COP [09] ( #$8707 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$010A, #00, #$0330, #$0370 )
    RTL 
}

asciistring_021D48 |[10]I will not leave you [N]and go off to other [N]places I promise- [FIN]As proof of my [N]promise, I buried my [N]belongings in the [N]Aurora Ridge- [FIN]The Magic Armor, [N]50 GEMs, and [N]one Medical Herb- [FIN]I hope someone will [N]find them- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021DF8 {
    RTL 
}
---------------------------------------------

code_021DF9 {
    COP [15]
    COP [17] ( &code_021E1A )
    COP [91]
    COP [0D] ( #00, #1C, #31, &code_021E09 )
    RTL 
}

code_021E09 {
    COP [01] ( &asciistring_021E64 )
    COP [3C] ( #04 )
    COP [10] ( #$010A, #01, #$0120, #$02C0 )
    RTL 
}

code_021E1A {
    COP [01] ( &asciistring_021E1F )
    RTL 
}

asciistring_021E1F |[10]This is my [N]hometown- [FIN]The mountain winds [N]carried my spores and [N]now we live there- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021E64 |[10]Make sure you don t [N]walk around in a dream[N]or you will get lost- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021E8F {
    COP [07] ( #$9A05, &code_021EAC )
    COP [91]
    COP [0D] ( #00, #20, #2E, &code_021E9F )
    RTL 
}

code_021E9F {
    COP [01] ( &asciistring_021EAF )
    BRK #$5E
    COP [0A] ( #2F )
    COP [09] ( #$9A05 )
}

code_021EAC {
    COP [86]
    RTL 
}

asciistring_021EAF |[10][02:2] found [N][03:24]Master s Emblem F- [03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_02230A {
    PHX 
    LDX #$0000
    LDA #$007F
    STA $7E7800, X
    LDA #$0010
    STA $7E7803, X
    LDA #$0000
    STA $7E7801, X
    STA $7E7804, X
    LDA #$0050
    STA $0C
    LDA #$0001

  loc_02232F:
    STA $7E7806, X
    INX 
    INX 
    INX 
    DEC $0C
    BNE loc_02232F
    LDA $0C
    STA $7E7806, X
    PLX 
    COP [91]
    PHX 
    PHB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaDirect
    LDA #$7E
    PHA 
    PLB 
    REP #$20
    LDA #$0050
    STA $0C
    LDA $033A
    SEC 
    SBC #$0060
    ASL 
    STA $00
    LDX #$0000

  loc_02236B:
    XBA 
    STA $7E7807, X
    XBA 
    INX 
    INX 
    INX 
    CLC 
    ADC $00
    DEC $0C
    BNE loc_02236B
    PLB 
    PLX 
    RTL 
}
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
    JSL $@lib_system_helpers.QueueHdmaIndirect
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
---------------------------------------------

code_022457 {
    LDA #$1C81
    STA $cgram_buffer
    COP [91]
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^binary_022471
    LDY #$&binary_022471
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLP 
    RTL 
}
---------------------------------------------

binary_022471 #09F30AF20AF10AF00AEF0AEE0AED0AEC0AEB0AEA0AE90AE80AE70AE60AE50AE40AE30AE20AE122E000