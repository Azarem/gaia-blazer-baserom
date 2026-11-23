?BANK 00

?INCLUDE 'engine_003005'
?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301
!player_x                       0374
!player_y                       0376
!boss_actor                     039A
!exit_list_ofs                  03B2
!boss_fight_active              0458

---------------------------------------------

code_004659 {
    STZ $exit_list_ofs
    INC $boss_fight_active
    STX $boss_actor
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [85] ( @engine_003005.RunBossMapPatch )
    LDA #$0003
    STA $0030, Y
    BRL code_00477D

  loc_004679:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_004688
    COP [09] ( #$8000 )

  loc_004688:
    COP [0C] ( #00, #02, &code_0046A8 )
    COP [9A] ( #$0028, &code_004698, &code_00477D, &code_0046A0 )
}

code_004698 {
    COP [80] ( #10 )
    COP [82]
    BRL code_00480B
}

code_0046A0 {
    COP [80] ( #0D )
    COP [82]
    BRL code_004842
}

code_0046A8 {
    COP [07] ( #$8001, &code_004879 )
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8001 )
    BRL loc_004A01

  loc_0046BF:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_0046CE
    COP [09] ( #$8000 )

  loc_0046CE:
    COP [0C] ( #00, #02, &code_0046EE )
    COP [9B] ( #$0028, &code_0046DE, &code_00480B, &code_0046E6 )
}

code_0046DE {
    COP [80] ( #0C )
    COP [82]
    BRL code_00477D
}

code_0046E6 {
    COP [80] ( #11 )
    COP [82]
    BRL code_0047C4
}

code_0046EE {
    COP [07] ( #$8001, &code_0048DB )
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8001 )
    BRL loc_004A01

  loc_004700:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_00470F
    COP [09] ( #$8000 )

  loc_00470F:
    COP [0C] ( #00, #02, &code_00472F )
    COP [9B] ( #$0028, &code_00471F, &code_004842, &code_004727 )
}

code_00471F {
    COP [80] ( #0F )
    COP [82]
    BRL code_00477D
}

code_004727 {
    COP [80] ( #12 )
    COP [82]
    BRL code_0047C4
}

code_00472F {
    COP [07] ( #$8001, &code_00493D )
    COP [80] ( #12 )
    COP [82]
    COP [09] ( #$8001 )
    BRL loc_004A01

  loc_004741:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_004750
    COP [09] ( #$8000 )

  loc_004750:
    COP [0C] ( #00, #02, &code_004770 )
    COP [9A] ( #$0028, &code_004760, &code_0047C4, &code_004768 )
}

code_004760 {
    COP [80] ( #13 )
    COP [82]
    BRL code_00480B
}

code_004768 {
    COP [80] ( #0E )
    COP [82]
    BRL code_004842
}

code_004770 {
    COP [07] ( #$8001, &code_00499F )
    COP [09] ( #$8001 )
    BRL loc_004A01
}

code_00477D {
    LDA $0002, X
    CMP #$00A0
    BEQ loc_00479D
    COP [07] ( #$8000, &code_004794 )
    COP [81] ( #0A, #04 )
    COP [83]
    BRL loc_004679
}

code_004794 {
    COP [81] ( #0B, #04 )
    COP [83]
    BRL loc_004679

  loc_00479D:
    COP [9A] ( #$0020, &code_0047A7, &code_0047AF, &code_0047BC )
}

code_0047A7 {
    COP [80] ( #10 )
    COP [82]
    BRL loc_0046BF
}

code_0047AF {
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    BRL loc_004741
}

code_0047BC {
    COP [80] ( #0D )
    COP [82]
    BRL loc_004700
}

code_0047C4 {
    LDA $0002, X
    CMP #$01A0
    BEQ loc_0047E4
    COP [07] ( #$8000, &code_0047DB )
    COP [81] ( #08, #04 )
    COP [83]
    BRL loc_004741
}

code_0047DB {
    COP [81] ( #09, #04 )
    COP [83]
    BRL loc_004741

  loc_0047E4:
    COP [9A] ( #$0020, &code_0047EE, &code_0047F6, &code_004803 )
}

code_0047EE {
    COP [80] ( #13 )
    COP [82]
    BRL loc_0046BF
}

code_0047F6 {
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #0F )
    COP [82]
    BRL loc_004679
}

code_004803 {
    COP [80] ( #0E )
    COP [82]
    BRL loc_004700
}

code_00480B {
    COP [07] ( #$8000, &code_004821 )
    LDA $0000, X
    CMP #$0070
    BEQ loc_004830
    COP [80] ( #06 )
    COP [82]
    BRL loc_0046BF
}

code_004821 {
    LDA $0000, X
    CMP #$0070
    BEQ loc_004830
    COP [80] ( #07 )
    COP [82]
    BRA code_004821

  loc_004830:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [81] ( #07, #04 )
    COP [83]
    BRL loc_004A31
}

code_004842 {
    COP [07] ( #$8000, &code_004858 )
    LDA $0000, X
    CMP #$0160
    BEQ loc_004867
    COP [80] ( #04 )
    COP [82]
    BRL loc_004700
}

code_004858 {
    LDA $0000, X
    CMP #$0160
    BEQ loc_004867
    COP [80] ( #05 )
    COP [82]
    BRA code_004858

  loc_004867:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [81] ( #05, #04 )
    COP [83]
    BRL loc_004A4C
}

code_004879 {
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @code_004BAB, #$0008, #$FFE0, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9A] ( #$0020, &code_004898, &code_0048B0, &code_0048C3 )
}

code_004898 {
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @code_004BC1, #$FFFE, #$FFE0, #$0200 )
    BRL code_00480B
}

code_0048B0 {
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @code_004BAB, #$0008, #$FFE0, #$0200 )
    BRL code_00477D
}

code_0048C3 {
    COP [80] ( #0D )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @code_004BB6, #$0012, #$FFE0, #$0200 )
    BRL code_004842
}

code_0048DB {
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @code_004BC1, #$FFFE, #$FFE0, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9B] ( #$0020, &code_0048FA, &code_004912, &code_004925 )
}

code_0048FA {
    COP [80] ( #0C )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @code_004BAB, #$0008, #$FFE0, #$0200 )
    BRL code_00477D
}

code_004912 {
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @code_004BC1, #$FFFE, #$FFE0, #$0200 )
    BRL code_00480B
}

code_004925 {
    COP [80] ( #12 )
    COP [82]
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @code_004BCC, #$0008, #$FFE2, #$0200 )
    BRL code_0047C4
}

code_00493D {
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @code_004BB6, #$0012, #$FFE0, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9B] ( #$0020, &code_00495C, &code_004974, &code_004987 )
}

code_00495C {
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @code_004BAB, #$0008, #$FFE0, #$0200 )
    BRL code_00477D
}

code_004974 {
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @code_004BB6, #$0012, #$FFE0, #$0200 )
    BRL code_004842
}

code_004987 {
    COP [80] ( #12 )
    COP [82]
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @code_004BCC, #$0008, #$FFE2, #$0200 )
    BRL code_0047C4
}

code_00499F {
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @code_004BCC, #$0008, #$FFE2, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9A] ( #$0020, &code_0049BE, &code_0049D6, &code_0049E9 )
}

code_0049BE {
    COP [80] ( #13 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @code_004BC1, #$FFFE, #$FFE0, #$0200 )
    BRL code_00480B
}

code_0049D6 {
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @code_004BCC, #$0008, #$FFE2, #$0200 )
    BRL code_0047C4
}

code_0049E9 {
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @code_004BB6, #$0012, #$FFE0, #$0200 )
    BRL code_004842

  loc_004A01:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #16 )
    COP [82]
    COP [B2] ( @code_004B1C, #$0000, #$FFF0, #$0200 )
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #14, #02 )
    COP [83]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL loc_004741

  loc_004A31:
    COP [80] ( #11 )
    COP [82]
    BRK #$5F
    COP [81] ( #22, #10 )
    COP [83]
    COP [81] ( #23, #08 )
    COP [83]
    COP [03] ( #3D )
    COP [04]
    BRL loc_004A67

  loc_004A4C:
    COP [80] ( #12 )
    COP [82]
    BRK #$5F
    COP [81] ( #22, #10 )
    COP [83]
    COP [81] ( #23, #08 )
    COP [83]
    COP [03] ( #3D )
    COP [04]
    BRL loc_004AA9

  loc_004A67:
    JSR $&code_004AEB
    STA $0002, X
    LDA #$0030
    STA $0000, X
    BRK #$5F
    COP [81] ( #23, #08 )
    COP [83]
    COP [81] ( #22, #10 )
    COP [83]
    LDA $0025, X
    AND #$00FF
    STA $0030, X
    COP [09] ( #$0000 )
    COP [09] ( #$0001 )
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    COP [80] ( #0E )
    COP [82]
    COP [81] ( #04, #04 )
    COP [83]
    BRL loc_004700

  loc_004AA9:
    JSR $&code_004AEB
    STA $0002, X
    LDA #$01A0
    STA $0000, X
    BRK #$5F
    COP [81] ( #23, #08 )
    COP [83]
    COP [81] ( #22, #10 )
    COP [83]
    LDA $0025, X
    AND #$00FF
    STA $0030, X
    COP [09] ( #$0000 )
    COP [09] ( #$0001 )
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [81] ( #06, #04 )
    COP [83]
    BRL loc_0046BF
}

code_004AEB {
    COP [1F]
    LDA $rng_state+1
    AND #$00FF
    LDY #$00A0
    SEC 
    SBC #$0033
    BMI loc_004B1A
    LDY #$00E0
    SEC 
    SBC #$0033
    BMI loc_004B1A
    LDY #$0120
    SEC 
    SBC #$0033
    BMI loc_004B1A
    LDY #$0160
    SEC 
    SBC #$0033
    BMI loc_004B1A
    LDY #$01A0

  loc_004B1A:
    TYA 
    RTS 
}

code_004B1C {
    COP [A3]
    COP [80] ( #20 )
    COP [82]
    COP [B2] ( @code_004B36, #$0008, #$FFF8, #$0300 )
    COP [80] ( #21 )
    COP [82]
    COP [86]
    RTL 
}

code_004B36 {
    BRK #$61
    COP [80] ( #1C )
    COP [82]

  loc_004B3D:
    COP [80] ( #1D )
    COP [82]
    LDA $0002, X
    BPL loc_004B3D
    COP [80] ( #1D )
    COP [82]
    COP [03] ( #0C )
    BRK #$52
    COP [B0] ( @code_004B63, #$0300 )
    COP [1B] ( &code_004B5E, #$000C )
}

code_004B5E {
    COP [04]
    COP [86]
    RTL 
}

code_004B63 {
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_x
    STA $0000, X
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_y
    SEC 
    SBC #$00FF
    STA $0002, X
    COP [81] ( #1E, #10 )
    COP [83]
    LDA #$0200
    STA $0016, X
    BRK #$5A
    COP [A4]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [80] ( #1F )
    COP [82]
    COP [86]
    RTL 
}

code_004BAB {
    BRK #$5D
    COP [97]
    COP [80] ( #02 )
    COP [82]
    BRA loc_004BD7
}

code_004BB6 {
    BRK #$5D
    COP [96]
    COP [80] ( #00 )
    COP [82]
    BRA loc_004BD7
}

code_004BC1 {
    BRK #$5D
    COP [97]
    COP [80] ( #00 )
    COP [82]
    BRA loc_004BD7
}

code_004BCC {
    BRK #$5D
    COP [A3]
    COP [97]
    COP [80] ( #01 )
    COP [82]

  loc_004BD7:
    COP [A3]
    COP [81] ( #03, #03 )
    COP [83]
    LDY #$0003
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}