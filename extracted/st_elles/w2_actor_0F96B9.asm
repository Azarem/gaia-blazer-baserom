?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F96B9 {
    COP [14] ( #$00BD, &code_0F96C0 )
    RTL 
}

code_0F96C0 {
    COP [07] ( #$9F02, &code_0F9704 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F9707 )
    COP [15]

  loc_0F96D1:
    COP [14] ( #$00B6, &code_0F96DF )
    COP [80] ( #08 )
    COP [82]
    BRL loc_0F96D1
}

code_0F96DF {
    COP [16]
    COP [9F] ( #$0010 )
    COP [81] ( #0A, #03 )
    COP [83]
    COP [9F] ( #$FFF0 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_0F970C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F9704 {
    COP [86]
    RTL 
}

code_0F9707 {
    COP [01] ( &asciistring_0F9711 )
    RTL 
}

code_0F970C {
    COP [01] ( &asciistring_0F976C )
    RTL 
}

asciistring_0F9711 |[10]I saw the Queen when [N]I was dreaming- [N]She looked very sad- [FIN]It was somewhere near [N]a sunken ship- [N]Please save the [N]Queen!! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F976C |[10]Thank you very much! [N]I can hardly believe [N]that she is really [N]back! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|