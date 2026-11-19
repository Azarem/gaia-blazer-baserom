?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020EE9 {
    COP [3B] ( #$00F7, &code_020EFF )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_020EFF {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_020F51 )
    COP [15]
    COP [05] ( #$0003 )
    COP [05] ( #$8003 )
    COP [80] ( #18 )
    COP [82]
    COP [17] ( &code_020F5A )
    COP [91]
    RTL 
}

code_020F1E {
    COP [16]

  loc_020F20:
    COP [80] ( #1C )
    COP [82]
    COP [97]
    COP [81] ( #1D, #07 )
    COP [83]
    COP [81] ( #1B, #0B )
    COP [83]
    COP [96]
    COP [81] ( #1D, #09 )
    COP [83]
    COP [81] ( #1C, #06 )
    COP [83]
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1C, #04 )
    COP [83]
    BRA loc_020F20
}

code_020F51 {
    COP [01] ( &asciistring_020F6B )
    COP [09] ( #$8003 )
    RTL 
}

code_020F5A {
    COP [01] ( &asciistring_020F7B )
    COP [17] ( &code_020F66 )
    COP [27] ( &code_020F1E )
}

code_020F66 {
    COP [01] ( &asciistring_020F88 )
    RTL 
}

asciistring_020F6B |[10]Week, week! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020F7B |[10]Let s go! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020F88 |[10]This is our vehicle- [JMP:&w3_shared_02249A.asciistring_02251E]|