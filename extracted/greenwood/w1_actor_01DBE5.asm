?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01DBE5 {
    COP [14] ( #$0040, &code_01DBEC ) ; {121829}
    RTL                   ; {121835}
}

code_01DBEC {
    COP [85] ( @engine_0026F3.code_00299D ) ; {121836}
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

asciistring_01DC19 |[10]I didn t know that he [N]was a ghost- [FIN]Both of us fell in [N]love with Monmo- [FIN]One day, Monmo was [N]captured by evil- He [N]tried to rescue her [N]but never came back- [FIN]Suddenly he appeared, [N]I had no idea what [N]happened to him- [FIN]Anyways, take this [N]bracelet and revive [N]GreenWood- [FIN]I know those two moles[N]would have liked to [N]live here in peace- [FIN][02:2] received [N][03:24]Shield Bracelet! [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DD41 |[10]My roommate has [N]disappeared- Will you [N]look for him? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DD72 |[10]I am a bit jealous [N]that he won Monmo s [N]heart- [FIN]But I hope they are [N]happy now- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|