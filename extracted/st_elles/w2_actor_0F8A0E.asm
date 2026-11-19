?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8A0E {
    COP [14] ( #$009B, &code_0F8A15 )
    RTL 
}

code_0F8A15 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [17] ( &code_0F8A28 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F8A28 {
    COP [01] ( &asciistring_0F8A2D )
    RTL 
}

asciistring_0F8A2D |[10]There used to be [N]4 mermaid statues in [N]this place- [FIN]Those statues [N]prevented all [N]creatures from getting[N]lost- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|