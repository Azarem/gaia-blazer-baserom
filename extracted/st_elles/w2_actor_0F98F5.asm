?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0
!joy_block_mask                 0326

---------------------------------------------

code_0F98F5 {
    COP [14] ( #$008A, &code_0F98FC )
    RTL 
}

code_0F98FC {
    COP [18] ( #24, &code_0F9903 )
    BRA code_0F997F
}

code_0F9903 {
    COP [0D] ( #00, #0A, #27, &code_0F997F )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F99A2 )
    COP [15]

  code_0F9915:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0002, &code_0F9915 )
    COP [16]
    COP [9F] ( #$FFF8 )
    COP [80] ( #05 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [81] ( #04, #02 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [01] ( &asciistring_0F9A0F )
    BRK #$4E
    COP [85] ( @engine_0026F3.code_00299D )
    COP [81] ( #19, #02 )
    COP [83]
    BRK #$4E
    COP [85] ( @engine_0026F3.code_00299D )
    COP [80] ( #18 )
    COP [82]
    COP [01] ( &asciistring_0F9A3F )
    BRK #$4E
    COP [85] ( @engine_0026F3.code_00299D )
    COP [80] ( #00 )
    COP [82]
    COP [01] ( &asciistring_0F9A6F )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_0F99D1 )
    COP [15]
    COP [91]
    COP [80] ( #00 )
    COP [82]
    RTL 
}

code_0F997F {
    COP [16]
    COP [17] ( &code_0F99D1 )
    COP [9F] ( #$FFF8 )
    COP [80] ( #05 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [81] ( #04, #02 )
    COP [83]
    COP [15]
    COP [91]
    COP [80] ( #00 )
    COP [82]
    RTL 
}

code_0F99A2 {
    COP [01] ( &asciistring_0F99E0 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0F99B6 )
    LDA $L_choice_result
    BNE code_0F99B6
    BRL loc_0F99C9
}

code_0F99B6 {
    COP [01] ( &asciistring_0F9A00 )
    COP [17] ( #$0000 )
    COP [09] ( #$8002 )
    LDA #$2F80
    TSB $joy_block_mask
    RTL 

  loc_0F99C9:
    COP [01] ( &asciistring_0F9AA7 )
    COP [27] ( &code_0F997F )
}

code_0F99D1 {
    COP [18] ( #24, &code_0F99DB )
    COP [01] ( &asciistring_0F9AAB )
    RTL 
}

code_0F99DB {
    COP [01] ( &asciistring_0F9AA7 )
    RTL 
}

asciistring_0F99E0 |[10]Have you seen the [N]Queen of the Mermaids?[END]|

asciistring_0F9A00 |Okay, wait- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9A0F |[10][0A]This█is█a█secret,█the[N]Queen█looks█like█this-[FIN][END]|

asciistring_0F9A3F |[0A]She█always█sits█like[N]this-[N]She█looks█so█mean-[FIN][END]|

asciistring_0F9A6F |[0A]Lue,█the█dolphin█has[N]been█captured![N]Please█save█him![JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9AA7 |[10][JMP:&asciistring_0F9A6F]|

asciistring_0F9AAB |[10]Lue can leave whenever[N]he wishes, but he [N]never comes out- [FIN]Maybe he likes that [N]place- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|