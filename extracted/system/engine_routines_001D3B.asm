?BANK 00

?INCLUDE 'common_actor_001A28_part1'
?INCLUDE 'engine_routines_002678'

!scene_next                     0318
!joy_release_latch              032A

---------------------------------------------

code_001D3B {
    BCS loc_001D4B
    LDA #$0001
    JSR $&code_001F9D
    COP [80] ( #01 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001D4B:
    LDA #$002B
    JSR $&code_001F9D
    COP [80] ( #2B )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001D59 {
    BCS loc_001D69
    LDA #$0000
    JSR $&code_001F9D
    COP [80] ( #00 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001D69:
    LDA #$0029
    JSR $&code_001F9D
    COP [80] ( #29 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001D77 {
    BCS loc_001D87
    LDA #$0002
    JSR $&code_001F9D
    COP [80] ( #02 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001D87:
    LDA #$0027
    JSR $&code_001F9D
    COP [80] ( #27 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001D95 {
    BCS loc_001DA5
    LDA #$0003
    JSR $&code_001F9D
    COP [80] ( #03 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001DA5:
    LDA #$0024
    JSR $&code_001F9D
    COP [80] ( #24 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001DB3 {
    BCS loc_001DC3
    LDA #$0006
    JSR $&code_001F9D
    COP [80] ( #06 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001DC3:
    LDA #$002A
    JSR $&code_001F9D
    COP [80] ( #2A )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001DD1 {
    BCS loc_001DE1
    LDA #$0004
    JSR $&code_001F9D
    COP [80] ( #04 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001DE1:
    LDA #$0028
    JSR $&code_001F9D
    COP [80] ( #28 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001DEF {
    BCS loc_001DFF
    LDA #$0008
    JSR $&code_001F9D
    COP [80] ( #08 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001DFF:
    LDA #$0026
    JSR $&code_001F9D
    COP [80] ( #26 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E0D {
    BCS loc_001E1D
    LDA #$000A
    JSR $&code_001F9D
    COP [80] ( #0A )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001E1D:
    LDA #$0025
    JSR $&code_001F9D
    COP [80] ( #25 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E2B {
    LDA #$0005
    JSR $&code_001F9D
    COP [80] ( #05 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E39 {
    LDA #$0011
    JSR $&code_001F9D
    COP [80] ( #11 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E47 {
    LDA #$0012
    JSR $&code_001F9D
    COP [80] ( #12 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E55 {
    LDA #$0007
    JSR $&code_001F9D
    COP [80] ( #07 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E63 {
    LDA #$0010
    JSR $&code_001F9D
    COP [80] ( #10 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E71 {
    LDA #$0013
    JSR $&code_001F9D
    COP [80] ( #13 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E7F {
    LDA #$000E
    JSR $&code_001F9D
    COP [80] ( #0E )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E8D {
    LDA #$000D
    JSR $&code_001F9D
    COP [80] ( #0D )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001E9B {
    LDA #$000B
    JSR $&code_001F9D
    COP [80] ( #0B )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001EA9 {
    LDA #$000F
    JSR $&code_001F9D
    COP [80] ( #0F )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001EB7 {
    LDA #$000C
    JSR $&code_001F9D
    COP [80] ( #0C )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001EC5 {
    LDA #$0009
    JSR $&code_001F9D
    COP [80] ( #09 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65

  loc_001ED3:
    SEP #$20
    LDA #$0B
    STA $0024, X
    LDY $039E
    LDA #$0C
    STA $0024, Y
    REP #$20
    BRK #$84
    LDA #$001C
    JSR $&code_001F9D
    COP [80] ( #1C )
    COP [82]
    LDA $03BA
    INC 
    STA $scene_next
    COP [91]
    RTL 
}

code_001EFB {
    BRK #$01
    JSR $&code_001F7B
    BCS loc_001F07
    COP [84] ( @engine_routines_002678.code_002678 )

  loc_001F07:
    LDA #$8000
    TRB $joy_release_latch
    LDA #$0021
    JSR $&code_001F9D
    COP [80] ( #21 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001F1B {
    BRK #$01
    JSR $&code_001F7B
    BCS loc_001F27
    COP [84] ( @engine_routines_002678.code_00268D )

  loc_001F27:
    LDA #$8000
    TRB $joy_release_latch
    LDA #$0020
    JSR $&code_001F9D
    COP [80] ( #20 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001F3B {
    BRK #$01
    JSR $&code_001F7B
    BCS loc_001F47
    COP [84] ( @engine_routines_002678.code_0026A4 )

  loc_001F47:
    LDA #$8000
    TRB $joy_release_latch
    LDA #$0022
    JSR $&code_001F9D
    COP [80] ( #22 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001F5B {
    BRK #$01
    JSR $&code_001F7B
    BCS loc_001F67
    COP [84] ( @engine_routines_002678.code_0026B9 )

  loc_001F67:
    LDA #$8000
    TRB $joy_release_latch
    LDA #$0023
    JSR $&code_001F9D
    COP [80] ( #23 )
    COP [82]
    BRL common_actor_001A28_part1.loc_001A65
}

code_001F7B {
    LDA $1B5E
    CMP #$0008
    BNE code_001F9B
    LDA $1B60
    CMP #$0010
    BNE code_001F9B
    LDA $1B62
    CMP #$0018
    BNE code_001F9B
    COP [26] ( #$0002, &code_001F9B )
    CLC 
    RTS 
}

code_001F9B {
    SEC 
    RTS 
}

code_001F9D {
    LDY $003E, X
    STA $001E, Y
    SEC 
    SBC #$0020
    CMP #$0004
    BCS loc_001FB5
    LDA $1B70
    CLC 
    ADC $1B72
    BRA loc_001FB8

  loc_001FB5:
    LDA $1B70

  loc_001FB8:
    STA $1B8C
    LDA $1B74
    CLC 
    ADC $1B76
    STA $1B8E
    LDA #$0000
    STA $0020, Y
    STA $0014, Y
    RTS 
}