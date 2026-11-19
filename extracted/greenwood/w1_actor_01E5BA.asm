?BANK 03

?INCLUDE 'w1_shared_01E7D8'
?INCLUDE 'w1_shared_01E854'
?INCLUDE 'w1_shared_01E8F0'

!player_actor                   039C

---------------------------------------------

code_01E5BA {
    LDY $player_actor
    LDA $0002, Y
    CMP #$0060
    BCC loc_01E5F5
    COP [0D] ( #00, #1C, #20, &code_01E5D5 )
    COP [0D] ( #00, #03, #19, &code_01E5DF )
    BRA loc_01E627
}

code_01E5D5 {
    COP [11] ( #16, #17, #19 )
    COP [12] ( #16, &w1_shared_01E854.code_01E854 )
}

code_01E5DF {
    COP [11] ( #14, #0F, #14 )
    COP [12] ( #14, &w1_shared_01E7D8.code_01E7D8 )
    COP [11] ( #15, #06, #10 )
    COP [12] ( #15, &w1_shared_01E8F0.code_01E8F0 )
    BRA loc_01E627

  loc_01E5F5:
    COP [11] ( #14, #0F, #08 )
    COP [12] ( #14, &w1_shared_01E8F0.code_01E8F0 )
    COP [11] ( #15, #1C, #0D )
    COP [12] ( #15, &w1_shared_01E7D8.code_01E7D8 )
    COP [11] ( #16, #17, #19 )
    COP [12] ( #16, &w1_shared_01E854.code_01E854 )
    COP [11] ( #17, #06, #10 )
    COP [12] ( #17, &w1_shared_01E8F0.code_01E8F0 )
    COP [11] ( #18, #0F, #14 )
    COP [12] ( #18, &w1_shared_01E7D8.code_01E7D8 )

  loc_01E627:
    COP [86]
    RTL 
}