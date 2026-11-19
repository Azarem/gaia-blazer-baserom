?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w4_shared_023F33'

!L_choice_result                0003D0

---------------------------------------------

code_0232B3 {
    COP [14] ( #$014C, &code_0232BA )
    RTL 
}

code_0232BA {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0232CD )
    COP [15]
    COP [91]
    COP [80] ( #07 )
    COP [82]
    RTL 
}

code_0232CD {
    COP [07] ( #$8807, &code_0232FF )
    COP [18] ( #38, &code_0232FA )
    COP [01] ( &asciistring_023317 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0232F5 )
    LDA $L_choice_result
    BNE code_0232F5
    COP [01] ( &asciistring_0233D0 )
    COP [0B] ( #38 )
    COP [09] ( #$8807 )
    RTL 
}

code_0232F5 {
    COP [01] ( &asciistring_0233B1 )
    RTL 
}

code_0232FA {
    COP [01] ( &asciistring_023374 )
    RTL 
}

code_0232FF {
    COP [18] ( #38, &code_023309 )
    COP [01] ( &asciistring_02342E )
    RTL 
}

code_023309 {
    COP [01] ( &asciistring_023403 )
    BRK #$5E
    COP [0A] ( #38 )
    COP [09] ( #$0807 )
    RTL 
}

asciistring_023317 |[10]If there s nothing in[N]a chest then the chest[N]is good for nothing- [FIN]Would you store your [N]Medical Herbs in my [N]drawer? [END]|

asciistring_023374 |[10]If there s nothing [N]in a chest, [N]a chest doesn t mean [N]anything- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0233B1 |I am the happiest [N]chest in the world- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0233D0 |[02:2] put [N]his Medical Herbs [N]in the drawer- [FIN]I am satisfied- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023403 |[10]Are you taking them [N]out? Well, it s okay- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02342E |[10]You have a Medical [N]Herb- I will give [N]them back to you when [N]you have run out- [JMP:&w4_shared_023F33.asciistring_023FA3]|