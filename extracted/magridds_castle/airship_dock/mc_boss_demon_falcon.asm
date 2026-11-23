?BANK 00

!rng_state                      0301
!boss_actor                     039A
!random_mod_result              0437
!boss_fight_active              0458

---------------------------------------------

code_004BEE {
    INC $boss_fight_active
    STX $boss_actor
    COP [85] ( @code_004D09 )

  loc_004BF9:
    COP [80] ( #08 )
    COP [82]

  loc_004BFE:
    COP [9B] ( #$0070, &code_004C08, &code_004C08, &code_004C0F )
}

code_004C08 {
    COP [80] ( #09 )
    COP [82]
    BRA loc_004BFE
}

code_004C0F {
    COP [80] ( #0A )
    COP [82]
    COP [87]
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]

  loc_004C20:
    COP [81] ( #00, #02 )
    COP [83]
    COP [1F]
    LDA $rng_state+1
    AND #$0007
    CMP #$0005
    BCS loc_004C4D
    COP [80] ( #0E )
    COP [82]
    BRK #$56
    COP [81] ( #0F, #0D )
    COP [83]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRL loc_004BF9

  loc_004C4D:
    COP [80] ( #01 )
    COP [82]
    COP [80] ( #1B )
    COP [82]

  loc_004C57:
    LDA $0000, X
    CMP #$00F0
    BEQ loc_004CA0
    CMP #$01E0
    BEQ loc_004CA0
    COP [9A] ( #$0018, &code_004C6E, &code_004C75, &code_004C6E )
}

code_004C6E {
    COP [80] ( #1B )
    COP [82]
    BRA loc_004C57
}

code_004C75 {
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @code_004CAA, #$0008, #$0008, #$0200 )
    COP [80] ( #00 )
    COP [82]
    BRA code_004C6E

  loc_004C8C:
    LDA $0000, X
    CMP #$00F0
    BEQ loc_004CA0
    CMP #$01E0
    BEQ loc_004CA0
    COP [80] ( #1B )
    COP [82]
    BRA loc_004C8C

  loc_004CA0:
    COP [80] ( #04 )
    COP [82]
    COP [87]
    BRL loc_004C20
}

code_004CAA {
    COP [80] ( #18 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRK #$65
    COP [B0] ( @code_004CCF, #$0200 )
    COP [80] ( #19 )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [86]
    RTL 
}

code_004CCF {
    COP [81] ( #17, #02 )
    COP [83]
    COP [B0] ( @code_004CDF, #$0200 )
    COP [86]
    RTL 
}

code_004CDF {
    COP [80] ( #16 )
    COP [82]
    COP [9B] ( #$0000, &code_004CEE, &code_004CF6, &code_004CF6 )
}

code_004CEE {
    LDA $0016, X
    BIT #$8000
    BNE loc_004D06
}

code_004CF6 {
    COP [B2] ( @code_004CDF, #$0000, #$0010, #$0200 )
    COP [80] ( #1C )
    COP [82]

  loc_004D06:
    COP [86]
    RTL 
}

code_004D09 {
    LDY $boss_actor
    LDA $0025, Y
    AND #$00FF
    STA $0030, X
    COP [91]
    LDY $boss_actor
    LDA $0016, Y
    BIT #$0400
    BNE loc_004D5C
    LDA $0025, Y
    AND #$00FF
    CMP $0030, X
    BNE loc_004D2E
    RTL 

  loc_004D2E:
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    SEC 
    SBC #$0008
    STA $0002, X
    COP [B0] ( @code_004D5F, #$0300 )
    COP [B0] ( @code_004D5F, #$0300 )
    COP [B0] ( @code_004D6B, #$0300 )
    COP [B0] ( @code_004D6B, #$0300 )
    BRA code_004D09

  loc_004D5C:
    COP [86]
    RTL 
}

code_004D5F {
    JSR $&code_004D77
    COP [81] ( #14, #04 )
    COP [83]
    COP [86]
    RTL 
}

code_004D6B {
    JSR $&code_004D77
    COP [81] ( #15, #04 )
    COP [83]
    COP [86]
    RTL 
}

code_004D77 {
    COP [1F]
    COP [35] ( #30 )
    LDA $random_mod_result
    SEC 
    SBC #$0010
    CLC 
    ADC $0000
    STA $0000, X
    RTS 
}