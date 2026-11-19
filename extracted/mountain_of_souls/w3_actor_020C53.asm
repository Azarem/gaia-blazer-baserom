?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020C53 {
    COP [14] ( #$00F6, &code_020C5A ) ; {134227}
    RTL                   ; {134233}
}

code_020C5A {
    COP [85] ( @engine_0026F3.code_00299D ) ; {134234}
    COP [17] ( &code_020C6F ) ; {134239}
    COP [15]              ; {134243}

  loc_020C65:
    COP [AD] ( #08 )      ; {134245}
    COP [80] ( #25 )      ; {134248}
    COP [82]              ; {134251}
    BRA loc_020C65        ; {134253}
}

code_020C6F {
    COP [01] ( &asciistring_020C74 ) ; {134255}
    RTL                   ; {134259}
}

asciistring_020C74 |[10]I ll tell you a [N]secret- [FIN]If you see a sleeping [N]mushroom, return to [N]the same place you saw[N]in it s dream- [JMP:&w3_shared_02249A.asciistring_02251E]|