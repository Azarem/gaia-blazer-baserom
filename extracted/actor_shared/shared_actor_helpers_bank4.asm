?BANK 04

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

asciistring_0222BA |[10]Ouch---- it hurts! [N]Somebody please help [N]me! [JMP:&asciistring_02251E]|

asciistring_0222E2 |[10]I want to return to my[N]real form- [JMP:&asciistring_02251E]|

asciistring_0222FF |[10]Ow---- [JMP:&asciistring_02251E]|
---------------------------------------------

asciistring_02249A |[10]I am watching the [N]world- Here, take [N]this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_0224C2 |[10]Would you like to [N]return to the location[N]of the Mountain of [N]Souls? [END]|

asciistring_0224F4 |Good luck then- [JMP:&asciistring_02251E]|

asciistring_022507 |Return to me when you [N]are ready- [JMP:&asciistring_02251E]|

asciistring_02251E |[12][::][08:408][END]|