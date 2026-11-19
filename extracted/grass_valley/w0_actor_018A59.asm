?BANK 03

?INCLUDE 'w0_shared_01B988'

!joy_block_mask                 0326

---------------------------------------------

code_018A59 {
    COP [14] ( #$0010, &code_018A60 )
    RTL 
}

code_018A60 {
    COP [30] ( #$0010, &code_018BC3, #03 )
    COP [07] ( #$9F02, &code_018B28 )
    COP [18] ( #29, &code_018A75 )
    COP [86]
    RTL 
}

code_018A75 {
    COP [A0] ( #$FFF8 )
    COP [14] ( #$0009, &code_018B1C )
    COP [17] ( &code_018B7C )

  code_018A83:
    COP [07] ( #$8302, &code_018B0F )
    COP [07] ( #$8301, &code_018AF5 )
    COP [07] ( #$8207, &code_018AE8 )
    COP [07] ( #$8105, &code_018AE8 )
    COP [07] ( #$8104, &code_018AA9 )
    COP [80] ( #12 )
    COP [82]
    BRL code_018A83
}

code_018AA9 {
    LDA #$AF80
    TSB $joy_block_mask
    COP [80] ( #13 )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    LDA #$AF80
    TRB $joy_block_mask
    COP [01] ( &asciistring_018C34 )
    COP [09] ( #$8105 )
    COP [91]
    COP [0D] ( #00, #37, #1F, &code_018AD8 )
    COP [0D] ( #00, #3A, #20, &code_018AD8 )
    RTL 
}

code_018AD8 {
    COP [01] ( &asciistring_018C5C )
    COP [09] ( #$8207 )
    COP [17] ( &code_018BA2 )
    COP [27] ( &code_018A83 )
}

code_018AE8 {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BA2 )
    COP [27] ( &code_018A83 )
}

code_018AF5 {
    COP [80] ( #14 )
    COP [82]
    COP [18] ( #1D, &code_018B07 )
    COP [17] ( &code_018BB0 )
    COP [27] ( &code_018A83 )
}

code_018B07 {
    COP [17] ( &code_018BAB )
    COP [27] ( &code_018A83 )
}

code_018B0F {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BB9 )
    COP [27] ( &code_018A83 )
}

code_018B1C {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BBE )
    COP [91]
    RTL 
}

code_018B28 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [A0] ( #$FFF8 )
    COP [07] ( #$9F01, &code_018B5B )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_018F85 )
    COP [03] ( #79 )
    COP [04]
    COP [3C] ( #04 )
    COP [10] ( #$0302, #01, #$0108, #$0348 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_018B5B {
    COP [34]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #5B )
    COP [04]
    COP [01] ( &asciistring_018FCD )
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$0B00, #01, #$0000, #$0000 )
    COP [91]
    RTL 
}

code_018B7C {
    COP [07] ( #$8104, &code_018B9D )
    COP [19] ( #1C, &code_018B98 )
    COP [01] ( &asciistring_018C02 )
    COP [3C] ( #04 )
    COP [10] ( #$0302, #02, #$0120, #$0320 )
    RTL 
}

code_018B98 {
    COP [01] ( &asciistring_018C26 )
    RTL 
}

code_018B9D {
    COP [01] ( &asciistring_018C34 )
    RTL 
}

code_018BA2 {
    COP [01] ( &asciistring_018C98 )
    COP [09] ( #$8301 )
    RTL 
}

code_018BAB {
    COP [01] ( &asciistring_018D5D )
    RTL 
}

code_018BB0 {
    COP [01] ( &asciistring_018D61 )
    COP [09] ( #$8302 )
    RTL 
}

code_018BB9 {
    COP [01] ( &asciistring_018F15 )
    RTL 
}

code_018BBE {
    COP [01] ( &asciistring_018F19 )
    RTL 
}

code_018BC3 {
    COP [01] ( &asciistring_018BCA )
    COP [86]
    RTL 
}

asciistring_018BCA |[10][0E:3C]You hear some light [N]snoring coming from [N]inside the house- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018C02 |[10][02:2] placed [N]the Dream Rod on the [N]girl s head- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018C26 |[10]Zzzz----- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018C34 |[10]Oh, my! Who are you? [N]Get out of my house! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018C5C |[10]Wait! [N]I m sorry for yelling [N]at you- [FIN]Please come back and [N]listen to my story- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018C98 |[10]I had a very strange [N]dream- It was about my[N]father and someone who[N]looked just like you- [FIN]My father told me to [N]give his paintbrush to[N]you and tell you all I[N]know- [FIN][::]The brush is all [N]I have left from my [N]father- [N]I hid it somewhere- [FIN]When you come back to [N]me with that brush, I [N]will tell you all I [N]know- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018D5D |[10][JMP:&asciistring_018C98+M]|

asciistring_018D61 |[10]Oh! You have found my [N]father s paintbrush- I[N]will now tell you what[N]I know- [FIN]One day, as I returned[N]from shopping I [N]found a note- [FIN]Lisa pulled out the [N]note and began to [N]read- [FIN]"Lisa, I won t be able[N]to see you for a [N]while- [FIN]If you have any [N]problems, please see [N]the village Chief- [FIN]Take care of your [N]friends, [N]Turbo, the dog, [FIN]Lue, the dolphin, [FIN]Nome, the snail, [FIN]and Marie, the doll-ˮ [FIN]The animals mentioned [N]in the letter were [N]once my father s pets-[FIN]I don t understand [N]what he is trying to [N]say though- [FIN][::]I know you re a [N]complete stranger, but[N]will you please search[N]for my father? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018F15 |[10][JMP:&asciistring_018D61+M]|

asciistring_018F19 |[10]Some believe after a [N]person dies, they will[N]return in the form of [N]a different creature- [FIN]If this is true, I [N]wonder what my mother [N]is doing now? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018F85 |[10][0F]Lisa appears to be [N]sleeping- [N][0E:5A][02:2], placed [N]the Dream Rod upon [N]Lisa s head- [0E:78][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_018FCD |[10][02:2], [N]promise me you will [N]return someday- [0E:B4][JMP:&w0_shared_01B988.asciistring_01B988+M]|