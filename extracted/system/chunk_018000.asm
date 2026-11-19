?BANK 03

?INCLUDE 'chunk_000000'
?INCLUDE 'chunk_010000'
?INCLUDE 'data_00F9F7'

!BG3SC                          2109
!TM                             212C

---------------------------------------------

code_018000 {
    COP [14] ( #$0029, &code_018007 ) ; {98304}
    RTL                   ; {98310}
}

code_018007 {
    COP [85] ( @chunk_000000.code_00299D ) ; {98311}
    COP [17] ( &code_018036 ) ; {98316}
    COP [15]              ; {98320}
    COP [05] ( #$0000 )   ; {98322}
    COP [8F]              ; {98326}
    COP [80] ( #02 )      ; {98328}
    COP [82]              ; {98331}
    COP [91]              ; {98333}
    LDA $0322             ; {98335}
    AND #$0030            ; {98338}
    BNE loc_018028        ; {98341}
    RTL                   ; {98343}

  loc_018028:
    LDA $0322             ; {98344}
    AND #$0F00            ; {98347}
    BNE loc_018031        ; {98350}
    RTL                   ; {98352}

  loc_018031:
    COP [17] ( &code_01803F ) ; {98353}
    RTL                   ; {98357}
}

code_018036 {
    COP [01] ( &asciistring_018044 ) ; {98358}
    COP [09] ( #$8000 )   ; {98362}
    RTL                   ; {98366}
}

code_01803F {
    COP [01] ( &asciistring_0180B7 ) ; {98367}
    RTL                   ; {98371}
}

asciistring_018044 |[10]Hey, you look like you[N]would be good at crab+[N]walking- [N]Try it- [FIN]You don t know how? [N]Just walk while [N]pressing either [N]the L or R button- [JMP:&asciistring_01B988]|

asciistring_0180B7 |[10]See, I knew you could[N]do it! [FIN]This will help you [N]when you are fighting [N]or using magic- [JMP:&asciistring_01B988]|

code_0180F7 {
    COP [14] ( #$0002, &code_0180FE ) ; {98551}
    RTL                   ; {98557}
}

code_0180FE {
    COP [30] ( #$0002, &code_018159, #03 ) ; {98558}
    COP [14] ( #$0009, &code_018114 ) ; {98565}
    COP [17] ( &code_01812B ) ; {98571}
    COP [15]              ; {98575}
    COP [91]              ; {98577}
    RTL                   ; {98579}
}

code_018114 {
    COP [07] ( #$9F02, &code_018128 ) ; {98580}
    COP [17] ( &code_018160 ) ; {98586}
    COP [11] ( #04, #3B, #1E ) ; {98590}
    COP [15]              ; {98595}
    COP [91]              ; {98597}
    RTL                   ; {98599}
}

code_018128 {
    COP [86]              ; {98600}
    RTL                   ; {98602}
}

code_01812B {
    COP [07] ( #$8101, &code_018152 ) ; {98603}
    COP [01] ( &asciistring_01816F ) ; {98609}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_01814D ) ; {98613}
    LDA $0003D0           ; {98620}
    BNE code_01814D       ; {98624}
    COP [09] ( #$8101 )   ; {98626}
    COP [01] ( &asciistring_018211 ) ; {98630}
    BRL loc_018156        ; {98634}
}

code_01814D {
    COP [01] ( &asciistring_0181F8 ) ; {98637}
    RTL                   ; {98641}
}

code_018152 {
    COP [01] ( &asciistring_018255 ) ; {98642}

  loc_018156:
    COP [37]              ; {98646}
    RTL                   ; {98648}
}

code_018159 {
    COP [01] ( &asciistring_01832D ) ; {98649}
    COP [86]              ; {98653}
    RTL                   ; {98655}
}

code_018160 {
    COP [18] ( #29, &code_01816A ) ; {98656}
    COP [01] ( &asciistring_0182E7 ) ; {98661}
    RTL                   ; {98665}
}

code_01816A {
    COP [01] ( &asciistring_0182AC ) ; {98666}
    RTL                   ; {98670}
}

asciistring_01816F |[10]My husband used to be [N]the village Chief- [FIN]One day he suddenly [N]disappeared along with[N]the other villagers- [FIN]I feel so lonely---- [N]How about being one of[N]my children? [END]|

asciistring_0181F8 |Well, [N]that s too bad- [JMP:&asciistring_01B988]|

asciistring_018211 |Really?! [N]I will call you [N][02:2] from now on- [FIN]Use the second floor [N]as your own room- [JMP:&asciistring_01B988]|

asciistring_018255 |[10][02:2], [N]you are just walking [N]around doing nothing- [FIN]I am beginning to [N]worry about you- [N]Please, stay here and [N]rest- [JMP:&asciistring_01B988]|

asciistring_0182AC |[10]I feel bad for Lisa, [N]having been separated [N]from her parents- [JMP:&asciistring_01B988]|

asciistring_0182E7 |[10][02:2]! [FIN]Soldiers from Magridd [N]were just here! [N]They kidnapped Lisa! [N]You must rescue her! [JMP:&asciistring_01B988]|

asciistring_01832D |[10]You hear a sigh coming[N]from inside the house-[JMP:&asciistring_01B988]|

code_018353 {
    COP [14] ( #$0006, &code_01835A ) ; {99155}
    RTL                   ; {99161}
}

code_01835A {
    COP [17] ( &code_018399 ) ; {99162}

  code_01835E:
    COP [91]              ; {99166}
    COP [20] ( &code_018395 ) ; {99168}
    COP [9A] ( #$0000, &code_01836E, &code_018395, &code_018383 ) ; {99172}
}

code_01836E {
    COP [23] ( &code_01837B ) ; {99182}
    COP [97]              ; {99186}
    COP [9D] ( #0B )      ; {99188}
    COP [9E] ( &code_01837B ) ; {99191}
}

code_01837B {
    COP [80] ( #06 )      ; {99195}
    COP [82]              ; {99198}
    BRL code_018395       ; {99200}
}

code_018383 {
    COP [24] ( &code_018390 ) ; {99203}
    COP [96]              ; {99207}
    COP [9D] ( #0B )      ; {99209}
    COP [9E] ( &code_018390 ) ; {99212}
}

code_018390 {
    COP [80] ( #06 )      ; {99216}
    COP [82]              ; {99219}
}

code_018395 {
    COP [27] ( &code_01835E ) ; {99221}
}

code_018399 {
    COP [18] ( #38, &code_0183A3 ) ; {99225}
    COP [01] ( &asciistring_018428 ) ; {99230}
    RTL                   ; {99234}
}

code_0183A3 {
    COP [01] ( &asciistring_0183AD ) ; {99235}
    BRK #$5E              ; {99239}
    COP [0A] ( #38 )      ; {99241}
    RTL                   ; {99244}
}

asciistring_0183AD |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [N]Take whatever you need[N]from my store- [FIN]I only have Medical [N]Herbs though- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&asciistring_01B988]|

asciistring_018428 |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [FIN]Whenever you use your [N]Medical Herb please [N]come back, and I will [N]give you another- [JMP:&asciistring_01B988]|

asciistring_018480 |[02:96][02:80][08:8202]And world your |

code_01848A {
    COP [14] ( #$0007, &code_018491 ) ; {99466}
    RTL                   ; {99472}
}

code_018491 {
    COP [30] ( #$0007, &code_0184B9, #03 ) ; {99473}
    COP [85] ( @chunk_000000.code_00299D ) ; {99480}
    COP [17] ( &code_0184AA ) ; {99485}
    COP [15]              ; {99489}

  loc_0184A3:
    COP [80] ( #1E )      ; {99491}
    COP [82]              ; {99494}
    BRA loc_0184A3        ; {99496}
}

code_0184AA {
    COP [14] ( #$0009, &code_0184B5 ) ; {99498}
    COP [01] ( &asciistring_0184BE ) ; {99504}
    RTL                   ; {99508}
}

code_0184B5 {
    COP [01] ( &asciistring_018552 ) ; {99509}
}

code_0184B9 {
    COP [01] ( &asciistring_01852E ) ; {99513}
    RTL                   ; {99517}
}

asciistring_0184BE |[10][::]There once was [N]a water mill here [N]before the village was[N]destroyed- [FIN]I hear there is a man [N]in the mill who runs [N]the elevator in the [N]Underground Castle- [JMP:&asciistring_01B988]|

asciistring_01852E |[10][0E:3C][02:2] began [N]to hear a small voice-[FIN][JMP:&asciistring_0184BE+M]|

asciistring_018552 |[10]The village Chief [N]speaks with me every [N]morning- [FIN]Even though I cannot [N]speak, I communicate [N]with him through our [N]thoughts- [JMP:&asciistring_01B988]|

code_0185B9 {
    COP [14] ( #$0008, &code_0185C0 ) ; {99769}
    RTL                   ; {99775}
}

code_0185C0 {
    COP [85] ( @chunk_000000.code_00299D ) ; {99776}
    COP [15]              ; {99781}
    COP [91]              ; {99783}
    COP [07] ( #$8202, &code_0185D4 ) ; {99785}
    COP [17] ( &code_018635 ) ; {99791}
    RTL                   ; {99795}
}

code_0185D4 {
    COP [17] ( &code_01863E ) ; {99796}

  code_0185D8:
    COP [0C] ( #00, #04, &code_01860F ) ; {99800}
    COP [07] ( #$8004, &code_0185FD ) ; {99806}
    COP [9A] ( #$0000, &code_0185EE, &code_01860F, &code_0185F3 ) ; {99812}
}

code_0185EE {
    COP [97]              ; {99822}
    BRL loc_0185F5        ; {99824}
}

code_0185F3 {
    COP [96]              ; {99827}

  loc_0185F5:
    COP [80] ( #02 )      ; {99829}
    COP [82]              ; {99832}
    BRL loc_018631        ; {99834}
}

code_0185FD {
    COP [16]              ; {99837}
    COP [9D] ( #04 )      ; {99839}
    COP [9E] ( &code_018606 ) ; {99842}
}

code_018606 {
    COP [15]              ; {99846}
    COP [09] ( #$0004 )   ; {99848}
    BRL loc_018631        ; {99852}
}

code_01860F {
    COP [07] ( #$8004, &code_01862C ) ; {99855}
    COP [16]              ; {99861}
    COP [9D] ( #03 )      ; {99863}
    COP [9E] ( &code_01861E ) ; {99866}
}

code_01861E {
    COP [80] ( #01 )      ; {99870}
    COP [82]              ; {99873}
    COP [15]              ; {99875}
    COP [09] ( #$8004 )   ; {99877}
    BRL loc_018631        ; {99881}
}

code_01862C {
    COP [80] ( #01 )      ; {99884}
    COP [82]              ; {99887}

  loc_018631:
    COP [27] ( &code_0185D8 ) ; {99889}
}

code_018635 {
    COP [01] ( &asciistring_018643 ) ; {99893}
    COP [09] ( #$8202 )   ; {99897}
    RTL                   ; {99901}
}

code_01863E {
    COP [01] ( &asciistring_018698 ) ; {99902}
    RTL                   ; {99906}
}

asciistring_018643 |[10]I am the guard of [N]the bridge- [FIN]I guess it is not [N]really necessary to [N]guard such a small [N]bridge, please pass- [JMP:&asciistring_01B988]|

asciistring_018698 |[10]Please pass-[JMP:&asciistring_01B988]|

code_0186A2 {
    COP [14] ( #$000E, &code_0186A9 ) ; {100002}
    RTL                   ; {100008}
}

code_0186A9 {
    COP [30] ( #$000E, &code_018774, #03 ) ; {100009}
    COP [07] ( #$8404, &code_018742 ) ; {100016}
    COP [15]              ; {100022}
    COP [17] ( &code_018766 ) ; {100024}
    COP [05] ( #$0001 )   ; {100028}
    COP [16]              ; {100032}
    LDA #$2F80            ; {100034}
    TSB $0326             ; {100037}
    COP [96]              ; {100040}
    COP [9D] ( #05 )      ; {100042}
    COP [9E] ( &code_0186D1 ) ; {100045}
}

code_0186D1 {
    COP [9D] ( #04 )      ; {100049}
    COP [9E] ( &code_0186D8 ) ; {100052}
}

code_0186D8 {
    COP [80] ( #00 )      ; {100056}
    COP [82]              ; {100059}
    LDA #$2F80            ; {100061}
    TRB $0326             ; {100064}
    COP [15]              ; {100067}

  loc_0186E5:
    COP [91]              ; {100069}
    COP [0D] ( #00, #26, #17, &code_0186EF ) ; {100071}
    RTL                   ; {100078}
}

code_0186EF {
    LDA #$2F80            ; {100079}
    TSB $0326             ; {100082}
    LDY $039C             ; {100085}
    LDA #$0001            ; {100088}
    STA $001E, Y          ; {100091}
    COP [03] ( #03 )      ; {100094}
    COP [04]              ; {100097}
    LDA #$2F80            ; {100099}
    TRB $0326             ; {100102}
    COP [01] ( &asciistring_018889 ) ; {100105}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_018732 ) ; {100109}
    LDA $0003D0           ; {100116}
    BNE code_018732       ; {100120}
    COP [01] ( &asciistring_0188A7 ) ; {100122}
    BRK #$4F              ; {100126}
    COP [09] ( #$8404 )   ; {100128}

  loc_018724:
    COP [17] ( &code_01876F ) ; {100132}
    COP [91]              ; {100136}
    COP [0D] ( #00, #2F, #32, &code_018750 ) ; {100138}
    RTL                   ; {100145}
}

code_018732 {
    COP [01] ( &asciistring_01B988+M ) ; {100146}
    COP [91]              ; {100150}
    COP [0D] ( #00, #26, #17, &code_018741 ) ; {100152}
    BRA loc_0186E5        ; {100159}
}

code_018741 {
    RTL                   ; {100161}
}

code_018742 {
    COP [11] ( #08, #27, #17 ) ; {100162}
    COP [15]              ; {100167}
    COP [80] ( #00 )      ; {100169}
    COP [82]              ; {100172}
    BRA loc_018724        ; {100174}
}

code_018750 {
    COP [07] ( #$9A00, &code_018763 ) ; {100176}
    COP [01] ( &asciistring_0188FC ) ; {100182}
    BRK #$5E              ; {100186}
    COP [0A] ( #2A )      ; {100188}
    COP [09] ( #$9A00 )   ; {100191}
}

code_018763 {
    COP [91]              ; {100195}
    RTL                   ; {100197}
}

code_018766 {
    COP [01] ( &asciistring_01877B ) ; {100198}
    COP [09] ( #$8001 )   ; {100202}
    RTL                   ; {100206}
}

code_01876F {
    COP [01] ( &asciistring_0187E0 ) ; {100207}
    RTL                   ; {100211}
}

code_018774 {
    COP [01] ( &asciistring_018836 ) ; {100212}
    COP [86]              ; {100216}
    RTL                   ; {100218}
}

asciistring_01877B |[10]Rotating this wheel [N]will move the elevator[N]in the Underground [N]Castle- [FIN]I am too weak to turn [N]this wheel, will you [N]do it for me? [JMP:&asciistring_01B988]|

asciistring_0187E0 |[10]Oh, no wonder! I was [N]turning it the wrong [N]way! [FIN]By the way, don t you [N]think this water mill [N]is great?! [JMP:&asciistring_01B988]|

asciistring_018836 |[10][0E:3C]A man s voice came [N]from inside the water [N]mill- [FIN]DARN IT! [FIN]This stupid wheel! [N]It s so hard to turn! [JMP:&asciistring_01B988]|

asciistring_018889 |[10]This is the wheel, [N]will you try to turn [N]it? [END]|

asciistring_0188A7 |[02:2] [N]turned the wheel- [FIN]As the wheel started [N]to turn, power was [N]transmitted to the [N]Underground Castle- [JMP:&asciistring_01B988]|

asciistring_0188FC |[10]This is [03:24]the Master s [N]Emblem A- [03:20][JMP:&asciistring_01B988]|

code_01891A {
    COP [14] ( #$000F, &code_018921 ) ; {100634}
    RTL                   ; {100640}
}

code_018921 {
    COP [85] ( @chunk_000000.code_00299D ) ; {100641}
    COP [AC] ( @code_01894A, #$0000, #$0010, #$2000 ) ; {100646}
    COP [17] ( &code_018968 ) ; {100657}

  loc_018935:
    COP [81] ( #1B, #02 ) ; {100661}
    COP [83]              ; {100665}
    COP [15]              ; {100667}
    COP [81] ( #24, #04 ) ; {100669}
    COP [83]              ; {100673}
    COP [16]              ; {100675}
    COP [87]              ; {100677}
    BRL loc_018935        ; {100679}
}

code_01894A {
    COP [07] ( #$8103, &code_018965 ) ; {100682}
    COP [0D] ( #00, #34, #2C, &code_018958 ) ; {100688}
    RTL                   ; {100695}
}

code_018958 {
    COP [01] ( &asciistring_018A2B ) ; {100696}
    BRK #$5E              ; {100700}
    COP [0A] ( #38 )      ; {100702}
    COP [09] ( #$8103 )   ; {100705}
}

code_018965 {
    COP [86]              ; {100709}
    RTL                   ; {100711}
}

code_018968 {
    COP [14] ( #$0009, &code_018973 ) ; {100712}
    COP [01] ( &asciistring_018978 ) ; {100718}
    RTL                   ; {100722}
}

code_018973 {
    COP [01] ( &asciistring_0189E0 ) ; {100723}
    RTL                   ; {100727}
}

asciistring_018978 |[10]I wonder why people [N]live in such small [N]houses? [FIN]Can you believe the [N]village Chief was [N]swallowed up in [FIN]one of the paintings [N]in the house on the [N]hill? [JMP:&asciistring_01B988]|

asciistring_0189E0 |[10]I wonder why people [N]are living in such [N]small houses? [FIN]Can you believe that [N]the village Chief has [N]come back to life? [JMP:&asciistring_01B988]|

asciistring_018A2B |[10]There is [03:24]a Medical [N]Herb [03:20]at the corner of [N]the fence- [JMP:&asciistring_01B988]|

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
    TSB $0326             ; {101036}
    COP [80] ( #13 )      ; {101039}
    COP [82]              ; {101042}
    COP [80] ( #14 )      ; {101044}
    COP [82]              ; {101047}
    LDA #$AF80            ; {101049}
    TRB $0326             ; {101052}
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
    TSB $0326             ; {101163}
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
    TRB $0326             ; {101205}
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

asciistring_018BCA |[10][0E:3C]You hear some light [N]snoring coming from [N]inside the house- [JMP:&asciistring_01B988]|

asciistring_018C02 |[10][02:2] placed [N]the Dream Rod on the [N]girl s head- [JMP:&asciistring_01B988]|

asciistring_018C26 |[10]Zzzz----- [JMP:&asciistring_01B988]|

asciistring_018C34 |[10]Oh, my! Who are you? [N]Get out of my house! [JMP:&asciistring_01B988]|

asciistring_018C5C |[10]Wait! [N]I m sorry for yelling [N]at you- [FIN]Please come back and [N]listen to my story- [JMP:&asciistring_01B988]|

asciistring_018C98 |[10]I had a very strange [N]dream- It was about my[N]father and someone who[N]looked just like you- [FIN]My father told me to [N]give his paintbrush to[N]you and tell you all I[N]know- [FIN][::]The brush is all [N]I have left from my [N]father- [N]I hid it somewhere- [FIN]When you come back to [N]me with that brush, I [N]will tell you all I [N]know- [JMP:&asciistring_01B988]|

asciistring_018D5D |[10][JMP:&asciistring_018C98+M]|

asciistring_018D61 |[10]Oh! You have found my [N]father s paintbrush- I[N]will now tell you what[N]I know- [FIN]One day, as I returned[N]from shopping I [N]found a note- [FIN]Lisa pulled out the [N]note and began to [N]read- [FIN]"Lisa, I won t be able[N]to see you for a [N]while- [FIN]If you have any [N]problems, please see [N]the village Chief- [FIN]Take care of your [N]friends, [N]Turbo, the dog, [FIN]Lue, the dolphin, [FIN]Nome, the snail, [FIN]and Marie, the doll-ˮ [FIN]The animals mentioned [N]in the letter were [N]once my father s pets-[FIN]I don t understand [N]what he is trying to [N]say though- [FIN][::]I know you re a [N]complete stranger, but[N]will you please search[N]for my father? [JMP:&asciistring_01B988]|

asciistring_018F15 |[10][JMP:&asciistring_018D61+M]|

asciistring_018F19 |[10]Some believe after a [N]person dies, they will[N]return in the form of [N]a different creature- [FIN]If this is true, I [N]wonder what my mother [N]is doing now? [JMP:&asciistring_01B988]|

asciistring_018F85 |[10][0F]Lisa appears to be [N]sleeping- [N][0E:5A][02:2], placed [N]the Dream Rod upon [N]Lisa s head- [0E:78][JMP:&asciistring_01B988+M]|

asciistring_018FCD |[10][02:2], [N]promise me you will [N]return someday- [0E:B4][JMP:&asciistring_01B988+M]|

code_018FF4 {
    COP [14] ( #$0011, &code_018FFB ) ; {102388}
    RTL                   ; {102394}
}

code_018FFB {
    COP [85] ( @chunk_000000.code_00299D ) ; {102395}
    COP [17] ( &code_01900D ) ; {102400}
    COP [15]              ; {102404}

  loc_019006:
    COP [80] ( #1E )      ; {102406}
    COP [82]              ; {102409}
    BRA loc_019006        ; {102411}
}

code_01900D {
    COP [18] ( #1C, &code_019017 ) ; {102413}
    COP [01] ( &asciistring_01901C ) ; {102418}
    RTL                   ; {102422}
}

code_019017 {
    COP [01] ( &asciistring_019098 ) ; {102423}
    RTL                   ; {102427}
}

asciistring_01901C |[10]The Dream Rod you [N]possess is a magical [N]stick that enables you[N]to look into dreams- [FIN]Equip this stick when [N]you wish to speak with[N]someone who is [N]sleeping- [JMP:&asciistring_01B988]|

asciistring_019098 |[10]I have heard of a [N]strange stick that [N]enables anyone who [N]possesses it [FIN]to speak with those [N]that are asleep- It is[N]hidden in the [N]Underground Castle- [JMP:&asciistring_01B988]|

code_01910C {
    COP [14] ( #$0012, &code_019113 ) ; {102668}
    RTL                   ; {102674}
}

code_019113 {
    COP [85] ( @chunk_000000.code_00299D ) ; {102675}
    COP [17] ( &code_019121 ) ; {102680}
    COP [15]              ; {102684}
    COP [91]              ; {102686}
    RTL                   ; {102688}
}

code_019121 {
    COP [07] ( #$0107, &code_01912D ) ; {102689}
    COP [07] ( #$0003, &code_01913A ) ; {102695}
}

code_01912D {
    COP [01] ( &asciistring_01913F ) ; {102701}
    COP [09] ( #$8107 )   ; {102705}
    COP [09] ( #$8003 )   ; {102709}
    RTL                   ; {102713}
}

code_01913A {
    COP [01] ( &asciistring_01919A ) ; {102714}
    RTL                   ; {102718}
}

asciistring_01913F |[10]My name is Gaudi, I am[N]an architect- [FIN]I built all the houses[N]in this town- Come [N]back later, I will [N]show you something- [JMP:&asciistring_01B988]|

asciistring_01919A |[10]What do you think of [N]these walls? [N]I am known to be a [N]fast builder! [JMP:&asciistring_01B988]|

code_0191D2 {
    COP [3B] ( #$0016, &code_0191E8 ) ; {102866}
    COP [17] ( &code_01B191 ) ; {102872}
    SEP #$20              ; {102876}
    LDA #$^chunk_000000.code_00305F ; {102878}
    PHA                   ; {102880}
    REP #$20              ; {102881}
    LDA #$&chunk_000000.code_00305F-1 ; {102883}
    PHA                   ; {102886}
    RTL                   ; {102887}
}

code_0191E8 {
    COP [85] ( @chunk_000000.code_00299D ) ; {102888}
    COP [17] ( &code_01922C ) ; {102893}

  code_0191F1:
    COP [91]              ; {102897}
    COP [20] ( &code_019228 ) ; {102899}
    COP [9A] ( #$0000, &code_019201, &code_019228, &code_019216 ) ; {102903}
}

code_019201 {
    COP [23] ( &code_01920E ) ; {102913}
    COP [97]              ; {102917}
    COP [9D] ( #11 )      ; {102919}
    COP [9E] ( &code_01920E ) ; {102922}
}

code_01920E {
    COP [80] ( #0C )      ; {102926}
    COP [82]              ; {102929}
    BRL code_019228       ; {102931}
}

code_019216 {
    COP [24] ( &code_019223 ) ; {102934}
    COP [96]              ; {102938}
    COP [9D] ( #11 )      ; {102940}
    COP [9E] ( &code_019223 ) ; {102943}
}

code_019223 {
    COP [80] ( #0C )      ; {102947}
    COP [82]              ; {102950}
}

code_019228 {
    COP [27] ( &code_0191F1 ) ; {102952}
}

code_01922C {
    COP [18] ( #19, &code_019236 ) ; {102956}
    COP [01] ( &asciistring_01931F ) ; {102961}
    RTL                   ; {102965}
}

code_019236 {
    COP [01] ( &asciistring_019255 ) ; {102966}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_019241 ) ; {102970}
}

code_019241 {
    COP [12] ( #05, &asciistring_018480 ) ; {102977}
    COP [01] ( &asciistring_0192D9 ) ; {102982}
    COP [12] ( #05, &code_018353 ) ; {102986}
    BRK #$5E              ; {102991}
    COP [0A] ( #19 )      ; {102993}
    RTL                   ; {102996}
}

asciistring_019255 |[10]I am helping my [N]mother-Would you like [N]to buy some goat s [N]food? [FIN]Do you want to know [N]how much it costs? [FIN]Well-------- [N][0E:1E]How about one billion [N]dollars plus tax?! [END]|

asciistring_0192D9 |[10]TEDDY!! [N]I m sorry, I will give[N]it to you for free- [FIN][02:2] received [N][03:24]a bag of goat s food[03:20]!![JMP:&asciistring_01B988]|

asciistring_01931F |[10]Oh, you don t need [N]many bags of goat s [N]food, [FIN]return here after you [N]have used the one [N]I have given you- [JMP:&asciistring_01B988]|

code_019365 {
    COP [14] ( #$0018, &code_01936C ) ; {103269}
    RTL                   ; {103275}
}

code_01936C {
    COP [85] ( @chunk_000000.code_00299D ) ; {103276}
    COP [17] ( &code_01937E ) ; {103281}
    COP [15]              ; {103285}

  loc_019377:
    COP [80] ( #1E )      ; {103287}
    COP [82]              ; {103290}
    BRA loc_019377        ; {103292}
}

code_01937E {
    COP [07] ( #$8104, &code_019389 ) ; {103294}
    COP [01] ( &asciistring_01938E ) ; {103300}
    RTL                   ; {103304}
}

code_019389 {
    COP [01] ( &asciistring_0193FB ) ; {103305}
    RTL                   ; {103309}
}

asciistring_01938E |[10]I wonder who placed [N]the boundary between [N]dreams and reality? [FIN]Sometimes things that [N]happen in dreams come [N]true in reality- [JMP:&asciistring_01B988]|

asciistring_0193FB |[10]You remember Lisa s, [N]dream right? Have you [N]returned to the place [N]you saw in her dream? [FIN]Things may be [N]different from when [N]you saw her before- [JMP:&asciistring_01B988]|

code_019475 {
    COP [14] ( #$001A, &code_01947C ) ; {103541}
    RTL                   ; {103547}
}

code_01947C {
    COP [30] ( #$001A, &code_019505, #03 ) ; {103548}
    COP [AC] ( @code_0194BE, #$0000, #$0010, #$2000 ) ; {103555}
    COP [14] ( #$0009, &code_0194B5 ) ; {103566}
    COP [17] ( &code_0194FB ) ; {103572}

  loc_019498:
    COP [80] ( #03 )      ; {103576}
    COP [82]              ; {103579}
    COP [87]              ; {103581}
    COP [81] ( #05, #02 ) ; {103583}
    COP [83]              ; {103587}
    COP [80] ( #04 )      ; {103589}
    COP [82]              ; {103592}
    COP [87]              ; {103594}
    COP [81] ( #05, #02 ) ; {103596}
    COP [83]              ; {103600}
    BRL loc_019498        ; {103602}
}

code_0194B5 {
    COP [17] ( &code_019500 ) ; {103605}
    COP [15]              ; {103609}
    COP [91]              ; {103611}
    RTL                   ; {103613}
}

code_0194BE {
    COP [20] ( &code_0194C9 ) ; {103614}
    COP [0D] ( #00, #30, #04, &code_0194CE ) ; {103618}
}

code_0194C9 {
    COP [09] ( #$0006 )   ; {103625}
    RTL                   ; {103629}
}

code_0194CE {
    COP [19] ( #1D, &code_0194E1 ) ; {103630}
    COP [01] ( &asciistring_01954B ) ; {103635}
    COP [10] ( #$0103, #01, #$0078, #$03E0 ) ; {103639}
    RTL                   ; {103648}
}

code_0194E1 {
    COP [07] ( #$8006, &code_0194F5 ) ; {103649}
    COP [09] ( #$8006 )   ; {103655}
    COP [14] ( #$0009, &code_0194F6 ) ; {103659}
    COP [01] ( &asciistring_01956E ) ; {103665}
}

code_0194F5 {
    RTL                   ; {103669}
}

code_0194F6 {
    COP [01] ( &asciistring_0195A8 ) ; {103670}
    RTL                   ; {103674}
}

code_0194FB {
    COP [01] ( &asciistring_01950C ) ; {103675}
    RTL                   ; {103679}
}

code_019500 {
    COP [01] ( &asciistring_0195CB ) ; {103680}
    RTL                   ; {103684}
}

code_019505 {
    COP [01] ( &asciistring_0195FE ) ; {103685}
    COP [86]              ; {103689}
    RTL                   ; {103691}
}

asciistring_01950C |[10]This was painted by [N]Dr-Leo- A strange [N]face has appeared! [FIN]It s terrifying!! [JMP:&asciistring_01B988]|

asciistring_01954B |[10][0F][02:2] is [N]dragged into the [N]painting! [JMP:&asciistring_01B988]|

asciistring_01956E |[10][0F]There is a picture of [N]the village Chief in [N]the painting, he [N]appears to be sad- [JMP:&asciistring_01B988]|

asciistring_0195A8 |[10][0F]The painting has [N]returned to normal- [JMP:&asciistring_01B988]|

asciistring_0195CB |[10]The face of the [N]village Chief has [N]disappeared!! What was[N]that? [JMP:&asciistring_01B988]|

asciistring_0195FE |[10][0E:3C]You hear a man [N]screaming inside the [N]house- [FIN]AHHHH!! [N]A GHOST! A GHOST! [JMP:&asciistring_01B988]|

code_019644 {
    COP [14] ( #$000E, &code_01964B ) ; {104004}
    RTL                   ; {104010}
}

code_01964B {
    COP [05] ( #$0404 )   ; {104011}
    COP [80] ( #1C )      ; {104015}
    COP [82]              ; {104018}
    BRA code_01964B       ; {104020}
}

code_019656 {
    COP [14] ( #$000E, &code_01965D ) ; {104022}
    RTL                   ; {104028}
}

code_01965D {
    COP [05] ( #$0404 )   ; {104029}
    COP [80] ( #1D )      ; {104033}
    COP [82]              ; {104036}
    BRA code_01965D       ; {104038}
}

code_019668 {
    COP [14] ( #$0023, &code_01966F ) ; {104040}
    RTL                   ; {104046}
}

code_01966F {
    COP [15]              ; {104047}
    COP [17] ( &code_0196FD ) ; {104049}
    COP [91]              ; {104053}
    COP [0D] ( #00, #38, #3A, &code_01967F ) ; {104055}
    RTL                   ; {104062}
}

code_01967F {
    COP [07] ( #$8206, &code_0196F6 ) ; {104063}
    COP [01] ( &asciistring_01971A ) ; {104069}
    COP [91]              ; {104073}
    COP [14] ( #$0022, &code_019692 ) ; {104075}
    RTL                   ; {104081}
}

code_019692 {
    COP [0D] ( #00, #3C, #37, &code_01969A ) ; {104082}
    RTL                   ; {104089}
}

code_01969A {
    COP [17] ( #$0000 )   ; {104090}
    COP [16]              ; {104094}
    COP [80] ( #0F )      ; {104096}
    COP [82]              ; {104099}
    COP [9D] ( #0F )      ; {104101}
    COP [9E] ( &code_0196AC ) ; {104104}
}

code_0196AC {
    COP [80] ( #11 )      ; {104108}
    COP [82]              ; {104111}
    COP [9D] ( #11 )      ; {104113}
    COP [9E] ( &code_0196B8 ) ; {104116}
}

code_0196B8 {
    COP [81] ( #10, #02 ) ; {104120}
    COP [83]              ; {104124}
    COP [9D] ( #10 )      ; {104126}
    COP [9E] ( &code_0196C5 ) ; {104129}
}

code_0196C5 {
    COP [81] ( #11, #03 ) ; {104133}
    COP [83]              ; {104137}
    COP [9D] ( #10 )      ; {104139}
    COP [9E] ( &code_0196D2 ) ; {104142}
}

code_0196D2 {
    COP [97]              ; {104146}
    COP [80] ( #0E )      ; {104148}
    COP [82]              ; {104151}
    COP [15]              ; {104153}
    COP [17] ( &code_019706 ) ; {104155}
    COP [91]              ; {104159}
    COP [0C] ( #00, #02, &code_0196E8 ) ; {104161}
    RTL                   ; {104167}
}

code_0196E8 {
    COP [96]              ; {104168}
    COP [80] ( #0C )      ; {104170}
    COP [82]              ; {104173}
    COP [01] ( &asciistring_01975F ) ; {104175}
    COP [91]              ; {104179}
    RTL                   ; {104181}
}

code_0196F6 {
    COP [17] ( &code_01970B ) ; {104182}
    COP [91]              ; {104186}
    RTL                   ; {104188}
}

code_0196FD {
    COP [01] ( &asciistring_019728 ) ; {104189}
    COP [09] ( #$8005 )   ; {104193}
    RTL                   ; {104197}
}

code_019706 {
    COP [01] ( &asciistring_01975F ) ; {104198}
    RTL                   ; {104202}
}

code_01970B {
    COP [18] ( #1B, &code_019715 ) ; {104203}
    COP [01] ( &asciistring_019793 ) ; {104208}
    RTL                   ; {104212}
}

code_019715 {
    COP [01] ( &asciistring_0197C3 ) ; {104213}
    RTL                   ; {104217}
}

asciistring_01971A |[10]Oh! You scared me! [JMP:&asciistring_01B988]|

asciistring_019728 |[10]This is our secret [N]hut- We have hidden [N]treasure near here- [JMP:&asciistring_01B988]|

asciistring_01975F |[10]Were you following me?[N]I will not tell you [N]where our treasure is-[JMP:&asciistring_01B988]|

asciistring_019793 |[10]Oh! That s my pass! [N]Well, okay, I ll give [N]it to you- [JMP:&asciistring_01B988]|

asciistring_0197C3 |[10]Was the pass helpful? [JMP:&asciistring_01B988]|

code_0197DA {
    COP [14] ( #$0022, &code_0197E1 ) ; {104410}
    RTL                   ; {104416}
}

code_0197E1 {
    COP [85] ( @chunk_000000.code_00299D ) ; {104417}
    COP [17] ( &code_019847 ) ; {104422}
    COP [15]              ; {104426}
    COP [91]              ; {104428}
    COP [0D] ( #00, #2F, #36, &code_0197F6 ) ; {104430}
    RTL                   ; {104437}
}

code_0197F6 {
    COP [03] ( #28 )      ; {104438}
    LDA $0322             ; {104441}
    AND #$0200            ; {104444}
    BEQ loc_019843        ; {104447}
    COP [0D] ( #00, #2F, #36, &code_01980B ) ; {104449}
    BRL loc_019843        ; {104456}
}

code_01980B {
    COP [04]              ; {104459}
    COP [16]              ; {104461}
    LDA #$2F80            ; {104463}
    TSB $0326             ; {104466}
    COP [81] ( #20, #10 ) ; {104469}
    COP [83]              ; {104473}
    LDA #$2F80            ; {104475}
    TRB $0326             ; {104478}
    COP [15]              ; {104481}
    COP [07] ( #$8206, &code_019840 ) ; {104483}
    COP [91]              ; {104489}
    COP [0D] ( #00, #2E, #36, &code_019833 ) ; {104491}
    RTL                   ; {104498}
}

code_019833 {
    COP [01] ( &asciistring_01986F ) ; {104499}
    BRK #$5E              ; {104503}
    COP [0A] ( #1B )      ; {104505}
    COP [09] ( #$8206 )   ; {104508}
}

code_019840 {
    COP [91]              ; {104512}
    RTL                   ; {104514}

  loc_019843:
    COP [27] ( &code_0197F6 ) ; {104515}
}

code_019847 {
    COP [19] ( #1C, &code_01985D ) ; {104519}
    COP [01] ( &asciistring_019880 ) ; {104524}
    COP [3C] ( #04 )      ; {104528}
    COP [10] ( #$0403, #00, #$0078, #$0070 ) ; {104531}
    RTL                   ; {104540}
}

code_01985D {
    COP [01] ( &asciistring_019862 ) ; {104541}
    RTL                   ; {104545}
}

asciistring_019862 |[10]Zzzz---- [JMP:&asciistring_01B988]|

asciistring_01986F |[10]There is [03:24]a pass- [03:20][JMP:&asciistring_01B988]|

asciistring_019880 |[10][02:2] placed [N]the Dream Rod on the [N]tulip s petal- [JMP:&asciistring_01B988]|

code_0198A6 {
    COP [14] ( #$0025, &code_0198AD ) ; {104614}
    RTL                   ; {104620}
}

code_0198AD {
    COP [85] ( @chunk_000000.code_00299D ) ; {104621}
    COP [17] ( &code_01991A ) ; {104626}
    COP [91]              ; {104630}
    COP [07] ( #$0201, &code_0198C8 ) ; {104632}
    COP [11] ( #14, #2C, #13 ) ; {104638}
    COP [15]              ; {104643}
    BRL loc_0198F7        ; {104645}
}

code_0198C8 {
    COP [15]              ; {104648}
    COP [05] ( #$0200 )   ; {104650}
    COP [17] ( &code_019930 ) ; {104654}
    COP [91]              ; {104658}
    COP [0C] ( #00, #02, &code_0198DD ) ; {104660}
    BRL loc_0198DE        ; {104666}
}

code_0198DD {
    RTL                   ; {104669}

  loc_0198DE:
    COP [16]              ; {104670}
    COP [80] ( #0F )      ; {104672}
    COP [82]              ; {104675}
    COP [80] ( #11 )      ; {104677}
    COP [82]              ; {104680}
    COP [87]              ; {104682}
    COP [80] ( #0E )      ; {104684}
    COP [82]              ; {104687}
    COP [15]              ; {104689}
    COP [09] ( #$8201 )   ; {104691}

  loc_0198F7:
    COP [17] ( &code_019935 ) ; {104695}
    COP [91]              ; {104699}
    COP [0D] ( #00, #28, #0B, &code_019905 ) ; {104701}
    RTL                   ; {104708}
}

code_019905 {
    COP [07] ( #$0904, &code_01990C ) ; {104709}
    RTL                   ; {104715}
}

code_01990C {
    COP [01] ( &asciistring_0199DC ) ; {104716}
    BRK #$5E              ; {104720}
    COP [0A] ( #39 )      ; {104722}
    COP [09] ( #$8904 )   ; {104725}
    RTL                   ; {104729}
}

code_01991A {
    COP [19] ( #1B, &code_01992B ) ; {104730}
    COP [09] ( #$8200 )   ; {104735}
    COP [01] ( &asciistring_01997B ) ; {104739}
    COP [0B] ( #1B )      ; {104743}
    RTL                   ; {104746}
}

code_01992B {
    COP [01] ( &asciistring_01993A ) ; {104747}
    RTL                   ; {104751}
}

code_019930 {
    COP [01] ( &asciistring_0199AE ) ; {104752}
    RTL                   ; {104756}
}

code_019935 {
    COP [01] ( &asciistring_0199F1 ) ; {104757}
    RTL                   ; {104761}
}

asciistring_01993A |[10]This is our secret [N]passage- I cannot let [N]you through without [N]a pass- [JMP:&asciistring_01B988]|

asciistring_01997B |[10]Oh, the pass! Where [N]did you find it? [N]You can go inside now-[JMP:&asciistring_01B988]|

asciistring_0199AE |[10]Would you please move [N]over a little so I can[N]let you pass? [JMP:&asciistring_01B988]|

asciistring_0199DC |[10]There is [03:24]a strange [N]bottle- [03:20][JMP:&asciistring_01B988]|

asciistring_0199F1 |[10]I am tired of playing [N]hide and seek- I must [N]find something else to[N]do- [JMP:&asciistring_01B988]|

code_019A2C {
    COP [14] ( #$001D, &code_019A33 ) ; {105004}
    RTL                   ; {105010}
}

code_019A33 {
    COP [85] ( @chunk_000000.code_00299D ) ; {105011}
    COP [07] ( #$0102, &code_019A46 ) ; {105016}
    COP [11] ( #15, #32, #2A ) ; {105022}
    BRL loc_019AD6        ; {105027}
}

code_019A46 {
    COP [17] ( &code_019AE4 ) ; {105030}
    COP [15]              ; {105034}
    COP [91]              ; {105036}
    RTL                   ; {105038}
}

code_019A4F {
    COP [16]              ; {105039}
    COP [17] ( &code_019B05 ) ; {105041}
    COP [81] ( #1B, #02 ) ; {105045}
    COP [83]              ; {105049}
    COP [9F] ( #$0008 )   ; {105051}
    COP [81] ( #1A, #03 ) ; {105055}
    COP [83]              ; {105059}
    COP [9F] ( #$FFF8 )   ; {105061}
    COP [81] ( #1B, #02 ) ; {105065}
    COP [83]              ; {105069}
    COP [9F] ( #$0008 )   ; {105071}
    COP [81] ( #1A, #02 ) ; {105075}
    COP [83]              ; {105079}
    COP [87]              ; {105081}
    COP [9F] ( #$FFF8 )   ; {105083}
    COP [80] ( #18 )      ; {105087}
    COP [82]              ; {105090}
    COP [17] ( &code_019AEC ) ; {105092}
    COP [15]              ; {105096}
    COP [91]              ; {105098}
    RTL                   ; {105100}
}

code_019A8D {
    COP [16]              ; {105101}
    COP [17] ( &code_019B05 ) ; {105103}
    COP [81] ( #1A, #04 ) ; {105107}
    COP [83]              ; {105111}
    COP [9F] ( #$FFF8 )   ; {105113}
    COP [81] ( #1B, #03 ) ; {105117}
    COP [83]              ; {105121}
    COP [9F] ( #$0008 )   ; {105123}
    COP [80] ( #1A )      ; {105127}
    COP [82]              ; {105130}
    COP [17] ( &code_019AF4 ) ; {105132}
    COP [15]              ; {105136}
    COP [91]              ; {105138}
    RTL                   ; {105140}
}

code_019AB5 {
    COP [16]              ; {105141}
    COP [17] ( &code_019B05 ) ; {105143}
    COP [87]              ; {105147}
    COP [9F] ( #$0008 )   ; {105149}
    COP [81] ( #1B, #04 ) ; {105153}
    COP [83]              ; {105157}
    COP [9F] ( #$0008 )   ; {105159}
    COP [81] ( #19, #0A ) ; {105163}
    COP [83]              ; {105167}
    COP [80] ( #18 )      ; {105169}
    COP [82]              ; {105172}

  loc_019AD6:
    COP [15]              ; {105174}
    COP [17] ( &code_019AFC ) ; {105176}
    COP [91]              ; {105180}
    COP [80] ( #24 )      ; {105182}
    COP [82]              ; {105185}
    RTL                   ; {105187}
}

code_019AE4 {
    COP [01] ( &asciistring_019B0A ) ; {105188}
    COP [27] ( &code_019A4F ) ; {105192}
}

code_019AEC {
    COP [01] ( &asciistring_019B52 ) ; {105196}
    COP [27] ( &code_019A8D ) ; {105200}
}

code_019AF4 {
    COP [01] ( &asciistring_019BF2 ) ; {105204}
    COP [27] ( &code_019AB5 ) ; {105208}
}

code_019AFC {
    COP [01] ( &asciistring_019C56 ) ; {105212}
    COP [09] ( #$8102 )   ; {105216}
    RTL                   ; {105220}
}

code_019B05 {
    COP [01] ( &asciistring_019CC1 ) ; {105221}
    RTL                   ; {105225}
}

asciistring_019B0A |[10]You are the one who [N]set me free, right? [FIN]Come, I shall show you[N]around- Please follow [N]me- [JMP:&asciistring_01B988]|

asciistring_019B52 |[10]This is the home of [N]Dr-Leo the inventor [N]and his daughter, [N]Lisa- [FIN]Dr-Leo was a great [N]painter as well as an [N]inventor- [FIN]One day, many soldiers[N]came and took Dr-Leo [N]away- Lisa has not [N]been the same since- [JMP:&asciistring_01B988]|

asciistring_019BF2 |[10]The house at the top [N]of this cliff contains[N]a painting by Dr-Leo-[FIN]I think the title of [N]the painting is [N]something like [N]"The World of Evil-ˮ [JMP:&asciistring_01B988]|

asciistring_019C56 |[10]This is a house people[N]constructed for the [N]goats- I am not [N]terribly fond of it- [FIN]I did see something on[N]the ground near the [N]corner of the fence- [JMP:&asciistring_01B988]|

asciistring_019CC1 |[10]This is all I will [N]tell you- Please [N]follow me- [JMP:&asciistring_01B988]|

code_019CDE {
    COP [14] ( #$0015, &code_019CE5 ) ; {105694}
    RTL                   ; {105700}
}

code_019CE5 {
    COP [85] ( @chunk_000000.code_00299D ) ; {105701}
    COP [17] ( &code_019D3B ) ; {105706}
    COP [15]              ; {105710}
    COP [05] ( #$0205 )   ; {105712}
    COP [17] ( &code_019D69 ) ; {105716}
    COP [16]              ; {105720}
    COP [9F] ( #$0008 )   ; {105722}
    COP [81] ( #19, #02 ) ; {105726}
    COP [83]              ; {105730}
    COP [9F] ( #$FFF8 )   ; {105732}
    COP [87]              ; {105736}
    COP [81] ( #1B, #04 ) ; {105738}
    COP [83]              ; {105742}
    COP [9F] ( #$0008 )   ; {105744}
    COP [81] ( #1A, #05 ) ; {105748}
    COP [83]              ; {105752}
    COP [87]              ; {105754}
    COP [9F] ( #$FFF8 )   ; {105756}
    COP [81] ( #1B, #0E ) ; {105760}
    COP [83]              ; {105764}
    COP [9F] ( #$0010 )   ; {105766}
    COP [81] ( #1A, #04 ) ; {105770}
    COP [83]              ; {105774}
    COP [17] ( &code_019D6E ) ; {105776}
    COP [09] ( #$0205 )   ; {105780}
    COP [91]              ; {105784}
    RTL                   ; {105786}
}

code_019D3B {
    COP [18] ( #19, &code_019D64 ) ; {105787}
    COP [01] ( &asciistring_019DCA ) ; {105792}

  loc_019D44:
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_019D51 ) ; {105796}
    LDA $0003D0           ; {105803}
    BEQ loc_019D58        ; {105807}
}

code_019D51 {
    COP [01] ( &asciistring_019EB1 ) ; {105809}
    BRL loc_019D44        ; {105813}

  loc_019D58:
    COP [01] ( &asciistring_019E0E ) ; {105816}
    COP [0B] ( #19 )      ; {105820}
    COP [09] ( #$8205 )   ; {105823}
    RTL                   ; {105827}
}

code_019D64 {
    COP [01] ( &asciistring_019D73 ) ; {105828}
    RTL                   ; {105832}
}

code_019D69 {
    COP [01] ( &asciistring_019EC5 ) ; {105833}
    RTL                   ; {105837}
}

code_019D6E {
    COP [01] ( &asciistring_019EE2 ) ; {105838}
    RTL                   ; {105842}
}

asciistring_019D73 |[10]I am known among my [N]friends as something [N]of a Gourmet Goat- [FIN]I will only eat food [N]sold at the tool shop- [JMP:&asciistring_01B988]|

asciistring_019DCA |[10]Oh! You have some food[N]from the tool shop! [FIN]I promise to tell you [N]a secret if you will [N]give me the food- [END]|

asciistring_019E0E |Thank you! I will [N]tell you a secret- [FIN]If you wish to get [N]inside the painting, [N]you must equip an item[N]which [FIN]used to belong to the [N]painter and touch the [N]painting- [FIN]Well, I have other [N]things to attend to so[N]I will see you later! [JMP:&asciistring_01B988]|

asciistring_019EB1 |Oh come on!, [N]Please!! [END]|

asciistring_019EC5 |[10]I love food from the [N]tool shop! [JMP:&asciistring_01B988]|

asciistring_019EE2 |[10]Hey, give me my food! [JMP:&asciistring_01B988]|

code_019EF4 {
    COP [14] ( #$0028, &code_019EFB ) ; {106228}
    RTL                   ; {106234}
}

code_019EFB {
    COP [17] ( &code_019F04 ) ; {106235}
    COP [15]              ; {106239}
    COP [91]              ; {106241}
    RTL                   ; {106243}
}

code_019F04 {
    COP [01] ( &asciistring_019F09 ) ; {106244}
    RTL                   ; {106248}
}

asciistring_019F09 |[10]Since losing my wife [N]to an illness, I [N]noticed a goat hanging[N]around my place- [FIN]I was so lonely [N]I decided to keep the [N]goat as a pet- [JMP:&asciistring_01B988]|

code_019F7A {
    COP [14] ( #$002F, &code_019F81 ) ; {106362}
    RTL                   ; {106368}
}

code_019F81 {
    COP [85] ( @chunk_000000.code_00299D ) ; {106369}
    COP [17] ( &code_019F94 ) ; {106374}
    COP [15]              ; {106378}
    COP [91]              ; {106380}
    COP [80] ( #24 )      ; {106382}
    COP [82]              ; {106385}
    RTL                   ; {106387}
}

code_019F94 {
    COP [01] ( &asciistring_019F99 ) ; {106388}
    RTL                   ; {106392}
}

asciistring_019F99 |[10]I don t know if there [N]is such a thing as [N]reincarnation- [FIN]Even though I can t [N]communicate with my [N]husband, I enjoy his [N]company- [JMP:&asciistring_01B988]|

code_01A004 {
    COP [14] ( #$002E, &code_01A00B ) ; {106500}
    RTL                   ; {106506}
}

code_01A00B {
    COP [85] ( @chunk_000000.code_00299D ) ; {106507}
    COP [17] ( &code_01A01D ) ; {106512}
    COP [15]              ; {106516}

  loc_01A016:
    COP [80] ( #1E )      ; {106518}
    COP [82]              ; {106521}
    BRA loc_01A016        ; {106523}
}

code_01A01D {
    COP [01] ( &asciistring_01A022 ) ; {106525}
    RTL                   ; {106529}
}

asciistring_01A022 |[10]Be sure to check [N]underneath all of the [N]tulip s- [FIN]A boy may have hidden [N]something under one- [FIN]He thought that no one[N]was watching, but I [N]saw him! [JMP:&asciistring_01B988]|

code_01A098 {
    COP [14] ( #$0009, &code_01A09F ) ; {106648}
    RTL                   ; {106654}
}

code_01A09F {
    COP [30] ( #$0009, &code_01A139, #03 ) ; {106655}
    COP [11] ( #01, #04, #08 ) ; {106662}
    COP [85] ( @chunk_000000.code_00299D ) ; {106667}
    COP [17] ( &code_01A11F ) ; {106672}
    COP [15]              ; {106676}
    COP [91]              ; {106678}
    COP [07] ( #$9B00, &code_01A0C5 ) ; {106680}
    COP [18] ( #3A, &code_01A0C5 ) ; {106686}
    BRA loc_01A0C6        ; {106691}
}

code_01A0C5 {
    RTL                   ; {106693}

  loc_01A0C6:
    LDA #$2F80            ; {106694}
    TSB $0326             ; {106697}
    COP [17] ( #$0000 )   ; {106700}
    COP [31] ( #00 )      ; {106704}
    COP [85] ( @code_01A105 ) ; {106707}
    COP [03] ( #F1 )      ; {106712}
    COP [04]              ; {106715}
    COP [01] ( &asciistring_01A2C4 ) ; {106717}
    COP [09] ( #$9B00 )   ; {106721}
    LDA #$2F80            ; {106725}
    TSB $0326             ; {106728}
    COP [85] ( @code_01A112 ) ; {106731}
    COP [32] ( #02 )      ; {106736}
    COP [03] ( #3D )      ; {106739}
    COP [04]              ; {106742}
    LDA #$2F80            ; {106744}
    TRB $0326             ; {106747}
    COP [17] ( &code_01A11F ) ; {106750}
    COP [91]              ; {106754}
    RTL                   ; {106756}
}

code_01A105 {
    COP [A8] ( #$8000, #0D ) ; {106757}
    COP [92] ( #45 )      ; {106762}
    COP [94]              ; {106765}
    COP [86]              ; {106767}
    RTL                   ; {106769}
}

code_01A112 {
    COP [A8] ( #$8000, #0D ) ; {106770}
    COP [92] ( #46 )      ; {106775}
    COP [94]              ; {106778}
    COP [86]              ; {106780}
    RTL                   ; {106782}
}

code_01A11F {
    COP [07] ( #$9B00, &code_01A12A ) ; {106783}
    COP [18] ( #3A, &code_01A12F ) ; {106789}
}

code_01A12A {
    COP [01] ( &asciistring_01A272 ) ; {106794}
    RTL                   ; {106798}
}

code_01A12F {
    COP [01] ( &asciistring_01A191 ) ; {106799}
    BRK #$5E              ; {106803}
    COP [0A] ( #3A )      ; {106805}
    RTL                   ; {106808}
}

code_01A139 {
    COP [01] ( &asciistring_01A142 ) ; {106809}
    COP [37]              ; {106813}
    COP [86]              ; {106815}
    RTL                   ; {106817}
}

asciistring_01A142 |[10][0E:3C]Welcome to my room- [N]I finally feel like [N]myself again- [FIN]I have something to [N]tell you- [N]Please come back to [N]my house- [JMP:&asciistring_01B988]|

asciistring_01A191 |[10]I feel as though I [N]have been surrounded [N]by darkness- [FIN]In that darkness I [N]heard my best friend [N]Leo- [FIN]He told me to give [N]this Brown Stone to a [N]person named [02:2]-[FIN]I don t know what the [N]Brown Stone looks like[N]but this is a stone [FIN]that I received from [N]him the day before he [N]disappeared- [FIN][02:2], received [N][03:24]the Brown Stone- [03:20][JMP:&asciistring_01B988]|

asciistring_01A272 |[10]Dr-Leo has only a [N]daughter named Lisa- [FIN]I will ask my wife to [N]look after her until [N]Dr-Leo returns- [JMP:&asciistring_01B988]|

asciistring_01A2C4 |[10]Suddenly the Master s [N]voice came thundering [N]down from the heavens-[FIN]"The Brown Stone you [N]have is a key to open [N]the World of Evil- [FIN]This is where [N]Deathtoll lives! [FIN]Come back to me with [N]the stone-ˮ [JMP:&asciistring_01B988]|

code_01A34B {
    COP [15]              ; {107339}
    COP [17] ( &code_01A362 ) ; {107341}
    COP [91]              ; {107345}
    COP [14] ( #$0009, &code_01A35F ) ; {107347}
    COP [80] ( #23 )      ; {107353}
    COP [82]              ; {107356}
    RTL                   ; {107358}
}

code_01A35F {
    COP [86]              ; {107359}
    RTL                   ; {107361}
}

code_01A362 {
    COP [01] ( &asciistring_01A367 ) ; {107362}
    RTL                   ; {107366}
}

asciistring_01A367 |[10]This is the room of [N]the village Chief- He [N]used to sit and rock [N]here for hours- [FIN]I wonder when he is [N]going to come back? [JMP:&asciistring_01B988]|

code_01A3B0 {
    COP [14] ( #$0022, &code_01A3B7 ) ; {107440}
    RTL                   ; {107446}
}

code_01A3B7 {
    COP [17] ( &code_01A3D5 ) ; {107447}
    COP [15]              ; {107451}

  loc_01A3BD:
    COP [80] ( #1E )      ; {107453}
    COP [82]              ; {107456}
    BRL loc_01A3BD        ; {107458}

  code_01A3C5:
    COP [AC] ( @code_01AD42, #$0070, #$0080, #$0050 ) ; {107461}
    BRK #$1C              ; {107472}
    BRL loc_01A3BD        ; {107474}
}

code_01A3D5 {
    COP [01] ( &asciistring_01A3E6 ) ; {107477}
    COP [17] ( &code_01A3E1 ) ; {107481}
    COP [27] ( &code_01A3C5 ) ; {107485}
}

code_01A3E1 {
    COP [01] ( &asciistring_01A420 ) ; {107489}
    RTL                   ; {107493}
}

asciistring_01A3E6 |[10]In my dreams I can [N]do anything I like-[N]For example---- [FIN]HA! [JMP:&asciistring_01B988]|

asciistring_01A420 |[10]Why don t you try and [N]talk to the jewelry? [JMP:&asciistring_01B988]|

code_01A440 {
    COP [14] ( #$0010, &code_01A447 ) ; {107584}
    RTL                   ; {107590}
}

code_01A447 {
    COP [07] ( #$9F02, &code_01A491 ) ; {107591}
    COP [17] ( &code_01A4DF ) ; {107597}
    COP [15]              ; {107601}
    COP [91]              ; {107603}
    COP [14] ( #$0032, &code_01A45C ) ; {107605}
    RTL                   ; {107611}
}

code_01A45C {
    COP [01] ( &asciistring_01A521 ) ; {107612}
    LDA #$2F80            ; {107616}
    TSB $0326             ; {107619}
    COP [81] ( #21, #02 ) ; {107622}
    COP [83]              ; {107626}
    COP [80] ( #22 )      ; {107628}
    COP [82]              ; {107631}
    LDA #$2F80            ; {107633}
    TRB $0326             ; {107636}
    COP [01] ( &asciistring_01A59F ) ; {107639}
    COP [17] ( &code_01A4E4 ) ; {107643}
    COP [91]              ; {107647}
    COP [0D] ( #00, #12, #35, &code_01A489 ) ; {107649}
    RTL                   ; {107656}
}

code_01A489 {
    COP [80] ( #1F )      ; {107657}
    COP [82]              ; {107660}
    COP [91]              ; {107662}
    RTL                   ; {107664}
}

code_01A491 {
    LDA #$BFC0            ; {107665}
    TSB $0326             ; {107668}
    COP [9F] ( #$0018 )   ; {107671}
    COP [03] ( #29 )      ; {107675}
    COP [04]              ; {107678}
    COP [01] ( &asciistring_01A604 ) ; {107680}
    LDA #$BFC0            ; {107684}
    TRB $0326             ; {107687}
    COP [1A] ( &chunk_010000.asciistring_014F15, #01, &code_01A4B1 ) ; {107690}
}

code_01A4B1 {
    LDA #$BFC0            ; {107697}
    TSB $0326             ; {107700}
    COP [01] ( &asciistring_01A77E ) ; {107703}
    COP [03] ( #B5 )      ; {107707}
    COP [04]              ; {107710}
    COP [09] ( #$9F01 )   ; {107712}
    LDA #$0003            ; {107716}
    STA $031E             ; {107719}
    COP [3C] ( #04 )      ; {107722}
    COP [10] ( #$0101, #01, #$03B0, #$01D8 ) ; {107725}
    LDA #$BFC0            ; {107734}
    TRB $0326             ; {107737}
    COP [91]              ; {107740}
    RTL                   ; {107742}
}

code_01A4DF {
    COP [01] ( &asciistring_01A50A ) ; {107743}
    RTL                   ; {107747}
}

code_01A4E4 {
    COP [01] ( &asciistring_01A5E9 ) ; {107748}
    COP [09] ( #$8104 )   ; {107752}
    COP [3C] ( #04 )      ; {107756}
    COP [10] ( #$0101, #03, #$03B0, #$01E0 ) ; {107759}
    RTL                   ; {107768}
}
---------------------------------------------

asciistring_01A4F9 |[10]I am dreaming- [N][JMP:&asciistring_01B988]|

asciistring_01A50A |[10]Daddy, where are you?![JMP:&asciistring_01B988]|

asciistring_01A521 |[10]A voice, full of [N]sadness, came from [N]somewhere- [FIN]"Lisa, you must tell [N]everything that you [N]know to the person in [N]front of you- [FIN]They will also need my[N]paintbrush to continue[N]on-ˮ [JMP:&asciistring_01B988]|

asciistring_01A59F |[10]Daddy! Is that you? [FIN]Where are you daddy?! [N]I miss you so [N]much----- [FIN][0F]There was no answer- [JMP:&asciistring_01B988]|

asciistring_01A5E9 |[10]Who are you? [N]Why am I here? [JMP:&asciistring_01B988]|

asciistring_01A604 |[10][0F][02:2], [N][0E:3C]I thought I would meet[N]you here- [N][0E:78]I am all alone- [N][0E:1E]I know that as time [N]passes I will stop [N]feeling lonely- [N][0E:5A]My father used to tell[N]me the key to [N]happiness lies in [N]patience not in haste-[N][0E:5A]I don t know whether [N]you are an angel or [N]human, but I must ask [N]you to do me a favor- [N][0E:5A]I will not ask you to [N]stay with me, [N][0E:5A]only promise me you [N]will return someday- [N][0E:5A]You could tell me a [N]lie, [0E:1E]but I feel our [N]promise will give me [N]hope for the future- [N][0E:5A]Please! [0E:28]Please promise[N]me that you will one [N]day return- [END]|

asciistring_01A77E |[0F]Thank you- [N][0E:5A]I wish this dream [N]would never end- [0E:78][JMP:&asciistring_01B988+M]|

code_01A7AC {
    COP [14] ( #$0000, &code_01A7B3 ) ; {108460}
    RTL                   ; {108466}
}

code_01A7B3 {
    COP [9F] ( #$0008 )   ; {108467}
    COP [85] ( @chunk_000000.code_00299D ) ; {108471}
    COP [17] ( &code_01A7DC ) ; {108476}
    COP [15]              ; {108480}
    COP [2A] ( #$0010, #$0000 ) ; {108482}
    COP [05] ( #$0504 )   ; {108488}
    COP [16]              ; {108492}
    COP [2B] ( #$0010, #$0000 ) ; {108494}
    COP [85] ( @chunk_000000.code_00299D ) ; {108500}
    COP [86]              ; {108505}
    RTL                   ; {108507}
}

code_01A7DC {
    COP [01] ( &asciistring_01A7F9 ) ; {108508}
    BRK #$5E              ; {108512}
    COP [0A] ( #11 )      ; {108514}
    COP [01] ( &asciistring_01A913 ) ; {108517}
    SEP #$20              ; {108521}
    LDA #$01              ; {108523}
    STA $1B82             ; {108525}
    REP #$20              ; {108528}
    COP [09] ( #$8504 )   ; {108530}
    BRK #$0E              ; {108534}
    RTL                   ; {108536}
}

asciistring_01A7F9 |[10]I used to live up [N]in the sky just like [N]you- [FIN]Now, I am living on [N]Earth, away from the [N]Master- [FIN]All the creatures that[N]have been captured by [N]Deathtoll are sealed [N]away in monster lairs-[FIN]Just as you have set [N]me free, you must free[N]everyone- [FIN]Even the release of a [N]small tree or [N]creature, they will [N]aid you in your quest-[FIN]Here, take this- [FIN][02:2] received [N][03:24]the Flame Ball Magic- [03:20][FIN][END]|

asciistring_01A913 |[10]Now I will join you- I[N]am a magician so I can[N]use all types magic- [FIN]I will use my skill to[N]help you- [FIN]Remember this, I need [N]GEMs in order to use [N]magic- [FIN]When you set me free, [N]the monsters left some[N]small spheres of gold-[FIN]This is what a GEM [N]looks like- Alright, [N]let s work together to[N]revive the world! [FIN]We must go to the [N]Grass Valley Shrine- [JMP:&asciistring_01B988]|

code_01AA26 {
    COP [07] ( #$8905, &code_01AA33 ) ; {109094}
    COP [B0] ( @code_01AA4C, #$2000 ) ; {109100}
}

code_01AA33 {
    COP [15]              ; {109107}
    COP [14] ( #$0009, &code_01AA41 ) ; {109109}
    COP [17] ( &code_01AA60 ) ; {109115}
    BRA loc_01AA45        ; {109119}
}

code_01AA41 {
    COP [17] ( &code_01AA65 ) ; {109121}

  loc_01AA45:
    COP [80] ( #1E )      ; {109125}
    COP [82]              ; {109128}
    BRA loc_01AA45        ; {109130}
}

code_01AA4C {
    COP [91]              ; {109132}
    COP [0C] ( #00, #02, &code_01AA55 ) ; {109134}
    RTL                   ; {109140}
}

code_01AA55 {
    COP [01] ( &asciistring_01AAC9 ) ; {109141}
    COP [09] ( #$8905 )   ; {109145}
    COP [86]              ; {109149}
    RTL                   ; {109151}
}

code_01AA60 {
    COP [01] ( &asciistring_01AA6A ) ; {109152}
    RTL                   ; {109156}
}

code_01AA65 {
    COP [01] ( &asciistring_01AAE6 ) ; {109157}
    RTL                   ; {109161}
}

asciistring_01AA6A |[10][::]There are many [N]creatures being held [N]in the Underground [N]Castle- [FIN]If you can release [N]those creatures, [N]the village will be [N]reconstructed- [JMP:&asciistring_01B988]|

asciistring_01AAC9 |[10][02:2] heard a [N]small voice- [FIN][JMP:&asciistring_01AA6A+M]|

asciistring_01AAE6 |[10]Thank you for saving [N]the villagers- [FIN]They are now taking [N]care of me- [FIN]No creature likes to [N]live alone- We have to[N]help each other- [JMP:&asciistring_01B988]|

code_01AB4F {
    COP [14] ( #$002C, &code_01AB56 ) ; {109391}
    RTL                   ; {109397}
}

code_01AB56 {
    JSL $@code_01B161     ; {109398}
    COP [17] ( &code_01AB6A ) ; {109402}
    SEP #$20              ; {109406}
    LDA #$^code_01B17C    ; {109408}
    PHA                   ; {109410}
    REP #$20              ; {109411}
    LDA #$&code_01B17C-1  ; {109413}
    PHA                   ; {109416}
    RTL                   ; {109417}
}

code_01AB6A {
    COP [07] ( #$9C00, &code_01AB7E ) ; {109418}
    COP [01] ( &asciistring_01AB83 ) ; {109424}
    BRK #$5E              ; {109428}
    COP [0A] ( #07 )      ; {109430}
    COP [09] ( #$9C00 )   ; {109433}
    RTL                   ; {109437}
}

code_01AB7E {
    COP [01] ( &asciistring_01ABE0 ) ; {109438}
    RTL                   ; {109442}
}

asciistring_01AB83 |[10]I am watching over [N]this world- Please [N]take this sword- [FIN][02:2] received [N][03:24]the Recover Sword- [03:20][JMP:&asciistring_01B988]|

asciistring_01ABB9 |[10]I am watching over the[N]world- [N]Please take this- [FIN][::][02:2] received [N]EXP! [JMP:&asciistring_01B988]|

asciistring_01ABE0 |[10]Alright, continue on- [N]Good luck! [JMP:&asciistring_01B988]|

code_01AC06 {
    JSL $@code_01B161     ; {109574}
    COP [17] ( &code_01AC1A ) ; {109578}
    SEP #$20              ; {109582}
    LDA #$^code_01B17C    ; {109584}
    PHA                   ; {109586}
    REP #$20              ; {109587}
    LDA #$&code_01B17C-1  ; {109589}
    PHA                   ; {109592}
    RTL                   ; {109593}
}

code_01AC1A {
    COP [07] ( #$9C01, &code_01AC2D ) ; {109594}
    COP [01] ( &asciistring_01ABB9 ) ; {109600}
    COP [38] ( #$0080 )   ; {109604}
    COP [09] ( #$9C01 )   ; {109608}
    RTL                   ; {109612}
}

code_01AC2D {
    COP [01] ( &asciistring_01ABE0 ) ; {109613}
    RTL                   ; {109617}
}

code_01AC32 {
    JSL $@code_01B161     ; {109618}
    COP [17] ( &code_01AD09 ) ; {109622}

  loc_01AC3A:
    COP [14] ( #$0004, &code_01AC47 ) ; {109626}
    COP [80] ( #07 )      ; {109632}
    COP [82]              ; {109635}
    BRA loc_01AC3A        ; {109637}
}

code_01AC47 {
    COP [07] ( #$8505, &code_01AC5E ) ; {109639}
    COP [09] ( #$8505 )   ; {109645}
    LDA $0016, X          ; {109649}
    AND #$FFEF            ; {109652}
    STA $0016, X          ; {109655}
    COP [01] ( &asciistring_01AC73 ) ; {109658}
}

code_01AC5E {
    LDA $0016, X          ; {109662}
    ORA #$0010            ; {109665}
    STA $0016, X          ; {109668}
    SEP #$20              ; {109671}
    LDA #$^code_01B17C    ; {109673}
    PHA                   ; {109675}
    REP #$20              ; {109676}
    LDA #$&code_01B17C-1  ; {109678}
    PHA                   ; {109681}
    RTL                   ; {109682}
}

asciistring_01AC73 |[10][02:2] heard a [N]faint voice coming [N]from the jewel in the [N]< corner- [FIN]Allright, come over [N]here- [JMP:&asciistring_01B988]|

asciistring_01ACBA |[10]I will give you some [N]advice- [FIN]Don t forget to equip [N]the things that you [N]wish to use or they [N]will not work- [FIN][JMP:&asciistring_01ABB9+M]|

code_01AD09 {
    COP [07] ( #$9C02, &code_01AD1B ) ; {109833}
    COP [01] ( &asciistring_01ACBA ) ; {109839}
    COP [38] ( #$0030 )   ; {109843}
    COP [09] ( #$9C02 )   ; {109847}
}

code_01AD1B {
    COP [01] ( &asciistring_01B2D2 ) ; {109851}
    COP [1A] ( &chunk_010000.asciistring_014F5B, #02, &code_01AD3D ) ; {109855}
    LDA $0003D0           ; {109862}
    BEQ code_01AD3D       ; {109866}
    COP [01] ( &asciistring_01B2F5 ) ; {109868}
    INC $042D             ; {109872}
    COP [10] ( #$0101, #00, #$0138, #$03A0 ) ; {109875}
    RTL                   ; {109884}
}

code_01AD3D {
    COP [01] ( &asciistring_01B30E ) ; {109885}
    RTL                   ; {109889}
}

code_01AD42 {
    JSL $@code_01B161     ; {109890}
    COP [17] ( &code_01AD56 ) ; {109894}
    SEP #$20              ; {109898}
    LDA #$^code_01B17C    ; {109900}
    PHA                   ; {109902}
    REP #$20              ; {109903}
    LDA #$&code_01B17C-1  ; {109905}
    PHA                   ; {109908}
    RTL                   ; {109909}
}

code_01AD56 {
    COP [01] ( &asciistring_01AD5D ) ; {109910}
    BRL code_01AD1B       ; {109914}
}

asciistring_01AD5D |[10]The monsters running [N]all over in Dr-Leo s [N]paintings [FIN]cannot be defeated [N]unless you have a [N]special sword- [FIN]You must find the [N]special sword that can[N]destroy metal- [FIN]Return here once you [N]have found the sword- [FIN][END]|

code_01ADF8 {
    JSL $@code_01B161     ; {110072}
    COP [17] ( &code_01AE0C ) ; {110076}
    SEP #$20              ; {110080}
    LDA #$^code_01B17C    ; {110082}
    PHA                   ; {110084}
    REP #$20              ; {110085}
    LDA #$&code_01B17C-1  ; {110087}
    PHA                   ; {110090}
    RTL                   ; {110091}
}

code_01AE0C {
    COP [01] ( &asciistring_01AE13 ) ; {110092}
    BRL code_01AD1B       ; {110096}
}

asciistring_01AE13 |[10]This is the heart [N]of the Underground [N]Castle- [FIN]You may meet many [N]monsters that cannot [N]be defeated with that [N]sword- [FIN]You will be able to [N]save those creatures [N]once you return with [N]the correct sword- [FIN][END]|

code_01AE99 {
    COP [A0] ( #$0002 )   ; {110233}

  loc_01AE9D:
    COP [91]              ; {110237}
    COP [07] ( #$8404, &code_01AEAD ) ; {110239}
    COP [0D] ( #00, #47, #38, &code_01AEFA ) ; {110245}
    RTL                   ; {110252}
}

code_01AEAD {
    LDY $039C             ; {110253}
    LDA $0000, Y          ; {110256}
    CMP #$04B0            ; {110259}
    BCC code_01AEC0       ; {110262}
    COP [A0] ( #$FFB0 )   ; {110264}
    COP [27] ( &code_01AEDD ) ; {110268}

  code_01AEC0:
    COP [91]              ; {110272}
    COP [0D] ( #00, #47, #38, &code_01AECA ) ; {110274}
    RTL                   ; {110281}
}

code_01AECA {
    LDA $0322             ; {110282}
    AND #$0800            ; {110285}
    BNE loc_01AED3        ; {110288}
    RTL                   ; {110290}

  loc_01AED3:
    COP [81] ( #2A, #14 ) ; {110291}
    COP [83]              ; {110295}
    COP [27] ( &code_01AEDD ) ; {110297}
}

code_01AEDD {
    COP [91]              ; {110301}
    COP [0D] ( #00, #47, #33, &code_01AEE7 ) ; {110303}
    RTL                   ; {110310}
}

code_01AEE7 {
    LDA $0322             ; {110311}
    AND #$0400            ; {110314}
    BNE loc_01AEF0        ; {110317}
    RTL                   ; {110319}

  loc_01AEF0:
    COP [81] ( #2C, #14 ) ; {110320}
    COP [83]              ; {110324}
    COP [27] ( &code_01AEC0 ) ; {110326}
}

code_01AEFA {
    COP [01] ( &asciistring_01AF0A ) ; {110330}
    COP [91]              ; {110334}
    COP [0D] ( #00, #47, #38, &code_01AF09 ) ; {110336}
    BRA loc_01AE9D        ; {110343}
}

code_01AF09 {
    RTL                   ; {110345}
}

asciistring_01AF0A |[10]I am an elevator [N]invented by Dr-Leo- [FIN]I cannot move unless [N]the water mill is [N]turning- [JMP:&asciistring_01B988]|

code_01AF5C {
    COP [A4]              ; {110428}
    COP [05] ( #$0404 )   ; {110430}
    LDY $039C             ; {110434}
    LDA $0000, Y          ; {110437}
    CMP #$04B0            ; {110440}
    BCC code_01AF75       ; {110443}
    COP [A0] ( #$FFB0 )   ; {110445}
    COP [27] ( &code_01AF97 ) ; {110449}

  code_01AF75:
    COP [91]              ; {110453}
    COP [0D] ( #00, #47, #38, &code_01AF7F ) ; {110455}
    RTL                   ; {110462}
}

code_01AF7F {
    LDA $0322             ; {110463}
    AND #$0800            ; {110466}
    BNE loc_01AF88        ; {110469}
    RTL                   ; {110471}

  loc_01AF88:
    COP [85] ( @code_01AFB9 ) ; {110472}
    COP [81] ( #2B, #14 ) ; {110477}
    COP [83]              ; {110481}
    COP [27] ( &code_01AF97 ) ; {110483}
}

code_01AF97 {
    COP [91]              ; {110487}
    COP [0D] ( #00, #47, #33, &code_01AFA1 ) ; {110489}
    RTL                   ; {110496}
}

code_01AFA1 {
    LDA $0322             ; {110497}
    AND #$0400            ; {110500}
    BNE loc_01AFAA        ; {110503}
    RTL                   ; {110505}

  loc_01AFAA:
    COP [85] ( @code_01AFB9 ) ; {110506}
    COP [81] ( #2D, #14 ) ; {110511}
    COP [83]              ; {110515}
    COP [27] ( &code_01AF75 ) ; {110517}
}

code_01AFB9 {
    LDA #$2F80            ; {110521}
    TSB $0326             ; {110524}
    COP [03] ( #51 )      ; {110527}
    LDY $003C, X          ; {110530}
    LDA $0002, Y          ; {110533}
    LDY $039C             ; {110536}
    STA $0002, Y          ; {110539}
    LDY $039E             ; {110542}
    STA $0002, Y          ; {110545}
    PHX                   ; {110548}
    LDX $039C             ; {110549}
    LDA $001E, X          ; {110552}
    ASL                   ; {110555}
    TAX                   ; {110556}
    LDA $&data_00F9F7.word_00FAD7, X ; {110557}
    CLC                   ; {110560}
    ADC $0002, Y          ; {110561}
    STA $0002, Y          ; {110564}
    PLX                   ; {110567}
    LDA $0312             ; {110568}
    AND #$0003            ; {110571}
    BNE loc_01AFF2        ; {110574}
    BRK #$63              ; {110576}

  loc_01AFF2:
    COP [04]              ; {110578}
    LDA #$2F80            ; {110580}
    TRB $0326             ; {110583}
    COP [86]              ; {110586}
    RTL                   ; {110588}
}

code_01AFFD {
    SEP #$20              ; {110589}
    LDA $1C6A             ; {110591}
    LDY #$&unk16_01B042   ; {110594}
    CMP #$05              ; {110597}
    BEQ loc_01B035        ; {110599}
    LDY #$&unk16_01B063   ; {110601}
    CMP #$06              ; {110604}
    BEQ loc_01B035        ; {110606}
    LDY #$&unk16_01B0A4   ; {110608}
    CMP #$07              ; {110611}
    BEQ loc_01B035        ; {110613}
    LDY #$&unk16_01B0B5   ; {110615}
    CMP #$08              ; {110618}
    BEQ loc_01B035        ; {110620}
    LDY #$&unk16_01B106   ; {110622}
    CMP #$09              ; {110625}
    BEQ loc_01B035        ; {110627}
    LDY #$&unk16_01B13F   ; {110629}
    CMP #$0B              ; {110632}
    BEQ loc_01B035        ; {110634}
    LDY #$&unk16_01B148   ; {110636}
    CMP #$0C              ; {110639}
    BEQ loc_01B035        ; {110641}
    BRA loc_01B03D        ; {110643}

  loc_01B035:
    STY $03D8             ; {110645}
    LDA #$^unk16_01B042   ; {110648}
    STA $03DA             ; {110650}

  loc_01B03D:
    REP #$20              ; {110653}
    COP [86]              ; {110655}
    RTL                   ; {110657}
}
---------------------------------------------

unk16_01B042 [
  unk16 < #27, #37, #08, #0A, #$0001, #$0000 >   ;00
  unk16 < #49, #4B, #0C, #1C, #$0000, #$FFFF >   ;01
  unk16 < #3A, #3B, #1E, #2E, #$0000, #$0001 >   ;02
  unk16 < #26, #36, #2E, #30, #$0001, #$0000 >   ;03
]

unk16_01B063 [
  unk16 < #21, #31, #25, #27, #$FFFF, #$0000 >   ;00
  unk16 < #28, #2A, #05, #25, #$0000, #$FFFF >   ;01
  unk16 < #2A, #3A, #13, #15, #$FFFF, #$0000 >   ;02
  unk16 < #28, #38, #03, #05, #$0001, #$0000 >   ;03
  unk16 < #38, #3A, #03, #13, #$0000, #$0001 >   ;04
  unk16 < #3A, #3C, #13, #34, #$0000, #$0001 >   ;05
  unk16 < #28, #38, #38, #3A, #$FFFF, #$0000 >   ;06
  unk16 < #1E, #2E, #3A, #3C, #$FFFF, #$0000 >   ;07
]

unk16_01B0A4 [
  unk16 < #03, #05, #12, #20, #$0000, #$FFFF >   ;00
  unk16 < #06, #08, #12, #20, #$0000, #$0001 >   ;01
]

unk16_01B0B5 [
  unk16 < #1D, #1F, #04, #07, #$0000, #$FFFF >   ;00
  unk16 < #1D, #1F, #09, #0C, #$0000, #$FFFF >   ;01
  unk16 < #1F, #21, #03, #06, #$0000, #$0001 >   ;02
  unk16 < #1F, #21, #08, #0B, #$0000, #$0001 >   ;03
  unk16 < #21, #23, #04, #07, #$0000, #$FFFF >   ;04
  unk16 < #21, #23, #09, #0C, #$0000, #$FFFF >   ;05
  unk16 < #26, #28, #03, #0C, #$0000, #$0001 >   ;06
  unk16 < #28, #2A, #03, #0C, #$0000, #$FFFF >   ;07
  unk16 < #2A, #2C, #03, #0C, #$0000, #$0001 >   ;08
  unk16 < #2C, #3B, #09, #0B, #$0001, #$0000 >   ;09
]

unk16_01B106 [
  unk16 < #05, #07, #11, #17, #$0000, #$0001 >   ;00
  unk16 < #07, #0D, #15, #17, #$0001, #$0000 >   ;01
  unk16 < #0D, #0F, #12, #17, #$0000, #$FFFF >   ;02
  unk16 < #0D, #0F, #09, #0F, #$0000, #$0001 >   ;03
  unk16 < #0F, #15, #07, #09, #$0001, #$0000 >   ;04
  unk16 < #0F, #15, #11, #13, #$0001, #$0000 >   ;05
  unk16 < #0F, #15, #1A, #1C, #$FFFF, #$0000 >   ;06
]

unk16_01B13F [
  unk16 < #07, #09, #0E, #3E, #$0000, #$FFFF >
]

unk16_01B148 [
  unk16 < #03, #05, #06, #0A, #$0000, #$FFFF >   ;00
  unk16 < #0B, #0D, #06, #0A, #$0000, #$FFFF >   ;01
  unk16 < #07, #09, #06, #0A, #$0000, #$0001 >   ;02
]
---------------------------------------------

code_01B161 {
    COP [A8] ( #$8000, #0E ) ; {110945}
    LDA #$0007            ; {110950}
    STA $001E, X          ; {110953}
    STZ $0020, X          ; {110956}
    JSL $@chunk_000000.code_0008F3 ; {110959}
    LDA $0372             ; {110963}
    STA $001C, X          ; {110966}
    COP [15]              ; {110969}
    RTL                   ; {110971}
}
---------------------------------------------

code_01B17C {
    COP [2E] ( #00, #$0018, &code_01B18A ) ; {110972}
    COP [80] ( #07 )      ; {110979}
    COP [82]              ; {110982}
    BRA code_01B17C       ; {110984}
}

code_01B18A {
    COP [80] ( #0C )      ; {110986}
    COP [82]              ; {110989}
    BRA code_01B17C       ; {110991}
}

code_01B191 {
    COP [1F]              ; {110993}
    LDA $0302             ; {110995}
    AND #$0003            ; {110998}
    BEQ loc_01B1A3        ; {111001}
    DEC                   ; {111003}
    BEQ loc_01B1A8        ; {111004}
    COP [01] ( &asciistring_01B1AD ) ; {111006}
    RTL                   ; {111010}

  loc_01B1A3:
    COP [01] ( &asciistring_01B1C7 ) ; {111011}
    RTL                   ; {111015}

  loc_01B1A8:
    COP [01] ( &asciistring_01B1E6 ) ; {111016}
    RTL                   ; {111020}
}

asciistring_01B1AD |[10]Please, someone help [N]me! [JMP:&asciistring_01B988]|

asciistring_01B1C7 |[10]Please release me, [N]someone help me! [JMP:&asciistring_01B988]|

asciistring_01B1E6 |[10]Someone help me! [JMP:&asciistring_01B988]|

code_01B1F7 {
    LDA $0000, X          ; {111095}
    CLC                   ; {111098}
    ADC #$0001            ; {111099}
    CLC                   ; {111102}
    ADC $0382             ; {111103}
    STA $0000, X          ; {111106}
    STA $033E             ; {111109}
    LDA $0002, X          ; {111112}
    SEC                   ; {111115}
    SBC #$0001            ; {111116}
    CLC                   ; {111119}
    ADC $0384             ; {111120}
    STA $0002, X          ; {111123}
    STA $0340             ; {111126}
    RTL                   ; {111129}
}

code_01B21A {
    LDA $0000, X          ; {111130}
    SEC                   ; {111133}
    SBC #$0008            ; {111134}
    CLC                   ; {111137}
    ADC $0382             ; {111138}
    STA $0000, X          ; {111141}
    STA $033E             ; {111144}
    LDA $0002, X          ; {111147}
    SEC                   ; {111150}
    SBC #$0008            ; {111151}
    CLC                   ; {111154}
    ADC $0384             ; {111155}
    STA $0002, X          ; {111158}
    STA $0340             ; {111161}
    RTL                   ; {111164}
}

code_01B23D {
    PHP                   ; {111165}
    SEP #$20              ; {111166}
    LDA #$32              ; {111168}
    XBA                   ; {111170}
    LDA #$^binary_01B24E  ; {111171}
    LDY #$&binary_01B24E  ; {111173}
    JSL $@chunk_010000.code_01188A ; {111176}
    PLP                   ; {111180}
    RTL                   ; {111181}
}
---------------------------------------------

binary_01B24E #7FE020E004E104E204E304E404E504E604E704E804E904EA04EB04EC04ED04EE04EF04F000
---------------------------------------------

code_01B273 {
    PHP                   ; {111219}
    SEP #$20              ; {111220}
    LDA #$32              ; {111222}
    XBA                   ; {111224}
    LDA #$^binary_01B284  ; {111225}
    LDY #$&binary_01B284  ; {111227}
    JSL $@chunk_010000.code_01188A ; {111230}
    PLP                   ; {111234}
    RTL                   ; {111235}
}
---------------------------------------------

binary_01B284 #07F20CF10CF00CEF0CEE0CED0CEC0CEB0CEA0CE90CE80CE70CE60CE50CE40CE30CE20CE10CE000
---------------------------------------------

asciistring_01B2AB |[10]I am watching over the[N]world- [N]Please take this- [FIN][02:2]  received [N]EXP! [FIN][END]|

asciistring_01B2D2 |[10]Would you like to [N]return to Grass [N]Valley? [END]|

asciistring_01B2F5 |Allright, please [N]continue- [JMP:&asciistring_01B988]|

asciistring_01B30E |Come back [N]whenever you feel like[N]returning [N]to Grass Valley- [JMP:&asciistring_01B988]|

code_01B33A {
    REP #$20              ; {111418}
    LDA #$0059            ; {111420}
    STA $BG3SC            ; {111423}
    STZ $0386             ; {111426}
    STZ $0388             ; {111429}
    LDA #$3FC0            ; {111432}
    TSB $0326             ; {111435}
    COP [0D] ( #00, #2F, #29, &code_01B38A ) ; {111438}
    LDA #$0007            ; {111445}
    STA $1B84             ; {111448}
    SEP #$20              ; {111451}
    LDA #$04              ; {111453}
    STA $TM               ; {111455}
    REP #$20              ; {111458}
    COP [03] ( #3D )      ; {111460}
    COP [04]              ; {111463}
    COP [01] ( &asciistring_01B52D ) ; {111465}
    COP [03] ( #79 )      ; {111469}
    COP [04]              ; {111472}
    STZ $0419             ; {111474}
    LDA #$0020            ; {111477}
    STA $03B4             ; {111480}
    COP [3C] ( #04 )      ; {111483}
    COP [10] ( #$0D00, #02, #$02F0, #$0290 ) ; {111486}
    COP [91]              ; {111495}
    RTL                   ; {111497}
}

code_01B38A {
    COP [91]              ; {111498}
    COP [34]              ; {111500}
    LDA #$0005            ; {111502}
    STA $1B84             ; {111505}
    COP [03] ( #3D )      ; {111508}
    COP [04]              ; {111511}
    COP [01] ( &asciistring_01B67F ) ; {111513}
    COP [03] ( #79 )      ; {111517}
    COP [04]              ; {111520}
    COP [AC] ( @chunk_000000.code_00299D, #$02F0, #$02A0, #$0040 ) ; {111522}
    BRK #$96              ; {111533}
    COP [33]              ; {111535}
    LDA #$3FC0            ; {111537}
    TSB $0326             ; {111540}
    COP [03] ( #1F )      ; {111543}
    COP [04]              ; {111546}
    COP [03] ( #02 )      ; {111548}
    LDA #$0003            ; {111551}
    LDY $039C             ; {111554}
    STA $001E, Y          ; {111557}
    COP [1B] ( &code_01B3CE, #$0010 ) ; {111560}
}

code_01B3CE {
    LDA #$0002            ; {111566}
    LDY $039C             ; {111569}
    STA $001E, Y          ; {111572}
    COP [1B] ( &code_01B3DD, #$0010 ) ; {111575}
}

code_01B3DD {
    COP [04]              ; {111581}
    COP [03] ( #5B )      ; {111583}
    COP [04]              ; {111586}
    COP [96]              ; {111588}
    COP [80] ( #25 )      ; {111590}
    COP [82]              ; {111593}
    COP [03] ( #3D )      ; {111595}
    COP [04]              ; {111598}
    COP [32] ( #11 )      ; {111600}
    COP [03] ( #3D )      ; {111603}
    COP [04]              ; {111606}
    COP [01] ( &asciistring_01B6C1 ) ; {111608}
    LDA #$0001            ; {111612}
    STA $1B84             ; {111615}
    COP [01] ( &asciistring_01B6C9 ) ; {111618}
    LDA #$0005            ; {111622}
    STA $1B84             ; {111625}
    COP [01] ( &asciistring_01B6D5 ) ; {111628}
    COP [03] ( #5B )      ; {111632}
    COP [04]              ; {111635}
    COP [01] ( &asciistring_01B6FF ) ; {111637}
    LDA #$3FC0            ; {111641}
    TRB $0326             ; {111644}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_01B438 ) ; {111647}
    LDA #$3FC0            ; {111654}
    TSB $0326             ; {111657}
    LDA $0003D0           ; {111660}
    BNE code_01B438       ; {111664}
    COP [01] ( &asciistring_01B723 ) ; {111666}
    BRA loc_01B442        ; {111670}
}

code_01B438 {
    LDA #$3FC0            ; {111672}
    TSB $0326             ; {111675}
    COP [01] ( &asciistring_01B73B ) ; {111678}

  loc_01B442:
    COP [03] ( #3D )      ; {111682}
    COP [04]              ; {111685}
    COP [01] ( &asciistring_01B880 ) ; {111687}
    COP [97]              ; {111691}
    COP [80] ( #25 )      ; {111693}
    COP [82]              ; {111696}
    COP [03] ( #29 )      ; {111698}
    COP [04]              ; {111701}
    COP [01] ( &asciistring_01B8CA ) ; {111703}
    LDA #$0002            ; {111707}
    STA $1B84             ; {111710}
    COP [01] ( &asciistring_01B8E8 ) ; {111713}
    LDA #$0005            ; {111717}
    STA $1B84             ; {111720}
    COP [96]              ; {111723}
    COP [80] ( #25 )      ; {111725}
    COP [82]              ; {111728}
    COP [03] ( #29 )      ; {111730}
    COP [04]              ; {111733}
    COP [01] ( &asciistring_01B8F8 ) ; {111735}
    LDA #$0380            ; {111739}
    STA $0342             ; {111742}
    COP [81] ( #26, #04 ) ; {111745}
    COP [83]              ; {111749}
    COP [97]              ; {111751}
    COP [80] ( #25 )      ; {111753}
    COP [82]              ; {111756}
    COP [03] ( #1F )      ; {111758}
    COP [04]              ; {111761}
    COP [01] ( &asciistring_01B951 ) ; {111763}
    COP [96]              ; {111767}
    COP [80] ( #25 )      ; {111769}
    COP [82]              ; {111772}
    LDY $039C             ; {111774}
    LDA $0016, Y          ; {111777}
    AND #$EFFF            ; {111780}
    STA $0016, Y          ; {111783}
    LDA #$0100            ; {111786}
    STA $0468             ; {111789}
    COP [09] ( #$8000 )   ; {111792}
    COP [80] ( #26 )      ; {111796}
    COP [82]              ; {111799}
    LDA #$0000            ; {111801}
    STA $0468             ; {111804}
    COP [81] ( #26, #02 ) ; {111807}
    COP [83]              ; {111811}
    LDA #$0100            ; {111813}
    STA $0468             ; {111816}
    COP [81] ( #26, #08 ) ; {111819}
    COP [83]              ; {111823}
    COP [1B] ( &code_01B4D7, #$014A ) ; {111825}
}

code_01B4D7 {
    LDA #$0000            ; {111831}
    STA $0468             ; {111834}
    COP [85] ( @code_01B508 ) ; {111837}
    COP [03] ( #BF )      ; {111842}
    COP [04]              ; {111845}
    STZ $0030, X          ; {111847}
    COP [03] ( #20 )      ; {111850}
    SEP #$20              ; {111853}
    LDA $0030, X          ; {111855}
    ORA #$E0              ; {111858}
    STA $7F0200           ; {111860}
    REP #$20              ; {111864}
    INC $0030, X          ; {111866}
    COP [1B] ( &code_01B503, #$0002 ) ; {111869}
}

code_01B503 {
    COP [04]              ; {111875}
    COP [91]              ; {111877}
    RTL                   ; {111879}
}

code_01B508 {
    LDA #$0002            ; {111880}
    TSB $03B8             ; {111883}
    COP [03] ( #02 )      ; {111886}
    COP [04]              ; {111889}
    LDA #$00FF            ; {111891}
    STA $0386             ; {111894}
    PHX                   ; {111897}
    LDY #$&chunk_010000.asciistring_0143A4 ; {111898}
    JSL $@chunk_010000.code_012769 ; {111901}
    PLX                   ; {111905}
    COP [03] ( #FF )      ; {111906}
    DEC $0386             ; {111909}
    COP [04]              ; {111912}
    COP [91]              ; {111914}
    RTL                   ; {111916}
}

asciistring_01B52D |[10]My follower, [N][0E:28]tell me what is on [N]your mind- [N][0E:5A]I do not know what has[N]happened between you [N]and that girl- [N][0E:5A]However, being [N]attracted to a human [N]means that you have [N]not yet established [N]yourself as a heavenly[N]creature- [N][0E:5A]A year has now passed,[N]but your feelings have[N]not changed- [N][0E:5A]Maybe you should try [N]living as a human [N]being- [N]Learning how they [N]live- [N][0E:5A]Be warned though- Once[N]you go down to earth [N]you will lose all [N]memory- [N][0E:78][JMP:&asciistring_01B988+M]|

asciistring_01B67F |[10]Hey, [0E:28]Turbo,[N][0E:5A]I feel something [N]strange in the air [N]today- [N][0E:3C]What s wrong with me? [N][0E:5A][JMP:&asciistring_01B988+M]|

asciistring_01B6C1 |[10][02:2]? [0E:5A][END]|

asciistring_01B6C9 |Is that you? [0E:B4][END]|

asciistring_01B6D5 |Oh, my-----![N][0E:5A]I knew you would come [N]back! [N][0E:5A][JMP:&asciistring_01B988+M]|

asciistring_01B6FF |[10]What is wrong? [N][0E:28]Don t you remember me?[END]|

asciistring_01B723 |No, I can t believe [N]this- [N][0E:78][JMP:&asciistring_01B73B+M]|

asciistring_01B73B |It s okay- [N][0E:28]You don t have to [N]worry-[N][0E:3C]I can tell by the look[N]in your eyes-[N][0E:5A][::]It s me, [N]Lisa----- [0E:28]Daughter of [N]Dr-Leo the inventor! [N][0E:5A]Please! [N][0E:28]Don t you remember me?[N][0E:B4]Well, okay- [N][0E:5A]You have never lied to[N]me- [N][0E:5A]It s just hard to [N]believe you lost all [N]your memory- [N][0E:5A]All right, I won t ask[N]you again- [N][0E:5A]I guess I have to [N]change my way of [N]thinking- [N][0E:5A]We can create many new[N]and wonderful memories[N]together! [N][0E:78][JMP:&asciistring_01B988+M]|

asciistring_01B880 |[10]Okay, let me introduce[N]myself- [N][0E:5A]I am Lisa, [N][0E:5A]and the goat behind [N]me is Turbo- [N][0E:5A][JMP:&asciistring_01B988+M]|

asciistring_01B8CA |[10]Come on Turbo, [N][0E:28]say "helloˮ- [N][0E:5A][END]|

asciistring_01B8E8 |[10]BLEEEET! [N][0E:5A][JMP:&asciistring_01B988+M]|

asciistring_01B8F8 |[10]He looks like a dog I[N]used to have- [N][0E:5A]That is [N]why I call him Turbo- [N][0E:5A]Come, I will show you [N]around- [N][0E:78][JMP:&asciistring_01B988+M]|

asciistring_01B951 |[10]Hurry up Turbo! [0E:78][JMP:&asciistring_01B988+M]|

code_01B967 {
    COP [07] ( #$8000, &code_01B974 ) ; {112999}
    COP [80] ( #24 )      ; {113005}
    COP [82]              ; {113008}
    BRA code_01B967       ; {113010}
}

code_01B974 {
    COP [81] ( #1B, #04 ) ; {113012}
    COP [83]              ; {113016}
    COP [80] ( #24 )      ; {113018}
    COP [82]              ; {113021}
    COP [81] ( #1B, #08 ) ; {113023}
    COP [83]              ; {113027}
    COP [91]              ; {113029}
    RTL                   ; {113031}
}
---------------------------------------------

asciistring_01B988 |[12][::][08:408][END]|