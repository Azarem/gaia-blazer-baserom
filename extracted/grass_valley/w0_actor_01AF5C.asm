?BANK 03

?INCLUDE 'data_00F9F7'

!frame_counter                  0312
!joy_pressed                    0322
!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_01AF5C {
    COP [A4]
    COP [05] ( #$0404 )
    LDY $player_actor
    LDA $0000, Y
    CMP #$04B0
    BCC code_01AF75
    COP [A0] ( #$FFB0 )
    COP [27] ( &code_01AF97 )

  code_01AF75:
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AF7F )
    RTL 
}

code_01AF7F {
    LDA $joy_pressed
    AND #$0800
    BNE loc_01AF88
    RTL 

  loc_01AF88:
    COP [85] ( @code_01AFB9 )
    COP [81] ( #2B, #14 )
    COP [83]
    COP [27] ( &code_01AF97 )
}

code_01AF97 {
    COP [91]
    COP [0D] ( #00, #47, #33, &code_01AFA1 )
    RTL 
}

code_01AFA1 {
    LDA $joy_pressed
    AND #$0400
    BNE loc_01AFAA
    RTL 

  loc_01AFAA:
    COP [85] ( @code_01AFB9 )
    COP [81] ( #2D, #14 )
    COP [83]
    COP [27] ( &code_01AF75 )
}

code_01AFB9 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #51 )
    LDY $003C, X
    LDA $0002, Y
    LDY $player_actor
    STA $0002, Y
    LDY $039E
    STA $0002, Y
    PHX 
    LDX $player_actor
    LDA $001E, X
    ASL 
    TAX 
    LDA $&data_00F9F7.word_00FAD7, X
    CLC 
    ADC $0002, Y
    STA $0002, Y
    PLX 
    LDA $frame_counter
    AND #$0003
    BNE loc_01AFF2
    BRK #$63

  loc_01AFF2:
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}