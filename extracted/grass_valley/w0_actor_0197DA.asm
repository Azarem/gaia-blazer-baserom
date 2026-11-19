?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

!joy_pressed                    0322
!joy_block_mask                 0326

---------------------------------------------

code_0197DA {
    COP [14] ( #$0022, &code_0197E1 ) ; {104410}
    RTL                   ; {104416}
}

code_0197E1 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {104417}
    COP [17] ( &code_019847 ) ; {104422}
    COP [15]              ; {104426}
    COP [91]              ; {104428}
    COP [0D] ( #00, #2F, #36, &code_0197F6 ) ; {104430}
    RTL                   ; {104437}
}

code_0197F6 {
    COP [03] ( #28 )      ; {104438}
    LDA $joy_pressed      ; {104441}
    AND #$0200            ; {104444}
    BEQ loc_019843        ; {104447}
    COP [0D] ( #00, #2F, #36, &code_01980B ) ; {104449}
    BRL loc_019843        ; {104456}
}

code_01980B {
    COP [04]              ; {104459}
    COP [16]              ; {104461}
    LDA #$2F80            ; {104463}
    TSB $joy_block_mask   ; {104466}
    COP [81] ( #20, #10 ) ; {104469}
    COP [83]              ; {104473}
    LDA #$2F80            ; {104475}
    TRB $joy_block_mask   ; {104478}
    COP [15]              ; {104481}
    COP [07] ( #$8206, &code_019840 ) ; {104483}
    COP [91]              ; {104489}
    COP [0D] ( #00, #2E, #36, &code_019833 ) ; {104491}
    RTL                   ; {104498}
}

code_019833 {
    COP [01] ( &asciistring_01986F ) ; {104499}
    BRK #$5E              ; {104503}
    COP [0A] ( #1B )      ; {104505}
    COP [09] ( #$8206 )   ; {104508}
}

code_019840 {
    COP [91]              ; {104512}
    RTL                   ; {104514}

  loc_019843:
    COP [27] ( &code_0197F6 ) ; {104515}
}

code_019847 {
    COP [19] ( #1C, &code_01985D ) ; {104519}
    COP [01] ( &asciistring_019880 ) ; {104524}
    COP [3C] ( #04 )      ; {104528}
    COP [10] ( #$0403, #00, #$0078, #$0070 ) ; {104531}
    RTL                   ; {104540}
}

code_01985D {
    COP [01] ( &asciistring_019862 ) ; {104541}
    RTL                   ; {104545}
}

asciistring_019862 |[10]Zzzz---- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01986F |[10]There is [03:24]a pass- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019880 |[10][02:2] placed [N]the Dream Rod on the [N]tulip s petal- [JMP:&w0_shared_01B988.asciistring_01B988]|