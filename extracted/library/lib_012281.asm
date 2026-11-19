?BANK 02

?INCLUDE 'lib_shared_01230B'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_012281 {
    STA $03C4
    XBA 
    PHA 
    STZ $03C6

  loc_012289:
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    LDA #$01
    TSB $vram_upload_flags

  loc_012298:
    JSR $&lib_shared_012769.code_013169
    BEQ loc_0122A2
    JSR $&lib_shared_01230B.code_01230B
    BRA loc_012298

  loc_0122A2:
    JSR $&lib_shared_012769.code_013169
    BIT #$08
    BNE loc_0122CE
    BIT #$04
    BNE loc_0122E3
    BIT #$40
    BNE loc_0122BF
    BIT #$80
    BNE loc_0122BA
    JSR $&lib_shared_01230B.code_01230B
    BRA loc_0122A2

  loc_0122BA:
    BRK #$18
    CLC 
    BRA loc_0122C2

  loc_0122BF:
    BRK #$07
    SEC 

  loc_0122C2:
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    PLA 
    RTL 

  loc_0122CE:
    LDA $01, S
    BEQ loc_012298
    DEC 
    STA $01, S
    TXY 
    REP #$20
    TYA 
    SEC 
    SEC 
    SBC #$0080
    TAY 
    SEP #$20
    BRA loc_0122F8

  loc_0122E3:
    LDA $01, S
    INC 
    CMP $03C4
    BCS loc_012298
    STA $01, S
    TXY 
    REP #$20
    TYA 
    CLC 
    ADC #$0080
    TAY 
    SEP #$20

  loc_0122F8:
    BRK #$07
    LDA #$20
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    STZ $03C6
    TYX 
    BRL loc_012289
}