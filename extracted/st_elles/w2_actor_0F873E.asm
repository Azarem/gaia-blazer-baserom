?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F873E {
    COP [3B] ( #$008B, &code_0F8754 ) ; {1017662}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1017668}
    SEP #$20              ; {1017672}
    LDA #$^engine_003005.code_00305F ; {1017674}
    PHA                   ; {1017676}
    REP #$20              ; {1017677}
    LDA #$&engine_003005.code_00305F-1 ; {1017679}
    PHA                   ; {1017682}
    RTL                   ; {1017683}
}

code_0F8754 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1017684}
    COP [17] ( &code_0F8779 ) ; {1017689}
    COP [15]              ; {1017693}

  code_0F875F:
    COP [80] ( #01 )      ; {1017695}
    COP [82]              ; {1017698}
    COP [07] ( #$0003, &code_0F875F ) ; {1017700}
    COP [16]              ; {1017706}

  loc_0F876C:
    COP [80] ( #03 )      ; {1017708}
    COP [82]              ; {1017711}
    COP [80] ( #04 )      ; {1017713}
    COP [82]              ; {1017716}
    BRL loc_0F876C        ; {1017718}
}

code_0F8779 {
    COP [01] ( &asciistring_0F877E ) ; {1017721}
    RTL                   ; {1017725}
}

asciistring_0F877E |[10]My name is Nanna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|