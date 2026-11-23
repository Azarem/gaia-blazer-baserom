?BANK 1F

?INCLUDE 'lib_map_index_helpers'

!rng_state                      0301
!player_x                       0374
!player_y                       0376
!tile_type_map                  7F8000

---------------------------------------------

code_0FBF25 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBF33

  code_0FBF2D:
    COP [1B] ( &code_0FBF25, #$0020 )

  loc_0FBF33:
    COP [19] ( #24, &code_0FBF2D )
    COP [0C] ( #00, #02, &code_0FBF40 )
    BRA code_0FBF2D
}

code_0FBF40 {
    COP [85] ( @code_0FBF4B )
    COP [1B] ( &code_0FBF25, #$00B4 )
}

code_0FBF4B {
    LDA #$02A0
    STA $0016, X
    LDA #$00FF
    STA $0030, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$90
    COP [A0] ( #$FF50 )
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @code_0FBF88 )
    COP [A0] ( #$0080 )
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @code_0FBF88 )
    COP [A1] ( #$FFE8, #$0048 )
    COP [80] ( #02 )
    COP [82]
    COP [86]
    RTL 
}

code_0FBF88 {
    LDA #$00FF
    STA $0030, X
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #01 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FBFA1 {
    LDA #$&code_0FBFB7
    STA $0018, X

  loc_0FBFA7:
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    CLC 
    ADC #$007F
    STA $0014, X
    RTL 
}
---------------------------------------------

code_0FBFB7 {
    COP [07] ( #$8503, &code_0FBFC4 )
    COP [85] ( @code_0FBFC7 )
    BRA loc_0FBFA7
}

code_0FBFC4 {
    COP [86]
    RTL 
}

code_0FBFC7 {
    LDA #$0301
    STA $0016, X
    COP [A3]
    BRK #$50

  loc_0FBFD1:
    COP [80] ( #03 )
    COP [82]
    COP [1C] ( #$8000, &code_0FBFDE )
    BRA loc_0FBFD1
}

code_0FBFDE {
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
    SBC #$00E0
    STA $0002, X
    COP [81] ( #04, #07 )
    COP [83]
    LDA #$0200
    STA $0016, X
    COP [A6]
    COP [80] ( #05 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FC01E {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC02C
    COP [1B] ( &code_0FC01E, #$0010 )

  loc_0FC02C:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FC03F
    DEC 
    BEQ loc_0FC05C
    DEC 
    BEQ loc_0FC079
    DEC 
    BEQ loc_0FC096

  loc_0FC03F:
    COP [97]
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0B4 )
    COP [80] ( #06 )
    COP [82]
    BRA code_0FC01E

  loc_0FC05C:
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0B9 )
    COP [80] ( #06 )
    COP [82]
    BRA code_0FC01E

  loc_0FC079:
    COP [96]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0BE )
    COP [80] ( #06 )
    COP [82]
    BRA code_0FC01E

  loc_0FC096:
    COP [97]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @code_0FC0BE )
    COP [80] ( #06 )
    COP [82]
    BRL code_0FC01E
}

code_0FC0B4 {
    LDA #$000C
    BRA loc_0FC0C1
}

code_0FC0B9 {
    LDA #$000B
    BRA loc_0FC0C1
}

code_0FC0BE {
    LDA #$000D

  loc_0FC0C1:
    STA $001E, X
    STZ $0020, X
    LDA #$0006
    STA $002A, X
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$FFF8 )
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FC0E5 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC0F3
    COP [1B] ( &code_0FC0E5, #$0010 )

  loc_0FC0F3:
    COP [0C] ( #00, #04, &code_0FC100 )

  code_0FC0F9:
    COP [80] ( #1D )
    COP [82]
    BRA code_0FC0E5
}

code_0FC100 {
    COP [9C] ( &code_0FC106, &code_0FC12A )
}

code_0FC106 {
    COP [9A] ( #$0010, &code_0FC110, &code_0FC11D, &code_0FC11D )
}

code_0FC110 {
    COP [23] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #20 )
    COP [82]
    BRA code_0FC0F9
}

code_0FC11D {
    COP [24] ( &code_0FC0F9 )
    COP [96]
    COP [80] ( #20 )
    COP [82]
    BRA code_0FC0F9
}

code_0FC12A {
    COP [9B] ( #$0010, &code_0FC134, &code_0FC141, &code_0FC141 )
}

code_0FC134 {
    COP [21] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #1F )
    COP [82]
    BRA code_0FC0F9
}

code_0FC141 {
    COP [22] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #1E )
    COP [82]
    BRA code_0FC0F9
}
---------------------------------------------

code_0FC14E {
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    TXA 
    PLX 
    STA $0030, X

  code_0FC166:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC174

  code_0FC16E:
    COP [1B] ( &code_0FC166, #$0008 )

  loc_0FC174:
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BNE loc_0FC186
    BRL loc_0FC26E

  loc_0FC186:
    COP [9B] ( #$0060, &code_0FC16E, &code_0FC190, &code_0FC16E )
}

code_0FC190 {
    COP [9A] ( #$0000, &code_0FC19A, &code_0FC1C7, &code_0FC1C7 )
}

code_0FC19A {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @code_0FC20D )
    COP [80] ( #2C )
    COP [82]
    COP [85] ( @code_0FC223 )
    COP [80] ( #2D )
    COP [82]
    COP [85] ( @code_0FC20D )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA loc_0FC1F6
}

code_0FC1C7 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @code_0FC20D )
    COP [80] ( #2C )
    COP [82]
    COP [85] ( @code_0FC229 )
    COP [80] ( #2D )
    COP [82]
    COP [85] ( @code_0FC20D )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [97]

  loc_0FC1F6:
    COP [03] ( #78 )
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BEQ loc_0FC26E
    COP [04]
    BRL code_0FC166
}

code_0FC20D {
    COP [28] ( &code_0FC213 )
    BRA loc_0FC220
}

code_0FC213 {
    LDA #$0300
    STA $0016, X
    COP [A4]
    COP [80] ( #2E )
    COP [82]

  loc_0FC220:
    COP [86]
    RTL 
}

code_0FC223 {
    COP [9F] ( #$FFF8 )
    BRA loc_0FC22D
}

code_0FC229 {
    COP [9F] ( #$0008 )

  loc_0FC22D:
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [9B] ( #$0020, &code_0FC244, &code_0FC252, &code_0FC260 )
}

code_0FC244 {
    COP [81] ( #33, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC252 {
    COP [81] ( #32, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC260 {
    COP [81] ( #34, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 

  loc_0FC26E:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    LDA $001C, X
    ASL 
    BMI loc_0FC283
    COP [23] ( &code_0FC289 )
    BRA loc_0FC28E

  loc_0FC283:
    COP [24] ( &code_0FC289 )
    BRA loc_0FC28E
}

code_0FC289 {
    COP [87]
    BRL code_0FC166

  loc_0FC28E:
    COP [80] ( #31 )
    COP [82]
    BRL code_0FC166
}
---------------------------------------------

code_0FC296 {
    COP [AA] ( #02 )

  code_0FC299:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC2A7

  code_0FC2A1:
    COP [1B] ( &code_0FC299, #$0008 )

  loc_0FC2A7:
    COP [9A] ( #$0010, &code_0FC2B1, &code_0FC2C3, &code_0FC2BA )
}

code_0FC2B1 {
    COP [97]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC303
}

code_0FC2BA {
    COP [96]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC303
}

code_0FC2C3 {
    COP [9B] ( #$0010, &code_0FC2CD, &code_0FC303, &code_0FC2E8 )
}

code_0FC2CD {
    COP [97]
    COP [81] ( #0F, #02 )
    COP [83]
    COP [81] ( #15, #02 )
    COP [83]
    COP [85] ( @code_0FC39C )
    COP [81] ( #0F, #02 )
    COP [83]
    BRA code_0FC303
}

code_0FC2E8 {
    COP [97]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [81] ( #14, #02 )
    COP [83]
    COP [85] ( @code_0FC3B9 )
    COP [81] ( #0E, #02 )
    COP [83]
    BRA code_0FC303
}

code_0FC303 {
    COP [9B] ( #$0010, &code_0FC30D, &code_0FC320, &code_0FC316 )
}

code_0FC30D {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0FC299
}

code_0FC316 {
    COP [97]
    COP [80] ( #11 )
    COP [82]
    BRL code_0FC299
}

code_0FC320 {
    COP [9A] ( #$0010, &code_0FC32A, &code_0FC2A1, &code_0FC346 )
}

code_0FC32A {
    COP [97]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #16, #02 )
    COP [83]
    COP [85] ( @code_0FC362 )
    COP [81] ( #10, #02 )
    COP [83]
    BRL code_0FC2A1
}

code_0FC346 {
    COP [96]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #16, #02 )
    COP [83]
    COP [85] ( @code_0FC37F )
    COP [81] ( #10, #02 )
    COP [83]
    BRL code_0FC2A1
}

code_0FC362 {
    JSR $&code_0FC3D6
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC36C:
    COP [23] ( &code_0FC377 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC36C
}

code_0FC377 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC37F {
    JSR $&code_0FC3D6
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC389:
    COP [24] ( &code_0FC394 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC389
}

code_0FC394 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC39C {
    JSR $&code_0FC3D6
    COP [80] ( #19 )
    COP [82]
    COP [A6]

  loc_0FC3A6:
    COP [21] ( &code_0FC3B1 )
    COP [80] ( #36 )
    COP [82]
    BRA loc_0FC3A6
}

code_0FC3B1 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC3B9 {
    JSR $&code_0FC3D6
    COP [80] ( #17 )
    COP [82]
    COP [A6]

  loc_0FC3C3:
    COP [22] ( &code_0FC3CE )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FC3C3
}

code_0FC3CE {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC3D6 {
    LDA #$0202
    STA $0016, X
    COP [AA] ( #02 )
    COP [A3]
    COP [A0] ( #$FFEE )
    BRK #$61
    RTS 
}
---------------------------------------------

code_0FC3E8 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [AA] ( #04 )

  code_0FC3F4:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC402

  code_0FC3FC:
    COP [1B] ( &code_0FC3F4, #$0008 )

  loc_0FC402:
    COP [9A] ( #$0010, &code_0FC40C, &code_0FC41E, &code_0FC415 )
}

code_0FC40C {
    COP [97]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC458
}

code_0FC415 {
    COP [96]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC458
}

code_0FC41E {
    COP [9B] ( #$0010, &code_0FC428, &code_0FC458, &code_0FC440 )
}

code_0FC428 {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [85] ( @code_0FC4EA )
    COP [80] ( #0F )
    COP [82]
    BRA code_0FC458
}

code_0FC440 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    COP [85] ( @code_0FC507 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FC458
}

code_0FC458 {
    COP [9B] ( #$0010, &code_0FC462, &code_0FC474, &code_0FC46B )
}

code_0FC462 {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0FC3F4
}

code_0FC46B {
    COP [97]
    COP [80] ( #11 )
    COP [82]
    BRA code_0FC3F4
}

code_0FC474 {
    COP [9A] ( #$0010, &code_0FC47E, &code_0FC3FC, &code_0FC497 )
}

code_0FC47E {
    COP [97]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @code_0FC4B0 )
    COP [80] ( #10 )
    COP [82]
    BRL code_0FC3FC
}

code_0FC497 {
    COP [96]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @code_0FC4CD )
    COP [80] ( #10 )
    COP [82]
    BRL code_0FC3FC
}

code_0FC4B0 {
    JSR $&code_0FC524
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC4BA:
    COP [23] ( &code_0FC4C5 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC4BA
}

code_0FC4C5 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC4CD {
    JSR $&code_0FC524
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC4D7:
    COP [24] ( &code_0FC4E2 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC4D7
}

code_0FC4E2 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC4EA {
    JSR $&code_0FC524
    COP [80] ( #19 )
    COP [82]
    COP [A6]

  loc_0FC4F4:
    COP [21] ( &code_0FC4FF )
    COP [80] ( #36 )
    COP [82]
    BRA loc_0FC4F4
}

code_0FC4FF {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC507 {
    JSR $&code_0FC524
    COP [80] ( #17 )
    COP [82]
    COP [A6]

  loc_0FC511:
    COP [22] ( &code_0FC51C )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FC511
}

code_0FC51C {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC524 {
    LDA #$0202
    STA $0016, X
    COP [AA] ( #04 )
    COP [A3]
    COP [A0] ( #$FFEE )
    BRK #$61
    RTS 
}
---------------------------------------------

code_0FC536 {
    COP [A3]
    COP [A2] ( #30 )

  code_0FC53B:
    COP [0C] ( #00, #10, &code_0FC547 )
    COP [1B] ( &code_0FC53B, #$0010 )
}

code_0FC547 {
    COP [9A] ( #$0018, &code_0FC551, &code_0FC619, &code_0FC55B )
}

code_0FC551 {
    COP [9B] ( #$0018, &code_0FC5BF, &code_0FC6AA, &code_0FC5EC )
}

code_0FC55B {
    COP [9B] ( #$0018, &code_0FC565, &code_0FC67D, &code_0FC592 )
}

code_0FC565 {
    COP [96]
    COP [81] ( #25, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC575 )
    BRA loc_0FC589
}

code_0FC575 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC589:
    COP [81] ( #25, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC592 {
    COP [96]
    COP [81] ( #24, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5A2 )
    BRA loc_0FC5B6
}

code_0FC5A2 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC5B6:
    COP [81] ( #24, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC5BF {
    COP [97]
    COP [81] ( #25, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5CF )
    BRA loc_0FC5E3
}

code_0FC5CF {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC5E3:
    COP [81] ( #25, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC5EC {
    COP [97]
    COP [81] ( #24, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5FC )
    BRA loc_0FC610
}

code_0FC5FC {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC610:
    COP [81] ( #24, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC619 {
    COP [9B] ( #$0000, &code_0FC650, &code_0FC650, &code_0FC623 )
}

code_0FC623 {
    COP [97]
    COP [81] ( #21, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC633 )
    BRA loc_0FC647
}

code_0FC633 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC647:
    COP [81] ( #21, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC650 {
    COP [97]
    COP [81] ( #22, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC660 )
    BRA loc_0FC674
}

code_0FC660 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC674:
    COP [81] ( #22, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC67D {
    COP [96]
    COP [81] ( #23, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC68D )
    BRA loc_0FC6A1
}

code_0FC68D {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC6A1:
    COP [81] ( #23, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC6AA {
    COP [97]
    COP [81] ( #23, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC6BA )
    BRA loc_0FC6CE
}

code_0FC6BA {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC6CE:
    COP [81] ( #23, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC6D7 {
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$001C )
    BRK #$56
    COP [80] ( #29 )
    COP [82]
    COP [9A] ( #$0000, &code_0FC6F2, &code_0FC6FC, &code_0FC6FC )
}

code_0FC6F2 {
    COP [9B] ( #$0000, &code_0FC706, &code_0FC710, &code_0FC710 )
}

code_0FC6FC {
    COP [9B] ( #$0000, &code_0FC71A, &code_0FC724, &code_0FC724 )
}

code_0FC706 {
    COP [97]
    COP [81] ( #2B, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC710 {
    COP [97]
    COP [81] ( #2A, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC71A {
    COP [96]
    COP [81] ( #2B, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC724 {
    COP [96]
    COP [81] ( #2A, #08 )
    COP [83]

  loc_0FC72C:
    COP [86]
    RTL 
}