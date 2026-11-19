?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8850 {
    COP [14] ( #$00AD, &code_0F8857 )
    RTL 
}

code_0F8857 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F886A )

  loc_0F8860:
    COP [81] ( #12, #04 )
    COP [83]
    COP [87]
    BRA loc_0F8860
}

code_0F886A {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F8881 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

asciistring_0F8881 |[10][0A]If█you█travel[N]the█coral█reef█you[N]will█find█a█passage█to[N]a█small█creek-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|