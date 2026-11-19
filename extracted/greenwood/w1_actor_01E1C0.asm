?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E1C0 {
    COP [14] ( #$0041, &code_01E1C7 )
    RTL 
}

code_01E1C7 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01E1D5 )
    COP [15]
    COP [91]
    RTL 
}

code_01E1D5 {
    COP [07] ( #$9A02, &code_01E1E9 )
    COP [01] ( &asciistring_01E1EE )
    BRK #$5E
    COP [0A] ( #2C )
    COP [09] ( #$9A02 )
    RTL 
}

code_01E1E9 {
    COP [01] ( &asciistring_01E22B )
    RTL 
}

asciistring_01E1EE |[10]Thank you for [N]releasing me- I will [N]give you this- [FIN][02:2] received [N][03:24]the Master s Emblem C-[03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E22B |[10]Thank you for [N]releasing me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|