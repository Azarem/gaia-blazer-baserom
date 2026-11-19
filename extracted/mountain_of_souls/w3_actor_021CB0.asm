?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021CB0 {
    COP [14] ( #$00CA, &code_021CB7 )
    RTL 
}

code_021CB7 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [17] ( &code_021CC5 )
    COP [91]
    RTL 
}

code_021CC5 {
    COP [01] ( &asciistring_021CCA )
    RTL 
}

asciistring_021CCA |[10]This is where the [N]Mountain of Souls [N]exists- [FIN]It is quite warm [N]inside the mountain- [JMP:&w3_shared_02249A.asciistring_02251E]|