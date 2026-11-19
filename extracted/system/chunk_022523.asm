?BANK 04

?INCLUDE 'chunk_000000'
?INCLUDE 'chunk_010000'
?INCLUDE 'chunk_018000'
?INCLUDE 'chunk_020000'
?INCLUDE 'chunk_023FA8'
?INCLUDE 'chunk_0270E4'
?INCLUDE 'table_0099B4'

---------------------------------------------

code_022523 {
    COP [14] ( #$0137, &code_02252A ) ; {140579}
    RTL                   ; {140585}
}

code_02252A {
    COP [85] ( @chunk_000000.code_00299D ) ; {140586}
    COP [15]              ; {140591}
    COP [A2] ( #30 )      ; {140593}
    COP [17] ( &code_02254C ) ; {140596}
    COP [91]              ; {140600}
    COP [80] ( #08 )      ; {140602}
    COP [82]              ; {140605}
    RTL                   ; {140607}
}

code_022540 {
    COP [17] ( &code_022554 ) ; {140608}
    COP [91]              ; {140612}
    COP [80] ( #05 )      ; {140614}
    COP [82]              ; {140617}
    RTL                   ; {140619}
}

code_02254C {
    COP [01] ( &asciistring_022559 ) ; {140620}
    COP [27] ( &code_022540 ) ; {140624}
}

code_022554 {
    COP [01] ( &asciistring_022596 ) ; {140628}
    RTL                   ; {140632}
}

asciistring_022559 |[10]My back hurts because [N]I have been sitting [N]too long- [FIN]I should get up and [N]exercise- [JMP:&asciistring_023FA3]|

asciistring_022596 |[10]It scares people when [N]we move- [N]But we are just [N]exercising- [JMP:&asciistring_023FA3]|

code_0225C4 {
    COP [14] ( #$0112, &code_0225CB ) ; {140740}
    RTL                   ; {140746}
}

code_0225CB {
    COP [85] ( @chunk_000000.code_00299D ) ; {140747}
    COP [17] ( &code_0225FA ) ; {140752}
    BRL loc_0225DE        ; {140756}

  loc_0225D7:
    BRK #$43              ; {140759}
    COP [80] ( #02 )      ; {140761}
    COP [82]              ; {140764}

  loc_0225DE:
    COP [91]              ; {140766}
    COP [0C] ( #00, #02, &code_0225E7 ) ; {140768}
    RTL                   ; {140774}
}

code_0225E7 {
    BRK #$43              ; {140775}
    COP [80] ( #01 )      ; {140777}
    COP [82]              ; {140780}
    COP [91]              ; {140782}
    COP [0C] ( #00, #02, &code_0225F9 ) ; {140784}
    BRL loc_0225D7        ; {140790}
}

code_0225F9 {
    RTL                   ; {140793}
}

code_0225FA {
    COP [01] ( &asciistring_0225FF ) ; {140794}
    RTL                   ; {140798}
}

asciistring_0225FF |[10]--------- [JMP:&asciistring_023FA3]|

code_02260D {
    COP [14] ( #$011A, &code_022614 ) ; {140813}
    RTL                   ; {140819}
}

code_022614 {
    COP [07] ( #$8800, &code_02265C ) ; {140820}
    COP [85] ( @chunk_000000.code_00299D ) ; {140826}
    COP [17] ( &code_022678 ) ; {140831}
    COP [15]              ; {140835}

  loc_022625:
    COP [91]              ; {140837}
    COP [0D] ( #00, #0B, #0D, &code_02262F ) ; {140839}
    RTL                   ; {140846}
}

code_02262F {
    COP [19] ( #27, &code_022645 ) ; {140847}
    COP [01] ( &asciistring_0226AC ) ; {140852}
    COP [09] ( #$8800 )   ; {140856}
    COP [17] ( #$0000 )   ; {140860}
    COP [16]              ; {140864}
    BRL code_02265C       ; {140866}
}

code_022645 {
    COP [01] ( &asciistring_02267D ) ; {140869}
    COP [91]              ; {140873}
    COP [0D] ( #00, #0B, #0D, &code_022654 ) ; {140875}
    BRA loc_022625        ; {140882}
}

code_022654 {
    RTL                   ; {140884}
}

code_022655 {
    BRK #$43              ; {140885}
    COP [80] ( #02 )      ; {140887}
    COP [82]              ; {140890}
}

code_02265C {
    COP [91]              ; {140892}
    COP [0C] ( #00, #02, &code_022665 ) ; {140894}
    RTL                   ; {140900}
}

code_022665 {
    BRK #$43              ; {140901}
    COP [80] ( #01 )      ; {140903}
    COP [82]              ; {140906}
    COP [91]              ; {140908}
    COP [0C] ( #00, #02, &code_022677 ) ; {140910}
    BRL code_022655       ; {140916}
}

code_022677 {
    RTL                   ; {140919}
}

code_022678 {
    COP [01] ( &asciistring_02267D ) ; {140920}
    RTL                   ; {140924}
}

asciistring_02267D |[10]My body is locked- [FIN]There should be a key [N]somewhere in the [N]laboratory- [JMP:&asciistring_023FA3]|

asciistring_0226AC |[10][02:2] used [N]the door key- [JMP:&asciistring_023FA3]|

code_0226C0 {
    COP [14] ( #$0129, &code_0226C7 ) ; {140992}
    RTL                   ; {140998}
}

code_0226C7 {
    COP [85] ( @chunk_000000.code_00299D ) ; {140999}
    COP [17] ( &code_0226F7 ) ; {141004}
    COP [07] ( #$0605, &code_0226DC ) ; {141008}
    COP [07] ( #$8606, &code_0226E4 ) ; {141014}
}

code_0226DC {
    COP [15]              ; {141020}
    COP [05] ( #$0002 )   ; {141022}
    COP [16]              ; {141026}
}

code_0226E4 {
    COP [96]              ; {141028}
    COP [80] ( #0F )      ; {141030}
    COP [82]              ; {141033}
    COP [97]              ; {141035}
    COP [80] ( #0C )      ; {141037}
    COP [82]              ; {141040}
    COP [15]              ; {141042}
    COP [91]              ; {141044}
    RTL                   ; {141046}
}

code_0226F7 {
    COP [07] ( #$0605, &code_022703 ) ; {141047}
    COP [07] ( #$8606, &code_022708 ) ; {141053}
}

code_022703 {
    COP [01] ( &asciistring_022711 ) ; {141059}
    RTL                   ; {141063}
}

code_022708 {
    COP [01] ( &asciistring_022750 ) ; {141064}
    COP [09] ( #$8002 )   ; {141068}
    RTL                   ; {141072}
}

asciistring_022711 |[10]Would you please take [N]the cats out of the [N]room? [FIN]I am too scared to [N]move around with them [N]in here- [JMP:&asciistring_023FA3]|

asciistring_022750 |[10]Thank you very much- [N]Now I can walk around [N]the room freely- [FIN]Let me give you [N]something- [N]Please come inside- [JMP:&asciistring_023FA3]|

code_022794 {
    COP [14] ( #$0114, &code_02279B ) ; {141204}
    RTL                   ; {141210}
}

code_02279B {
    COP [85] ( @chunk_000000.code_00299D ) ; {141211}
    COP [17] ( &code_02282A ) ; {141216}
    COP [07] ( #$8605, &code_022817 ) ; {141220}
    COP [15]              ; {141226}

  loc_0227AC:
    COP [19] ( #26, &code_0227B7 ) ; {141228}
    COP [0C] ( #00, #02, &code_0227BE ) ; {141233}
}

code_0227B7 {
    COP [80] ( #13 )      ; {141239}
    COP [82]              ; {141242}
    BRA loc_0227AC        ; {141244}
}

code_0227BE {
    COP [91]              ; {141246}
    COP [17] ( &code_02282F ) ; {141248}

  code_0227C4:
    COP [0D] ( #05, #16, #10, &code_022809 ) ; {141252}
    COP [9C] ( &code_0227D1, &code_0227ED ) ; {141259}
}

code_0227D1 {
    COP [9A] ( #$0010, &code_0227DB, &code_0227ED, &code_0227E4 ) ; {141265}
}

code_0227DB {
    COP [97]              ; {141275}
    COP [80] ( #12 )      ; {141277}
    COP [82]              ; {141280}
    BRA code_0227C4       ; {141282}
}

code_0227E4 {
    COP [96]              ; {141284}
    COP [80] ( #12 )      ; {141286}
    COP [82]              ; {141289}
    BRA code_0227C4       ; {141291}
}

code_0227ED {
    COP [9B] ( #$0010, &code_0227F7, &code_022805, &code_0227FE ) ; {141293}
}

code_0227F7 {
    COP [80] ( #11 )      ; {141303}
    COP [82]              ; {141306}
    BRA code_0227C4       ; {141308}
}

code_0227FE {
    COP [80] ( #10 )      ; {141310}
    COP [82]              ; {141313}
    BRA code_0227C4       ; {141315}
}

code_022805 {
    COP [27] ( &code_0227C4 ) ; {141317}
}

code_022809 {
    COP [97]              ; {141321}
    COP [81] ( #12, #02 ) ; {141323}
    COP [83]              ; {141327}
    COP [09] ( #$8605 )   ; {141329}
    BRA loc_02281C        ; {141333}
}

code_022817 {
    COP [11] ( #05, #14, #11 ) ; {141335}

  loc_02281C:
    COP [17] ( &code_02282F ) ; {141340}
    COP [15]              ; {141344}
    COP [91]              ; {141346}
    COP [80] ( #13 )      ; {141348}
    COP [82]              ; {141351}
    RTL                   ; {141353}
}

code_02282A {
    COP [01] ( &asciistring_022834 ) ; {141354}
    RTL                   ; {141358}
}

code_02282F {
    COP [01] ( &asciistring_02286C ) ; {141359}
    RTL                   ; {141363}
}

asciistring_022834 |[10]We don t really [N]like to chase rats- [FIN]Cats just have to eat [N]in order to live- [JMP:&asciistring_023FA3]|

asciistring_02286C |[10]What a pleasant smell- [JMP:&asciistring_023FA3]|

code_022886 {
    COP [14] ( #$010D, &code_02288D ) ; {141446}
    RTL                   ; {141452}
}

code_02288D {
    COP [85] ( @chunk_000000.code_00299D ) ; {141453}
    COP [17] ( &code_022923 ) ; {141458}
    COP [07] ( #$8606, &code_022910 ) ; {141462}

  loc_02289C:
    COP [19] ( #26, &code_0228A7 ) ; {141468}
    COP [0C] ( #00, #02, &code_0228AE ) ; {141473}
}

code_0228A7 {
    COP [80] ( #14 )      ; {141479}
    COP [82]              ; {141482}
    BRA loc_02289C        ; {141484}
}

code_0228AE {
    COP [91]              ; {141486}
    COP [96]              ; {141488}
    COP [80] ( #1A )      ; {141490}
    COP [82]              ; {141493}
    COP [17] ( &code_022928 ) ; {141495}

  code_0228BB:
    COP [91]              ; {141499}
    COP [0D] ( #06, #16, #10, &code_022902 ) ; {141501}
    COP [9C] ( &code_0228CA, &code_0228E6 ) ; {141508}
}

code_0228CA {
    COP [9A] ( #$0010, &code_0228D4, &code_0228E6, &code_0228DD ) ; {141514}
}

code_0228D4 {
    COP [97]              ; {141524}
    COP [80] ( #12 )      ; {141526}
    COP [82]              ; {141529}
    BRA code_0228BB       ; {141531}
}

code_0228DD {
    COP [96]              ; {141533}
    COP [80] ( #12 )      ; {141535}
    COP [82]              ; {141538}
    BRA code_0228BB       ; {141540}
}

code_0228E6 {
    COP [9B] ( #$0010, &code_0228F0, &code_0228FE, &code_0228F7 ) ; {141542}
}

code_0228F0 {
    COP [80] ( #11 )      ; {141552}
    COP [82]              ; {141555}
    BRA code_0228BB       ; {141557}
}

code_0228F7 {
    COP [80] ( #10 )      ; {141559}
    COP [82]              ; {141562}
    BRA code_0228BB       ; {141564}
}

code_0228FE {
    COP [27] ( &code_0228BB ) ; {141566}
}

code_022902 {
    COP [96]              ; {141570}
    COP [81] ( #12, #02 ) ; {141572}
    COP [83]              ; {141576}
    COP [09] ( #$8606 )   ; {141578}
    BRA loc_022915        ; {141582}
}

code_022910 {
    COP [11] ( #06, #18, #11 ) ; {141584}

  loc_022915:
    COP [17] ( &code_022928 ) ; {141589}
    COP [15]              ; {141593}
    COP [91]              ; {141595}
    COP [80] ( #13 )      ; {141597}
    COP [82]              ; {141600}
    RTL                   ; {141602}
}

code_022923 {
    COP [01] ( &asciistring_02292D ) ; {141603}
    RTL                   ; {141607}
}

code_022928 {
    COP [01] ( &asciistring_02296A ) ; {141608}
    RTL                   ; {141612}
}

asciistring_02292D |[10]This is Dr-Leo s [N]Laboratory- [FIN]This house has a [N]second floor and an [N]attic- [JMP:&asciistring_023FA3]|

asciistring_02296A |[10]What a good smell- [JMP:&asciistring_023FA3]|

code_02297C {
    COP [14] ( #$011B, &code_022983 ) ; {141692}
    RTL                   ; {141698}
}

code_022983 {
    COP [85] ( @chunk_000000.code_00299D ) ; {141699}
    COP [17] ( &code_022994 ) ; {141704}
    COP [91]              ; {141708}
    COP [80] ( #15 )      ; {141710}
    COP [82]              ; {141713}
    RTL                   ; {141715}
}

code_022994 {
    COP [01] ( &asciistring_022999 ) ; {141716}
    RTL                   ; {141720}
}

asciistring_022999 |[10]Doo|

code_02299D {
    ADC ($73)             ; {141725}
    JSR $7598             ; {141727}
    ADC ($75, S), Y       ; {141730}
    ADC ($6C, X)          ; {141732}
    JMP ($2079)           ; {141734}
    ORA $7571             ; {141737}
    ADC #$7465            ; {141740}
    BIT $&table_0099B4.unk2_00A21B+5 ; {141743}
    SBC #$0D98            ; {141746}
    ADC ($6F, S), Y       ; {141749}
    ADC $2065             ; {141751}
    STZ $61, X            ; {141754}
    JMP ($616B)           ; {141756}
    STZ $69, X            ; {141759}
    ROR $65, X            ; {141761}
    JSR $6E6F             ; {141763}
    ADC $73               ; {141766}
    ROL $1120             ; {141768}
    MVN #$72, #$79        ; {141771}
    JSR $&chunk_023FA8.code_026A96 ; {141774}
    SEP #$9A              ; {141777}
    ADC $740D66           ; {141779}
    PLA                   ; {141783}
    ADC $6D               ; {141784}
    ROL $1320             ; {141786}
    LDA $BF, S            ; {141789}
}

code_0229DF {
    COP [14] ( #$010C, &code_0229E6 ) ; {141791}
    RTL                   ; {141797}
}

code_0229E6 {
    COP [85] ( @chunk_000000.code_00299D ) ; {141798}
    COP [17] ( &code_022A69 ) ; {141803}
    COP [15]              ; {141807}

  code_0229F1:
    COP [91]              ; {141809}
    COP [03] ( #02 )      ; {141811}
    COP [80] ( #08 )      ; {141814}
    COP [82]              ; {141817}
    LDA $0322             ; {141819}
    AND #$0200            ; {141822}
    BEQ loc_022A2E        ; {141825}
    COP [0D] ( #00, #04, #10, &code_022A0C ) ; {141827}
    BRA loc_022A2E        ; {141834}
}

code_022A0C {
    COP [04]              ; {141836}
    LDA #$2F80            ; {141838}
    TSB $0326             ; {141841}
    COP [16]              ; {141844}
    COP [81] ( #1D, #10 ) ; {141846}
    COP [83]              ; {141850}
    COP [15]              ; {141852}
    LDA #$2F80            ; {141854}
    TRB $0326             ; {141857}
    COP [91]              ; {141860}
    COP [0D] ( #00, #03, #10, &code_022A32 ) ; {141862}
    RTL                   ; {141869}

  loc_022A2E:
    COP [27] ( &code_0229F1 ) ; {141870}
}

code_022A32 {
    COP [07] ( #$9A06, &code_022A45 ) ; {141874}
    COP [01] ( &asciistring_022ADC ) ; {141880}
    BRK #$5E              ; {141884}
    COP [0A] ( #30 )      ; {141886}
    COP [09] ( #$9A06 )   ; {141889}
}

code_022A45 {
    COP [91]              ; {141893}
    RTL                   ; {141895}
}

code_022A48 {
    LDA #$2F80            ; {141896}
    TSB $0326             ; {141899}
    COP [80] ( #1B )      ; {141902}
    COP [82]              ; {141905}
    COP [01] ( &asciistring_022A9D ) ; {141907}
    BRK #$5E              ; {141911}
    COP [0A] ( #0D )      ; {141913}
    COP [80] ( #1C )      ; {141916}
    COP [82]              ; {141919}
    LDA #$2F80            ; {141921}
    TRB $0326             ; {141924}
    BRA code_0229F1       ; {141927}
}

code_022A69 {
    COP [18] ( #0D, &code_022A73 ) ; {141929}
    COP [01] ( &asciistring_022AB8 ) ; {141934}
    RTL                   ; {141938}
}

code_022A73 {
    COP [01] ( &asciistring_022A7B ) ; {141939}
    COP [27] ( &code_022A48 ) ; {141943}
}

asciistring_022A7B |[10]Take the Mystic Armor [N]from my drawer- [JMP:&asciistring_023FA3]|

asciistring_022A9D |[10][02:2] received [N][03:24]Mystic Armor- [03:20][JMP:&asciistring_023FA3]|

asciistring_022AB8 |[10]My body is made from [N]the trees in [N]GreenWood- [JMP:&asciistring_023FA3]|

asciistring_022ADC |[10][02:2] found [N][03:24]Master s Emblem G- [03:20][JMP:&asciistring_023FA3]|

code_022AFB {
    COP [14] ( #$0139, &code_022B02 ) ; {142075}
    RTL                   ; {142081}
}

code_022B02 {
    COP [85] ( @chunk_000000.code_00299D ) ; {142082}
    COP [17] ( &code_022B15 ) ; {142087}
    COP [15]              ; {142091}
    COP [91]              ; {142093}
    COP [80] ( #03 )      ; {142095}
    COP [82]              ; {142098}
    RTL                   ; {142100}
}

code_022B15 {
    COP [01] ( &asciistring_022B1A ) ; {142101}
    RTL                   ; {142105}
}

asciistring_022B1A |[10]If the soul of the [N]Great Door joins you, [FIN]you will be able to [N]see the invisible [N]enemies in the models [N]of town- [FIN]Listen to what the cat[N]says- [JMP:&asciistring_023FA3]|

code_022B80 {
    COP [14] ( #$0109, &code_022B87 ) ; {142208}
    RTL                   ; {142214}
}

code_022B87 {
    COP [15]              ; {142215}
    COP [17] ( &code_022B9E ) ; {142217}
    COP [A0] ( #$FFFC )   ; {142221}
    COP [85] ( @chunk_000000.code_00299D ) ; {142225}
    COP [91]              ; {142230}
    COP [80] ( #03 )      ; {142232}
    COP [82]              ; {142235}
    RTL                   ; {142237}
}

code_022B9E {
    COP [01] ( &asciistring_022BC8 ) ; {142238}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_022BC3 ) ; {142242}
    LDA $0003D0           ; {142249}
    BNE code_022BC3       ; {142253}
    COP [18] ( #38, &code_022BB9 ) ; {142255}
    COP [01] ( &asciistring_022C21 ) ; {142260}
    RTL                   ; {142264}
}

code_022BB9 {
    COP [01] ( &asciistring_022BE2 ) ; {142265}
    BRK #$5E              ; {142269}
    COP [0A] ( #38 )      ; {142271}
    RTL                   ; {142274}
}

code_022BC3 {
    COP [01] ( &asciistring_022C55 ) ; {142275}
    RTL                   ; {142279}
}

asciistring_022BC8 |[10]Would you like [N]a Medical Herb? [END]|

asciistring_022BE2 |[10]Take any leaves that [N]you want from my body-[FIN]OUCH! [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&asciistring_023FA3]|

asciistring_022C21 |[10]Medical Herbs are part[N]of my body- I cannot [N]give many at one time-[JMP:&asciistring_023FA3]|

asciistring_022C55 |[10]Oh, really? Come and [N]ask me when you are in[N]trouble- [JMP:&asciistring_023FA3]|

code_022C7C {
    COP [14] ( #$010B, &code_022C83 ) ; {142460}
    RTL                   ; {142466}
}

code_022C83 {
    COP [15]              ; {142467}
    COP [A0] ( #$FFFC )   ; {142469}
    COP [85] ( @chunk_000000.code_00299D ) ; {142473}
    COP [17] ( &code_022C9A ) ; {142478}
    COP [91]              ; {142482}
    COP [80] ( #03 )      ; {142484}
    COP [82]              ; {142487}
    RTL                   ; {142489}
}

code_022C9A {
    COP [01] ( &asciistring_022C9F ) ; {142490}
    RTL                   ; {142494}
}

asciistring_022C9F |[10]The room on the second[N]floor is Dr-Leo s- [FIN]There were two models [N]of town in his room- [FIN]Many creatures were [N]swallowed into the [N]models- [JMP:&asciistring_023FA3]|

code_022D05 {
    COP [14] ( #$014A, &code_022D0C ) ; {142597}
    RTL                   ; {142603}
}

code_022D0C {
    COP [85] ( @chunk_000000.code_00299D ) ; {142604}
    COP [17] ( &code_022D63 ) ; {142609}
    COP [15]              ; {142613}
    COP [05] ( #$0000 )   ; {142615}
    COP [16]              ; {142619}
    COP [9A] ( #$0000, &code_022D27, &code_022D27, &code_022D37 ) ; {142621}
}

code_022D27 {
    COP [96]              ; {142631}
    COP [80] ( #0F )      ; {142633}
    COP [82]              ; {142636}
    COP [97]              ; {142638}
    COP [80] ( #0C )      ; {142640}
    COP [82]              ; {142643}
    BRA loc_022D45        ; {142645}
}

code_022D37 {
    COP [97]              ; {142647}
    COP [80] ( #0F )      ; {142649}
    COP [82]              ; {142652}
    COP [96]              ; {142654}
    COP [80] ( #0C )      ; {142656}
    COP [82]              ; {142659}

  loc_022D45:
    COP [15]              ; {142661}
    COP [91]              ; {142663}
    COP [0D] ( #00, #14, #05, &code_022D51 ) ; {142665}
    RTL                   ; {142672}
}

code_022D51 {
    LDA $0322             ; {142673}
    AND #$0800            ; {142676}
    BNE loc_022D5A        ; {142679}
    RTL                   ; {142681}

  loc_022D5A:
    COP [01] ( &asciistring_022D98 ) ; {142682}
    COP [37]              ; {142686}
    COP [91]              ; {142688}
    RTL                   ; {142690}
}

code_022D63 {
    COP [01] ( &asciistring_022D6C ) ; {142691}
    COP [09] ( #$8000 )   ; {142695}
    RTL                   ; {142699}
}

asciistring_022D6C |[10]I am a devout mouse, [N]stand here and you [N]will be purified- [JMP:&asciistring_023FA3]|

asciistring_022D98 |[10][02:2], [N]felt his body and mind[N]become purified- [JMP:&asciistring_023FA3]|

code_022DC6 {
    COP [14] ( #$0120, &code_022DCD ) ; {142790}
    RTL                   ; {142796}
}

code_022DCD {
    COP [85] ( @chunk_000000.code_00299D ) ; {142797}
    COP [17] ( &code_022DFC ) ; {142802}
    BRL loc_022DE0        ; {142806}

  loc_022DD9:
    BRK #$43              ; {142809}
    COP [80] ( #02 )      ; {142811}
    COP [82]              ; {142814}

  loc_022DE0:
    COP [91]              ; {142816}
    COP [0C] ( #00, #02, &code_022DE9 ) ; {142818}
    RTL                   ; {142824}
}

code_022DE9 {
    BRK #$43              ; {142825}
    COP [80] ( #01 )      ; {142827}
    COP [82]              ; {142830}
    COP [91]              ; {142832}
    COP [0C] ( #00, #02, &code_022DFB ) ; {142834}
    BRL loc_022DD9        ; {142840}
}

code_022DFB {
    RTL                   ; {142843}
}

code_022DFC {
    COP [01] ( &asciistring_022E01 ) ; {142844}
    RTL                   ; {142848}
}

asciistring_022E01 |[10]---------- [JMP:&asciistring_023FA3]|

code_022E10 {
    COP [14] ( #$0142, &code_022E17 ) ; {142864}
    RTL                   ; {142870}
}

code_022E17 {
    COP [30] ( #$0142, &code_022E7E, #04 ) ; {142871}
    COP [07] ( #$8603, &code_022E53 ) ; {142878}
    COP [85] ( @chunk_000000.code_00299D ) ; {142884}
    COP [17] ( &code_022E60 ) ; {142889}
    BRL loc_022E37        ; {142893}

  loc_022E30:
    BRK #$43              ; {142896}
    COP [80] ( #02 )      ; {142898}
    COP [82]              ; {142901}

  loc_022E37:
    COP [91]              ; {142903}
    COP [0C] ( #00, #02, &code_022E40 ) ; {142905}
    RTL                   ; {142911}
}

code_022E40 {
    BRK #$43              ; {142912}
    COP [80] ( #01 )      ; {142914}
    COP [82]              ; {142917}
    COP [91]              ; {142919}
    COP [0C] ( #00, #02, &code_022E52 ) ; {142921}
    BRL loc_022E30        ; {142927}
}

code_022E52 {
    RTL                   ; {142930}
}

code_022E53 {
    COP [85] ( @chunk_000000.code_00299D ) ; {142931}
    COP [80] ( #1F )      ; {142936}
    COP [82]              ; {142939}
    COP [91]              ; {142941}
    RTL                   ; {142943}
}

code_022E60 {
    COP [01] ( &asciistring_022EEE ) ; {142944}
    COP [09] ( #$8603 )   ; {142948}
    BRK #$4E              ; {142952}
    SEP #$20              ; {142954}
    LDA $1B82             ; {142956}
    ORA #$08              ; {142959}
    STA $1B82             ; {142961}
    REP #$20              ; {142964}
    COP [17] ( #$0000 )   ; {142966}
    COP [27] ( &code_022E53 ) ; {142970}
}

code_022E7E {
    COP [01] ( &asciistring_022E85 ) ; {142974}
    COP [86]              ; {142978}
    RTL                   ; {142980}
}

asciistring_022E85 |[10][0E:3C][02:2] hears [N]the door [N]speaking to itself- [FIN]I can see------ [FIN]I can see machines [N]throwing bombs inside [N]the model towns- [JMP:&asciistring_023FA3]|

asciistring_022EEE |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]Let me join you- [FIN]The soul that enables [N]you to see invisible [N]enemies in model towns[N]joins you- [JMP:&asciistring_023FA3]|

code_022F68 {
    COP [14] ( #$0126, &code_022F6F ) ; {143208}
    RTL                   ; {143214}
}

code_022F6F {
    COP [30] ( #$0126, &code_022FF3, #04 ) ; {143215}
    COP [85] ( @chunk_000000.code_00299D ) ; {143222}
    COP [17] ( &code_022FCD ) ; {143227}
    COP [15]              ; {143231}
    COP [07] ( #$8802, &code_022FC5 ) ; {143233}
    COP [91]              ; {143239}
    COP [0D] ( #00, #09, #0A, &code_022F91 ) ; {143241}
    RTL                   ; {143248}
}

code_022F91 {
    COP [07] ( #$0801, &code_022FC2 ) ; {143249}
    COP [17] ( #$0000 )   ; {143255}
    LDA #$2F80            ; {143259}
    TSB $0326             ; {143262}
    COP [80] ( #13 )      ; {143265}
    COP [82]              ; {143268}
    COP [03] ( #1F )      ; {143270}
    COP [04]              ; {143273}
    COP [01] ( &asciistring_02306C ) ; {143275}
    BRK #$5E              ; {143279}
    COP [0A] ( #27 )      ; {143281}
    COP [09] ( #$8802 )   ; {143284}
    LDA #$2F80            ; {143288}
    TRB $0326             ; {143291}
    COP [17] ( &code_022FCD ) ; {143294}
}

code_022FC2 {
    COP [91]              ; {143298}
    RTL                   ; {143300}
}

code_022FC5 {
    COP [91]              ; {143301}
    COP [80] ( #13 )      ; {143303}
    COP [82]              ; {143306}
    RTL                   ; {143308}
}

code_022FCD {
    COP [07] ( #$8802, &code_022FEE ) ; {143309}
    COP [19] ( #1C, &code_022FE9 ) ; {143315}
    COP [01] ( &asciistring_023049 ) ; {143320}
    COP [3C] ( #04 )      ; {143324}
    COP [10] ( #$050D, #01, #$00C0, #$0010 ) ; {143327}
    RTL                   ; {143336}
}

code_022FE9 {
    COP [01] ( &asciistring_02303F ) ; {143337}
    RTL                   ; {143341}
}

code_022FEE {
    COP [01] ( &asciistring_0230FA ) ; {143342}
    RTL                   ; {143346}
}

code_022FF3 {
    COP [01] ( &asciistring_022FFA ) ; {143347}
    COP [86]              ; {143351}
    RTL                   ; {143353}
}

asciistring_022FFA |[10][0E:3C]The cat is sleeping- [N]He looks as though he [N]is suffering- [FIN]Uh, uh, Dr-Leo? [JMP:&asciistring_023FA3]|

asciistring_02303F |[10]Zzzzz [JMP:&asciistring_023FA3]|

asciistring_023049 |[10][02:2] places [N]the Dream Rod on the [N]cat s head- [JMP:&asciistring_023FA3]|

asciistring_02306C |[10]Lately, I always see [N]Dr-Leo in my dreams- [FIN]I was scared when he [N]was taken away- [N]I had been hiding [N]under the table- [FIN]Oh yes, I will give [N]you this- [N]Dr-Leo left this- [FIN][02:2] received [N][03:24]a door key- [03:20][JMP:&asciistring_023FA3]|

asciistring_0230FA |[10]There are invisible [N]enemies in the models [N]town- [N]Please be careful- [JMP:&asciistring_023FA3]|

code_02312F {
    COP [14] ( #$013E, &code_023136 ) ; {143663}
    RTL                   ; {143669}
}

code_023136 {
    COP [85] ( @chunk_000000.code_00299D ) ; {143670}
    COP [17] ( &code_023144 ) ; {143675}
    COP [15]              ; {143679}
    COP [91]              ; {143681}
    RTL                   ; {143683}
}

code_023144 {
    COP [01] ( &asciistring_023149 ) ; {143684}
    RTL                   ; {143688}
}

asciistring_023149 |[10]Use magic to defeat [N]the enemies which you [N]cannot reach- [JMP:&asciistring_023FA3]|

code_02317F {
    COP [14] ( #$014D, &code_023186 ) ; {143743}
    RTL                   ; {143749}
}

code_023186 {
    COP [85] ( @chunk_000000.code_00299D ) ; {143750}
    COP [17] ( &code_023199 ) ; {143755}
    COP [15]              ; {143759}
    COP [91]              ; {143761}
    COP [80] ( #03 )      ; {143763}
    COP [82]              ; {143766}
    RTL                   ; {143768}
}

code_023199 {
    COP [18] ( #26, &code_0231A3 ) ; {143769}
    COP [01] ( &asciistring_023200 ) ; {143774}
    RTL                   ; {143778}
}

code_0231A3 {
    COP [01] ( &asciistring_0231AD ) ; {143779}
    BRK #$5E              ; {143783}
    COP [0A] ( #26 )      ; {143785}
    RTL                   ; {143788}
}

asciistring_0231AD |[10]I am an Actinidia- [N]Take some of my leaves[N]if you want- [FIN]OUCH! [FIN][02:2] received [N][03:24]Actinidia leaves- [03:20][JMP:&asciistring_023FA3]|

asciistring_023200 |[10]I am happy to help [N]you- [JMP:&asciistring_023FA3]|

code_023214 {
    COP [14] ( #$0136, &code_02321B ) ; {143892}
    RTL                   ; {143898}
}

code_02321B {
    COP [85] ( @chunk_000000.code_00299D ) ; {143899}
    COP [17] ( &code_02322E ) ; {143904}
    COP [15]              ; {143908}
    COP [91]              ; {143910}
    COP [80] ( #18 )      ; {143912}
    COP [82]              ; {143915}
    RTL                   ; {143917}
}

code_02322E {
    COP [01] ( &asciistring_023233 ) ; {143918}
    RTL                   ; {143922}
}

asciistring_023233 |[10]The large machines in [N]the basement were the [N]machines which [N]summoned evil- [FIN]They were made by [N]Dr-Leo- [FIN]When those machines [N]started to move, the [N]cities were destroyed-[JMP:&asciistring_023FA3]|

code_0232B3 {
    COP [14] ( #$014C, &code_0232BA ) ; {144051}
    RTL                   ; {144057}
}

code_0232BA {
    COP [85] ( @chunk_000000.code_00299D ) ; {144058}
    COP [17] ( &code_0232CD ) ; {144063}
    COP [15]              ; {144067}
    COP [91]              ; {144069}
    COP [80] ( #07 )      ; {144071}
    COP [82]              ; {144074}
    RTL                   ; {144076}
}

code_0232CD {
    COP [07] ( #$8807, &code_0232FF ) ; {144077}
    COP [18] ( #38, &code_0232FA ) ; {144083}
    COP [01] ( &asciistring_023317 ) ; {144088}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_0232F5 ) ; {144092}
    LDA $0003D0           ; {144099}
    BNE code_0232F5       ; {144103}
    COP [01] ( &asciistring_0233D0 ) ; {144105}
    COP [0B] ( #38 )      ; {144109}
    COP [09] ( #$8807 )   ; {144112}
    RTL                   ; {144116}
}

code_0232F5 {
    COP [01] ( &asciistring_0233B1 ) ; {144117}
    RTL                   ; {144121}
}

code_0232FA {
    COP [01] ( &asciistring_023374 ) ; {144122}
    RTL                   ; {144126}
}

code_0232FF {
    COP [18] ( #38, &code_023309 ) ; {144127}
    COP [01] ( &asciistring_02342E ) ; {144132}
    RTL                   ; {144136}
}

code_023309 {
    COP [01] ( &asciistring_023403 ) ; {144137}
    BRK #$5E              ; {144141}
    COP [0A] ( #38 )      ; {144143}
    COP [09] ( #$0807 )   ; {144146}
    RTL                   ; {144150}
}

asciistring_023317 |[10]If there s nothing in[N]a chest then the chest[N]is good for nothing- [FIN]Would you store your [N]Medical Herbs in my [N]drawer? [END]|

asciistring_023374 |[10]If there s nothing [N]in a chest, [N]a chest doesn t mean [N]anything- [JMP:&asciistring_023FA3]|

asciistring_0233B1 |I am the happiest [N]chest in the world- [JMP:&asciistring_023FA3]|

asciistring_0233D0 |[02:2] put [N]his Medical Herbs [N]in the drawer- [FIN]I am satisfied- [JMP:&asciistring_023FA3]|

asciistring_023403 |[10]Are you taking them [N]out? Well, it s okay- [JMP:&asciistring_023FA3]|

asciistring_02342E |[10]You have a Medical [N]Herb- I will give [N]them back to you when [N]you have run out- [JMP:&asciistring_023FA3]|

code_02345D {
    COP [14] ( #$0153, &code_023464 ) ; {144477}
    RTL                   ; {144483}
}

code_023464 {
    COP [85] ( @chunk_000000.code_00299D ) ; {144484}
    COP [17] ( &code_023477 ) ; {144489}
    COP [15]              ; {144493}
    COP [91]              ; {144495}
    COP [80] ( #15 )      ; {144497}
    COP [82]              ; {144500}
    RTL                   ; {144502}
}

code_023477 {
    COP [01] ( &asciistring_02347C ) ; {144503}
    RTL                   ; {144507}
}

asciistring_02347C |[10]This room belongs to a[N]doll named Marie- [FIN]She told me many [N]things about foreign [N]towns- [FIN]A girl named Lisa took[N]care of Marie- [JMP:&asciistring_023FA3]|

code_0234EC {
    COP [14] ( #$012F, &code_0234F3 ) ; {144620}
    RTL                   ; {144626}
}

code_0234F3 {
    COP [30] ( #$012F, &code_023558, #04 ) ; {144627}
    COP [07] ( #$9F02, &code_023513 ) ; {144634}
    COP [85] ( @chunk_000000.code_00299D ) ; {144640}
    COP [17] ( &code_02353F ) ; {144645}
    COP [15]              ; {144649}
    COP [91]              ; {144651}
    COP [80] ( #18 )      ; {144653}
    COP [82]              ; {144656}
    RTL                   ; {144658}
}

code_023513 {
    LDA #$BFC0            ; {144659}
    TSB $0326             ; {144662}
    COP [03] ( #29 )      ; {144665}
    COP [04]              ; {144668}
    COP [01] ( &asciistring_023675 ) ; {144670}
    COP [03] ( #5B )      ; {144674}
    COP [04]              ; {144677}
    LDA #$0020            ; {144679}
    STA $03B4             ; {144682}
    COP [10] ( #$010A, #01, #$0100, #$0380 ) ; {144685}
    LDA #$BFC0            ; {144694}
    TRB $0326             ; {144697}
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

asciistring_023561 |[10][0E:3C]I am Marie, the doll- [N]I have [03:24]a Purple Stone [N][03:20]in my pocket- [FIN]Take this with you and[N]save Dr-Leo- [JMP:&asciistring_023FA3]|

asciistring_0235AC |[10]Nobody can break a [N]promise that is made [N]with Evil- [FIN]There will be no [N]revival of the world [N]unless Deathtoll is [N]defeated- [FIN]Dr-Leo must be [N]somewhere in the [N]Magridd Castle- [FIN]Here, take this stone [N]from my pocket and go [N]to the Magridd Castle- [JMP:&asciistring_023FA3]|

asciistring_023644 |[10]I wonder how Lisa is, [N]I want to see her [N]after the world is [N]revived- [JMP:&asciistring_023FA3]|

asciistring_023675 |[10][0F][02:2], [N]you made it- [N][0E:3C]Dr-Leo can pass away [N]peacefully- [N][0E:5A]We tools, exist to be [N]used by human beings- [N][0E:5A]We are happy if we re [N]helpful to the humans-[N][0E:3C]And we hurt if they [N]use us in the wrong [N]way- [N][0E:5A]Even though we would [N]like to tell them not [N]to use us the wrong [N]way, we cannot- [N][0E:3C]This is very painful- [N][0E:5A]But Dr-Leo understood[N]our feelings- [N][0E:5A]The tools Dr-Leo used[N]must have been happy- [0E:78][JMP:&asciistring_023FA3+M]|

code_0237A7 {
    COP [14] ( #$0152, &code_0237AE ) ; {145319}
    RTL                   ; {145325}
}

code_0237AE {
    COP [85] ( @chunk_000000.code_00299D ) ; {145326}
    COP [17] ( &code_0237DB ) ; {145331}
    COP [81] ( #1E, #08 ) ; {145335}
    COP [83]              ; {145339}

  loc_0237BD:
    COP [81] ( #0D, #02 ) ; {145341}
    COP [83]              ; {145345}
    COP [96]              ; {145347}
    COP [81] ( #0F, #03 ) ; {145349}
    COP [83]              ; {145353}
    COP [81] ( #0E, #02 ) ; {145355}
    COP [83]              ; {145359}
    COP [97]              ; {145361}
    COP [81] ( #0F, #03 ) ; {145363}
    COP [83]              ; {145367}
    BRA loc_0237BD        ; {145369}
}

code_0237DB {
    COP [01] ( &asciistring_0237E0 ) ; {145371}
    RTL                   ; {145375}
}

asciistring_0237E0 |[10]We are weak and timid [N]animals- [FIN]Don t you think it s [N]unfair the weaker [N]creatures are defeated[N]first? [JMP:&asciistring_023FA3]|

code_02382D {
    COP [14] ( #$013B, &code_023834 ) ; {145453}
    RTL                   ; {145459}
}

code_023834 {
    COP [85] ( @chunk_000000.code_00299D ) ; {145460}
    COP [17] ( &code_023861 ) ; {145465}
    COP [81] ( #1E, #08 ) ; {145469}
    COP [83]              ; {145473}

  loc_023843:
    COP [81] ( #0E, #02 ) ; {145475}
    COP [83]              ; {145479}
    COP [97]              ; {145481}
    COP [81] ( #0F, #03 ) ; {145483}
    COP [83]              ; {145487}
    COP [81] ( #0D, #02 ) ; {145489}
    COP [83]              ; {145493}
    COP [96]              ; {145495}
    COP [81] ( #0F, #03 ) ; {145497}
    COP [83]              ; {145501}
    BRA loc_023843        ; {145503}
}

code_023861 {
    COP [01] ( &asciistring_023866 ) ; {145505}
    RTL                   ; {145509}
}

asciistring_023866 |[10]I would have liked to [N]have been born a [N]plant- [FIN]I would not fear [N]anything- [JMP:&asciistring_023FA3]|

code_0238A7 {
    COP [14] ( #$013C, &code_0238AE ) ; {145575}
    RTL                   ; {145581}
}

code_0238AE {
    COP [85] ( @chunk_000000.code_00299D ) ; {145582}
    COP [17] ( &code_0238D3 ) ; {145587}
    COP [15]              ; {145591}

  loc_0238B9:
    COP [0C] ( #00, #04, &code_0238C6 ) ; {145593}
    COP [80] ( #0C )      ; {145599}
    COP [82]              ; {145602}
    BRA loc_0238B9        ; {145604}
}

code_0238C6 {
    COP [80] ( #1E )      ; {145606}
    COP [82]              ; {145609}
    COP [0C] ( #00, #04, &code_0238C6 ) ; {145611}
    BRA loc_0238B9        ; {145617}
}

code_0238D3 {
    COP [07] ( #$0605, &code_0238DF ) ; {145619}
    COP [07] ( #$8606, &code_0238E4 ) ; {145625}
}

code_0238DF {
    COP [01] ( &asciistring_0238F8 ) ; {145631}
    RTL                   ; {145635}
}

code_0238E4 {
    COP [18] ( #15, &code_0238EE ) ; {145636}
    COP [01] ( &asciistring_023976 ) ; {145641}
    RTL                   ; {145645}
}

code_0238EE {
    COP [01] ( &asciistring_023921 ) ; {145646}
    BRK #$5E              ; {145650}
    COP [0A] ( #15 )      ; {145652}
    RTL                   ; {145655}
}

asciistring_0238F8 |[10]We cannot walk [N]around outside because[N]of the cats- [JMP:&asciistring_023FA3]|

asciistring_023921 |[10]Thank you for getting [N]rid of the cats- [FIN]Take this magic, the [N]Magic of Spark Bomb- [FIN][02:2] received [N][03:24]Spark Bomb- [03:20][JMP:&asciistring_023FA3]|

asciistring_023976 |[10]It is not easy to hit [N]the enemies with Spark[N]Bomb, but if you do, [N]it works very well- [JMP:&asciistring_023FA3]|

code_0239BA {
    COP [14] ( #$011E, &code_0239C1 ) ; {145850}
    RTL                   ; {145856}
}

code_0239C1 {
    COP [17] ( &code_0239C8 ) ; {145857}
    COP [91]              ; {145861}
    RTL                   ; {145863}
}

code_0239C8 {
    COP [01] ( &asciistring_0239D6 ) ; {145864}
    COP [10] ( #$010F, #01, #$01F8, #$03E0 ) ; {145868}
    RTL                   ; {145877}
}

asciistring_0239D6 |[10][0F][02:2] is [N]swallowed into the [N]model- [JMP:&asciistring_023FA3]|

code_0239F8 {
    COP [14] ( #$0145, &code_0239FF ) ; {145912}
    RTL                   ; {145918}
}

code_0239FF {
    COP [17] ( &code_023A06 ) ; {145919}
    COP [91]              ; {145923}
    RTL                   ; {145925}
}

code_023A06 {
    COP [01] ( &asciistring_023A14 ) ; {145926}
    COP [10] ( #$020F, #01, #$01F8, #$03E0 ) ; {145930}
    RTL                   ; {145939}
}

asciistring_023A14 |[10][0F][02:2] is [N]swallowed into the [N]model- [JMP:&asciistring_023FA3]|

code_023A36 {
    COP [07] ( #$8600, &code_023A4C ) ; {145974}
    COP [17] ( &code_023A68 ) ; {145980}
    COP [15]              ; {145984}
    COP [91]              ; {145986}
    RTL                   ; {145988}
}

code_023A45 {
    BRK #$43              ; {145989}
    COP [80] ( #02 )      ; {145991}
    COP [82]              ; {145994}
}

code_023A4C {
    COP [91]              ; {145996}
    COP [0C] ( #00, #02, &code_023A55 ) ; {145998}
    RTL                   ; {146004}
}

code_023A55 {
    BRK #$43              ; {146005}
    COP [80] ( #01 )      ; {146007}
    COP [82]              ; {146010}
    COP [91]              ; {146012}
    COP [0C] ( #00, #02, &code_023A67 ) ; {146014}
    BRL code_023A45       ; {146020}
}

code_023A67 {
    RTL                   ; {146023}
}

code_023A68 {
    COP [01] ( &asciistring_023A7A ) ; {146024}
    COP [09] ( #$8600 )   ; {146028}
    COP [16]              ; {146032}
    COP [17] ( #$0000 )   ; {146034}
    COP [27] ( &code_023A4C ) ; {146038}
}

asciistring_023A7A |[10]This is Dr-Leo s [N]laboratory- [FIN]There are machines [N]lurking around here [N]which only the [N]powerful [FIN]Zantetsu Sword can [N]defeat- [FIN]First of all, talk to [N]a certain door to get [N]you into the room- [JMP:&asciistring_023FA3]|

code_023B0B {
    LDA #$2F80            ; {146187}
    TSB $0326             ; {146190}
    COP [03] ( #02 )      ; {146193}
    COP [04]              ; {146196}
    COP [34]              ; {146198}
    COP [03] ( #29 )      ; {146200}
    COP [04]              ; {146203}
    COP [01] ( &asciistring_023B65 ) ; {146205}
    COP [03] ( #15 )      ; {146209}
    COP [04]              ; {146212}
    COP [96]              ; {146214}
    COP [80] ( #23 )      ; {146216}
    COP [82]              ; {146219}
    COP [01] ( &asciistring_023B88 ) ; {146221}
    COP [09] ( #$8000 )   ; {146225}
    COP [05] ( #$0001 )   ; {146229}
    COP [01] ( &asciistring_023C8F ) ; {146233}
    COP [09] ( #$8002 )   ; {146237}
    COP [05] ( #$0003 )   ; {146241}
    COP [80] ( #1F )      ; {146245}
    COP [82]              ; {146248}
    COP [01] ( &asciistring_023D13 ) ; {146250}
    COP [09] ( #$8801 )   ; {146254}
    LDA #$2F80            ; {146258}
    TRB $0326             ; {146261}
    COP [3C] ( #04 )      ; {146264}
    COP [10] ( #$020D, #01, #$0090, #$00A0 ) ; {146267}
    RTL                   ; {146276}
}

asciistring_023B65 |[10]Dr-Leo, King Magridd [N]wishes to see you at [N]once! [JMP:&asciistring_023FA3]|

asciistring_023B88 |[10]Are you going to allow[N]him to make a deal [N]with Deathtoll? [FIN]King Magridd knows [N]nothing about the [N]value of human lives! [FIN]No matter how small, [N]all creatures have a [N]right to exist in this[N]world- [FIN]If the trees in this [N]world were cut in [N]half, [FIN]the oxygen would [N]decrease and many of [N]us would die- [FIN][10]We do what King [N]Magridd tells us to [N]do- [FIN]King Magridd makes all[N]of the decisions for [N]us- [JMP:&asciistring_023FA3]|

asciistring_023C8F |[10]Dr-Leo, you love your[N]daughter Lisa don t [N]you? [FIN]If you obey, she will [N]remain safe- [FIN]We will be waiting for[N]you outside in the [N]airship- [FIN]Come out when you are [N]ready- [JMP:&asciistring_023FA3]|

asciistring_023D13 |[10]Please forgive me! [FIN]The world will go to [N]ruin sooner or later- [FIN]But I can do nothing [N]more- [FIN]Oh, Master! Please [N]help me- [JMP:&asciistring_023FA3]|

code_023D6B {
    COP [05] ( #$0002 )   ; {146795}
    COP [96]              ; {146799}
    COP [81] ( #17, #04 ) ; {146801}
    COP [83]              ; {146805}
    COP [81] ( #15, #05 ) ; {146807}
    COP [83]              ; {146811}
    COP [09] ( #$8003 )   ; {146813}
    COP [86]              ; {146817}
    RTL                   ; {146819}
}

code_023D84 {
    COP [05] ( #$0000 )   ; {146820}
    BRK #$43              ; {146824}
    COP [81] ( #16, #04 ) ; {146826}
    COP [83]              ; {146830}
    COP [97]              ; {146832}
    COP [81] ( #17, #03 ) ; {146834}
    COP [83]              ; {146838}
    COP [01] ( &asciistring_023DBC ) ; {146840}
    COP [03] ( #1F )      ; {146844}
    COP [04]              ; {146847}
    COP [09] ( #$8001 )   ; {146849}
    COP [05] ( #$0002 )   ; {146853}
    COP [96]              ; {146857}
    COP [81] ( #17, #03 ) ; {146859}
    COP [83]              ; {146863}
    COP [81] ( #15, #05 ) ; {146865}
    COP [83]              ; {146869}
    BRK #$43              ; {146871}
    COP [86]              ; {146873}
    RTL                   ; {146875}
}

asciistring_023DBC |[10]Hey, it s time to go- [JMP:&asciistring_023FA3]|

code_023DD3 {
    COP [14] ( #$0127, &code_023DDA ) ; {146899}
    RTL                   ; {146905}
}

code_023DDA {
    JSL $@chunk_018000.code_01B161 ; {146906}
    COP [17] ( &code_023DEE ) ; {146910}
    SEP #$20              ; {146914}
    LDA #$^chunk_020000.code_022289 ; {146916}
    PHA                   ; {146918}
    REP #$20              ; {146919}
    LDA #$&chunk_020000.code_022289-1 ; {146921}
    PHA                   ; {146924}
    RTL                   ; {146925}
}

code_023DEE {
    COP [07] ( #$9D01, &code_023E00 ) ; {146926}
    COP [01] ( &asciistring_023F33 ) ; {146932}
    COP [38] ( #$0300 )   ; {146936}
    COP [09] ( #$9D01 )   ; {146940}
}

code_023E00 {
    COP [01] ( &asciistring_023F59 ) ; {146944}
    COP [1A] ( &chunk_010000.asciistring_014F5B, #02, &code_023E22 ) ; {146948}
    LDA $0003D0           ; {146955}
    BEQ code_023E22       ; {146959}
    COP [01] ( &asciistring_023F7D ) ; {146961}
    INC $042D             ; {146965}
    COP [10] ( #$010D, #00, #$0188, #$0190 ) ; {146968}
    RTL                   ; {146977}
}

code_023E22 {
    COP [01] ( &asciistring_023F8B ) ; {146978}
    RTL                   ; {146982}
}

code_023E27 {
    COP [14] ( #$0147, &code_023E2E ) ; {146983}
    RTL                   ; {146989}
}

code_023E2E {
    JSL $@chunk_018000.code_01B161 ; {146990}
    COP [17] ( &code_023E42 ) ; {146994}
    SEP #$20              ; {146998}
    LDA #$^chunk_020000.code_022289 ; {147000}
    PHA                   ; {147002}
    REP #$20              ; {147003}
    LDA #$&chunk_020000.code_022289-1 ; {147005}
    PHA                   ; {147008}
    RTL                   ; {147009}
}

code_023E42 {
    COP [07] ( #$9D02, &code_023E00 ) ; {147010}
    COP [01] ( &asciistring_023F33 ) ; {147016}
    COP [38] ( #$0300 )   ; {147020}
    COP [09] ( #$9D02 )   ; {147024}
    BRL code_023E00       ; {147028}
}

code_023E57 {
    COP [14] ( #$0130, &code_023E5E ) ; {147031}
    RTL                   ; {147037}
}

code_023E5E {
    JSL $@chunk_018000.code_01B161 ; {147038}
    COP [17] ( &code_023E72 ) ; {147042}
    SEP #$20              ; {147046}
    LDA #$^chunk_020000.code_022289 ; {147048}
    PHA                   ; {147050}
    REP #$20              ; {147051}
    LDA #$&chunk_020000.code_022289-1 ; {147053}
    PHA                   ; {147056}
    RTL                   ; {147057}
}

code_023E72 {
    COP [07] ( #$9D03, &code_023E00 ) ; {147058}
    COP [01] ( &asciistring_023F33 ) ; {147064}
    COP [38] ( #$0300 )   ; {147068}
    COP [09] ( #$9D03 )   ; {147072}
    BRL code_023E00       ; {147076}
}

code_023E87 {
    COP [14] ( #$0143, &code_023E8E ) ; {147079}
    RTL                   ; {147085}
}

code_023E8E {
    COP [07] ( #$9B07, &code_023EF0 ) ; {147086}
    COP [09] ( #$9B07 )   ; {147092}
    COP [B2] ( &code_023EF3, #04, #$0000, #$0000, #$4000 ) ; {147096}
    COP [B2] ( &code_023EF3, #04, #$0020, #$0000, #$4000 ) ; {147107}
    COP [B2] ( &code_023EF3, #04, #$0040, #$0000, #$4000 ) ; {147118}
    COP [B2] ( &code_023EF3, #04, #$0060, #$0000, #$4000 ) ; {147129}
    COP [B2] ( &code_023EF3, #04, #$0000, #$0040, #$4000 ) ; {147140}
    COP [B2] ( &code_023EF3, #04, #$0020, #$0040, #$4000 ) ; {147151}
    COP [B2] ( &code_023EF3, #04, #$0040, #$0040, #$4000 ) ; {147162}
    COP [B2] ( &code_023EF3, #04, #$0060, #$0040, #$4000 ) ; {147173}
}

code_023EF0 {
    COP [86]              ; {147184}
    RTL                   ; {147186}
}

code_023EF3 {
    COP [A8] ( #$8000, #0E ) ; {147187}
    LDA $0005             ; {147192}
    STA $001E, X          ; {147195}
    STZ $0020, X          ; {147198}
    LDA $0372             ; {147201}
    STA $001C, X          ; {147204}
    COP [A4]              ; {147207}
    COP [80] ( #05 )      ; {147209}
    COP [82]              ; {147212}
    COP [81] ( #0A, #3C ) ; {147214}
    COP [83]              ; {147218}
    COP [86]              ; {147220}
    RTL                   ; {147222}
}

code_023F17 {
    COP [19] ( #0A, &code_023F1D ) ; {147223}
    RTL                   ; {147228}
}

code_023F1D {
    LDA #$00F3            ; {147229}
    JSL $@chunk_0270E4.code_027462 ; {147232}
    BCS loc_023F2F        ; {147236}
    LDA #$00E1            ; {147238}
    JSL $@chunk_0270E4.code_027462 ; {147241}
    BCC loc_023F32        ; {147245}

  loc_023F2F:
    COP [39] ( #04 )      ; {147247}

  loc_023F32:
    RTL                   ; {147250}
}

asciistring_023F33 |[10]I am watching over the[N]world- Please take [N]this- [FIN][02:2] received [N]EXP- [FIN][END]|

asciistring_023F59 |[10]Would you like to go [N]back to Dr-Leo s [N]Laboratory? [END]|

asciistring_023F7D |Good luck- [JMP:&asciistring_023FA3]|

asciistring_023F8B |Come back to me when [N]you wish to return- [JMP:&asciistring_023FA3]|

asciistring_023FA3 |[12][::][08:408][END]|