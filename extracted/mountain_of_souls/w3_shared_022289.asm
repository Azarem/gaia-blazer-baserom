?BANK 04

?INCLUDE 'w3_shared_02249A'

!rng_state                      0301

---------------------------------------------

code_022289 {
    COP [2E] ( #00, #$0018, &code_022297 ) ; {139913}
    COP [80] ( #07 )      ; {139920}
    COP [82]              ; {139923}
    BRA code_022289       ; {139925}
}

code_022297 {
    COP [80] ( #0C )      ; {139927}
    COP [82]              ; {139930}
    BRA code_022289       ; {139932}
}

code_02229E {
    COP [1F]              ; {139934}
    LDA $rng_state+1      ; {139936}
    AND #$0003            ; {139939}
    BEQ loc_0222B0        ; {139942}
    DEC                   ; {139944}
    BEQ loc_0222B5        ; {139945}
    COP [01] ( &asciistring_0222BA ) ; {139947}
    RTL                   ; {139951}

  loc_0222B0:
    COP [01] ( &asciistring_0222E2 ) ; {139952}
    RTL                   ; {139956}

  loc_0222B5:
    COP [01] ( &asciistring_0222FF ) ; {139957}
    RTL                   ; {139961}
}

asciistring_0222BA |[10]Ouch---- it hurts! [N]Somebody please help [N]me! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0222E2 |[10]I want to return to my[N]real form- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0222FF |[10]Ow---- [JMP:&w3_shared_02249A.asciistring_02251E]|