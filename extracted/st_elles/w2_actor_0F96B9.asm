?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F96B9 {
    COP [14] ( #$00BD, &code_0F96C0 ) ; {1021625}
    RTL                   ; {1021631}
}

code_0F96C0 {
    COP [07] ( #$9F02, &code_0F9704 ) ; {1021632}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1021638}
    COP [17] ( &code_0F9707 ) ; {1021643}
    COP [15]              ; {1021647}

  loc_0F96D1:
    COP [14] ( #$00B6, &code_0F96DF ) ; {1021649}
    COP [80] ( #08 )      ; {1021655}
    COP [82]              ; {1021658}
    BRL loc_0F96D1        ; {1021660}
}

code_0F96DF {
    COP [16]              ; {1021663}
    COP [9F] ( #$0010 )   ; {1021665}
    COP [81] ( #0A, #03 ) ; {1021669}
    COP [83]              ; {1021673}
    COP [9F] ( #$FFF0 )   ; {1021675}
    COP [97]              ; {1021679}
    COP [80] ( #08 )      ; {1021681}
    COP [82]              ; {1021684}
    COP [15]              ; {1021686}
    COP [17] ( &code_0F970C ) ; {1021688}
    COP [91]              ; {1021692}
    COP [80] ( #08 )      ; {1021694}
    COP [82]              ; {1021697}
    RTL                   ; {1021699}
}

code_0F9704 {
    COP [86]              ; {1021700}
    RTL                   ; {1021702}
}

code_0F9707 {
    COP [01] ( &asciistring_0F9711 ) ; {1021703}
    RTL                   ; {1021707}
}

code_0F970C {
    COP [01] ( &asciistring_0F976C ) ; {1021708}
    RTL                   ; {1021712}
}

asciistring_0F9711 |[10]I saw the Queen when [N]I was dreaming- [N]She looked very sad- [FIN]It was somewhere near [N]a sunken ship- [N]Please save the [N]Queen!! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F976C |[10]Thank you very much! [N]I can hardly believe [N]that she is really [N]back! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|