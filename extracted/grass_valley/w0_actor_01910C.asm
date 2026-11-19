?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01910C {
    COP [14] ( #$0012, &code_019113 )
    RTL 
}

code_019113 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_019121 )
    COP [15]
    COP [91]
    RTL 
}

code_019121 {
    COP [07] ( #$0107, &code_01912D )
    COP [07] ( #$0003, &code_01913A )
}

code_01912D {
    COP [01] ( &asciistring_01913F )
    COP [09] ( #$8107 )
    COP [09] ( #$8003 )
    RTL 
}

code_01913A {
    COP [01] ( &asciistring_01919A )
    RTL 
}

asciistring_01913F |[10]My name is Gaudi, I am[N]an architect- [FIN]I built all the houses[N]in this town- Come [N]back later, I will [N]show you something- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01919A |[10]What do you think of [N]these walls? [N]I am known to be a [N]fast builder! [JMP:&w0_shared_01B988.asciistring_01B988]|