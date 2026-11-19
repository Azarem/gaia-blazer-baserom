?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8209 {
    COP [3B] ( #$0083, &code_0F821F ) ; {1016329}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1016335}
    SEP #$20              ; {1016339}
    LDA #$^engine_003005.code_00305F ; {1016341}
    PHA                   ; {1016343}
    REP #$20              ; {1016344}
    LDA #$&engine_003005.code_00305F-1 ; {1016346}
    PHA                   ; {1016349}
    RTL                   ; {1016350}
}

code_0F821F {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1016351}
    COP [17] ( &code_0F826B ) ; {1016356}
    COP [80] ( #12 )      ; {1016360}
    COP [82]              ; {1016363}

  loc_0F822D:
    COP [A3]              ; {1016365}
    COP [84] ( @code_0F824F ) ; {1016367}
    COP [80] ( #1F )      ; {1016372}
    COP [82]              ; {1016375}
    COP [84] ( @code_0F824F ) ; {1016377}
    COP [A6]              ; {1016382}
    COP [17] ( &code_0F8266 ) ; {1016384}
    COP [81] ( #12, #02 ) ; {1016388}
    COP [83]              ; {1016392}
    COP [87]              ; {1016394}
    BRL loc_0F822D        ; {1016396}
}

code_0F824F {
    LDA #$0310            ; {1016399}
    STA $0016, X          ; {1016402}
    LDA #$002A            ; {1016405}
    STA $001E, X          ; {1016408}
    STZ $0020, X          ; {1016411}
    COP [80] ( #2A )      ; {1016414}
    COP [82]              ; {1016417}
    COP [86]              ; {1016419}
    RTL                   ; {1016421}
}

code_0F8266 {
    COP [01] ( &asciistring_0F8270 ) ; {1016422}
    RTL                   ; {1016426}
}

code_0F826B {
    COP [01] ( &asciistring_0F82A8 ) ; {1016427}
    RTL                   ; {1016431}
}

asciistring_0F8270 |[10]I didn t know the [N]world under water [N]looked different from [N]the world above- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F82A8 |[10]Please don t talk to [N]me while I m jumping, [N]I will not be able to [N]breathe- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|