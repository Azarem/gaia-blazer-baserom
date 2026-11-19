?BANK 02

?INCLUDE 'lib_0124EE_part2'
?INCLUDE 'lib_shared_012769'

!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_0124EE {
    PHP 
    PHX 
    PHY 
    SEP #$20
    STZ $0441
    STZ $0443
    LDX #$03C6
    LDY #$1B92

  loc_0124FF:
    LDA $0000, Y
    BEQ loc_012507
    INY 
    BRA loc_0124FF

  loc_012507:
    BRK #$07

  loc_012509:
    PHX 
    PHY 
    LDY #$&lib_0124EE_part2.asciistring_01445D
    JSL $@lib_shared_012769.code_012769
    LDY #$&lib_0124EE_part2.asciistring_014485
    JSL $@lib_shared_012769.code_012769
    PLY 
    PLX 
    LDA #$2B
    STA $bg3_tilemap_buffer, X
    STA $7F6FC0, X

  loc_012525:
    JSR $&lib_shared_012769.code_013169
    CMP #$00
    BNE loc_012525

  loc_01252C:
    JSR $&lib_shared_012769.code_013169
    LSR 
    BCC loc_012535
    BRL loc_0125EB

  loc_012535:
    LSR 
    BCC loc_01253B
    BRL loc_0125CA

  loc_01253B:
    LSR 
    BCC loc_012541
    BRL loc_012593

  loc_012541:
    LSR 
    BCC loc_012547
    BRL loc_01255C

  loc_012547:
    LSR 
    BCC loc_01254D
    BRL loc_01263E

  loc_01254D:
    LSR 
    LSR 
    BCC loc_012554
    BRL loc_01260C

  loc_012554:
    LSR 
    BCC loc_01255A
    BRL loc_01261D

  loc_01255A:
    BRA loc_01252C

  loc_01255C:
    LDA $0443
    BEQ loc_012581
    DEC $0443
    CMP #$02
    BEQ loc_01256C
    CMP #$04
    BNE loc_012574

  loc_01256C:
    REP #$20
    TXA 
    SEC 
    SBC #$0040
    TAX 

  loc_012574:
    REP #$20
    TXA 
    SEC 
    SBC #$0080
    TAX 
    SEP #$20
    BRL loc_012507

  loc_012581:
    LDA #$04
    STA $0443
    REP #$20
    TXA 
    CLC 
    ADC #$0280
    TAX 
    SEP #$20
    BRL loc_012507

  loc_012593:
    LDA $0443
    CMP #$04
    BCS loc_0125BA
    INC $0443
    CMP #$01
    BEQ loc_0125A5
    CMP #$03
    BNE loc_0125AD

  loc_0125A5:
    REP #$20
    TXA 
    CLC 
    ADC #$0040
    TAX 

  loc_0125AD:
    REP #$20
    TXA 
    CLC 
    ADC #$0080
    TAX 
    SEP #$20
    BRL loc_012507

  loc_0125BA:
    STZ $0443
    REP #$20
    TXA 
    SEC 
    SBC #$0280
    TAX 
    SEP #$20
    BRL loc_012507

  loc_0125CA:
    LDA $0441
    BEQ loc_0125D9
    DEC $0441
    DEX 
    DEX 
    DEX 
    DEX 
    BRL loc_012507

  loc_0125D9:
    LDA #$0C
    STA $0441
    REP #$20
    TXA 
    CLC 
    ADC #$0030
    TAX 
    SEP #$20
    BRL loc_012507

  loc_0125EB:
    LDA $0441
    CMP #$0C
    BCS loc_0125FC
    INC $0441
    INX 
    INX 
    INX 
    INX 
    BRL loc_012507

  loc_0125FC:
    STZ $0441
    REP #$20
    TXA 
    SEC 
    SBC #$0030
    TAX 
    SEP #$20
    BRL loc_012507

  loc_01260C:
    CPY #$1B92
    BNE loc_012614
    BRL loc_01252C

  loc_012614:
    DEY 
    LDA #$00
    STA $0000, Y
    BRL loc_012507

  loc_01261D:
    LDA $7F7002, X
    CMP #$23
    BEQ loc_01263E
    CMP #$24
    BEQ loc_01260C
    CPY #$1B9A
    BCC loc_012631
    BRL loc_01252C

  loc_012631:
    LDA $7F7002, X
    STA $0000, Y
    INY 
    BRK #$18
    BRL loc_012509

  loc_01263E:
    CPY #$1B92
    BNE loc_012646
    BRL loc_01252C

  loc_012646:
    LDA #$00
    STA $0000, Y
    LDY #$&lib_0124EE_part2.asciistring_014512
    JSL $@lib_shared_012769.code_012769
    JSR $&lib_shared_012769.code_013169
    PLY 
    PLX 
    PLP 
    RTL 
}