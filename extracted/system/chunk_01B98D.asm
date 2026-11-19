?BANK 03

?INCLUDE 'chunk_000000'
?INCLUDE 'chunk_010000'
?INCLUDE 'chunk_018000'
?INCLUDE 'chunk_0270E4'

!APUIO0                         2140

---------------------------------------------

code_01B98D {
    COP [14] ( #$0056, &code_01B994 ) ; {113037}
    RTL                   ; {113043}
}

code_01B994 {
    COP [85] ( @chunk_000000.code_00299D ) ; {113044}
    COP [17] ( &code_01BA28 ) ; {113049}

  loc_01B99D:
    COP [80] ( #0E )      ; {113053}
    COP [82]              ; {113056}
    COP [15]              ; {113058}
    COP [1B] ( &code_01B9AA, #$0078 ) ; {113060}
}

code_01B9AA {
    COP [16]              ; {113066}
    COP [9F] ( #$0008 )   ; {113068}
    COP [1E] ( #$EFFF )   ; {113072}
    COP [81] ( #0F, #04 ) ; {113076}
    COP [83]              ; {113080}
    COP [1D] ( #$1000 )   ; {113082}
    COP [9F] ( #$FFF8 )   ; {113086}
    COP [81] ( #11, #03 ) ; {113090}
    COP [83]              ; {113094}
    COP [9D] ( #11 )      ; {113096}
    COP [9E] ( &code_01B9CF ) ; {113099}
}

code_01B9CF {
    COP [15]              ; {113103}
    COP [1B] ( &code_01B9D7, #$0078 ) ; {113105}
}

code_01B9D7 {
    COP [16]              ; {113111}
    COP [9F] ( #$0008 )   ; {113113}
    COP [81] ( #10, #02 ) ; {113117}
    COP [83]              ; {113121}
    COP [9F] ( #$FFF8 )   ; {113123}
    COP [80] ( #0E )      ; {113127}
    COP [82]              ; {113130}
    COP [15]              ; {113132}
    COP [1B] ( &code_01B9F4, #$0078 ) ; {113134}
}

code_01B9F4 {
    COP [16]              ; {113140}
    COP [9F] ( #$0008 )   ; {113142}
    COP [81] ( #10, #03 ) ; {113146}
    COP [83]              ; {113150}
    COP [87]              ; {113152}
    COP [9F] ( #$FFF8 )   ; {113154}
    COP [81] ( #11, #03 ) ; {113158}
    COP [83]              ; {113162}
    COP [9D] ( #11 )      ; {113164}
    COP [9E] ( &code_01BA13 ) ; {113167}
}

code_01BA13 {
    COP [87]              ; {113171}
    COP [9F] ( #$0008 )   ; {113173}
    COP [80] ( #0F )      ; {113177}
    COP [82]              ; {113180}
    COP [9F] ( #$FFF8 )   ; {113182}
    BRL loc_01B99D        ; {113186}

  loc_01BA25:
    COP [91]              ; {113189}
    RTL                   ; {113191}
}

code_01BA28 {
    COP [01] ( &asciistring_01BA6B ) ; {113192}

  loc_01BA2C:
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_01BA64 ) ; {113196}
    LDA $0003D0           ; {113203}
    BNE code_01BA64       ; {113207}
    COP [01] ( &asciistring_01BAAA ) ; {113209}
    LDA #$0000            ; {113213}
    STA $APUIO0           ; {113216}
    LDA $1B84             ; {113219}
    PHA                   ; {113222}
    LDA #$0005            ; {113223}
    STA $1B84             ; {113226}
    COP [01] ( &asciistring_01BAD8 ) ; {113229}
    PLA                   ; {113233}
    STA $1B84             ; {113234}
    COP [01] ( &asciistring_01BAE1 ) ; {113237}
    LDA #$0001            ; {113241}
    STA $APUIO0           ; {113244}
    COP [01] ( &asciistring_01BB03 ) ; {113247}
    RTL                   ; {113251}
}

code_01BA64 {
    COP [01] ( &asciistring_01BA8F ) ; {113252}
    BRL loc_01BA2C        ; {113256}
}

asciistring_01BA6B |[10]This is a restaurant- [N][::]Would you like to see [N]the menu? [END]|

asciistring_01BA8F |Come on! At least [N]take a look- [N][JMP:&asciistring_01BA6B+M]|

asciistring_01BAAA |Great! Let me tell [N]you our special of the[N]day------- [0E:78][END]|

asciistring_01BAD8 |[10]You! [0E:78][END]|

asciistring_01BAE1 |I m just kidding! [N]Please don t be [N]offended- [FIN][END]|

asciistring_01BB03 |[0E:8][10]This restaurant is [N]famous for delicious [N]food and fruit [N]drinks! [JMP:&asciistring_01EC46]|

code_01BB3F {
    COP [14] ( #$004A, &code_01BB46 ) ; {113471}
    RTL                   ; {113477}
}

code_01BB46 {
    COP [85] ( @chunk_000000.code_00299D ) ; {113478}
    COP [17] ( &code_01BC1C ) ; {113483}
    COP [15]              ; {113487}
    COP [91]              ; {113489}
    COP [14] ( #$005D, &code_01BB5A ) ; {113491}
    RTL                   ; {113497}
}

code_01BB5A {
    COP [14] ( #$003F, &code_01BB61 ) ; {113498}
    RTL                   ; {113504}
}

code_01BB61 {
    COP [17] ( &code_01BC21 ) ; {113505}
    COP [05] ( #$0003 )   ; {113509}
    COP [16]              ; {113513}
    COP [17] ( #$0000 )   ; {113515}
    COP [A1] ( #$0008, #$0008 ) ; {113519}
    COP [81] ( #12, #03 ) ; {113525}
    COP [83]              ; {113529}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {113531}
    COP [87]              ; {113537}
    COP [81] ( #14, #03 ) ; {113539}
    COP [83]              ; {113543}
    COP [87]              ; {113545}
    COP [A1] ( #$0008, #$0008 ) ; {113547}
    COP [81] ( #13, #03 ) ; {113553}
    COP [83]              ; {113557}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {113559}
    COP [81] ( #14, #03 ) ; {113565}
    COP [83]              ; {113569}
    COP [85] ( @chunk_000000.code_00299D ) ; {113571}
    BRK #$4E              ; {113576}
    COP [80] ( #02 )      ; {113578}
    COP [82]              ; {113581}
    COP [1B] ( &code_01BBB5, #$003C ) ; {113583}
}

code_01BBB5 {
    COP [09] ( #$8004 )   ; {113589}
    COP [80] ( #00 )      ; {113593}
    COP [82]              ; {113596}
    COP [15]              ; {113598}
    COP [17] ( &code_01BC21 ) ; {113600}
    COP [05] ( #$0006 )   ; {113604}
    COP [16]              ; {113608}
    COP [17] ( #$0000 )   ; {113610}
    COP [81] ( #05, #03 ) ; {113614}
    COP [83]              ; {113618}
    COP [80] ( #03 )      ; {113620}
    COP [82]              ; {113623}
    COP [87]              ; {113625}
    COP [80] ( #05 )      ; {113627}
    COP [82]              ; {113630}
    COP [87]              ; {113632}
    COP [80] ( #05 )      ; {113634}
    COP [82]              ; {113637}
    COP [80] ( #04 )      ; {113639}
    COP [82]              ; {113642}
    COP [81] ( #05, #03 ) ; {113644}
    COP [83]              ; {113648}
    COP [87]              ; {113650}
    COP [81] ( #05, #06 ) ; {113652}
    COP [83]              ; {113656}
    COP [80] ( #00 )      ; {113658}
    COP [82]              ; {113661}
    COP [15]              ; {113663}
    COP [17] ( &code_01BC26 ) ; {113665}
    COP [05] ( #$0007 )   ; {113669}
    COP [85] ( @chunk_000000.code_00299D ) ; {113673}
    BRK #$4E              ; {113678}
    COP [80] ( #12 )      ; {113680}
    COP [82]              ; {113683}
    COP [17] ( &code_01BC33 ) ; {113685}
    COP [91]              ; {113689}
    RTL                   ; {113691}
}

code_01BC1C {
    COP [01] ( &asciistring_01BC47 ) ; {113692}
    RTL                   ; {113696}
}

code_01BC21 {
    COP [01] ( &asciistring_01BCBF ) ; {113697}
    RTL                   ; {113701}
}

code_01BC26 {
    COP [01] ( &asciistring_01D49D ) ; {113702}
    COP [09] ( #$8006 )   ; {113706}
    COP [09] ( #$8007 )   ; {113710}
    RTL                   ; {113714}
}

code_01BC33 {
    COP [07] ( #$8000, &code_01BC42 ) ; {113715}
    COP [01] ( &asciistring_01D4BB ) ; {113721}
    COP [17] ( &code_01BC42 ) ; {113725}
    RTL                   ; {113729}
}

code_01BC42 {
    COP [01] ( &asciistring_01D4D0 ) ; {113730}
    RTL                   ; {113734}
}

asciistring_01BC47 |[10]Hello, I am a member [N]of the famous [N]"Woodstin+Trio-ˮ [FIN]We usually have a [N]variety show at this [N]theater, [FIN]but I am missing my [N]two sidekicks- [JMP:&asciistring_01EC46]|

asciistring_01BCBF |[10]Hey, don t walk [N]around, you re [N]annoying me- [JMP:&asciistring_01EC46]|

code_01BCEC {
    COP [14] ( #$005A, &code_01BCF3 ) ; {113900}
    RTL                   ; {113906}
}

code_01BCF3 {
    COP [85] ( @chunk_000000.code_00299D ) ; {113907}
    COP [17] ( &code_01BD11 ) ; {113912}

  loc_01BCFC:
    COP [81] ( #11, #03 ) ; {113916}
    COP [83]              ; {113920}
    COP [15]              ; {113922}
    COP [1B] ( &code_01BD0A, #$0028 ) ; {113924}
}

code_01BD0A {
    COP [16]              ; {113930}
    COP [87]              ; {113932}
    BRL loc_01BCFC        ; {113934}
}

code_01BD11 {
    COP [07] ( #$8402, &code_01BD1D ) ; {113937}
    COP [14] ( #$0061, &code_01BD22 ) ; {113943}
}

code_01BD1D {
    COP [01] ( &asciistring_01BD27 ) ; {113949}
    RTL                   ; {113953}
}

code_01BD22 {
    COP [01] ( &asciistring_01BD84 ) ; {113954}
    RTL                   ; {113958}
}

asciistring_01BD27 |[10]I am guarding the [N]graveyard- [FIN]I hear someone snoring[N]but can t tell from [N]which direction the [N]sound is coming- [JMP:&asciistring_01EC46]|

asciistring_01BD84 |[10]I am guarding the [N]graveyard- [FIN]I hear someone snoring[N]but can t tell which [N]direction the sound [N]is coming from- [JMP:&asciistring_01EC46]|

code_01BDE5 {
    COP [14] ( #$0037, &code_01BDEC ) ; {114149}
    RTL                   ; {114155}
}

code_01BDEC {
    COP [85] ( @chunk_000000.code_00299D ) ; {114156}
    COP [AC] ( @code_01BEE5, #$0030, #$0110, #$2040 ) ; {114161}
    COP [15]              ; {114172}

  loc_01BDFE:
    COP [0C] ( #00, #04, &code_01BE0C ) ; {114174}

  code_01BE04:
    COP [80] ( #18 )      ; {114180}
    COP [82]              ; {114183}
    BRL loc_01BDFE        ; {114185}
}

code_01BE0C {
    COP [9B] ( #$0010, &code_01BE04, &code_01BE16, &code_01BE16 ) ; {114188}
}

code_01BE16 {
    COP [17] ( #$0000 )   ; {114198}
    COP [16]              ; {114202}
    COP [A3]              ; {114204}
    COP [80] ( #1E )      ; {114206}
    COP [82]              ; {114209}
    COP [81] ( #1F, #05 ) ; {114211}
    COP [83]              ; {114215}
    COP [80] ( #20 )      ; {114217}
    COP [82]              ; {114220}
    COP [87]              ; {114222}
    COP [A6]              ; {114224}
    COP [15]              ; {114226}
    COP [17] ( &code_01BE3B ) ; {114228}
    BRL loc_01BDFE        ; {114232}
}

code_01BE3B {
    COP [18] ( #18, &code_01BE42 ) ; {114235}
    BRA loc_01BE47        ; {114240}
}

code_01BE42 {
    COP [18] ( #32, &code_01BE4C ) ; {114242}

  loc_01BE47:
    COP [01] ( &asciistring_01BED2 ) ; {114247}
    RTL                   ; {114251}
}

code_01BE4C {
    COP [01] ( &asciistring_01BE56 ) ; {114252}
    BRK #$5E              ; {114256}
    COP [0A] ( #32 )      ; {114258}
    RTL                   ; {114261}
}

asciistring_01BE56 |[10]AHHHH! [N]You scared me! Please [N]don t sneak up behind [N]me- [FIN]Well, I guess it s [N]okay- I have something[N]special for you- [FIN][02:2] received [N][03:24]the Red+Hot Mirror- [03:20][JMP:&asciistring_01EC46]|

asciistring_01BED2 |[10]AHHHH! [N]You scared me! [N][JMP:&asciistring_01EC46]|

code_01BEE5 {
    COP [17] ( &code_01BEF1 ) ; {114405}
    COP [91]              ; {114409}
    COP [80] ( #23 )      ; {114411}
    COP [82]              ; {114414}
    RTL                   ; {114416}
}

code_01BEF1 {
    COP [01] ( &asciistring_01BEF6 ) ; {114417}
    RTL                   ; {114421}
}

asciistring_01BEF6 |[10][0A]For█shy█birds,[N]you█better█approach[N]quietly█from█behind-[JMP:&asciistring_01EC46]|

code_01BF32 {
    COP [14] ( #$0063, &code_01BF39 ) ; {114482}
    RTL                   ; {114488}
}

code_01BF39 {
    COP [85] ( @chunk_000000.code_00299D ) ; {114489}
    COP [AC] ( @code_01C261, #$0030, #$0200, #$2040 ) ; {114494}
    COP [17] ( &code_01BFED ) ; {114505}
    COP [07] ( #$0306, &code_01BF62 ) ; {114509}
    COP [17] ( &code_01C015 ) ; {114515}
    COP [AC] ( @code_01C0B0, #$00A0, #$00B0, #$0050 ) ; {114519}
}

code_01BF62 {
    COP [15]              ; {114530}
    COP [91]              ; {114532}
    RTL                   ; {114534}
}

code_01BF67 {
    COP [16]              ; {114535}
    COP [81] ( #16, #09 ) ; {114537}
    COP [83]              ; {114541}
    COP [9F] ( #$FFF8 )   ; {114543}
    COP [87]              ; {114547}
    COP [80] ( #17 )      ; {114549}
    COP [82]              ; {114552}
    COP [9F] ( #$0008 )   ; {114554}
    COP [80] ( #16 )      ; {114558}
    COP [82]              ; {114561}
    COP [15]              ; {114563}
    COP [17] ( &code_01C009 ) ; {114565}
    COP [91]              ; {114569}
    RTL                   ; {114571}
}

code_01BF8C {
    COP [09] ( #$8002 )   ; {114572}

  code_01BF90:
    COP [16]              ; {114576}
    COP [80] ( #25 )      ; {114578}
    COP [82]              ; {114581}
    COP [80] ( #26 )      ; {114583}
    COP [82]              ; {114586}
    BRK #$4A              ; {114588}
    LDA #$2F80            ; {114590}
    TSB $0326             ; {114593}
    COP [03] ( #08 )      ; {114596}
    LDA $002E, X          ; {114599}
    CLC                   ; {114602}
    ADC $033C             ; {114603}
    STA $033C             ; {114606}
    COP [1B] ( &code_01BFB7, #$0002 ) ; {114609}
}

code_01BFB7 {
    COP [04]              ; {114615}
    LDA #$2F80            ; {114617}
    TRB $0326             ; {114620}
    COP [07] ( #$0002, &code_01BF8C ) ; {114623}
    COP [AC] ( @code_01C08A, #$00A0, #$0010, #$0050 ) ; {114629}
    COP [1B] ( &code_01BFD6, #$005A ) ; {114640}
}

code_01BFD6 {
    COP [80] ( #12 )      ; {114646}
    COP [82]              ; {114649}
    COP [80] ( #15 )      ; {114651}
    COP [82]              ; {114654}
    COP [15]              ; {114656}
    COP [17] ( &code_01C015 ) ; {114658}
    COP [09] ( #$8306 )   ; {114662}
    COP [91]              ; {114666}
    RTL                   ; {114668}
}

code_01BFED {
    COP [14] ( #$006F, &code_01BFF8 ) ; {114669}
    COP [01] ( &asciistring_01C01A ) ; {114675}
    RTL                   ; {114679}
}

code_01BFF8 {
    COP [01] ( &asciistring_01C043 ) ; {114680}
    COP [17] ( &code_01C004 ) ; {114684}
    COP [27] ( &code_01BF67 ) ; {114688}
}

code_01C004 {
    COP [01] ( &asciistring_01C043 ) ; {114692}
    RTL                   ; {114696}
}

code_01C009 {
    COP [01] ( &asciistring_01C052 ) ; {114697}
    COP [17] ( #$0000 )   ; {114701}
    COP [27] ( &code_01BF90 ) ; {114705}
}

code_01C015 {
    COP [01] ( &asciistring_01C065 ) ; {114709}
    RTL                   ; {114713}
}

asciistring_01C01A |[10]If you help me [N]cross the river I will[N]give you something- [JMP:&asciistring_01EC46]|

asciistring_01C043 |[10]Follow me- [JMP:&asciistring_01EC46]|

asciistring_01C052 |[10]Stand back and watch! [JMP:&asciistring_01EC46]|

asciistring_01C065 |[10]What did you think? [N]I hope this helped- [JMP:&asciistring_01EC46]|

code_01C08A {
    JSL $@chunk_018000.code_01B161 ; {114826}
    STZ $0014, X          ; {114830}
    COP [03] ( #28 )      ; {114833}
    LDA $0002, X          ; {114836}
    CLC                   ; {114839}
    ADC #$0004            ; {114840}
    STA $0002, X          ; {114843}
    COP [04]              ; {114846}
    COP [17] ( &code_01C0C4 ) ; {114848}
    SEP #$20              ; {114852}
    LDA #$^chunk_018000.code_01B17C ; {114854}
    PHA                   ; {114856}
    REP #$20              ; {114857}
    LDA #$&chunk_018000.code_01B17C-1 ; {114859}
    PHA                   ; {114862}
    RTL                   ; {114863}
}

code_01C0B0 {
    JSL $@chunk_018000.code_01B161 ; {114864}
    COP [17] ( &code_01C0C4 ) ; {114868}
    SEP #$20              ; {114872}
    LDA #$^chunk_018000.code_01B17C ; {114874}
    PHA                   ; {114876}
    REP #$20              ; {114877}
    LDA #$&chunk_018000.code_01B17C-1 ; {114879}
    PHA                   ; {114882}
    RTL                   ; {114883}
}

code_01C0C4 {
    COP [18] ( #40, &code_01C0CE ) ; {114884}
    COP [01] ( &asciistring_01C224 ) ; {114889}
    RTL                   ; {114893}
}

code_01C0CE {
    COP [18] ( #2A, &code_01C118 ) ; {114894}
    COP [18] ( #2B, &code_01C118 ) ; {114899}
    COP [18] ( #2C, &code_01C118 ) ; {114904}
    COP [18] ( #2D, &code_01C118 ) ; {114909}
    COP [18] ( #2E, &code_01C118 ) ; {114914}
    COP [18] ( #2F, &code_01C118 ) ; {114919}
    COP [18] ( #30, &code_01C118 ) ; {114924}
    COP [18] ( #31, &code_01C118 ) ; {114929}
    COP [01] ( &asciistring_01C1D8 ) ; {114934}
    COP [0B] ( #2A )      ; {114938}
    COP [0B] ( #2B )      ; {114941}
    COP [0B] ( #2C )      ; {114944}
    COP [0B] ( #2D )      ; {114947}
    COP [0B] ( #2E )      ; {114950}
    COP [0B] ( #2F )      ; {114953}
    COP [0B] ( #30 )      ; {114956}
    COP [0B] ( #31 )      ; {114959}
    BRK #$5E              ; {114962}
    COP [0A] ( #40 )      ; {114964}
    RTL                   ; {114967}
}

code_01C118 {
    COP [01] ( &asciistring_01C11D ) ; {114968}
    RTL                   ; {114972}
}

asciistring_01C11D |[10]The Master s Emblems [N]are all over the [N]world------- [FIN]They are fairly [N]difficult to find- [FIN]Collect all 8 emblems,[N]will not require GEMs [N]when casting magic- [FIN]This will make [N]fighting much easier [N]If you collect all 8, [N]bring them to me- [JMP:&asciistring_01EC46]|

asciistring_01C1D8 |[10][02:2], [N]you collected all 8 [N]emblems- [FIN]I will now give you [N][03:24]the Magic Bell- [N][03:20]You have fought well! [JMP:&asciistring_01EC46]|

asciistring_01C224 |[10]The Magic Bell [N]enables you to use [N]magic without GEMs- [FIN][02:2], good luck! [JMP:&asciistring_01EC46]|

code_01C261 {
    COP [17] ( &code_01C26D ) ; {115297}
    COP [91]              ; {115301}
    COP [80] ( #23 )      ; {115303}
    COP [82]              ; {115306}
    RTL                   ; {115308}
}

code_01C26D {
    COP [01] ( &asciistring_01C272 ) ; {115309}
    RTL                   ; {115313}
}

asciistring_01C272 |[10][0A]There█once█was█a█raft[N]made█from█the█bark█of[N]my█branches-[FIN]You█must█find█this[N]raft-█I█believe█it[N]might█be█able[N]help█you█in█some█way-[JMP:&asciistring_01EC46]|

code_01C2F9 {
    COP [14] ( #$0058, &code_01C300 ) ; {115449}
    RTL                   ; {115455}
}

code_01C300 {
    COP [85] ( @chunk_000000.code_00299D ) ; {115456}
    COP [AC] ( @code_01C372, #$0070, #$02D0, #$2040 ) ; {115461}
    COP [17] ( &code_01C335 ) ; {115472}
    COP [91]              ; {115476}

  loc_01C316:
    COP [81] ( #05, #03 ) ; {115478}
    COP [83]              ; {115482}
    COP [81] ( #03, #03 ) ; {115484}
    COP [83]              ; {115488}
    COP [87]              ; {115490}
    COP [81] ( #05, #03 ) ; {115492}
    COP [83]              ; {115496}
    COP [81] ( #04, #03 ) ; {115498}
    COP [83]              ; {115502}
    COP [87]              ; {115504}
    BRL loc_01C316        ; {115506}
}

code_01C335 {
    COP [01] ( &asciistring_01C33A ) ; {115509}
    RTL                   ; {115513}
}

asciistring_01C33A |[10]I hear someone [N]snoring- [N]I cannot tell who is [N]making the noise- [JMP:&asciistring_01EC46]|

code_01C372 {
    COP [17] ( &code_01C37E ) ; {115570}
    COP [91]              ; {115574}
    COP [80] ( #23 )      ; {115576}
    COP [82]              ; {115579}
    RTL                   ; {115581}
}

code_01C37E {
    COP [19] ( #1C, &code_01C397 ) ; {115582}
    COP [01] ( &asciistring_01C3A7 ) ; {115587}
    STZ $0419             ; {115591}
    COP [3C] ( #04 )      ; {115594}
    COP [10] ( #$0604, #02, #$0120, #$0040 ) ; {115597}
    RTL                   ; {115606}
}

code_01C397 {
    COP [01] ( &asciistring_01C39C ) ; {115607}
    RTL                   ; {115611}
}

asciistring_01C39C |[10][0A]Zzzzz [JMP:&asciistring_01EC46]|

asciistring_01C3A7 |[10][02:2] placed the [N]Dream Rod upon the [N]stump- [JMP:&asciistring_01EC46]|

code_01C3CA {
    COP [14] ( #$0046, &code_01C3D1 ) ; {115658}
    RTL                   ; {115664}
}

code_01C3D1 {
    COP [85] ( @chunk_000000.code_00299D ) ; {115665}
    COP [AC] ( @code_01C495, #$0220, #$02E0, #$2040 ) ; {115670}
    COP [17] ( &code_01C41C ) ; {115681}

  loc_01C3E5:
    COP [80] ( #1D )      ; {115685}
    COP [82]              ; {115688}
    COP [1B] ( &code_01C3F0, #$0028 ) ; {115690}
}

code_01C3F0 {
    COP [87]              ; {115696}
    COP [80] ( #1D )      ; {115698}
    COP [82]              ; {115701}
    COP [1B] ( &code_01C3FD, #$003C ) ; {115703}
}

code_01C3FD {
    COP [A3]              ; {115709}
    COP [80] ( #1E )      ; {115711}
    COP [82]              ; {115714}
    COP [81] ( #1F, #04 ) ; {115716}
    COP [83]              ; {115720}
    COP [87]              ; {115722}
    COP [81] ( #1F, #04 ) ; {115724}
    COP [83]              ; {115728}
    COP [80] ( #20 )      ; {115730}
    COP [82]              ; {115733}
    COP [A6]              ; {115735}
    BRL loc_01C3E5        ; {115737}
}

code_01C41C {
    COP [01] ( &asciistring_01C421 ) ; {115740}
    RTL                   ; {115744}
}

asciistring_01C421 |[10]We tell the trees [N]what is taking place [N]and in turn they give [N]us seeds to eat- [FIN]So I guess you could [N]say we have sort of a [N]give+and+take [N]relationship- [JMP:&asciistring_01EC46]|

code_01C495 {
    COP [17] ( &code_01C4A1 ) ; {115861}
    COP [91]              ; {115865}
    COP [80] ( #23 )      ; {115867}
    COP [82]              ; {115870}
    RTL                   ; {115872}
}

code_01C4A1 {
    COP [01] ( &asciistring_01C4A6 ) ; {115873}
    RTL                   ; {115877}
}

asciistring_01C4A6 |[10][0A]The█birds█tell█me█many[N]stories-[FIN]I█am█thankful█for[N]them█because█I█can t[N]move█from█this█spot-[FIN]The█birds█tell█me█the[N]Lostside█Marsh█has[N]three█shrines-[FIN]One█is█called█Water,[FIN]another█is█Fire[FIN]and█the█third█is[N]Light-[JMP:&asciistring_01EC46]|

code_01C57B {
    COP [14] ( #$003C, &code_01C582 ) ; {116091}
    RTL                   ; {116097}
}

code_01C582 {
    COP [85] ( @chunk_000000.code_00299D ) ; {116098}
    COP [AC] ( @code_01C826, #$02B0, #$0200, #$2040 ) ; {116103}
    COP [17] ( &code_01C60A ) ; {116114}
    COP [15]              ; {116118}
    COP [91]              ; {116120}
    RTL                   ; {116122}
}

code_01C59B {
    COP [16]              ; {116123}
    COP [81] ( #11, #06 ) ; {116125}
    COP [83]              ; {116129}
    COP [9F] ( #$0008 )   ; {116131}
    COP [81] ( #0F, #04 ) ; {116135}
    COP [83]              ; {116139}
    COP [9F] ( #$FFF8 )   ; {116141}
    COP [80] ( #0E )      ; {116145}
    COP [82]              ; {116148}
    COP [17] ( &code_01C631 ) ; {116150}
    COP [15]              ; {116154}
    COP [91]              ; {116156}
    RTL                   ; {116158}
}

code_01C5BF {
    COP [16]              ; {116159}
    COP [17] ( &code_01C62C ) ; {116161}
    COP [81] ( #10, #07 ) ; {116165}
    COP [83]              ; {116169}
    COP [17] ( &code_01C639 ) ; {116171}
    COP [15]              ; {116175}
    COP [91]              ; {116177}
    RTL                   ; {116179}
}

code_01C5D4 {
    COP [17] ( #$0000 )   ; {116180}
    LDA #$2F80            ; {116184}
    TSB $0326             ; {116187}
    COP [1B] ( &code_01C5E4, #$003C ) ; {116190}
}

code_01C5E4 {
    COP [01] ( &asciistring_01C782 ) ; {116196}
    COP [80] ( #0C )      ; {116200}
    COP [82]              ; {116203}
    COP [1B] ( &code_01C5F3, #$001E ) ; {116205}
}

code_01C5F3 {
    COP [81] ( #24, #04 ) ; {116211}
    COP [83]              ; {116215}
    COP [01] ( &asciistring_01C7DF ) ; {116217}
    LDA #$2F80            ; {116221}
    TRB $0326             ; {116224}
    COP [17] ( &code_01C62C ) ; {116227}
    COP [91]              ; {116231}
    RTL                   ; {116233}
}

code_01C60A {
    COP [01] ( &asciistring_01C64D ) ; {116234}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_01C627 ) ; {116238}
    LDA $0003D0           ; {116245}
    BNE code_01C627       ; {116249}
    COP [01] ( &asciistring_01C661 ) ; {116251}
    COP [17] ( &code_01C62C ) ; {116255}
    COP [27] ( &code_01C59B ) ; {116259}
}

code_01C627 {
    COP [01] ( &asciistring_01C675 ) ; {116263}
    RTL                   ; {116267}
}

code_01C62C {
    COP [01] ( &asciistring_01C683 ) ; {116268}
    RTL                   ; {116272}
}

code_01C631 {
    COP [01] ( &asciistring_01C6B6 ) ; {116273}
    COP [27] ( &code_01C5BF ) ; {116277}
}

code_01C639 {
    COP [14] ( #$004A, &code_01C645 ) ; {116281}
    COP [01] ( &asciistring_01C738 ) ; {116287}
    BRA loc_01C649        ; {116291}
}

code_01C645 {
    COP [01] ( &asciistring_01C6F6 ) ; {116293}

  loc_01C649:
    COP [27] ( &code_01C5D4 ) ; {116297}
}

asciistring_01C64D |[10]Please, come [N]take a walk with me- [END]|

asciistring_01C661 |All right, let s go! [JMP:&asciistring_01EC46]|

asciistring_01C675 |Why not!? [N][JMP:&asciistring_01EC46]|

asciistring_01C683 |[10]I have as much fun [N]walking people as they[N]do walking me- [JMP:&asciistring_01EC46]|

asciistring_01C6B6 |[10]The island over there [N]is a graveyard- [N]My twin brother is the[N]island guard- [JMP:&asciistring_01EC46]|

asciistring_01C6F6 |[10]This is Green Theater-[N]A group called the [N]"Woodstin+Trioˮ is a [N]local favorite here- [JMP:&asciistring_01EC46]|

asciistring_01C738 |[10]This place used to be [N]the Green Theater- [FIN]A group called the [N]"Woodstin+Trioˮ used [N]to be a very popular [N]band- [JMP:&asciistring_01EC46]|

asciistring_01C782 |[10]Thank you for walking [N]with me- [N]Oh, one more thing--- [FIN]We animals communicate[N]not only with our [N]voices but also--- [JMP:&asciistring_01EC46]|

asciistring_01C7DF |[10]If I step like this [N]and wag my tail, it [N]means "thank youˮ- [FIN]Did you already know [N]that? [JMP:&asciistring_01EC46]|

code_01C826 {
    COP [17] ( &code_01C832 ) ; {116774}
    COP [91]              ; {116778}
    COP [80] ( #23 )      ; {116780}
    COP [82]              ; {116783}
    RTL                   ; {116785}
}

code_01C832 {
    COP [01] ( &asciistring_01C837 ) ; {116786}
    RTL                   ; {116790}
}

asciistring_01C837 |[10][0A]If█you█find█a[N]particular█mole,█you[N]will█be█able█to[N]see█in█the█dark-[FIN]Make█sure█you█talk█to[N]all█the█moles-[JMP:&asciistring_01EC46]|

code_01C8A4 {
    COP [14] ( #$0038, &code_01C8AB ) ; {116900}
    RTL                   ; {116906}
}

code_01C8AB {
    COP [85] ( @chunk_000000.code_00299D ) ; {116907}
    COP [AC] ( @code_01C8F5, #$02A0, #$0160, #$2040 ) ; {116912}
    COP [17] ( &code_01C8C9 ) ; {116923}
    COP [15]              ; {116927}
    COP [91]              ; {116929}
    COP [80] ( #18 )      ; {116931}
    COP [82]              ; {116934}
    RTL                   ; {116936}
}

code_01C8C9 {
    COP [01] ( &asciistring_01C8CE ) ; {116937}
    RTL                   ; {116941}
}

asciistring_01C8CE |[10]Talk with the stump- [N]Please listen [N]carefully- [JMP:&asciistring_01EC46]|

code_01C8F5 {
    COP [17] ( &code_01C901 ) ; {116981}
    COP [91]              ; {116985}
    COP [80] ( #23 )      ; {116987}
    COP [82]              ; {116990}
    RTL                   ; {116992}
}

code_01C901 {
    COP [01] ( &asciistring_01C906 ) ; {116993}
    RTL                   ; {116997}
}

asciistring_01C906 |[10][0A]This█is█GreenWood-[N]This█land█was[N]developed█by█a█dog[N]named█Turbo-[FIN]He█created█this█town[N]so█animals█could█come[N]here█and█feel█safe-[JMP:&asciistring_01EC46]|

code_01C98A {
    COP [14] ( #$0061, &code_01C991 ) ; {117130}
    RTL                   ; {117136}
}

code_01C991 {
    COP [30] ( #$0061, &code_01CA7E, #03 ) ; {117137}
    COP [07] ( #$9F02, &code_01C9C0 ) ; {117144}
    COP [85] ( @chunk_000000.code_00299D ) ; {117150}
    COP [85] ( @code_01CA63 ) ; {117155}
    COP [17] ( &code_01CA43 ) ; {117160}
    COP [15]              ; {117164}
    COP [91]              ; {117166}
    COP [07] ( #$0402, &code_01C9BF ) ; {117168}
    COP [17] ( &code_01CA5E ) ; {117174}
    COP [80] ( #1A )      ; {117178}
    COP [82]              ; {117181}
}

code_01C9BF {
    RTL                   ; {117183}
}

code_01C9C0 {
    LDA #$BFC0            ; {117184}
    TSB $0326             ; {117187}
    LDA $0016, X          ; {117190}
    ORA #$2000            ; {117193}
    STA $0016, X          ; {117196}
    COP [03] ( #65 )      ; {117199}
    COP [04]              ; {117202}
    COP [01] ( &asciistring_01CBA8 ) ; {117204}
    COP [03] ( #79 )      ; {117208}
    COP [04]              ; {117211}
    COP [A1] ( #$0010, #$FFF0 ) ; {117213}
    LDA $0016, X          ; {117219}
    AND #$DFFF            ; {117222}
    STA $0016, X          ; {117225}
    COP [81] ( #28, #08 ) ; {117228}
    COP [83]              ; {117232}
    COP [81] ( #27, #10 ) ; {117234}
    COP [83]              ; {117238}
    COP [03] ( #5B )      ; {117240}
    COP [04]              ; {117243}
    COP [01] ( &asciistring_01CC05 ) ; {117245}
    COP [03] ( #79 )      ; {117249}
    COP [04]              ; {117252}
    COP [81] ( #24, #04 ) ; {117254}
    COP [83]              ; {117258}
    COP [03] ( #29 )      ; {117260}
    COP [04]              ; {117263}
    COP [81] ( #27, #10 ) ; {117265}
    COP [83]              ; {117269}
    COP [81] ( #28, #08 ) ; {117271}
    COP [83]              ; {117275}
    LDA $0016, X          ; {117277}
    ORA #$2000            ; {117280}
    STA $0016, X          ; {117283}
    COP [03] ( #79 )      ; {117286}
    COP [04]              ; {117289}
    LDA #$0020            ; {117291}
    STA $03B4             ; {117294}
    COP [10] ( #$0101, #03, #$03B0, #$01D8 ) ; {117297}
    LDA #$BFC0            ; {117306}
    TRB $0326             ; {117309}
    COP [91]              ; {117312}
    RTL                   ; {117314}
}

code_01CA43 {
    COP [19] ( #1C, &code_01CA59 ) ; {117315}
    COP [01] ( &asciistring_01CAB9 ) ; {117320}
    COP [3C] ( #04 )      ; {117324}
    COP [10] ( #$0504, #03, #$0160, #$01C0 ) ; {117327}
    RTL                   ; {117336}
}

code_01CA59 {
    COP [01] ( &asciistring_01CAAF ) ; {117337}
    RTL                   ; {117341}
}

code_01CA5E {
    COP [01] ( &asciistring_01CADE ) ; {117342}
    RTL                   ; {117346}
}

code_01CA63 {
    COP [91]              ; {117347}
    COP [0D] ( #00, #12, #2C, &code_01CA6D ) ; {117349}
    RTL                   ; {117356}
}

code_01CA6D {
    COP [01] ( &asciistring_01CA85 ) ; {117357}
    COP [91]              ; {117361}
    COP [0D] ( #00, #12, #2C, &code_01CA7D ) ; {117363}
    BRL code_01CA63       ; {117370}
}

code_01CA7D {
    RTL                   ; {117373}
}

code_01CA7E {
    COP [01] ( &asciistring_01CB73 ) ; {117374}
    COP [86]              ; {117378}
    RTL                   ; {117380}
}

asciistring_01CA85 |[10]Here lies Turbo, [N]builder of GreenWood- [JMP:&asciistring_01EC46]|

asciistring_01CAAF |[10]Zzzzz [JMP:&asciistring_01EC46]|

asciistring_01CAB9 |[10][02:2] touched the [N]small bird with the [N]Dream Rod- [JMP:&asciistring_01EC46]|

asciistring_01CADE |[10]The rafts will only [N]carry the residents of[N]GreenWood- [FIN]Maybe if you bring [N]something that used to[N]belong to Turbo, they [N]might help you- [FIN]There are some leaves [N]from GreenWood buried [N]with Turbo- [JMP:&asciistring_01EC46]|

asciistring_01CB73 |[10][0E:3C]There is a bird [N]sleeping in front of [N]Turbo s grave stone- [JMP:&asciistring_01EC46]|

asciistring_01CBA8 |[10][0F]Turbo s grave is [N]standing alone- [N][0E:5A]When [02:2] closed [N]his eyes, he tried to [N]imagine Turbo- [0E:78][JMP:&asciistring_01EC46+M]|

asciistring_01CC05 |[10][0F]Like good sleep comes [N]after hard work, good [N]rest comes after an [N]honest life- [N][0E:5A]I will rest well with [N]Dr-Leo- [0E:78][JMP:&asciistring_01EC46+M]|

code_01CC61 {
    COP [14] ( #$004E, &code_01CC68 ) ; {117857}
    RTL                   ; {117863}
}

code_01CC68 {
    COP [85] ( @chunk_000000.code_00299D ) ; {117864}
    COP [17] ( &code_01CCA1 ) ; {117869}
    COP [A4]              ; {117873}
    COP [07] ( #$8305, &code_01CC81 ) ; {117875}
    COP [91]              ; {117881}
    COP [80] ( #21 )      ; {117883}
    COP [82]              ; {117886}
    RTL                   ; {117888}
}

code_01CC81 {
    COP [16]              ; {117889}
    COP [17] ( #$0000 )   ; {117891}

  code_01CC87:
    COP [03] ( #0A )      ; {117895}
    COP [80] ( #21 )      ; {117898}
    COP [82]              ; {117901}
    COP [0C] ( #00, #00, &code_01CC98 ) ; {117903}
    BRL code_01CC87       ; {117909}
}

code_01CC98 {
    COP [04]              ; {117912}
    COP [01] ( &asciistring_01CD20 ) ; {117914}
    BRL code_01CC87       ; {117918}
}

code_01CCA1 {
    COP [01] ( &asciistring_01CCC9 ) ; {117921}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_01CCC4 ) ; {117925}
    LDA $0003D0           ; {117932}
    BNE code_01CCC4       ; {117936}
    COP [01] ( &asciistring_01CCEE ) ; {117938}
    COP [09] ( #$8305 )   ; {117942}
    COP [16]              ; {117946}
    COP [17] ( #$0000 )   ; {117948}
    COP [27] ( &code_01CC87 ) ; {117952}
}

code_01CCC4 {
    COP [01] ( &asciistring_01CD16 ) ; {117956}
    RTL                   ; {117960}
}

asciistring_01CCC9 |[10]Who are you? [N]Are you trying to walk[N]over me!? [END]|

asciistring_01CCEE |You have some nerve! [N]Okay, but don t hurt [N]me- [JMP:&asciistring_01EC46]|

asciistring_01CD16 |You wimp! [JMP:&asciistring_01EC46]|

asciistring_01CD20 |[10]Hey, you re hurting [N]me! [JMP:&asciistring_01EC46]|

code_01CD3D {
    COP [14] ( #$005B, &code_01CD44 ) ; {118077}
    RTL                   ; {118083}
}

code_01CD44 {
    COP [85] ( @chunk_000000.code_00299D ) ; {118084}
    COP [A4]              ; {118089}
    COP [16]              ; {118091}
    COP [91]              ; {118093}
    COP [80] ( #21 )      ; {118095}
    COP [82]              ; {118098}
    RTL                   ; {118100}
}

code_01CD55 {
    COP [14] ( #$006F, &code_01CD5C ) ; {118101}
    RTL                   ; {118107}
}

code_01CD5C {
    COP [85] ( @chunk_000000.code_00299D ) ; {118108}
    COP [A4]              ; {118113}
    COP [16]              ; {118115}
    COP [91]              ; {118117}
    COP [80] ( #21 )      ; {118119}
    COP [82]              ; {118122}
    RTL                   ; {118124}
}

code_01CD6D {
    COP [14] ( #$003D, &code_01CD74 ) ; {118125}
    RTL                   ; {118131}
}

code_01CD74 {
    COP [85] ( @chunk_000000.code_00299D ) ; {118132}
    COP [17] ( &code_01CDE1 ) ; {118137}
    COP [15]              ; {118141}
    COP [91]              ; {118143}
    RTL                   ; {118145}
}

code_01CD82 {
    COP [17] ( &code_01CDE9 ) ; {118146}
    COP [16]              ; {118150}
    COP [80] ( #0F )      ; {118152}
    COP [82]              ; {118155}
    COP [9D] ( #0F )      ; {118157}
    COP [9E] ( &code_01CD94 ) ; {118160}
}

code_01CD94 {
    COP [87]              ; {118164}
    COP [81] ( #11, #08 ) ; {118166}
    COP [83]              ; {118170}
    COP [80] ( #0E )      ; {118172}
    COP [82]              ; {118175}
    COP [17] ( &code_01CDEE ) ; {118177}
    COP [15]              ; {118181}
    COP [91]              ; {118183}
    RTL                   ; {118185}
}

code_01CDAA {
    COP [16]              ; {118186}
    COP [17] ( &code_01CDF6 ) ; {118188}
    COP [81] ( #10, #06 ) ; {118192}
    COP [83]              ; {118196}
    COP [81] ( #11, #02 ) ; {118198}
    COP [83]              ; {118202}
    COP [80] ( #10 )      ; {118204}
    COP [82]              ; {118207}
    COP [80] ( #0D )      ; {118209}
    COP [82]              ; {118212}
    COP [17] ( &code_01CDFB ) ; {118214}
    COP [15]              ; {118218}
    COP [91]              ; {118220}
    COP [0D] ( #00, #1D, #09, &code_01CDD6 ) ; {118222}
    RTL                   ; {118229}
}

code_01CDD6 {
    COP [01] ( &asciistring_01CED5 ) ; {118230}
    COP [09] ( #$8001 )   ; {118234}
    COP [91]              ; {118238}
    RTL                   ; {118240}
}

code_01CDE1 {
    COP [01] ( &asciistring_01CE0B ) ; {118241}
    COP [27] ( &code_01CD82 ) ; {118245}
}

code_01CDE9 {
    COP [01] ( &asciistring_01CE0B ) ; {118249}
    RTL                   ; {118253}
}

code_01CDEE {
    COP [01] ( &asciistring_01CE48 ) ; {118254}
    COP [27] ( &code_01CDAA ) ; {118258}
}

code_01CDF6 {
    COP [01] ( &asciistring_01CEA7 ) ; {118262}
    RTL                   ; {118266}
}

code_01CDFB {
    COP [07] ( #$8001, &code_01CE06 ) ; {118267}
    COP [01] ( &asciistring_01CEAB ) ; {118273}
    RTL                   ; {118277}
}

code_01CE06 {
    COP [01] ( &asciistring_01CEE6 ) ; {118278}
    RTL                   ; {118282}
}

asciistring_01CE0B |[10]I can tell what [N]something is just by [N]it s smell- [FIN]Allright, let me start[N]doing my job- [JMP:&asciistring_01EC46]|

asciistring_01CE48 |[10]From >,[N][0E:3C]I smell fresh air- [FIN]From _, [0E:3C]I smell a [N]mole- [FIN]What is that smell!! [N][::]I smell something [N]strange coming from '-[JMP:&asciistring_01EC46]|

asciistring_01CEA7 |[10][JMP:&asciistring_01CE48+M]|

asciistring_01CEAB |[10]It s around here [N]somewhere- [N]I smell something [N]really strange! [JMP:&asciistring_01EC46]|

asciistring_01CED5 |[10]There is an outhouse- [JMP:&asciistring_01EC46]|

asciistring_01CEE6 |[10]Oh, this is our [N]bathroom- [FIN]Thank you for walking [N]with me- [N]I will tell you a [N]secret- [FIN]I can smell some armor[N]north of here- [JMP:&asciistring_01EC46]|

code_01CF41 {
    COP [14] ( #$0059, &code_01CF48 ) ; {118593}
    RTL                   ; {118599}
}

code_01CF48 {
    COP [85] ( @chunk_000000.code_00299D ) ; {118600}
    COP [17] ( &code_01CFB4 ) ; {118605}
    COP [15]              ; {118609}
    COP [91]              ; {118611}
    COP [14] ( #$0056, &code_01CF5C ) ; {118613}
    RTL                   ; {118619}
}

code_01CF5C {
    COP [17] ( &code_01CFA7 ) ; {118620}
    COP [91]              ; {118624}
    RTL                   ; {118626}
}

code_01CF63 {
    COP [16]              ; {118627}
    COP [17] ( &code_01CFAF ) ; {118629}

  code_01CF69:
    COP [9C] ( &code_01CF6F, &code_01CF8B ) ; {118633}
}

code_01CF6F {
    COP [9A] ( #$0010, &code_01CF79, &code_01CF8B, &code_01CF82 ) ; {118639}
}

code_01CF79 {
    COP [97]              ; {118649}
    COP [80] ( #05 )      ; {118651}
    COP [82]              ; {118654}
    BRA code_01CF69       ; {118656}
}

code_01CF82 {
    COP [96]              ; {118658}
    COP [80] ( #05 )      ; {118660}
    COP [82]              ; {118663}
    BRA code_01CF69       ; {118665}
}

code_01CF8B {
    COP [9B] ( #$0010, &code_01CF95, &code_01CFA3, &code_01CF9C ) ; {118667}
}

code_01CF95 {
    COP [80] ( #04 )      ; {118677}
    COP [82]              ; {118680}
    BRA code_01CF69       ; {118682}
}

code_01CF9C {
    COP [80] ( #03 )      ; {118684}
    COP [82]              ; {118687}
    BRA code_01CF69       ; {118689}
}

code_01CFA3 {
    COP [27] ( &code_01CF69 ) ; {118691}
}

code_01CFA7 {
    COP [01] ( &asciistring_01CFB9 ) ; {118695}
    COP [27] ( &code_01CF63 ) ; {118699}
}

code_01CFAF {
    COP [01] ( &asciistring_01CFE0 ) ; {118703}
    RTL                   ; {118707}
}

code_01CFB4 {
    COP [01] ( &asciistring_01D01B ) ; {118708}
    RTL                   ; {118712}
}

asciistring_01CFB9 |[10]I need to take [N]a walk and work some [N]of this food off- [JMP:&asciistring_01EC46]|

asciistring_01CFE0 |[10]"Why am I following [N]you?ˮ [N]Well it s purely [N]coincidence- [JMP:&asciistring_01EC46]|

asciistring_01D01B |[10]I m starving! This [N]place used to be a [N]restaurant- [JMP:&asciistring_01EC46]|

code_01D045 {
    COP [3B] ( #$005D, &code_01D05B ) ; {118853}
    COP [17] ( &chunk_018000.code_01B191 ) ; {118859}
    SEP #$20              ; {118863}
    LDA #$^chunk_000000.code_00305F ; {118865}
    PHA                   ; {118867}
    REP #$20              ; {118868}
    LDA #$&chunk_000000.code_00305F-1 ; {118870}
    PHA                   ; {118873}
    RTL                   ; {118874}
}

code_01D05B {
    COP [85] ( @chunk_000000.code_00299D ) ; {118875}
    COP [15]              ; {118880}
    COP [17] ( &code_01D0DE ) ; {118882}
    COP [91]              ; {118886}
    COP [14] ( #$004A, &code_01D06F ) ; {118888}
    RTL                   ; {118894}
}

code_01D06F {
    COP [14] ( #$003F, &code_01D076 ) ; {118895}
    RTL                   ; {118901}
}

code_01D076 {
    COP [17] ( &code_01D0E3 ) ; {118902}
    COP [05] ( #$0005 )   ; {118906}
    COP [09] ( #$0005 )   ; {118910}
    COP [16]              ; {118914}
    COP [81] ( #04, #02 ) ; {118916}
    COP [83]              ; {118920}
    COP [80] ( #00 )      ; {118922}
    COP [82]              ; {118925}
    COP [17] ( &code_01D0F0 ) ; {118927}
    COP [15]              ; {118931}
    RTL                   ; {118933}
}

code_01D096 {
    COP [16]              ; {118934}
    COP [17] ( #$0000 )   ; {118936}
    COP [81] ( #05, #03 ) ; {118940}
    COP [83]              ; {118944}
    COP [80] ( #03 )      ; {118946}
    COP [82]              ; {118949}
    COP [09] ( #$0006 )   ; {118951}
    COP [87]              ; {118955}
    COP [81] ( #05, #06 ) ; {118957}
    COP [83]              ; {118961}
    COP [80] ( #04 )      ; {118963}
    COP [82]              ; {118966}
    COP [87]              ; {118968}
    COP [81] ( #05, #03 ) ; {118970}
    COP [83]              ; {118974}
    COP [87]              ; {118976}
    COP [81] ( #05, #03 ) ; {118978}
    COP [83]              ; {118982}
    COP [80] ( #00 )      ; {118984}
    COP [82]              ; {118987}
    COP [15]              ; {118989}
    COP [17] ( &code_01D101 ) ; {118991}
    COP [05] ( #$0007 )   ; {118995}
    COP [17] ( &code_01D10E ) ; {118999}
    COP [91]              ; {119003}
    RTL                   ; {119005}
}

code_01D0DE {
    COP [01] ( &asciistring_01D134 ) ; {119006}
    RTL                   ; {119010}
}

code_01D0E3 {
    COP [01] ( &asciistring_01D174 ) ; {119011}
    COP [17] ( #$0000 )   ; {119015}
    COP [09] ( #$8003 )   ; {119019}
    RTL                   ; {119023}
}

code_01D0F0 {
    COP [01] ( &asciistring_01D1E5 ) ; {119024}
    COP [09] ( #$8006 )   ; {119028}
    COP [27] ( &code_01D096 ) ; {119032}
    COP [01] ( &asciistring_01D291 ) ; {119036}
    RTL                   ; {119040}
}

code_01D101 {
    COP [01] ( &asciistring_01D49D ) ; {119041}
    COP [09] ( #$8000 )   ; {119045}
    COP [09] ( #$8007 )   ; {119049}
    RTL                   ; {119053}
}

code_01D10E {
    COP [07] ( #$8006, &code_01D126 ) ; {119054}
    COP [09] ( #$8006 )   ; {119060}
    COP [01] ( &asciistring_01D291 ) ; {119064}
    BRK #$5E              ; {119068}
    COP [0A] ( #38 )      ; {119070}
    COP [17] ( &code_01D12F ) ; {119073}
    RTL                   ; {119077}
}

code_01D126 {
    COP [01] ( &asciistring_01D2D3 ) ; {119078}
    COP [17] ( &code_01D12F ) ; {119082}
    RTL                   ; {119086}
}

code_01D12F {
    COP [01] ( &asciistring_01D4D0 ) ; {119087}
    RTL                   ; {119091}
}

asciistring_01D134 |[10]I am Billy, leader of [N]the "Woodstin+Trioˮ, -[N]Our show is really [N]exciting! [JMP:&asciistring_01EC46]|

asciistring_01D174 |[10]The band is back [N]together, so let s [N]start the show! [FIN]Even though you are [N]our only audience we [N]will try our best- [FIN]Please watch the two [N]other guys- [JMP:&asciistring_01EC46]|

asciistring_01D1E5 |[10]How did you like it? [FIN]For our next number [N]you must try and guess[N]the real squirrel, me-[FIN]We will move around [N]and if you choose [N]correctly, you will [N]win a prize- [FIN]Please talk with whom [N]you think the real [N]squirrel is- [FIN]Here we go! [JMP:&asciistring_01EC46]|

asciistring_01D291 |[10]You re right!! [N]Okay, I will give you [N]a present- [FIN][02:2] received [N][03:24]the Medical Herb- [03:20][JMP:&asciistring_01EC46]|

asciistring_01D2D3 |[10]Too bad, but please [N]try again soon- [JMP:&asciistring_01EC46]|

code_01D2F3 {
    COP [3B] ( #$003F, &code_01D309 ) ; {119539}
    COP [17] ( &chunk_018000.code_01B191 ) ; {119545}
    SEP #$20              ; {119549}
    LDA #$^chunk_000000.code_00305F ; {119551}
    PHA                   ; {119553}
    REP #$20              ; {119554}
    LDA #$&chunk_000000.code_00305F-1 ; {119556}
    PHA                   ; {119559}
    RTL                   ; {119560}
}

code_01D309 {
    COP [85] ( @chunk_000000.code_00299D ) ; {119561}
    COP [17] ( &code_01D3E5 ) ; {119566}
    COP [15]              ; {119570}
    COP [91]              ; {119572}
    COP [14] ( #$005D, &code_01D31D ) ; {119574}
    RTL                   ; {119580}
}

code_01D31D {
    COP [14] ( #$004A, &code_01D324 ) ; {119581}
    RTL                   ; {119587}
}

code_01D324 {
    COP [17] ( &code_01D3EA ) ; {119588}
    COP [05] ( #$0004 )   ; {119592}
    COP [16]              ; {119596}
    COP [17] ( #$0000 )   ; {119598}
    COP [A1] ( #$0008, #$0008 ) ; {119602}
    COP [81] ( #0C, #03 ) ; {119608}
    COP [83]              ; {119612}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {119614}
    COP [87]              ; {119620}
    COP [81] ( #0E, #03 ) ; {119622}
    COP [83]              ; {119626}
    COP [87]              ; {119628}
    COP [A1] ( #$0008, #$0008 ) ; {119630}
    COP [81] ( #0D, #03 ) ; {119636}
    COP [83]              ; {119640}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {119642}
    COP [81] ( #0E, #03 ) ; {119648}
    COP [83]              ; {119652}
    COP [9F] ( #$0010 )   ; {119654}
    COP [85] ( @chunk_000000.code_00299D ) ; {119658}
    BRK #$4E              ; {119663}
    COP [80] ( #02 )      ; {119665}
    COP [82]              ; {119668}
    COP [1B] ( &code_01D37C, #$003C ) ; {119670}
}

code_01D37C {
    COP [09] ( #$8005 )   ; {119676}
    COP [80] ( #00 )      ; {119680}
    COP [82]              ; {119683}
    COP [15]              ; {119685}
    COP [17] ( &code_01D3EA ) ; {119687}
    COP [05] ( #$0006 )   ; {119691}
    COP [16]              ; {119695}
    COP [17] ( #$0000 )   ; {119697}
    COP [80] ( #03 )      ; {119701}
    COP [82]              ; {119704}
    COP [81] ( #05, #06 ) ; {119706}
    COP [83]              ; {119710}
    COP [80] ( #04 )      ; {119712}
    COP [82]              ; {119715}
    COP [87]              ; {119717}
    COP [81] ( #05, #03 ) ; {119719}
    COP [83]              ; {119723}
    COP [80] ( #03 )      ; {119725}
    COP [82]              ; {119728}
    COP [80] ( #05 )      ; {119730}
    COP [82]              ; {119733}
    COP [87]              ; {119735}
    COP [80] ( #05 )      ; {119737}
    COP [82]              ; {119740}
    COP [80] ( #04 )      ; {119742}
    COP [82]              ; {119745}
    COP [80] ( #00 )      ; {119747}
    COP [82]              ; {119750}
    COP [15]              ; {119752}
    COP [17] ( &code_01D3EF ) ; {119754}
    COP [05] ( #$0007 )   ; {119758}
    COP [85] ( @chunk_000000.code_00299D ) ; {119762}
    BRK #$4E              ; {119767}
    COP [80] ( #0C )      ; {119769}
    COP [82]              ; {119772}
    COP [17] ( &code_01D3FC ) ; {119774}
    COP [91]              ; {119778}
    RTL                   ; {119780}
}

code_01D3E5 {
    COP [01] ( &asciistring_01D410 ) ; {119781}
    RTL                   ; {119785}
}

code_01D3EA {
    COP [01] ( &asciistring_01D481 ) ; {119786}
    RTL                   ; {119790}
}

code_01D3EF {
    COP [01] ( &asciistring_01D49D ) ; {119791}
    COP [09] ( #$8006 )   ; {119795}
    COP [09] ( #$8007 )   ; {119799}
    RTL                   ; {119803}
}

code_01D3FC {
    COP [07] ( #$8000, &code_01D40B ) ; {119804}
    COP [01] ( &asciistring_01D4BB ) ; {119810}
    COP [17] ( &code_01D40B ) ; {119814}
    RTL                   ; {119818}
}

code_01D40B {
    COP [01] ( &asciistring_01D4D0 ) ; {119819}
    RTL                   ; {119823}
}

asciistring_01D410 |[10]I am a member of the [N]"Woodstin+Trio-ˮ [N]We put on a variety [N]show in this theater- [FIN]I need my other two [N]band members to start [N]the show- [JMP:&asciistring_01EC46]|

asciistring_01D481 |[10]Hey, don t walk around[N]here- [JMP:&asciistring_01EC46]|

asciistring_01D49D |[10]Okay, let s see if [N]I really am Billy- [JMP:&asciistring_01EC46]|

asciistring_01D4BB |[10]Too bad, almost- [JMP:&asciistring_01EC46]|

asciistring_01D4D0 |[10]I hope you liked [N]our show- [N]See you later- [JMP:&asciistring_01EC46]|

code_01D4F9 {
    COP [14] ( #$0050, &code_01D500 ) ; {120057}
    RTL                   ; {120063}
}

code_01D500 {
    COP [30] ( #$0050, &code_01D531, #03 ) ; {120064}
    COP [91]              ; {120071}
    COP [0D] ( #00, #17, #0D, &code_01D511 ) ; {120073}
    RTL                   ; {120080}
}

code_01D511 {
    COP [07] ( #$8507, &code_01D52E ) ; {120081}
    COP [1B] ( &code_01D51D, #$0002 ) ; {120087}
}

code_01D51D {
    COP [01] ( &asciistring_01D53A ) ; {120093}
    BRK #$5E              ; {120097}
    COP [0A] ( #3B )      ; {120099}
    COP [09] ( #$8507 )   ; {120102}
    COP [09] ( #$9B01 )   ; {120106}
}

code_01D52E {
    COP [91]              ; {120110}
    RTL                   ; {120112}
}

code_01D531 {
    COP [01] ( &asciistring_01D5CE ) ; {120113}
    COP [37]              ; {120117}
    COP [86]              ; {120119}
    RTL                   ; {120121}
}

asciistring_01D53A |[10]I am the [N]Guardian of the Woods-[FIN]I have been watching [N]the world for a long [N]time- [FIN][02:2], a dog named [N]Turbo has buried [N]something near my [N]roots- [FIN]You will need this [N]Green Stone someday, [N]so please take it- [FIN][02:2] received [N][03:24]the Green Stone- [03:20][JMP:&asciistring_01EC46]|

asciistring_01D5CE |[10][0E:3C]I am the Guardian of [N]the Woods- Thank you [N]for releasing me- [FIN]I will give you the [N]Green Stone upon your [N]return- [JMP:&asciistring_01EC46]|

code_01D614 {
    RTL                   ; {120340}
}

code_01D615 {
    COP [14] ( #$0064, &code_01D61C ) ; {120341}
    RTL                   ; {120347}
}

code_01D61C {
    COP [85] ( @chunk_000000.code_00299D ) ; {120348}
    COP [17] ( &code_01D635 ) ; {120353}

  loc_01D625:
    COP [80] ( #1D )      ; {120357}
    COP [82]              ; {120360}
    COP [1B] ( &code_01D630, #$0028 ) ; {120362}
}

code_01D630 {
    COP [87]              ; {120368}
    BRL loc_01D625        ; {120370}
}

code_01D635 {
    COP [01] ( &asciistring_01D63A ) ; {120373}
    RTL                   ; {120377}
}

asciistring_01D63A |[10]I heard of the [N]Phoenix s magic when I[N]visited the Soul of [N]the Mountain- [FIN]If you collect the [N]three symbols, you [N]should visit the [N]Mountain King- [JMP:&asciistring_01EC46]|

code_01D6AB {
    COP [14] ( #$0049, &code_01D6B2 ) ; {120491}
    RTL                   ; {120497}
}

code_01D6B2 {
    COP [85] ( @code_01D803 ) ; {120498}
    COP [17] ( &code_01D6D0 ) ; {120503}
    COP [15]              ; {120507}
    COP [91]              ; {120509}
    COP [07] ( #$8303, &code_01D6C6 ) ; {120511}
    RTL                   ; {120517}
}

code_01D6C6 {
    COP [16]              ; {120518}
    COP [85] ( @chunk_000000.code_00299D ) ; {120520}
    COP [86]              ; {120525}
    RTL                   ; {120527}
}

code_01D6D0 {
    COP [01] ( &asciistring_01D6F9 ) ; {120528}
    SEP #$20              ; {120532}
    LDA $1B82             ; {120534}
    ORA #$02              ; {120537}
    STA $1B82             ; {120539}
    REP #$20              ; {120542}
    COP [09] ( #$8303 )   ; {120544}
    BRK #$4E              ; {120548}
    COP [14] ( #$004F, &code_01D6EE ) ; {120550}
    BRA loc_01D6F4        ; {120556}
}

code_01D6EE {
    COP [14] ( #$0051, &code_01D6F8 ) ; {120558}

  loc_01D6F4:
    COP [01] ( &asciistring_01D7A2 ) ; {120564}
}

code_01D6F8 {
    RTL                   ; {120568}
}

asciistring_01D6F9 |[10]Even though I [N]don t look like it, [N]I am from the sky [N]just like you- [FIN]I light up the [N]darkness- [N]You cheer up everyone-[FIN]Let s work together to[N]revive the world- [FIN]The creature who [N]lights up darkness [N]joined [02:2]! [JMP:&asciistring_01EC46]|

asciistring_01D7A2 |[10][0E:3C]By the way why don t [N]we go to the second [N]basement of the Water [N]Shrine? [FIN]You will now be able [N]to see monsters which [N]you could not see [N]without me- [JMP:&asciistring_01EC46]|

code_01D803 {
    COP [07] ( #$0304, &code_01D80C ) ; {120835}
    COP [86]              ; {120841}
    RTL                   ; {120843}
}

code_01D80C {
    COP [91]              ; {120844}
    COP [0D] ( #00, #19, #19, &code_01D816 ) ; {120846}
    RTL                   ; {120853}
}

code_01D816 {
    COP [01] ( &asciistring_01D826 ) ; {120854}
    BRK #$5E              ; {120858}
    COP [0A] ( #1E )      ; {120860}
    COP [09] ( #$8304 )   ; {120863}
    COP [91]              ; {120867}
    RTL                   ; {120869}
}

asciistring_01D826 |[10][03:24]The leaves of [N]GreenWood [03:20]are found [N]under the dog bones! [JMP:&asciistring_01EC46]|

code_01D857 {
    COP [14] ( #$0049, &code_01D85E ) ; {120919}
    RTL                   ; {120925}
}

code_01D85E {
    COP [30] ( #$0049, &code_01D868, #03 ) ; {120926}
    COP [91]              ; {120933}
    RTL                   ; {120935}
}

code_01D868 {
    COP [01] ( &asciistring_01D86F ) ; {120936}
    COP [86]              ; {120940}
    RTL                   ; {120942}
}

asciistring_01D86F |[10][0E:3C]A voice is calling [N][02:2] from [N]the hole- [FIN]I am the creature who [N]brings light to [N]darkness- I will help [N]you upon your return- [JMP:&asciistring_01EC46]|

code_01D8C8 {
    COP [14] ( #$0051, &code_01D8CF ) ; {121032}
    RTL                   ; {121038}
}

code_01D8CF {
    COP [07] ( #$8403, &code_01D905 ) ; {121039}
    COP [15]              ; {121045}
    COP [17] ( &code_01D908 ) ; {121047}
    COP [91]              ; {121051}
    RTL                   ; {121053}
}

code_01D8DE {
    COP [17] ( #$0000 )   ; {121054}
    COP [03] ( #20 )      ; {121058}
    LDA $0016, X          ; {121061}
    AND #$DFFF            ; {121064}
    STA $0016, X          ; {121067}
    COP [80] ( #07 )      ; {121070}
    COP [82]              ; {121073}
    LDA $0016, X          ; {121075}
    ORA #$2000            ; {121078}
    STA $0016, X          ; {121081}
    COP [80] ( #07 )      ; {121084}
    COP [82]              ; {121087}
    COP [04]              ; {121089}
    COP [16]              ; {121091}
}

code_01D905 {
    COP [86]              ; {121093}
    RTL                   ; {121095}
}

code_01D908 {
    COP [19] ( #1F, &code_01D91C ) ; {121096}
    COP [01] ( &asciistring_01D94B ) ; {121101}
    COP [0B] ( #1F )      ; {121105}
    COP [09] ( #$8403 )   ; {121108}
    COP [27] ( &code_01D8DE ) ; {121112}
}

code_01D91C {
    COP [01] ( &asciistring_01D921 ) ; {121116}
    RTL                   ; {121120}
}

asciistring_01D921 |[10]You must bring [N]me something that once[N]belonged to Monmo- [JMP:&asciistring_01EC46]|

asciistring_01D94B |[10]Th-- that s Monmo s [N]ribbon! [FIN]Al-- allright, I will [N]move if you give that [N]to me- [JMP:&asciistring_01EC46]|

code_01D98E {
    COP [14] ( #$0062, &code_01D995 ) ; {121230}
    RTL                   ; {121236}
}

code_01D995 {
    COP [15]              ; {121237}
    COP [17] ( &code_01D9BB ) ; {121239}
    COP [07] ( #$0307, &code_01D9A5 ) ; {121243}
    COP [17] ( &code_01D9C0 ) ; {121249}
}

code_01D9A5 {
    COP [07] ( #$0400, &code_01D9AF ) ; {121253}
    COP [17] ( &code_01D9D9 ) ; {121259}
}

code_01D9AF {
    COP [91]              ; {121263}
    COP [18] ( #1F, &code_01D9BA ) ; {121265}
    COP [09] ( #$8907 )   ; {121270}
}

code_01D9BA {
    RTL                   ; {121274}
}

code_01D9BB {
    COP [01] ( &asciistring_01D9DE ) ; {121275}
    RTL                   ; {121279}
}

code_01D9C0 {
    COP [01] ( &asciistring_01DA4D ) ; {121280}
    COP [17] ( &code_01D9D4 ) ; {121284}
    COP [14] ( #$005C, &code_01D9CF ) ; {121288}
    RTL                   ; {121294}
}

code_01D9CF {
    COP [09] ( #$8400 )   ; {121295}
    RTL                   ; {121299}
}

code_01D9D4 {
    COP [01] ( &asciistring_01DB09 ) ; {121300}
    RTL                   ; {121304}
}

code_01D9D9 {
    COP [01] ( &asciistring_01DB0D ) ; {121305}
    RTL                   ; {121309}
}

asciistring_01D9DE |[10]I am always digging in[N]the ground, sometimes [N]I dig up strange [N]things- [FIN]I just dug up some dog[N]bones to #- [FIN]I got scared and re+ [N]buried them- [JMP:&asciistring_01EC46]|

asciistring_01DA4D |[10]What? Did a female [N]mole come by here? [FIN]No, I am living down [N]here alone- [FIN]Oh, I think I have [N]heard this story----- [FIN]There once was a cute [N]female mole living [N]around here- [FIN]But she was taken away[N]by evil creatures- [FIN][::]I am scared----- [JMP:&asciistring_01EC46]|

asciistring_01DB09 |[10][JMP:&asciistring_01DA4D+M]|

asciistring_01DB0D |[10]I became so scared I [N]dug a tunnel to the [N]house next door- [JMP:&asciistring_01EC46]|

code_01DB3F {
    COP [14] ( #$005C, &code_01DB46 ) ; {121663}
    RTL                   ; {121669}
}

code_01DB46 {
    COP [17] ( #$0000 )   ; {121670}
    COP [91]              ; {121674}
    COP [0D] ( #00, #05, #0B, &code_01DB69 ) ; {121676}
    COP [0D] ( #00, #05, #0F, &code_01DB69 ) ; {121683}
    COP [0D] ( #00, #0E, #0D, &code_01DBA5 ) ; {121690}
    COP [0D] ( #00, #0D, #12, &code_01DBA5 ) ; {121697}
    RTL                   ; {121704}
}

code_01DB69 {
    COP [2A] ( #$0010, #$0000 ) ; {121705}
    COP [9B] ( #$0000, &code_01DB79, &code_01DB79, &code_01DB87 ) ; {121711}
}

code_01DB79 {
    COP [80] ( #0B )      ; {121721}
    COP [82]              ; {121724}
    COP [81] ( #07, #10 ) ; {121726}
    COP [83]              ; {121730}
    BRL loc_01DB92        ; {121732}
}

code_01DB87 {
    COP [80] ( #0B )      ; {121735}
    COP [82]              ; {121738}
    COP [81] ( #06, #10 ) ; {121740}
    COP [83]              ; {121744}

  loc_01DB92:
    COP [01] ( &asciistring_01DBAD ) ; {121746}
    COP [16]              ; {121750}
    COP [87]              ; {121752}
    COP [80] ( #0B )      ; {121754}
    COP [82]              ; {121757}
    COP [15]              ; {121759}
    COP [17] ( &code_01DBA8 ) ; {121761}
}

code_01DBA5 {
    COP [91]              ; {121765}
    RTL                   ; {121767}
}

code_01DBA8 {
    COP [01] ( &asciistring_01DBDB ) ; {121768}
    RTL                   ; {121772}
}

asciistring_01DBAD |[10]BOO! [FIN]----------- [FIN]Come on! Aren t you [N]suprised? [JMP:&asciistring_01EC46]|

asciistring_01DBDB |[10]Phew! [JMP:&asciistring_01EC46]|

code_01DBE5 {
    COP [14] ( #$0040, &code_01DBEC ) ; {121829}
    RTL                   ; {121835}
}

code_01DBEC {
    COP [85] ( @chunk_000000.code_00299D ) ; {121836}
    COP [15]              ; {121841}
    COP [17] ( &code_01DBFA ) ; {121843}
    COP [91]              ; {121847}
    RTL                   ; {121849}
}

code_01DBFA {
    COP [14] ( #$0051, &code_01DC05 ) ; {121850}
    COP [01] ( &asciistring_01DD41 ) ; {121856}
    RTL                   ; {121860}
}

code_01DC05 {
    COP [18] ( #36, &code_01DC0F ) ; {121861}
    COP [01] ( &asciistring_01DD72 ) ; {121866}
    RTL                   ; {121870}
}

code_01DC0F {
    COP [01] ( &asciistring_01DC19 ) ; {121871}
    BRK #$5E              ; {121875}
    COP [0A] ( #36 )      ; {121877}
    RTL                   ; {121880}
}

asciistring_01DC19 |[10]I didn t know that he [N]was a ghost- [FIN]Both of us fell in [N]love with Monmo- [FIN]One day, Monmo was [N]captured by evil- He [N]tried to rescue her [N]but never came back- [FIN]Suddenly he appeared, [N]I had no idea what [N]happened to him- [FIN]Anyways, take this [N]bracelet and revive [N]GreenWood- [FIN]I know those two moles[N]would have liked to [N]live here in peace- [FIN][02:2] received [N][03:24]Shield Bracelet! [03:20][JMP:&asciistring_01EC46]|

asciistring_01DD41 |[10]My roommate has [N]disappeared- Will you [N]look for him? [JMP:&asciistring_01EC46]|

asciistring_01DD72 |[10]I am a bit jealous [N]that he won Monmo s [N]heart- [FIN]But I hope they are [N]happy now- [JMP:&asciistring_01EC46]|

code_01DDB7 {
    COP [14] ( #$0072, &code_01DDBE ) ; {122295}
    RTL                   ; {122301}
}

code_01DDBE {
    COP [07] ( #$8307, &code_01DE5D ) ; {122302}
    COP [85] ( @chunk_000000.code_00299D ) ; {122308}
    COP [17] ( &code_01DE60 ) ; {122313}
    COP [15]              ; {122317}
    COP [91]              ; {122319}
    RTL                   ; {122321}
}

code_01DDD2 {
    COP [17] ( &code_01DE68 ) ; {122322}
    COP [16]              ; {122326}

  code_01DDD8:
    COP [27] ( &code_01DDDC ) ; {122328}
}

code_01DDDC {
    COP [0D] ( #16, #0E, #1F, &code_01DE49 ) ; {122332}
    COP [9C] ( &code_01DDE9, &code_01DE1B ) ; {122339}
}

code_01DDE9 {
    COP [9A] ( #$0010, &code_01DDF3, &code_01DE1B, &code_01DE12 ) ; {122345}
}

code_01DDF3 {
    COP [14] ( #$0056, &code_01DE09 ) ; {122355}
    LDA $0000, X          ; {122361}
    CMP #$0120            ; {122364}
    BCS code_01DE09       ; {122367}
    LDA $0002, X          ; {122369}
    CMP #$0170            ; {122372}
    BCC code_01DDD8       ; {122375}
}

code_01DE09 {
    COP [97]              ; {122377}
    COP [80] ( #0B )      ; {122379}
    COP [82]              ; {122382}
    BRA code_01DDDC       ; {122384}
}

code_01DE12 {
    COP [96]              ; {122386}
    COP [80] ( #0B )      ; {122388}
    COP [82]              ; {122391}
    BRA code_01DDDC       ; {122393}
}

code_01DE1B {
    COP [9B] ( #$0010, &code_01DE25, &code_01DDD8, &code_01DE42 ) ; {122395}
}

code_01DE25 {
    COP [14] ( #$0056, &code_01DE3B ) ; {122405}
    LDA $0002, X          ; {122411}
    CMP #$0170            ; {122414}
    BCS code_01DE3B       ; {122417}
    LDA $0000, X          ; {122419}
    CMP #$0120            ; {122422}
    BCC code_01DDD8       ; {122425}
}

code_01DE3B {
    COP [80] ( #0A )      ; {122427}
    COP [82]              ; {122430}
    BRA code_01DDDC       ; {122432}
}

code_01DE42 {
    COP [80] ( #09 )      ; {122434}
    COP [82]              ; {122437}
    BRA code_01DDDC       ; {122439}
}

code_01DE49 {
    COP [17] ( &code_01DE6D ) ; {122441}
    COP [15]              ; {122445}
    COP [80] ( #06 )      ; {122447}
    COP [82]              ; {122450}
    COP [91]              ; {122452}
    RTL                   ; {122454}
}

code_01DE57 {
    COP [16]              ; {122455}
    COP [09] ( #$8307 )   ; {122457}
}

code_01DE5D {
    COP [86]              ; {122461}
    RTL                   ; {122463}
}

code_01DE60 {
    COP [01] ( &asciistring_01DE75 ) ; {122464}
    COP [27] ( &code_01DDD2 ) ; {122468}
}

code_01DE68 {
    COP [01] ( &asciistring_01DF22 ) ; {122472}
    RTL                   ; {122476}
}

code_01DE6D {
    COP [01] ( &asciistring_01DF4C ) ; {122477}
    COP [27] ( &code_01DE57 ) ; {122481}
}

asciistring_01DE75 |[10]My name is Monmo the [N]mole- [FIN]This place is so [N]bright I cannot see- [FIN]Would you please lead [N]me to my house? I will[N]follow you- [FIN]Please take to the [N]hole that leads to my [N]home- [FIN]Allright, talk to me [N]when I am standing in [N]the right place- [JMP:&asciistring_01EC46]|

asciistring_01DF22 |[10]Please don t walk so [N]fast, I can t keep up [N]with you- [JMP:&asciistring_01EC46]|

asciistring_01DF4C |[10]I ll give you [N]a present- [N]Could you wait here? [JMP:&asciistring_01EC46]|

code_01DF73 {
    COP [14] ( #$004F, &code_01DF7A ) ; {122739}
    RTL                   ; {122745}
}

code_01DF7A {
    COP [85] ( @chunk_000000.code_00299D ) ; {122746}
    COP [17] ( &code_01DF88 ) ; {122751}
    COP [15]              ; {122755}
    COP [91]              ; {122757}
    RTL                   ; {122759}
}

code_01DF88 {
    COP [01] ( &asciistring_01DF8D ) ; {122760}
    RTL                   ; {122764}
}

asciistring_01DF8D |[10]Turbo, the dog, [N]used to live with a [N]human named Dr-Leo- [FIN]Turbo learned a great [N]many things from him- [FIN]He used branches from [N]the trees to make a [N]tool called a raft- [JMP:&asciistring_01EC46]|

code_01E005 {
    COP [14] ( #$0043, &code_01E00C ) ; {122885}
    RTL                   ; {122891}
}

code_01E00C {
    COP [85] ( @chunk_000000.code_00299D ) ; {122892}
    COP [17] ( &code_01E01A ) ; {122897}
    COP [15]              ; {122901}
    COP [91]              ; {122903}
    RTL                   ; {122905}
}

code_01E01A {
    COP [18] ( #02, &code_01E024 ) ; {122906}
    COP [01] ( &asciistring_01E11B ) ; {122911}
    RTL                   ; {122915}
}

code_01E024 {
    COP [18] ( #25, &code_01E03B ) ; {122916}
    COP [19] ( #25, &code_01E040 ) ; {122921}
    COP [01] ( &asciistring_01E0DD ) ; {122926}
    COP [0B] ( #25 )      ; {122930}
    BRK #$5E              ; {122933}
    COP [0A] ( #02 )      ; {122935}
    RTL                   ; {122938}
}

code_01E03B {
    COP [01] ( &asciistring_01E045 ) ; {122939}
    RTL                   ; {122943}
}

code_01E040 {
    COP [01] ( &asciistring_01E0A5 ) ; {122944}
    RTL                   ; {122948}
}

asciistring_01E045 |[10]Welcome to the [N]squirrel s exchange [N]store- [FIN]I am hungry, if [N]you can bring me [N]something to eat, [FIN]I will trade you [N]something- [JMP:&asciistring_01EC46]|

asciistring_01E0A5 |[10]Ah, I smell some [N]delicious seeds- You [N]have some don t you? [JMP:&asciistring_01EC46]|

asciistring_01E0DD |[10]I will exchange this [N]sword with you for the[N]seeds- [FIN][02:2] received [N][03:24]the Psycho Sword- [03:20][JMP:&asciistring_01EC46]|

asciistring_01E11B |[10]Those seeds were very [N]good! [JMP:&asciistring_01EC46]|

code_01E134 {
    COP [14] ( #$0043, &code_01E13B ) ; {123188}
    RTL                   ; {123194}
}

code_01E13B {
    COP [30] ( #$0043, &code_01E145, #03 ) ; {123195}
    COP [91]              ; {123202}
    RTL                   ; {123204}
}

code_01E145 {
    COP [01] ( &asciistring_01E14C ) ; {123205}
    COP [86]              ; {123209}
    RTL                   ; {123211}
}

asciistring_01E14C |[10][0E:3C]A small voice is [N]coming from a hole- [FIN]Oh, I am starving----[FIN]If someone can bring [N]me something to eat [FIN]I will exchange this [N]powerful sword with [N]them----- [JMP:&asciistring_01EC46]|

code_01E1C0 {
    COP [14] ( #$0041, &code_01E1C7 ) ; {123328}
    RTL                   ; {123334}
}

code_01E1C7 {
    COP [85] ( @chunk_000000.code_00299D ) ; {123335}
    COP [17] ( &code_01E1D5 ) ; {123340}
    COP [15]              ; {123344}
    COP [91]              ; {123346}
    RTL                   ; {123348}
}

code_01E1D5 {
    COP [07] ( #$9A02, &code_01E1E9 ) ; {123349}
    COP [01] ( &asciistring_01E1EE ) ; {123355}
    BRK #$5E              ; {123359}
    COP [0A] ( #2C )      ; {123361}
    COP [09] ( #$9A02 )   ; {123364}
    RTL                   ; {123368}
}

code_01E1E9 {
    COP [01] ( &asciistring_01E22B ) ; {123369}
    RTL                   ; {123373}
}

asciistring_01E1EE |[10]Thank you for [N]releasing me- I will [N]give you this- [FIN][02:2] received [N][03:24]the Master s Emblem C-[03:20][JMP:&asciistring_01EC46]|

asciistring_01E22B |[10]Thank you for [N]releasing me- [JMP:&asciistring_01EC46]|

code_01E241 {
    COP [15]              ; {123457}
    COP [17] ( &code_01E24A ) ; {123459}
    COP [91]              ; {123463}
    RTL                   ; {123465}
}

code_01E24A {
    COP [07] ( #$8402, &code_01E255 ) ; {123466}
    COP [01] ( &asciistring_01E266 ) ; {123472}
    RTL                   ; {123476}
}

code_01E255 {
    COP [01] ( &asciistring_01E2EA ) ; {123477}
    COP [3C] ( #04 )      ; {123481}
    COP [10] ( #$0104, #02, #$0120, #$02D0 ) ; {123484}
    RTL                   ; {123493}
}

asciistring_01E266 |[10]Turbo refused to give [N]his life to the evil [N]one, Deathtoll- [FIN]He fought Deathtoll [N]trying to save [N]GreenWood and all [N]it s animals, [FIN]but he was defeated- [JMP:&asciistring_01EC46]|

asciistring_01E2EA |[10]Turbo, wait! [JMP:&asciistring_01EC46]|

code_01E2FB {
    COP [14] ( #$0074, &code_01E302 ) ; {123643}
    RTL                   ; {123649}
}

code_01E302 {
    COP [81] ( #27, #0F ) ; {123650}
    COP [83]              ; {123654}
    COP [81] ( #28, #08 ) ; {123656}
    COP [83]              ; {123660}
    COP [15]              ; {123662}
    COP [17] ( &code_01E337 ) ; {123664}
    COP [91]              ; {123668}
    RTL                   ; {123670}
}

code_01E317 {
    COP [17] ( #$0000 )   ; {123671}
    COP [1B] ( &code_01E321, #$003C ) ; {123675}
}

code_01E321 {
    COP [81] ( #28, #08 ) ; {123681}
    COP [83]              ; {123685}
    COP [81] ( #27, #0F ) ; {123687}
    COP [83]              ; {123691}
    COP [80] ( #23 )      ; {123693}
    COP [82]              ; {123696}
    COP [16]              ; {123698}
    COP [91]              ; {123700}
    RTL                   ; {123702}
}

code_01E337 {
    COP [01] ( &asciistring_01E343 ) ; {123703}
    COP [09] ( #$8402 )   ; {123707}
    COP [27] ( &code_01E317 ) ; {123711}
}

asciistring_01E343 |[10][02:2], go to [N]the Light Shrine and [N]release the Guardian [N]of the Woods- [FIN]You will find what you[N]are looking for- [FIN]There is a bird, Tiki,[N]that may tell you how [N]to use the raft- [FIN]You must protect [N]GreenWood now that [N]I am gone- [JMP:&asciistring_01EC46]|

code_01E3E2 {
    COP [A1] ( #$007C, #$FFFA ) ; {123874}
    COP [80] ( #1F )      ; {123880}
    COP [82]              ; {123883}
    COP [80] ( #20 )      ; {123885}
    COP [82]              ; {123888}
    COP [80] ( #1D )      ; {123890}
    COP [82]              ; {123893}
    COP [1B] ( &code_01E3FD, #$0028 ) ; {123895}
}

code_01E3FD {
    COP [87]              ; {123901}
    COP [80] ( #1D )      ; {123903}
    COP [82]              ; {123906}
    COP [15]              ; {123908}
    COP [17] ( &code_01E412 ) ; {123910}
    COP [91]              ; {123914}
    COP [80] ( #1A )      ; {123916}
    COP [82]              ; {123919}
    RTL                   ; {123921}
}

code_01E412 {
    COP [01] ( &asciistring_01E426 ) ; {123922}
    STZ $0419             ; {123926}
    COP [3C] ( #04 )      ; {123929}
    COP [10] ( #$0104, #00, #$0070, #$02A0 ) ; {123932}
    RTL                   ; {123941}
}

asciistring_01E426 |[10]Even though I am only [N]a stump in real life, [N]I often dream [FIN]that I am a bird and [N]can fly wherever I [N]wish- [JMP:&asciistring_01EC46]|

code_01E47B {
    COP [91]              ; {124027}
    COP [0D] ( #00, #0F, #15, &code_01E485 ) ; {124029}
    RTL                   ; {124036}
}

code_01E485 {
    COP [07] ( #$0906, &code_01E48E ) ; {124037}
    COP [86]              ; {124043}
    RTL                   ; {124045}
}

code_01E48E {
    COP [01] ( &asciistring_01E49E ) ; {124046}
    BRK #$5E              ; {124050}
    COP [0A] ( #39 )      ; {124052}
    COP [09] ( #$8906 )   ; {124055}
    COP [86]              ; {124059}
    RTL                   ; {124061}
}

asciistring_01E49E |[10][02:2] found [N][03:24]a Strange Bottle[03:20]-[JMP:&asciistring_01EC46]|

code_01E4BB {
    COP [85] ( @chunk_000000.code_002EC0 ) ; {124091}
    COP [86]              ; {124096}
    RTL                   ; {124098}
}

code_01E4C3 {
    JSL $@chunk_018000.code_01B161 ; {124099}
    COP [17] ( &code_01E4D7 ) ; {124103}
    SEP #$20              ; {124107}
    LDA #$^chunk_018000.code_01B17C ; {124109}
    PHA                   ; {124111}
    REP #$20              ; {124112}
    LDA #$&chunk_018000.code_01B17C-1 ; {124114}
    PHA                   ; {124117}
    RTL                   ; {124118}
}

code_01E4D7 {
    COP [07] ( #$9C05, &code_01E4E9 ) ; {124119}
    COP [01] ( &asciistring_01EBC2 ) ; {124125}
    COP [38] ( #$0150 )   ; {124129}
    COP [09] ( #$9C05 )   ; {124133}
}

code_01E4E9 {
    COP [01] ( &asciistring_01EBEA ) ; {124137}
    COP [1A] ( &chunk_010000.asciistring_014F5B, #02, &code_01E50B ) ; {124141}
    LDA $0003D0           ; {124148}
    BEQ code_01E50B       ; {124152}
    COP [01] ( &asciistring_01EC09 ) ; {124154}
    INC $042D             ; {124158}
    COP [10] ( #$0104, #02, #$02E0, #$01A0 ) ; {124161}
    RTL                   ; {124170}
}

code_01E50B {
    COP [01] ( &asciistring_01EC1B ) ; {124171}
    RTL                   ; {124175}
}

code_01E510 {
    COP [14] ( #$0048, &code_01E517 ) ; {124176}
    RTL                   ; {124182}
}

code_01E517 {
    JSL $@chunk_018000.code_01B161 ; {124183}
    COP [17] ( &code_01E52B ) ; {124187}
    SEP #$20              ; {124191}
    LDA #$^chunk_018000.code_01B17C ; {124193}
    PHA                   ; {124195}
    REP #$20              ; {124196}
    LDA #$&chunk_018000.code_01B17C-1 ; {124198}
    PHA                   ; {124201}
    RTL                   ; {124202}
}

code_01E52B {
    COP [07] ( #$9C06, &code_01E4E9 ) ; {124203}
    COP [01] ( &asciistring_01EBC2 ) ; {124209}
    COP [38] ( #$0180 )   ; {124213}
    COP [09] ( #$9C06 )   ; {124217}
    BRL code_01E4E9       ; {124221}
}

code_01E540 {
    COP [14] ( #$005E, &code_01E547 ) ; {124224}
    RTL                   ; {124230}
}

code_01E547 {
    JSL $@chunk_018000.code_01B161 ; {124231}
    COP [17] ( &code_01E55B ) ; {124235}
    SEP #$20              ; {124239}
    LDA #$^chunk_018000.code_01B17C ; {124241}
    PHA                   ; {124243}
    REP #$20              ; {124244}
    LDA #$&chunk_018000.code_01B17C-1 ; {124246}
    PHA                   ; {124249}
    RTL                   ; {124250}
}

code_01E55B {
    COP [07] ( #$9C07, &code_01E4E9 ) ; {124251}
    COP [01] ( &asciistring_01E571 ) ; {124257}
    BRK #$5E              ; {124261}
    COP [0A] ( #12 )      ; {124263}
    COP [09] ( #$9C07 )   ; {124266}
    BRL code_01E4E9       ; {124270}
}

asciistring_01E571 |[10]Here, take this [N][03:24]Light Arrow Magic- [03:20][FIN][END]|

code_01E594 {
    COP [14] ( #$0053, &code_01E59B ) ; {124308}
    RTL                   ; {124314}
}

code_01E59B {
    JSL $@chunk_018000.code_01B161 ; {124315}
    COP [17] ( &code_01E5AF ) ; {124319}
    SEP #$20              ; {124323}
    LDA #$^chunk_018000.code_01B17C ; {124325}
    PHA                   ; {124327}
    REP #$20              ; {124328}
    LDA #$&chunk_018000.code_01B17C-1 ; {124330}
    PHA                   ; {124333}
    RTL                   ; {124334}
}

code_01E5AF {
    COP [01] ( &asciistring_01EBC2 ) ; {124335}
    COP [38] ( #$0001 )   ; {124339}
    BRL code_01E4E9       ; {124343}
}

code_01E5BA {
    LDY $039C             ; {124346}
    LDA $0002, Y          ; {124349}
    CMP #$0060            ; {124352}
    BCC loc_01E5F5        ; {124355}
    COP [0D] ( #00, #1C, #20, &code_01E5D5 ) ; {124357}
    COP [0D] ( #00, #03, #19, &code_01E5DF ) ; {124364}
    BRA loc_01E627        ; {124371}
}

code_01E5D5 {
    COP [11] ( #16, #17, #19 ) ; {124373}
    COP [12] ( #16, &code_01E854 ) ; {124378}
}

code_01E5DF {
    COP [11] ( #14, #0F, #14 ) ; {124383}
    COP [12] ( #14, &code_01E7D8 ) ; {124388}
    COP [11] ( #15, #06, #10 ) ; {124393}
    COP [12] ( #15, &code_01E8F0 ) ; {124398}
    BRA loc_01E627        ; {124403}

  loc_01E5F5:
    COP [11] ( #14, #0F, #08 ) ; {124405}
    COP [12] ( #14, &code_01E8F0 ) ; {124410}
    COP [11] ( #15, #1C, #0D ) ; {124415}
    COP [12] ( #15, &code_01E7D8 ) ; {124420}
    COP [11] ( #16, #17, #19 ) ; {124425}
    COP [12] ( #16, &code_01E854 ) ; {124430}
    COP [11] ( #17, #06, #10 ) ; {124435}
    COP [12] ( #17, &code_01E8F0 ) ; {124440}
    COP [11] ( #18, #0F, #14 ) ; {124445}
    COP [12] ( #18, &code_01E7D8 ) ; {124450}

  loc_01E627:
    COP [86]              ; {124455}
    RTL                   ; {124457}
}

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
    TSB $0326             ; {124488}
    COP [81] ( #1A, #02 ) ; {124491}
    COP [83]              ; {124495}
    COP [1B] ( &code_01E657, #$001E ) ; {124497}
}

code_01E657 {
    COP [81] ( #30, #02 ) ; {124503}
    COP [83]              ; {124507}
    LDA #$2F80            ; {124509}
    TRB $0326             ; {124512}
    COP [18] ( #1E, &code_01E686 ) ; {124515}
    COP [01] ( &asciistring_01E712 ) ; {124520}
    COP [81] ( #19, #02 ) ; {124524}
    COP [83]              ; {124528}
    COP [2B] ( #$0000, #$0000 ) ; {124530}
    COP [2B] ( #$0010, #$0000 ) ; {124536}
    COP [09] ( #$8401 )   ; {124542}
}

code_01E682 {
    COP [27] ( &code_01E75C ) ; {124546}
}

code_01E686 {
    COP [01] ( &asciistring_01E68D ) ; {124550}
    COP [91]              ; {124554}
    RTL                   ; {124556}
}

asciistring_01E68D |[10][02:2] began to [N]hear a small voice- [FIN]We are rafts made from[N]the branches of trees [N]in GreenWood- [FIN]If you cannot prove [N]that you are from [N]GreenWood, we will not[N]let you ride- [JMP:&asciistring_01EC46]|

asciistring_01E712 |[10]Those are leaves from [N]GreenWood! [N]Turbo s symbol! [FIN]We will take you to [N]the Light Shrine- [JMP:&asciistring_01EC46]|

code_01E759 {
    COP [AD] ( #08 )      ; {124761}
}

code_01E75C {
    COP [A4]              ; {124764}
    COP [2A] ( #$FFF0, #$0000 ) ; {124766}
    COP [2B] ( #$0000, #$0000 ) ; {124772}
    COP [2B] ( #$0010, #$0000 ) ; {124778}
    COP [91]              ; {124784}
    COP [0C] ( #00, #00, &code_01E77B ) ; {124786}
    BRL loc_01E77C        ; {124792}
}

code_01E77B {
    RTL                   ; {124795}

  loc_01E77C:
    COP [91]              ; {124796}
    COP [0C] ( #00, #00, &code_01E785 ) ; {124798}
    RTL                   ; {124804}
}

code_01E785 {
    COP [85] ( @code_01E7AD ) ; {124805}
    COP [2B] ( #$FFF0, #$0000 ) ; {124810}
    COP [2A] ( #$0000, #$0000 ) ; {124816}
    COP [2A] ( #$0010, #$0000 ) ; {124822}

  code_01E79C:
    COP [80] ( #1A )      ; {124828}
    COP [82]              ; {124831}
    COP [23] ( &code_01E79C ) ; {124833}
    COP [09] ( #$8000 )   ; {124837}
    COP [27] ( &code_01E7D5 ) ; {124841}
}

code_01E7AD {
    LDA #$2F80            ; {124845}
    TSB $0326             ; {124848}
    COP [91]              ; {124851}
    COP [2F] ( #$0000, #$FFFE ) ; {124853}
    COP [07] ( #$8000, &code_01E7C2 ) ; {124859}
    RTL                   ; {124865}
}

code_01E7C2 {
    COP [2F] ( #$0000, #$FFFE ) ; {124866}
    COP [09] ( #$0000 )   ; {124872}
    LDA #$2F80            ; {124876}
    TRB $0326             ; {124879}
    COP [86]              ; {124882}
    RTL                   ; {124884}
}

code_01E7D5 {
    COP [AD] ( #08 )      ; {124885}
}

code_01E7D8 {
    COP [A4]              ; {124888}
    COP [2A] ( #$FFF0, #$0000 ) ; {124890}
    COP [2B] ( #$0000, #$FFF0 ) ; {124896}
    COP [2B] ( #$0010, #$FFF0 ) ; {124902}
    COP [91]              ; {124908}
    COP [0C] ( #00, #00, &code_01E7F7 ) ; {124910}
    BRL loc_01E7F8        ; {124916}
}

code_01E7F7 {
    RTL                   ; {124919}

  loc_01E7F8:
    COP [91]              ; {124920}
    COP [0C] ( #00, #00, &code_01E801 ) ; {124922}
    RTL                   ; {124928}
}

code_01E801 {
    COP [85] ( @code_01E829 ) ; {124929}
    COP [2B] ( #$FFF0, #$0000 ) ; {124934}
    COP [2A] ( #$0000, #$FFF0 ) ; {124940}
    COP [2A] ( #$0010, #$FFF0 ) ; {124946}

  code_01E818:
    COP [80] ( #19 )      ; {124952}
    COP [82]              ; {124955}
    COP [23] ( &code_01E818 ) ; {124957}
    COP [09] ( #$8000 )   ; {124961}
    COP [27] ( &code_01E759 ) ; {124965}
}

code_01E829 {
    LDA #$2F80            ; {124969}
    TSB $0326             ; {124972}
    COP [91]              ; {124975}
    COP [2F] ( #$0000, #$0002 ) ; {124977}
    COP [07] ( #$8000, &code_01E83E ) ; {124983}
    RTL                   ; {124989}
}

code_01E83E {
    COP [2F] ( #$0000, #$0002 ) ; {124990}
    COP [09] ( #$0000 )   ; {124996}
    LDA #$2F80            ; {125000}
    TRB $0326             ; {125003}
    COP [86]              ; {125006}
    RTL                   ; {125008}
}

code_01E851 {
    COP [AD] ( #08 )      ; {125009}
}

code_01E854 {
    COP [A4]              ; {125012}
    COP [2A] ( #$0000, #$0010 ) ; {125014}
    COP [2B] ( #$0010, #$0000 ) ; {125020}
    COP [2B] ( #$0010, #$FFF0 ) ; {125026}
    COP [2B] ( #$0000, #$0000 ) ; {125032}
    COP [2B] ( #$0000, #$FFF0 ) ; {125038}
    COP [91]              ; {125044}
    COP [0C] ( #00, #00, &code_01E87F ) ; {125046}
    BRL loc_01E880        ; {125052}
}

code_01E87F {
    RTL                   ; {125055}

  loc_01E880:
    COP [91]              ; {125056}
    COP [0C] ( #00, #00, &code_01E889 ) ; {125058}
    RTL                   ; {125064}
}

code_01E889 {
    COP [85] ( @code_01E8C5 ) ; {125065}
    COP [2B] ( #$0000, #$0010 ) ; {125070}
    COP [2A] ( #$0010, #$0000 ) ; {125076}
    COP [2A] ( #$0010, #$FFF0 ) ; {125082}
    COP [2A] ( #$0000, #$0000 ) ; {125088}
    COP [2A] ( #$0000, #$FFF0 ) ; {125094}

  code_01E8AC:
    COP [80] ( #1B )      ; {125100}
    COP [82]              ; {125103}
    COP [22] ( &code_01E8AC ) ; {125105}
    COP [09] ( #$8000 )   ; {125109}
    COP [23] ( &code_01E8C1 ) ; {125113}
    COP [27] ( &code_01E8ED ) ; {125117}
}

code_01E8C1 {
    COP [27] ( &code_01E851 ) ; {125121}
}

code_01E8C5 {
    LDA #$2F80            ; {125125}
    TSB $0326             ; {125128}
    COP [91]              ; {125131}
    COP [2F] ( #$FFFE, #$0000 ) ; {125133}
    COP [07] ( #$8000, &code_01E8DA ) ; {125139}
    RTL                   ; {125145}
}

code_01E8DA {
    COP [2F] ( #$FFFE, #$0000 ) ; {125146}
    COP [09] ( #$0000 )   ; {125152}
    LDA #$2F80            ; {125156}
    TRB $0326             ; {125159}
    COP [86]              ; {125162}
    RTL                   ; {125164}
}

code_01E8ED {
    COP [AD] ( #08 )      ; {125165}
}

code_01E8F0 {
    COP [A4]              ; {125168}
    COP [87]              ; {125170}
    COP [2A] ( #$0000, #$0010 ) ; {125172}
    COP [2B] ( #$0000, #$0000 ) ; {125178}
    COP [2B] ( #$0000, #$FFF0 ) ; {125184}
    COP [2B] ( #$0010, #$0000 ) ; {125190}
    COP [2B] ( #$0010, #$FFF0 ) ; {125196}
    COP [91]              ; {125202}
    COP [0C] ( #00, #00, &code_01E91D ) ; {125204}
    BRL loc_01E91E        ; {125210}
}

code_01E91D {
    RTL                   ; {125213}

  loc_01E91E:
    COP [91]              ; {125214}
    COP [0C] ( #00, #00, &code_01E927 ) ; {125216}
    RTL                   ; {125222}
}

code_01E927 {
    COP [85] ( @code_01E965 ) ; {125223}
    COP [2B] ( #$0000, #$0010 ) ; {125228}
    COP [2A] ( #$0000, #$0000 ) ; {125234}
    COP [2A] ( #$0000, #$FFF0 ) ; {125240}
    COP [2A] ( #$0010, #$0000 ) ; {125246}
    COP [2A] ( #$0010, #$FFF0 ) ; {125252}

  code_01E94A:
    COP [80] ( #1B )      ; {125258}
    COP [82]              ; {125261}
    COP [22] ( &code_01E94A ) ; {125263}
    COP [09] ( #$8000 )   ; {125267}
    COP [87]              ; {125271}
    COP [24] ( &code_01E961 ) ; {125273}
    COP [27] ( &code_01E851 ) ; {125277}
}

code_01E961 {
    COP [27] ( &code_01E8ED ) ; {125281}
}

code_01E965 {
    LDA #$2F80            ; {125285}
    TSB $0326             ; {125288}
    COP [91]              ; {125291}
    COP [2F] ( #$0002, #$0000 ) ; {125293}
    COP [07] ( #$8000, &code_01E97A ) ; {125299}
    RTL                   ; {125305}
}

code_01E97A {
    COP [2F] ( #$0002, #$0000 ) ; {125306}
    COP [09] ( #$0000 )   ; {125312}
    LDA #$2F80            ; {125316}
    TRB $0326             ; {125319}
    COP [86]              ; {125322}
    RTL                   ; {125324}
}

code_01E98D {
    COP [92] ( #3B )      ; {125325}
    COP [94]              ; {125328}
    COP [B0] ( @code_01E9A6, #$2040 ) ; {125330}
    COP [1B] ( &code_01E99F, #$00F0 ) ; {125337}
}

code_01E99F {
    COP [92] ( #3D )      ; {125343}
    COP [94]              ; {125346}
    BRA code_01E98D       ; {125348}
}

code_01E9A6 {
    COP [03] ( #F0 )      ; {125350}
    COP [19] ( #0A, &code_01E9B0 ) ; {125353}
    BRA loc_01E9BC        ; {125358}
}

code_01E9B0 {
    LDA #$0080            ; {125360}
    JSL $@chunk_0270E4.code_027462 ; {125363}
    BCC loc_01E9BC        ; {125367}
    COP [39] ( #01 )      ; {125369}

  loc_01E9BC:
    COP [04]              ; {125372}
    COP [86]              ; {125374}
    RTL                   ; {125376}
}

code_01E9C1 {
    LDA $0002, X          ; {125377}
    SEC                   ; {125380}
    SBC #$0001            ; {125381}
    CLC                   ; {125384}
    ADC $0384             ; {125385}
    STA $0002, X          ; {125388}
    STA $0340             ; {125391}
    RTL                   ; {125394}
}

code_01E9D3 {
    PHX                   ; {125395}
    LDX #$0000            ; {125396}

  loc_01E9D7:
    LDA #$00A0            ; {125399}
    STA $7E7000, X        ; {125402}
    STA $7E7800, X        ; {125406}
    LDA #$7100            ; {125410}
    STA $7E7001, X        ; {125413}
    LDA #$7900            ; {125417}
    STA $7E7801, X        ; {125420}
    INX                   ; {125424}
    INX                   ; {125425}
    INX                   ; {125426}
    CPX #$0015            ; {125427}
    BNE loc_01E9D7        ; {125430}
    LDA #$0000            ; {125432}
    STA $7E7000, X        ; {125435}
    STA $7E7800, X        ; {125439}
    PLX                   ; {125443}
    COP [91]              ; {125444}
    LDA $0000, X          ; {125446}
    INC                   ; {125449}
    CLC                   ; {125450}
    ADC $0382             ; {125451}
    STA $0000, X          ; {125454}
    STA $033E             ; {125457}
    LDA $0002, X          ; {125460}
    INC                   ; {125463}
    CLC                   ; {125464}
    ADC $0384             ; {125465}
    STA $0002, X          ; {125468}
    STA $0340             ; {125471}
    PHX                   ; {125474}
    LDA $0312             ; {125475}
    LSR                   ; {125478}
    LSR                   ; {125479}
    CLC                   ; {125480}
    ADC $0340             ; {125481}
    AND #$001F            ; {125484}
    ASL                   ; {125487}
    TAX                   ; {125488}
    LDY #$0000            ; {125489}
    PHB                   ; {125492}
    SEP #$20              ; {125493}
    LDA #$7E              ; {125495}
    PHA                   ; {125497}
    PLB                   ; {125498}
    REP #$20              ; {125499}

  loc_01EA3D:
    LDA $@word_01EA7B, X  ; {125501}
    CLC                   ; {125505}
    ADC $033E             ; {125506}
    STA $7100, Y          ; {125509}
    LDA $@word_01EA7B, X  ; {125512}
    CLC                   ; {125516}
    ADC $0340             ; {125517}
    STA $7900, Y          ; {125520}
    INX                   ; {125523}
    INX                   ; {125524}
    INY                   ; {125525}
    INY                   ; {125526}
    CPY #$0040            ; {125527}
    BNE loc_01EA3D        ; {125530}
    PLB                   ; {125532}
    SEP #$20              ; {125533}
    LDA #$0D              ; {125535}
    XBA                   ; {125537}
    LDA #$7E              ; {125538}
    LDY #$7000            ; {125540}
    JSL $@chunk_010000.code_01186E ; {125543}
    LDA #$0E              ; {125547}
    XBA                   ; {125549}
    LDA #$7E              ; {125550}
    LDY #$7800            ; {125552}
    JSL $@chunk_010000.code_01186E ; {125555}
    REP #$20              ; {125559}
    PLX                   ; {125561}
    RTL                   ; {125562}
}
---------------------------------------------

word_01EA7B [
  #$0000   ;00
  #$0001   ;01
  #$0002   ;02
  #$0002   ;03
  #$0003   ;04
  #$0003   ;05
  #$0004   ;06
  #$0004   ;07
  #$0004   ;08
  #$0004   ;09
  #$0004   ;0A
  #$0003   ;0B
  #$0003   ;0C
  #$0002   ;0D
  #$0002   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFE   ;12
  #$FFFE   ;13
  #$FFFD   ;14
  #$FFFD   ;15
  #$FFFC   ;16
  #$FFFC   ;17
  #$FFFC   ;18
  #$FFFC   ;19
  #$FFFC   ;1A
  #$FFFD   ;1B
  #$FFFD   ;1C
  #$FFFE   ;1D
  #$FFFE   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0002   ;22
  #$0002   ;23
  #$0003   ;24
  #$0003   ;25
  #$0004   ;26
  #$0004   ;27
  #$0004   ;28
  #$0004   ;29
  #$0004   ;2A
  #$0003   ;2B
  #$0003   ;2C
  #$0002   ;2D
  #$0002   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFE   ;32
  #$FFFE   ;33
  #$FFFD   ;34
  #$FFFD   ;35
  #$FFFC   ;36
  #$FFFC   ;37
  #$FFFC   ;38
  #$FFFC   ;39
  #$FFFC   ;3A
  #$FFFD   ;3B
  #$FFFD   ;3C
  #$FFFE   ;3D
  #$FFFE   ;3E
  #$FFFF   ;3F
]
---------------------------------------------

code_01EAFB {
    PHX                   ; {125691}
    LDX #$0000            ; {125692}

  loc_01EAFF:
    LDA #$0090            ; {125695}
    STA $7E7000, X        ; {125698}
    STA $7E7800, X        ; {125702}
    LDA #$7100            ; {125706}
    STA $7E7001, X        ; {125709}
    LDA #$7900            ; {125713}
    STA $7E7801, X        ; {125716}
    INX                   ; {125720}
    INX                   ; {125721}
    INX                   ; {125722}
    CPX #$002A            ; {125723}
    BNE loc_01EAFF        ; {125726}
    LDA #$0000            ; {125728}
    STA $7E7000, X        ; {125731}
    STA $7E7800, X        ; {125735}
    PLX                   ; {125739}
    COP [91]              ; {125740}
    PHX                   ; {125742}
    LDA $0312             ; {125743}
    LSR                   ; {125746}
    CLC                   ; {125747}
    ADC $033C             ; {125748}
    AND #$000F            ; {125751}
    ASL                   ; {125754}
    TAX                   ; {125755}
    LDY #$0000            ; {125756}
    SEP #$20              ; {125759}
    PHB                   ; {125761}
    LDA #$7E              ; {125762}
    PHA                   ; {125764}
    PLB                   ; {125765}

  loc_01EB46:
    LDA $@word_01EB82, X  ; {125766}
    CLC                   ; {125770}
    ADC $033A             ; {125771}
    STA $7100, Y          ; {125774}
    LDA $@word_01EB82, X  ; {125777}
    CLC                   ; {125781}
    ADC $033C             ; {125782}
    STA $7900, Y          ; {125785}
    INX                   ; {125788}
    INX                   ; {125789}
    INY                   ; {125790}
    INY                   ; {125791}
    CPY #$0020            ; {125792}
    BNE loc_01EB46        ; {125795}
    PLB                   ; {125797}
    LDA #$0F              ; {125798}
    XBA                   ; {125800}
    LDA #$7E              ; {125801}
    LDY #$7000            ; {125803}
    JSL $@chunk_010000.code_01186E ; {125806}
    LDA #$10              ; {125810}
    XBA                   ; {125812}
    LDA #$7E              ; {125813}
    LDY #$7800            ; {125815}
    JSL $@chunk_010000.code_01186E ; {125818}
    REP #$20              ; {125822}
    PLX                   ; {125824}
    RTL                   ; {125825}
}
---------------------------------------------

word_01EB82 [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0000   ;03
  #$0001   ;04
  #$0001   ;05
  #$0001   ;06
  #$0001   ;07
  #$0000   ;08
  #$0000   ;09
  #$0000   ;0A
  #$0000   ;0B
  #$FFFF   ;0C
  #$FFFF   ;0D
  #$FFFF   ;0E
  #$FFFF   ;0F
  #$0000   ;10
  #$0000   ;11
  #$0000   ;12
  #$0000   ;13
  #$0001   ;14
  #$0001   ;15
  #$0001   ;16
  #$0001   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$FFFF   ;1C
  #$FFFF   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
]
---------------------------------------------

asciistring_01EBC2 |[10]I am watching over [N]the world- Please take[N]this- [FIN][02:2] received [N]EXP! [JMP:&asciistring_01EC46]|

asciistring_01EBEA |[10]Would you like to [N]return to GreenWood? [END]|

asciistring_01EC09 |All right, good luck- [JMP:&asciistring_01EC46]|

asciistring_01EC1B |Come back to me [N]whenever you feel like[N]returning to [N]GreenWood- [JMP:&asciistring_01EC46]|

asciistring_01EC46 |[12][::][08:408][END]|