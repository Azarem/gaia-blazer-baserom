?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020EE9 {
    COP [3B] ( #$00F7, &code_020EFF ) ; {134889}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {134895}
    SEP #$20              ; {134899}
    LDA #$^engine_003005.code_00305F ; {134901}
    PHA                   ; {134903}
    REP #$20              ; {134904}
    LDA #$&engine_003005.code_00305F-1 ; {134906}
    PHA                   ; {134909}
    RTL                   ; {134910}
}

code_020EFF {
    COP [85] ( @engine_0026F3.code_00299D ) ; {134911}
    COP [17] ( &code_020F51 ) ; {134916}
    COP [15]              ; {134920}
    COP [05] ( #$0003 )   ; {134922}
    COP [05] ( #$8003 )   ; {134926}
    COP [80] ( #18 )      ; {134930}
    COP [82]              ; {134933}
    COP [17] ( &code_020F5A ) ; {134935}
    COP [91]              ; {134939}
    RTL                   ; {134941}
}

code_020F1E {
    COP [16]              ; {134942}

  loc_020F20:
    COP [80] ( #1C )      ; {134944}
    COP [82]              ; {134947}
    COP [97]              ; {134949}
    COP [81] ( #1D, #07 ) ; {134951}
    COP [83]              ; {134955}
    COP [81] ( #1B, #0B ) ; {134957}
    COP [83]              ; {134961}
    COP [96]              ; {134963}
    COP [81] ( #1D, #09 ) ; {134965}
    COP [83]              ; {134969}
    COP [81] ( #1C, #06 ) ; {134971}
    COP [83]              ; {134975}
    COP [97]              ; {134977}
    COP [81] ( #1D, #02 ) ; {134979}
    COP [83]              ; {134983}
    COP [81] ( #1C, #04 ) ; {134985}
    COP [83]              ; {134989}
    BRA loc_020F20        ; {134991}
}

code_020F51 {
    COP [01] ( &asciistring_020F6B ) ; {134993}
    COP [09] ( #$8003 )   ; {134997}
    RTL                   ; {135001}
}

code_020F5A {
    COP [01] ( &asciistring_020F7B ) ; {135002}
    COP [17] ( &code_020F66 ) ; {135006}
    COP [27] ( &code_020F1E ) ; {135010}
}

code_020F66 {
    COP [01] ( &asciistring_020F88 ) ; {135014}
    RTL                   ; {135018}
}

asciistring_020F6B |[10]Week, week! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020F7B |[10]Let s go! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020F88 |[10]This is our vehicle- [JMP:&w3_shared_02249A.asciistring_02251E]|