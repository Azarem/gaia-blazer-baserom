?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w1_shared_01EBC2'

!L_choice_result                0003D0
!APUIO0                         2140

---------------------------------------------

code_01B98D {
    COP [14] ( #$0056, &code_01B994 )
    RTL 
}

code_01B994 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01BA28 )

  loc_01B99D:
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [1B] ( &code_01B9AA, #$0078 )
}

code_01B9AA {
    COP [16]
    COP [9F] ( #$0008 )
    COP [1E] ( #$EFFF )
    COP [81] ( #0F, #04 )
    COP [83]
    COP [1D] ( #$1000 )
    COP [9F] ( #$FFF8 )
    COP [81] ( #11, #03 )
    COP [83]
    COP [9D] ( #11 )
    COP [9E] ( &code_01B9CF )
}

code_01B9CF {
    COP [15]
    COP [1B] ( &code_01B9D7, #$0078 )
}

code_01B9D7 {
    COP [16]
    COP [9F] ( #$0008 )
    COP [81] ( #10, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [1B] ( &code_01B9F4, #$0078 )
}

code_01B9F4 {
    COP [16]
    COP [9F] ( #$0008 )
    COP [81] ( #10, #03 )
    COP [83]
    COP [87]
    COP [9F] ( #$FFF8 )
    COP [81] ( #11, #03 )
    COP [83]
    COP [9D] ( #11 )
    COP [9E] ( &code_01BA13 )
}

code_01BA13 {
    COP [87]
    COP [9F] ( #$0008 )
    COP [80] ( #0F )
    COP [82]
    COP [9F] ( #$FFF8 )
    BRL loc_01B99D

  loc_01BA25:
    COP [91]
    RTL 
}

code_01BA28 {
    COP [01] ( &asciistring_01BA6B )

  loc_01BA2C:
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01BA64 )
    LDA $L_choice_result
    BNE code_01BA64
    COP [01] ( &asciistring_01BAAA )
    LDA #$0000
    STA $APUIO0
    LDA $1B84
    PHA 
    LDA #$0005
    STA $1B84
    COP [01] ( &asciistring_01BAD8 )
    PLA 
    STA $1B84
    COP [01] ( &asciistring_01BAE1 )
    LDA #$0001
    STA $APUIO0
    COP [01] ( &asciistring_01BB03 )
    RTL 
}

code_01BA64 {
    COP [01] ( &asciistring_01BA8F )
    BRL loc_01BA2C
}

asciistring_01BA6B |[10]This is a restaurant- [N][::]Would you like to see [N]the menu? [END]|

asciistring_01BA8F |Come on! At least [N]take a look- [N][JMP:&asciistring_01BA6B+M]|

asciistring_01BAAA |Great! Let me tell [N]you our special of the[N]day------- [0E:78][END]|

asciistring_01BAD8 |[10]You! [0E:78][END]|

asciistring_01BAE1 |I m just kidding! [N]Please don t be [N]offended- [FIN][END]|

asciistring_01BB03 |[0E:8][10]This restaurant is [N]famous for delicious [N]food and fruit [N]drinks! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|