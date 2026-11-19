?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020C53 {
    COP [14] ( #$00F6, &code_020C5A )
    RTL 
}

code_020C5A {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_020C6F )
    COP [15]

  loc_020C65:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_020C65
}

code_020C6F {
    COP [01] ( &asciistring_020C74 )
    RTL 
}

asciistring_020C74 |[10]I ll tell you a [N]secret- [FIN]If you see a sleeping [N]mushroom, return to [N]the same place you saw[N]in it s dream- [JMP:&w3_shared_02249A.asciistring_02251E]|