?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024BC8 {
    COP [3B] ( #$0170, &code_024BDE ) ; {150472}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {150478}
    SEP #$20              ; {150482}
    LDA #$^engine_003005.code_00305F ; {150484}
    PHA                   ; {150486}
    REP #$20              ; {150487}
    LDA #$&engine_003005.code_00305F-1 ; {150489}
    PHA                   ; {150492}
    RTL                   ; {150493}
}

code_024BDE {
    COP [85] ( @engine_0026F3.code_00299D ) ; {150494}
    COP [07] ( #$8805, &code_024C20 ) ; {150499}
    COP [17] ( &code_024C23 ) ; {150505}
    COP [18] ( #28, &code_024BF8 ) ; {150509}
    COP [17] ( &code_024C2D ) ; {150514}
    BRA loc_024BFF        ; {150518}
}

code_024BF8 {
    COP [B0] ( @code_024C32, #$2000 ) ; {150520}

  loc_024BFF:
    COP [15]              ; {150527}
    COP [05] ( #$0001 )   ; {150529}
    COP [16]              ; {150533}
    COP [17] ( #$0000 )   ; {150535}
    COP [81] ( #17, #02 ) ; {150539}
    COP [83]              ; {150543}
    COP [81] ( #16, #03 ) ; {150545}
    COP [83]              ; {150549}
    COP [17] ( &code_024C28 ) ; {150551}
    COP [15]              ; {150555}
    COP [91]              ; {150557}
    RTL                   ; {150559}
}

code_024C20 {
    COP [86]              ; {150560}
    RTL                   ; {150562}
}

code_024C23 {
    COP [01] ( &asciistring_024C48 ) ; {150563}
    RTL                   ; {150567}
}

code_024C28 {
    COP [01] ( &asciistring_024CDF ) ; {150568}
    RTL                   ; {150572}
}

code_024C2D {
    COP [01] ( &asciistring_024D1B ) ; {150573}
    RTL                   ; {150577}
}

code_024C32 {
    COP [91]              ; {150578}
    COP [0D] ( #00, #0B, #30, &code_024C3C ) ; {150580}
    RTL                   ; {150587}
}

code_024C3C {
    COP [01] ( &asciistring_024D45 ) ; {150588}
    BRK #$5E              ; {150592}
    COP [0A] ( #28 )      ; {150594}
    COP [86]              ; {150597}
    RTL                   ; {150599}
}

asciistring_024C48 |[10]I am a guard- [N]But I am tired of my [N]job- [N]I came here to relax- [FIN][0F]While listening to the[N]guard, [02:2] sees a[N]card under the guard s[N]feet- [FIN]But [02:2] can t [N]get it because the [N]guard is standing on [N]it- [0F][JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024CDF |[10]I love listening to [N]music from the front [N]row- [FIN]Please do not bother [N]me- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024D1B |[10]I am a guard, [N]I am tired of my job- [N]I came here to relax- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024D45 |[10][02:2] found [N][03:24]a card- [03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|