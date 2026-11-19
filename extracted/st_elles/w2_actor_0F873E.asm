?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F873E {
    COP [3B] ( #$008B, &code_0F8754 )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F8754 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F8779 )
    COP [15]

  code_0F875F:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F875F )
    COP [16]

  loc_0F876C:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F876C
}

code_0F8779 {
    COP [01] ( &asciistring_0F877E )
    RTL 
}

asciistring_0F877E |[10]My name is Nanna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|