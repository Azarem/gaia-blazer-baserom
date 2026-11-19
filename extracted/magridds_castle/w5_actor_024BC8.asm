?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024BC8 {
    COP [3B] ( #$0170, &code_024BDE )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_024BDE {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [07] ( #$8805, &code_024C20 )
    COP [17] ( &code_024C23 )
    COP [18] ( #28, &code_024BF8 )
    COP [17] ( &code_024C2D )
    BRA loc_024BFF
}

code_024BF8 {
    COP [B0] ( @code_024C32, #$2000 )

  loc_024BFF:
    COP [15]
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #17, #02 )
    COP [83]
    COP [81] ( #16, #03 )
    COP [83]
    COP [17] ( &code_024C28 )
    COP [15]
    COP [91]
    RTL 
}

code_024C20 {
    COP [86]
    RTL 
}

code_024C23 {
    COP [01] ( &asciistring_024C48 )
    RTL 
}

code_024C28 {
    COP [01] ( &asciistring_024CDF )
    RTL 
}

code_024C2D {
    COP [01] ( &asciistring_024D1B )
    RTL 
}

code_024C32 {
    COP [91]
    COP [0D] ( #00, #0B, #30, &code_024C3C )
    RTL 
}

code_024C3C {
    COP [01] ( &asciistring_024D45 )
    BRK #$5E
    COP [0A] ( #28 )
    COP [86]
    RTL 
}

asciistring_024C48 |[10]I am a guard- [N]But I am tired of my [N]job- [N]I came here to relax- [FIN][0F]While listening to the[N]guard, [02:2] sees a[N]card under the guard s[N]feet- [FIN]But [02:2] can t [N]get it because the [N]guard is standing on [N]it- [0F][JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024CDF |[10]I love listening to [N]music from the front [N]row- [FIN]Please do not bother [N]me- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024D1B |[10]I am a guard, [N]I am tired of my job- [N]I came here to relax- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024D45 |[10][02:2] found [N][03:24]a card- [03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|