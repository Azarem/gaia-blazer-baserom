?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0
!joy_block_mask                 0326

---------------------------------------------

code_0F98F5 {
    COP [14] ( #$008A, &code_0F98FC ) ; {1022197}
    RTL                   ; {1022203}
}

code_0F98FC {
    COP [18] ( #24, &code_0F9903 ) ; {1022204}
    BRA code_0F997F       ; {1022209}
}

code_0F9903 {
    COP [0D] ( #00, #0A, #27, &code_0F997F ) ; {1022211}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1022218}
    COP [17] ( &code_0F99A2 ) ; {1022223}
    COP [15]              ; {1022227}

  code_0F9915:
    COP [80] ( #01 )      ; {1022229}
    COP [82]              ; {1022232}
    COP [07] ( #$0002, &code_0F9915 ) ; {1022234}
    COP [16]              ; {1022240}
    COP [9F] ( #$FFF8 )   ; {1022242}
    COP [80] ( #05 )      ; {1022246}
    COP [82]              ; {1022249}
    COP [9F] ( #$0008 )   ; {1022251}
    COP [81] ( #04, #02 ) ; {1022255}
    COP [83]              ; {1022259}
    COP [80] ( #00 )      ; {1022261}
    COP [82]              ; {1022264}
    COP [01] ( &asciistring_0F9A0F ) ; {1022266}
    BRK #$4E              ; {1022270}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1022272}
    COP [81] ( #19, #02 ) ; {1022277}
    COP [83]              ; {1022281}
    BRK #$4E              ; {1022283}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1022285}
    COP [80] ( #18 )      ; {1022290}
    COP [82]              ; {1022293}
    COP [01] ( &asciistring_0F9A3F ) ; {1022295}
    BRK #$4E              ; {1022299}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1022301}
    COP [80] ( #00 )      ; {1022306}
    COP [82]              ; {1022309}
    COP [01] ( &asciistring_0F9A6F ) ; {1022311}
    LDA #$2F80            ; {1022315}
    TRB $joy_block_mask   ; {1022318}
    COP [17] ( &code_0F99D1 ) ; {1022321}
    COP [15]              ; {1022325}
    COP [91]              ; {1022327}
    COP [80] ( #00 )      ; {1022329}
    COP [82]              ; {1022332}
    RTL                   ; {1022334}
}

code_0F997F {
    COP [16]              ; {1022335}
    COP [17] ( &code_0F99D1 ) ; {1022337}
    COP [9F] ( #$FFF8 )   ; {1022341}
    COP [80] ( #05 )      ; {1022345}
    COP [82]              ; {1022348}
    COP [9F] ( #$0008 )   ; {1022350}
    COP [81] ( #04, #02 ) ; {1022354}
    COP [83]              ; {1022358}
    COP [15]              ; {1022360}
    COP [91]              ; {1022362}
    COP [80] ( #00 )      ; {1022364}
    COP [82]              ; {1022367}
    RTL                   ; {1022369}
}

code_0F99A2 {
    COP [01] ( &asciistring_0F99E0 ) ; {1022370}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0F99B6 ) ; {1022374}
    LDA $L_choice_result  ; {1022381}
    BNE code_0F99B6       ; {1022385}
    BRL loc_0F99C9        ; {1022387}
}

code_0F99B6 {
    COP [01] ( &asciistring_0F9A00 ) ; {1022390}
    COP [17] ( #$0000 )   ; {1022394}
    COP [09] ( #$8002 )   ; {1022398}
    LDA #$2F80            ; {1022402}
    TSB $joy_block_mask   ; {1022405}
    RTL                   ; {1022408}

  loc_0F99C9:
    COP [01] ( &asciistring_0F9AA7 ) ; {1022409}
    COP [27] ( &code_0F997F ) ; {1022413}
}

code_0F99D1 {
    COP [18] ( #24, &code_0F99DB ) ; {1022417}
    COP [01] ( &asciistring_0F9AAB ) ; {1022422}
    RTL                   ; {1022426}
}

code_0F99DB {
    COP [01] ( &asciistring_0F9AA7 ) ; {1022427}
    RTL                   ; {1022431}
}

asciistring_0F99E0 |[10]Have you seen the [N]Queen of the Mermaids?[END]|

asciistring_0F9A00 |Okay, wait- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9A0F |[10][0A]This█is█a█secret,█the[N]Queen█looks█like█this-[FIN][END]|

asciistring_0F9A3F |[0A]She█always█sits█like[N]this-[N]She█looks█so█mean-[FIN][END]|

asciistring_0F9A6F |[0A]Lue,█the█dolphin█has[N]been█captured![N]Please█save█him![JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9AA7 |[10][JMP:&asciistring_0F9A6F]|

asciistring_0F9AAB |[10]Lue can leave whenever[N]he wishes, but he [N]never comes out- [FIN]Maybe he likes that [N]place- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|