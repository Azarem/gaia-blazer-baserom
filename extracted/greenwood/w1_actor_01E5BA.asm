?BANK 03

?INCLUDE 'w1_shared_01E7D8'
?INCLUDE 'w1_shared_01E854'
?INCLUDE 'w1_shared_01E8F0'

!player_actor                   039C

---------------------------------------------

code_01E5BA {
    LDY $player_actor     ; {124346}
    LDA $0002, Y          ; {124349}
    CMP #$0060            ; {124352}
    BCC loc_01E5F5        ; {124355}
    COP [0D] ( #00, #1C, #20, &code_01E5D5 ) ; {124357}
    COP [0D] ( #00, #03, #19, &code_01E5DF ) ; {124364}
    BRA loc_01E627        ; {124371}
}

code_01E5D5 {
    COP [11] ( #16, #17, #19 ) ; {124373}
    COP [12] ( #16, &w1_shared_01E854.code_01E854 ) ; {124378}
}

code_01E5DF {
    COP [11] ( #14, #0F, #14 ) ; {124383}
    COP [12] ( #14, &w1_shared_01E7D8.code_01E7D8 ) ; {124388}
    COP [11] ( #15, #06, #10 ) ; {124393}
    COP [12] ( #15, &w1_shared_01E8F0.code_01E8F0 ) ; {124398}
    BRA loc_01E627        ; {124403}

  loc_01E5F5:
    COP [11] ( #14, #0F, #08 ) ; {124405}
    COP [12] ( #14, &w1_shared_01E8F0.code_01E8F0 ) ; {124410}
    COP [11] ( #15, #1C, #0D ) ; {124415}
    COP [12] ( #15, &w1_shared_01E7D8.code_01E7D8 ) ; {124420}
    COP [11] ( #16, #17, #19 ) ; {124425}
    COP [12] ( #16, &w1_shared_01E854.code_01E854 ) ; {124430}
    COP [11] ( #17, #06, #10 ) ; {124435}
    COP [12] ( #17, &w1_shared_01E8F0.code_01E8F0 ) ; {124440}
    COP [11] ( #18, #0F, #14 ) ; {124445}
    COP [12] ( #18, &w1_shared_01E7D8.code_01E7D8 ) ; {124450}

  loc_01E627:
    COP [86]              ; {124455}
    RTL                   ; {124457}
}