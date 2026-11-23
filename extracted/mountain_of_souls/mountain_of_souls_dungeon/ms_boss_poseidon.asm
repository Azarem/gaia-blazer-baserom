?BANK 00

?INCLUDE 'engine_003005'

!rng_state                      0301
!boss_actor                     039A
!exit_list_ofs                  03B2
!random_mod_result              0437
!boss_fight_active              0458

---------------------------------------------

code_004299 {
    STZ $exit_list_ofs
    INC $boss_fight_active
    STX $boss_actor
    COP [9F] ( #$0008 )
    COP [85] ( @engine_003005.RunBossMapPatch )
    LDA #$0002
    STA $0030, Y

  loc_0042B1:
    LDA #$0002
    STA $0030, X

  loc_0042B7:
    COP [97]
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [B2] ( @code_004528, #$0010, #$FFF0, #$0300 )
    COP [03] ( #15 )
    COP [04]
    COP [B2] ( @code_004528, #$0008, #$FFFA, #$0300 )
    COP [03] ( #15 )
    COP [04]
    COP [B2] ( @code_004528, #$0014, #$FFF6, #$0300 )
    COP [03] ( #15 )
    COP [04]
    COP [85] ( @code_0045F5 )
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    COP [1F]
    LDA $rng_state+1
    BMI loc_00433D
    COP [80] ( #01 )
    COP [82]
    COP [B2] ( @code_004497, #$FFEA, #$000D, #$0200 )
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #0D )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    COP [B2] ( @code_004487, #$FFED, #$0010, #$0200 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_00436C

  loc_00433D:
    COP [80] ( #00 )
    COP [82]
    COP [B2] ( @code_004497, #$0015, #$000F, #$0300 )
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_00448F, #$0012, #$0010, #$0200 )
    COP [80] ( #03 )
    COP [82]

  loc_00436C:
    COP [1F]
    LDA $rng_state+1
    BMI loc_0043C6
    COP [80] ( #05 )
    COP [82]
    COP [B2] ( @code_004487, #$FFED, #$0010, #$0200 )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #0E )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_004532, #$FFE4, #$FFCD, #$0200 )
    COP [B2] ( @code_004546, #$FFE4, #$FFCD, #$0200 )
    COP [03] ( #29 )
    COP [04]
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [85] ( @code_0045F5 )
    COP [80] ( #08 )
    COP [82]
    BRA loc_004417

  loc_0043C6:
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_00448F, #$0012, #$0010, #$0200 )
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #0C )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_004532, #$001B, #$FFCD, #$0200 )
    COP [B2] ( @code_004546, #$001B, #$FFCD, #$0200 )
    COP [03] ( #29 )
    COP [04]
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [85] ( @code_0045F5 )
    COP [80] ( #09 )
    COP [82]

  loc_004417:
    LDA $0030, X
    CMP #$0001
    BEQ loc_004455
    COP [1F]
    LDA $rng_state+1
    BMI loc_00442A
    COP [97]
    BRA loc_00442C

  loc_00442A:
    COP [96]

  loc_00442C:
    COP [AF] ( @code_0044D3, #$0300 )
    COP [AF] ( @code_0044D3, #$0300 )
    COP [AF] ( @code_0044D3, #$0300 )
    COP [AF] ( @code_0044FF, #$0300 )
    COP [80] ( #14 )
    COP [82]
    DEC $0030, X
    BEQ loc_004455
    BRL loc_0042B7

  loc_004455:
    LDA $0000, X
    CMP #$00F0
    BCS loc_004461
    COP [97]
    BRA loc_004463

  loc_004461:
    COP [96]

  loc_004463:
    COP [AF] ( @code_0044D3, #$0300 )
    COP [AF] ( @code_0044D3, #$0300 )
    COP [AF] ( @code_0044D3, #$0300 )
    COP [AF] ( @code_0044FF, #$0300 )
    COP [80] ( #15 )
    COP [82]
    BRL loc_0042B1
}

code_004487 {
    COP [80] ( #07 )
    COP [82]
    COP [86]
    RTL 
}

code_00448F {
    COP [80] ( #04 )
    COP [82]
    COP [86]
    RTL 
}

code_004497 {
    COP [A3]
    COP [81] ( #16, #06 )
    COP [83]
    BRK #$4B
    COP [B0] ( @code_0044BF, #$0200 )
    COP [B0] ( @code_0044C1, #$0200 )

  loc_0044AF:
    COP [80] ( #12 )
    COP [82]
    LDA $0016, X
    BIT #$8000
    BEQ loc_0044AF
    COP [86]
    RTL 
}

code_0044BF {
    COP [96]
}

code_0044C1 {
    COP [A3]

  loc_0044C3:
    COP [80] ( #13 )
    COP [82]
    LDA $0016, X
    BIT #$8000
    BEQ loc_0044C3
    COP [86]
    RTL 
}

code_0044D3 {
    COP [A4]
    COP [80] ( #1D )
    COP [82]
    COP [91]
    LDY $boss_actor
    LDA $001E, Y
    CMP #$0014
    BEQ loc_0044EC
    CMP #$0015
    BNE loc_0044FC

  loc_0044EC:
    LDY $003E, X
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    RTL 

  loc_0044FC:
    COP [86]
    RTL 
}

code_0044FF {
    COP [A4]
    COP [80] ( #1D )
    COP [82]
    COP [91]
    LDY $boss_actor
    LDA $001E, Y
    CMP #$0014
    BEQ loc_004518
    CMP #$0015
    BNE loc_004525

  loc_004518:
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    RTL 

  loc_004525:
    COP [86]
    RTL 
}

code_004528 {
    COP [A3]
    COP [80] ( #0F )
    COP [82]
    COP [86]
    RTL 
}

code_004532 {
    COP [A3]
    COP [81] ( #16, #06 )
    COP [83]
    BRK #$4B
    COP [97]
    COP [81] ( #19, #02 )
    COP [83]
    BRA loc_00455B
}

code_004546 {
    COP [A3]
    COP [81] ( #16, #06 )
    COP [83]
    BRK #$4B
    COP [96]
    COP [81] ( #19, #02 )
    COP [83]
    BRL loc_0045A8

  loc_00455B:
    COP [97]

  loc_00455D:
    COP [9B] ( #$0020, &code_004588, &code_004567, &code_004588 )
}

code_004567 {
    COP [9A] ( #$0000, &code_004571, &code_004578, &code_004578 )
}

code_004571 {
    COP [80] ( #1B )
    COP [82]
    BRA loc_00457F
}

code_004578 {
    COP [80] ( #1C )
    COP [82]
    COP [96]

  loc_00457F:
    COP [81] ( #17, #2A )
    COP [83]
    COP [86]
    RTL 
}

code_004588 {
    COP [9A] ( #$0018, &code_0045A0, &code_004592, &code_0045A0 )
}

code_004592 {
    COP [80] ( #1A )
    COP [82]
    COP [81] ( #18, #0A )
    COP [83]
    COP [86]
    RTL 
}

code_0045A0 {
    COP [80] ( #19 )
    COP [82]
    BRL loc_00455D

  loc_0045A8:
    COP [96]

  loc_0045AA:
    COP [9B] ( #$0020, &code_0045D5, &code_0045B4, &code_0045D5 )
}

code_0045B4 {
    COP [9A] ( #$0000, &code_0045BE, &code_0045C7, &code_0045C7 )
}

code_0045BE {
    COP [80] ( #1C )
    COP [82]
    COP [97]
    BRA loc_0045CC
}

code_0045C7 {
    COP [80] ( #1B )
    COP [82]

  loc_0045CC:
    COP [81] ( #17, #2A )
    COP [83]
    COP [86]
    RTL 
}

code_0045D5 {
    COP [9A] ( #$0018, &code_0045ED, &code_0045DF, &code_0045ED )
}

code_0045DF {
    COP [80] ( #1A )
    COP [82]
    COP [81] ( #18, #0A )
    COP [83]
    COP [86]
    RTL 
}

code_0045ED {
    COP [80] ( #19 )
    COP [82]
    BRL loc_0045AA
}

code_0045F5 {
    COP [03] ( #10 )
    COP [B0] ( @code_004617, #$0300 )
    COP [1B] ( &code_004605, #$0002 )
}

code_004605 {
    COP [B0] ( @code_004622, #$0300 )
    COP [1B] ( &code_004612, #$0002 )
}

code_004612 {
    COP [04]
    COP [86]
    RTL 
}

code_004617 {
    JSR $&code_00462D
    COP [80] ( #10 )
    COP [82]
    COP [86]
    RTL 
}

code_004622 {
    JSR $&code_00462D
    COP [80] ( #11 )
    COP [82]
    COP [86]
    RTL 
}

code_00462D {
    LDY $boss_actor
    COP [1F]
    COP [35] ( #20 )
    LDA $random_mod_result
    SEC 
    SBC #$0008
    CLC 
    ADC $0000, Y
    STA $0000, X
    COP [1F]
    COP [35] ( #10 )
    LDA $random_mod_result
    SEC 
    SBC #$000C
    CLC 
    ADC $0002, Y
    STA $0002, X
    COP [A3]
    RTS 
}