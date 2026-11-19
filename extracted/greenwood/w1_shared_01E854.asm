?BANK 03

?INCLUDE 'w1_actor_01E851'
?INCLUDE 'w1_actor_01E8ED'

!joy_block_mask                 0326

---------------------------------------------

code_01E854 {
    COP [A4]
    COP [2A] ( #$0000, #$0010 )
    COP [2B] ( #$0010, #$0000 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E87F )
    BRL loc_01E880
}

code_01E87F {
    RTL 

  loc_01E880:
    COP [91]
    COP [0C] ( #00, #00, &code_01E889 )
    RTL 
}

code_01E889 {
    COP [85] ( @code_01E8C5 )
    COP [2B] ( #$0000, #$0010 )
    COP [2A] ( #$0010, #$0000 )
    COP [2A] ( #$0010, #$FFF0 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )

  code_01E8AC:
    COP [80] ( #1B )
    COP [82]
    COP [22] ( &code_01E8AC )
    COP [09] ( #$8000 )
    COP [23] ( &code_01E8C1 )
    COP [27] ( &w1_actor_01E8ED.code_01E8ED )
}

code_01E8C1 {
    COP [27] ( &w1_actor_01E851.code_01E851 )
}

code_01E8C5 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$FFFE, #$0000 )
    COP [07] ( #$8000, &code_01E8DA )
    RTL 
}

code_01E8DA {
    COP [2F] ( #$FFFE, #$0000 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}