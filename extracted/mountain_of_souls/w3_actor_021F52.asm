?BANK 04

!player_actor                   039C
!location_id                    1C6A

---------------------------------------------

code_021F52 {
    LDA $location_id
    AND #$00FF
    CMP #$0045
    BEQ loc_021F6D
    CMP #$0047
    BEQ loc_021F65
    COP [86]
    RTL 

  loc_021F65:
    COP [91]
    PHX 
    LDX #$&unk15_021FED
    BRA loc_021F73

  loc_021F6D:
    COP [91]
    PHX 
    LDX #$&unk15_021FA9

  loc_021F73:
    LDY $player_actor

  loc_021F76:
    LDA $040000, X
    CMP #$FFFF
    BEQ loc_021F95
    CMP $0000, Y
    BNE loc_021F8D
    LDA $040002, X
    CMP $0002, Y
    BEQ loc_021F97

  loc_021F8D:
    TXA 
    CLC 
    ADC #$0006
    TAX 
    BRA loc_021F76

  loc_021F95:
    PLX 
    RTL 

  loc_021F97:
    LDA $040004, X
    BEQ loc_021FA3
    COP [09] ( #$8000 )
    BRA loc_021FA7

  loc_021FA3:
    COP [09] ( #$0000 )

  loc_021FA7:
    PLX 
    RTL 
}
---------------------------------------------

unk15_021FA9 [
  unk15 < #$00A0, #$00B0, #$0001 >   ;00
  unk15 < #$01C0, #$00A0, #$0001 >   ;01
  unk15 < #$0290, #$0230, #$0001 >   ;02
  unk15 < #$0170, #$01D0, #$0001 >   ;03
  unk15 < #$01C0, #$0260, #$0001 >   ;04
  unk15 < #$0290, #$00A0, #$0001 >   ;05
  unk15 < #$00A0, #$00A0, #$0000 >   ;06
  unk15 < #$01C0, #$0090, #$0000 >   ;07
  unk15 < #$0290, #$0220, #$0000 >   ;08
  unk15 < #$0170, #$01C0, #$0000 >   ;09
  unk15 < #$01C0, #$0250, #$0000 >   ;0A
]

unk15_021FED [
  unk15 < #$0220, #$0200, #$0001 >   ;00
  unk15 < #$0120, #$0140, #$0001 >   ;01
  unk15 < #$01A0, #$01A0, #$0001 >   ;02
  unk15 < #$0220, #$0210, #$0000 >   ;03
]