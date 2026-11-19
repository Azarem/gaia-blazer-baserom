?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_010EA9_part3'
?INCLUDE 'lib_027348'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_01112A'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131D1'

!map_width_pages                0343
!map_height_pages               0345
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!location_id                    1C6A
!tile_type_map                  7F8000

---------------------------------------------

code_010DBD {
    LDX #$0000
    TXY 

  loc_010DC1:
    LDA $&data_00BA0D, X
    BMI loc_010DE8
    CMP $location_id
    BNE loc_010DDB
    LDA $&data_00BA0D+2, X
    CMP $player_tile_x
    BNE loc_010DDB
    LDA $&data_00BA0D+3, X
    CMP $player_tile_y
    BEQ loc_010DE9

  loc_010DDB:
    REP #$20
    TXA 
    CLC 
    ADC #$0020
    TAX 
    INY 
    SEP #$20
    BRA loc_010DC1

  loc_010DE8:
    RTL 

  loc_010DE9:
    LDA $&data_00BA0D+9, X
    STA $03C8
    STZ $03C9
    PHX 
    PHY 
    LDY #$&lib_010EA9_part3.asciistring_016203
    JSL $@lib_shared_012769.code_012C27
    JSL $@engine_000000.code_000173
    PLY 
    PLX 
    PHX 
    TYX 
    LDA $7F0203, X
    AND #$BF
    STA $7F0203, X
    PLX 
    REP #$20
    TYA 
    PHA 
    TXA 
    CLC 
    ADC #$&data_00BA0D
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_00BA0D
    LDA $1C6F
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $1C70
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    PHX 
    SEP #$20
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_shared_0131D1.code_0131D1
    STA $01
    STZ $00
    LDY #$0004

  loc_010E52:
    REP #$20
    TXA 
    CLC 
    ADC $00
    TAX 
    SEP #$20
    CPX #$4000
    BCS loc_010E63
    DEY 
    BNE loc_010E52

  loc_010E63:
    PLX 
    BRK #$9C
    LDA $1C73
    BNE loc_010E74
    STZ $1C75
    JSL $@engine_000000.code_000173
    BRA loc_010E95

  loc_010E74:
    JSR $&lib_shared_01112A.code_01112A
    LDA #$01
    STA $1C75
    INC $1C6C
    LDA #$23

  loc_010E81:
    JSL $@engine_000000.code_000173
    DEC 
    BNE loc_010E81
    STZ $1C6C
    INC $1C6E
    LDA $1C6E
    CMP #$04
    BCC loc_010E74

  loc_010E95:
    REP #$20
    PLA 
    LDY #$1A9E
    JSL $@lib_027348.code_027348
    LDY #$1ADE
    JSL $@lib_027348.code_027348
    SEP #$20
    RTL 
}

code_010EA9 {
    REP #$20
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA $tile_type_map, X
    CMP #$01
    BNE loc_010ECC
    JSL $@code_010DBD
    RTL 

  loc_010ECC:
    REP #$20
    LDA $0405
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    SEP #$20
    LDA $&data_00BA0D+9, X
    STA $03C8
    STZ $03C9
    LDY #$&lib_010EA9_part3.asciistring_0161DE
    JSL $@lib_shared_012769.code_012C27
    RTL 
}