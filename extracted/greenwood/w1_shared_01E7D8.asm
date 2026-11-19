?BANK 03

?INCLUDE 'w1_actor_01E759'

!joy_block_mask                 0326

---------------------------------------------

code_01E7D8 {
    COP [A4]
    COP [2A] ( #$FFF0, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E7F7 )
    BRL loc_01E7F8
}

code_01E7F7 {
    RTL 

  loc_01E7F8:
    COP [91]
    COP [0C] ( #00, #00, &code_01E801 )
    RTL 
}

code_01E801 {
    COP [85] ( @code_01E829 )
    COP [2B] ( #$FFF0, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )
    COP [2A] ( #$0010, #$FFF0 )

  code_01E818:
    COP [80] ( #19 )
    COP [82]
    COP [23] ( &code_01E818 )
    COP [09] ( #$8000 )
    COP [27] ( &w1_actor_01E759.code_01E759 )
}

code_01E829 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0000, #$0002 )
    COP [07] ( #$8000, &code_01E83E )
    RTL 
}

code_01E83E {
    COP [2F] ( #$0000, #$0002 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}