?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E005 {
    COP [14] ( #$0043, &code_01E00C ) ; {122885}
    RTL                   ; {122891}
}

code_01E00C {
    COP [85] ( @engine_0026F3.code_00299D ) ; {122892}
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

asciistring_01E045 |[10]Welcome to the [N]squirrel s exchange [N]store- [FIN]I am hungry, if [N]you can bring me [N]something to eat, [FIN]I will trade you [N]something- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E0A5 |[10]Ah, I smell some [N]delicious seeds- You [N]have some don t you? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E0DD |[10]I will exchange this [N]sword with you for the[N]seeds- [FIN][02:2] received [N][03:24]the Psycho Sword- [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E11B |[10]Those seeds were very [N]good! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|