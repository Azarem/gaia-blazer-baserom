?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'lib_shared_01112A'

!location_id                    1C6A

---------------------------------------------

code_0112F5 {
    LDX #$0000
    TXY 

  loc_0112F9:
    LDA $1A9E, Y
    INY 
    STA $04
    LDA #$08
    STA $0C

  loc_011303:
    LDA $&data_00BA0D, X
    BPL loc_01130B
    BRL loc_011394

  loc_01130B:
    LSR $04
    BCC loc_011380
    CMP $location_id
    BNE loc_011380
    LDA $&data_00BA0D+6, X
    ORA $&data_00BA0D+7, X
    BEQ loc_011380
    PHX 
    PHY 
    LDA $&data_00BA0D+E, X
    ORA $&data_00BA0D+F, X
    BEQ loc_011363
    REP #$20
    LDA $&data_00BA0D+E, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_00BA0D+F, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    LDA $&data_00BA0D+8, X
    LSR 
    PHP 
    TXA 
    CLC 
    ADC #$&data_00BA0D
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_00BA0D
    PLP 
    SEP #$20
    BCS loc_01135E
    JSR $&lib_shared_01112A.code_0111CB
    BRA loc_01137E

  loc_01135E:
    JSR $&lib_shared_01112A.code_01125E
    BRA loc_01137E

  loc_011363:
    REP #$20
    TXA 
    CLC 
    ADC #$&data_00BA0D
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_00BA0D
    SEP #$20
    LDA #$03
    STA $1C6E
    JSR $&lib_shared_01112A.code_01112A

  loc_01137E:
    PLY 
    PLX 

  loc_011380:
    REP #$20
    TXA 
    CLC 
    ADC #$0020
    TAX 
    SEP #$20
    DEC $0C
    BEQ loc_011391
    BRL loc_011303

  loc_011391:
    BRL loc_0112F9

  loc_011394:
    RTL 
}