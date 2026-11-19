?BANK 1F

?INCLUDE 'chunk_000000'
?INCLUDE 'chunk_010000'
?INCLUDE 'chunk_018000'
?INCLUDE 'chunk_0270E4'

---------------------------------------------

code_0F8000 {
    COP [3B] ( #$007C, &code_0F8016 ) ; {1015808}
    COP [17] ( &code_0FA95A ) ; {1015814}
    SEP #$20              ; {1015818}
    LDA #$^chunk_000000.code_00305F ; {1015820}
    PHA                   ; {1015822}
    REP #$20              ; {1015823}
    LDA #$&chunk_000000.code_00305F-1 ; {1015825}
    PHA                   ; {1015828}
    RTL                   ; {1015829}
}

code_0F8016 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1015830}
    COP [15]              ; {1015835}
    COP [17] ( &code_0F8029 ) ; {1015837}

  loc_0F8021:
    COP [80] ( #11 )      ; {1015841}
    COP [82]              ; {1015844}
    BRL loc_0F8021        ; {1015846}
}

code_0F8029 {
    COP [07] ( #$8704, &code_0F804A ) ; {1015849}
    COP [19] ( #1C, &code_0F8045 ) ; {1015855}
    COP [01] ( &asciistring_0F8059 ) ; {1015860}
    COP [3C] ( #04 )      ; {1015864}
    COP [10] ( #$0209, #01, #$0078, #$0410 ) ; {1015867}
    RTL                   ; {1015876}
}

code_0F8045 {
    COP [01] ( &asciistring_0F804F ) ; {1015877}
    RTL                   ; {1015881}
}

code_0F804A {
    COP [01] ( &asciistring_0F8080 ) ; {1015882}
    RTL                   ; {1015886}
}

asciistring_0F804F |[10]Zzzzz [JMP:&asciistring_0FAA44]|

asciistring_0F8059 |[10][02:2] placed [N]the Dream Rod on [N]the dolphin s nose- [JMP:&asciistring_0FAA44]|

asciistring_0F8080 |[10]I always have the same[N]dream- Isn t that [N]strange! [JMP:&asciistring_0FAA44]|

code_0F80A4 {
    COP [14] ( #$00B1, &code_0F80AB ) ; {1015972}
    RTL                   ; {1015978}
}

code_0F80AB {
    COP [30] ( #$00B1, &code_0F8108, #1F ) ; {1015979}
    COP [07] ( #$8701, &code_0F80D4 ) ; {1015986}
    COP [85] ( @chunk_000000.code_00299D ) ; {1015992}
    COP [17] ( &code_0F80DC ) ; {1015997}

  loc_0F80C1:
    COP [81] ( #14, #02 ) ; {1016001}
    COP [83]              ; {1016005}
    COP [87]              ; {1016007}
    COP [81] ( #13, #02 ) ; {1016009}
    COP [83]              ; {1016013}
    COP [87]              ; {1016015}
    BRL loc_0F80C1        ; {1016017}
}

code_0F80D4 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1016020}
    COP [86]              ; {1016025}
    RTL                   ; {1016027}
}

code_0F80DC {
    LDA $0016, X          ; {1016028}
    AND #$FFEF            ; {1016031}
    STA $0016, X          ; {1016034}
    COP [01] ( &asciistring_0F814A ) ; {1016037}
    LDA $0016, X          ; {1016041}
    ORA #$0010            ; {1016044}
    STA $0016, X          ; {1016047}
    SEP #$20              ; {1016050}
    LDA $1B82             ; {1016052}
    ORA #$04              ; {1016055}
    STA $1B82             ; {1016057}
    REP #$20              ; {1016060}
    COP [09] ( #$8701 )   ; {1016062}
    BRK #$4E              ; {1016066}
    COP [27] ( &code_0F80D4 ) ; {1016068}
}

code_0F8108 {
    COP [01] ( &asciistring_0F810F ) ; {1016072}
    COP [86]              ; {1016076}
    RTL                   ; {1016078}
}

asciistring_0F810F |[10][0E:3C]I have the power to [N]stop the Magma Rain- [N]I will help you if you[N]return to me- [JMP:&asciistring_0FAA44]|

asciistring_0F814A |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]I will protect you [N]from the Magma- [FIN]Please try and protect[N]all creatures- [FIN]Let s work together so[N]we may revive the [N]world! [FIN]The creature that [N]enables you to avoid [N]Magma has joined you- [JMP:&asciistring_0FAA44]|

code_0F8209 {
    COP [3B] ( #$0083, &code_0F821F ) ; {1016329}
    COP [17] ( &code_0FA95A ) ; {1016335}
    SEP #$20              ; {1016339}
    LDA #$^chunk_000000.code_00305F ; {1016341}
    PHA                   ; {1016343}
    REP #$20              ; {1016344}
    LDA #$&chunk_000000.code_00305F-1 ; {1016346}
    PHA                   ; {1016349}
    RTL                   ; {1016350}
}

code_0F821F {
    COP [85] ( @chunk_000000.code_00299D ) ; {1016351}
    COP [17] ( &code_0F826B ) ; {1016356}
    COP [80] ( #12 )      ; {1016360}
    COP [82]              ; {1016363}

  loc_0F822D:
    COP [A3]              ; {1016365}
    COP [84] ( @code_0F824F ) ; {1016367}
    COP [80] ( #1F )      ; {1016372}
    COP [82]              ; {1016375}
    COP [84] ( @code_0F824F ) ; {1016377}
    COP [A6]              ; {1016382}
    COP [17] ( &code_0F8266 ) ; {1016384}
    COP [81] ( #12, #02 ) ; {1016388}
    COP [83]              ; {1016392}
    COP [87]              ; {1016394}
    BRL loc_0F822D        ; {1016396}
}

code_0F824F {
    LDA #$0310            ; {1016399}
    STA $0016, X          ; {1016402}
    LDA #$002A            ; {1016405}
    STA $001E, X          ; {1016408}
    STZ $0020, X          ; {1016411}
    COP [80] ( #2A )      ; {1016414}
    COP [82]              ; {1016417}
    COP [86]              ; {1016419}
    RTL                   ; {1016421}
}

code_0F8266 {
    COP [01] ( &asciistring_0F8270 ) ; {1016422}
    RTL                   ; {1016426}
}

code_0F826B {
    COP [01] ( &asciistring_0F82A8 ) ; {1016427}
    RTL                   ; {1016431}
}

asciistring_0F8270 |[10]I didn t know the [N]world under water [N]looked different from [N]the world above- [JMP:&asciistring_0FAA44]|

asciistring_0F82A8 |[10]Please don t talk to [N]me while I m jumping, [N]I will not be able to [N]breathe- [JMP:&asciistring_0FAA44]|

code_0F82DD {
    COP [14] ( #$0084, &code_0F82E4 ) ; {1016541}
    RTL                   ; {1016547}
}

code_0F82E4 {
    COP [17] ( &code_0F82F2 ) ; {1016548}
    COP [15]              ; {1016552}
    COP [91]              ; {1016554}
    COP [80] ( #06 )      ; {1016556}
    COP [82]              ; {1016559}
    RTL                   ; {1016561}
}

code_0F82F2 {
    COP [01] ( &asciistring_0F831C ) ; {1016562}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_0F8317 ) ; {1016566}
    LDA $0003D0           ; {1016573}
    BNE code_0F8317       ; {1016577}
    COP [18] ( #38, &code_0F830D ) ; {1016579}
    COP [01] ( &asciistring_0F836C ) ; {1016584}
    RTL                   ; {1016588}
}

code_0F830D {
    COP [01] ( &asciistring_0F8355 ) ; {1016589}
    BRK #$5E              ; {1016593}
    COP [0A] ( #38 )      ; {1016595}
    RTL                   ; {1016598}
}

code_0F8317 {
    COP [01] ( &asciistring_0F8395 ) ; {1016599}
    RTL                   ; {1016603}
}

asciistring_0F831C |[10]Hello, I have some [N]Medical Herbs made [N]from seaweed- [N]Would you like one? [END]|

asciistring_0F8355 |[10]Come back to me [N]when you don t have [N]one- [JMP:&asciistring_0FAA44]|

asciistring_0F836C |[10]Medical herbs are [N]really rare- [N]I can t give you many-[JMP:&asciistring_0FAA44]|

asciistring_0F8395 |[10]Come see me when you [N]need another- [JMP:&asciistring_0FAA44]|

code_0F83AD {
    COP [14] ( #$0086, &code_0F83B4 ) ; {1016749}
    RTL                   ; {1016755}
}

code_0F83B4 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1016756}
    COP [17] ( &code_0F841B ) ; {1016761}

  loc_0F83BD:
    COP [81] ( #13, #04 ) ; {1016765}
    COP [83]              ; {1016769}
    COP [07] ( #$8007, &code_0F83D6 ) ; {1016771}

  loc_0F83C9:
    COP [87]              ; {1016777}
    COP [81] ( #14, #04 ) ; {1016779}
    COP [83]              ; {1016783}
    COP [87]              ; {1016785}
    BRL loc_0F83BD        ; {1016787}
}

code_0F83D6 {
    COP [17] ( #$0000 )   ; {1016790}
    COP [03] ( #3D )      ; {1016794}
    COP [04]              ; {1016797}
    BRK #$56              ; {1016799}
    COP [A2] ( #30 )      ; {1016801}
    COP [A3]              ; {1016804}
    COP [84] ( @code_0F8404 ) ; {1016806}
    COP [80] ( #15 )      ; {1016811}
    COP [82]              ; {1016814}
    COP [84] ( @code_0F8404 ) ; {1016816}
    COP [A6]              ; {1016821}
    COP [A2] ( #20 )      ; {1016823}
    COP [09] ( #$0007 )   ; {1016826}
    COP [17] ( &code_0F841B ) ; {1016830}
    BRA loc_0F83C9        ; {1016834}
}

code_0F8404 {
    LDA #$0310            ; {1016836}
    STA $0016, X          ; {1016839}
    LDA #$002A            ; {1016842}
    STA $001E, X          ; {1016845}
    STZ $0020, X          ; {1016848}
    COP [80] ( #2A )      ; {1016851}
    COP [82]              ; {1016854}
    COP [86]              ; {1016856}
    RTL                   ; {1016858}
}

code_0F841B {
    COP [01] ( &asciistring_0F8424 ) ; {1016859}
    COP [09] ( #$8007 )   ; {1016863}
    RTL                   ; {1016867}
}

asciistring_0F8424 |[10]I am the best jumper! [N]I ll show you- [JMP:&asciistring_0FAA44]|

code_0F8446 {
    COP [14] ( #$0099, &code_0F844D ) ; {1016902}
    RTL                   ; {1016908}
}

code_0F844D {
    COP [85] ( @chunk_000000.code_00299D ) ; {1016909}
    COP [14] ( #$00C2, &code_0F845B ) ; {1016914}
    BRL loc_0F8474        ; {1016920}
}

code_0F845B {
    COP [14] ( #$00A5, &code_0F8464 ) ; {1016923}
    BRL loc_0F8474        ; {1016929}
}

code_0F8464 {
    COP [14] ( #$008B, &code_0F846D ) ; {1016932}
    BRL loc_0F8474        ; {1016938}
}

code_0F846D {
    COP [17] ( &code_0F8493 ) ; {1016941}
    BRL loc_0F8478        ; {1016945}

  loc_0F8474:
    COP [17] ( &code_0F848E ) ; {1016948}

  loc_0F8478:
    COP [15]              ; {1016952}
    COP [91]              ; {1016954}
    COP [80] ( #06 )      ; {1016956}
    COP [82]              ; {1016959}
    RTL                   ; {1016961}
}

code_0F8482 {
    COP [09] ( #$8003 )   ; {1016962}
    COP [91]              ; {1016966}
    COP [80] ( #06 )      ; {1016968}
    COP [82]              ; {1016971}
    RTL                   ; {1016973}
}

code_0F848E {
    COP [01] ( &asciistring_0F849B ) ; {1016974}
    RTL                   ; {1016978}
}

code_0F8493 {
    COP [01] ( &asciistring_0F84F1 ) ; {1016979}
    COP [27] ( &code_0F8482 ) ; {1016983}
}

asciistring_0F849B |[10]Mermaids have to be [N]very good at dancing- [FIN]If three of my [N]students return, I [N]will show you our [N]great dance- [JMP:&asciistring_0FAA44]|

asciistring_0F84F1 |[10]Thank you very much- [N]Three of my students [N]came back- [FIN]I was going to show [N]you our dance-I think [N]it will be more fun if[N]you join us- [FIN]I will show you the [N]easiest dance, just [N]move like they do- [JMP:&asciistring_0FAA44]|

code_0F8577 {
    COP [3B] ( #$00C2, &code_0F858D ) ; {1017207}
    COP [17] ( &code_0FA95A ) ; {1017213}
    SEP #$20              ; {1017217}
    LDA #$^chunk_000000.code_00305F ; {1017219}
    PHA                   ; {1017221}
    REP #$20              ; {1017222}
    LDA #$&chunk_000000.code_00305F-1 ; {1017224}
    PHA                   ; {1017227}
    RTL                   ; {1017228}
}

code_0F858D {
    COP [85] ( @chunk_000000.code_00299D ) ; {1017229}
    COP [17] ( &code_0F85B2 ) ; {1017234}
    COP [15]              ; {1017238}

  code_0F8598:
    COP [80] ( #01 )      ; {1017240}
    COP [82]              ; {1017243}
    COP [07] ( #$0003, &code_0F8598 ) ; {1017245}
    COP [16]              ; {1017251}

  loc_0F85A5:
    COP [80] ( #03 )      ; {1017253}
    COP [82]              ; {1017256}
    COP [80] ( #04 )      ; {1017258}
    COP [82]              ; {1017261}
    BRL loc_0F85A5        ; {1017263}
}

code_0F85B2 {
    COP [01] ( &asciistring_0F85B7 ) ; {1017266}
    RTL                   ; {1017270}
}

asciistring_0F85B7 |[10]My name is Anna- [N]I am one of the [N]Queen s dancers- [JMP:&asciistring_0FAA44]|

code_0F85E1 {
    COP [3B] ( #$00A5, &code_0F85F7 ) ; {1017313}
    COP [17] ( &code_0FA95A ) ; {1017319}
    SEP #$20              ; {1017323}
    LDA #$^chunk_000000.code_00305F ; {1017325}
    PHA                   ; {1017327}
    REP #$20              ; {1017328}
    LDA #$&chunk_000000.code_00305F-1 ; {1017330}
    PHA                   ; {1017333}
    RTL                   ; {1017334}
}

code_0F85F7 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1017335}
    COP [17] ( &code_0F861C ) ; {1017340}
    COP [15]              ; {1017344}

  code_0F8602:
    COP [80] ( #01 )      ; {1017346}
    COP [82]              ; {1017349}
    COP [07] ( #$0003, &code_0F8602 ) ; {1017351}
    COP [16]              ; {1017357}

  loc_0F860F:
    COP [80] ( #03 )      ; {1017359}
    COP [82]              ; {1017362}
    COP [80] ( #04 )      ; {1017364}
    COP [82]              ; {1017367}
    BRL loc_0F860F        ; {1017369}
}

code_0F861C {
    COP [07] ( #$8503, &code_0F8627 ) ; {1017372}
    COP [01] ( &asciistring_0F862C ) ; {1017378}
    RTL                   ; {1017382}
}

code_0F8627 {
    COP [01] ( &asciistring_0F86E3 ) ; {1017383}
    RTL                   ; {1017387}
}

asciistring_0F862C |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]As a reward for saving[N]us I will tell you a [N]secret- [FIN]No armor will protect [N]you against the Magma [N]off the volcanic [N]island, Durean- [FIN]You must find a way to[N]stop the volcano- [JMP:&asciistring_0FAA44]|

asciistring_0F86E3 |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]You have seized the [N]volcano, right? [N]You are a very brave [N]person- [JMP:&asciistring_0FAA44]|

code_0F873E {
    COP [3B] ( #$008B, &code_0F8754 ) ; {1017662}
    COP [17] ( &code_0FA95A ) ; {1017668}
    SEP #$20              ; {1017672}
    LDA #$^chunk_000000.code_00305F ; {1017674}
    PHA                   ; {1017676}
    REP #$20              ; {1017677}
    LDA #$&chunk_000000.code_00305F-1 ; {1017679}
    PHA                   ; {1017682}
    RTL                   ; {1017683}
}

code_0F8754 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1017684}
    COP [17] ( &code_0F8779 ) ; {1017689}
    COP [15]              ; {1017693}

  code_0F875F:
    COP [80] ( #01 )      ; {1017695}
    COP [82]              ; {1017698}
    COP [07] ( #$0003, &code_0F875F ) ; {1017700}
    COP [16]              ; {1017706}

  loc_0F876C:
    COP [80] ( #03 )      ; {1017708}
    COP [82]              ; {1017711}
    COP [80] ( #04 )      ; {1017713}
    COP [82]              ; {1017716}
    BRL loc_0F876C        ; {1017718}
}

code_0F8779 {
    COP [01] ( &asciistring_0F877E ) ; {1017721}
    RTL                   ; {1017725}
}

asciistring_0F877E |[10]My name is Nanna- [N]I am one of the [N]Queen s dancers- [JMP:&asciistring_0FAA44]|

code_0F87A9 {
    COP [14] ( #$008D, &code_0F87B0 ) ; {1017769}
    RTL                   ; {1017775}
}

code_0F87B0 {
    COP [30] ( #$008D, &code_0F87F9, #1F ) ; {1017776}
    COP [17] ( &code_0F87D5 ) ; {1017783}
    COP [91]              ; {1017787}
    COP [0D] ( #00, #22, #1C, &code_0F87C5 ) ; {1017789}
    RTL                   ; {1017796}
}

code_0F87C5 {
    COP [11] ( #00, #23, #1E ) ; {1017797}
    COP [33]              ; {1017802}
    LDA #$EF80            ; {1017804}
    TRB $0326             ; {1017807}
    COP [91]              ; {1017810}
    RTL                   ; {1017812}
}

code_0F87D5 {
    COP [01] ( &asciistring_0F8800 ) ; {1017813}
    COP [07] ( #$8407, &code_0F87F8 ) ; {1017817}
    LDA #$EF80            ; {1017823}
    TSB $0326             ; {1017826}
    LDA #$0020            ; {1017829}
    STA $03B4             ; {1017832}
    COP [09] ( #$8903 )   ; {1017835}
    COP [10] ( #$0107, #02, #$06A0, #$0040 ) ; {1017839}
}

code_0F87F8 {
    RTL                   ; {1017848}
}

code_0F87F9 {
    COP [01] ( &asciistring_0F8B27 ) ; {1017849}
    COP [86]              ; {1017853}
    RTL                   ; {1017855}
}

asciistring_0F8800 |[10]I will open a passage [N]for you- [FIN]Travel up the seabed [N]to reach the island of[N]rain, Blester- [JMP:&asciistring_0FAA44]|

code_0F8850 {
    COP [14] ( #$00AD, &code_0F8857 ) ; {1017936}
    RTL                   ; {1017942}
}

code_0F8857 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1017943}
    COP [17] ( &code_0F886A ) ; {1017948}

  loc_0F8860:
    COP [81] ( #12, #04 ) ; {1017952}
    COP [83]              ; {1017956}
    COP [87]              ; {1017958}
    BRA loc_0F8860        ; {1017960}
}

code_0F886A {
    LDA $0016, X          ; {1017962}
    AND #$FFEF            ; {1017965}
    STA $0016, X          ; {1017968}
    COP [01] ( &asciistring_0F8881 ) ; {1017971}
    LDA $0016, X          ; {1017975}
    ORA #$0010            ; {1017978}
    STA $0016, X          ; {1017981}
    RTL                   ; {1017984}
}

asciistring_0F8881 |[10][0A]If█you█travel[N]the█coral█reef█you[N]will█find█a█passage█to[N]a█small█creek-[JMP:&asciistring_0FAA44]|

code_0F88CC {
    COP [3B] ( #$00BE, &code_0F88E2 ) ; {1018060}
    COP [17] ( &code_0FA95A ) ; {1018066}
    SEP #$20              ; {1018070}
    LDA #$^chunk_000000.code_00305F ; {1018072}
    PHA                   ; {1018074}
    REP #$20              ; {1018075}
    LDA #$&chunk_000000.code_00305F-1 ; {1018077}
    PHA                   ; {1018080}
    RTL                   ; {1018081}
}

code_0F88E2 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1018082}
    COP [17] ( &code_0F88F5 ) ; {1018087}

  loc_0F88EB:
    COP [81] ( #12, #04 ) ; {1018091}
    COP [83]              ; {1018095}
    COP [87]              ; {1018097}
    BRA loc_0F88EB        ; {1018099}
}

code_0F88F5 {
    COP [01] ( &asciistring_0F88FA ) ; {1018101}
    RTL                   ; {1018105}
}

asciistring_0F88FA |[10]The coral reef [N]hides many dangerous [N]monsters- Make sure [N]to use magic there- [JMP:&asciistring_0FAA44]|

code_0F8941 {
    COP [14] ( #$0092, &code_0F8948 ) ; {1018177}
    RTL                   ; {1018183}
}

code_0F8948 {
    COP [07] ( #$9F02, &code_0F8984 ) ; {1018184}
    COP [85] ( @chunk_000000.code_00299D ) ; {1018190}
    COP [17] ( &code_0F8987 ) ; {1018195}
    COP [15]              ; {1018199}

  loc_0F8959:
    COP [14] ( #$00B6, &code_0F8967 ) ; {1018201}
    COP [80] ( #08 )      ; {1018207}
    COP [82]              ; {1018210}
    BRL loc_0F8959        ; {1018212}
}

code_0F8967 {
    COP [16]              ; {1018215}
    COP [81] ( #0A, #03 ) ; {1018217}
    COP [83]              ; {1018221}
    COP [96]              ; {1018223}
    COP [80] ( #08 )      ; {1018225}
    COP [82]              ; {1018228}
    COP [15]              ; {1018230}
    COP [17] ( &code_0F898C ) ; {1018232}
    COP [91]              ; {1018236}
    COP [80] ( #08 )      ; {1018238}
    COP [82]              ; {1018241}
    RTL                   ; {1018243}
}

code_0F8984 {
    COP [86]              ; {1018244}
    RTL                   ; {1018246}
}

code_0F8987 {
    COP [01] ( &asciistring_0F8991 ) ; {1018247}
    RTL                   ; {1018251}
}

code_0F898C {
    COP [01] ( &asciistring_0F89BB ) ; {1018252}
    RTL                   ; {1018256}
}

asciistring_0F8991 |[10]This used to be the [N]Queen s palace- I am [N]the Queen s maid- [JMP:&asciistring_0FAA44]|

asciistring_0F89BB |[10]I am glad you came [N]back- [JMP:&asciistring_0FAA44]|

code_0F89CF {
    COP [14] ( #$0095, &code_0F89D6 ) ; {1018319}
    RTL                   ; {1018325}
}

code_0F89D6 {
    COP [17] ( &code_0F89E4 ) ; {1018326}
    COP [15]              ; {1018330}

  loc_0F89DC:
    COP [80] ( #06 )      ; {1018332}
    COP [82]              ; {1018335}
    BRL loc_0F89DC        ; {1018337}
}

code_0F89E4 {
    COP [01] ( &asciistring_0F89E9 ) ; {1018340}
    RTL                   ; {1018344}
}

asciistring_0F89E9 |[10]Servas is the name of [N]my friend the dolphin-[JMP:&asciistring_0FAA44]|

code_0F8A0E {
    COP [14] ( #$009B, &code_0F8A15 ) ; {1018382}
    RTL                   ; {1018388}
}

code_0F8A15 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1018389}
    COP [15]              ; {1018394}
    COP [17] ( &code_0F8A28 ) ; {1018396}
    COP [91]              ; {1018400}
    COP [80] ( #11 )      ; {1018402}
    COP [82]              ; {1018405}
    RTL                   ; {1018407}
}

code_0F8A28 {
    COP [01] ( &asciistring_0F8A2D ) ; {1018408}
    RTL                   ; {1018412}
}

asciistring_0F8A2D |[10]There used to be [N]4 mermaid statues in [N]this place- [FIN]Those statues [N]prevented all [N]creatures from getting[N]lost- [JMP:&asciistring_0FAA44]|

code_0F8A7E {
    COP [14] ( #$009D, &code_0F8A85 ) ; {1018494}
    RTL                   ; {1018500}
}

code_0F8A85 {
    COP [30] ( #$009D, &code_0F8ACE, #1F ) ; {1018501}
    COP [17] ( &code_0F8AAA ) ; {1018508}
    COP [91]              ; {1018512}
    COP [0D] ( #00, #22, #22, &code_0F8A9A ) ; {1018514}
    RTL                   ; {1018521}
}

code_0F8A9A {
    COP [11] ( #00, #23, #24 ) ; {1018522}
    COP [33]              ; {1018527}
    LDA #$AFC0            ; {1018529}
    TRB $0326             ; {1018532}
    COP [91]              ; {1018535}
    RTL                   ; {1018537}
}

code_0F8AAA {
    COP [01] ( &asciistring_0F8AD5 ) ; {1018538}
    COP [07] ( #$8406, &code_0F8ACD ) ; {1018542}
    LDA #$EF80            ; {1018548}
    TSB $0326             ; {1018551}
    LDA #$0020            ; {1018554}
    STA $03B4             ; {1018557}
    COP [09] ( #$8903 )   ; {1018560}
    COP [10] ( #$0107, #02, #$05B0, #$0240 ) ; {1018564}
}

code_0F8ACD {
    RTL                   ; {1018573}
}

code_0F8ACE {
    COP [01] ( &asciistring_0F8B27 ) ; {1018574}
    COP [86]              ; {1018578}
    RTL                   ; {1018580}
}

asciistring_0F8AD5 |[10]I will open a passage [N]for you- [FIN]Proceed right along [N]the seabed to the [N]shore reef, Rockbird- [JMP:&asciistring_0FAA44]|

asciistring_0F8B27 |[10][0E:3C][02:2] hears [N]a small voice- [FIN]I will open the [N]passage for you, [N]return to me- [JMP:&asciistring_0FAA44]|

code_0F8B6A {
    COP [14] ( #$00A1, &code_0F8B71 ) ; {1018730}
    RTL                   ; {1018736}
}

code_0F8B71 {
    COP [30] ( #$00A1, &code_0F8BB5, #1F ) ; {1018737}
    COP [B0] ( @code_0F8C9A, #$2000 ) ; {1018744}
    COP [17] ( &code_0F8B8D ) ; {1018751}
    COP [15]              ; {1018755}
    COP [91]              ; {1018757}
    COP [80] ( #08 )      ; {1018759}
    COP [82]              ; {1018762}
    RTL                   ; {1018764}
}

code_0F8B8D {
    COP [07] ( #$8405, &code_0F8BA1 ) ; {1018765}
    COP [09] ( #$8405 )   ; {1018771}
    COP [01] ( &asciistring_0F8BF7 ) ; {1018775}
    BRK #$5E              ; {1018779}
    COP [0A] ( #0B )      ; {1018781}
    RTL                   ; {1018784}
}

code_0F8BA1 {
    LDA $1B88             ; {1018785}
    CMP $1B8A             ; {1018788}
    BEQ loc_0F8BB0        ; {1018791}
    COP [01] ( &asciistring_0F8C60 ) ; {1018793}
    COP [37]              ; {1018797}
    RTL                   ; {1018799}

  loc_0F8BB0:
    COP [01] ( &asciistring_0F8C75 ) ; {1018800}
    RTL                   ; {1018804}
}

code_0F8BB5 {
    COP [01] ( &asciistring_0F8BBC ) ; {1018805}
    COP [86]              ; {1018809}
    RTL                   ; {1018811}
}

asciistring_0F8BBC |[10][0E:3C]You hear a mermaid-[FIN]Is there anyone who [N]needs to use the [N]Bubble Armor? [JMP:&asciistring_0FAA44]|

asciistring_0F8BF7 |[10]Oh! I have not had a [N]human guest in a long [N]time- [FIN]I know you can t [N]breathe under water, [N]so please take this- [FIN][02:2] received [N][03:24]Bubble Armor- [03:20][JMP:&asciistring_0FAA44]|

asciistring_0F8C60 |[10]Have you been hurt? [JMP:&asciistring_0FAA44]|

asciistring_0F8C75 |[10]If you get hurt, [N]return to me and I [N]will heal you- [JMP:&asciistring_0FAA44]|

code_0F8C9A {
    COP [07] ( #$8A02, &code_0F8CC8 ) ; {1019034}
    COP [91]              ; {1019040}
    COP [18] ( #21, &code_0F8CA9 ) ; {1019042}
    BRA loc_0F8CAA        ; {1019047}
}

code_0F8CA9 {
    RTL                   ; {1019049}

  loc_0F8CAA:
    LDA #$02A0            ; {1019050}
    STA $16               ; {1019053}
    LDA #$0B80            ; {1019055}
    STA $18               ; {1019058}
    PHX                   ; {1019060}
    JSL $@chunk_0270E4.code_0272B8 ; {1019061}
    SEP #$20              ; {1019065}
    LDA #$FC              ; {1019067}
    STA $7E8000, X        ; {1019069}
    REP #$20              ; {1019073}
    PLX                   ; {1019075}
    COP [09] ( #$8A02 )   ; {1019076}
}

code_0F8CC8 {
    COP [86]              ; {1019080}
    RTL                   ; {1019082}
}

code_0F8CCB {
    COP [14] ( #$00A4, &code_0F8CD2 ) ; {1019083}
    RTL                   ; {1019089}
}

code_0F8CD2 {
    COP [17] ( &code_0F8D02 ) ; {1019090}
    COP [11] ( #13, #35, #26 ) ; {1019094}
    COP [85] ( @chunk_000000.code_00299D ) ; {1019099}
    COP [15]              ; {1019104}
    COP [91]              ; {1019106}

  loc_0F8CE4:
    COP [0C] ( #00, #02, &code_0F8CF1 ) ; {1019108}

  code_0F8CEA:
    COP [80] ( #01 )      ; {1019114}
    COP [82]              ; {1019117}
    BRA loc_0F8CE4        ; {1019119}
}

code_0F8CF1 {
    COP [9B] ( #$0000, &code_0F8CEA, &code_0F8CEA, &code_0F8CFB ) ; {1019121}
}

code_0F8CFB {
    COP [80] ( #00 )      ; {1019131}
    COP [82]              ; {1019134}
    BRA loc_0F8CE4        ; {1019136}
}

code_0F8D02 {
    COP [0D] ( #00, #35, #26, &code_0F8D0E ) ; {1019138}
    COP [01] ( &asciistring_0F8D13 ) ; {1019145}
    RTL                   ; {1019149}
}

code_0F8D0E {
    COP [01] ( &asciistring_0F8D44 ) ; {1019150}
    RTL                   ; {1019154}
}

asciistring_0F8D13 |[10]Sorry, I have orders [N]from the Queen not to [N]let anyone pass- [JMP:&asciistring_0FAA44]|

asciistring_0F8D44 |[10]How did you get here? [JMP:&asciistring_0FAA44]|

code_0F8D58 {
    COP [3B] ( #$00A7, &code_0F8D6E ) ; {1019224}
    COP [17] ( &code_0FA95A ) ; {1019230}
    SEP #$20              ; {1019234}
    LDA #$^chunk_000000.code_00305F ; {1019236}
    PHA                   ; {1019238}
    REP #$20              ; {1019239}
    LDA #$&chunk_000000.code_00305F-1 ; {1019241}
    PHA                   ; {1019244}
    RTL                   ; {1019245}
}

code_0F8D6E {
    COP [85] ( @chunk_000000.code_00299D ) ; {1019246}
    COP [17] ( &code_0F8D81 ) ; {1019251}
    COP [15]              ; {1019255}
    COP [91]              ; {1019257}
    COP [80] ( #06 )      ; {1019259}
    COP [82]              ; {1019262}
    RTL                   ; {1019264}
}

code_0F8D81 {
    COP [07] ( #$8503, &code_0F8D96 ) ; {1019265}
    COP [18] ( #21, &code_0F8D91 ) ; {1019271}
    COP [01] ( &asciistring_0F8D9B ) ; {1019276}
    RTL                   ; {1019280}
}

code_0F8D91 {
    COP [01] ( &asciistring_0F8DF9 ) ; {1019281}
    RTL                   ; {1019285}
}

code_0F8D96 {
    COP [01] ( &asciistring_0F8E14 ) ; {1019286}
    RTL                   ; {1019290}
}

asciistring_0F8D9B |[10]The teardrops from a [N]mermaid have the power[N]to turn Magma to [N]stone- [FIN]Use them at the top of[N]the volcanic island- [JMP:&asciistring_0FAA44]|

asciistring_0F8DF9 |[10]Open the treasure [N]chest- [JMP:&asciistring_0FAA44]|

asciistring_0F8E14 |[10]These teardrops were [N]left by a mermaid when[N]evil invaded this [N]place- [FIN]Icy teardrops, filled [N]with sorrow, will turn[N]even the hottest Magma[N]to stone- [JMP:&asciistring_0FAA44]|

code_0F8E99 {
    COP [14] ( #$00AB, &code_0F8EA0 ) ; {1019545}
    RTL                   ; {1019551}
}

code_0F8EA0 {
    COP [30] ( #$00AB, &code_0F8EE9, #1F ) ; {1019552}
    COP [17] ( &code_0F8EC5 ) ; {1019559}
    COP [91]              ; {1019563}
    COP [0D] ( #00, #1C, #22, &code_0F8EB5 ) ; {1019565}
    RTL                   ; {1019572}
}

code_0F8EB5 {
    COP [11] ( #00, #1C, #24 ) ; {1019573}
    COP [33]              ; {1019578}
    LDA #$AFC0            ; {1019580}
    TRB $0326             ; {1019583}
    COP [91]              ; {1019586}
    RTL                   ; {1019588}
}

code_0F8EC5 {
    COP [01] ( &asciistring_0F8EF0 ) ; {1019589}
    COP [07] ( #$8500, &code_0F8EE8 ) ; {1019593}
    LDA #$EF80            ; {1019599}
    TSB $0326             ; {1019602}
    LDA #$0020            ; {1019605}
    STA $03B4             ; {1019608}
    COP [09] ( #$8903 )   ; {1019611}
    COP [10] ( #$0107, #02, #$0240, #$02B0 ) ; {1019615}
}

code_0F8EE8 {
    RTL                   ; {1019624}
}

code_0F8EE9 {
    COP [01] ( &asciistring_0F8B27 ) ; {1019625}
    COP [86]              ; {1019629}
    RTL                   ; {1019631}
}

asciistring_0F8EF0 |[10]I will open the [N]passage for you- [FIN]Walk downward under [N]the sea and go to the [N]volcanic island, [N]Durean- [JMP:&asciistring_0FAA44]|

code_0F8F45 {
    COP [14] ( #$00C1, &code_0F8F4C ) ; {1019717}
    RTL                   ; {1019723}
}

code_0F8F4C {
    COP [85] ( @chunk_000000.code_00299D ) ; {1019724}

  loc_0F8F51:
    COP [17] ( &code_0F9041 ) ; {1019729}
    COP [15]              ; {1019733}

  code_0F8F57:
    COP [80] ( #10 )      ; {1019735}
    COP [82]              ; {1019738}
    COP [07] ( #$0000, &code_0F8F57 ) ; {1019740}

  loc_0F8F62:
    COP [0D] ( #00, #03, #31, &code_0F8F71 ) ; {1019746}
    COP [80] ( #10 )      ; {1019753}
    COP [82]              ; {1019756}
    BRL loc_0F8F62        ; {1019758}
}

code_0F8F71 {
    COP [16]              ; {1019761}
    COP [17] ( #$0000 )   ; {1019763}
    COP [85] ( @code_0F8FAB ) ; {1019767}
    COP [81] ( #0D, #1B ) ; {1019772}
    COP [83]              ; {1019776}
    COP [17] ( &code_0F9041 ) ; {1019778}
    COP [15]              ; {1019782}

  loc_0F8F88:
    COP [0D] ( #00, #03, #19, &code_0F8F97 ) ; {1019784}
    COP [80] ( #0F )      ; {1019791}
    COP [82]              ; {1019794}
    BRL loc_0F8F88        ; {1019796}
}

code_0F8F97 {
    COP [16]              ; {1019799}
    COP [17] ( #$0000 )   ; {1019801}
    COP [85] ( @code_0F8FF6 ) ; {1019805}
    COP [81] ( #0C, #1B ) ; {1019810}
    COP [83]              ; {1019814}
    BRL loc_0F8F51        ; {1019816}
}

code_0F8FAB {
    LDA #$2F80            ; {1019819}
    TSB $0326             ; {1019822}
    LDA #$01B0            ; {1019825}
    STA $0025, X          ; {1019828}
    LDY $039C             ; {1019831}
    LDA $0016, Y          ; {1019834}
    AND #$EFFF            ; {1019837}
    STA $0016, Y          ; {1019840}
    COP [91]              ; {1019843}
    LDY $003C, X          ; {1019845}
    LDA $0002, Y          ; {1019848}
    SEC                   ; {1019851}
    SBC #$0020            ; {1019852}
    LDY $039C             ; {1019855}
    STA $0002, Y          ; {1019858}
    LDA #$FFFF            ; {1019861}
    STA $0006, Y          ; {1019864}
    DEC $0025, X          ; {1019867}
    BEQ loc_0F8FE1        ; {1019870}
    RTL                   ; {1019872}

  loc_0F8FE1:
    LDY $039C             ; {1019873}
    LDA $0016, Y          ; {1019876}
    ORA #$1000            ; {1019879}
    STA $0016, Y          ; {1019882}
    LDA #$2F80            ; {1019885}
    TRB $0326             ; {1019888}
    COP [86]              ; {1019891}
    RTL                   ; {1019893}
}

code_0F8FF6 {
    LDA #$2F80            ; {1019894}
    TSB $0326             ; {1019897}
    LDA #$01B0            ; {1019900}
    STA $0025, X          ; {1019903}
    LDY $039C             ; {1019906}
    LDA $0016, Y          ; {1019909}
    AND #$EFFF            ; {1019912}
    STA $0016, Y          ; {1019915}
    COP [91]              ; {1019918}
    LDY $003C, X          ; {1019920}
    LDA $0002, Y          ; {1019923}
    CLC                   ; {1019926}
    ADC #$0010            ; {1019927}
    LDY $039C             ; {1019930}
    STA $0002, Y          ; {1019933}
    LDA #$0001            ; {1019936}
    STA $0006, Y          ; {1019939}
    DEC $0025, X          ; {1019942}
    BEQ loc_0F902C        ; {1019945}
    RTL                   ; {1019947}

  loc_0F902C:
    LDY $039C             ; {1019948}
    LDA $0016, Y          ; {1019951}
    ORA #$1000            ; {1019954}
    STA $0016, Y          ; {1019957}
    LDA #$2F80            ; {1019960}
    TRB $0326             ; {1019963}
    COP [86]              ; {1019966}
    RTL                   ; {1019968}
}

code_0F9041 {
    COP [01] ( &asciistring_0F904A ) ; {1019969}
    COP [09] ( #$8000 )   ; {1019973}
    RTL                   ; {1019977}
}

asciistring_0F904A |[10]Stand on my nose- [JMP:&asciistring_0FAA44]|

code_0F905C {
    COP [3B] ( #$00B5, &code_0F9072 ) ; {1019996}
    COP [17] ( &code_0FA95A ) ; {1020002}
    SEP #$20              ; {1020006}
    LDA #$^chunk_000000.code_00305F ; {1020008}
    PHA                   ; {1020010}
    REP #$20              ; {1020011}
    LDA #$&chunk_000000.code_00305F-1 ; {1020013}
    PHA                   ; {1020016}
    RTL                   ; {1020017}
}

code_0F9072 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1020018}
    COP [17] ( &code_0F9085 ) ; {1020023}
    COP [15]              ; {1020027}
    COP [91]              ; {1020029}
    COP [80] ( #02 )      ; {1020031}
    COP [82]              ; {1020034}
    RTL                   ; {1020036}
}

code_0F9085 {
    COP [18] ( #13, &code_0F908F ) ; {1020037}
    COP [01] ( &asciistring_0F90B5 ) ; {1020042}
    RTL                   ; {1020046}
}

code_0F908F {
    COP [01] ( &asciistring_0F9099 ) ; {1020047}
    BRK #$5E              ; {1020051}
    COP [0A] ( #13 )      ; {1020053}
    RTL                   ; {1020056}
}

asciistring_0F9099 |[10]I will give you [N][03:24]the Magic Flair- [FIN][03:20][JMP:&asciistring_0F90B5+M]|

asciistring_0F90B5 |[10][::]Magic Flair is useful [N]against monsters that [N]fly and have a large [N]amount of hit points- [FIN]You know which [N]monsters I am [N]referring to, right? [JMP:&asciistring_0FAA44]|

code_0F911E {
    COP [14] ( #$00B6, &code_0F9125 ) ; {1020190}
    RTL                   ; {1020196}
}

code_0F9125 {
    COP [30] ( #$00B6, &code_0F922E, #1F ) ; {1020197}
    COP [9F] ( #$0008 )   ; {1020204}
    COP [07] ( #$9F02, &code_0F913F ) ; {1020208}
    COP [15]              ; {1020214}
    COP [17] ( &code_0F9215 ) ; {1020216}
    COP [91]              ; {1020220}
    RTL                   ; {1020222}
}

code_0F913F {
    COP [11] ( #0D, #00, #C9 ) ; {1020223}
    COP [11] ( #1A, #00, #C9 ) ; {1020228}
    LDA #$FF80            ; {1020233}
    TSB $0326             ; {1020236}
    COP [03] ( #29 )      ; {1020239}
    COP [04]              ; {1020242}
    COP [01] ( &asciistring_0F9416 ) ; {1020244}
    COP [AC] ( @code_0F91AA, #$0200, #$0100, #$0050 ) ; {1020248}
    COP [05] ( #$0000 )   ; {1020259}
    COP [03] ( #29 )      ; {1020263}
    COP [04]              ; {1020266}
    COP [01] ( &asciistring_0F953B ) ; {1020268}
    COP [03] ( #79 )      ; {1020272}
    COP [04]              ; {1020275}
    COP [AC] ( @code_0F91E2, #$0200, #$0100, #$0050 ) ; {1020277}
    COP [05] ( #$0001 )   ; {1020288}
    COP [03] ( #29 )      ; {1020292}
    COP [04]              ; {1020295}
    COP [01] ( &asciistring_0F95CE ) ; {1020297}
    COP [03] ( #79 )      ; {1020301}
    COP [04]              ; {1020304}
    LDA #$0020            ; {1020306}
    STA $03B4             ; {1020309}
    COP [10] ( #$0104, #01, #$0120, #$02E0 ) ; {1020312}
    LDA #$BFC0            ; {1020321}
    TRB $0326             ; {1020324}
    COP [91]              ; {1020327}
    RTL                   ; {1020329}
}

code_0F91AA {
    COP [81] ( #0D, #04 ) ; {1020330}
    COP [83]              ; {1020334}
    COP [9F] ( #$FFF8 )   ; {1020336}
    COP [96]              ; {1020340}
    COP [81] ( #0E, #02 ) ; {1020342}
    COP [83]              ; {1020346}
    COP [9F] ( #$0008 )   ; {1020348}
    COP [97]              ; {1020352}
    COP [81] ( #0D, #06 ) ; {1020354}
    COP [83]              ; {1020358}
    COP [9F] ( #$FFF8 )   ; {1020360}
    COP [80] ( #0E )      ; {1020364}
    COP [82]              ; {1020367}
    COP [80] ( #11 )      ; {1020369}
    COP [82]              ; {1020372}
    COP [09] ( #$8000 )   ; {1020374}
    COP [91]              ; {1020378}
    COP [80] ( #11 )      ; {1020380}
    COP [82]              ; {1020383}
    RTL                   ; {1020385}
}

code_0F91E2 {
    COP [81] ( #0D, #04 ) ; {1020386}
    COP [83]              ; {1020390}
    COP [9F] ( #$FFF8 )   ; {1020392}
    COP [96]              ; {1020396}
    COP [81] ( #0E, #02 ) ; {1020398}
    COP [83]              ; {1020402}
    COP [9F] ( #$0008 )   ; {1020404}
    COP [97]              ; {1020408}
    COP [81] ( #0D, #05 ) ; {1020410}
    COP [83]              ; {1020414}
    COP [9F] ( #$FFF8 )   ; {1020416}
    COP [80] ( #11 )      ; {1020420}
    COP [82]              ; {1020423}
    COP [09] ( #$8001 )   ; {1020425}
    COP [91]              ; {1020429}
    COP [80] ( #11 )      ; {1020431}
    COP [82]              ; {1020434}
    RTL                   ; {1020436}
}

code_0F9215 {
    COP [07] ( #$9B02, &code_0F9229 ) ; {1020437}
    COP [01] ( &asciistring_0F9252 ) ; {1020443}
    BRK #$5E              ; {1020447}
    COP [0A] ( #3C )      ; {1020449}
    COP [09] ( #$9B02 )   ; {1020452}
    RTL                   ; {1020456}
}

code_0F9229 {
    COP [01] ( &asciistring_0F938C ) ; {1020457}
    RTL                   ; {1020461}
}

code_0F922E {
    LDA #$FFFF            ; {1020462}
    STA $03FB             ; {1020465}
    COP [14] ( #$00BD, &code_0F9242 ) ; {1020468}
    COP [14] ( #$0092, &code_0F9242 ) ; {1020474}
    BRA loc_0F9246        ; {1020480}
}

code_0F9242 {
    COP [01] ( &asciistring_0F9390 ) ; {1020482}

  loc_0F9246:
    COP [01] ( &asciistring_0F939F ) ; {1020486}
    COP [37]              ; {1020490}
    STZ $03FB             ; {1020492}
    COP [86]              ; {1020495}
    RTL                   ; {1020497}
}

asciistring_0F9252 |[10]I have heard about you[N]from Lue- [FIN]You are the one who [N]saved me- [FIN]Everything started [N]when I saw the jewel [N]that Lue had- [FIN]One glance at the Blue[N]Stone caused desire [N]and hatred to [N]overwhelm me- [FIN]Right after that the [N]creatures disappeared [N]and the monsters took [N]over- [FIN]Maybe because we let [N]bad feeling dominate [N]us we created the [N]monsters ourselves- [FIN]I will give you [03:24]the [N]Blue Stone- [FIN][03:20][::]Please travel to other[N]regions and release [N]all creatures- [JMP:&asciistring_0FAA44]|

asciistring_0F938C |[10][JMP:&asciistring_0F9252+M]|

asciistring_0F9390 |[10][0E:1E]Queen! [0E:3C][JMP:&asciistring_0FAA44+M]|

asciistring_0F939F |[10][0E:3C]A beautiful voice came[N]from inside the [N]palace- [FIN]I am the Mermaid [N]Queen- [FIN]I know not who you [N]are, but thank you for[N]releasing me- [FIN]Please return to the [N]palace- [JMP:&asciistring_0FAA44]|

asciistring_0F9416 |[10][0F][02:2], [N]thank you very much! [N][0E:3C]Peace has returned [N]here, to St-Elles- [N][0E:5A]The dolphin, Lue, used[N]to live with Dr-Leo- [N][0E:5A]It s strange, whenever[N]he tells me about Dr- [N]Leo and his daughter [N]Lisa- [N][0E:2D]I miss them and [N]sometimes find myself [N]crying- [N][0E:5A]Now Dr-Leo is gone, [N][0E:1E]Lisa must be very [N]lonely- [N][0E:5A]Oh, here comes Lue- He[N]must have heard your [N]voice- [N][0E:78][JMP:&asciistring_0FAA44+M]|

asciistring_0F953B |[10][0F]Phew! [N][0E:5A][02:2], [N]why did you not visit [N]me? [N][0E:5A]I decided to return to[N]my home town along [N]with my friends- [N][0E:5A]To tell you the truth,[N][0E:28]I am to be married- [N][0E:50]Hey Lala, come in [N]here! [0E:78][JMP:&asciistring_0FAA44+M]|

asciistring_0F95CE |[10][0F]Don t you think she is[N]beautiful- [N][0E:5A]We will be happy [N]together- [N][0E:5A][02:2], [N]I wish you luck- [0E:78][JMP:&asciistring_0FAA44+M]|

code_0F961C {
    COP [14] ( #$00B9, &code_0F9623 ) ; {1021468}
    RTL                   ; {1021474}
}

code_0F9623 {
    COP [30] ( #$00B9, &code_0F966C, #1F ) ; {1021475}
    COP [17] ( &code_0F9648 ) ; {1021482}
    COP [91]              ; {1021486}
    COP [0D] ( #00, #1C, #1C, &code_0F9638 ) ; {1021488}
    RTL                   ; {1021495}
}

code_0F9638 {
    COP [11] ( #00, #1C, #1E ) ; {1021496}
    COP [33]              ; {1021501}
    LDA #$AFC0            ; {1021503}
    TRB $0326             ; {1021506}
    COP [91]              ; {1021509}
    RTL                   ; {1021511}
}

code_0F9648 {
    COP [01] ( &asciistring_0F9673 ) ; {1021512}
    COP [07] ( #$8501, &code_0F966B ) ; {1021516}
    LDA #$EF80            ; {1021522}
    TSB $0326             ; {1021525}
    LDA #$0020            ; {1021528}
    STA $03B4             ; {1021531}
    COP [09] ( #$8903 )   ; {1021534}
    COP [10] ( #$0107, #02, #$0140, #$0040 ) ; {1021538}
}

code_0F966B {
    RTL                   ; {1021547}
}

code_0F966C {
    COP [01] ( &asciistring_0F8B27 ) ; {1021548}
    COP [86]              ; {1021552}
    RTL                   ; {1021554}
}

asciistring_0F9673 |[10]I will open the [N]passage for you- [FIN]Go ¦ along the [N]seabed and you will [N]find a ghost ship- [JMP:&asciistring_0FAA44]|

code_0F96B9 {
    COP [14] ( #$00BD, &code_0F96C0 ) ; {1021625}
    RTL                   ; {1021631}
}

code_0F96C0 {
    COP [07] ( #$9F02, &code_0F9704 ) ; {1021632}
    COP [85] ( @chunk_000000.code_00299D ) ; {1021638}
    COP [17] ( &code_0F9707 ) ; {1021643}
    COP [15]              ; {1021647}

  loc_0F96D1:
    COP [14] ( #$00B6, &code_0F96DF ) ; {1021649}
    COP [80] ( #08 )      ; {1021655}
    COP [82]              ; {1021658}
    BRL loc_0F96D1        ; {1021660}
}

code_0F96DF {
    COP [16]              ; {1021663}
    COP [9F] ( #$0010 )   ; {1021665}
    COP [81] ( #0A, #03 ) ; {1021669}
    COP [83]              ; {1021673}
    COP [9F] ( #$FFF0 )   ; {1021675}
    COP [97]              ; {1021679}
    COP [80] ( #08 )      ; {1021681}
    COP [82]              ; {1021684}
    COP [15]              ; {1021686}
    COP [17] ( &code_0F970C ) ; {1021688}
    COP [91]              ; {1021692}
    COP [80] ( #08 )      ; {1021694}
    COP [82]              ; {1021697}
    RTL                   ; {1021699}
}

code_0F9704 {
    COP [86]              ; {1021700}
    RTL                   ; {1021702}
}

code_0F9707 {
    COP [01] ( &asciistring_0F9711 ) ; {1021703}
    RTL                   ; {1021707}
}

code_0F970C {
    COP [01] ( &asciistring_0F976C ) ; {1021708}
    RTL                   ; {1021712}
}

asciistring_0F9711 |[10]I saw the Queen when [N]I was dreaming- [N]She looked very sad- [FIN]It was somewhere near [N]a sunken ship- [N]Please save the [N]Queen!! [JMP:&asciistring_0FAA44]|

asciistring_0F976C |[10]Thank you very much! [N]I can hardly believe [N]that she is really [N]back! [JMP:&asciistring_0FAA44]|

code_0F9793 {
    COP [3B] ( #$00C0, &code_0F97A9 ) ; {1021843}
    COP [17] ( &code_0FA95A ) ; {1021849}
    SEP #$20              ; {1021853}
    LDA #$^chunk_000000.code_00305F ; {1021855}
    PHA                   ; {1021857}
    REP #$20              ; {1021858}
    LDA #$&chunk_000000.code_00305F-1 ; {1021860}
    PHA                   ; {1021863}
    RTL                   ; {1021864}
}

code_0F97A9 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1021865}
    COP [17] ( &code_0F97E2 ) ; {1021870}
    COP [91]              ; {1021874}

  loc_0F97B4:
    COP [97]              ; {1021876}
    COP [81] ( #0B, #05 ) ; {1021878}
    COP [83]              ; {1021882}
    COP [9F] ( #$0008 )   ; {1021884}
    COP [81] ( #0A, #02 ) ; {1021888}
    COP [83]              ; {1021892}
    COP [9F] ( #$FFF8 )   ; {1021894}
    COP [96]              ; {1021898}
    COP [81] ( #0B, #05 ) ; {1021900}
    COP [83]              ; {1021904}
    COP [9F] ( #$0008 )   ; {1021906}
    COP [81] ( #09, #02 ) ; {1021910}
    COP [83]              ; {1021914}
    COP [9F] ( #$FFF8 )   ; {1021916}
    BRA loc_0F97B4        ; {1021920}
}

code_0F97E2 {
    COP [01] ( &asciistring_0F97E7 ) ; {1021922}
    RTL                   ; {1021926}
}

asciistring_0F97E7 |[10]The coral reef is home[N]to the dolphins- [FIN]The pearls made in the[N]reef are their [N]treasure- [JMP:&asciistring_0FAA44]|

code_0F982F {
    COP [3B] ( #$008E, &code_0F9845 ) ; {1021999}
    COP [17] ( &code_0FA95A ) ; {1022005}
    SEP #$20              ; {1022009}
    LDA #$^chunk_000000.code_00305F ; {1022011}
    PHA                   ; {1022013}
    REP #$20              ; {1022014}
    LDA #$&chunk_000000.code_00305F-1 ; {1022016}
    PHA                   ; {1022019}
    RTL                   ; {1022020}
}

code_0F9845 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1022021}
    COP [17] ( &code_0F9858 ) ; {1022026}
    COP [15]              ; {1022030}
    COP [91]              ; {1022032}
    COP [80] ( #06 )      ; {1022034}
    COP [82]              ; {1022037}
    RTL                   ; {1022039}
}

code_0F9858 {
    COP [18] ( #18, &code_0F985F ) ; {1022040}
    BRA loc_0F9864        ; {1022045}
}

code_0F985F {
    COP [18] ( #34, &code_0F9869 ) ; {1022047}

  loc_0F9864:
    COP [01] ( &asciistring_0F98C6 ) ; {1022052}
    RTL                   ; {1022056}
}

code_0F9869 {
    COP [01] ( &asciistring_0F9873 ) ; {1022057}
    BRK #$5E              ; {1022061}
    COP [0A] ( #34 )      ; {1022063}
    RTL                   ; {1022066}
}

asciistring_0F9873 |[10]Thank you very [N]much for releasing me![FIN]I will give you [03:24]the [N]Red+Hot Stick- [N][03:20]The Phoenix resides on[N]the Stick- [FIN][JMP:&asciistring_0F98C6+M]|

asciistring_0F98C6 |[10][::]Take the Red+Hot Stick[N]and visit the Mountain[N]King- [JMP:&asciistring_0FAA44]|

code_0F98F5 {
    COP [14] ( #$008A, &code_0F98FC ) ; {1022197}
    RTL                   ; {1022203}
}

code_0F98FC {
    COP [18] ( #24, &code_0F9903 ) ; {1022204}
    BRA code_0F997F       ; {1022209}
}

code_0F9903 {
    COP [0D] ( #00, #0A, #27, &code_0F997F ) ; {1022211}
    COP [85] ( @chunk_000000.code_00299D ) ; {1022218}
    COP [17] ( &code_0F99A2 ) ; {1022223}
    COP [15]              ; {1022227}

  code_0F9915:
    COP [80] ( #01 )      ; {1022229}
    COP [82]              ; {1022232}
    COP [07] ( #$0002, &code_0F9915 ) ; {1022234}
    COP [16]              ; {1022240}
    COP [9F] ( #$FFF8 )   ; {1022242}
    COP [80] ( #05 )      ; {1022246}
    COP [82]              ; {1022249}
    COP [9F] ( #$0008 )   ; {1022251}
    COP [81] ( #04, #02 ) ; {1022255}
    COP [83]              ; {1022259}
    COP [80] ( #00 )      ; {1022261}
    COP [82]              ; {1022264}
    COP [01] ( &asciistring_0F9A0F ) ; {1022266}
    BRK #$4E              ; {1022270}
    COP [85] ( @chunk_000000.code_00299D ) ; {1022272}
    COP [81] ( #19, #02 ) ; {1022277}
    COP [83]              ; {1022281}
    BRK #$4E              ; {1022283}
    COP [85] ( @chunk_000000.code_00299D ) ; {1022285}
    COP [80] ( #18 )      ; {1022290}
    COP [82]              ; {1022293}
    COP [01] ( &asciistring_0F9A3F ) ; {1022295}
    BRK #$4E              ; {1022299}
    COP [85] ( @chunk_000000.code_00299D ) ; {1022301}
    COP [80] ( #00 )      ; {1022306}
    COP [82]              ; {1022309}
    COP [01] ( &asciistring_0F9A6F ) ; {1022311}
    LDA #$2F80            ; {1022315}
    TRB $0326             ; {1022318}
    COP [17] ( &code_0F99D1 ) ; {1022321}
    COP [15]              ; {1022325}
    COP [91]              ; {1022327}
    COP [80] ( #00 )      ; {1022329}
    COP [82]              ; {1022332}
    RTL                   ; {1022334}
}

code_0F997F {
    COP [16]              ; {1022335}
    COP [17] ( &code_0F99D1 ) ; {1022337}
    COP [9F] ( #$FFF8 )   ; {1022341}
    COP [80] ( #05 )      ; {1022345}
    COP [82]              ; {1022348}
    COP [9F] ( #$0008 )   ; {1022350}
    COP [81] ( #04, #02 ) ; {1022354}
    COP [83]              ; {1022358}
    COP [15]              ; {1022360}
    COP [91]              ; {1022362}
    COP [80] ( #00 )      ; {1022364}
    COP [82]              ; {1022367}
    RTL                   ; {1022369}
}

code_0F99A2 {
    COP [01] ( &asciistring_0F99E0 ) ; {1022370}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_0F99B6 ) ; {1022374}
    LDA $0003D0           ; {1022381}
    BNE code_0F99B6       ; {1022385}
    BRL loc_0F99C9        ; {1022387}
}

code_0F99B6 {
    COP [01] ( &asciistring_0F9A00 ) ; {1022390}
    COP [17] ( #$0000 )   ; {1022394}
    COP [09] ( #$8002 )   ; {1022398}
    LDA #$2F80            ; {1022402}
    TSB $0326             ; {1022405}
    RTL                   ; {1022408}

  loc_0F99C9:
    COP [01] ( &asciistring_0F9AA7 ) ; {1022409}
    COP [27] ( &code_0F997F ) ; {1022413}
}

code_0F99D1 {
    COP [18] ( #24, &code_0F99DB ) ; {1022417}
    COP [01] ( &asciistring_0F9AAB ) ; {1022422}
    RTL                   ; {1022426}
}

code_0F99DB {
    COP [01] ( &asciistring_0F9AA7 ) ; {1022427}
    RTL                   ; {1022431}
}

asciistring_0F99E0 |[10]Have you seen the [N]Queen of the Mermaids?[END]|

asciistring_0F9A00 |Okay, wait- [JMP:&asciistring_0FAA44]|

asciistring_0F9A0F |[10][0A]This█is█a█secret,█the[N]Queen█looks█like█this-[FIN][END]|

asciistring_0F9A3F |[0A]She█always█sits█like[N]this-[N]She█looks█so█mean-[FIN][END]|

asciistring_0F9A6F |[0A]Lue,█the█dolphin█has[N]been█captured![N]Please█save█him![JMP:&asciistring_0FAA44]|

asciistring_0F9AA7 |[10][JMP:&asciistring_0F9A6F]|

asciistring_0F9AAB |[10]Lue can leave whenever[N]he wishes, but he [N]never comes out- [FIN]Maybe he likes that [N]place- [JMP:&asciistring_0FAA44]|

code_0F9AFD {
    COP [14] ( #$00BB, &code_0F9B04 ) ; {1022717}
    RTL                   ; {1022723}
}

code_0F9B04 {
    COP [85] ( @chunk_000000.code_00299D ) ; {1022724}
    COP [15]              ; {1022729}
    COP [17] ( &code_0F9B17 ) ; {1022731}

  loc_0F9B0F:
    COP [80] ( #11 )      ; {1022735}
    COP [82]              ; {1022738}
    BRL loc_0F9B0F        ; {1022740}
}

code_0F9B17 {
    COP [07] ( #$8506, &code_0F9B38 ) ; {1022743}
    COP [19] ( #1C, &code_0F9B33 ) ; {1022749}
    COP [01] ( &asciistring_0F9B47 ) ; {1022754}
    COP [3C] ( #04 )      ; {1022758}
    COP [10] ( #$0407, #00, #$0050, #$0200 ) ; {1022761}
    RTL                   ; {1022770}
}

code_0F9B33 {
    COP [01] ( &asciistring_0F9B3D ) ; {1022771}
    RTL                   ; {1022775}
}

code_0F9B38 {
    COP [01] ( &asciistring_0F9B69 ) ; {1022776}
    RTL                   ; {1022780}
}

asciistring_0F9B3D |[10]Zzzzz [JMP:&asciistring_0FAA44]|

asciistring_0F9B47 |[10][02:2] touches [N]the dolphin with the [N]Dream Rod- [JMP:&asciistring_0FAA44]|

asciistring_0F9B69 |[10]Hey, didn t I meet you[N]in my dream? [JMP:&asciistring_0FAA44]|

code_0F9B8B {
    COP [14] ( #$008F, &code_0F9B92 ) ; {1022859}
    RTL                   ; {1022865}
}

code_0F9B92 {
    COP [30] ( #$008F, &code_0F9BED, #1F ) ; {1022866}
    COP [85] ( @chunk_000000.code_00299D ) ; {1022873}
    COP [17] ( &code_0F9BB5 ) ; {1022878}

  loc_0F9BA2:
    COP [96]              ; {1022882}
    COP [81] ( #0E, #04 ) ; {1022884}
    COP [83]              ; {1022888}
    COP [97]              ; {1022890}
    COP [81] ( #0E, #04 ) ; {1022892}
    COP [83]              ; {1022896}
    BRL loc_0F9BA2        ; {1022898}
}

code_0F9BB5 {
    COP [18] ( #24, &code_0F9BD1 ) ; {1022901}
    LDA $0016, X          ; {1022906}
    AND #$FFEF            ; {1022909}
    STA $0016, X          ; {1022912}
    COP [01] ( &asciistring_0F9D86 ) ; {1022915}
    LDA $0016, X          ; {1022919}
    ORA #$0010            ; {1022922}
    STA $0016, X          ; {1022925}
    RTL                   ; {1022928}
}

code_0F9BD1 {
    LDA $0016, X          ; {1022929}
    AND #$FFEF            ; {1022932}
    STA $0016, X          ; {1022935}
    COP [01] ( &asciistring_0F9C12 ) ; {1022938}
    LDA $0016, X          ; {1022942}
    ORA #$0010            ; {1022945}
    STA $0016, X          ; {1022948}
    BRK #$5E              ; {1022951}
    COP [0A] ( #24 )      ; {1022953}
    RTL                   ; {1022956}
}

code_0F9BED {
    COP [14] ( #$008C, &code_0F9BF7 ) ; {1022957}
    COP [01] ( &asciistring_0F9BFA ) ; {1022963}
}

code_0F9BF7 {
    COP [86]              ; {1022967}
    RTL                   ; {1022969}
}

asciistring_0F9BFA |[10][0E:3C]Hey, somebody help me![JMP:&asciistring_0FAA44]|

asciistring_0F9C12 |[10]My name is Lue- [N]I used to live with [N]the inventor, Dr-Leo-[FIN]The Blue Stone I [N]received from him is [N]a strange jewel- [FIN]It attracts anyone who[N]looks at it and then [N]changes their [N]personality- [FIN]If that person has a [N]good mind, they will [N]become a great person-[FIN]If they have a evil [N]mind, they will become[N]a bad person- [FIN]One day, the Queen [N]found the jewel and [N]took it- Then she [N]placed me in prison- [FIN]Please save the Queen [N]and get the Blue Stone[N]back- [FIN]I know this ring will [N]help please take it- [FIN][02:2] received [N][03:24]the Thunder Ring- [03:20][JMP:&asciistring_0FAA44]|

asciistring_0F9D86 |[10]I heard that Dr-Leo [N]was taken to the [N]Magridd Castle- [N]I wonder how he is- [JMP:&asciistring_0FAA44]|

code_0F9DBE {
    COP [14] ( #$008C, &code_0F9DC5 ) ; {1023422}
    RTL                   ; {1023428}
}

code_0F9DC5 {
    COP [30] ( #$008C, &code_0F9E32, #1F ) ; {1023429}
    COP [85] ( @chunk_000000.code_00299D ) ; {1023436}
    COP [1B] ( &code_0F9DD7, #$0002 ) ; {1023441}
}

code_0F9DD7 {
    COP [07] ( #$0000, &code_0F9E0D ) ; {1023447}
    LDA #$FFFF            ; {1023453}
    STA $03FB             ; {1023456}
    COP [09] ( #$8601 )   ; {1023459}
    COP [81] ( #0E, #09 ) ; {1023463}
    COP [83]              ; {1023467}
    COP [81] ( #0C, #03 ) ; {1023469}
    COP [83]              ; {1023473}
    COP [80] ( #17 )      ; {1023475}
    COP [82]              ; {1023478}
    BRK #$4A              ; {1023480}
    COP [80] ( #17 )      ; {1023482}
    COP [82]              ; {1023485}
    BRK #$4A              ; {1023487}
    STZ $03FB             ; {1023489}

  loc_0F9E04:
    COP [80] ( #17 )      ; {1023492}
    COP [82]              ; {1023495}
    BRK #$4A              ; {1023497}
    BRA loc_0F9E04        ; {1023499}
}

code_0F9E0D {
    COP [11] ( #04, #12, #0B ) ; {1023501}
    COP [97]              ; {1023506}
    COP [15]              ; {1023508}
    COP [17] ( &code_0F9E22 ) ; {1023510}
    COP [91]              ; {1023514}
    COP [80] ( #11 )      ; {1023516}
    COP [82]              ; {1023519}
    RTL                   ; {1023521}
}

code_0F9E22 {
    COP [14] ( #$008F, &code_0F9E2D ) ; {1023522}
    COP [01] ( &asciistring_0F9E55 ) ; {1023528}
    RTL                   ; {1023532}
}

code_0F9E2D {
    COP [01] ( &asciistring_0F9E7D ) ; {1023533}
    RTL                   ; {1023537}
}

code_0F9E32 {
    COP [09] ( #$8000 )   ; {1023538}
    COP [01] ( &asciistring_0F9E3D ) ; {1023542}
    COP [86]              ; {1023546}
    RTL                   ; {1023548}
}

asciistring_0F9E3D |[10][0E:1E]Lue! I m coming! [0E:28][JMP:&asciistring_0FAA44+M]|

asciistring_0F9E55 |[10]I tried hard to save [N]Lue but he is not [N]here- [JMP:&asciistring_0FAA44]|

asciistring_0F9E7D |[10]Lue told me many [N]things about the [N]Queen- [FIN]I don t think she was [N]a bad person- She was [N]just attracted to the [N]jewel- [JMP:&asciistring_0FAA44]|

code_0F9ED4 {
    COP [07] ( #$8406, &code_0F9EE6 ) ; {1023700}
    COP [15]              ; {1023706}
    COP [91]              ; {1023708}
    COP [0D] ( #00, #5B, #24, &code_0F9EF0 ) ; {1023710}
    RTL                   ; {1023717}
}

code_0F9EE6 {
    COP [80] ( #26 )      ; {1023718}
    COP [82]              ; {1023721}
    COP [16]              ; {1023723}
    COP [91]              ; {1023725}
    RTL                   ; {1023727}
}

code_0F9EF0 {
    LDA #$EF80            ; {1023728}
    TSB $0326             ; {1023731}
    COP [34]              ; {1023734}
    COP [1B] ( &code_0F9EFE, #$0078 ) ; {1023736}
}

code_0F9EFE {
    BRK #$9C              ; {1023742}
    COP [81] ( #26, #10 ) ; {1023744}
    COP [83]              ; {1023748}
    COP [81] ( #27, #08 ) ; {1023750}
    COP [83]              ; {1023754}
    COP [1B] ( &code_0F9F12, #$005A ) ; {1023756}
}

code_0F9F12 {
    COP [09] ( #$8406 )   ; {1023762}
    COP [09] ( #$0903 )   ; {1023766}
    COP [10] ( #$0106, #01, #$0220, #$0220 ) ; {1023770}
    RTL                   ; {1023779}
}

code_0F9F24 {
    COP [07] ( #$8407, &code_0F9F36 ) ; {1023780}
    COP [15]              ; {1023786}
    COP [91]              ; {1023788}
    COP [0D] ( #00, #6A, #04, &code_0F9F40 ) ; {1023790}
    RTL                   ; {1023797}
}

code_0F9F36 {
    COP [80] ( #26 )      ; {1023798}
    COP [82]              ; {1023801}
    COP [16]              ; {1023803}
    COP [91]              ; {1023805}
    RTL                   ; {1023807}
}

code_0F9F40 {
    LDA #$EF80            ; {1023808}
    TSB $0326             ; {1023811}
    COP [34]              ; {1023814}
    COP [1B] ( &code_0F9F4E, #$0078 ) ; {1023816}
}

code_0F9F4E {
    BRK #$9C              ; {1023822}
    COP [81] ( #26, #10 ) ; {1023824}
    COP [83]              ; {1023828}
    COP [81] ( #27, #08 ) ; {1023830}
    COP [83]              ; {1023834}
    COP [1B] ( &code_0F9F62, #$005A ) ; {1023836}
}

code_0F9F62 {
    COP [09] ( #$8407 )   ; {1023842}
    COP [09] ( #$0903 )   ; {1023846}
    COP [10] ( #$0106, #01, #$0220, #$01C0 ) ; {1023850}
    RTL                   ; {1023859}
}

code_0F9F74 {
    COP [07] ( #$8500, &code_0F9F86 ) ; {1023860}
    COP [15]              ; {1023866}
    COP [91]              ; {1023868}
    COP [0D] ( #00, #24, #2B, &code_0F9F90 ) ; {1023870}
    RTL                   ; {1023877}
}

code_0F9F86 {
    COP [80] ( #26 )      ; {1023878}
    COP [82]              ; {1023881}
    COP [16]              ; {1023883}
    COP [91]              ; {1023885}
    RTL                   ; {1023887}
}

code_0F9F90 {
    LDA #$EF80            ; {1023888}
    TSB $0326             ; {1023891}
    COP [34]              ; {1023894}
    COP [1B] ( &code_0F9F9E, #$0078 ) ; {1023896}
}

code_0F9F9E {
    BRK #$9C              ; {1023902}
    COP [81] ( #26, #10 ) ; {1023904}
    COP [83]              ; {1023908}
    COP [81] ( #27, #08 ) ; {1023910}
    COP [83]              ; {1023914}
    COP [1B] ( &code_0F9FB2, #$005A ) ; {1023916}
}

code_0F9FB2 {
    COP [09] ( #$8500 )   ; {1023922}
    COP [09] ( #$0903 )   ; {1023926}
    COP [10] ( #$0106, #01, #$01C0, #$0220 ) ; {1023930}
    RTL                   ; {1023939}
}

code_0F9FC4 {
    COP [07] ( #$8501, &code_0F9FD6 ) ; {1023940}
    COP [15]              ; {1023946}
    COP [91]              ; {1023948}
    COP [0D] ( #00, #14, #04, &code_0F9FE0 ) ; {1023950}
    RTL                   ; {1023957}
}

code_0F9FD6 {
    COP [80] ( #26 )      ; {1023958}
    COP [82]              ; {1023961}
    COP [16]              ; {1023963}
    COP [91]              ; {1023965}
    RTL                   ; {1023967}
}

code_0F9FE0 {
    LDA #$EF80            ; {1023968}
    TSB $0326             ; {1023971}
    COP [34]              ; {1023974}
    COP [1B] ( &code_0F9FEE, #$0078 ) ; {1023976}
}

code_0F9FEE {
    BRK #$9C              ; {1023982}
    COP [81] ( #26, #10 ) ; {1023984}
    COP [83]              ; {1023988}
    COP [81] ( #27, #08 ) ; {1023990}
    COP [83]              ; {1023994}
    COP [1B] ( &code_0FA002, #$005A ) ; {1023996}
}

code_0FA002 {
    COP [09] ( #$8501 )   ; {1024002}
    COP [09] ( #$0903 )   ; {1024006}
    COP [10] ( #$0106, #01, #$01C0, #$01C0 ) ; {1024010}
    RTL                   ; {1024019}
}

code_0FA014 {
    COP [14] ( #$00B6, &code_0FA02E ) ; {1024020}
    COP [14] ( #$009D, &code_0FA027 ) ; {1024026}
    COP [17] ( &code_0FA031 ) ; {1024032}
    COP [91]              ; {1024036}
    RTL                   ; {1024038}
}

code_0FA027 {
    COP [17] ( &code_0FA03A ) ; {1024039}
    COP [91]              ; {1024043}
    RTL                   ; {1024045}
}

code_0FA02E {
    COP [86]              ; {1024046}
    RTL                   ; {1024048}
}

code_0FA031 {
    COP [01] ( &asciistring_0FA03F ) ; {1024049}
    COP [09] ( #$8502 )   ; {1024053}
    RTL                   ; {1024057}
}

code_0FA03A {
    COP [01] ( &asciistring_0FA0D3 ) ; {1024058}
    RTL                   ; {1024062}
}

asciistring_0FA03F |[10][02:2] heard [N]a small voice- [FIN]This is St-Elles [N]Palace in the ocean- [FIN]No human can live [N]under the sea- [FIN]Go to the island, [N]Southerta, through the[N]shrine and look for [N]the Bubble Clothing- [JMP:&asciistring_0FAA44]|

asciistring_0FA0D3 |[10]Listen closely to the [N]advice of the 4 [N]mermaid statues- [JMP:&asciistring_0FAA44]|

code_0FA106 {
    COP [17] ( &code_0FA159 ) ; {1024262}
    COP [15]              ; {1024266}

  code_0FA10C:
    COP [80] ( #10 )      ; {1024268}
    COP [82]              ; {1024271}
    COP [07] ( #$0506, &code_0FA10C ) ; {1024273}
    COP [16]              ; {1024279}
    LDA #$2F80            ; {1024281}
    TSB $0326             ; {1024284}
    COP [81] ( #0D, #04 ) ; {1024287}
    COP [83]              ; {1024291}
    LDA #$2F80            ; {1024293}
    TRB $0326             ; {1024296}
    COP [15]              ; {1024299}

  loc_0FA12D:
    COP [14] ( #$0079, &code_0FA13A ) ; {1024301}
    COP [80] ( #10 )      ; {1024307}
    COP [82]              ; {1024310}
    BRA loc_0FA12D        ; {1024312}
}

code_0FA13A {
    LDA #$2F80            ; {1024314}
    TSB $0326             ; {1024317}
    COP [81] ( #10, #02 ) ; {1024320}
    COP [83]              ; {1024324}
    LDA #$2F80            ; {1024326}
    TRB $0326             ; {1024329}
    COP [3C] ( #04 )      ; {1024332}
    COP [10] ( #$0307, #02, #$0040, #$0080 ) ; {1024335}
    RTL                   ; {1024344}
}

code_0FA159 {
    COP [19] ( #20, &code_0FA16E ) ; {1024345}
    COP [01] ( &asciistring_0FA1E9 ) ; {1024350}
    COP [0B] ( #20 )      ; {1024354}
    COP [17] ( &code_0FA17F ) ; {1024357}
    COP [09] ( #$8506 )   ; {1024361}
    RTL                   ; {1024365}
}

code_0FA16E {
    COP [01] ( &asciistring_0FA184 ) ; {1024366}
    COP [3C] ( #04 )      ; {1024370}
    COP [10] ( #$0307, #00, #$0040, #$0070 ) ; {1024373}
    RTL                   ; {1024382}
}

code_0FA17F {
    COP [01] ( &asciistring_0FA237 ) ; {1024383}
    RTL                   ; {1024387}
}

asciistring_0FA184 |[10]I used to live [N]here- [FIN]I am trying to [N]remember something but[N]I cannot- [FIN]When I close my eyes, [N]I see something like [N]a ball, shiny and [N]black---- [JMP:&asciistring_0FAA44]|

asciistring_0FA1E9 |[10]That Pearl! [FIN]Yes, I was going to [N]present that Pearl- [FIN][::]This is the Coral [N]Reef- I have missed [N]this place- [JMP:&asciistring_0FAA44]|

asciistring_0FA237 |[10][JMP:&asciistring_0FA1E9+M]|

code_0FA23B {
    COP [17] ( &code_0FA252 ) ; {1024571}
    COP [15]              ; {1024575}
    COP [91]              ; {1024577}
    COP [0D] ( #00, #04, #29, &code_0FA24B ) ; {1024579}
    RTL                   ; {1024586}
}

code_0FA24B {
    COP [01] ( &asciistring_0FA25B ) ; {1024587}
    COP [91]              ; {1024591}
    RTL                   ; {1024593}
}

code_0FA252 {
    COP [01] ( &asciistring_0FA369 ) ; {1024594}
    COP [09] ( #$8000 )   ; {1024598}
    RTL                   ; {1024602}
}

asciistring_0FA25B |[10][0F]You can hear the [N]conversation of [FIN]a father and son- [FIN][10]Daddy, how many days [N]have passed since the [N]ship sank? [FIN]I am too hungry and [N]cannot travel any [N]farther- [FIN]Are we going to die? [FIN]Servas, my son, some [N]people believe that [N]human life does not [N]end at death- [FIN]They believe that they[N]will be born into a [N]new life- Lives, they [N]feel, are everlasting-[JMP:&asciistring_0FAA44]|

asciistring_0FA369 |[10]Oh, I hear some [N]voices----- maybe the [N]Master is calling me- [JMP:&asciistring_0FAA44]|

code_0FA3A5 {
    COP [17] ( &code_0FA3AE ) ; {1024933}
    COP [15]              ; {1024937}
    COP [91]              ; {1024939}
    RTL                   ; {1024941}
}

code_0FA3AE {
    COP [07] ( #$0000, &code_0FA3C9 ) ; {1024942}
    COP [01] ( &asciistring_0FA3DB ) ; {1024948}
    COP [3C] ( #04 )      ; {1024952}
    COP [10] ( #$0106, #03, #$00C0, #$0040 ) ; {1024955}
    COP [09] ( #$8704 )   ; {1024964}
    RTL                   ; {1024968}
}

code_0FA3C9 {
    COP [01] ( &asciistring_0FA3CE ) ; {1024969}
    RTL                   ; {1024973}
}

asciistring_0FA3CE |[10]-------- [JMP:&asciistring_0FAA44]|

asciistring_0FA3DB |[10]Someone is calling me-[N]What is that? [FIN]I just put one GEM in [N]a treasure chest- [FIN]I hope someone will [N]find it- [FIN]-------- [JMP:&asciistring_0FAA44]|

code_0FA440 {
    COP [14] ( #$00A6, &code_0FA447 ) ; {1025088}
    RTL                   ; {1025094}
}

code_0FA447 {
    JSL $@chunk_018000.code_01B161 ; {1025095}
    COP [17] ( &code_0FA45B ) ; {1025099}
    SEP #$20              ; {1025103}
    LDA #$^code_0FA945    ; {1025105}
    PHA                   ; {1025107}
    REP #$20              ; {1025108}
    LDA #$&code_0FA945-1  ; {1025110}
    PHA                   ; {1025113}
    RTL                   ; {1025114}
}

code_0FA45B {
    COP [07] ( #$9D00, &code_0FA46D ) ; {1025115}
    COP [01] ( &asciistring_0FA9C5 ) ; {1025121}
    COP [38] ( #$0200 )   ; {1025125}
    COP [09] ( #$9D00 )   ; {1025129}
}

code_0FA46D {
    COP [01] ( &asciistring_0FA9F0 ) ; {1025133}
    COP [1A] ( &chunk_010000.asciistring_014F5B, #02, &code_0FA48F ) ; {1025137}
    LDA $0003D0           ; {1025144}
    BEQ code_0FA48F       ; {1025148}
    COP [01] ( &asciistring_0FAA15 ) ; {1025150}
    INC $042D             ; {1025154}
    COP [10] ( #$0106, #00, #$01F8, #$0200 ) ; {1025157}
    RTL                   ; {1025166}
}

code_0FA48F {
    COP [01] ( &asciistring_0FAA29 ) ; {1025167}
    RTL                   ; {1025171}
}

code_0FA494 {
    COP [14] ( #$007F, &code_0FA49B ) ; {1025172}
    RTL                   ; {1025178}
}

code_0FA49B {
    JSL $@chunk_018000.code_01B161 ; {1025179}
    COP [17] ( &code_0FA4AF ) ; {1025183}
    SEP #$20              ; {1025187}
    LDA #$^code_0FA945    ; {1025189}
    PHA                   ; {1025191}
    REP #$20              ; {1025192}
    LDA #$&code_0FA945-1  ; {1025194}
    PHA                   ; {1025197}
    RTL                   ; {1025198}
}

code_0FA4AF {
    COP [07] ( #$9D06, &code_0FA46D ) ; {1025199}
    COP [01] ( &asciistring_0FA9C5 ) ; {1025205}
    COP [38] ( #$0300 )   ; {1025209}
    COP [09] ( #$9D06 )   ; {1025213}
    BRL code_0FA46D       ; {1025217}
}

code_0FA4C4 {
    COP [14] ( #$007A, &code_0FA4CB ) ; {1025220}
    RTL                   ; {1025226}
}

code_0FA4CB {
    JSL $@chunk_018000.code_01B161 ; {1025227}
    COP [17] ( &code_0FA4DF ) ; {1025231}
    SEP #$20              ; {1025235}
    LDA #$^code_0FA945    ; {1025237}
    PHA                   ; {1025239}
    REP #$20              ; {1025240}
    LDA #$&code_0FA945-1  ; {1025242}
    PHA                   ; {1025245}
    RTL                   ; {1025246}
}

code_0FA4DF {
    COP [07] ( #$9D07, &code_0FA46D ) ; {1025247}
    COP [01] ( &asciistring_0FA9C5 ) ; {1025253}
    COP [38] ( #$0250 )   ; {1025257}
    COP [09] ( #$9D07 )   ; {1025261}
    BRL code_0FA46D       ; {1025265}
}

code_0FA4F4 {
    COP [14] ( #$00B8, &code_0FA4FB ) ; {1025268}
    RTL                   ; {1025274}
}

code_0FA4FB {
    JSL $@chunk_018000.code_01B161 ; {1025275}
    COP [17] ( &code_0FA50F ) ; {1025279}
    SEP #$20              ; {1025283}
    LDA #$^code_0FA945    ; {1025285}
    PHA                   ; {1025287}
    REP #$20              ; {1025288}
    LDA #$&code_0FA945-1  ; {1025290}
    PHA                   ; {1025293}
    RTL                   ; {1025294}
}

code_0FA50F {
    COP [01] ( &asciistring_0FA516 ) ; {1025295}
    BRL code_0FA46D       ; {1025299}
}

asciistring_0FA516 |[10]The monuments on this [N]island are lightning [N]pyramids- [FIN]If you wear the [N]Thunder Ring and touch[N]them, [FIN]the Master will send [N]down lightning to [N]destroy the monsters- [FIN][END]|

code_0FA59C {
    SEP #$20              ; {1025436}
    LDY #$&unk16_0FA5AE   ; {1025438}
    STY $03D8             ; {1025441}
    LDA #$^unk16_0FA5AE   ; {1025444}
    STA $03DA             ; {1025446}
    REP #$20              ; {1025449}
    COP [86]              ; {1025451}
    RTL                   ; {1025453}
}
---------------------------------------------

unk16_0FA5AE [
  unk16 < #32, #7B, #0B, #16, #$FFFC, #$0000 >   ;00
  unk16 < #7B, #7D, #0E, #16, #$FFFC, #$0000 >   ;01
]
---------------------------------------------

code_0FA5BF {
    COP [07] ( #$8503, &code_0FA5D3 ) ; {1025471}
    LDA #$0047            ; {1025477}
    JSL $@chunk_0270E4.code_027462 ; {1025480}
    BCS loc_0FA5CF        ; {1025484}
    RTL                   ; {1025486}

  loc_0FA5CF:
    COP [39] ( #04 )      ; {1025487}
    RTL                   ; {1025490}
}

code_0FA5D3 {
    COP [86]              ; {1025491}
    RTL                   ; {1025493}
}

code_0FA5D6 {
    COP [07] ( #$8503, &code_0FA5F7 ) ; {1025494}
    COP [B0] ( @code_0FA5FA, #$2240 ) ; {1025500}

  code_0FA5E3:
    COP [92] ( #19 )      ; {1025507}
    COP [94]              ; {1025510}
    COP [07] ( #$0503, &code_0FA5E3 ) ; {1025512}
    COP [05] ( #$0001 )   ; {1025518}
    COP [92] ( #39 )      ; {1025522}
    COP [94]              ; {1025525}
}

code_0FA5F7 {
    COP [86]              ; {1025527}
    RTL                   ; {1025529}
}

code_0FA5FA {
    LDA $0016, X          ; {1025530}
    AND #$FFEF            ; {1025533}
    STA $0016, X          ; {1025536}
    COP [91]              ; {1025539}
    COP [0D] ( #00, #1F, #21, &code_0FA60D ) ; {1025541}

  code_0FA60C:
    RTL                   ; {1025548}
}

code_0FA60D {
    COP [19] ( #21, &code_0FA60C ) ; {1025549}
    COP [09] ( #$8503 )   ; {1025554}
    COP [0B] ( #21 )      ; {1025558}
    COP [01] ( &asciistring_0FA626 ) ; {1025561}
    BRK #$86              ; {1025565}
    COP [09] ( #$8001 )   ; {1025567}
    COP [86]              ; {1025571}
    RTL                   ; {1025573}
}

asciistring_0FA626 |[10][02:2] poured [N]out the mermaid s [N]tears- [JMP:&asciistring_0FAA44]|

code_0FA64B {
    COP [91]              ; {1025611}
    COP [07] ( #$8903, &code_0FA6A6 ) ; {1025613}
    COP [19] ( #0B, &code_0FA697 ) ; {1025619}
    COP [B0] ( @code_0FA6A9, #$0310 ) ; {1025624}
    COP [91]              ; {1025631}
    COP [19] ( #0B, &code_0FA68A ) ; {1025633}
    LDY $003E, X          ; {1025638}
    LDA $0374             ; {1025641}
    STA $0000, Y          ; {1025644}
    LDA $0376             ; {1025647}
    SEC                   ; {1025650}
    SBC #$0004            ; {1025651}
    STA $0002, Y          ; {1025654}
    LDA $0312             ; {1025657}
    AND #$00FF            ; {1025660}
    BEQ loc_0FA682        ; {1025663}
    RTL                   ; {1025665}

  loc_0FA682:
    COP [AF] ( @code_0FA6CB, #$2040 ) ; {1025666}
    RTL                   ; {1025673}
}

code_0FA68A {
    LDY $003E, X          ; {1025674}
    LDA #$0000            ; {1025677}
    STA $0014, Y          ; {1025680}
    COP [27] ( &code_0FA64B ) ; {1025683}
}

code_0FA697 {
    LDA $0312             ; {1025687}
    AND #$003F            ; {1025690}
    BNE loc_0FA6A2        ; {1025693}
    COP [39] ( #01 )      ; {1025695}

  loc_0FA6A2:
    COP [27] ( &code_0FA64B ) ; {1025698}
}

code_0FA6A6 {
    COP [91]              ; {1025702}
    RTL                   ; {1025704}
}

code_0FA6A9 {
    COP [A3]              ; {1025705}
    COP [A2] ( #30 )      ; {1025707}
    LDA #$0024            ; {1025710}
    STA $001E, X          ; {1025713}
    STZ $0020, X          ; {1025716}
    JSL $@chunk_000000.code_0008F3 ; {1025719}
    COP [A3]              ; {1025723}
    COP [91]              ; {1025725}

  loc_0FA6BF:
    COP [19] ( #0B, &code_0FA6C8 ) ; {1025727}
    COP [82]              ; {1025732}
    BRA loc_0FA6BF        ; {1025734}
}

code_0FA6C8 {
    COP [86]              ; {1025736}
    RTL                   ; {1025738}
}

code_0FA6CB {
    COP [A3]              ; {1025739}
    COP [A2] ( #30 )      ; {1025741}
    LDA $0374             ; {1025744}
    CLC                   ; {1025747}
    ADC #$0004            ; {1025748}
    STA $0000, X          ; {1025751}
    LDA $0376             ; {1025754}
    SEC                   ; {1025757}
    SBC #$0010            ; {1025758}
    STA $0002, X          ; {1025761}
    LDA $0016, X          ; {1025764}
    AND #$DFFF            ; {1025767}
    STA $0016, X          ; {1025770}
    COP [80] ( #22 )      ; {1025773}
    COP [82]              ; {1025776}
    COP [86]              ; {1025778}
    RTL                   ; {1025780}
}

code_0FA6F5 {
    COP [85] ( @code_0FA78C ) ; {1025781}
    COP [85] ( @code_0FA777 ) ; {1025786}
    COP [91]              ; {1025791}
    LDA $03A6             ; {1025793}
    BNE loc_0FA717        ; {1025796}
    LDY $039C             ; {1025798}
    LDA $0004, Y          ; {1025801}
    BMI loc_0FA726        ; {1025804}
    BNE loc_0FA72B        ; {1025806}
    LDA $0006, Y          ; {1025808}
    BMI loc_0FA721        ; {1025811}
    BNE loc_0FA71C        ; {1025813}

  loc_0FA717:
    LDA #$0020            ; {1025815}
    BRA loc_0FA72E        ; {1025818}

  loc_0FA71C:
    LDA #$0022            ; {1025820}
    BRA loc_0FA72E        ; {1025823}

  loc_0FA721:
    LDA #$0024            ; {1025825}
    BRA loc_0FA72E        ; {1025828}

  loc_0FA726:
    LDA #$0026            ; {1025830}
    BRA loc_0FA72E        ; {1025833}

  loc_0FA72B:
    LDA #$0028            ; {1025835}

  loc_0FA72E:
    STA $00               ; {1025838}
    LDY $003E, X          ; {1025840}
    PHX                   ; {1025843}
    LDX $039C             ; {1025844}
    LDA $0000, X          ; {1025847}
    STA $0000, Y          ; {1025850}
    LDA $0002, X          ; {1025853}
    INC                   ; {1025856}
    STA $0002, Y          ; {1025857}
    LDA $00               ; {1025860}
    CMP $001E, Y          ; {1025862}
    BEQ loc_0FA754        ; {1025865}
    STA $001E, Y          ; {1025867}
    LDA #$0000            ; {1025870}
    STA $0014, Y          ; {1025873}

  loc_0FA754:
    LDA $003E, Y          ; {1025876}
    TAY                   ; {1025879}
    LDA $0000, X          ; {1025880}
    STA $0000, Y          ; {1025883}
    LDA $0002, X          ; {1025886}
    STA $0002, Y          ; {1025889}
    PLX                   ; {1025892}
    LDA $00               ; {1025893}
    INC                   ; {1025895}
    CMP $001E, Y          ; {1025896}
    BEQ loc_0FA776        ; {1025899}
    STA $001E, Y          ; {1025901}
    LDA #$0000            ; {1025904}
    STA $0014, Y          ; {1025907}

  loc_0FA776:
    RTL                   ; {1025910}
}

code_0FA777 {
    LDA #$0310            ; {1025911}
    STA $0016, X          ; {1025914}
    LDA #$0020            ; {1025917}
    STA $001E, X          ; {1025920}
    STZ $0020, X          ; {1025923}
    COP [91]              ; {1025926}

  loc_0FA788:
    COP [82]              ; {1025928}
    BRA loc_0FA788        ; {1025930}
}

code_0FA78C {
    LDA #$0310            ; {1025932}
    STA $0016, X          ; {1025935}
    LDA #$0021            ; {1025938}
    STA $001E, X          ; {1025941}
    STZ $0020, X          ; {1025944}
    COP [91]              ; {1025947}

  loc_0FA79D:
    COP [82]              ; {1025949}
    BRA loc_0FA79D        ; {1025951}
}

code_0FA7A1 {
    LDA $0000, X          ; {1025953}
    CLC                   ; {1025956}
    ADC #$0002            ; {1025957}
    CLC                   ; {1025960}
    ADC $0382             ; {1025961}
    STA $0000, X          ; {1025964}
    STA $033E             ; {1025967}
    LDA $0002, X          ; {1025970}
    SEC                   ; {1025973}
    SBC #$0006            ; {1025974}
    CLC                   ; {1025977}
    ADC $0384             ; {1025978}
    STA $0002, X          ; {1025981}
    STA $0340             ; {1025984}
    RTL                   ; {1025987}
}

code_0FA7C4 {
    PHX                   ; {1025988}
    LDX #$0000            ; {1025989}

  loc_0FA7C8:
    LDA #$0090            ; {1025992}
    STA $7E7000, X        ; {1025995}
    LDA #$7100            ; {1025999}
    STA $7E7001, X        ; {1026002}
    INX                   ; {1026006}
    INX                   ; {1026007}
    INX                   ; {1026008}
    CPX #$002A            ; {1026009}
    BNE loc_0FA7C8        ; {1026012}
    LDA #$0000            ; {1026014}
    STA $7E7000, X        ; {1026017}
    PLX                   ; {1026021}
    COP [91]              ; {1026022}
    PHX                   ; {1026024}
    LDA $033A             ; {1026025}
    LSR                   ; {1026028}
    STA $00               ; {1026029}
    LDA $033C             ; {1026031}
    LSR                   ; {1026034}
    STA $02               ; {1026035}
    LDA $0312             ; {1026037}
    LSR                   ; {1026040}
    LSR                   ; {1026041}
    CLC                   ; {1026042}
    ADC $02               ; {1026043}
    AND #$000F            ; {1026045}
    ASL                   ; {1026048}
    TAX                   ; {1026049}
    LDY #$0000            ; {1026050}
    SEP #$20              ; {1026053}
    PHB                   ; {1026055}
    LDA #$7E              ; {1026056}
    PHA                   ; {1026058}
    PLB                   ; {1026059}
    REP #$20              ; {1026060}

  loc_0FA80E:
    LDA $@word_0FA834, X  ; {1026062}
    CLC                   ; {1026066}
    ADC $00               ; {1026067}
    STA $7100, Y          ; {1026069}
    INX                   ; {1026072}
    INX                   ; {1026073}
    INY                   ; {1026074}
    INY                   ; {1026075}
    CPY #$0020            ; {1026076}
    BNE loc_0FA80E        ; {1026079}
    PLB                   ; {1026081}
    SEP #$20              ; {1026082}
    LDA #$0F              ; {1026084}
    XBA                   ; {1026086}
    LDA #$7E              ; {1026087}
    LDY #$7000            ; {1026089}
    JSL $@chunk_010000.code_01186E ; {1026092}
    REP #$20              ; {1026096}
    PLX                   ; {1026098}
    RTL                   ; {1026099}
}
---------------------------------------------

word_0FA834 [
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

code_0FA874 {
    PHX                   ; {1026164}
    LDX #$0000            ; {1026165}

  loc_0FA878:
    LDA #$0090            ; {1026168}
    STA $7E7000, X        ; {1026171}
    STA $7E7800, X        ; {1026175}
    LDA #$7100            ; {1026179}
    STA $7E7001, X        ; {1026182}
    LDA #$7900            ; {1026186}
    STA $7E7801, X        ; {1026189}
    INX                   ; {1026193}
    INX                   ; {1026194}
    INX                   ; {1026195}
    CPX #$002A            ; {1026196}
    BNE loc_0FA878        ; {1026199}
    LDA #$0000            ; {1026201}
    STA $7E7000, X        ; {1026204}
    STA $7E7800, X        ; {1026208}
    PLX                   ; {1026212}
    COP [91]              ; {1026213}
    PHX                   ; {1026215}
    LDA $033A             ; {1026216}
    LSR                   ; {1026219}
    STA $16               ; {1026220}
    LDA $033C             ; {1026222}
    LSR                   ; {1026225}
    STA $18               ; {1026226}
    LDA $0312             ; {1026228}
    LSR                   ; {1026231}
    LSR                   ; {1026232}
    CLC                   ; {1026233}
    ADC $18               ; {1026234}
    AND #$000F            ; {1026236}
    ASL                   ; {1026239}
    TAX                   ; {1026240}
    LDY #$0000            ; {1026241}
    SEP #$20              ; {1026244}
    PHB                   ; {1026246}
    LDA #$7E              ; {1026247}
    PHA                   ; {1026249}
    PLB                   ; {1026250}

  loc_0FA8CB:
    LDA $@word_0FA905, X  ; {1026251}
    CLC                   ; {1026255}
    ADC $16               ; {1026256}
    STA $7100, Y          ; {1026258}
    LDA $@word_0FA905, X  ; {1026261}
    CLC                   ; {1026265}
    ADC $18               ; {1026266}
    STA $7900, Y          ; {1026268}
    INX                   ; {1026271}
    INX                   ; {1026272}
    INY                   ; {1026273}
    INY                   ; {1026274}
    CPY #$0020            ; {1026275}
    BNE loc_0FA8CB        ; {1026278}
    PLB                   ; {1026280}
    LDA #$0D              ; {1026281}
    XBA                   ; {1026283}
    LDA #$7E              ; {1026284}
    LDY #$7000            ; {1026286}
    JSL $@chunk_010000.code_01186E ; {1026289}
    LDA #$0E              ; {1026293}
    XBA                   ; {1026295}
    LDA #$7E              ; {1026296}
    LDY #$7800            ; {1026298}
    JSL $@chunk_010000.code_01186E ; {1026301}
    REP #$20              ; {1026305}
    PLX                   ; {1026307}
    RTL                   ; {1026308}
}
---------------------------------------------

word_0FA905 [
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

code_0FA945 {
    COP [2E] ( #00, #$0018, &code_0FA953 ) ; {1026373}
    COP [80] ( #07 )      ; {1026380}
    COP [82]              ; {1026383}
    BRA code_0FA945       ; {1026385}
}

code_0FA953 {
    COP [80] ( #0C )      ; {1026387}
    COP [82]              ; {1026390}
    BRA code_0FA945       ; {1026392}
}

code_0FA95A {
    COP [1F]              ; {1026394}
    LDA $0302             ; {1026396}
    AND #$0003            ; {1026399}
    BEQ loc_0FA96C        ; {1026402}
    DEC                   ; {1026404}
    BEQ loc_0FA971        ; {1026405}
    COP [01] ( &asciistring_0FA976 ) ; {1026407}
    RTL                   ; {1026411}

  loc_0FA96C:
    COP [01] ( &asciistring_0FA98C ) ; {1026412}
    RTL                   ; {1026416}

  loc_0FA971:
    COP [01] ( &asciistring_0FA9A4 ) ; {1026417}
    RTL                   ; {1026421}
}

asciistring_0FA976 |[10]Please somebody help [N]me--- [JMP:&asciistring_0FAA44]|

asciistring_0FA98C |[10]I want to return to [N]myself! [JMP:&asciistring_0FAA44]|

asciistring_0FA9A4 |[10]Help! Somebody [N]please------ [JMP:&asciistring_0FAA44]|

asciistring_0FA9C5 |[10]I am watching over the[N]world- [N]Here, take this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_0FA9F0 |[10]Would you like to [N]return to the Seabed [N]Palace? [END]|

asciistring_0FAA15 |Allright, good luck- [JMP:&asciistring_0FAA44]|

asciistring_0FAA29 |Visit me again when [N]you are ready- [JMP:&asciistring_0FAA44]|

asciistring_0FAA44 |[12][::][08:408][END]|