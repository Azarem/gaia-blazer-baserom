?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w1_shared_01EBC2'

!L_choice_result                0003D0
!APUIO0                         2140

---------------------------------------------

code_01B98D {
    COP [14] ( #$0056, &code_01B994 ) ; {113037}
    RTL                   ; {113043}
}

code_01B994 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {113044}
    COP [17] ( &code_01BA28 ) ; {113049}

  loc_01B99D:
    COP [80] ( #0E )      ; {113053}
    COP [82]              ; {113056}
    COP [15]              ; {113058}
    COP [1B] ( &code_01B9AA, #$0078 ) ; {113060}
}

code_01B9AA {
    COP [16]              ; {113066}
    COP [9F] ( #$0008 )   ; {113068}
    COP [1E] ( #$EFFF )   ; {113072}
    COP [81] ( #0F, #04 ) ; {113076}
    COP [83]              ; {113080}
    COP [1D] ( #$1000 )   ; {113082}
    COP [9F] ( #$FFF8 )   ; {113086}
    COP [81] ( #11, #03 ) ; {113090}
    COP [83]              ; {113094}
    COP [9D] ( #11 )      ; {113096}
    COP [9E] ( &code_01B9CF ) ; {113099}
}

code_01B9CF {
    COP [15]              ; {113103}
    COP [1B] ( &code_01B9D7, #$0078 ) ; {113105}
}

code_01B9D7 {
    COP [16]              ; {113111}
    COP [9F] ( #$0008 )   ; {113113}
    COP [81] ( #10, #02 ) ; {113117}
    COP [83]              ; {113121}
    COP [9F] ( #$FFF8 )   ; {113123}
    COP [80] ( #0E )      ; {113127}
    COP [82]              ; {113130}
    COP [15]              ; {113132}
    COP [1B] ( &code_01B9F4, #$0078 ) ; {113134}
}

code_01B9F4 {
    COP [16]              ; {113140}
    COP [9F] ( #$0008 )   ; {113142}
    COP [81] ( #10, #03 ) ; {113146}
    COP [83]              ; {113150}
    COP [87]              ; {113152}
    COP [9F] ( #$FFF8 )   ; {113154}
    COP [81] ( #11, #03 ) ; {113158}
    COP [83]              ; {113162}
    COP [9D] ( #11 )      ; {113164}
    COP [9E] ( &code_01BA13 ) ; {113167}
}

code_01BA13 {
    COP [87]              ; {113171}
    COP [9F] ( #$0008 )   ; {113173}
    COP [80] ( #0F )      ; {113177}
    COP [82]              ; {113180}
    COP [9F] ( #$FFF8 )   ; {113182}
    BRL loc_01B99D        ; {113186}

  loc_01BA25:
    COP [91]              ; {113189}
    RTL                   ; {113191}
}

code_01BA28 {
    COP [01] ( &asciistring_01BA6B ) ; {113192}

  loc_01BA2C:
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01BA64 ) ; {113196}
    LDA $L_choice_result  ; {113203}
    BNE code_01BA64       ; {113207}
    COP [01] ( &asciistring_01BAAA ) ; {113209}
    LDA #$0000            ; {113213}
    STA $APUIO0           ; {113216}
    LDA $1B84             ; {113219}
    PHA                   ; {113222}
    LDA #$0005            ; {113223}
    STA $1B84             ; {113226}
    COP [01] ( &asciistring_01BAD8 ) ; {113229}
    PLA                   ; {113233}
    STA $1B84             ; {113234}
    COP [01] ( &asciistring_01BAE1 ) ; {113237}
    LDA #$0001            ; {113241}
    STA $APUIO0           ; {113244}
    COP [01] ( &asciistring_01BB03 ) ; {113247}
    RTL                   ; {113251}
}

code_01BA64 {
    COP [01] ( &asciistring_01BA8F ) ; {113252}
    BRL loc_01BA2C        ; {113256}
}

asciistring_01BA6B |[10]This is a restaurant- [N][::]Would you like to see [N]the menu? [END]|

asciistring_01BA8F |Come on! At least [N]take a look- [N][JMP:&asciistring_01BA6B+M]|

asciistring_01BAAA |Great! Let me tell [N]you our special of the[N]day------- [0E:78][END]|

asciistring_01BAD8 |[10]You! [0E:78][END]|

asciistring_01BAE1 |I m just kidding! [N]Please don t be [N]offended- [FIN][END]|

asciistring_01BB03 |[0E:8][10]This restaurant is [N]famous for delicious [N]food and fruit [N]drinks! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|