?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'data_00F99A'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0133A6_part5'
?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_01112A'

!location_id                    1C6A

---------------------------------------------

code_01157E {
    LDX #$0000
    TXY 
    STZ $0456

  loc_011585:
    LDA $&data_00BA0D, Y
    CMP #$FF
    BEQ loc_0115B0
    LDA $&data_00BA0D+B, Y
    CMP $location_id
    BNE loc_0115A3
    INC $0456
    LDA $7F0203, X
    BMI loc_0115B1
    BEQ loc_0115B1
    JSL $@engine_000000.code_00144F

  loc_0115A3:
    REP #$20
    TYA 
    CLC 
    ADC #$0020
    TAY 
    SEP #$20
    INX 
    BRA loc_011585

  loc_0115B0:
    RTL 

  loc_0115B1:
    PHX 
    PHY 
    PHP 
    REP #$20
    LDA $&data_00BA0D+C, Y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_00BA0D+D, Y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA #$FE
    PLP 
    BPL loc_0115DE
    LDA #$FF
    DEC $0456

  loc_0115DE:
    STA $7E8000, X
    XBA 
    LDA $&data_00BA0D+8, Y
    BEQ loc_0115ED
    XBA 
    STA $7EC000, X

  loc_0115ED:
    PLY 
    PLX 
    BRA loc_0115A3

  code_0115F1:
    LDX #$0000
    TXY 

  loc_0115F5:
    LDA $@lib_0133A6_part5.unk13_01728D, X
    CMP #$FF
    BEQ loc_011620
    CMP $location_id
    BNE loc_011614
    LDA $@lib_0133A6_part5.unk13_01728D+2, X
    XBA 
    LDA $@lib_0133A6_part5.unk13_01728D+1, X
    LDY #$1A5E
    JSL $@lib_0273A2.code_0273A2
    BCS loc_011621

  loc_011614:
    REP #$20
    TXA 
    CLC 
    ADC #$0009
    TAX 
    SEP #$20
    BRA loc_0115F5

  loc_011620:
    RTL 

  loc_011621:
    PHX 
    LDA $@lib_0133A6_part5.unk13_01728D+3, X
    STA $1C71
    LDA $@lib_0133A6_part5.unk13_01728D+4, X
    STA $1C72
    LDA $@lib_0133A6_part5.unk13_01728D+5, X
    STA $1C73
    LDA $@lib_0133A6_part5.unk13_01728D+6, X
    STA $1C74
    REP #$20
    LDA $@lib_0133A6_part5.unk13_01728D+7, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $@lib_0133A6_part5.unk13_01728D+8, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSR $&lib_shared_01112A.code_0111CB
    SEP #$20
    PLX 
    BRA loc_011614

  code_011662:
    PHX 
    PHY 
    LDX #$0000

  loc_011667:
    LDA $&data_00F99A, X
    BMI loc_011691
    CMP $location_id
    BNE loc_01168B
    LDA $&data_00F99A+2, X
    XBA 
    LDA $&data_00F99A+1, X
    LDY #$1ADE
    JSL $@lib_0273A2.code_0273A2
    BCC loc_01168B
    LDA $&data_00F99A+3, X
    STA $031E
    SEC 
    PLY 
    PLX 
    RTL 

  loc_01168B:
    INX 
    INX 
    INX 
    INX 
    BRA loc_011667

  loc_011691:
    CLC 
    PLY 
    PLX 
    RTL 
}