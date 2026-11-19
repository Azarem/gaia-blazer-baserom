?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_0F8F45 {
    COP [14] ( #$00C1, &code_0F8F4C )
    RTL 
}

code_0F8F4C {
    COP [85] ( @engine_0026F3.code_00299D )

  loc_0F8F51:
    COP [17] ( &code_0F9041 )
    COP [15]

  code_0F8F57:
    COP [80] ( #10 )
    COP [82]
    COP [07] ( #$0000, &code_0F8F57 )

  loc_0F8F62:
    COP [0D] ( #00, #03, #31, &code_0F8F71 )
    COP [80] ( #10 )
    COP [82]
    BRL loc_0F8F62
}

code_0F8F71 {
    COP [16]
    COP [17] ( #$0000 )
    COP [85] ( @code_0F8FAB )
    COP [81] ( #0D, #1B )
    COP [83]
    COP [17] ( &code_0F9041 )
    COP [15]

  loc_0F8F88:
    COP [0D] ( #00, #03, #19, &code_0F8F97 )
    COP [80] ( #0F )
    COP [82]
    BRL loc_0F8F88
}

code_0F8F97 {
    COP [16]
    COP [17] ( #$0000 )
    COP [85] ( @code_0F8FF6 )
    COP [81] ( #0C, #1B )
    COP [83]
    BRL loc_0F8F51
}

code_0F8FAB {
    LDA #$2F80
    TSB $joy_block_mask
    LDA #$01B0
    STA $0025, X
    LDY $player_actor
    LDA $0016, Y
    AND #$EFFF
    STA $0016, Y
    COP [91]
    LDY $003C, X
    LDA $0002, Y
    SEC 
    SBC #$0020
    LDY $player_actor
    STA $0002, Y
    LDA #$FFFF
    STA $0006, Y
    DEC $0025, X
    BEQ loc_0F8FE1
    RTL 

  loc_0F8FE1:
    LDY $player_actor
    LDA $0016, Y
    ORA #$1000
    STA $0016, Y
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

code_0F8FF6 {
    LDA #$2F80
    TSB $joy_block_mask
    LDA #$01B0
    STA $0025, X
    LDY $player_actor
    LDA $0016, Y
    AND #$EFFF
    STA $0016, Y
    COP [91]
    LDY $003C, X
    LDA $0002, Y
    CLC 
    ADC #$0010
    LDY $player_actor
    STA $0002, Y
    LDA #$0001
    STA $0006, Y
    DEC $0025, X
    BEQ loc_0F902C
    RTL 

  loc_0F902C:
    LDY $player_actor
    LDA $0016, Y
    ORA #$1000
    STA $0016, Y
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

code_0F9041 {
    COP [01] ( &asciistring_0F904A )
    COP [09] ( #$8000 )
    RTL 
}

asciistring_0F904A |[10]Stand on my nose- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|