?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326

---------------------------------------------

code_024259 {
    COP [14] ( #$0161, &code_024260 )
    RTL 
}

code_024260 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [07] ( #$8804, &code_0242AE )
    COP [17] ( &code_0242BC )
    COP [15]
    COP [91]
    COP [0D] ( #00, #02, #1F, &code_02427B )
    RTL 
}

code_02427B {
    COP [07] ( #$0803, &code_0242B9 )
    COP [17] ( #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #2C )
    COP [82]
    COP [2B] ( #$FFF0, #$0000 )
    COP [01] ( &asciistring_024316 )
    BRK #$5E
    COP [0A] ( #0F )
    COP [09] ( #$8804 )
    LDA #$2F80
    TRB $joy_block_mask
}

code_0242AE {
    COP [80] ( #12 )
    COP [82]
    COP [17] ( &code_0242DD )
    COP [15]
}

code_0242B9 {
    COP [91]
    RTL 
}

code_0242BC {
    COP [07] ( #$8804, &code_0242DD )
    COP [19] ( #1C, &code_0242D8 )
    COP [01] ( &asciistring_0242EB )
    COP [3C] ( #04 )
    COP [10] ( #$0313, #01, #$0150, #$01A0 )
    RTL 
}

code_0242D8 {
    COP [01] ( &asciistring_0242E2 )
    RTL 
}

code_0242DD {
    COP [01] ( &asciistring_0243E7 )
    RTL 
}

asciistring_0242E2 |[10]Zzzz [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0242EB |[10][02:2] placed the [N]Dream Rod upon the [N]soldier s head- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024316 |[10]Oops! I was sleeping- [FIN]Lately I have been [N]having the same dream [N]as Dr-Leo- [FIN]If I would have [N]released Dr-Leo, [N]the world would not be[N]like this- [FIN]I don t know who to [N]obey anymore! [FIN]There are many thorns [N]in the basement of [N]Magridd Castle- [FIN]You must take this [N]armor with you- [FIN][02:2] received [N][03:24]the Elemental Mail- [03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0243E7 |[10]I have a feeling that [N]you will change the [N]world- [N]Good luck! [JMP:&w5_shared_02706C.asciistring_0270DF]|