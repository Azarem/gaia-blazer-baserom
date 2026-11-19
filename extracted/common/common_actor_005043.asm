?BANK 00

?INCLUDE 'common_actor_005043_part2'

!random_mod_result              0437
!event_flags                    1A5E

---------------------------------------------

code_005043 {
    STX $039A
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    STZ $0466
    COP [85] ( @common_actor_005043_part2.code_0055C6 )
    COP [AC] ( @code_005344, #$0038, #$0070, #$0200 )
    COP [AC] ( @code_00534C, #$00B8, #$0070, #$0200 )
    COP [AC] ( @code_0051C4, #$0038, #$0040, #$0200 )
    COP [AC] ( @code_0051F2, #$00B8, #$0040, #$0200 )
    COP [03] ( #3D )
    COP [04]
    BRA loc_0050ED

  loc_00508A:
    COP [91]
    LDA $event_flags
    AND #$00FF
    CMP #$0004
    BEQ loc_005098
    RTL 

  loc_005098:
    SEP #$20
    STZ $event_flags
    REP #$20
    COP [80] ( #14 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #12 )
    COP [82]
    COP [B0] ( @code_0051B6, #$0300 )
    COP [80] ( #13 )
    COP [82]
    COP [B2] ( @code_005194, #$0008, #$0010, #$0200 )
    COP [B2] ( @code_0051A4, #$0008, #$0010, #$0200 )
    COP [B2] ( @code_0051B2, #$0008, #$0010, #$0200 )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #15 )
    COP [82]

  loc_0050ED:
    COP [03] ( #04 )
    COP [B0] ( @code_005101, #$0301 )
    COP [1B] ( &code_0050FD, #$0028 )
}

code_0050FD {
    COP [04]
    BRA loc_00508A
}

code_005101 {
    LDA $001A, X
    ORA #$0100
    STA $001A, X
    COP [1F]
    COP [35] ( #A0 )
    LDA $random_mod_result
    CLC 
    ADC #$0020
    STA $0000, X
    COP [1F]
    COP [35] ( #1E )
    LDA $random_mod_result
    CLC 
    ADC #$00B0
    STA $0002, X
    SEP #$20
    LDA #$FF
    STA $0025, X
    REP #$20
    COP [80] ( #16 )
    COP [82]
    LDA $0016, X
    AND #$FCFF
    STA $0016, X

  loc_00513F:
    LDA $0025, X
    AND #$00FF
    CMP #$00FC
    BCC loc_005151
    COP [80] ( #17 )
    COP [82]
    BRA loc_00513F

  loc_005151:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [80] ( #18 )
    COP [82]
    SEP #$20
    INC $event_flags
    REP #$20
    COP [B0] ( @code_005170, #$4000 )
    COP [86]
    RTL 
}

code_005170 {
    COP [A8] ( #$8000, #0E )
    LDA $0005
    STA $001E, X
    STZ $0020, X
    LDA $0372
    STA $001C, X
    COP [A4]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #0A, #04 )
    COP [83]
    COP [86]
    RTL 
}

code_005194 {
    BRK #$51
    COP [80] ( #1A )
    COP [82]
    COP [81] ( #1C, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0051A4 {
    COP [80] ( #1B )
    COP [82]
    COP [81] ( #1C, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0051B2 {
    COP [96]
    BRA code_0051A4
}

code_0051B6 {
    COP [A3]
    COP [A0] ( #$FFFE )
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

code_0051C4 {
    COP [81] ( #0E, #0E )
    COP [83]
    COP [80] ( #0D )
    COP [82]
    BRK #$4B
    COP [B0] ( @code_005220, #$0200 )
    COP [1B] ( &code_0051DE, #$0002 )
}

code_0051DE {
    COP [03] ( #03 )
    COP [B0] ( @code_00526F, #$0200 )
    COP [1B] ( &code_0051EE, #$0003 )
}

code_0051EE {
    COP [04]
    BRA code_0051C4
}

code_0051F2 {
    COP [81] ( #0E, #0E )
    COP [83]
    COP [80] ( #0D )
    COP [82]
    BRK #$4B
    COP [B0] ( @code_0052B2, #$0200 )
    COP [1B] ( &code_00520C, #$0002 )
}

code_00520C {
    COP [03] ( #03 )
    COP [B0] ( @code_005301, #$0200 )
    COP [1B] ( &code_00521C, #$0003 )
}

code_00521C {
    COP [04]
    BRA code_0051F2
}

code_005220 {
    LDA $0016, X
    BIT #$8000
    BNE loc_00526C
    COP [81] ( #0C, #02 )
    COP [83]
    COP [9A] ( #$0000, &code_005238, &code_005252, &code_005252 )
}

code_005238 {
    COP [09] ( #$9906 )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_005220
}

code_005252 {
    COP [09] ( #$1906 )
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_005220

  loc_00526C:
    COP [86]
    RTL 
}

code_00526F {
    LDA $0016, X
    BIT #$8000
    BNE loc_0052AF
    COP [81] ( #0C, #02 )
    COP [83]
    COP [07] ( #$1906, &code_005299 )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_00526F
}

code_005299 {
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_00526F

  loc_0052AF:
    COP [86]
    RTL 
}

code_0052B2 {
    LDA $0016, X
    BIT #$8000
    BNE loc_0052FE
    COP [81] ( #0C, #02 )
    COP [83]
    COP [9A] ( #$0000, &code_0052CA, &code_0052E4, &code_0052E4 )
}

code_0052CA {
    COP [09] ( #$9907 )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_0052B2
}

code_0052E4 {
    COP [09] ( #$1907 )
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_0052B2

  loc_0052FE:
    COP [86]
    RTL 
}

code_005301 {
    LDA $0016, X
    BIT #$8000
    BNE loc_005341
    COP [81] ( #0C, #02 )
    COP [83]
    COP [07] ( #$1907, &code_00532B )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA code_005301
}

code_00532B {
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA code_005301

  loc_005341:
    COP [86]
    RTL 
}

code_005344 {
    COP [80] ( #11 )
    COP [82]
    COP [91]
    RTL 
}

code_00534C {
    COP [80] ( #10 )
    COP [82]
    COP [91]
    RTL 
}