?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01DF73 {
    COP [14] ( #$004F, &code_01DF7A )
    RTL 
}

code_01DF7A {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01DF88 )
    COP [15]
    COP [91]
    RTL 
}

code_01DF88 {
    COP [01] ( &asciistring_01DF8D )
    RTL 
}

asciistring_01DF8D |[10]Turbo, the dog, [N]used to live with a [N]human named Dr-Leo- [FIN]Turbo learned a great [N]many things from him- [FIN]He used branches from [N]the trees to make a [N]tool called a raft- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|