?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025AAA {
    COP [3B] ( #$0185, &code_025AC0 ) ; {154282}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {154288}
    SEP #$20              ; {154292}
    LDA #$^engine_003005.code_00305F ; {154294}
    PHA                   ; {154296}
    REP #$20              ; {154297}
    LDA #$&engine_003005.code_00305F-1 ; {154299}
    PHA                   ; {154302}
    RTL                   ; {154303}
}

code_025AC0 {
    COP [A1] ( #$FFE0, #$0020 ) ; {154304}
    COP [85] ( @engine_0026F3.code_00299D ) ; {154310}
    COP [17] ( &code_025AF1 ) ; {154315}
    COP [97]              ; {154319}
    COP [80] ( #14 )      ; {154321}
    COP [82]              ; {154324}
    COP [15]              ; {154326}
    COP [91]              ; {154328}
    COP [0D] ( #00, #1C, #33, &code_025AE2 ) ; {154330}
    RTL                   ; {154337}
}

code_025AE2 {
    COP [03] ( #05 )      ; {154338}
    COP [04]              ; {154341}
    COP [96]              ; {154343}
    COP [80] ( #14 )      ; {154345}
    COP [82]              ; {154348}
    COP [91]              ; {154350}
    RTL                   ; {154352}
}

code_025AF1 {
    COP [01] ( &asciistring_025AF6 ) ; {154353}
    RTL                   ; {154357}
}

asciistring_025AF6 |[10]She was removing some [N]dust from my eye- [JMP:&w5_shared_02706C.asciistring_0270DF]|