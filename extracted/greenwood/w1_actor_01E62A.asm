?BANK 03

?INCLUDE 'w1_shared_01E75C'
?INCLUDE 'w1_shared_01EBC2'

!joy_block_mask                 0326

---------------------------------------------

code_01E62A {
    COP [07] ( #$8401, &code_01E682 ) ; {124458}
    COP [91]              ; {124464}
    COP [0C] ( #00, #01, &code_01E639 ) ; {124466}
    RTL                   ; {124472}
}

code_01E639 {
    COP [2A] ( #$0000, #$0000 ) ; {124473}
    COP [2A] ( #$0010, #$0000 ) ; {124479}
    LDA #$2F80            ; {124485}
    TSB $joy_block_mask   ; {124488}
    COP [81] ( #1A, #02 ) ; {124491}
    COP [83]              ; {124495}
    COP [1B] ( &code_01E657, #$001E ) ; {124497}
}

code_01E657 {
    COP [81] ( #30, #02 ) ; {124503}
    COP [83]              ; {124507}
    LDA #$2F80            ; {124509}
    TRB $joy_block_mask   ; {124512}
    COP [18] ( #1E, &code_01E686 ) ; {124515}
    COP [01] ( &asciistring_01E712 ) ; {124520}
    COP [81] ( #19, #02 ) ; {124524}
    COP [83]              ; {124528}
    COP [2B] ( #$0000, #$0000 ) ; {124530}
    COP [2B] ( #$0010, #$0000 ) ; {124536}
    COP [09] ( #$8401 )   ; {124542}
}

code_01E682 {
    COP [27] ( &w1_shared_01E75C.code_01E75C ) ; {124546}
}

code_01E686 {
    COP [01] ( &asciistring_01E68D ) ; {124550}
    COP [91]              ; {124554}
    RTL                   ; {124556}
}

asciistring_01E68D |[10][02:2] began to [N]hear a small voice- [FIN]We are rafts made from[N]the branches of trees [N]in GreenWood- [FIN]If you cannot prove [N]that you are from [N]GreenWood, we will not[N]let you ride- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E712 |[10]Those are leaves from [N]GreenWood! [N]Turbo s symbol! [FIN]We will take you to [N]the Light Shrine- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|