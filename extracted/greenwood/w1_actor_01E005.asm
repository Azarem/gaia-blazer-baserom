?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E005 {
    COP [14] ( #$0043, &code_01E00C )
    RTL 
}

code_01E00C {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01E01A )
    COP [15]
    COP [91]
    RTL 
}

code_01E01A {
    COP [18] ( #02, &code_01E024 )
    COP [01] ( &asciistring_01E11B )
    RTL 
}

code_01E024 {
    COP [18] ( #25, &code_01E03B )
    COP [19] ( #25, &code_01E040 )
    COP [01] ( &asciistring_01E0DD )
    COP [0B] ( #25 )
    BRK #$5E
    COP [0A] ( #02 )
    RTL 
}

code_01E03B {
    COP [01] ( &asciistring_01E045 )
    RTL 
}

code_01E040 {
    COP [01] ( &asciistring_01E0A5 )
    RTL 
}

asciistring_01E045 |[10]Welcome to the [N]squirrel s exchange [N]store- [FIN]I am hungry, if [N]you can bring me [N]something to eat, [FIN]I will trade you [N]something- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E0A5 |[10]Ah, I smell some [N]delicious seeds- You [N]have some don t you? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E0DD |[10]I will exchange this [N]sword with you for the[N]seeds- [FIN][02:2] received [N][03:24]the Psycho Sword- [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E11B |[10]Those seeds were very [N]good! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|