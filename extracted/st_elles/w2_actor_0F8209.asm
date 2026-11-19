?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8209 {
    COP [3B] ( #$0083, &code_0F821F )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F821F {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F826B )
    COP [80] ( #12 )
    COP [82]

  loc_0F822D:
    COP [A3]
    COP [84] ( @code_0F824F )
    COP [80] ( #1F )
    COP [82]
    COP [84] ( @code_0F824F )
    COP [A6]
    COP [17] ( &code_0F8266 )
    COP [81] ( #12, #02 )
    COP [83]
    COP [87]
    BRL loc_0F822D
}

code_0F824F {
    LDA #$0310
    STA $0016, X
    LDA #$002A
    STA $001E, X
    STZ $0020, X
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}

code_0F8266 {
    COP [01] ( &asciistring_0F8270 )
    RTL 
}

code_0F826B {
    COP [01] ( &asciistring_0F82A8 )
    RTL 
}

asciistring_0F8270 |[10]I didn t know the [N]world under water [N]looked different from [N]the world above- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F82A8 |[10]Please don t talk to [N]me while I m jumping, [N]I will not be able to [N]breathe- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|