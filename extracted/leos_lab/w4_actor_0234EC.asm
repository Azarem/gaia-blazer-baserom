?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_block_mask                 0326

---------------------------------------------

code_0234EC {
    COP [14] ( #$012F, &code_0234F3 ) ; {144620}
    RTL                   ; {144626}
}

code_0234F3 {
    COP [30] ( #$012F, &code_023558, #04 ) ; {144627}
    COP [07] ( #$9F02, &code_023513 ) ; {144634}
    COP [85] ( @engine_0026F3.code_00299D ) ; {144640}
    COP [17] ( &code_02353F ) ; {144645}
    COP [15]              ; {144649}
    COP [91]              ; {144651}
    COP [80] ( #18 )      ; {144653}
    COP [82]              ; {144656}
    RTL                   ; {144658}
}

code_023513 {
    LDA #$BFC0            ; {144659}
    TSB $joy_block_mask   ; {144662}
    COP [03] ( #29 )      ; {144665}
    COP [04]              ; {144668}
    COP [01] ( &asciistring_023675 ) ; {144670}
    COP [03] ( #5B )      ; {144674}
    COP [04]              ; {144677}
    LDA #$0020            ; {144679}
    STA $03B4             ; {144682}
    COP [10] ( #$010A, #01, #$0100, #$0380 ) ; {144685}
    LDA #$BFC0            ; {144694}
    TRB $joy_block_mask   ; {144697}
    COP [91]              ; {144700}
    RTL                   ; {144702}
}

code_02353F {
    COP [07] ( #$9B04, &code_023553 ) ; {144703}
    COP [01] ( &asciistring_0235AC ) ; {144709}
    BRK #$5E              ; {144713}
    COP [0A] ( #3E )      ; {144715}
    COP [09] ( #$9B04 )   ; {144718}
    RTL                   ; {144722}
}

code_023553 {
    COP [01] ( &asciistring_023644 ) ; {144723}
    RTL                   ; {144727}
}

code_023558 {
    COP [01] ( &asciistring_023561 ) ; {144728}
    COP [37]              ; {144732}
    COP [86]              ; {144734}
    RTL                   ; {144736}
}

asciistring_023561 |[10][0E:3C]I am Marie, the doll- [N]I have [03:24]a Purple Stone [N][03:20]in my pocket- [FIN]Take this with you and[N]save Dr-Leo- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0235AC |[10]Nobody can break a [N]promise that is made [N]with Evil- [FIN]There will be no [N]revival of the world [N]unless Deathtoll is [N]defeated- [FIN]Dr-Leo must be [N]somewhere in the [N]Magridd Castle- [FIN]Here, take this stone [N]from my pocket and go [N]to the Magridd Castle- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023644 |[10]I wonder how Lisa is, [N]I want to see her [N]after the world is [N]revived- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023675 |[10][0F][02:2], [N]you made it- [N][0E:3C]Dr-Leo can pass away [N]peacefully- [N][0E:5A]We tools, exist to be [N]used by human beings- [N][0E:5A]We are happy if we re [N]helpful to the humans-[N][0E:3C]And we hurt if they [N]use us in the wrong [N]way- [N][0E:5A]Even though we would [N]like to tell them not [N]to use us the wrong [N]way, we cannot- [N][0E:3C]This is very painful- [N][0E:5A]But Dr-Leo understood[N]our feelings- [N][0E:5A]The tools Dr-Leo used[N]must have been happy- [0E:78][JMP:&w4_shared_023F33.asciistring_023FA3+M]|