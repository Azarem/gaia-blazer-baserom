?BANK 1F

?INCLUDE 'engine_000000'

!frame_counter                  0312
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FA64B {
    COP [91]
    COP [07] ( #$8903, &code_0FA6A6 )
    COP [19] ( #0B, &code_0FA697 )
    COP [B0] ( @code_0FA6A9, #$0310 )
    COP [91]
    COP [19] ( #0B, &code_0FA68A )
    LDY $003E, X
    LDA $player_x
    STA $0000, Y
    LDA $player_y
    SEC 
    SBC #$0004
    STA $0002, Y
    LDA $frame_counter
    AND #$00FF
    BEQ loc_0FA682
    RTL 

  loc_0FA682:
    COP [AF] ( @code_0FA6CB, #$2040 )
    RTL 
}

code_0FA68A {
    LDY $003E, X
    LDA #$0000
    STA $0014, Y
    COP [27] ( &code_0FA64B )
}

code_0FA697 {
    LDA $frame_counter
    AND #$003F
    BNE loc_0FA6A2
    COP [39] ( #01 )

  loc_0FA6A2:
    COP [27] ( &code_0FA64B )
}

code_0FA6A6 {
    COP [91]
    RTL 
}

code_0FA6A9 {
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0024
    STA $001E, X
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    COP [A3]
    COP [91]

  loc_0FA6BF:
    COP [19] ( #0B, &code_0FA6C8 )
    COP [82]
    BRA loc_0FA6BF
}

code_0FA6C8 {
    COP [86]
    RTL 
}

code_0FA6CB {
    COP [A3]
    COP [A2] ( #30 )
    LDA $player_x
    CLC 
    ADC #$0004
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0010
    STA $0002, X
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #22 )
    COP [82]
    COP [86]
    RTL 
}