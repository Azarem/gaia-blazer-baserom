?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_01112A'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'table_00B69A'

!map_width_pages                0343
!map_height_pages               0345
!player_tile_x                  0378
!player_tile_y                  037A
!location_id                    1C6A
!tile_type_map                  7F8000

---------------------------------------------

code_011395 {
    LDX #$01FF

  loc_011398:
    LDA $7F0203, X
    BPL loc_0113A1
    ASL 
    BMI loc_0113A5

  loc_0113A1:
    DEX 
    BPL loc_011398
    RTL 

  loc_0113A5:
    REP #$20
    PHX 
    TXA 
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    TAY 
    SEP #$20
    LDA $&data_00BA0D, X
    CMP $location_id
    BEQ loc_0113BD
    BRL loc_011441

  loc_0113BD:
    LDY $&data_00BA0D+1E, X
    BEQ loc_0113D2
    LDA $&data_00BA0D+1F, X
    XBA 
    LDA $&data_00BA0D+1E, X
    LDY #$1ADE
    JSL $@lib_0273A2.code_0273A2
    BCC loc_011441

  loc_0113D2:
    TXY 
    REP #$20
    LDA $&data_00BA0D+2, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_00BA0D+3, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA $&data_00BA0D+6, Y
    ORA $&data_00BA0D+7, Y
    BNE loc_01143B
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_shared_0131D1.code_0131D1
    STA $01
    STZ $00
    XBA 
    LDA $&data_00BA0D+1, Y
    BEQ loc_011421
    JSL $@lib_shared_0131D1.code_0131D1
    REP #$20
    PHX 
    XBA 
    CLC 
    ADC $01, S
    TAX 
    PLA 
    SEP #$20
    BRA loc_01143B

  loc_011421:
    LDY #$0003

  loc_011424:
    LDA #$01
    STA $tile_type_map, X
    REP #$20
    TXA 
    CLC 
    ADC $00
    TAX 
    SEP #$20
    CPX #$4000
    BCS loc_011441
    DEY 
    BNE loc_011424

  loc_01143B:
    LDA #$01
    STA $tile_type_map, X

  loc_011441:
    PLX 
    BRL loc_0113A1

  code_011445:
    LDX #$0000
    STZ $03A8
    REP #$20
    LDA $location_id
    ASL 
    ASL 
    TAX 
    STX $03AA
    LDA $&table_00B69A, X
    SEC 
    SBC #$&table_00B69A
    STA $03AC
    TAX 
    SEP #$20

  loc_011463:
    LDA $&table_00B69A, X
    CMP #$FF
    BEQ loc_01148E
    CMP $player_tile_x
    BNE loc_011487
    LDA $&table_00B69A+1, X
    CMP $player_tile_y
    BNE loc_011487
    LDA $&table_00B69A+3, X
    XBA 
    LDA $&table_00B69A+2, X
    LDY #$1A9E
    JSL $@lib_0273A2.code_0273A2
    BCS loc_01148F

  loc_011487:
    INX 
    INX 
    INX 
    INX 
    BRL loc_011463

  loc_01148E:
    RTL 

  loc_01148F:
    REP #$20
    LDA $&table_00B69A+2, X
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$&data_00BA0D
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_00BA0D
    SEP #$20
    LDA #$02
    STA $1C6E
    JSR $&lib_shared_01112A.code_01112A
    REP #$20
    LDX $03AA
    LDA $03A8
    EOR #$0001
    STA $03A8
    BEQ loc_0114C3
    INX 
    INX 

  loc_0114C3:
    LDA $&table_00B69A, X
    SEC 
    SBC #$&table_00B69A
    STA $03AC
    SEP #$20
    RTL 
}