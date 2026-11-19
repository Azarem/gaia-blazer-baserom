?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_block_mask                 0326

---------------------------------------------

code_0234EC {
    COP [14] ( #$012F, &code_0234F3 )
    RTL 
}

code_0234F3 {
    COP [30] ( #$012F, &code_023558, #04 )
    COP [07] ( #$9F02, &code_023513 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02353F )
    COP [15]
    COP [91]
    COP [80] ( #18 )
    COP [82]
    RTL 
}

code_023513 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_023675 )
    COP [03] ( #5B )
    COP [04]
    LDA #$0020
    STA $03B4
    COP [10] ( #$010A, #01, #$0100, #$0380 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_02353F {
    COP [07] ( #$9B04, &code_023553 )
    COP [01] ( &asciistring_0235AC )
    BRK #$5E
    COP [0A] ( #3E )
    COP [09] ( #$9B04 )
    RTL 
}

code_023553 {
    COP [01] ( &asciistring_023644 )
    RTL 
}

code_023558 {
    COP [01] ( &asciistring_023561 )
    COP [37]
    COP [86]
    RTL 
}

asciistring_023561 |[10][0E:3C]I am Marie, the doll- [N]I have [03:24]a Purple Stone [N][03:20]in my pocket- [FIN]Take this with you and[N]save Dr-Leo- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0235AC |[10]Nobody can break a [N]promise that is made [N]with Evil- [FIN]There will be no [N]revival of the world [N]unless Deathtoll is [N]defeated- [FIN]Dr-Leo must be [N]somewhere in the [N]Magridd Castle- [FIN]Here, take this stone [N]from my pocket and go [N]to the Magridd Castle- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023644 |[10]I wonder how Lisa is, [N]I want to see her [N]after the world is [N]revived- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023675 |[10][0F][02:2], [N]you made it- [N][0E:3C]Dr-Leo can pass away [N]peacefully- [N][0E:5A]We tools, exist to be [N]used by human beings- [N][0E:5A]We are happy if we re [N]helpful to the humans-[N][0E:3C]And we hurt if they [N]use us in the wrong [N]way- [N][0E:5A]Even though we would [N]like to tell them not [N]to use us the wrong [N]way, we cannot- [N][0E:3C]This is very painful- [N][0E:5A]But Dr-Leo understood[N]our feelings- [N][0E:5A]The tools Dr-Leo used[N]must have been happy- [0E:78][JMP:&w4_shared_023F33.asciistring_023FA3+M]|