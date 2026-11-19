?BANK 03

?INCLUDE 'w0_shared_01B988'

!joy_block_mask                 0326

---------------------------------------------

code_018A59 {
    COP [14] ( #$0010, &code_018A60 ) ; {100953}
    RTL                   ; {100959}
}

code_018A60 {
    COP [30] ( #$0010, &code_018BC3, #03 ) ; {100960}
    COP [07] ( #$9F02, &code_018B28 ) ; {100967}
    COP [18] ( #29, &code_018A75 ) ; {100973}
    COP [86]              ; {100978}
    RTL                   ; {100980}
}

code_018A75 {
    COP [A0] ( #$FFF8 )   ; {100981}
    COP [14] ( #$0009, &code_018B1C ) ; {100985}
    COP [17] ( &code_018B7C ) ; {100991}

  code_018A83:
    COP [07] ( #$8302, &code_018B0F ) ; {100995}
    COP [07] ( #$8301, &code_018AF5 ) ; {101001}
    COP [07] ( #$8207, &code_018AE8 ) ; {101007}
    COP [07] ( #$8105, &code_018AE8 ) ; {101013}
    COP [07] ( #$8104, &code_018AA9 ) ; {101019}
    COP [80] ( #12 )      ; {101025}
    COP [82]              ; {101028}
    BRL code_018A83       ; {101030}
}

code_018AA9 {
    LDA #$AF80            ; {101033}
    TSB $joy_block_mask   ; {101036}
    COP [80] ( #13 )      ; {101039}
    COP [82]              ; {101042}
    COP [80] ( #14 )      ; {101044}
    COP [82]              ; {101047}
    LDA #$AF80            ; {101049}
    TRB $joy_block_mask   ; {101052}
    COP [01] ( &asciistring_018C34 ) ; {101055}
    COP [09] ( #$8105 )   ; {101059}
    COP [91]              ; {101063}
    COP [0D] ( #00, #37, #1F, &code_018AD8 ) ; {101065}
    COP [0D] ( #00, #3A, #20, &code_018AD8 ) ; {101072}
    RTL                   ; {101079}
}

code_018AD8 {
    COP [01] ( &asciistring_018C5C ) ; {101080}
    COP [09] ( #$8207 )   ; {101084}
    COP [17] ( &code_018BA2 ) ; {101088}
    COP [27] ( &code_018A83 ) ; {101092}
}

code_018AE8 {
    COP [80] ( #14 )      ; {101096}
    COP [82]              ; {101099}
    COP [17] ( &code_018BA2 ) ; {101101}
    COP [27] ( &code_018A83 ) ; {101105}
}

code_018AF5 {
    COP [80] ( #14 )      ; {101109}
    COP [82]              ; {101112}
    COP [18] ( #1D, &code_018B07 ) ; {101114}
    COP [17] ( &code_018BB0 ) ; {101119}
    COP [27] ( &code_018A83 ) ; {101123}
}

code_018B07 {
    COP [17] ( &code_018BAB ) ; {101127}
    COP [27] ( &code_018A83 ) ; {101131}
}

code_018B0F {
    COP [80] ( #14 )      ; {101135}
    COP [82]              ; {101138}
    COP [17] ( &code_018BB9 ) ; {101140}
    COP [27] ( &code_018A83 ) ; {101144}
}

code_018B1C {
    COP [80] ( #14 )      ; {101148}
    COP [82]              ; {101151}
    COP [17] ( &code_018BBE ) ; {101153}
    COP [91]              ; {101157}
    RTL                   ; {101159}
}

code_018B28 {
    LDA #$BFC0            ; {101160}
    TSB $joy_block_mask   ; {101163}
    COP [A0] ( #$FFF8 )   ; {101166}
    COP [07] ( #$9F01, &code_018B5B ) ; {101170}
    COP [03] ( #29 )      ; {101176}
    COP [04]              ; {101179}
    COP [01] ( &asciistring_018F85 ) ; {101181}
    COP [03] ( #79 )      ; {101185}
    COP [04]              ; {101188}
    COP [3C] ( #04 )      ; {101190}
    COP [10] ( #$0302, #01, #$0108, #$0348 ) ; {101193}
    LDA #$BFC0            ; {101202}
    TRB $joy_block_mask   ; {101205}
    COP [91]              ; {101208}
    RTL                   ; {101210}
}

code_018B5B {
    COP [34]              ; {101211}
    COP [80] ( #13 )      ; {101213}
    COP [82]              ; {101216}
    COP [03] ( #5B )      ; {101218}
    COP [04]              ; {101221}
    COP [01] ( &asciistring_018FCD ) ; {101223}
    COP [03] ( #F1 )      ; {101227}
    COP [04]              ; {101230}
    COP [10] ( #$0B00, #01, #$0000, #$0000 ) ; {101232}
    COP [91]              ; {101241}
    RTL                   ; {101243}
}

code_018B7C {
    COP [07] ( #$8104, &code_018B9D ) ; {101244}
    COP [19] ( #1C, &code_018B98 ) ; {101250}
    COP [01] ( &asciistring_018C02 ) ; {101255}
    COP [3C] ( #04 )      ; {101259}
    COP [10] ( #$0302, #02, #$0120, #$0320 ) ; {101262}
    RTL                   ; {101271}
}

code_018B98 {
    COP [01] ( &asciistring_018C26 ) ; {101272}
    RTL                   ; {101276}
}

code_018B9D {
    COP [01] ( &asciistring_018C34 ) ; {101277}
    RTL                   ; {101281}
}

code_018BA2 {
    COP [01] ( &asciistring_018C98 ) ; {101282}
    COP [09] ( #$8301 )   ; {101286}
    RTL                   ; {101290}
}

code_018BAB {
    COP [01] ( &asciistring_018D5D ) ; {101291}
    RTL                   ; {101295}
}

code_018BB0 {
    COP [01] ( &asciistring_018D61 ) ; {101296}
    COP [09] ( #$8302 )   ; {101300}
    RTL                   ; {101304}
}

code_018BB9 {
    COP [01] ( &asciistring_018F15 ) ; {101305}
    RTL                   ; {101309}
}

code_018BBE {
    COP [01] ( &asciistring_018F19 ) ; {101310}
    RTL                   ; {101314}
}

code_018BC3 {
    COP [01] ( &asciistring_018BCA ) ; {101315}
    COP [86]              ; {101319}
    RTL                   ; {101321}
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