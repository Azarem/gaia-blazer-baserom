?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8941 {
    COP [14] ( #$0092, &code_0F8948 ) ; {1018177}
    RTL                   ; {1018183}
}

code_0F8948 {
    COP [07] ( #$9F02, &code_0F8984 ) ; {1018184}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1018190}
    COP [17] ( &code_0F8987 ) ; {1018195}
    COP [15]              ; {1018199}

  loc_0F8959:
    COP [14] ( #$00B6, &code_0F8967 ) ; {1018201}
    COP [80] ( #08 )      ; {1018207}
    COP [82]              ; {1018210}
    BRL loc_0F8959        ; {1018212}
}

code_0F8967 {
    COP [16]              ; {1018215}
    COP [81] ( #0A, #03 ) ; {1018217}
    COP [83]              ; {1018221}
    COP [96]              ; {1018223}
    COP [80] ( #08 )      ; {1018225}
    COP [82]              ; {1018228}
    COP [15]              ; {1018230}
    COP [17] ( &code_0F898C ) ; {1018232}
    COP [91]              ; {1018236}
    COP [80] ( #08 )      ; {1018238}
    COP [82]              ; {1018241}
    RTL                   ; {1018243}
}

code_0F8984 {
    COP [86]              ; {1018244}
    RTL                   ; {1018246}
}

code_0F8987 {
    COP [01] ( &asciistring_0F8991 ) ; {1018247}
    RTL                   ; {1018251}
}

code_0F898C {
    COP [01] ( &asciistring_0F89BB ) ; {1018252}
    RTL                   ; {1018256}
}

asciistring_0F8991 |[10]This used to be the [N]Queen s palace- I am [N]the Queen s maid- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F89BB |[10]I am glad you came [N]back- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|