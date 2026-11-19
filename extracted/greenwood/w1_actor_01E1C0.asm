?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E1C0 {
    COP [14] ( #$0041, &code_01E1C7 ) ; {123328}
    RTL                   ; {123334}
}

code_01E1C7 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {123335}
    COP [17] ( &code_01E1D5 ) ; {123340}
    COP [15]              ; {123344}
    COP [91]              ; {123346}
    RTL                   ; {123348}
}

code_01E1D5 {
    COP [07] ( #$9A02, &code_01E1E9 ) ; {123349}
    COP [01] ( &asciistring_01E1EE ) ; {123355}
    BRK #$5E              ; {123359}
    COP [0A] ( #2C )      ; {123361}
    COP [09] ( #$9A02 )   ; {123364}
    RTL                   ; {123368}
}

code_01E1E9 {
    COP [01] ( &asciistring_01E22B ) ; {123369}
    RTL                   ; {123373}
}

asciistring_01E1EE |[10]Thank you for [N]releasing me- I will [N]give you this- [FIN][02:2] received [N][03:24]the Master s Emblem C-[03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E22B |[10]Thank you for [N]releasing me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|