?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019F7A {
    COP [14] ( #$002F, &code_019F81 )
    RTL 
}

code_019F81 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_019F94 )
    COP [15]
    COP [91]
    COP [80] ( #24 )
    COP [82]
    RTL 
}

code_019F94 {
    COP [01] ( &asciistring_019F99 )
    RTL 
}

asciistring_019F99 |[10]I don t know if there [N]is such a thing as [N]reincarnation- [FIN]Even though I can t [N]communicate with my [N]husband, I enjoy his [N]company- [JMP:&w0_shared_01B988.asciistring_01B988]|