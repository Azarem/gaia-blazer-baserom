?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025AAA {
    COP [3B] ( #$0185, &code_025AC0 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_025AC0 {
    COP [A1] ( #$FFE0, #$0020 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_025AF1 )
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    COP [0D] ( #00, #1C, #33, &code_025AE2 )
    RTL 
}

code_025AE2 {
    COP [03] ( #05 )
    COP [04]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_025AF1 {
    COP [01] ( &asciistring_025AF6 )
    RTL 
}

asciistring_025AF6 |[10]She was removing some [N]dust from my eye- [JMP:&w5_shared_02706C.asciistring_0270DF]|