?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA3A5 {
    COP [17] ( &code_0FA3AE )
    COP [15]
    COP [91]
    RTL 
}

code_0FA3AE {
    COP [07] ( #$0000, &code_0FA3C9 )
    COP [01] ( &asciistring_0FA3DB )
    COP [3C] ( #04 )
    COP [10] ( #$0106, #03, #$00C0, #$0040 )
    COP [09] ( #$8704 )
    RTL 
}

code_0FA3C9 {
    COP [01] ( &asciistring_0FA3CE )
    RTL 
}

asciistring_0FA3CE |[10]-------- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA3DB |[10]Someone is calling me-[N]What is that? [FIN]I just put one GEM in [N]a treasure chest- [FIN]I hope someone will [N]find it- [FIN]-------- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|