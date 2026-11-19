?BANK 03

!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_01EE6D {
    COP [07] ( #$0A01, &code_01EEC2 )
    LDA #$FF80
    TSB $joy_block_mask
    LDA #$00F8
    STA $0000, X
    LDA #$0138
    STA $0002, X
    COP [11] ( #0C, #00, #01 )
    COP [11] ( #0D, #00, #01 )
    COP [11] ( #10, #00, #01 )
    COP [11] ( #11, #00, #01 )
    COP [34]
    COP [03] ( #03 )
    COP [04]
    BRK #$86
    COP [03] ( #FA )
    LDY $player_actor
    LDA $0002, X
    DEC 
    STA $0002, X
    STA $0002, Y
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$010A, #01, #$0100, #$0360 )
}

code_01EEC2 {
    COP [86]
    RTL 
}