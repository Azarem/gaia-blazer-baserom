?BANK 04

?INCLUDE 'lib_014F02'
?INCLUDE 'w5_shared_02706C'

!random_mod_result              0437

---------------------------------------------

asciistring_026240 |[10]You took everything [N]away from me- [FIN]You are dirtier than [N]evil! [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_02626D |[10]Dr-Leo, you talk too [N]much- [FIN]Life is never easy- [N]Look! [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0262A0 |[10]Hey, keep walking- [0E:28][JMP:&w5_shared_02706C.asciistring_0270DF+M]|

asciistring_0262B9 |[10]Daddy! [FIN]Daddy! I knew [N]I would see you, [N]but not like this---- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0262ED |[10]Dr-Leo, [N]you will still do what[N]I say? [FIN][10]You-------- [FIN]As you said, I made a [N]machine to call [N]Deathtoll! [FIN]Lisa has nothing to do[N]with this- [FIN][10]Shut up! [FIN]Dr-Leo, you still [N]have to work for us- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026382 |[10]All right- [FIN]I cannot sacrifice [N]peoples  lives [N]anymore- [FIN]But please, release [N]Lisa- [FIN]She is the most [N]precious thing in this[N]world- [FIN]Even if I could not [N]see her, she would [N]still be my [N]motivation- [FIN]I can endure anything [N]by just imagining her [N]face- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026458 |[10]You are an honest man-[FIN]All right, Dr-Leo- [N]Leave Lisa alone- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_02648E |[10][0F]Leo whispered in [N][02:2] s ears- [0F][FIN][0A][02:2],[N]stay█behind█me----[JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0264C3 |[10][0A]Here,█take█this█and[N]get█on█the█airship-[FIN]Please█take█care█of[N]Lisa-[JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026509 |[10]I will not run away- [N]Just take me wherever [N]you want- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026533 |[10][0F]Lisa, [N][0E:3C]please forgive me- [N][0E:50][JMP:&w5_shared_02706C.asciistring_0270DF+M]|

asciistring_026551 |[10][02:2], I think [N]I was born in the [N]wrong generation- [FIN]Scientists are [N]supposed to invent [N]machines in order to [N]make people happy- [FIN]But an unexpected [N]scientist may ruin the[N]culture- [FIN]Some people believe [N]happiness comes [N]quickly, [FIN]I think it comes with [N]patientce- [FIN]Lisa, I am sorry for [N]leaving you- [FIN]I am not passing away,[N]rather, [N]I am going to sleep- [FIN]When a scientist with [N]my knowledge is [N]needed, I will be [N]back- [FIN][0A]Lisa,█be█happy-[N]But█don t█rush[N]yourself-[N][0E:28]Yes,█gradually--------[JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0266DB |[10]-------- [JMP:&w5_shared_02706C.asciistring_0270DF]|

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
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_026746 ) ; {157503}
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

asciistring_026758 |[10][0F]Lisa just keeps [N]crying- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026772 |[10]Hello- Thank you for [N]staying with me while [N]my father passed away-[FIN]I didn t think I would[N]see him again- [FIN]But because of you I [N]was finally able to [N]see him again- [FIN]Ever since you saved [N]me at Grass Valley, [N]I imagined you [N]fighting monsters [N]whenever I closed my [N]eyes- [FIN]By the way, [N]I would like you to [N]answer my questions- [FIN]Are you a real human [N]being like me? [END]|

asciistring_026874 |I see --------- [FIN]I feel like you are [N]far away even though [N]you are right in front[N]of me- [FIN]I feel like you are [N]watching us from the [N]sky- [FIN]I don t know how to [N]express the way I [N]feel- [FIN]But that is okay, [N]I, I love--- [FIN]You are going to fight[N]Deathtoll, right? [FIN][JMP:&asciistring_026921+M]|

asciistring_026921 |[10][::]I would say goodbye, [N]but I know I am going [N]to cry- [FIN]Please leave while my [N]back is turned- [JMP:&w5_shared_02706C.asciistring_0270DF]|

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
    LDA $random_mod_result ; {158164}
    SEC                   ; {158167}
    SBC #$0020            ; {158168}
    CLC                   ; {158171}
    ADC $0000, X          ; {158172}
    STA $0000, X          ; {158175}
    COP [1F]              ; {158178}
    COP [35] ( #40 )      ; {158180}
    LDA $random_mod_result ; {158183}
    SEC                   ; {158186}
    SBC #$0020            ; {158187}
    CLC                   ; {158190}
    ADC $0002, X          ; {158191}
    STA $0002, X          ; {158194}
    RTS                   ; {158197}
}