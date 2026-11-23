?BANK 04

?INCLUDE 'data_engine_tables'
?INCLUDE 'lib_map_index_helpers'

!joy_block_mask                 0326
!player_actor                   039C
!location_id                    1C6A
!tile_type_map                  7F8000

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
---------------------------------------------

code_022007 {
    LDA #$2F80
    TRB $joy_block_mask
    COP [91]
    COP [05] ( #$0000 )
    COP [19] ( #22, &code_02201C )
    COP [27] ( &code_022007 )
}

code_02201C {
    LDY $player_actor
    LDA $001E, Y
    AND #$003F
    PHX 
    TAX 
    LDA $@byte_022032, X
    PLX 
    AND #$00FF
    BNE code_022072
    RTL 
}
---------------------------------------------

byte_022032 [
  #00   ;00
  #00   ;01
  #00   ;02
  #00   ;03
  #01   ;04
  #01   ;05
  #01   ;06
  #01   ;07
  #01   ;08
  #01   ;09
  #01   ;0A
  #01   ;0B
  #01   ;0C
  #01   ;0D
  #01   ;0E
  #01   ;0F
  #01   ;10
  #01   ;11
  #01   ;12
  #01   ;13
  #00   ;14
  #00   ;15
  #00   ;16
  #00   ;17
  #00   ;18
  #00   ;19
  #00   ;1A
  #00   ;1B
  #00   ;1C
  #00   ;1D
  #00   ;1E
  #00   ;1F
  #00   ;20
  #00   ;21
  #00   ;22
  #00   ;23
  #00   ;24
  #01   ;25
  #01   ;26
  #00   ;27
  #01   ;28
  #00   ;29
  #01   ;2A
  #00   ;2B
  #00   ;2C
  #00   ;2D
  #00   ;2E
  #00   ;2F
  #00   ;30
  #00   ;31
  #00   ;32
  #00   ;33
  #00   ;34
  #00   ;35
  #00   ;36
  #00   ;37
  #00   ;38
  #00   ;39
  #00   ;3A
  #00   ;3B
  #00   ;3C
  #00   ;3D
  #00   ;3E
  #00   ;3F
]
---------------------------------------------

code_022072 {
    LDA $001E, Y
    TAY 
    LDA $&data_engine_tables.PlayerMoveDirByAnim, Y
    STA $002C, X
    LDY $player_actor
    LDA #$0000
    STA $0014, Y
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [07] ( #$0000, &code_0220B4 )
    COP [19] ( #22, &code_02209B )
    BRL code_0220B4
}

code_02209B {
    LDA $002C, X
    PHX 
    LDX $player_actor
    AND #$00FF
    BEQ loc_0220B8
    DEC 
    BEQ loc_022106
    DEC 
    BNE loc_0220B0
    BRL loc_0221A6

  loc_0220B0:
    BRL loc_022152

  code_0220B3:
    PLX 
}

code_0220B4 {
    COP [27] ( &code_022007 )

  loc_0220B8:
    LDA $0002, X
    AND #$000F
    BNE loc_0220FE
    LDA $0000, X
    AND #$000F
    BEQ loc_0220FA
    LDA $0000, X
    AND #$FFF0
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    STA $18
    JSR $&code_0221FA
    BCS code_0220B3
    LDA $0000, X
    AND #$FFF0
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    STA $18
    JSR $&code_0221FA
    BCS code_0220B3
    BRA loc_0220FE

  loc_0220FA:
    COP [21] ( &code_0220B3 )

  loc_0220FE:
    COP [2F] ( #$0000, #$FFFE )
    PLX 
    RTL 

  loc_022106:
    LDA $0002, X
    AND #$000F
    BNE loc_02214A
    LDA $0000, X
    AND #$000F
    BEQ loc_022146
    LDA $0000, X
    AND #$FFF0
    STA $16
    LDA $0002, X
    STA $18
    JSR $&code_0221FA
    BCC loc_02212B
    BRL code_0220B3

  loc_02212B:
    LDA $0000, X
    AND #$FFF0
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    STA $18
    JSR $&code_0221FA
    BCC loc_022144
    BRL code_0220B3

  loc_022144:
    BRA loc_02214A

  loc_022146:
    COP [22] ( &code_0220B3 )

  loc_02214A:
    COP [2F] ( #$0000, #$0002 )
    PLX 
    RTL 

  loc_022152:
    LDA $0000, X
    AND #$000F
    BNE loc_02219E
    LDA $0002, X
    AND #$000F
    BEQ loc_02219A
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSR $&code_0221FA
    BCC loc_02217F
    BRL code_0220B3

  loc_02217F:
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    STA $18
    JSR $&code_0221FA
    BCC loc_022198
    BRL code_0220B3

  loc_022198:
    BRA loc_02219E

  loc_02219A:
    COP [23] ( &code_0220B3 )

  loc_02219E:
    COP [2F] ( #$FFFE, #$0000 )
    PLX 
    RTL 

  loc_0221A6:
    LDA $0000, X
    AND #$000F
    BNE loc_0221F2
    LDA $0002, X
    AND #$000F
    BEQ loc_0221EE
    LDA $0000, X
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSR $&code_0221FA
    BCC loc_0221D3
    BRL code_0220B3

  loc_0221D3:
    LDA $0000, X
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    STA $18
    JSR $&code_0221FA
    BCC loc_0221EC
    BRL code_0220B3

  loc_0221EC:
    BRA loc_0221F2

  loc_0221EE:
    COP [24] ( &code_0220B3 )

  loc_0221F2:
    COP [2F] ( #$0002, #$0000 )
    PLX 
    RTL 
}

code_0221FA {
    PHX 
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BNE loc_02220B
    CLC 
    RTS 

  loc_02220B:
    SEC 
    RTS 
}