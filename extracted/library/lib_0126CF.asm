?BANK 02

?INCLUDE 'engine_000000'

!scroll_bg3_y                   0388
!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_0126CF {
    PHP 
    PHB 
    SEP #$20
    LDA #$02
    PHA 
    PLB 
    LDX #$0702
    PHX 

  loc_0126DB:
    LDA $0000, Y
    BNE loc_0126E3
    BRL loc_012765

  loc_0126E3:
    INY 
    CMP #$0D
    BEQ loc_012715
    CMP #$14
    BEQ loc_01274F
    PHX 
    PHA 
    STA $bg3_tilemap_buffer, X
    LDA #$21
    STA $7F7001, X
    REP #$20
    TXA 
    CLC 
    ADC #$0040
    AND #$07FF
    TAX 
    SEP #$20
    PLA 
    STA $bg3_tilemap_buffer, X
    LDA #$20
    STA $7F7001, X
    PLX 
    INX 
    INX 
    BRA loc_0126DB

  loc_012715:
    LDA #$01
    TSB $vram_upload_flags
    LDA #$20

  loc_01271C:
    INC $scroll_bg3_y
    JSL $@engine_000000.code_0001BE
    DEC 
    BNE loc_01271C
    REP #$20
    PLA 
    CLC 
    ADC #$0100
    AND #$07FF
    TAX 
    PHA 
    SEP #$20
    PHX 
    LDA #$80
    STA $0C

  loc_012739:
    LDA #$00
    STA $bg3_tilemap_buffer, X
    LDA #$20
    STA $7F7001, X
    INX 
    INX 
    DEC $0C
    BNE loc_012739
    PLX 
    BRL loc_0126DB

  loc_01274F:
    LDA $0000, Y
    INY 
    REP #$20
    AND #$00FF
    ASL 
    PHX 
    CLC 
    ADC $01, S
    STA $01, S
    PLX 
    SEP #$20
    BRL loc_0126DB

  loc_012765:
    PLX 
    PLB 
    PLP 
    RTL 
}