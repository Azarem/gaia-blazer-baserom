?BANK 04

?INCLUDE 'chunk_000000'
?INCLUDE 'chunk_010000'
?INCLUDE 'chunk_018000'
?INCLUDE 'chunk_020000'
?INCLUDE 'chunk_0270E4'

---------------------------------------------

code_023FA8 {
    COP [14] ( #$0159, &code_023FAF ) ; {147368}
    RTL                   ; {147374}
}

code_023FAF {
    COP [30] ( #$0159, &code_023FC9, #04 ) ; {147375}
    COP [85] ( @chunk_000000.code_00299D ) ; {147382}
    COP [17] ( &code_023FC4 ) ; {147387}
    COP [15]              ; {147391}
    COP [91]              ; {147393}
    RTL                   ; {147395}
}

code_023FC4 {
    COP [01] ( &asciistring_023FDD ) ; {147396}
    RTL                   ; {147400}
}

code_023FC9 {
    COP [18] ( #06, &code_023FD1 ) ; {147401}

  loc_023FCE:
    COP [86]              ; {147406}
    RTL                   ; {147408}
}

code_023FD1 {
    COP [01] ( &asciistring_023FD7 ) ; {147409}
    BRA loc_023FCE        ; {147413}
}

asciistring_023FD7 |[10][0E:3C][JMP:&asciistring_023FDD+M]|

asciistring_023FDD |[10][::]There are many [N]ghosts in the torture [N]room of the basement- [FIN]First, [N]look for the Spirit [N]Sword- [JMP:&asciistring_0270DF]|

code_024027 {
    COP [14] ( #$015A, &code_02402E ) ; {147495}
    RTL                   ; {147501}
}

code_02402E {
    COP [07] ( #$8806, &code_024042 ) ; {147502}
    COP [85] ( @chunk_000000.code_00299D ) ; {147508}
    COP [17] ( &code_02404B ) ; {147513}
    COP [15]              ; {147517}
    COP [91]              ; {147519}
    RTL                   ; {147521}
}

code_024042 {
    COP [17] ( &code_024054 ) ; {147522}
    COP [15]              ; {147526}
    COP [91]              ; {147528}
    RTL                   ; {147530}
}

code_02404B {
    COP [01] ( &asciistring_024059 ) ; {147531}
    COP [09] ( #$8806 )   ; {147535}
    RTL                   ; {147539}
}

code_024054 {
    COP [01] ( &asciistring_0240AC ) ; {147540}
    RTL                   ; {147544}
}

asciistring_024059 |[10]My uncle is [N]the famous architect [N]Gaudi- [FIN]I know a bit about [N]architecture- [N]I will show you [N]something later- [JMP:&asciistring_0270DF]|

asciistring_0240AC |[10]What do you think [N]about the wall? [N]I am known as a [N]"speedˮ architect- [JMP:&asciistring_0270DF]|

code_0240E4 {
    RTL                   ; {147684}
}

code_0240E5 {
    COP [14] ( #$015F, &code_0240EC ) ; {147685}
    RTL                   ; {147691}
}

code_0240EC {
    COP [30] ( #$015F, &code_024111, #04 ) ; {147692}
    COP [85] ( @chunk_000000.code_00299D ) ; {147699}
    COP [17] ( &code_024101 ) ; {147704}
    COP [15]              ; {147708}
    COP [91]              ; {147710}
    RTL                   ; {147712}
}

code_024101 {
    COP [14] ( #$0195, &code_02410C ) ; {147713}
    COP [01] ( &asciistring_024194 ) ; {147719}
    RTL                   ; {147723}
}

code_02410C {
    COP [01] ( &asciistring_0241F2 ) ; {147724}
    RTL                   ; {147728}
}

code_024111 {
    COP [01] ( &asciistring_024118 ) ; {147729}
    COP [86]              ; {147733}
    RTL                   ; {147735}
}

asciistring_024118 |[10][0E:3C]Thank you very much- [FIN]There are many thorns [N]in the basement- [FIN]If you free the [N]soldier right in front[N]of where I have been [N]captured, [FIN]you will receive [N]the Elemental Mail- [JMP:&asciistring_0270DF]|

asciistring_024194 |[10]This is King Magridd s[N]Castle- [FIN]The King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█that█or[N]I█will█be█punished-[JMP:&asciistring_0270DF]|

asciistring_0241F2 |[10]This is the Castle of [N]King Magridd- [FIN]The King is the [N]greatest man in the [N]world- [FIN]I don t have to say [N]that anymore, because [N]the King really did [N]become a good man- [JMP:&asciistring_0270DF]|

code_024259 {
    COP [14] ( #$0161, &code_024260 ) ; {148057}
    RTL                   ; {148063}
}

code_024260 {
    COP [85] ( @chunk_000000.code_00299D ) ; {148064}
    COP [07] ( #$8804, &code_0242AE ) ; {148069}
    COP [17] ( &code_0242BC ) ; {148075}
    COP [15]              ; {148079}
    COP [91]              ; {148081}
    COP [0D] ( #00, #02, #1F, &code_02427B ) ; {148083}
    RTL                   ; {148090}
}

code_02427B {
    COP [07] ( #$0803, &code_0242B9 ) ; {148091}
    COP [17] ( #$0000 )   ; {148097}
    LDA #$2F80            ; {148101}
    TSB $0326             ; {148104}
    COP [03] ( #1F )      ; {148107}
    COP [04]              ; {148110}
    COP [80] ( #2C )      ; {148112}
    COP [82]              ; {148115}
    COP [2B] ( #$FFF0, #$0000 ) ; {148117}
    COP [01] ( &asciistring_024316 ) ; {148123}
    BRK #$5E              ; {148127}
    COP [0A] ( #0F )      ; {148129}
    COP [09] ( #$8804 )   ; {148132}
    LDA #$2F80            ; {148136}
    TRB $0326             ; {148139}
}

code_0242AE {
    COP [80] ( #12 )      ; {148142}
    COP [82]              ; {148145}
    COP [17] ( &code_0242DD ) ; {148147}
    COP [15]              ; {148151}
}

code_0242B9 {
    COP [91]              ; {148153}
    RTL                   ; {148155}
}

code_0242BC {
    COP [07] ( #$8804, &code_0242DD ) ; {148156}
    COP [19] ( #1C, &code_0242D8 ) ; {148162}
    COP [01] ( &asciistring_0242EB ) ; {148167}
    COP [3C] ( #04 )      ; {148171}
    COP [10] ( #$0313, #01, #$0150, #$01A0 ) ; {148174}
    RTL                   ; {148183}
}

code_0242D8 {
    COP [01] ( &asciistring_0242E2 ) ; {148184}
    RTL                   ; {148188}
}

code_0242DD {
    COP [01] ( &asciistring_0243E7 ) ; {148189}
    RTL                   ; {148193}
}

asciistring_0242E2 |[10]Zzzz [JMP:&asciistring_0270DF]|

asciistring_0242EB |[10][02:2] placed the [N]Dream Rod upon the [N]soldier s head- [JMP:&asciistring_0270DF]|

asciistring_024316 |[10]Oops! I was sleeping- [FIN]Lately I have been [N]having the same dream [N]as Dr-Leo- [FIN]If I would have [N]released Dr-Leo, [N]the world would not be[N]like this- [FIN]I don t know who to [N]obey anymore! [FIN]There are many thorns [N]in the basement of [N]Magridd Castle- [FIN]You must take this [N]armor with you- [FIN][02:2] received [N][03:24]the Elemental Mail- [03:20][JMP:&asciistring_0270DF]|

asciistring_0243E7 |[10]I have a feeling that [N]you will change the [N]world- [N]Good luck! [JMP:&asciistring_0270DF]|

code_024416 {
    COP [14] ( #$0162, &code_02441D ) ; {148502}
    RTL                   ; {148508}
}

code_02441D {
    COP [85] ( @chunk_000000.code_00299D ) ; {148509}
    COP [17] ( &code_0244C5 ) ; {148514}

  loc_024426:
    COP [97]              ; {148518}
    COP [81] ( #17, #08 ) ; {148520}
    COP [83]              ; {148524}
    COP [03] ( #1F )      ; {148526}
    COP [04]              ; {148529}
    COP [80] ( #13 )      ; {148531}
    COP [82]              ; {148534}
    COP [03] ( #1F )      ; {148536}
    COP [04]              ; {148539}
    COP [80] ( #14 )      ; {148541}
    COP [82]              ; {148544}
    COP [03] ( #1F )      ; {148546}
    COP [04]              ; {148549}
    COP [80] ( #12 )      ; {148551}
    COP [82]              ; {148554}
    COP [03] ( #1F )      ; {148556}
    COP [04]              ; {148559}
    COP [81] ( #15, #0B ) ; {148561}
    COP [83]              ; {148565}
    COP [03] ( #1F )      ; {148567}
    COP [04]              ; {148570}
    COP [80] ( #14 )      ; {148572}
    COP [82]              ; {148575}
    COP [03] ( #1F )      ; {148577}
    COP [04]              ; {148580}
    COP [80] ( #12 )      ; {148582}
    COP [82]              ; {148585}
    COP [03] ( #1F )      ; {148587}
    COP [04]              ; {148590}
    COP [96]              ; {148592}
    COP [80] ( #14 )      ; {148594}
    COP [82]              ; {148597}
    COP [03] ( #1F )      ; {148599}
    COP [04]              ; {148602}
    COP [81] ( #17, #10 ) ; {148604}
    COP [83]              ; {148608}
    COP [03] ( #1F )      ; {148610}
    COP [04]              ; {148613}
    COP [80] ( #13 )      ; {148615}
    COP [82]              ; {148618}
    COP [03] ( #1F )      ; {148620}
    COP [04]              ; {148623}
    COP [81] ( #16, #0B ) ; {148625}
    COP [83]              ; {148629}
    COP [03] ( #1F )      ; {148631}
    COP [04]              ; {148634}
    COP [80] ( #14 )      ; {148636}
    COP [82]              ; {148639}
    COP [03] ( #1F )      ; {148641}
    COP [04]              ; {148644}
    COP [80] ( #13 )      ; {148646}
    COP [82]              ; {148649}
    COP [03] ( #1F )      ; {148651}
    COP [04]              ; {148654}
    COP [97]              ; {148656}
    COP [80] ( #14 )      ; {148658}
    COP [82]              ; {148661}
    COP [03] ( #1F )      ; {148663}
    COP [04]              ; {148666}
    COP [81] ( #17, #08 ) ; {148668}
    COP [83]              ; {148672}
    BRL loc_024426        ; {148674}
}

code_0244C5 {
    COP [01] ( &asciistring_0244CA ) ; {148677}
    RTL                   ; {148681}
}

asciistring_0244CA |[10]I am guarding [N]the castle- [N]Don t talk to me- [JMP:&asciistring_0270DF]|

code_0244EF {
    COP [14] ( #$0166, &code_0244F6 ) ; {148719}
    RTL                   ; {148725}
}

code_0244F6 {
    COP [85] ( @chunk_000000.code_00299D ) ; {148726}
    COP [17] ( &code_024504 ) ; {148731}
    COP [15]              ; {148735}
    COP [91]              ; {148737}
    RTL                   ; {148739}
}

code_024504 {
    COP [14] ( #$0195, &code_02450F ) ; {148740}
    COP [01] ( &asciistring_024514 ) ; {148746}
    RTL                   ; {148750}
}

code_02450F {
    COP [01] ( &asciistring_024575 ) ; {148751}
    RTL                   ; {148755}
}

asciistring_024514 |[10]This is King [N]Magridd s Castle- [FIN]Our King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█this█or[N]I█will█be█punished-[JMP:&asciistring_0270DF]|

asciistring_024575 |[10]I think he is in shock[N]after losing the [N]Queen- [JMP:&asciistring_0270DF]|

code_024597 {
    COP [14] ( #$0167, &code_02459E ) ; {148887}
    RTL                   ; {148893}
}

code_02459E {
    COP [30] ( #$0167, &code_024615, #04 ) ; {148894}
    COP [17] ( &code_0245CB ) ; {148901}
    COP [15]              ; {148905}
    COP [80] ( #1B )      ; {148907}
    COP [82]              ; {148910}
    COP [91]              ; {148912}
    RTL                   ; {148914}
}

code_0245B3 {
    COP [80] ( #1C )      ; {148915}
    COP [82]              ; {148918}
    COP [31] ( #12 )      ; {148920}
    COP [03] ( #79 )      ; {148923}
    COP [04]              ; {148926}
    COP [09] ( #$8001 )   ; {148928}

  loc_0245C4:
    COP [80] ( #1D )      ; {148932}
    COP [82]              ; {148935}
    BRA loc_0245C4        ; {148937}
}

code_0245CB {
    COP [07] ( #$8703, &code_0245FF ) ; {148939}
    COP [19] ( #1A, &code_024610 ) ; {148945}
    COP [01] ( &asciistring_02480A ) ; {148950}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_0245FA ) ; {148954}
    LDA $0003D0           ; {148961}
    BNE code_0245FA       ; {148965}
    COP [09] ( #$8703 )   ; {148967}
    COP [01] ( &asciistring_02484C ) ; {148971}
    COP [0B] ( #1A )      ; {148975}
    COP [17] ( &code_02460B ) ; {148978}
    COP [27] ( &code_0245B3 ) ; {148982}
}

code_0245FA {
    COP [01] ( &asciistring_024871 ) ; {148986}
    RTL                   ; {148990}
}

code_0245FF {
    COP [01] ( &asciistring_024676 ) ; {148991}
    COP [17] ( &code_02460B ) ; {148995}
    COP [27] ( &code_0245B3 ) ; {148999}
}

code_02460B {
    COP [01] ( &asciistring_02479E ) ; {149003}
    RTL                   ; {149007}
}

code_024610 {
    COP [01] ( &asciistring_0247DE ) ; {149008}
    RTL                   ; {149012}
}

code_024615 {
    COP [01] ( &asciistring_02461C ) ; {149013}
    COP [86]              ; {149017}
    RTL                   ; {149019}
}

asciistring_02461C |[10][0E:3C]A sad sounding voice [N]is coming from the [N]theater- [FIN]Oh, what can I do? [N]I can t play a harp [N]without strings- [JMP:&asciistring_0270DF]|

asciistring_024676 |[10][::]Thank you very [N]much for coming- [FIN]Before I play some [N]music let me tell you [N]my story- [FIN]I fell in love just [N]once in my 24 years- [FIN]It was when I visited [N]a mine town, [N]Grass Valley- [FIN]When I was injured, [N]there was a girl who [N]took care of me- [FIN]I couldn t tell her [N]my true feelings [N]though-------- [FIN]The girl s name was [N]something like Lisa- [FIN]The music I am going [N]to play now is a song [N]that I wrote for her- [JMP:&asciistring_0270DF]|

asciistring_02479E |[10]There are no words- [FIN]I hope someday someone[N]will be able to put [N]words to my music- [JMP:&asciistring_0270DF]|

asciistring_0247DE |[10]I want to play music, [N]but the harp string [N]is broken- [JMP:&asciistring_0270DF]|

asciistring_02480A |[10]Oh! [N]That is a harp string-[FIN]I promise to use it [N]carefully if you give [N]it to me- [END]|

asciistring_02484C |Thank you very much- [N]Please sit and [N]listen to my music- [FIN][JMP:&asciistring_024676+M]|

asciistring_024871 |It seems important [N]to you- [JMP:&asciistring_0270DF]|

code_02488E {
    COP [3B] ( #$0168, &code_0248A4 ) ; {149646}
    COP [17] ( &chunk_020000.code_02229E ) ; {149652}
    SEP #$20              ; {149656}
    LDA #$^chunk_000000.code_00305F ; {149658}
    PHA                   ; {149660}
    REP #$20              ; {149661}
    LDA #$&chunk_000000.code_00305F-1 ; {149663}
    PHA                   ; {149666}
    RTL                   ; {149667}
}

code_0248A4 {
    COP [85] ( @chunk_000000.code_00299D ) ; {149668}
    COP [17] ( &code_0248B2 ) ; {149673}
    COP [15]              ; {149677}
    COP [91]              ; {149679}
    RTL                   ; {149681}
}

code_0248B2 {
    COP [14] ( #$0195, &code_0248BD ) ; {149682}
    COP [01] ( &asciistring_0248C2 ) ; {149688}
    RTL                   ; {149692}
}

code_0248BD {
    COP [01] ( &asciistring_024904 ) ; {149693}
    RTL                   ; {149697}
}

asciistring_0248C2 |[10]One of the soldiers [N]betrayed the King! [N]He is trying to [N]escape with Dr-Leo- [JMP:&asciistring_0270DF]|

asciistring_024904 |[10]The Queen passed away?[FIN]King Magridd must be [N]in shock! [FIN]He did everything he [N]could to save the [N]Queen- [JMP:&asciistring_0270DF]|

code_02494A {
    COP [14] ( #$017F, &code_024951 ) ; {149834}
    RTL                   ; {149840}
}

code_024951 {
    COP [30] ( #$017F, &code_0249D1, #04 ) ; {149841}
    COP [07] ( #$8805, &code_024978 ) ; {149848}
    COP [17] ( &code_02499F ) ; {149854}
    COP [15]              ; {149858}

  loc_024964:
    COP [07] ( #$8000, &code_024971 ) ; {149860}
    COP [80] ( #0C )      ; {149866}
    COP [82]              ; {149869}
    BRA loc_024964        ; {149871}
}

code_024971 {
    COP [80] ( #0D )      ; {149873}
    COP [82]              ; {149876}
    BRA loc_024964        ; {149878}
}

code_024978 {
    LDA $0016, X          ; {149880}
    ORA #$2000            ; {149883}
    STA $0016, X          ; {149886}
    COP [18] ( #37, &code_024989 ) ; {149889}
    COP [86]              ; {149894}
    RTL                   ; {149896}
}

code_024989 {
    COP [91]              ; {149897}
    COP [0D] ( #00, #36, #17, &code_024993 ) ; {149899}
    RTL                   ; {149906}
}

code_024993 {
    COP [01] ( &asciistring_024AB6 ) ; {149907}
    BRK #$5E              ; {149911}
    COP [0A] ( #37 )      ; {149913}
    COP [91]              ; {149916}
    RTL                   ; {149918}
}

code_02499F {
    COP [18] ( #29, &code_0249A9 ) ; {149919}
    COP [01] ( &asciistring_024A76 ) ; {149924}
    RTL                   ; {149928}
}

code_0249A9 {
    COP [01] ( &asciistring_024A21 ) ; {149929}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_0249C8 ) ; {149933}
    LDA $0003D0           ; {149940}
    BNE code_0249C8       ; {149944}
    COP [01] ( &asciistring_024A47 ) ; {149946}
    BRK #$5E              ; {149950}
    COP [0A] ( #29 )      ; {149952}
    COP [09] ( #$0000 )   ; {149955}
    RTL                   ; {149959}
}

code_0249C8 {
    COP [01] ( &asciistring_024AA8 ) ; {149960}
    COP [09] ( #$8000 )   ; {149964}
    RTL                   ; {149968}
}

code_0249D1 {
    COP [01] ( &asciistring_0249D8 ) ; {149969}
    COP [86]              ; {149973}
    RTL                   ; {149975}
}

asciistring_0249D8 |[10][0E:3C]I do not know who you [N]are, but thank you [N]very much for [N]releasing me- [FIN]I will give you a gift[N]if you come back- [JMP:&asciistring_0270DF]|

asciistring_024A21 |[10]I am the wife of King [N]Magridd- Do you think [N]I am pretty? [END]|

asciistring_024A47 |This is my present to [N]you- [FIN]The Queen put [N]something in [N][02:2] S pocket- [JMP:&asciistring_0270DF]|

asciistring_024A76 |[10]Do you like it? [N]You may go wherever [N]you want within the [N]Magridd Castle- [JMP:&asciistring_0270DF]|

asciistring_024AA8 |[10]--------- [JMP:&asciistring_0270DF]|

asciistring_024AB6 |[10][02:2] found [03:24]the [N]Invulnerable Bracelet [N][03:20]where the Queen was [N]standing- [JMP:&asciistring_0270DF]|

code_024AF4 {
    COP [14] ( #$016D, &code_024AFB ) ; {150260}
    RTL                   ; {150266}
}

code_024AFB {
    COP [07] ( #$8805, &code_024B29 ) ; {150267}
    COP [85] ( @chunk_000000.code_00299D ) ; {150273}
    COP [17] ( &code_024B2C ) ; {150278}
    COP [15]              ; {150282}
    COP [05] ( #$0607 )   ; {150284}
    COP [17] ( &code_024B3F ) ; {150288}
    COP [16]              ; {150292}
    COP [96]              ; {150294}
    COP [80] ( #17 )      ; {150296}
    COP [82]              ; {150299}
    COP [97]              ; {150301}
    COP [80] ( #14 )      ; {150303}
    COP [82]              ; {150306}
    COP [15]              ; {150308}
    COP [91]              ; {150310}
    RTL                   ; {150312}
}

code_024B29 {
    COP [86]              ; {150313}
    RTL                   ; {150315}
}

code_024B2C {
    COP [19] ( #28, &code_024B3A ) ; {150316}
    COP [01] ( &asciistring_024B98 ) ; {150321}
    COP [09] ( #$8607 )   ; {150325}
    RTL                   ; {150329}
}

code_024B3A {
    COP [01] ( &asciistring_024B44 ) ; {150330}
    RTL                   ; {150334}
}

code_024B3F {
    COP [01] ( &asciistring_024B94 ) ; {150335}
    RTL                   ; {150339}
}

asciistring_024B44 |[10]The top floor of this [N]tower is a prison- [FIN]Anyone who does not [N]have the Platinum Card[N]cannot enter- [JMP:&asciistring_0270DF]|

asciistring_024B94 |[10][JMP:&asciistring_024B98+M]|

asciistring_024B98 |[10]Oh, that is the [N]Platinum Card, I am [N]sorry- [FIN][::]Please go inside- [JMP:&asciistring_0270DF]|

code_024BC8 {
    COP [3B] ( #$0170, &code_024BDE ) ; {150472}
    COP [17] ( &chunk_020000.code_02229E ) ; {150478}
    SEP #$20              ; {150482}
    LDA #$^chunk_000000.code_00305F ; {150484}
    PHA                   ; {150486}
    REP #$20              ; {150487}
    LDA #$&chunk_000000.code_00305F-1 ; {150489}
    PHA                   ; {150492}
    RTL                   ; {150493}
}

code_024BDE {
    COP [85] ( @chunk_000000.code_00299D ) ; {150494}
    COP [07] ( #$8805, &code_024C20 ) ; {150499}
    COP [17] ( &code_024C23 ) ; {150505}
    COP [18] ( #28, &code_024BF8 ) ; {150509}
    COP [17] ( &code_024C2D ) ; {150514}
    BRA loc_024BFF        ; {150518}
}

code_024BF8 {
    COP [B0] ( @code_024C32, #$2000 ) ; {150520}

  loc_024BFF:
    COP [15]              ; {150527}
    COP [05] ( #$0001 )   ; {150529}
    COP [16]              ; {150533}
    COP [17] ( #$0000 )   ; {150535}
    COP [81] ( #17, #02 ) ; {150539}
    COP [83]              ; {150543}
    COP [81] ( #16, #03 ) ; {150545}
    COP [83]              ; {150549}
    COP [17] ( &code_024C28 ) ; {150551}
    COP [15]              ; {150555}
    COP [91]              ; {150557}
    RTL                   ; {150559}
}

code_024C20 {
    COP [86]              ; {150560}
    RTL                   ; {150562}
}

code_024C23 {
    COP [01] ( &asciistring_024C48 ) ; {150563}
    RTL                   ; {150567}
}

code_024C28 {
    COP [01] ( &asciistring_024CDF ) ; {150568}
    RTL                   ; {150572}
}

code_024C2D {
    COP [01] ( &asciistring_024D1B ) ; {150573}
    RTL                   ; {150577}
}

code_024C32 {
    COP [91]              ; {150578}
    COP [0D] ( #00, #0B, #30, &code_024C3C ) ; {150580}
    RTL                   ; {150587}
}

code_024C3C {
    COP [01] ( &asciistring_024D45 ) ; {150588}
    BRK #$5E              ; {150592}
    COP [0A] ( #28 )      ; {150594}
    COP [86]              ; {150597}
    RTL                   ; {150599}
}

asciistring_024C48 |[10]I am a guard- [N]But I am tired of my [N]job- [N]I came here to relax- [FIN][0F]While listening to the[N]guard, [02:2] sees a[N]card under the guard s[N]feet- [FIN]But [02:2] can t [N]get it because the [N]guard is standing on [N]it- [0F][JMP:&asciistring_0270DF]|

asciistring_024CDF |[10]I love listening to [N]music from the front [N]row- [FIN]Please do not bother [N]me- [JMP:&asciistring_0270DF]|

asciistring_024D1B |[10]I am a guard, [N]I am tired of my job- [N]I came here to relax- [JMP:&asciistring_0270DF]|

asciistring_024D45 |[10][02:2] found [N][03:24]a card- [03:20][JMP:&asciistring_0270DF]|

code_024D59 {
    COP [14] ( #$0172, &code_024D60 ) ; {150873}
    RTL                   ; {150879}
}

code_024D60 {
    COP [85] ( @chunk_000000.code_00299D ) ; {150880}
    COP [17] ( &code_024D6E ) ; {150885}
    COP [15]              ; {150889}
    COP [91]              ; {150891}
    RTL                   ; {150893}
}

code_024D6E {
    COP [01] ( &asciistring_024D73 ) ; {150894}
    RTL                   ; {150898}
}

asciistring_024D73 |[10]I have a friend who [N]once disobeyed King [N]Magridd- He wanted to [N]save Dr-Leo- [FIN]He was taken to the [N]torture room in the [N]first basement and [N]never came back- [FIN]"This harp string is a[N]birthday present from [N]my friend- [FIN]I am able to play [N]great music with this [N]string-ˮ [FIN]He always told me I [N]could- [JMP:&asciistring_0270DF]|

code_024E53 {
    COP [14] ( #$0187, &code_024E5A ) ; {151123}
    RTL                   ; {151129}
}

code_024E5A {
    COP [91]              ; {151130}
    COP [0D] ( #00, #39, #2F, &code_024E70 ) ; {151132}
    RTL                   ; {151139}
}

code_024E64 {
    COP [91]              ; {151140}
    COP [0D] ( #00, #39, #2F, &code_024E6F ) ; {151142}
    BRA code_024E5A       ; {151149}
}

code_024E6F {
    RTL                   ; {151151}
}

code_024E70 {
    COP [01] ( &asciistring_024E9D ) ; {151152}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_024E97 ) ; {151156}
    LDA $0003D0           ; {151163}
    BNE code_024E97       ; {151167}
    COP [18] ( #38, &code_024E8C ) ; {151169}
    COP [01] ( &asciistring_024F0E ) ; {151174}
    BRA code_024E64       ; {151178}
}

code_024E8C {
    COP [01] ( &asciistring_024EB9 ) ; {151180}
    BRK #$5E              ; {151184}
    COP [0A] ( #38 )      ; {151186}
    BRA code_024E64       ; {151189}
}

code_024E97 {
    COP [01] ( &asciistring_024F27 ) ; {151191}
    BRA code_024E64       ; {151195}
}

asciistring_024E9D |[10]You want Medical Herbs[N]don t you? [END]|

asciistring_024EB9 |[10]See? [N]I have the ability to [N]read peoples  minds- [FIN]Here I will give you [N]one- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&asciistring_0270DF]|

asciistring_024F0E |[10]Hey, you already have [N]one- [JMP:&asciistring_0270DF]|

asciistring_024F27 |[10]Oh, I guess my ability[N]is not perfect- [JMP:&asciistring_0270DF]|

code_024F4A {
    COP [3B] ( #$017E, &code_024F60 ) ; {151370}
    COP [17] ( &chunk_020000.code_02229E ) ; {151376}
    SEP #$20              ; {151380}
    LDA #$^chunk_000000.code_00305F ; {151382}
    PHA                   ; {151384}
    REP #$20              ; {151385}
    LDA #$&chunk_000000.code_00305F-1 ; {151387}
    PHA                   ; {151390}
    RTL                   ; {151391}
}

code_024F60 {
    COP [85] ( @chunk_000000.code_00299D ) ; {151392}
    COP [17] ( &code_024F6E ) ; {151397}
    COP [15]              ; {151401}
    COP [91]              ; {151403}
    RTL                   ; {151405}
}

code_024F6E {
    COP [01] ( &asciistring_024F73 ) ; {151406}
    RTL                   ; {151410}
}

asciistring_024F73 |[10]Music is really [N]strange- [FIN]The same music [N]sometimes sounds very [N]wonderful when I am [N]happy [FIN]and sad when I am [N]depressed- [JMP:&asciistring_0270DF]|

code_024FD3 {
    COP [14] ( #$016B, &code_024FDA ) ; {151507}
    RTL                   ; {151513}
}

code_024FDA {
    COP [14] ( #$0185, &code_024FE9 ) ; {151514}
    COP [17] ( &code_025015 ) ; {151520}
    COP [15]              ; {151524}
    COP [91]              ; {151526}
    RTL                   ; {151528}
}

code_024FE9 {
    COP [A1] ( #$0010, #$0030 ) ; {151529}
    COP [17] ( &code_02501A ) ; {151535}
    COP [96]              ; {151539}
    COP [80] ( #0E )      ; {151541}
    COP [82]              ; {151544}
    COP [15]              ; {151546}
    COP [91]              ; {151548}
    COP [0D] ( #00, #1C, #33, &code_025006 ) ; {151550}
    RTL                   ; {151557}
}

code_025006 {
    COP [03] ( #05 )      ; {151558}
    COP [04]              ; {151561}
    COP [97]              ; {151563}
    COP [80] ( #0E )      ; {151565}
    COP [82]              ; {151568}
    COP [91]              ; {151570}
    RTL                   ; {151572}
}

code_025015 {
    COP [01] ( &asciistring_02501F ) ; {151573}
    RTL                   ; {151577}
}

code_02501A {
    COP [01] ( &asciistring_025053 ) ; {151578}
    RTL                   ; {151582}
}

asciistring_02501F |[10]This is the [N]soldiers  dormitory- [FIN]I am taking care of [N]them- [JMP:&asciistring_0270DF]|

asciistring_025053 |[10]Oh, I was just [N]removing a speck of [N]dust from his eye- [JMP:&asciistring_0270DF]|

code_025080 {
    COP [14] ( #$0182, &code_025087 ) ; {151680}
    RTL                   ; {151686}
}

code_025087 {
    COP [07] ( #$8805, &code_0250B5 ) ; {151687}
    COP [85] ( @chunk_000000.code_00299D ) ; {151693}
    COP [17] ( &code_0250B8 ) ; {151698}
    COP [15]              ; {151702}
    COP [05] ( #$0700 )   ; {151704}
    COP [17] ( &code_0250CB ) ; {151708}
    COP [16]              ; {151712}
    COP [97]              ; {151714}
    COP [80] ( #17 )      ; {151716}
    COP [82]              ; {151719}
    COP [96]              ; {151721}
    COP [80] ( #14 )      ; {151723}
    COP [82]              ; {151726}
    COP [15]              ; {151728}
    COP [91]              ; {151730}
    RTL                   ; {151732}
}

code_0250B5 {
    COP [86]              ; {151733}
    RTL                   ; {151735}
}

code_0250B8 {
    COP [19] ( #29, &code_0250C6 ) ; {151736}
    COP [01] ( &asciistring_025133 ) ; {151741}
    COP [09] ( #$8700 )   ; {151745}
    RTL                   ; {151749}
}

code_0250C6 {
    COP [01] ( &asciistring_0250D0 ) ; {151750}
    RTL                   ; {151754}
}

code_0250CB {
    COP [01] ( &asciistring_02512F ) ; {151755}
    RTL                   ; {151759}
}

asciistring_0250D0 |[10]This tower is [N]connected to the [N]airship s dock at the [N]top floor- [FIN]Anyone without a VIP [N]card cannot get in- [JMP:&asciistring_0270DF]|

asciistring_02512F |[10][JMP:&asciistring_025133+M]|

asciistring_025133 |[10]Oh, that is the VIP [N]card- [N]I am very sorry- [N][::]Please come in- [JMP:&asciistring_0270DF]|

code_02515B {
    COP [3B] ( #$0186, &code_025171 ) ; {151899}
    COP [17] ( &chunk_020000.code_02229E ) ; {151905}
    SEP #$20              ; {151909}
    LDA #$^chunk_000000.code_00305F ; {151911}
    PHA                   ; {151913}
    REP #$20              ; {151914}
    LDA #$&chunk_000000.code_00305F-1 ; {151916}
    PHA                   ; {151919}
    RTL                   ; {151920}
}

code_025171 {
    COP [85] ( @chunk_000000.code_00299D ) ; {151921}
    COP [17] ( &code_02517F ) ; {151926}
    COP [15]              ; {151930}
    COP [91]              ; {151932}
    RTL                   ; {151934}
}

code_02517F {
    COP [01] ( &asciistring_025184 ) ; {151935}
    RTL                   ; {151939}
}

asciistring_025184 |[10]I find a great [N]many things wandering [N]around- [FIN]I have seen something [N]shiny around the [N]castle- [FIN]But I did not pick up-[JMP:&asciistring_0270DF]|

code_0251DC {
    COP [14] ( #$0179, &code_0251E3 ) ; {152028}
    RTL                   ; {152034}
}

code_0251E3 {
    COP [30] ( #$0179, &code_02521A, #04 ) ; {152035}
    COP [17] ( &code_025203 ) ; {152042}
    COP [15]              ; {152046}
    COP [91]              ; {152048}
    COP [07] ( #$8604, &code_0251F9 ) ; {152050}
    RTL                   ; {152056}
}

code_0251F9 {
    COP [16]              ; {152057}
    COP [85] ( @chunk_000000.code_00299D ) ; {152059}
    COP [86]              ; {152064}
    RTL                   ; {152066}
}

code_025203 {
    COP [01] ( &asciistring_025266 ) ; {152067}
    BRK #$4E              ; {152071}
    COP [09] ( #$8604 )   ; {152073}
    SEP #$20              ; {152077}
    LDA $1B82             ; {152079}
    ORA #$10              ; {152082}
    STA $1B82             ; {152084}
    REP #$20              ; {152087}
    RTL                   ; {152089}
}

code_02521A {
    COP [01] ( &asciistring_025221 ) ; {152090}
    COP [86]              ; {152094}
    RTL                   ; {152096}
}

asciistring_025221 |[10][0E:3C]Someone is calling [N][02:2] from the [N]house- [FIN]I know everything [N]about the Magridd [N]Castle- [FIN]I will help you when [N]you come back- [JMP:&asciistring_0270DF]|

asciistring_025266 |[10]Even though I don t [N]look like it, [N]I am from the sky just[N]like you- [FIN]I know all of the [N]invisible passages in [N]the Magridd Castle- [FIN]Would you like to walk[N]the basement with me? [FIN]The soul that [N]knows the castle s [N]secret passages joins [N]you! [JMP:&asciistring_0270DF]|

code_025302 {
    COP [14] ( #$018C, &code_025309 ) ; {152322}
    RTL                   ; {152328}
}

code_025309 {
    COP [14] ( #$0195, &code_02531C ) ; {152329}
    COP [85] ( @chunk_000000.code_00299D ) ; {152335}
    COP [17] ( &code_02534D ) ; {152340}
    COP [15]              ; {152344}
    BRA loc_02532D        ; {152346}
}

code_02531C {
    COP [17] ( &code_025352 ) ; {152348}
    COP [9F] ( #$FFF0 )   ; {152352}
    COP [15]              ; {152356}
    COP [96]              ; {152358}
    COP [80] ( #14 )      ; {152360}
    COP [82]              ; {152363}

  loc_02532D:
    COP [91]              ; {152365}
    COP [0D] ( #00, #25, #0C, &code_025337 ) ; {152367}
    RTL                   ; {152374}
}

code_025337 {
    COP [07] ( #$9A07, &code_02534A ) ; {152375}
    COP [01] ( &asciistring_0253C3 ) ; {152381}
    BRK #$5E              ; {152385}
    COP [0A] ( #31 )      ; {152387}
    COP [09] ( #$9A07 )   ; {152390}
}

code_02534A {
    COP [91]              ; {152394}
    RTL                   ; {152396}
}

code_02534D {
    COP [01] ( &asciistring_025357 ) ; {152397}
    RTL                   ; {152401}
}

code_025352 {
    COP [01] ( &asciistring_025397 ) ; {152402}
    RTL                   ; {152406}
}

asciistring_025357 |[10]If King Magridd [N]doesn t come back, [N]then I will be crowned[N]the next King- [FIN]He, he, he- [JMP:&asciistring_0270DF]|

asciistring_025397 |[10]King Magridd is back- [N]Please do not tell [N]anybody what I have [N]said to you- [JMP:&asciistring_0270DF]|

asciistring_0253C3 |[10][02:2] found [N][03:24]the Master s Emblem H-[03:20][JMP:&asciistring_0270DF]|

code_0253E2 {
    COP [14] ( #$018D, &code_0253E9 ) ; {152546}
    RTL                   ; {152552}
}

code_0253E9 {
    COP [17] ( &code_0253F2 ) ; {152553}
    COP [15]              ; {152557}
    COP [91]              ; {152559}
    RTL                   ; {152561}
}

code_0253F2 {
    COP [14] ( #$0195, &code_0253FD ) ; {152562}
    COP [01] ( &asciistring_025402 ) ; {152568}
    RTL                   ; {152572}
}

code_0253FD {
    COP [01] ( &asciistring_025438 ) ; {152573}
    RTL                   ; {152577}
}

asciistring_025402 |[10]The key to the airship[N]has been stolen! [N]I don t know what is [N]going to happen- [JMP:&asciistring_0270DF]|

asciistring_025438 |[10]There appears to be a [N]fight on the airship s[N]dock- [FIN]It seems some of my [N]friends have passed [N]away- [FIN]I hate being a [N]soldier- [JMP:&asciistring_0270DF]|

code_0254A2 {
    COP [3B] ( #$018F, &code_0254B8 ) ; {152738}
    COP [17] ( &chunk_020000.code_02229E ) ; {152744}
    SEP #$20              ; {152748}
    LDA #$^chunk_000000.code_00305F ; {152750}
    PHA                   ; {152752}
    REP #$20              ; {152753}
    LDA #$&chunk_000000.code_00305F-1 ; {152755}
    PHA                   ; {152758}
    RTL                   ; {152759}
}

code_0254B8 {
    COP [85] ( @chunk_000000.code_00299D ) ; {152760}
    COP [17] ( &code_0254C6 ) ; {152765}
    COP [15]              ; {152769}
    COP [91]              ; {152771}
    RTL                   ; {152773}
}

code_0254C6 {
    COP [01] ( &asciistring_0254CB ) ; {152774}
    RTL                   ; {152778}
}

asciistring_0254CB |[10]Don t you think that [N]she s a nice girl- [N]She seems to know what[N]people want- [JMP:&asciistring_0270DF]|

code_025502 {
    COP [14] ( #$0192, &code_025509 ) ; {152834}
    RTL                   ; {152840}
}

code_025509 {
    COP [85] ( @chunk_000000.code_00299D ) ; {152841}
    COP [17] ( &code_025517 ) ; {152846}
    COP [15]              ; {152850}
    COP [91]              ; {152852}
    RTL                   ; {152854}
}

code_025517 {
    COP [01] ( &asciistring_02551C ) ; {152855}
    RTL                   ; {152859}
}

asciistring_02551C |[10]Phew! You scared me! [FIN]Don t sneak up behind [N]me- I almost fell into[N]the river- [JMP:&asciistring_0270DF]|

code_025561 {
    COP [3B] ( #$0195, &code_025577 ) ; {152929}
    COP [17] ( &chunk_020000.code_02229E ) ; {152935}
    SEP #$20              ; {152939}
    LDA #$^chunk_000000.code_00305F ; {152941}
    PHA                   ; {152943}
    REP #$20              ; {152944}
    LDA #$&chunk_000000.code_00305F-1 ; {152946}
    PHA                   ; {152949}
    RTL                   ; {152950}
}

code_025577 {
    COP [30] ( #$0195, &code_0255E4, #04 ) ; {152951}
    COP [07] ( #$9F02, &code_02559B ) ; {152958}
    COP [85] ( @chunk_000000.code_00299D ) ; {152964}
    COP [17] ( &code_0255C7 ) ; {152969}
    COP [15]              ; {152973}
    COP [05] ( #$0007 )   ; {152975}
    COP [80] ( #02 )      ; {152979}
    COP [82]              ; {152982}
    COP [91]              ; {152984}
    RTL                   ; {152986}
}

code_02559B {
    LDA #$BFC0            ; {152987}
    TSB $0326             ; {152990}
    COP [03] ( #29 )      ; {152993}
    COP [04]              ; {152996}
    COP [01] ( &asciistring_02580C ) ; {152998}
    COP [03] ( #5B )      ; {153002}
    COP [04]              ; {153005}
    LDA #$0020            ; {153007}
    STA $03B4             ; {153010}
    COP [10] ( #$030D, #01, #$00A0, #$0050 ) ; {153013}
    LDA #$BFC0            ; {153022}
    TRB $0326             ; {153025}
    COP [91]              ; {153028}
    RTL                   ; {153030}
}

code_0255C7 {
    COP [09] ( #$8007 )   ; {153031}
    COP [07] ( #$9B05, &code_0255DF ) ; {153035}
    COP [01] ( &asciistring_025639 ) ; {153041}
    BRK #$5E              ; {153045}
    COP [0A] ( #3F )      ; {153047}
    COP [09] ( #$9B05 )   ; {153050}
    RTL                   ; {153054}
}

code_0255DF {
    COP [01] ( &asciistring_0257CA ) ; {153055}
    RTL                   ; {153059}
}

code_0255E4 {
    COP [01] ( &asciistring_0255ED ) ; {153060}
    COP [37]              ; {153064}
    COP [86]              ; {153066}
    RTL                   ; {153068}
}

asciistring_0255ED |[10][0E:3C]I knew what was [N]happening- [FIN]I could do nothing to [N]prevent the Queen from[N]passing away- [JMP:&asciistring_0270DF]|

asciistring_025639 |[10]I have failed as [N]a King- [FIN]I ordered people to be[N]loyal to me- [FIN]And killed whomever [N]would not follow me- [FIN]Once you reach the top[N]the only way is down- [FIN]I was just a coward- [N]I made a promise with [N]the evil King [N]Deathtoll- [FIN]Simply because I [N]thought it would [N]impress the Queen- [FIN]But the Queen was [N]captured by her own [N]desire and passed [N]away- [FIN]I must apologize to [N]Dr-Leo- [FIN]I have [03:24]the Black Stone[N][03:20]with me- You must have[N]all 6 of these now- [FIN]Please go to the world[N]of evil and defeat [N]Deathtoll- [FIN]This is all I can do [N]for Dr-Leo- [JMP:&asciistring_0270DF]|

asciistring_0257CA |[10]I finally realized [N]what was happening [N]when the situation was[N]at its worst- [JMP:&asciistring_0270DF]|

asciistring_02580C |[10][0F]You finally made it! [N][0E:1E]First of all, let me [N]say thank you- [N][0E:5A]I started to think of [N]many things- [N][0E:5A]I know this may sound [N]strange but in the [N]human world, [N][0E:3C]if a person kills one [N]man he is a murderer- [N][0E:28]However, if a person [N]kills 100, [N]then he is praised as [N]a hero- [N][0E:5A]I became a king by [N]this theory, [N]but I always felt [N]lonely- [N][0E:5A]Even if I had many men[N][0E:2D]and beautiful women [N]around me, I felt [N]alone- [N][0E:5A]Now I realize no man [N]can live by himself- [N][0E:8C]I am going to spend [N]all the money I [N]received from [N]Deathtoll to construct[N]and build a great [N]town- [N][0E:5A]This is my way of [N]compensating the [N]people I helped [N]defeat- [N][0E:3C]But, I also want to [N]build a town where [N]people won t have [N]anything to fear- [N][0E:28]and they can begin to [N]believe in themselves-[N][0E:5A][02:2], [N]thank you very much- [N][0E:46]I will build statues [N]of you and Dr-Leo [N]in the center of town-[N][0E:28]I promise to tell [N]every generation about[N]your accomplishments- [0E:78][JMP:&asciistring_0270DF+M]|

code_025AAA {
    COP [3B] ( #$0185, &code_025AC0 ) ; {154282}
    COP [17] ( &chunk_020000.code_02229E ) ; {154288}
    SEP #$20              ; {154292}
    LDA #$^chunk_000000.code_00305F ; {154294}
    PHA                   ; {154296}
    REP #$20              ; {154297}
    LDA #$&chunk_000000.code_00305F-1 ; {154299}
    PHA                   ; {154302}
    RTL                   ; {154303}
}

code_025AC0 {
    COP [A1] ( #$FFE0, #$0020 ) ; {154304}
    COP [85] ( @chunk_000000.code_00299D ) ; {154310}
    COP [17] ( &code_025AF1 ) ; {154315}
    COP [97]              ; {154319}
    COP [80] ( #14 )      ; {154321}
    COP [82]              ; {154324}
    COP [15]              ; {154326}
    COP [91]              ; {154328}
    COP [0D] ( #00, #1C, #33, &code_025AE2 ) ; {154330}
    RTL                   ; {154337}
}

code_025AE2 {
    COP [03] ( #05 )      ; {154338}
    COP [04]              ; {154341}
    COP [96]              ; {154343}
    COP [80] ( #14 )      ; {154345}
    COP [82]              ; {154348}
    COP [91]              ; {154350}
    RTL                   ; {154352}
}

code_025AF1 {
    COP [01] ( &asciistring_025AF6 ) ; {154353}
    RTL                   ; {154357}
}

asciistring_025AF6 |[10]She was removing some [N]dust from my eye- [JMP:&asciistring_0270DF]|

code_025B1A {
    COP [14] ( #$016E, &code_025B21 ) ; {154394}
    RTL                   ; {154400}
}

code_025B21 {
    COP [30] ( #$016E, &code_025B98, #04 ) ; {154401}
    COP [07] ( #$8805, &code_025B81 ) ; {154408}
    COP [85] ( @chunk_000000.code_00299D ) ; {154414}
    COP [15]              ; {154419}
    COP [17] ( &code_025B93 ) ; {154421}
    COP [05] ( #$0000 )   ; {154425}
    COP [09] ( #$0000 )   ; {154429}
    COP [16]              ; {154433}
    COP [97]              ; {154435}
    COP [81] ( #17, #02 ) ; {154437}
    COP [83]              ; {154441}
    COP [01] ( &asciistring_025C7E ) ; {154443}
    COP [32] ( #00 )      ; {154447}
    COP [B2] ( &code_025B84, #04, #$0080, #$0000, #$0200 ) ; {154450}
    BRK #$5B              ; {154461}
    COP [05] ( #$0001 )   ; {154463}
    BRK #$04              ; {154467}
    LDA $0016, X          ; {154469}
    ORA #$0010            ; {154472}
    STA $0016, X          ; {154475}
    COP [97]              ; {154478}
    COP [80] ( #27 )      ; {154480}
    COP [82]              ; {154483}
    COP [81] ( #28, #08 ) ; {154485}
    COP [83]              ; {154489}
    COP [81] ( #29, #08 ) ; {154491}
    COP [83]              ; {154495}
}

code_025B81 {
    COP [86]              ; {154497}
    RTL                   ; {154499}
}

code_025B84 {
    COP [97]              ; {154500}
    COP [81] ( #25, #10 ) ; {154502}
    COP [83]              ; {154506}
    COP [09] ( #$8001 )   ; {154508}
    COP [86]              ; {154512}
    RTL                   ; {154514}
}

code_025B93 {
    COP [01] ( &asciistring_025C65 ) ; {154515}
    RTL                   ; {154519}
}

code_025B98 {
    COP [14] ( #$0183, &code_025BA3 ) ; {154520}
    COP [01] ( &asciistring_025BB3 ) ; {154526}
    RTL                   ; {154530}
}

code_025BA3 {
    COP [14] ( #$0181, &code_025BAE ) ; {154531}
    COP [01] ( &asciistring_025BEB ) ; {154537}
    RTL                   ; {154541}
}

code_025BAE {
    COP [01] ( &asciistring_025C22 ) ; {154542}
    RTL                   ; {154546}
}

asciistring_025BB3 |[10][0E:3C]Please save Dr-Leo- [N]He must be in the [N]prison of the left [N]tower!! [JMP:&asciistring_0270DF]|

asciistring_025BEB |[10][0E:3C]Please save my friend![N]He must be in the same[N]prison that Dr-Leo [N]is in- [JMP:&asciistring_0270DF]|

asciistring_025C22 |[10][0E:3C]Please come to the [N]airship dock as soon [N]as possible- [FIN]Dr-Leo is waiting for [N]you- [JMP:&asciistring_0270DF]|

asciistring_025C65 |[10]Are you [02:2]? [FIN]Please see to Dr-Leo- [JMP:&asciistring_0270DF]|

asciistring_025C7E |[10]Doctor, we can finally[N]start our ship- [JMP:&asciistring_0270DF]|

code_025CA6 {
    COP [14] ( #$0181, &code_025CAD ) ; {154790}
    RTL                   ; {154796}
}

code_025CAD {
    COP [07] ( #$8805, &code_025D40 ) ; {154797}
    COP [85] ( @chunk_000000.code_00299D ) ; {154803}
    COP [15]              ; {154808}
    COP [05] ( #$0001 )   ; {154810}
    COP [03] ( #65 )      ; {154814}
    COP [04]              ; {154817}
    COP [16]              ; {154819}
    COP [96]              ; {154821}
    COP [81] ( #2A, #02 ) ; {154823}
    COP [83]              ; {154827}
    COP [01] ( &asciistring_025D43 ) ; {154829}
    COP [32] ( #0D )      ; {154833}
    COP [B2] ( &code_025DA5, #04, #$0080, #$FFF0, #$0040 ) ; {154836}
    COP [B2] ( &code_025DCE, #04, #$0080, #$0000, #$0040 ) ; {154847}
    COP [B2] ( &code_025DFD, #04, #$0080, #$0010, #$0040 ) ; {154858}
    COP [B2] ( &code_025E26, #04, #$0090, #$0000, #$0040 ) ; {154869}
    COP [05] ( #$0002 )   ; {154880}
    COP [01] ( &asciistring_025D4D ) ; {154884}
    COP [09] ( #$8003 )   ; {154888}
    COP [03] ( #03 )      ; {154892}
    COP [05] ( #$0000 )   ; {154895}
    COP [09] ( #$0000 )   ; {154899}
    LDA $0000, X          ; {154903}
    SEC                   ; {154906}
    SBC #$0002            ; {154907}
    STA $0000, X          ; {154910}
    BRK #$44              ; {154913}
    COP [04]              ; {154915}
    COP [05] ( #$0004 )   ; {154917}
    COP [96]              ; {154921}
    COP [80] ( #27 )      ; {154923}
    COP [82]              ; {154926}
    COP [81] ( #28, #08 ) ; {154928}
    COP [83]              ; {154932}
    COP [81] ( #29, #08 ) ; {154934}
    COP [83]              ; {154938}
    COP [09] ( #$8005 )   ; {154940}
}

code_025D40 {
    COP [86]              ; {154944}
    RTL                   ; {154946}
}

asciistring_025D43 |[10]Dok!! [JMP:&asciistring_0270DF]|

asciistring_025D4D |[10]You are Queen Magridd![FIN]You destroyed the [N]world! [N]Didn t you realize?! [FIN][10]Shut up wimp! [FIN]Defeat him! [JMP:&asciistring_0270DF]|

code_025DA5 {
    COP [97]              ; {155045}
    COP [81] ( #17, #02 ) ; {155047}
    COP [83]              ; {155051}
    COP [05] ( #$0003 )   ; {155053}
    COP [03] ( #03 )      ; {155057}
    COP [80] ( #24 )      ; {155060}
    COP [82]              ; {155063}
    COP [B0] ( @code_025E4B, #$0040 ) ; {155065}
    COP [80] ( #2B )      ; {155072}
    COP [82]              ; {155075}
    COP [04]              ; {155077}
    COP [05] ( #$0006 )   ; {155079}
    COP [86]              ; {155083}
    RTL                   ; {155085}
}

code_025DCE {
    COP [97]              ; {155086}
    COP [81] ( #17, #02 ) ; {155088}
    COP [83]              ; {155092}
    COP [05] ( #$0003 )   ; {155094}
    COP [03] ( #03 )      ; {155098}
    COP [80] ( #24 )      ; {155101}
    COP [82]              ; {155104}
    COP [B0] ( @code_025E54, #$0040 ) ; {155106}
    BRK #$1B              ; {155113}
    COP [80] ( #2B )      ; {155115}
    COP [82]              ; {155118}
    COP [04]              ; {155120}
    COP [09] ( #$8004 )   ; {155122}
    COP [05] ( #$0006 )   ; {155126}
    COP [86]              ; {155130}
    RTL                   ; {155132}
}

code_025DFD {
    COP [97]              ; {155133}
    COP [81] ( #17, #02 ) ; {155135}
    COP [83]              ; {155139}
    COP [05] ( #$0003 )   ; {155141}
    COP [03] ( #03 )      ; {155145}
    COP [80] ( #24 )      ; {155148}
    COP [82]              ; {155151}
    COP [B0] ( @code_025E4B, #$0040 ) ; {155153}
    COP [80] ( #2B )      ; {155160}
    COP [82]              ; {155163}
    COP [04]              ; {155165}
    COP [05] ( #$0006 )   ; {155167}
    COP [86]              ; {155171}
    RTL                   ; {155173}
}

code_025E26 {
    COP [03] ( #51 )      ; {155174}
    COP [04]              ; {155177}
    COP [AA] ( #00 )      ; {155179}
    COP [97]              ; {155182}
    COP [81] ( #1A, #02 ) ; {155184}
    COP [83]              ; {155188}
    COP [80] ( #11 )      ; {155190}
    COP [82]              ; {155193}
    COP [03] ( #3D )      ; {155195}
    COP [04]              ; {155198}
    COP [09] ( #$8002 )   ; {155200}
    COP [05] ( #$0006 )   ; {155204}
    COP [86]              ; {155208}
    RTL                   ; {155210}
}

code_025E4B {
    COP [81] ( #25, #20 ) ; {155211}
    COP [83]              ; {155215}
    COP [86]              ; {155217}
    RTL                   ; {155219}
}

code_025E54 {
    COP [81] ( #25, #07 ) ; {155220}
    COP [83]              ; {155224}
    COP [09] ( #$8000 )   ; {155226}
    COP [86]              ; {155230}
    RTL                   ; {155232}
}

code_025E61 {
    COP [14] ( #$0183, &code_025E68 ) ; {155233}
    RTL                   ; {155239}
}

code_025E68 {
    COP [30] ( #$0183, &code_02601D, #04 ) ; {155240}
    COP [07] ( #$9F05, &code_025FDC ) ; {155247}
    COP [07] ( #$8805, &code_025FAF ) ; {155253}
    COP [85] ( @chunk_000000.code_00299D ) ; {155259}
    COP [15]              ; {155264}
    COP [14] ( #$016E, &code_025E8B ) ; {155266}
    BRL loc_025E91        ; {155272}
}

code_025E8B {
    COP [14] ( #$0181, &code_025E98 ) ; {155275}

  loc_025E91:
    COP [17] ( &code_025FDF ) ; {155281}
    COP [91]              ; {155285}
    RTL                   ; {155287}
}

code_025E98 {
    COP [17] ( &code_025FE4 ) ; {155288}
    COP [05] ( #$0001 )   ; {155292}
    COP [96]              ; {155296}
    COP [80] ( #23 )      ; {155298}
    COP [82]              ; {155301}
    PHX                   ; {155303}
    LDX $039C             ; {155304}
    LDA #$0003            ; {155307}
    STA $001E, X          ; {155310}
    STZ $0020, X          ; {155313}
    JSL $@chunk_000000.code_0008F3 ; {155316}
    PLX                   ; {155320}
    COP [05] ( #$0005 )   ; {155321}
    COP [16]              ; {155325}
    COP [81] ( #26, #02 ) ; {155327}
    COP [83]              ; {155331}
    COP [80] ( #23 )      ; {155333}
    COP [82]              ; {155336}
    COP [15]              ; {155338}
    COP [01] ( &asciistring_026240 ) ; {155340}
    COP [03] ( #1F )      ; {155344}
    COP [04]              ; {155347}
    COP [01] ( &asciistring_02626D ) ; {155349}
    COP [03] ( #3D )      ; {155353}
    COP [04]              ; {155356}
    COP [01] ( &asciistring_0262A0 ) ; {155358}
    COP [B2] ( &code_0266E8, #04, #$0040, #$FF70, #$0040 ) ; {155362}
    COP [B2] ( &code_026961, #04, #$0040, #$FF60, #$0040 ) ; {155373}
    COP [05] ( #$0007 )   ; {155384}
    COP [01] ( &asciistring_0262B9 ) ; {155388}
    COP [03] ( #1F )      ; {155392}
    COP [04]              ; {155395}
    COP [01] ( &asciistring_0262ED ) ; {155397}
    COP [03] ( #5B )      ; {155401}
    COP [04]              ; {155404}
    LDA #$0004            ; {155406}
    STA $1B84             ; {155409}
    COP [01] ( &asciistring_026382 ) ; {155412}
    LDA #$0003            ; {155416}
    STA $1B84             ; {155419}
    COP [03] ( #1F )      ; {155422}
    COP [04]              ; {155425}
    COP [01] ( &asciistring_026458 ) ; {155427}
    COP [09] ( #$0007 )   ; {155431}
    COP [05] ( #$0007 )   ; {155435}
    COP [01] ( &asciistring_02648E ) ; {155439}
    LDA #$6FC0            ; {155443}
    TRB $0326             ; {155446}
    COP [91]              ; {155449}
    COP [0D] ( #00, #1E, #18, &code_025F43 ) ; {155451}
    RTL                   ; {155458}
}

code_025F43 {
    LDA #$6FC0            ; {155459}
    TSB $0326             ; {155462}
    COP [01] ( &asciistring_0264C3 ) ; {155465}
    BRK #$5E              ; {155469}
    COP [0A] ( #23 )      ; {155471}
    COP [03] ( #1F )      ; {155474}
    COP [04]              ; {155477}
    COP [01] ( &asciistring_026509 ) ; {155479}
    COP [16]              ; {155483}
    COP [80] ( #26 )      ; {155485}
    COP [82]              ; {155488}
    COP [80] ( #23 )      ; {155490}
    COP [82]              ; {155493}
    COP [03] ( #3D )      ; {155495}
    COP [04]              ; {155498}
    COP [01] ( &asciistring_026533 ) ; {155500}
    COP [80] ( #26 )      ; {155504}
    COP [82]              ; {155507}
    COP [80] ( #23 )      ; {155509}
    COP [82]              ; {155512}
    COP [B0] ( @code_02699C, #$0300 ) ; {155514}
    COP [03] ( #3D )      ; {155521}
    COP [04]              ; {155524}
    COP [80] ( #22 )      ; {155526}
    COP [82]              ; {155529}
    COP [15]              ; {155531}
    COP [05] ( #$0006 )   ; {155533}
    COP [03] ( #15 )      ; {155537}
    COP [04]              ; {155540}
    COP [31] ( #13 )      ; {155542}
    COP [03] ( #79 )      ; {155545}
    COP [04]              ; {155548}
    COP [09] ( #$8805 )   ; {155550}
    LDA #$6FC0            ; {155554}
    TRB $0326             ; {155557}

  loc_025FA8:
    COP [17] ( &code_025FF7 ) ; {155560}
    COP [91]              ; {155564}
    RTL                   ; {155566}
}

code_025FAF {
    COP [07] ( #$8900, &code_025FC2 ) ; {155567}
    COP [AC] ( @code_0266FC, #$0230, #$0180, #$0040 ) ; {155573}
    BRA loc_025FCD        ; {155584}
}

code_025FC2 {
    COP [AC] ( @code_02670A, #$0220, #$0190, #$0040 ) ; {155586}

  loc_025FCD:
    COP [9F] ( #$0080 )   ; {155597}
    COP [96]              ; {155601}
    COP [80] ( #22 )      ; {155603}
    COP [82]              ; {155606}
    COP [15]              ; {155608}
    BRA loc_025FA8        ; {155610}
}

code_025FDC {
    COP [86]              ; {155612}
    RTL                   ; {155614}
}

code_025FDF {
    COP [01] ( &asciistring_0260F6 ) ; {155615}
    RTL                   ; {155619}
}

code_025FE4 {
    COP [01] ( &asciistring_026144 ) ; {155620}
    LDA #$6FC0            ; {155624}
    TSB $0326             ; {155627}
    COP [09] ( #$8000 )   ; {155630}
    COP [17] ( #$0000 )   ; {155634}
    RTL                   ; {155638}
}

code_025FF7 {
    COP [07] ( #$8900, &code_026018 ) ; {155639}
    COP [07] ( #$8901, &code_026018 ) ; {155645}
    LDA #$0004            ; {155651}
    STA $1B84             ; {155654}
    COP [01] ( &asciistring_026551 ) ; {155657}
    LDA #$0003            ; {155661}
    STA $1B84             ; {155664}
    COP [09] ( #$8901 )   ; {155667}
    RTL                   ; {155671}
}

code_026018 {
    COP [01] ( &asciistring_0266DB ) ; {155672}
    RTL                   ; {155676}
}

code_02601D {
    COP [14] ( #$0181, &code_026025 ) ; {155677}
    BRA loc_02602B        ; {155683}
}

code_026025 {
    COP [14] ( #$016E, &code_026032 ) ; {155685}

  loc_02602B:
    COP [01] ( &asciistring_0260F0 ) ; {155691}
    COP [86]              ; {155695}
    RTL                   ; {155697}
}

code_026032 {
    COP [01] ( &asciistring_026039 ) ; {155698}
    COP [86]              ; {155702}
    RTL                   ; {155704}
}

asciistring_026039 |[10][0E:3C]I am Dr-Leo- [N]I have been watching [N]from the darkness- [FIN]I am going to retrieve[N]the Black Stone, go [N]to the World of Evil [N]and defeat Deathtoll- [FIN]I hope you will come [N]with me- [FIN]The airship dock is at[N]the top floor of the [N]right tower- [FIN]I will be waiting for [N]you- [JMP:&asciistring_0270DF]|

asciistring_0260F0 |[10][0E:3C][JMP:&asciistring_0260F6+M]|

asciistring_0260F6 |[10][::]I am Dr-Leo- [N]I will save the story [N]for later- [FIN]Please save the two [N]soldiers who promised [N]to come with me- [JMP:&asciistring_0270DF]|

asciistring_026144 |[10]You are [02:2]- [N]Birds from GreenWood [N]told me of you- [FIN]The stones you have [N]collected are keys to [N]open the gate to the [N]World of Evil- [FIN]They are the Origins [N]of Power for machines [N]that beckon evil- [FIN]King Magridd holds the[N]last stone- [FIN]We have to free him to[N]get the last stone- [FIN]Go then to the World [N]of Evil and defeat [N]Deathtoll- [JMP:&asciistring_0270DF]|

asciistring_02623C |[10][JMP:&asciistring_0270DF]|

asciistring_026240 |[10]You took everything [N]away from me- [FIN]You are dirtier than [N]evil! [JMP:&asciistring_0270DF]|

asciistring_02626D |[10]Dr-Leo, you talk too [N]much- [FIN]Life is never easy- [N]Look! [JMP:&asciistring_0270DF]|

asciistring_0262A0 |[10]Hey, keep walking- [0E:28][JMP:&asciistring_0270DF+M]|

asciistring_0262B9 |[10]Daddy! [FIN]Daddy! I knew [N]I would see you, [N]but not like this---- [JMP:&asciistring_0270DF]|

asciistring_0262ED |[10]Dr-Leo, [N]you will still do what[N]I say? [FIN][10]You-------- [FIN]As you said, I made a [N]machine to call [N]Deathtoll! [FIN]Lisa has nothing to do[N]with this- [FIN][10]Shut up! [FIN]Dr-Leo, you still [N]have to work for us- [JMP:&asciistring_0270DF]|

asciistring_026382 |[10]All right- [FIN]I cannot sacrifice [N]peoples  lives [N]anymore- [FIN]But please, release [N]Lisa- [FIN]She is the most [N]precious thing in this[N]world- [FIN]Even if I could not [N]see her, she would [N]still be my [N]motivation- [FIN]I can endure anything [N]by just imagining her [N]face- [JMP:&asciistring_0270DF]|

asciistring_026458 |[10]You are an honest man-[FIN]All right, Dr-Leo- [N]Leave Lisa alone- [JMP:&asciistring_0270DF]|

asciistring_02648E |[10][0F]Leo whispered in [N][02:2] s ears- [0F][FIN][0A][02:2],[N]stay█behind█me----[JMP:&asciistring_0270DF]|

asciistring_0264C3 |[10][0A]Here,█take█this█and[N]get█on█the█airship-[FIN]Please█take█care█of[N]Lisa-[JMP:&asciistring_0270DF]|

asciistring_026509 |[10]I will not run away- [N]Just take me wherever [N]you want- [JMP:&asciistring_0270DF]|

asciistring_026533 |[10][0F]Lisa, [N][0E:3C]please forgive me- [N][0E:50][JMP:&asciistring_0270DF+M]|

asciistring_026551 |[10][02:2], I think [N]I was born in the [N]wrong generation- [FIN]Scientists are [N]supposed to invent [N]machines in order to [N]make people happy- [FIN]But an unexpected [N]scientist may ruin the[N]culture- [FIN]Some people believe [N]happiness comes [N]quickly, [FIN]I think it comes with [N]patientce- [FIN]Lisa, I am sorry for [N]leaving you- [FIN]I am not passing away,[N]rather, [N]I am going to sleep- [FIN]When a scientist with [N]my knowledge is [N]needed, I will be [N]back- [FIN][0A]Lisa,█be█happy-[N]But█don t█rush[N]yourself-[N][0E:28]Yes,█gradually--------[JMP:&asciistring_0270DF]|

asciistring_0266DB |[10]-------- [JMP:&asciistring_0270DF]|

code_0266E8 {
    COP [81] ( #09, #03 ) ; {157416}
    COP [83]              ; {157420}
    COP [80] ( #03 )      ; {157422}
    COP [82]              ; {157425}
    COP [05] ( #$0006 )   ; {157427}
    COP [80] ( #09 )      ; {157431}
    COP [82]              ; {157434}
}

code_0266FC {
    COP [80] ( #03 )      ; {157436}
    COP [82]              ; {157439}
    COP [15]              ; {157441}
    COP [17] ( &code_026736 ) ; {157443}
    COP [91]              ; {157447}
    RTL                   ; {157449}
}

code_02670A {
    COP [07] ( #$8902, &code_026723 ) ; {157450}
    COP [97]              ; {157456}
    COP [80] ( #08 )      ; {157458}
    COP [82]              ; {157461}
    COP [15]              ; {157463}
    COP [17] ( &code_02673B ) ; {157465}
    COP [05] ( #$0902 )   ; {157469}
    COP [16]              ; {157473}
}

code_026723 {
    COP [17] ( &code_026753 ) ; {157475}
    COP [80] ( #09 )      ; {157479}
    COP [82]              ; {157482}
    COP [80] ( #06 )      ; {157484}
    COP [82]              ; {157487}
    COP [15]              ; {157489}
    COP [91]              ; {157491}
    RTL                   ; {157493}
}

code_026736 {
    COP [01] ( &asciistring_026758 ) ; {157494}
    RTL                   ; {157498}
}

code_02673B {
    COP [01] ( &asciistring_026772 ) ; {157499}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_026746 ) ; {157503}
}

code_026746 {
    COP [01] ( &asciistring_026874 ) ; {157510}
    COP [17] ( &code_026753 ) ; {157514}
    COP [09] ( #$8902 )   ; {157518}
    RTL                   ; {157522}
}

code_026753 {
    COP [01] ( &asciistring_026921 ) ; {157523}
    RTL                   ; {157527}
}

asciistring_026758 |[10][0F]Lisa just keeps [N]crying- [JMP:&asciistring_0270DF]|

asciistring_026772 |[10]Hello- Thank you for [N]staying with me while [N]my father passed away-[FIN]I didn t think I would[N]see him again- [FIN]But because of you I [N]was finally able to [N]see him again- [FIN]Ever since you saved [N]me at Grass Valley, [N]I imagined you [N]fighting monsters [N]whenever I closed my [N]eyes- [FIN]By the way, [N]I would like you to [N]answer my questions- [FIN]Are you a real human [N]being like me? [END]|

asciistring_026874 |I see --------- [FIN]I feel like you are [N]far away even though [N]you are right in front[N]of me- [FIN]I feel like you are [N]watching us from the [N]sky- [FIN]I don t know how to [N]express the way I [N]feel- [FIN]But that is okay, [N]I, I love--- [FIN]You are going to fight[N]Deathtoll, right? [FIN][JMP:&asciistring_026921+M]|

asciistring_026921 |[10][::]I would say goodbye, [N]but I know I am going [N]to cry- [FIN]Please leave while my [N]back is turned- [JMP:&asciistring_0270DF]|

code_026961 {
    COP [81] ( #15, #03 ) ; {158049}
    COP [83]              ; {158053}
    COP [80] ( #12 )      ; {158055}
    COP [82]              ; {158058}
    COP [09] ( #$8007 )   ; {158060}
    COP [05] ( #$8007 )   ; {158064}
    LDA $0016, X          ; {158068}
    ORA #$1000            ; {158071}
    STA $0016, X          ; {158074}
    COP [96]              ; {158077}
    COP [80] ( #17 )      ; {158079}
    COP [82]              ; {158082}
    COP [81] ( #15, #03 ) ; {158084}
    COP [83]              ; {158088}
    COP [97]              ; {158090}
    COP [80] ( #17 )      ; {158092}
    COP [82]              ; {158095}
    COP [09] ( #$8007 )   ; {158097}
    COP [05] ( #$0006 )   ; {158101}
    COP [86]              ; {158105}
    RTL                   ; {158107}
}

code_02699C {
    COP [03] ( #40 )      ; {158108}
    COP [B0] ( @code_0269B5, #$0300 ) ; {158111}
    COP [1B] ( &code_0269AC, #$0002 ) ; {158118}
}

code_0269AC {
    COP [04]              ; {158124}
    COP [09] ( #$8006 )   ; {158126}
    COP [86]              ; {158130}
    RTL                   ; {158132}
}

code_0269B5 {
    COP [A8] ( #$8000, #0E ) ; {158133}
    COP [A3]              ; {158138}
    LDA $0372             ; {158140}
    STA $001C, X          ; {158143}
    JSR $&code_0269CF     ; {158146}
    BRK #$85              ; {158149}
    COP [80] ( #00 )      ; {158151}
    COP [82]              ; {158154}
    COP [86]              ; {158156}
    RTL                   ; {158158}
}

code_0269CF {
    COP [1F]              ; {158159}
    COP [35] ( #40 )      ; {158161}
    LDA $0437             ; {158164}
    SEC                   ; {158167}
    SBC #$0020            ; {158168}
    CLC                   ; {158171}
    ADC $0000, X          ; {158172}
    STA $0000, X          ; {158175}
    COP [1F]              ; {158178}
    COP [35] ( #40 )      ; {158180}
    LDA $0437             ; {158183}
    SEC                   ; {158186}
    SBC #$0020            ; {158187}
    CLC                   ; {158190}
    ADC $0002, X          ; {158191}
    STA $0002, X          ; {158194}
    RTS                   ; {158197}
}

code_0269F6 {
    COP [07] ( #$8702, &code_026A13 ) ; {158198}
    COP [91]              ; {158204}
    COP [0D] ( #00, #28, #05, &code_026A06 ) ; {158206}
    RTL                   ; {158213}
}

code_026A06 {
    COP [01] ( &asciistring_026A16 ) ; {158214}
    BRK #$5E              ; {158218}
    COP [0A] ( #1A )      ; {158220}
    COP [09] ( #$8702 )   ; {158223}
}

code_026A13 {
    COP [86]              ; {158227}
    RTL                   ; {158229}
}

asciistring_026A16 |[10]The body is holding [N]something- [FIN][02:2] found [N]"[03:24]harp string-[03:20]ˮ [JMP:&asciistring_0270DF]|

code_026A4E {
    LDA #$2C81            ; {158286}
    STA $7F0000           ; {158289}
    COP [03] ( #02 )      ; {158293}
    COP [04]              ; {158296}
    COP [34]              ; {158298}
    LDA #$6FC0            ; {158300}
    TSB $0326             ; {158303}
    COP [80] ( #23 )      ; {158306}
    COP [82]              ; {158309}
    COP [03] ( #3D )      ; {158311}
    COP [04]              ; {158314}
    COP [01] ( &asciistring_026AA6 ) ; {158316}
    COP [80] ( #1F )      ; {158320}
    COP [82]              ; {158323}
    COP [03] ( #1F )      ; {158325}
    COP [04]              ; {158328}
    COP [01] ( &asciistring_026C9D ) ; {158330}
    COP [09] ( #$8000 )   ; {158334}
    COP [05] ( #$0001 )   ; {158338}
    COP [03] ( #1F )      ; {158342}
    COP [04]              ; {158345}
    COP [01] ( &asciistring_026CBE ) ; {158347}
    COP [09] ( #$8803 )   ; {158351}
    COP [3C] ( #04 )      ; {158355}
}

code_026A96 {
    COP [10] ( #$0110, #01, #$0020, #$01F0 ) ; {158358}
    LDA #$6FC0            ; {158367}
    TRB $0326             ; {158370}
    RTL                   ; {158373}
}

asciistring_026AA6 |[10]I have been haunted by[N]a monster called [N]"research-ˮ [FIN]I would not pay [N]attention to my wife [N]and daughter- [FIN]Still I didn t [N]understand- [FIN]I was praised as a [N]genius, scientist and [N]even the King often [N]gave me orders- [FIN]I kept inventing [N]things, Water Mill, [N]Elevator, and even [N]this Airship- [FIN]Finally I invented [N]a machine to call upon[N]evil, only to [N]realize something- [FIN]Tools are there to [N]make peoples  lives [N]easier- [FIN]But when tools start [N]to use people, [FIN]their culture will [N]decline and they will [N]become unhappy- [FIN]When I get to the [N]World of Evil, [N]Deathtoll will be [N]called- [FIN]I don t want to [N]believe this beautiful[N]world will be [N]destroyed- [JMP:&asciistring_0270DF]|

asciistring_026C9D |[10]Please, let me off [N]somewhere! [JMP:&asciistring_0270DF]|

asciistring_026CBE |[10]Dr-Leo, [N]you may be right- [FIN]But I must take you to[N]Magridd castle and [N]make sure you do not [N]escape- [FIN]I have to worry about [N]the present, [N]not tomorrow- [FIN]I must do my job or be[N]punished- [FIN]Please try to [N]understand this- [JMP:&asciistring_0270DF]|

code_026D61 {
    COP [80] ( #14 )      ; {159073}
    COP [82]              ; {159076}
    COP [05] ( #$0000 )   ; {159078}
    COP [80] ( #13 )      ; {159082}
    COP [82]              ; {159085}
    COP [09] ( #$8001 )   ; {159087}
    COP [91]              ; {159091}
    RTL                   ; {159093}
}

code_026D76 {
    COP [15]              ; {159094}
    COP [80] ( #13 )      ; {159096}
    COP [82]              ; {159099}
    COP [91]              ; {159101}
    RTL                   ; {159103}
}

code_026D80 {
    COP [14] ( #$0195, &code_026D8C ) ; {159104}
    COP [3B] ( #$0195, &code_026D9E ) ; {159110}
}

code_026D8C {
    LDA $0016, X          ; {159116}
    AND #$FFEF            ; {159119}
    STA $0016, X          ; {159122}
    COP [91]              ; {159125}
    COP [0D] ( #00, #17, #0F, &code_026D9F ) ; {159127}
}

code_026D9E {
    RTL                   ; {159134}
}

code_026D9F {
    COP [01] ( &asciistring_026DB6 ) ; {159135}
    COP [09] ( #$8900 )   ; {159139}
    STZ $0419             ; {159143}
    BRK #$91              ; {159146}
    COP [10] ( #$0113, #01, #$0170, #$00F0 ) ; {159148}
    RTL                   ; {159157}
}

asciistring_026DB6 |[10][02:2] drove [N]the Airship back to [N]the dock- [JMP:&asciistring_0270DF]|

code_026DD7 {
    COP [14] ( #$0184, &code_026DDE ) ; {159191}
    RTL                   ; {159197}
}

code_026DDE {
    JSL $@chunk_018000.code_01B161 ; {159198}
    COP [17] ( &code_026E75 ) ; {159202}
    SEP #$20              ; {159206}
    LDA #$^chunk_020000.code_022289 ; {159208}
    PHA                   ; {159210}
    REP #$20              ; {159211}
    LDA #$&chunk_020000.code_022289-1 ; {159213}
    PHA                   ; {159216}
    RTL                   ; {159217}
}
---------------------------------------------

asciistring_026DF2 |[10]There are many [N]treasure chests hidden[N]in the basements and [N]towers- [FIN]If a soldier, the one [N]who knows a lot about [N]the Magridd castle [N]joins you, [FIN]then the treasures [N]will be found easily- [FIN][END]|

code_026E75 {
    COP [01] ( &asciistring_026DF2 ) ; {159349}

  loc_026E79:
    COP [01] ( &asciistring_027090 ) ; {159353}
    COP [1A] ( &chunk_010000.asciistring_014F5B, #02, &code_026E98 ) ; {159357}
    LDA $0003D0           ; {159364}
    BEQ code_026E98       ; {159368}
    COP [01] ( &asciistring_0270B8 ) ; {159370}
    COP [10] ( #$0110, #00, #$01F0, #$0140 ) ; {159374}
    RTL                   ; {159383}
}

code_026E98 {
    COP [01] ( &asciistring_0270CB ) ; {159384}
    RTL                   ; {159388}
}

code_026E9D {
    COP [14] ( #$0163, &code_026EA4 ) ; {159389}
    RTL                   ; {159395}
}

code_026EA4 {
    JSL $@chunk_018000.code_01B161 ; {159396}
    COP [17] ( &code_026F29 ) ; {159400}
    SEP #$20              ; {159404}
    LDA #$^chunk_020000.code_022289 ; {159406}
    PHA                   ; {159408}
    REP #$20              ; {159409}
    LDA #$&chunk_020000.code_022289-1 ; {159411}
    PHA                   ; {159414}
    RTL                   ; {159415}
}
---------------------------------------------

asciistring_026EB8 |[10]The Zantetsu Sword is [N]found in Leo s [N]laboratory- [FIN]And the Spirit Sword [N]in this castle----- [FIN]try to remember where [N]the invincible [N]monsters are- [FIN][END]|

code_026F29 {
    COP [01] ( &asciistring_026EB8 ) ; {159529}
    BRL loc_026E79        ; {159533}
}

code_026F30 {
    COP [19] ( #0F, &code_026F36 ) ; {159536}
    RTL                   ; {159541}
}

code_026F36 {
    LDA #$0088            ; {159542}
    JSL $@chunk_0270E4.code_027462 ; {159545}
    BCS loc_026F40        ; {159549}
    RTL                   ; {159551}

  loc_026F40:
    COP [39] ( #03 )      ; {159552}
    RTL                   ; {159555}
}

code_026F44 {
    DEC $038A             ; {159556}
    RTL                   ; {159559}
}

code_026F48 {
    LDA $038C             ; {159560}
    SEC                   ; {159563}
    SBC #$0008            ; {159564}
    STA $038C             ; {159567}
    RTL                   ; {159570}
}

code_026F53 {
    DEC $038C             ; {159571}
    RTL                   ; {159574}
}

code_026F57 {
    COP [07] ( #$8900, &code_026F69 ) ; {159575}
    COP [19] ( #23, &code_026F69 ) ; {159581}
    COP [0D] ( #00, #17, #0F, &code_026F6A ) ; {159586}
}

code_026F69 {
    RTL                   ; {159593}
}

code_026F6A {
    LDA #$2F80            ; {159594}
    TSB $0326             ; {159597}
    COP [1B] ( &code_026F76, #$0002 ) ; {159600}
}

code_026F76 {
    LDA $0016, X          ; {159606}
    AND #$FFEF            ; {159609}
    STA $0016, X          ; {159612}
    COP [01] ( &asciistring_026FF9 ) ; {159615}
    LDA $0016, X          ; {159619}
    ORA #$0010            ; {159622}
    STA $0016, X          ; {159625}
    BRK #$4F              ; {159628}
    COP [91]              ; {159630}
    LDA $033E             ; {159632}
    BEQ loc_026F99        ; {159635}
    DEC $038A             ; {159637}
    RTL                   ; {159640}

  loc_026F99:
    BRK #$4A              ; {159641}
    COP [1B] ( &code_026FA1, #$0046 ) ; {159643}
}

code_026FA1 {
    BRK #$91              ; {159649}
    COP [91]              ; {159651}
    LDA $0340             ; {159653}
    BEQ loc_026FAE        ; {159656}
    DEC $038C             ; {159658}
    RTL                   ; {159661}

  loc_026FAE:
    STZ $034E             ; {159662}
    STZ $0350             ; {159665}
    LDA #$0200            ; {159668}
    STA $0346             ; {159671}
    STA $0348             ; {159674}
    LDA #$0002            ; {159677}
    STA $0030, X          ; {159680}

  loc_026FC3:
    COP [03] ( #10 )      ; {159683}
    LDA $0340             ; {159686}
    SEC                   ; {159689}
    SBC $0030, X          ; {159690}
    STA $0340             ; {159693}
    COP [04]              ; {159696}
    INC $0030, X          ; {159698}
    LDA $0030, X          ; {159701}
    CMP #$0010            ; {159704}
    BCC loc_026FC3        ; {159707}
    STZ $0419             ; {159709}
    COP [10] ( #$0213, #01, #$0170, #$00F0 ) ; {159712}
    COP [03] ( #10 )      ; {159721}
    LDA $0340             ; {159724}
    SEC                   ; {159727}
    SBC $0030, X          ; {159728}
    STA $0340             ; {159731}
    COP [04]              ; {159734}
    RTL                   ; {159736}
}

asciistring_026FF9 |[10][02:2] plugged [N]in the starting key- [JMP:&asciistring_0270DF]|

code_027019 {
    SEP #$20              ; {159769}
    LDY #$&unk16_02702B   ; {159771}
    STY $03D8             ; {159774}
    LDA #$^unk16_02702B   ; {159777}
    STA $03DA             ; {159779}
    REP #$20              ; {159782}
    COP [86]              ; {159784}
    RTL                   ; {159786}
}
---------------------------------------------

unk16_02702B [
  unk16 < #16, #19, #06, #0D, #$0000, #$0001 >   ;00
  unk16 < #15, #17, #0D, #14, #$0000, #$0001 >   ;01
  unk16 < #18, #1A, #0D, #14, #$0000, #$0001 >   ;02
  unk16 < #17, #18, #10, #14, #$0000, #$0001 >   ;03
  unk16 < #13, #1C, #14, #1E, #$0000, #$0001 >   ;04
  unk16 < #13, #16, #1E, #23, #$0000, #$0001 >   ;05
  unk16 < #19, #1C, #1E, #23, #$0000, #$0001 >   ;06
  unk16 < #16, #19, #23, #29, #$0000, #$0001 >   ;07
]
---------------------------------------------

asciistring_02706C |[10]I am watching over [N]the world, [N]here take this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_027090 |[10]Would you like to [N]return to the outside [N]of Magridd Castle? [END]|

asciistring_0270B8 |Good luck then- [JMP:&asciistring_0270DF]|

asciistring_0270CB |Come back to me when [N]you feel like it- [JMP:&asciistring_0270DF]|

asciistring_0270DF |[12][::][08:408][END]|