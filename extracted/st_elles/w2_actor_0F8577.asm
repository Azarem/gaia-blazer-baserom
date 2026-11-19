?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8577 {
    COP [3B] ( #$00C2, &code_0F858D ) ; {1017207}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1017213}
    SEP #$20              ; {1017217}
    LDA #$^engine_003005.code_00305F ; {1017219}
    PHA                   ; {1017221}
    REP #$20              ; {1017222}
    LDA #$&engine_003005.code_00305F-1 ; {1017224}
    PHA                   ; {1017227}
    RTL                   ; {1017228}
}

code_0F858D {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1017229}
    COP [17] ( &code_0F85B2 ) ; {1017234}
    COP [15]              ; {1017238}

  code_0F8598:
    COP [80] ( #01 )      ; {1017240}
    COP [82]              ; {1017243}
    COP [07] ( #$0003, &code_0F8598 ) ; {1017245}
    COP [16]              ; {1017251}

  loc_0F85A5:
    COP [80] ( #03 )      ; {1017253}
    COP [82]              ; {1017256}
    COP [80] ( #04 )      ; {1017258}
    COP [82]              ; {1017261}
    BRL loc_0F85A5        ; {1017263}
}

code_0F85B2 {
    COP [01] ( &asciistring_0F85B7 ) ; {1017266}
    RTL                   ; {1017270}
}

asciistring_0F85B7 |[10]My name is Anna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|