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
    COP [81] ( #09, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [05] ( #$0006 )
    COP [80] ( #09 )
    COP [82]
}

code_0266FC {
    COP [80] ( #03 )
    COP [82]
    COP [15]
    COP [17] ( &code_026736 )
    COP [91]
    RTL 
}

code_02670A {
    COP [07] ( #$8902, &code_026723 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_02673B )
    COP [05] ( #$0902 )
    COP [16]
}

code_026723 {
    COP [17] ( &code_026753 )
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_026736 {
    COP [01] ( &asciistring_026758 )
    RTL 
}

code_02673B {
    COP [01] ( &asciistring_026772 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_026746 )
}

code_026746 {
    COP [01] ( &asciistring_026874 )
    COP [17] ( &code_026753 )
    COP [09] ( #$8902 )
    RTL 
}

code_026753 {
    COP [01] ( &asciistring_026921 )
    RTL 
}

asciistring_026758 |[10][0F]Lisa just keeps [N]crying- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026772 |[10]Hello- Thank you for [N]staying with me while [N]my father passed away-[FIN]I didn t think I would[N]see him again- [FIN]But because of you I [N]was finally able to [N]see him again- [FIN]Ever since you saved [N]me at Grass Valley, [N]I imagined you [N]fighting monsters [N]whenever I closed my [N]eyes- [FIN]By the way, [N]I would like you to [N]answer my questions- [FIN]Are you a real human [N]being like me? [END]|

asciistring_026874 |I see --------- [FIN]I feel like you are [N]far away even though [N]you are right in front[N]of me- [FIN]I feel like you are [N]watching us from the [N]sky- [FIN]I don t know how to [N]express the way I [N]feel- [FIN]But that is okay, [N]I, I love--- [FIN]You are going to fight[N]Deathtoll, right? [FIN][JMP:&asciistring_026921+M]|

asciistring_026921 |[10][::]I would say goodbye, [N]but I know I am going [N]to cry- [FIN]Please leave while my [N]back is turned- [JMP:&w5_shared_02706C.asciistring_0270DF]|

code_026961 {
    COP [81] ( #15, #03 )
    COP [83]
    COP [80] ( #12 )
    COP [82]
    COP [09] ( #$8007 )
    COP [05] ( #$8007 )
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #03 )
    COP [83]
    COP [97]
    COP [80] ( #17 )
    COP [82]
    COP [09] ( #$8007 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_02699C {
    COP [03] ( #40 )
    COP [B0] ( @code_0269B5, #$0300 )
    COP [1B] ( &code_0269AC, #$0002 )
}

code_0269AC {
    COP [04]
    COP [09] ( #$8006 )
    COP [86]
    RTL 
}

code_0269B5 {
    COP [A8] ( #$8000, #0E )
    COP [A3]
    LDA $0372
    STA $001C, X
    JSR $&code_0269CF
    BRK #$85
    COP [80] ( #00 )
    COP [82]
    COP [86]
    RTL 
}

code_0269CF {
    COP [1F]
    COP [35] ( #40 )
    LDA $random_mod_result
    SEC 
    SBC #$0020
    CLC 
    ADC $0000, X
    STA $0000, X
    COP [1F]
    COP [35] ( #40 )
    LDA $random_mod_result
    SEC 
    SBC #$0020
    CLC 
    ADC $0002, X
    STA $0002, X
    RTS 
}