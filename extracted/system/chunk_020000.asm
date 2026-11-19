?BANK 04

?INCLUDE 'chunk_000000'
?INCLUDE 'chunk_010000'
?INCLUDE 'chunk_018000'
?INCLUDE 'chunk_022523'
?INCLUDE 'chunk_0270E4'
?INCLUDE 'data_00F9F7'

---------------------------------------------

code_020000 {
    COP [14] ( #$00C9, &code_020007 ) ; {131072}
    RTL                   ; {131078}
}

code_020007 {
    COP [85] ( @chunk_000000.code_00299D ) ; {131079}
    COP [17] ( &code_020052 ) ; {131084}
    COP [15]              ; {131088}
    COP [05] ( #$0000 )   ; {131090}
    COP [16]              ; {131094}
    COP [17] ( #$0000 )   ; {131096}
    COP [97]              ; {131100}
    COP [81] ( #11, #02 ) ; {131102}
    COP [83]              ; {131106}
    COP [81] ( #10, #02 ) ; {131108}
    COP [83]              ; {131112}
    COP [81] ( #11, #06 ) ; {131114}
    COP [83]              ; {131118}
    COP [81] ( #10, #03 ) ; {131120}
    COP [83]              ; {131124}
    COP [96]              ; {131126}
    COP [80] ( #0E )      ; {131128}
    COP [82]              ; {131131}
    COP [17] ( &code_02005B ) ; {131133}
    COP [91]              ; {131137}
    COP [0D] ( #00, #0A, #07, &code_02004B ) ; {131139}
    RTL                   ; {131146}
}

code_02004B {
    COP [01] ( &asciistring_0200B8 ) ; {131147}
    COP [91]              ; {131151}
    RTL                   ; {131153}
}

code_020052 {
    COP [01] ( &asciistring_020060 ) ; {131154}
    COP [09] ( #$8000 )   ; {131158}
    RTL                   ; {131162}
}

code_02005B {
    COP [01] ( &asciistring_020095 ) ; {131163}
    RTL                   ; {131167}
}

asciistring_020060 |[10]My, my, it is rare to [N]see someone new- [N]Please come into my [N]room- [JMP:&asciistring_02251E]|

asciistring_020095 |[10]Please, sit right in [N]front of me- [JMP:&asciistring_02251E]|

asciistring_0200B8 |[10]I have so many [N]questions about human [N]beings- [FIN]Would you like to [N]discuss them with me? [JMP:&asciistring_02251E]|

code_0200F5 {
    COP [14] ( #$00D3, &code_0200FC ) ; {131317}
    RTL                   ; {131323}
}

code_0200FC {
    COP [17] ( &code_020119 ) ; {131324}
    COP [14] ( #$00EA, &code_02010F ) ; {131328}
    LDA $0016, X          ; {131334}
    AND #$FFF7            ; {131337}
    STA $0016, X          ; {131340}
}

code_02010F {
    COP [85] ( @chunk_000000.code_00299D ) ; {131343}
    COP [15]              ; {131348}
    COP [91]              ; {131350}
    RTL                   ; {131352}
}

code_020119 {
    COP [01] ( &asciistring_02011E ) ; {131353}
    RTL                   ; {131357}
}

asciistring_02011E |[10]My wife was able to [N]use magic at one time- [JMP:&asciistring_02251E]|

code_020143 {
    COP [3B] ( #$00EA, &code_020159 ) ; {131395}
    COP [17] ( &code_02229E ) ; {131401}
    SEP #$20              ; {131405}
    LDA #$^chunk_000000.code_00305F ; {131407}
    PHA                   ; {131409}
    REP #$20              ; {131410}
    LDA #$&chunk_000000.code_00305F-1 ; {131412}
    PHA                   ; {131415}
    RTL                   ; {131416}
}

code_020159 {
    COP [85] ( @chunk_000000.code_00299D ) ; {131417}
    COP [17] ( &code_02019A ) ; {131422}
    COP [15]              ; {131426}
    COP [91]              ; {131428}
    RTL                   ; {131430}
}

code_020167 {
    COP [B2] ( &chunk_022523.code_02299D, #00, #$0000, #$0010, #$0040 ) ; {131431}
    BRK #$4E              ; {131442}
    LDY $039C             ; {131444}
    LDA #$0100            ; {131447}
    STA $0000, Y          ; {131450}
    COP [03] ( #E1 )      ; {131453}
    COP [04]              ; {131456}
    BRK #$4E              ; {131458}
    LDY $039C             ; {131460}
    LDA #$0020            ; {131463}
    STA $0000, Y          ; {131466}
    LDA #$01A0            ; {131469}
    STA $0002, Y          ; {131472}
    COP [01] ( &asciistring_0201C8 ) ; {131475}
    COP [91]              ; {131479}
    RTL                   ; {131481}
}

code_02019A {
    COP [01] ( &asciistring_0201A2 ) ; {131482}
    COP [27] ( &code_020167 ) ; {131486}
}

asciistring_0201A2 |[10]Oh honey, I can still [N]use magic- [FIN]Look! [JMP:&asciistring_02251E]|

asciistring_0201C8 |[10]You see? [JMP:&asciistring_02251E]|

code_0201D2 {
    COP [14] ( #$00CC, &code_0201D9 ) ; {131538}
    RTL                   ; {131544}
}

code_0201D9 {
    COP [85] ( @chunk_000000.code_00299D ) ; {131545}
    COP [17] ( &code_0201E7 ) ; {131550}
    COP [15]              ; {131554}
    COP [91]              ; {131556}
    RTL                   ; {131558}
}

code_0201E7 {
    COP [14] ( #$00EB, &code_0201F2 ) ; {131559}
    COP [01] ( &asciistring_02021F ) ; {131565}
    RTL                   ; {131569}
}

code_0201F2 {
    COP [01] ( &asciistring_0201F7 ) ; {131570}
    RTL                   ; {131574}
}

asciistring_0201F7 |[10]We were really [N]happy just gazing at [N]each other- [JMP:&asciistring_02251E]|

asciistring_02021F |[10]Please save my [N]girlfriend- [JMP:&asciistring_02251E]|

code_020237 {
    COP [3B] ( #$00EB, &code_02024D ) ; {131639}
    COP [17] ( &code_02229E ) ; {131645}
    SEP #$20              ; {131649}
    LDA #$^chunk_000000.code_00305F ; {131651}
    PHA                   ; {131653}
    REP #$20              ; {131654}
    LDA #$&chunk_000000.code_00305F-1 ; {131656}
    PHA                   ; {131659}
    RTL                   ; {131660}
}

code_02024D {
    COP [85] ( @chunk_000000.code_00299D ) ; {131661}
    COP [17] ( &code_02025B ) ; {131666}
    COP [15]              ; {131670}
    COP [91]              ; {131672}
    RTL                   ; {131674}
}

code_02025B {
    COP [01] ( &asciistring_020260 ) ; {131675}
    RTL                   ; {131679}
}

asciistring_020260 |[10]We were really [N]happy just gazing at [N]each other- [FIN]But I may get old [N]soon- [FIN]Maybe I should search [N]for someone new- [JMP:&asciistring_02251E]|

code_0202BA {
    COP [14] ( #$00F8, &code_0202C1 ) ; {131770}
    RTL                   ; {131776}
}

code_0202C1 {
    COP [85] ( @chunk_000000.code_00299D ) ; {131777}
    COP [17] ( &code_0202CF ) ; {131782}
    COP [15]              ; {131786}
    COP [91]              ; {131788}
    RTL                   ; {131790}
}

code_0202CF {
    COP [01] ( &asciistring_0202D4 ) ; {131791}
    RTL                   ; {131795}
}

asciistring_0202D4 |[10]Make sure you search [N]Laynole very [N]carefully- [FIN]If you move too fast [N]you may overlook [N]things--- [JMP:&asciistring_02251E]|

code_02032B {
    COP [14] ( #$00E1, &code_020332 ) ; {131883}
    RTL                   ; {131889}
}

code_020332 {
    COP [17] ( &code_0203B4 ) ; {131890}
    COP [14] ( #$0103, &code_02035A ) ; {131894}
    COP [85] ( @chunk_000000.code_00299D ) ; {131900}
    COP [15]              ; {131905}
    COP [91]              ; {131907}
    COP [14] ( #$0103, &code_02034C ) ; {131909}
    RTL                   ; {131915}
}

code_02034C {
    COP [80] ( #17 )      ; {131916}
    COP [82]              ; {131919}
    COP [81] ( #15, #08 ) ; {131921}
    COP [83]              ; {131925}
    COP [91]              ; {131927}
    RTL                   ; {131929}
}

code_02035A {
    COP [11] ( #0A, #11, #37 ) ; {131930}
    COP [85] ( @chunk_000000.code_00299D ) ; {131935}
    LDA $0016, X          ; {131940}
    AND #$FFEF            ; {131943}
    STA $0016, X          ; {131946}
    COP [15]              ; {131949}
    COP [05] ( #$0004 )   ; {131951}
    COP [81] ( #28, #02 ) ; {131955}
    COP [83]              ; {131959}
    COP [81] ( #27, #02 ) ; {131961}
    COP [83]              ; {131965}
    COP [81] ( #28, #02 ) ; {131967}
    COP [83]              ; {131971}
    COP [81] ( #27, #02 ) ; {131973}
    COP [83]              ; {131977}
    COP [81] ( #28, #02 ) ; {131979}
    COP [83]              ; {131983}
    COP [85] ( @code_020445 ) ; {131985}
    COP [81] ( #29, #04 ) ; {131990}
    COP [83]              ; {131994}
    COP [81] ( #2A, #08 ) ; {131996}
    COP [83]              ; {132000}
    COP [81] ( #2B, #10 ) ; {132002}
    COP [83]              ; {132006}
    COP [09] ( #$8005 )   ; {132008}
    COP [80] ( #14 )      ; {132012}
    COP [82]              ; {132015}
    COP [91]              ; {132017}
    RTL                   ; {132019}
}

code_0203B4 {
    COP [14] ( #$0103, &code_0203BF ) ; {132020}
    COP [01] ( &asciistring_0203CE ) ; {132026}
    RTL                   ; {132030}
}

code_0203BF {
    COP [18] ( #18, &code_0203C9 ) ; {132031}
    COP [01] ( &asciistring_020427 ) ; {132036}
    RTL                   ; {132040}
}

code_0203C9 {
    COP [01] ( &asciistring_0203DF ) ; {132041}
    RTL                   ; {132045}
}

asciistring_0203CE |[10]Please save the King! [JMP:&asciistring_02251E]|

asciistring_0203DF |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&asciistring_02251E]|

asciistring_020427 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&asciistring_02251E]|

code_020445 {
    COP [A8] ( #$8000, #0D ) ; {132165}
    COP [92] ( #49 )      ; {132170}
    COP [94]              ; {132173}
    COP [86]              ; {132175}
    RTL                   ; {132177}
}

code_020452 {
    COP [14] ( #$00E6, &code_020459 ) ; {132178}
    RTL                   ; {132184}
}

code_020459 {
    COP [17] ( &code_0204D2 ) ; {132185}
    COP [14] ( #$0103, &code_020481 ) ; {132189}
    COP [85] ( @chunk_000000.code_00299D ) ; {132195}
    COP [15]              ; {132200}
    COP [91]              ; {132202}
    COP [14] ( #$0103, &code_020473 ) ; {132204}
    RTL                   ; {132210}
}

code_020473 {
    COP [80] ( #17 )      ; {132211}
    COP [82]              ; {132214}
    COP [81] ( #15, #08 ) ; {132216}
    COP [83]              ; {132220}
    COP [91]              ; {132222}
    RTL                   ; {132224}
}

code_020481 {
    COP [11] ( #0B, #0F, #37 ) ; {132225}
    COP [85] ( @chunk_000000.code_00299D ) ; {132230}
    LDA $0016, X          ; {132235}
    AND #$FFEF            ; {132238}
    STA $0016, X          ; {132241}
    COP [15]              ; {132244}
    COP [05] ( #$0004 )   ; {132246}
    COP [81] ( #28, #02 ) ; {132250}
    COP [83]              ; {132254}
    COP [81] ( #27, #02 ) ; {132256}
    COP [83]              ; {132260}
    COP [81] ( #28, #02 ) ; {132262}
    COP [83]              ; {132266}
    COP [81] ( #27, #02 ) ; {132268}
    COP [83]              ; {132272}
    COP [81] ( #28, #02 ) ; {132274}
    COP [83]              ; {132278}
    COP [81] ( #29, #04 ) ; {132280}
    COP [83]              ; {132284}
    COP [81] ( #2A, #08 ) ; {132286}
    COP [83]              ; {132290}
    COP [81] ( #2B, #10 ) ; {132292}
    COP [83]              ; {132296}
    COP [80] ( #14 )      ; {132298}
    COP [82]              ; {132301}
    COP [91]              ; {132303}
    RTL                   ; {132305}
}

code_0204D2 {
    COP [14] ( #$0103, &code_0204DD ) ; {132306}
    COP [01] ( &asciistring_0204EC ) ; {132312}
    RTL                   ; {132316}
}

code_0204DD {
    COP [18] ( #18, &code_0204E7 ) ; {132317}
    COP [01] ( &asciistring_020545 ) ; {132322}
    RTL                   ; {132326}
}

code_0204E7 {
    COP [01] ( &asciistring_0204FD ) ; {132327}
    RTL                   ; {132331}
}

asciistring_0204EC |[10]Please save the King! [JMP:&asciistring_02251E]|

asciistring_0204FD |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&asciistring_02251E]|

asciistring_020545 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&asciistring_02251E]|

code_020563 {
    COP [14] ( #$0103, &code_02056A ) ; {132451}
    RTL                   ; {132457}
}

code_02056A {
    COP [30] ( #$0103, &code_02067F, #04 ) ; {132458}
    COP [07] ( #$9F02, &code_0205F2 ) ; {132465}
    COP [07] ( #$8A01, &code_0205D2 ) ; {132471}
    COP [85] ( @chunk_000000.code_00299D ) ; {132477}
    COP [17] ( &code_02062D ) ; {132482}
    COP [15]              ; {132486}
    COP [18] ( #18, &code_02058F ) ; {132488}
    BRA loc_0205EF        ; {132493}
}

code_02058F {
    COP [05] ( #$0004 )   ; {132495}
    LDA #$2F80            ; {132499}
    TSB $0326             ; {132502}
    COP [05] ( #$0005 )   ; {132505}
    COP [01] ( &asciistring_0209D4 ) ; {132509}
    BRK #$5E              ; {132513}
    COP [0A] ( #18 )      ; {132515}
    COP [0B] ( #32 )      ; {132518}
    COP [0B] ( #33 )      ; {132521}
    COP [0B] ( #34 )      ; {132524}
    COP [03] ( #3D )      ; {132527}
    COP [04]              ; {132530}
    COP [01] ( &asciistring_02092A ) ; {132532}
    COP [09] ( #$8A00 )   ; {132536}
    COP [09] ( #$8A01 )   ; {132540}
    LDA #$0020            ; {132544}
    STA $03B4             ; {132547}
    COP [10] ( #$0314, #01, #$00F8, #$0128 ) ; {132550}
    COP [91]              ; {132559}
    RTL                   ; {132561}
}

code_0205D2 {
    LDA #$2F80            ; {132562}
    TSB $0326             ; {132565}
    COP [09] ( #$0A01 )   ; {132568}
    COP [03] ( #29 )      ; {132572}
    COP [04]              ; {132575}
    COP [01] ( &asciistring_0209F2 ) ; {132577}
    LDA #$2F80            ; {132581}
    TRB $0326             ; {132584}
    COP [17] ( &code_02062D ) ; {132587}

  loc_0205EF:
    COP [91]              ; {132591}
    RTL                   ; {132593}
}

code_0205F2 {
    COP [11] ( #0A, #00, #C9 ) ; {132594}
    COP [11] ( #0B, #00, #C9 ) ; {132599}
    COP [11] ( #12, #11, #37 ) ; {132604}
    LDA #$BFC0            ; {132609}
    TSB $0326             ; {132612}
    COP [03] ( #29 )      ; {132615}
    COP [04]              ; {132618}
    COP [01] ( &asciistring_020AF6 ) ; {132620}
    COP [03] ( #5B )      ; {132624}
    COP [04]              ; {132627}
    LDA #$0020            ; {132629}
    STA $03B4             ; {132632}
    COP [10] ( #$0106, #01, #$01F8, #$0060 ) ; {132635}
    LDA #$BFC0            ; {132644}
    TRB $0326             ; {132647}
    COP [91]              ; {132650}
    RTL                   ; {132652}
}

code_02062D {
    COP [07] ( #$0705, &code_020676 ) ; {132653}
    COP [18] ( #18, &code_02063D ) ; {132659}
    COP [01] ( &asciistring_0208B1 ) ; {132664}
    RTL                   ; {132668}
}

code_02063D {
    COP [18] ( #32, &code_020671 ) ; {132669}
    COP [18] ( #33, &code_020671 ) ; {132674}
    COP [18] ( #34, &code_020671 ) ; {132679}
    COP [14] ( #$00E1, &code_020654 ) ; {132684}
    BRA loc_02066C        ; {132690}
}

code_020654 {
    COP [14] ( #$00E6, &code_02065C ) ; {132692}
    BRA loc_02066C        ; {132698}
}

code_02065C {
    COP [01] ( &asciistring_020904 ) ; {132700}
    COP [17] ( #$0000 )   ; {132704}
    COP [31] ( #00 )      ; {132708}
    COP [09] ( #$8004 )   ; {132711}
    RTL                   ; {132715}

  loc_02066C:
    COP [01] ( &asciistring_020A83 ) ; {132716}
    RTL                   ; {132720}
}

code_020671 {
    COP [01] ( &asciistring_0207CF ) ; {132721}
    RTL                   ; {132725}
}

code_020676 {
    COP [01] ( &asciistring_0206AC ) ; {132726}
    COP [09] ( #$8705 )   ; {132730}
    RTL                   ; {132734}
}

code_02067F {
    COP [14] ( #$00E1, &code_02068D ) ; {132735}
    COP [14] ( #$00E6, &code_02068D ) ; {132741}
    BRA loc_020691        ; {132747}
}

code_02068D {
    COP [01] ( &asciistring_020696 ) ; {132749}

  loc_020691:
    COP [37]              ; {132753}
    COP [86]              ; {132755}
    RTL                   ; {132757}
}

asciistring_020696 |[10][0E:1E]King, are you okay? [0E:3C][JMP:&asciistring_02251E+M]|

asciistring_0206AC |[10]You saved me? Thank [N]you very much- [FIN][JMP:&asciistring_020742]|

asciistring_0206C6 |By the way, the prison[N]guard has not yet been[N]released- [FIN]Release him and do not[N]forget to visit those [N]around him- [FIN][::]I believe you will [N]find what you are [N]looking for- [FIN][JMP:&asciistring_0207D3]|

asciistring_020742 |I treated the snail, [N]Nome, very poorly- [FIN]I would not trust all [N]of the things Nome was[N]saying- [FIN]He told me monsters [N]would invade our town-[N]I put him in prison- [FIN]See Nome- [N][JMP:&asciistring_0206C6+M]|

asciistring_0207CF |[10][JMP:&asciistring_0207D3+M]|

asciistring_0207D3 |By the way, [N][::]have you heard [N]of the Phoenix? [FIN]Whoever collects the [N]Master s three [N]symbols, [FIN]The Red+Hot Mirror, [FIN]The Red+Hot Ball and [FIN]The Red+Hot Stick, [FIN]shall have the Phoenix[N]help them- [FIN]That person will [N]inherit the strongest [N]power- [FIN]If you collect them [N]all bring them to me- [JMP:&asciistring_02251E]|

asciistring_0208B1 |[10]The power of the [N]Phoenix is tremendous-[FIN]I fear that without [N]it s power you will [N]not defeat Deathtoll- [JMP:&asciistring_02251E]|

asciistring_020904 |[10]You made it! [N][02:2], I shall [N]call the Phoenix- [JMP:&asciistring_02251E]|

asciistring_02092A |[10][0F]High above in the sky,[N]a beautiful voice [N]could be heard--- [FIN][0F]I am the Phoenix- [N]I live on the Mountain[N]of Souls- [FIN]I will help you revive[N]the world and protect [N]the peace- [FIN]As soon as I was [N]called, Deathtoll [N]moved into position- [JMP:&asciistring_02251E]|

asciistring_0209D4 |[10][02:2] received [N][03:24]Magic of Phoenix!! [03:20][JMP:&asciistring_02251E]|

asciistring_0209F2 |[10][02:2], [N]return to the world of[N]evil with the Phoenix-[FIN]If you equip SoulBlade[N]and Soul Armor the [N]Phoenix will be able [N]to help you- [FIN]This is the final [N]battle, the battle [N]with Deathtoll- [FIN]Please come back [N]alive- [JMP:&asciistring_02251E]|

asciistring_020A83 |[10]Yes, you have [N]collected the three [N]symbols, but--- [FIN]I need two very old [N]magicians to help call[N]the Phoenix- [FIN]Find them and return [N]to me- [JMP:&asciistring_02251E]|

asciistring_020AF6 |[10][0F]Oh, you re back! [N][0E:5A]Well, I wasn t [N]worried, but---- [N][0E:28]Nome was really [N]worried about you- [N][0E:3C]Nome, [N]say something- [N][0E:78][10]--------- [N][0E:5A][0A]The█King█is█such█a[N]thoughtless█man-[N][0E:5A][10][0A]Dr-Leo has passed [N]away- [0E:28]I miss him very [N]much- [N][0E:5A]There are creatures [N]that only get one year[N]to live- [N][0E:5A]The value of life [N]depends on the number [N]of days spent with [N]fulfillment- [N][0E:5A]Maybe Dr-Leo s life [N]was more fulfilled [N]than many others- [N][0E:78][JMP:&asciistring_02251E+M]|

code_020C53 {
    COP [14] ( #$00F6, &code_020C5A ) ; {134227}
    RTL                   ; {134233}
}

code_020C5A {
    COP [85] ( @chunk_000000.code_00299D ) ; {134234}
    COP [17] ( &code_020C6F ) ; {134239}
    COP [15]              ; {134243}

  loc_020C65:
    COP [AD] ( #08 )      ; {134245}
    COP [80] ( #25 )      ; {134248}
    COP [82]              ; {134251}
    BRA loc_020C65        ; {134253}
}

code_020C6F {
    COP [01] ( &asciistring_020C74 ) ; {134255}
    RTL                   ; {134259}
}

asciistring_020C74 |[10]I ll tell you a [N]secret- [FIN]If you see a sleeping [N]mushroom, return to [N]the same place you saw[N]in it s dream- [JMP:&asciistring_02251E]|

code_020CC6 {
    COP [14] ( #$00E9, &code_020CCD ) ; {134342}
    RTL                   ; {134348}
}

code_020CCD {
    COP [30] ( #$00E9, &code_020D65, #04 ) ; {134349}
    COP [85] ( @chunk_000000.code_00299D ) ; {134356}
    COP [1B] ( &code_020CDF, #$0002 ) ; {134361}
}

code_020CDF {
    COP [07] ( #$0007, &code_020D14 ) ; {134367}
    LDA #$FFFF            ; {134373}
    STA $03FB             ; {134376}
    COP [80] ( #04 )      ; {134379}
    COP [82]              ; {134382}
    COP [03] ( #03 )      ; {134384}
    COP [97]              ; {134387}
    COP [81] ( #05, #02 ) ; {134389}
    COP [83]              ; {134393}
    COP [96]              ; {134395}
    COP [81] ( #05, #02 ) ; {134397}
    COP [83]              ; {134401}
    COP [04]              ; {134403}
    COP [97]              ; {134405}
    COP [80] ( #05 )      ; {134407}
    COP [82]              ; {134410}
    COP [80] ( #01 )      ; {134412}
    COP [82]              ; {134415}
    COP [91]              ; {134417}
    RTL                   ; {134419}
}

code_020D14 {
    COP [17] ( &code_020D51 ) ; {134420}
    COP [15]              ; {134424}
    COP [05] ( #$0003 )   ; {134426}
    LDA $0016, X          ; {134430}
    AND #$FFEF            ; {134433}
    STA $0016, X          ; {134436}
    COP [96]              ; {134439}
    COP [80] ( #02 )      ; {134441}
    COP [82]              ; {134444}
    LDA #$2F80            ; {134446}
    TSB $0326             ; {134449}
    COP [03] ( #1F )      ; {134452}
    COP [04]              ; {134455}
    COP [01] ( &asciistring_020EB9 ) ; {134457}
    COP [16]              ; {134461}
    COP [80] ( #26 )      ; {134463}
    COP [82]              ; {134466}
    COP [09] ( #$0003 )   ; {134468}
    LDA #$2F80            ; {134472}
    TRB $0326             ; {134475}
    COP [86]              ; {134478}
    RTL                   ; {134480}
}

code_020D51 {
    COP [18] ( #22, &code_020D5B ) ; {134481}
    COP [01] ( &asciistring_020E72 ) ; {134486}
    RTL                   ; {134490}
}

code_020D5B {
    COP [01] ( &asciistring_020DDC ) ; {134491}
    BRK #$5E              ; {134495}
    COP [0A] ( #22 )      ; {134497}
    RTL                   ; {134500}
}

code_020D65 {
    COP [09] ( #$8007 )   ; {134501}
    COP [01] ( &asciistring_020D73 ) ; {134505}
    STZ $03FB             ; {134509}
    COP [86]              ; {134512}
    RTL                   ; {134514}
}

asciistring_020D73 |[10][0E:28]Hooray! I am back! [N]I am back! [0E:B4][N]Thank you very much- [FIN]I will give you these [N]Mushroom Shoes if you [N]return to me- [FIN]You will be able to [N]walk on ice! [JMP:&asciistring_02251E]|

asciistring_020DDC |[10]I will give you my [N]Mushroom Shoes- [FIN]There is snail goo on [N]the bottom of these [N]shoes- [FIN]If you wear these you [N]will not slip on the [N]ice- [FIN]You will still slip on[N]the slopes though- [FIN][02:2], received [N][03:24]Mushroom Shoes- [03:20][JMP:&asciistring_02251E]|

asciistring_020E72 |[10]How do you like my [N]Mushroom Shoes? [FIN]My people make [N]clothing and shoes [N]from mushrooms- [JMP:&asciistring_02251E]|

asciistring_020EB9 |[10]This snail always [N]wants me to walk with [N]it- [FIN]Where shall we go [N]today? [JMP:&asciistring_02251E]|

code_020EE9 {
    COP [3B] ( #$00F7, &code_020EFF ) ; {134889}
    COP [17] ( &code_02229E ) ; {134895}
    SEP #$20              ; {134899}
    LDA #$^chunk_000000.code_00305F ; {134901}
    PHA                   ; {134903}
    REP #$20              ; {134904}
    LDA #$&chunk_000000.code_00305F-1 ; {134906}
    PHA                   ; {134909}
    RTL                   ; {134910}
}

code_020EFF {
    COP [85] ( @chunk_000000.code_00299D ) ; {134911}
    COP [17] ( &code_020F51 ) ; {134916}
    COP [15]              ; {134920}
    COP [05] ( #$0003 )   ; {134922}
    COP [05] ( #$8003 )   ; {134926}
    COP [80] ( #18 )      ; {134930}
    COP [82]              ; {134933}
    COP [17] ( &code_020F5A ) ; {134935}
    COP [91]              ; {134939}
    RTL                   ; {134941}
}

code_020F1E {
    COP [16]              ; {134942}

  loc_020F20:
    COP [80] ( #1C )      ; {134944}
    COP [82]              ; {134947}
    COP [97]              ; {134949}
    COP [81] ( #1D, #07 ) ; {134951}
    COP [83]              ; {134955}
    COP [81] ( #1B, #0B ) ; {134957}
    COP [83]              ; {134961}
    COP [96]              ; {134963}
    COP [81] ( #1D, #09 ) ; {134965}
    COP [83]              ; {134969}
    COP [81] ( #1C, #06 ) ; {134971}
    COP [83]              ; {134975}
    COP [97]              ; {134977}
    COP [81] ( #1D, #02 ) ; {134979}
    COP [83]              ; {134983}
    COP [81] ( #1C, #04 ) ; {134985}
    COP [83]              ; {134989}
    BRA loc_020F20        ; {134991}
}

code_020F51 {
    COP [01] ( &asciistring_020F6B ) ; {134993}
    COP [09] ( #$8003 )   ; {134997}
    RTL                   ; {135001}
}

code_020F5A {
    COP [01] ( &asciistring_020F7B ) ; {135002}
    COP [17] ( &code_020F66 ) ; {135006}
    COP [27] ( &code_020F1E ) ; {135010}
}

code_020F66 {
    COP [01] ( &asciistring_020F88 ) ; {135014}
    RTL                   ; {135018}
}

asciistring_020F6B |[10]Week, week! [JMP:&asciistring_02251E]|

asciistring_020F7B |[10]Let s go! [JMP:&asciistring_02251E]|

asciistring_020F88 |[10]This is our vehicle- [JMP:&asciistring_02251E]|

code_020F9B {
    COP [3B] ( #$00DD, &code_020FB1 ) ; {135067}
    COP [17] ( &code_02229E ) ; {135073}
    SEP #$20              ; {135077}
    LDA #$^chunk_000000.code_00305F ; {135079}
    PHA                   ; {135081}
    REP #$20              ; {135082}
    LDA #$&chunk_000000.code_00305F-1 ; {135084}
    PHA                   ; {135087}
    RTL                   ; {135088}
}

code_020FB1 {
    COP [85] ( @chunk_000000.code_00299D ) ; {135089}
    COP [17] ( &code_020FC4 ) ; {135094}
    COP [15]              ; {135098}
    COP [80] ( #25 )      ; {135100}
    COP [82]              ; {135103}
    COP [91]              ; {135105}
    RTL                   ; {135107}
}

code_020FC4 {
    COP [19] ( #1C, &code_020FDA ) ; {135108}
    COP [01] ( &asciistring_020FE9 ) ; {135113}
    COP [3C] ( #04 )      ; {135117}
    COP [10] ( #$060B, #01, #$0200, #$02F0 ) ; {135120}
    RTL                   ; {135129}
}

code_020FDA {
    COP [01] ( &asciistring_020FDF ) ; {135130}
    RTL                   ; {135134}
}

asciistring_020FDF |[10]Zzzzz [JMP:&asciistring_02251E]|

asciistring_020FE9 |[10][02:2] placed [N]the Dream Rod on the [N]mushroom- [JMP:&asciistring_02251E]|

code_02100B {
    COP [3B] ( #$00D7, &code_021021 ) ; {135179}
    COP [17] ( &code_02229E ) ; {135185}
    SEP #$20              ; {135189}
    LDA #$^chunk_000000.code_00305F ; {135191}
    PHA                   ; {135193}
    REP #$20              ; {135194}
    LDA #$&chunk_000000.code_00305F-1 ; {135196}
    PHA                   ; {135199}
    RTL                   ; {135200}
}

code_021021 {
    COP [85] ( @chunk_000000.code_00299D ) ; {135201}
    COP [17] ( &code_02102F ) ; {135206}
    COP [15]              ; {135210}
    COP [91]              ; {135212}
    RTL                   ; {135214}
}

code_02102F {
    COP [01] ( &asciistring_021034 ) ; {135215}
    RTL                   ; {135219}
}

asciistring_021034 |[10]There is a house [N]in the desert to #- [FIN]Mechanical monsters [N]that cannot be [N]defeated by normal [N]swords exist there- [JMP:&asciistring_02251E]|

code_02108F {
    COP [3B] ( #$00D6, &code_0210A5 ) ; {135311}
    COP [17] ( &code_02229E ) ; {135317}
    SEP #$20              ; {135321}
    LDA #$^chunk_000000.code_00305F ; {135323}
    PHA                   ; {135325}
    REP #$20              ; {135326}
    LDA #$&chunk_000000.code_00305F-1 ; {135328}
    PHA                   ; {135331}
    RTL                   ; {135332}
}

code_0210A5 {
    COP [85] ( @chunk_000000.code_00299D ) ; {135333}
    COP [17] ( &code_0210B3 ) ; {135338}
    COP [15]              ; {135342}
    COP [91]              ; {135344}
    RTL                   ; {135346}
}

code_0210B3 {
    COP [07] ( #$9B03, &code_0210C7 ) ; {135347}
    COP [01] ( &asciistring_0210CC ) ; {135353}
    BRK #$5E              ; {135357}
    COP [0A] ( #3D )      ; {135359}
    COP [09] ( #$9B03 )   ; {135362}
    RTL                   ; {135366}
}

code_0210C7 {
    COP [01] ( &asciistring_021224 ) ; {135367}
    RTL                   ; {135371}
}

asciistring_0210CC |[10]My name is Nome- [N]I used to live in [N]Dr-Leo s house- [FIN]Dr-Leo was asked by [N]King Magridd to build [N]a machine that would [N]call upon evil- [FIN]Because he refused, he[N]was taken to Magridd [N]Castle- [FIN]He secretly gave us 4 [N]stones and told us to [N]run away- [FIN]Those stones are keys [N]to the World of Evil- [FIN]The other stones are [N]in Dr-Leo s [N]Laboratory and in the [N]Castle of Magridd- [FIN]Here, take this [03:24]Silver[N]Stone [03:20]and hurry to the[N]Laboratory where [N]Dr-Leo was held- [JMP:&asciistring_02251E]|

asciistring_021224 |[10]What is his daughters [N]name? Lisa? [N]I wonder how she is [N]doing? [JMP:&asciistring_02251E]|

code_021263 {
    COP [14] ( #$00FF, &code_02126A ) ; {135779}
    RTL                   ; {135785}
}

code_02126A {
    COP [85] ( @chunk_000000.code_00299D ) ; {135786}
    COP [17] ( &code_021289 ) ; {135791}
    COP [15]              ; {135795}
    COP [91]              ; {135797}
    COP [14] ( #$0103, &code_02127E ) ; {135799}
    RTL                   ; {135805}
}

code_02127E {
    COP [09] ( #$8706 )   ; {135806}
    COP [17] ( &code_02128E ) ; {135810}
    COP [91]              ; {135814}
    RTL                   ; {135816}
}

code_021289 {
    COP [01] ( &asciistring_021293 ) ; {135817}
    RTL                   ; {135821}
}

code_02128E {
    COP [01] ( &asciistring_0212DC ) ; {135822}
    RTL                   ; {135826}
}

asciistring_021293 |[10]There is a sword [N]called Lucky Blade [N]somewhere in Laynole- [FIN]It is said that [N]monsters will leave [N]larger GEMs- [JMP:&asciistring_02251E]|

asciistring_0212DC |[10]The King has spoken of[N]you- The snail over [N]there is Nome- [JMP:&asciistring_02251E]|

code_0212FE {
    COP [14] ( #$00D4, &code_021305 ) ; {135934}
    RTL                   ; {135940}
}

code_021305 {
    COP [85] ( @chunk_000000.code_00299D ) ; {135941}
    COP [15]              ; {135946}
    COP [14] ( #$00EF, &code_021314 ) ; {135948}
    BRA loc_02133C        ; {135954}
}

code_021314 {
    COP [14] ( #$00F0, &code_02131C ) ; {135956}
    BRA loc_02133C        ; {135962}
}

code_02131C {
    COP [14] ( #$00E9, &code_021324 ) ; {135964}
    BRA loc_021343        ; {135970}
}

code_021324 {
    COP [14] ( #$00F2, &code_02132C ) ; {135972}
    BRA loc_021343        ; {135978}
}

code_02132C {
    COP [17] ( &code_0213BA ) ; {135980}
    COP [05] ( #$0001 )   ; {135984}
    COP [16]              ; {135988}
    COP [17] ( &code_021399 ) ; {135990}
    BRA loc_02134A        ; {135994}

  loc_02133C:
    COP [17] ( &code_0213B0 ) ; {135996}
    COP [91]              ; {136000}
    RTL                   ; {136002}

  loc_021343:
    COP [17] ( &code_0213B5 ) ; {136003}
    COP [91]              ; {136007}
    RTL                   ; {136009}

  loc_02134A:
    COP [81] ( #1D, #06 ) ; {136010}
    COP [83]              ; {136014}
    COP [81] ( #1B, #04 ) ; {136016}
    COP [83]              ; {136020}
    COP [81] ( #1D, #0B ) ; {136022}
    COP [83]              ; {136026}
    COP [81] ( #1B, #0D ) ; {136028}
    COP [83]              ; {136032}
    COP [96]              ; {136034}
    COP [81] ( #1D, #02 ) ; {136036}
    COP [83]              ; {136040}
    COP [81] ( #1B, #06 ) ; {136042}
    COP [83]              ; {136046}
    COP [81] ( #1D, #02 ) ; {136048}
    COP [83]              ; {136052}
    COP [81] ( #1B, #06 ) ; {136054}
    COP [83]              ; {136058}
    COP [81] ( #1D, #0E ) ; {136060}
    COP [83]              ; {136064}
    COP [81] ( #1C, #1D ) ; {136066}
    COP [83]              ; {136070}
    COP [97]              ; {136072}
    COP [80] ( #1D )      ; {136074}
    COP [82]              ; {136077}
    COP [80] ( #1A )      ; {136079}
    COP [82]              ; {136082}
    BRA loc_02134A        ; {136084}

  loc_021396:
    COP [91]              ; {136086}
    RTL                   ; {136088}
}

code_021399 {
    LDA $0016, X          ; {136089}
    AND #$FFEF            ; {136092}
    STA $0016, X          ; {136095}
    COP [01] ( &asciistring_0213BF ) ; {136098}
    LDA $0016, X          ; {136102}
    ORA #$0010            ; {136105}
    STA $0016, X          ; {136108}
    RTL                   ; {136111}
}

code_0213B0 {
    COP [01] ( &asciistring_0213E9 ) ; {136112}
    RTL                   ; {136116}
}

code_0213B5 {
    COP [01] ( &asciistring_021409 ) ; {136117}
    RTL                   ; {136121}
}

code_0213BA {
    COP [01] ( &asciistring_02143E ) ; {136122}
    RTL                   ; {136126}
}

asciistring_0213BF |[10]I have no time to [N]talk- I think I am [N]going to lose the [N]race- [JMP:&asciistring_02251E]|

asciistring_0213E9 |[10]We are snail jockeys- [N]This snail is called [N]Legend- [JMP:&asciistring_02251E]|

asciistring_021409 |[10]All the jockeys are [N]here, but the race [N]track is not completed[N]yet- [JMP:&asciistring_02251E]|

asciistring_02143E |[10]I am going to win this[N]race! [JMP:&asciistring_02251E]|

code_021455 {
    COP [14] ( #$00EF, &code_02145C ) ; {136277}
    RTL                   ; {136283}
}

code_02145C {
    COP [85] ( @chunk_000000.code_00299D ) ; {136284}
    COP [15]              ; {136289}
    COP [14] ( #$00D4, &code_02146B ) ; {136291}
    BRA loc_021493        ; {136297}
}

code_02146B {
    COP [14] ( #$00F0, &code_021473 ) ; {136299}
    BRA loc_021493        ; {136305}
}

code_021473 {
    COP [14] ( #$00E9, &code_02147B ) ; {136307}
    BRA loc_02149A        ; {136313}
}

code_02147B {
    COP [14] ( #$00F2, &code_021483 ) ; {136315}
    BRA loc_02149A        ; {136321}
}

code_021483 {
    COP [17] ( &code_021511 ) ; {136323}
    COP [05] ( #$0001 )   ; {136327}
    COP [16]              ; {136331}
    COP [17] ( &code_0214F0 ) ; {136333}
    BRA loc_0214A1        ; {136337}

  loc_021493:
    COP [17] ( &code_021507 ) ; {136339}
    COP [91]              ; {136343}
    RTL                   ; {136345}

  loc_02149A:
    COP [17] ( &code_02150C ) ; {136346}
    COP [91]              ; {136350}
    RTL                   ; {136352}

  loc_0214A1:
    COP [81] ( #1D, #06 ) ; {136353}
    COP [83]              ; {136357}
    COP [81] ( #1B, #02 ) ; {136359}
    COP [83]              ; {136363}
    COP [81] ( #1D, #0B ) ; {136365}
    COP [83]              ; {136369}
    COP [81] ( #1B, #0D ) ; {136371}
    COP [83]              ; {136375}
    COP [96]              ; {136377}
    COP [81] ( #1D, #02 ) ; {136379}
    COP [83]              ; {136383}
    COP [81] ( #1B, #06 ) ; {136385}
    COP [83]              ; {136389}
    COP [81] ( #1D, #02 ) ; {136391}
    COP [83]              ; {136395}
    COP [81] ( #1B, #06 ) ; {136397}
    COP [83]              ; {136401}
    COP [81] ( #1D, #0E ) ; {136403}
    COP [83]              ; {136407}
    COP [81] ( #1C, #1B ) ; {136409}
    COP [83]              ; {136413}
    COP [97]              ; {136415}
    COP [80] ( #1D )      ; {136417}
    COP [82]              ; {136420}
    COP [80] ( #1A )      ; {136422}
    COP [82]              ; {136425}
    BRA loc_0214A1        ; {136427}

  loc_0214ED:
    COP [91]              ; {136429}
    RTL                   ; {136431}
}

code_0214F0 {
    LDA $0016, X          ; {136432}
    AND #$FFEF            ; {136435}
    STA $0016, X          ; {136438}
    COP [01] ( &asciistring_021516 ) ; {136441}
    LDA $0016, X          ; {136445}
    ORA #$0010            ; {136448}
    STA $0016, X          ; {136451}
    RTL                   ; {136454}
}

code_021507 {
    COP [01] ( &asciistring_02153D ) ; {136455}
    RTL                   ; {136459}
}

code_02150C {
    COP [01] ( &asciistring_021569 ) ; {136460}
    RTL                   ; {136464}
}

code_021511 {
    COP [01] ( &asciistring_02159A ) ; {136465}
    RTL                   ; {136469}
}

asciistring_021516 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&asciistring_02251E]|

asciistring_02153D |[10]We are snail jockeys- [N]This snail is called [N]Flash- [N]I am the fastest! [JMP:&asciistring_02251E]|

asciistring_021569 |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&asciistring_02251E]|

asciistring_02159A |[10]I am going to win this[N]race! [JMP:&asciistring_02251E]|

code_0215B1 {
    COP [14] ( #$00F0, &code_0215B8 ) ; {136625}
    RTL                   ; {136631}
}

code_0215B8 {
    COP [85] ( @chunk_000000.code_00299D ) ; {136632}
    COP [15]              ; {136637}
    COP [14] ( #$00D4, &code_0215C7 ) ; {136639}
    BRA loc_0215EF        ; {136645}
}

code_0215C7 {
    COP [14] ( #$00EF, &code_0215CF ) ; {136647}
    BRA loc_0215EF        ; {136653}
}

code_0215CF {
    COP [14] ( #$00E9, &code_0215D7 ) ; {136655}
    BRA loc_0215F6        ; {136661}
}

code_0215D7 {
    COP [14] ( #$00F2, &code_0215DF ) ; {136663}
    BRA loc_0215F6        ; {136669}
}

code_0215DF {
    COP [17] ( &code_021661 ) ; {136671}
    COP [05] ( #$0001 )   ; {136675}
    COP [16]              ; {136679}
    COP [17] ( &code_021640 ) ; {136681}
    BRA loc_0215FD        ; {136685}

  loc_0215EF:
    COP [17] ( &code_021657 ) ; {136687}
    COP [91]              ; {136691}
    RTL                   ; {136693}

  loc_0215F6:
    COP [17] ( &code_02165C ) ; {136694}
    COP [91]              ; {136698}
    RTL                   ; {136700}

  loc_0215FD:
    COP [81] ( #1D, #11 ) ; {136701}
    COP [83]              ; {136705}
    COP [81] ( #1B, #0D ) ; {136707}
    COP [83]              ; {136711}
    COP [96]              ; {136713}
    COP [81] ( #1D, #02 ) ; {136715}
    COP [83]              ; {136719}
    COP [81] ( #1B, #06 ) ; {136721}
    COP [83]              ; {136725}
    COP [81] ( #1D, #02 ) ; {136727}
    COP [83]              ; {136731}
    COP [81] ( #1B, #06 ) ; {136733}
    COP [83]              ; {136737}
    COP [81] ( #1D, #0E ) ; {136739}
    COP [83]              ; {136743}
    COP [81] ( #1C, #19 ) ; {136745}
    COP [83]              ; {136749}
    COP [97]              ; {136751}
    COP [80] ( #1D )      ; {136753}
    COP [82]              ; {136756}
    COP [80] ( #1A )      ; {136758}
    COP [82]              ; {136761}
    BRA loc_0215FD        ; {136763}

  loc_02163D:
    COP [91]              ; {136765}
    RTL                   ; {136767}
}

code_021640 {
    LDA $0016, X          ; {136768}
    AND #$FFEF            ; {136771}
    STA $0016, X          ; {136774}
    COP [01] ( &asciistring_021666 ) ; {136777}
    LDA $0016, X          ; {136781}
    ORA #$0010            ; {136784}
    STA $0016, X          ; {136787}
    RTL                   ; {136790}
}

code_021657 {
    COP [01] ( &asciistring_02168D ) ; {136791}
    RTL                   ; {136795}
}

code_02165C {
    COP [01] ( &asciistring_0216BE ) ; {136796}
    RTL                   ; {136800}
}

code_021661 {
    COP [01] ( &asciistring_0216EF ) ; {136801}
    RTL                   ; {136805}
}

asciistring_021666 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&asciistring_02251E]|

asciistring_02168D |[10]We are snail jockeys- [N]We are waiting for the[N]race to start- [JMP:&asciistring_02251E]|

asciistring_0216BE |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&asciistring_02251E]|

asciistring_0216EF |[10]We are waiting for the[N]race to start- [JMP:&asciistring_02251E]|

code_021711 {
    COP [14] ( #$00CB, &code_021718 ) ; {136977}
    RTL                   ; {136983}
}

code_021718 {
    COP [85] ( @chunk_000000.code_00299D ) ; {136984}
    COP [17] ( &code_02172D ) ; {136989}
    COP [15]              ; {136993}

  loc_021723:
    COP [AD] ( #08 )      ; {136995}
    COP [80] ( #25 )      ; {136998}
    COP [82]              ; {137001}
    BRA loc_021723        ; {137003}
}

code_02172D {
    COP [01] ( &asciistring_021732 ) ; {137005}
    RTL                   ; {137009}
}

asciistring_021732 |[10]These creatures grow [N]very fast- They become[N]adults within half a [N]year, [FIN]get married, have [N]children and pass away[N]in a year- [FIN]They never feel their [N]lives are too short- [N]They enjoy each [N]moment! [JMP:&asciistring_02251E]|

code_0217D9 {
    COP [14] ( #$00FE, &code_0217E0 ) ; {137177}
    RTL                   ; {137183}
}

code_0217E0 {
    COP [85] ( @chunk_000000.code_00299D ) ; {137184}
    COP [17] ( &code_021824 ) ; {137189}
    COP [15]              ; {137193}
    COP [91]              ; {137195}
    COP [18] ( #04, &code_0217F3 ) ; {137197}
    RTL                   ; {137202}
}

code_0217F3 {
    COP [0D] ( #00, #37, #24, &code_0217FB ) ; {137203}
    RTL                   ; {137210}
}

code_0217FB {
    COP [16]              ; {137211}
    LDA #$2F80            ; {137213}
    TSB $0326             ; {137216}
    COP [97]              ; {137219}
    COP [81] ( #11, #02 ) ; {137221}
    COP [83]              ; {137225}
    COP [80] ( #0F )      ; {137227}
    COP [82]              ; {137230}
    COP [80] ( #0C )      ; {137232}
    COP [82]              ; {137235}
    LDA #$2F80            ; {137237}
    TRB $0326             ; {137240}
    COP [15]              ; {137243}
    COP [01] ( &asciistring_021858 ) ; {137245}
    COP [91]              ; {137249}
    RTL                   ; {137251}
}

code_021824 {
    COP [01] ( &asciistring_021829 ) ; {137252}
    RTL                   ; {137256}
}

asciistring_021829 |[10]This passage leads to [N]the underground lake, [N]Lune- [JMP:&asciistring_02251E]|

asciistring_021858 |[10]Hey, you re not going [N]to the lake with that [N]sword are you? [FIN]You are going to get [N]in trouble- [FIN]Talk to some of the [N]people in town, maybe [N]someone can help you- [JMP:&asciistring_02251E]|

code_0218BF {
    COP [14] ( #$00FC, &code_0218C6 ) ; {137407}
    RTL                   ; {137413}
}

code_0218C6 {
    COP [85] ( @chunk_000000.code_00299D ) ; {137414}
    COP [17] ( &code_0218D4 ) ; {137419}
    COP [15]              ; {137423}
    COP [91]              ; {137425}
    RTL                   ; {137427}
}

code_0218D4 {
    COP [07] ( #$8707, &code_0218F5 ) ; {137428}
    COP [19] ( #1C, &code_0218F0 ) ; {137434}
    COP [01] ( &asciistring_021903 ) ; {137439}
    COP [3C] ( #04 )      ; {137443}
    COP [10] ( #$030B, #01, #$00A0, #$00E0 ) ; {137446}
    RTL                   ; {137455}
}

code_0218F0 {
    COP [01] ( &asciistring_0218FA ) ; {137456}
    RTL                   ; {137460}
}

code_0218F5 {
    COP [01] ( &asciistring_021924 ) ; {137461}
    RTL                   ; {137465}
}

asciistring_0218FA |[10]Zzzz [JMP:&asciistring_02251E]|

asciistring_021903 |[10][02:2] placed [N]the Dream Rod on the [N]old man- [JMP:&asciistring_02251E]|

asciistring_021924 |[10]Oops! I must have [N]fallen asleep- [FIN]I was dreaming of my [N]childhood- [JMP:&asciistring_02251E]|

code_02195F {
    COP [3B] ( #$00FA, &code_021975 ) ; {137567}
    COP [17] ( &code_02229E ) ; {137573}
    SEP #$20              ; {137577}
    LDA #$^chunk_000000.code_00305F ; {137579}
    PHA                   ; {137581}
    REP #$20              ; {137582}
    LDA #$&chunk_000000.code_00305F-1 ; {137584}
    PHA                   ; {137587}
    RTL                   ; {137588}
}

code_021975 {
    COP [85] ( @chunk_000000.code_00299D ) ; {137589}
    COP [17] ( &code_021983 ) ; {137594}
    COP [15]              ; {137598}
    COP [91]              ; {137600}
    RTL                   ; {137602}
}

code_021983 {
    COP [01] ( &asciistring_021988 ) ; {137603}
    RTL                   ; {137607}
}

asciistring_021988 |[10]Can you believe this [N]old man used to be a [N]child just a half a [N]year ago? [FIN]Time is very [N]important- [JMP:&asciistring_02251E]|

code_0219CE {
    COP [14] ( #$00EE, &code_0219D5 ) ; {137678}
    RTL                   ; {137684}
}

code_0219D5 {
    COP [85] ( @chunk_000000.code_00299D ) ; {137685}
    COP [17] ( &code_0219EA ) ; {137690}
    COP [15]              ; {137694}

  loc_0219E0:
    COP [AD] ( #08 )      ; {137696}
    COP [80] ( #25 )      ; {137699}
    COP [82]              ; {137702}
    BRA loc_0219E0        ; {137704}
}

code_0219EA {
    COP [01] ( &asciistring_0219EF ) ; {137706}
    RTL                   ; {137710}
}

asciistring_0219EF |[10]There is a prison over[N]there- [FIN]Well--- there are no [N]actual bad people- [N]I guess it is just a [N]punishment room- [JMP:&asciistring_02251E]|

code_021A4B {
    COP [14] ( #$00E8, &code_021A52 ) ; {137803}
    RTL                   ; {137809}
}

code_021A52 {
    COP [85] ( @chunk_000000.code_00299D ) ; {137810}
    COP [17] ( &code_021A60 ) ; {137815}
    COP [15]              ; {137819}
    COP [91]              ; {137821}
    RTL                   ; {137823}
}

code_021A60 {
    COP [07] ( #$9A04, &code_021A74 ) ; {137824}
    COP [01] ( &asciistring_021A79 ) ; {137830}
    BRK #$5E              ; {137834}
    COP [0A] ( #2E )      ; {137836}
    COP [09] ( #$9A04 )   ; {137839}
    RTL                   ; {137843}
}

code_021A74 {
    COP [01] ( &asciistring_021AB8 ) ; {137844}
    RTL                   ; {137848}
}

asciistring_021A79 |[10]How did you get in? [N]Here I will give you [N]this- [FIN][02:2] received [N][03:24]the Master s Emblem E-[03:20][JMP:&asciistring_02251E]|

asciistring_021AB8 |[10]How did you get in? [JMP:&asciistring_02251E]|

code_021ACA {
    COP [14] ( #$00F2, &code_021AD1 ) ; {137930}
    RTL                   ; {137936}
}

code_021AD1 {
    COP [85] ( @chunk_000000.code_00299D ) ; {137937}
    COP [17] ( &code_021B2E ) ; {137942}
    COP [15]              ; {137946}
    COP [05] ( #$0002 )   ; {137948}
    COP [17] ( #$0000 )   ; {137952}
    COP [16]              ; {137956}
    COP [96]              ; {137958}
    COP [81] ( #0B, #03 ) ; {137960}
    COP [83]              ; {137964}
    COP [81] ( #0A, #13 ) ; {137966}
    COP [83]              ; {137970}
    COP [97]              ; {137972}
    COP [81] ( #0B, #03 ) ; {137974}
    COP [83]              ; {137978}
    COP [80] ( #07 )      ; {137980}
    COP [82]              ; {137983}
    COP [15]              ; {137985}
    LDA $0016, X          ; {137987}
    AND #$FFF7            ; {137990}
    STA $0016, X          ; {137993}
    COP [17] ( &code_021B57 ) ; {137996}
    COP [05] ( #$0001 )   ; {138000}
    COP [16]              ; {138004}
    COP [96]              ; {138006}
    COP [81] ( #0B, #02 ) ; {138008}
    COP [83]              ; {138012}
    COP [81] ( #09, #04 ) ; {138014}
    COP [83]              ; {138018}
    COP [80] ( #08 )      ; {138020}
    COP [82]              ; {138023}
    COP [15]              ; {138025}
    COP [91]              ; {138027}
    RTL                   ; {138029}
}

code_021B2E {
    COP [14] ( #$00D4, &code_021B36 ) ; {138030}
    BRA loc_021B69        ; {138036}
}

code_021B36 {
    COP [14] ( #$00EF, &code_021B3E ) ; {138038}
    BRA loc_021B69        ; {138044}
}

code_021B3E {
    COP [14] ( #$00F0, &code_021B46 ) ; {138046}
    BRA loc_021B69        ; {138052}
}

code_021B46 {
    COP [14] ( #$00E9, &code_021B4E ) ; {138054}
    BRA loc_021B6E        ; {138060}
}

code_021B4E {
    COP [01] ( &asciistring_021B73 ) ; {138062}
    COP [09] ( #$8002 )   ; {138066}
    RTL                   ; {138070}
}

code_021B57 {
    COP [01] ( &asciistring_021BCE ) ; {138071}
    COP [09] ( #$8001 )   ; {138075}
    COP [17] ( &code_021B64 ) ; {138079}
    RTL                   ; {138083}
}

code_021B64 {
    COP [01] ( &asciistring_021C18 ) ; {138084}
    RTL                   ; {138088}

  loc_021B69:
    COP [01] ( &asciistring_021C24 ) ; {138089}
    RTL                   ; {138093}

  loc_021B6E:
    COP [01] ( &asciistring_021C68 ) ; {138094}
    RTL                   ; {138098}
}

asciistring_021B73 |[10]All the jockeys [N]are here and the race [N]track is finally [N]finished- [FIN]We are going to start [N]the race- Why don t [N]you come along? [JMP:&asciistring_02251E]|

asciistring_021BCE |[10]On your mark, [FIN]well everyone s on the[N]mark- [FIN]Okay, are you ready? [FIN]Get set, [N][0E:28]Go! [JMP:&asciistring_02251E]|

asciistring_021C18 |[10]All right! [JMP:&asciistring_02251E]|

asciistring_021C24 |[10]This is the race [N]track- [FIN]Not all the members [N]are ready, so I cannot[N]start the race- [JMP:&asciistring_02251E]|

asciistring_021C68 |[10]This is the race [N]track- [FIN]But the track is not [N]yet completed, so I [N]cannot start the race- [JMP:&asciistring_02251E]|

code_021CB0 {
    COP [14] ( #$00CA, &code_021CB7 ) ; {138416}
    RTL                   ; {138422}
}

code_021CB7 {
    COP [85] ( @chunk_000000.code_00299D ) ; {138423}
    COP [15]              ; {138428}
    COP [17] ( &code_021CC5 ) ; {138430}
    COP [91]              ; {138434}
    RTL                   ; {138436}
}

code_021CC5 {
    COP [01] ( &asciistring_021CCA ) ; {138437}
    RTL                   ; {138441}
}

asciistring_021CCA |[10]This is where the [N]Mountain of Souls [N]exists- [FIN]It is quite warm [N]inside the mountain- [JMP:&asciistring_02251E]|

code_021D14 {
    LDA #$2F80            ; {138516}
    TSB $0326             ; {138519}
    COP [03] ( #02 )      ; {138522}
    COP [04]              ; {138525}
    COP [34]              ; {138527}
    COP [03] ( #3D )      ; {138529}
    COP [04]              ; {138532}
    COP [96]              ; {138534}
    COP [80] ( #02 )      ; {138536}
    COP [82]              ; {138539}
    COP [01] ( &asciistring_021D48 ) ; {138541}
    COP [09] ( #$8707 )   ; {138545}
    LDA #$2F80            ; {138549}
    TRB $0326             ; {138552}
    COP [3C] ( #04 )      ; {138555}
    COP [10] ( #$010A, #00, #$0330, #$0370 ) ; {138558}
    RTL                   ; {138567}
}

asciistring_021D48 |[10]I will not leave you [N]and go off to other [N]places I promise- [FIN]As proof of my [N]promise, I buried my [N]belongings in the [N]Aurora Ridge- [FIN]The Magic Armor, [N]50 GEMs, and [N]one Medical Herb- [FIN]I hope someone will [N]find them- [JMP:&asciistring_02251E]|

code_021DF8 {
    RTL                   ; {138744}
}

code_021DF9 {
    COP [15]              ; {138745}
    COP [17] ( &code_021E1A ) ; {138747}
    COP [91]              ; {138751}
    COP [0D] ( #00, #1C, #31, &code_021E09 ) ; {138753}
    RTL                   ; {138760}
}

code_021E09 {
    COP [01] ( &asciistring_021E64 ) ; {138761}
    COP [3C] ( #04 )      ; {138765}
    COP [10] ( #$010A, #01, #$0120, #$02C0 ) ; {138768}
    RTL                   ; {138777}
}

code_021E1A {
    COP [01] ( &asciistring_021E1F ) ; {138778}
    RTL                   ; {138782}
}

asciistring_021E1F |[10]This is my [N]hometown- [FIN]The mountain winds [N]carried my spores and [N]now we live there- [JMP:&asciistring_02251E]|

asciistring_021E64 |[10]Make sure you don t [N]walk around in a dream[N]or you will get lost- [JMP:&asciistring_02251E]|

code_021E8F {
    COP [07] ( #$9A05, &code_021EAC ) ; {138895}
    COP [91]              ; {138901}
    COP [0D] ( #00, #20, #2E, &code_021E9F ) ; {138903}
    RTL                   ; {138910}
}

code_021E9F {
    COP [01] ( &asciistring_021EAF ) ; {138911}
    BRK #$5E              ; {138915}
    COP [0A] ( #2F )      ; {138917}
    COP [09] ( #$9A05 )   ; {138920}
}

code_021EAC {
    COP [86]              ; {138924}
    RTL                   ; {138926}
}

asciistring_021EAF |[10][02:2] found [N][03:24]Master s Emblem F- [03:20][JMP:&asciistring_02251E]|

code_021ECE {
    COP [14] ( #$00EC, &code_021ED5 ) ; {138958}
    RTL                   ; {138964}
}

code_021ED5 {
    JSL $@chunk_018000.code_01B161 ; {138965}
    COP [17] ( &code_021EE9 ) ; {138969}
    SEP #$20              ; {138973}
    LDA #$^code_022289    ; {138975}
    PHA                   ; {138977}
    REP #$20              ; {138978}
    LDA #$&code_022289-1  ; {138980}
    PHA                   ; {138983}
    RTL                   ; {138984}
}

code_021EE9 {
    COP [07] ( #$9E00, &code_021EFB ) ; {138985}
    COP [01] ( &asciistring_02249A ) ; {138991}
    COP [38] ( #$0300 )   ; {138995}
    COP [09] ( #$9E00 )   ; {138999}
}

code_021EFB {
    COP [01] ( &asciistring_0224C2 ) ; {139003}
    COP [1A] ( &chunk_010000.asciistring_014F5B, #02, &code_021F1D ) ; {139007}
    LDA $0003D0           ; {139014}
    BEQ code_021F1D       ; {139018}
    COP [01] ( &asciistring_0224F4 ) ; {139020}
    INC $042D             ; {139024}
    COP [10] ( #$010A, #00, #$01D8, #$0040 ) ; {139027}
    RTL                   ; {139036}
}

code_021F1D {
    COP [01] ( &asciistring_022507 ) ; {139037}
    RTL                   ; {139041}
}

code_021F22 {
    COP [14] ( #$00D9, &code_021F29 ) ; {139042}
    RTL                   ; {139048}
}

code_021F29 {
    JSL $@chunk_018000.code_01B161 ; {139049}
    COP [17] ( &code_021F3D ) ; {139053}
    SEP #$20              ; {139057}
    LDA #$^code_022289    ; {139059}
    PHA                   ; {139061}
    REP #$20              ; {139062}
    LDA #$&code_022289-1  ; {139064}
    PHA                   ; {139067}
    RTL                   ; {139068}
}

code_021F3D {
    COP [07] ( #$9D05, &code_021EFB ) ; {139069}
    COP [01] ( &asciistring_02249A ) ; {139075}
    COP [38] ( #$0400 )   ; {139079}
    COP [09] ( #$9D05 )   ; {139083}
    BRL code_021EFB       ; {139087}
}

code_021F52 {
    LDA $1C6A             ; {139090}
    AND #$00FF            ; {139093}
    CMP #$0045            ; {139096}
    BEQ loc_021F6D        ; {139099}
    CMP #$0047            ; {139101}
    BEQ loc_021F65        ; {139104}
    COP [86]              ; {139106}
    RTL                   ; {139108}

  loc_021F65:
    COP [91]              ; {139109}
    PHX                   ; {139111}
    LDX #$&unk15_021FED   ; {139112}
    BRA loc_021F73        ; {139115}

  loc_021F6D:
    COP [91]              ; {139117}
    PHX                   ; {139119}
    LDX #$&unk15_021FA9   ; {139120}

  loc_021F73:
    LDY $039C             ; {139123}

  loc_021F76:
    LDA $040000, X        ; {139126}
    CMP #$FFFF            ; {139130}
    BEQ loc_021F95        ; {139133}
    CMP $0000, Y          ; {139135}
    BNE loc_021F8D        ; {139138}
    LDA $040002, X        ; {139140}
    CMP $0002, Y          ; {139144}
    BEQ loc_021F97        ; {139147}

  loc_021F8D:
    TXA                   ; {139149}
    CLC                   ; {139150}
    ADC #$0006            ; {139151}
    TAX                   ; {139154}
    BRA loc_021F76        ; {139155}

  loc_021F95:
    PLX                   ; {139157}
    RTL                   ; {139158}

  loc_021F97:
    LDA $040004, X        ; {139159}
    BEQ loc_021FA3        ; {139163}
    COP [09] ( #$8000 )   ; {139165}
    BRA loc_021FA7        ; {139169}

  loc_021FA3:
    COP [09] ( #$0000 )   ; {139171}

  loc_021FA7:
    PLX                   ; {139175}
    RTL                   ; {139176}
}
---------------------------------------------

unk15_021FA9 [
  unk15 < #$00A0, #$00B0, #$0001 >   ;00
  unk15 < #$01C0, #$00A0, #$0001 >   ;01
  unk15 < #$0290, #$0230, #$0001 >   ;02
  unk15 < #$0170, #$01D0, #$0001 >   ;03
  unk15 < #$01C0, #$0260, #$0001 >   ;04
  unk15 < #$0290, #$00A0, #$0001 >   ;05
  unk15 < #$00A0, #$00A0, #$0000 >   ;06
  unk15 < #$01C0, #$0090, #$0000 >   ;07
  unk15 < #$0290, #$0220, #$0000 >   ;08
  unk15 < #$0170, #$01C0, #$0000 >   ;09
  unk15 < #$01C0, #$0250, #$0000 >   ;0A
]

unk15_021FED [
  unk15 < #$0220, #$0200, #$0001 >   ;00
  unk15 < #$0120, #$0140, #$0001 >   ;01
  unk15 < #$01A0, #$01A0, #$0001 >   ;02
  unk15 < #$0220, #$0210, #$0000 >   ;03
]
---------------------------------------------

code_022007 {
    LDA #$2F80            ; {139271}
    TRB $0326             ; {139274}
    COP [91]              ; {139277}
    COP [05] ( #$0000 )   ; {139279}
    COP [19] ( #22, &code_02201C ) ; {139283}
    COP [27] ( &code_022007 ) ; {139288}
}

code_02201C {
    LDY $039C             ; {139292}
    LDA $001E, Y          ; {139295}
    AND #$003F            ; {139298}
    PHX                   ; {139301}
    TAX                   ; {139302}
    LDA $@byte_022032, X  ; {139303}
    PLX                   ; {139307}
    AND #$00FF            ; {139308}
    BNE code_022072       ; {139311}
    RTL                   ; {139313}
}
---------------------------------------------

byte_022032 [
  #00   ;00
  #00   ;01
  #00   ;02
  #00   ;03
  #01   ;04
  #01   ;05
  #01   ;06
  #01   ;07
  #01   ;08
  #01   ;09
  #01   ;0A
  #01   ;0B
  #01   ;0C
  #01   ;0D
  #01   ;0E
  #01   ;0F
  #01   ;10
  #01   ;11
  #01   ;12
  #01   ;13
  #00   ;14
  #00   ;15
  #00   ;16
  #00   ;17
  #00   ;18
  #00   ;19
  #00   ;1A
  #00   ;1B
  #00   ;1C
  #00   ;1D
  #00   ;1E
  #00   ;1F
  #00   ;20
  #00   ;21
  #00   ;22
  #00   ;23
  #00   ;24
  #01   ;25
  #01   ;26
  #00   ;27
  #01   ;28
  #00   ;29
  #01   ;2A
  #00   ;2B
  #00   ;2C
  #00   ;2D
  #00   ;2E
  #00   ;2F
  #00   ;30
  #00   ;31
  #00   ;32
  #00   ;33
  #00   ;34
  #00   ;35
  #00   ;36
  #00   ;37
  #00   ;38
  #00   ;39
  #00   ;3A
  #00   ;3B
  #00   ;3C
  #00   ;3D
  #00   ;3E
  #00   ;3F
]
---------------------------------------------

code_022072 {
    LDA $001E, Y          ; {139378}
    TAY                   ; {139381}
    LDA $&data_00F9F7.binary_00FAAB, Y ; {139382}
    STA $002C, X          ; {139385}
    LDY $039C             ; {139388}
    LDA #$0000            ; {139391}
    STA $0014, Y          ; {139394}
    LDA #$2F80            ; {139397}
    TSB $0326             ; {139400}
    COP [91]              ; {139403}
    COP [07] ( #$0000, &code_0220B4 ) ; {139405}
    COP [19] ( #22, &code_02209B ) ; {139411}
    BRL code_0220B4       ; {139416}
}

code_02209B {
    LDA $002C, X          ; {139419}
    PHX                   ; {139422}
    LDX $039C             ; {139423}
    AND #$00FF            ; {139426}
    BEQ loc_0220B8        ; {139429}
    DEC                   ; {139431}
    BEQ loc_022106        ; {139432}
    DEC                   ; {139434}
    BNE loc_0220B0        ; {139435}
    BRL loc_0221A6        ; {139437}

  loc_0220B0:
    BRL loc_022152        ; {139440}

  code_0220B3:
    PLX                   ; {139443}
}

code_0220B4 {
    COP [27] ( &code_022007 ) ; {139444}

  loc_0220B8:
    LDA $0002, X          ; {139448}
    AND #$000F            ; {139451}
    BNE loc_0220FE        ; {139454}
    LDA $0000, X          ; {139456}
    AND #$000F            ; {139459}
    BEQ loc_0220FA        ; {139462}
    LDA $0000, X          ; {139464}
    AND #$FFF0            ; {139467}
    STA $16               ; {139470}
    LDA $0002, X          ; {139472}
    SEC                   ; {139475}
    SBC #$0020            ; {139476}
    STA $18               ; {139479}
    JSR $&code_0221FA     ; {139481}
    BCS code_0220B3       ; {139484}
    LDA $0000, X          ; {139486}
    AND #$FFF0            ; {139489}
    CLC                   ; {139492}
    ADC #$0010            ; {139493}
    STA $16               ; {139496}
    LDA $0002, X          ; {139498}
    SEC                   ; {139501}
    SBC #$0020            ; {139502}
    STA $18               ; {139505}
    JSR $&code_0221FA     ; {139507}
    BCS code_0220B3       ; {139510}
    BRA loc_0220FE        ; {139512}

  loc_0220FA:
    COP [21] ( &code_0220B3 ) ; {139514}

  loc_0220FE:
    COP [2F] ( #$0000, #$FFFE ) ; {139518}
    PLX                   ; {139524}
    RTL                   ; {139525}

  loc_022106:
    LDA $0002, X          ; {139526}
    AND #$000F            ; {139529}
    BNE loc_02214A        ; {139532}
    LDA $0000, X          ; {139534}
    AND #$000F            ; {139537}
    BEQ loc_022146        ; {139540}
    LDA $0000, X          ; {139542}
    AND #$FFF0            ; {139545}
    STA $16               ; {139548}
    LDA $0002, X          ; {139550}
    STA $18               ; {139553}
    JSR $&code_0221FA     ; {139555}
    BCC loc_02212B        ; {139558}
    BRL code_0220B3       ; {139560}

  loc_02212B:
    LDA $0000, X          ; {139563}
    AND #$FFF0            ; {139566}
    CLC                   ; {139569}
    ADC #$0010            ; {139570}
    STA $16               ; {139573}
    LDA $0002, X          ; {139575}
    STA $18               ; {139578}
    JSR $&code_0221FA     ; {139580}
    BCC loc_022144        ; {139583}
    BRL code_0220B3       ; {139585}

  loc_022144:
    BRA loc_02214A        ; {139588}

  loc_022146:
    COP [22] ( &code_0220B3 ) ; {139590}

  loc_02214A:
    COP [2F] ( #$0000, #$0002 ) ; {139594}
    PLX                   ; {139600}
    RTL                   ; {139601}

  loc_022152:
    LDA $0000, X          ; {139602}
    AND #$000F            ; {139605}
    BNE loc_02219E        ; {139608}
    LDA $0002, X          ; {139610}
    AND #$000F            ; {139613}
    BEQ loc_02219A        ; {139616}
    LDA $0000, X          ; {139618}
    SEC                   ; {139621}
    SBC #$0010            ; {139622}
    STA $16               ; {139625}
    LDA $0002, X          ; {139627}
    AND #$FFF0            ; {139630}
    SEC                   ; {139633}
    SBC #$0010            ; {139634}
    STA $18               ; {139637}
    JSR $&code_0221FA     ; {139639}
    BCC loc_02217F        ; {139642}
    BRL code_0220B3       ; {139644}

  loc_02217F:
    LDA $0000, X          ; {139647}
    SEC                   ; {139650}
    SBC #$0010            ; {139651}
    STA $16               ; {139654}
    LDA $0002, X          ; {139656}
    AND #$FFF0            ; {139659}
    STA $18               ; {139662}
    JSR $&code_0221FA     ; {139664}
    BCC loc_022198        ; {139667}
    BRL code_0220B3       ; {139669}

  loc_022198:
    BRA loc_02219E        ; {139672}

  loc_02219A:
    COP [23] ( &code_0220B3 ) ; {139674}

  loc_02219E:
    COP [2F] ( #$FFFE, #$0000 ) ; {139678}
    PLX                   ; {139684}
    RTL                   ; {139685}

  loc_0221A6:
    LDA $0000, X          ; {139686}
    AND #$000F            ; {139689}
    BNE loc_0221F2        ; {139692}
    LDA $0002, X          ; {139694}
    AND #$000F            ; {139697}
    BEQ loc_0221EE        ; {139700}
    LDA $0000, X          ; {139702}
    CLC                   ; {139705}
    ADC #$0010            ; {139706}
    STA $16               ; {139709}
    LDA $0002, X          ; {139711}
    AND #$FFF0            ; {139714}
    SEC                   ; {139717}
    SBC #$0010            ; {139718}
    STA $18               ; {139721}
    JSR $&code_0221FA     ; {139723}
    BCC loc_0221D3        ; {139726}
    BRL code_0220B3       ; {139728}

  loc_0221D3:
    LDA $0000, X          ; {139731}
    CLC                   ; {139734}
    ADC #$0010            ; {139735}
    STA $16               ; {139738}
    LDA $0002, X          ; {139740}
    AND #$FFF0            ; {139743}
    STA $18               ; {139746}
    JSR $&code_0221FA     ; {139748}
    BCC loc_0221EC        ; {139751}
    BRL code_0220B3       ; {139753}

  loc_0221EC:
    BRA loc_0221F2        ; {139756}

  loc_0221EE:
    COP [24] ( &code_0220B3 ) ; {139758}

  loc_0221F2:
    COP [2F] ( #$0002, #$0000 ) ; {139762}
    PLX                   ; {139768}
    RTL                   ; {139769}
}

code_0221FA {
    PHX                   ; {139770}
    JSL $@chunk_0270E4.code_0272B8 ; {139771}
    LDA $7F8000, X        ; {139775}
    PLX                   ; {139779}
    AND #$00FF            ; {139780}
    BNE loc_02220B        ; {139783}
    CLC                   ; {139785}
    RTS                   ; {139786}

  loc_02220B:
    SEC                   ; {139787}
    RTS                   ; {139788}
}

code_02220D {
    SEP #$20              ; {139789}
    LDA $1C6A             ; {139791}
    LDY #$&unk16_022267   ; {139794}
    CMP #$46              ; {139797}
    BEQ loc_022230        ; {139799}
    LDY #$&unk16_022280   ; {139801}
    CMP #$47              ; {139804}
    BEQ loc_022230        ; {139806}
    LDY #$&unk16_02223D   ; {139808}
    CMP #$3E              ; {139811}
    BEQ loc_022230        ; {139813}
    LDY #$&unk16_022256   ; {139815}
    CMP #$3F              ; {139818}
    BEQ loc_022230        ; {139820}
    BRA loc_022238        ; {139822}

  loc_022230:
    STY $03D8             ; {139824}
    LDA #$^unk16_02223D   ; {139827}
    STA $03DA             ; {139829}

  loc_022238:
    REP #$20              ; {139832}
    COP [86]              ; {139834}
    RTL                   ; {139836}
}
---------------------------------------------

unk16_02223D [
  unk16 < #1A, #1C, #0A, #11, #$0000, #$0001 >   ;00
  unk16 < #16, #18, #19, #27, #$0000, #$0001 >   ;01
  unk16 < #2B, #2D, #2F, #36, #$0000, #$0001 >   ;02
]

unk16_022256 [
  unk16 < #13, #15, #14, #1B, #$0000, #$0001 >   ;00
  unk16 < #1C, #1E, #0A, #11, #$0000, #$0001 >   ;01
]

unk16_022267 [
  unk16 < #02, #1E, #08, #11, #$0000, #$0001 >   ;00
  unk16 < #02, #1E, #2C, #42, #$0000, #$0001 >   ;01
  unk16 < #02, #1E, #4F, #59, #$0000, #$0001 >   ;02
]

unk16_022280 [
  unk16 < #2F, #3E, #21, #36, #$0000, #$0001 >
]
---------------------------------------------

code_022289 {
    COP [2E] ( #00, #$0018, &code_022297 ) ; {139913}
    COP [80] ( #07 )      ; {139920}
    COP [82]              ; {139923}
    BRA code_022289       ; {139925}
}

code_022297 {
    COP [80] ( #0C )      ; {139927}
    COP [82]              ; {139930}
    BRA code_022289       ; {139932}
}

code_02229E {
    COP [1F]              ; {139934}
    LDA $0302             ; {139936}
    AND #$0003            ; {139939}
    BEQ loc_0222B0        ; {139942}
    DEC                   ; {139944}
    BEQ loc_0222B5        ; {139945}
    COP [01] ( &asciistring_0222BA ) ; {139947}
    RTL                   ; {139951}

  loc_0222B0:
    COP [01] ( &asciistring_0222E2 ) ; {139952}
    RTL                   ; {139956}

  loc_0222B5:
    COP [01] ( &asciistring_0222FF ) ; {139957}
    RTL                   ; {139961}
}

asciistring_0222BA |[10]Ouch---- it hurts! [N]Somebody please help [N]me! [JMP:&asciistring_02251E]|

asciistring_0222E2 |[10]I want to return to my[N]real form- [JMP:&asciistring_02251E]|

asciistring_0222FF |[10]Ow---- [JMP:&asciistring_02251E]|

code_02230A {
    PHX                   ; {140042}
    LDX #$0000            ; {140043}
    LDA #$007F            ; {140046}
    STA $7E7800, X        ; {140049}
    LDA #$0010            ; {140053}
    STA $7E7803, X        ; {140056}
    LDA #$0000            ; {140060}
    STA $7E7801, X        ; {140063}
    STA $7E7804, X        ; {140067}
    LDA #$0050            ; {140071}
    STA $0C               ; {140074}
    LDA #$0001            ; {140076}

  loc_02232F:
    STA $7E7806, X        ; {140079}
    INX                   ; {140083}
    INX                   ; {140084}
    INX                   ; {140085}
    DEC $0C               ; {140086}
    BNE loc_02232F        ; {140088}
    LDA $0C               ; {140090}
    STA $7E7806, X        ; {140092}
    PLX                   ; {140096}
    COP [91]              ; {140097}
    PHX                   ; {140099}
    PHB                   ; {140100}
    SEP #$20              ; {140101}
    LDA #$0F              ; {140103}
    XBA                   ; {140105}
    LDA #$7E              ; {140106}
    LDY #$7800            ; {140108}
    JSL $@chunk_010000.code_01188A ; {140111}
    LDA #$7E              ; {140115}
    PHA                   ; {140117}
    PLB                   ; {140118}
    REP #$20              ; {140119}
    LDA #$0050            ; {140121}
    STA $0C               ; {140124}
    LDA $033A             ; {140126}
    SEC                   ; {140129}
    SBC #$0060            ; {140130}
    ASL                   ; {140133}
    STA $00               ; {140134}
    LDX #$0000            ; {140136}

  loc_02236B:
    XBA                   ; {140139}
    STA $7E7807, X        ; {140140}
    XBA                   ; {140144}
    INX                   ; {140145}
    INX                   ; {140146}
    INX                   ; {140147}
    CLC                   ; {140148}
    ADC $00               ; {140149}
    DEC $0C               ; {140151}
    BNE loc_02236B        ; {140153}
    PLB                   ; {140155}
    PLX                   ; {140156}
    RTL                   ; {140157}
}

code_02237E {
    PHX                   ; {140158}
    LDX #$0000            ; {140159}

  loc_022382:
    LDA #$00A0            ; {140162}
    STA $7E7800, X        ; {140165}
    LDA #$7900            ; {140169}
    STA $7E7801, X        ; {140172}
    INX                   ; {140176}
    INX                   ; {140177}
    INX                   ; {140178}
    CPX #$0015            ; {140179}
    BNE loc_022382        ; {140182}
    LDA #$0000            ; {140184}
    STA $7E7800, X        ; {140187}
    PLX                   ; {140191}
    COP [91]              ; {140192}
    PHX                   ; {140194}
    LDA $0312             ; {140195}
    LSR                   ; {140198}
    AND #$001F            ; {140199}
    ASL                   ; {140202}
    TAX                   ; {140203}
    LDY #$0000            ; {140204}
    SEP #$20              ; {140207}
    PHB                   ; {140209}
    LDA #$7E              ; {140210}
    PHA                   ; {140212}
    PLB                   ; {140213}

  loc_0223B6:
    LDA $@word_0223D7, X  ; {140214}
    STA $7900, Y          ; {140218}
    INX                   ; {140221}
    INX                   ; {140222}
    INY                   ; {140223}
    INY                   ; {140224}
    CPY #$0040            ; {140225}
    BNE loc_0223B6        ; {140228}
    PLB                   ; {140230}
    LDA #$10              ; {140231}
    XBA                   ; {140233}
    LDA #$7E              ; {140234}
    LDY #$7800            ; {140236}
    JSL $@chunk_010000.code_01186E ; {140239}
    REP #$20              ; {140243}
    PLX                   ; {140245}
    RTL                   ; {140246}
}
---------------------------------------------

word_0223D7 [
  #$0000   ;00
  #$0001   ;01
  #$0001   ;02
  #$0002   ;03
  #$0002   ;04
  #$0002   ;05
  #$0003   ;06
  #$0003   ;07
  #$0003   ;08
  #$0003   ;09
  #$0003   ;0A
  #$0002   ;0B
  #$0002   ;0C
  #$0002   ;0D
  #$0001   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFF   ;12
  #$FFFE   ;13
  #$FFFE   ;14
  #$FFFE   ;15
  #$FFFD   ;16
  #$FFFD   ;17
  #$FFFD   ;18
  #$FFFD   ;19
  #$FFFD   ;1A
  #$FFFE   ;1B
  #$FFFE   ;1C
  #$FFFE   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0001   ;22
  #$0002   ;23
  #$0002   ;24
  #$0002   ;25
  #$0003   ;26
  #$0003   ;27
  #$0003   ;28
  #$0003   ;29
  #$0003   ;2A
  #$0002   ;2B
  #$0002   ;2C
  #$0002   ;2D
  #$0001   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFF   ;32
  #$FFFE   ;33
  #$FFFE   ;34
  #$FFFE   ;35
  #$FFFD   ;36
  #$FFFD   ;37
  #$FFFD   ;38
  #$FFFD   ;39
  #$FFFD   ;3A
  #$FFFE   ;3B
  #$FFFE   ;3C
  #$FFFE   ;3D
  #$FFFF   ;3E
  #$FFFF   ;3F
]
---------------------------------------------

code_022457 {
    LDA #$1C81            ; {140375}
    STA $7F0000           ; {140378}
    COP [91]              ; {140382}
    PHP                   ; {140384}
    SEP #$20              ; {140385}
    LDA #$32              ; {140387}
    XBA                   ; {140389}
    LDA #$^binary_022471  ; {140390}
    LDY #$&binary_022471  ; {140392}
    JSL $@chunk_010000.code_01188A ; {140395}
    PLP                   ; {140399}
    RTL                   ; {140400}
}
---------------------------------------------

binary_022471 #09F30AF20AF10AF00AEF0AEE0AED0AEC0AEB0AEA0AE90AE80AE70AE60AE50AE40AE30AE20AE122E000
---------------------------------------------

asciistring_02249A |[10]I am watching the [N]world- Here, take [N]this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_0224C2 |[10]Would you like to [N]return to the location[N]of the Mountain of [N]Souls? [END]|

asciistring_0224F4 |Good luck then- [JMP:&asciistring_02251E]|

asciistring_022507 |Return to me when you [N]are ready- [JMP:&asciistring_02251E]|

asciistring_02251E |[12][::][08:408][END]|