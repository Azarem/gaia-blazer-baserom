?BANK 04

?INCLUDE 'w3_shared_02249A'

!rng_state                      0301

---------------------------------------------

code_022289 {
    COP [2E] ( #00, #$0018, &code_022297 )
    COP [80] ( #07 )
    COP [82]
    BRA code_022289
}

code_022297 {
    COP [80] ( #0C )
    COP [82]
    BRA code_022289
}

code_02229E {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0222B0
    DEC 
    BEQ loc_0222B5
    COP [01] ( &asciistring_0222BA )
    RTL 

  loc_0222B0:
    COP [01] ( &asciistring_0222E2 )
    RTL 

  loc_0222B5:
    COP [01] ( &asciistring_0222FF )
    RTL 
}

asciistring_0222BA |[10]Ouch---- it hurts! [N]Somebody please help [N]me! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0222E2 |[10]I want to return to my[N]real form- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0222FF |[10]Ow---- [JMP:&w3_shared_02249A.asciistring_02251E]|