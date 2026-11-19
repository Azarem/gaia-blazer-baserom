?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8941 {
    COP [14] ( #$0092, &code_0F8948 )
    RTL 
}

code_0F8948 {
    COP [07] ( #$9F02, &code_0F8984 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F8987 )
    COP [15]

  loc_0F8959:
    COP [14] ( #$00B6, &code_0F8967 )
    COP [80] ( #08 )
    COP [82]
    BRL loc_0F8959
}

code_0F8967 {
    COP [16]
    COP [81] ( #0A, #03 )
    COP [83]
    COP [96]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_0F898C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F8984 {
    COP [86]
    RTL 
}

code_0F8987 {
    COP [01] ( &asciistring_0F8991 )
    RTL 
}

code_0F898C {
    COP [01] ( &asciistring_0F89BB )
    RTL 
}

asciistring_0F8991 |[10]This used to be the [N]Queen s palace- I am [N]the Queen s maid- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F89BB |[10]I am glad you came [N]back- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|