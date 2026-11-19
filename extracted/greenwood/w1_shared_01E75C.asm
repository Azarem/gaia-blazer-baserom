?BANK 03

?INCLUDE 'w1_actor_01E7D5'

!joy_block_mask                 0326

---------------------------------------------

code_01E75C {
    COP [A4]
    COP [2A] ( #$FFF0, #$0000 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0010, #$0000 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E77B )
    BRL loc_01E77C
}

code_01E77B {
    RTL 

  loc_01E77C:
    COP [91]
    COP [0C] ( #00, #00, &code_01E785 )
    RTL 
}

code_01E785 {
    COP [85] ( @code_01E7AD )
    COP [2B] ( #$FFF0, #$0000 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0010, #$0000 )

  code_01E79C:
    COP [80] ( #1A )
    COP [82]
    COP [23] ( &code_01E79C )
    COP [09] ( #$8000 )
    COP [27] ( &w1_actor_01E7D5.code_01E7D5 )
}

code_01E7AD {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0000, #$FFFE )
    COP [07] ( #$8000, &code_01E7C2 )
    RTL 
}

code_01E7C2 {
    COP [2F] ( #$0000, #$FFFE )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}