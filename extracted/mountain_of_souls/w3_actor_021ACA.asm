?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021ACA {
    COP [14] ( #$00F2, &code_021AD1 ) ; {137930}
    RTL                   ; {137936}
}

code_021AD1 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {137937}
    COP [17] ( &code_021B2E ) ; {137942}
    COP [15]              ; {137946}
    COP [05] ( #$0002 )   ; {137948}
    COP [17] ( #$0000 )   ; {137952}
    COP [16]              ; {137956}
    COP [96]              ; {137958}
    COP [81] ( #0B, #03 ) ; {137960}
    COP [83]              ; {137964}
    COP [81] ( #0A, #13 ) ; {137966}
    COP [83]              ; {137970}
    COP [97]              ; {137972}
    COP [81] ( #0B, #03 ) ; {137974}
    COP [83]              ; {137978}
    COP [80] ( #07 )      ; {137980}
    COP [82]              ; {137983}
    COP [15]              ; {137985}
    LDA $0016, X          ; {137987}
    AND #$FFF7            ; {137990}
    STA $0016, X          ; {137993}
    COP [17] ( &code_021B57 ) ; {137996}
    COP [05] ( #$0001 )   ; {138000}
    COP [16]              ; {138004}
    COP [96]              ; {138006}
    COP [81] ( #0B, #02 ) ; {138008}
    COP [83]              ; {138012}
    COP [81] ( #09, #04 ) ; {138014}
    COP [83]              ; {138018}
    COP [80] ( #08 )      ; {138020}
    COP [82]              ; {138023}
    COP [15]              ; {138025}
    COP [91]              ; {138027}
    RTL                   ; {138029}
}

code_021B2E {
    COP [14] ( #$00D4, &code_021B36 ) ; {138030}
    BRA loc_021B69        ; {138036}
}

code_021B36 {
    COP [14] ( #$00EF, &code_021B3E ) ; {138038}
    BRA loc_021B69        ; {138044}
}

code_021B3E {
    COP [14] ( #$00F0, &code_021B46 ) ; {138046}
    BRA loc_021B69        ; {138052}
}

code_021B46 {
    COP [14] ( #$00E9, &code_021B4E ) ; {138054}
    BRA loc_021B6E        ; {138060}
}

code_021B4E {
    COP [01] ( &asciistring_021B73 ) ; {138062}
    COP [09] ( #$8002 )   ; {138066}
    RTL                   ; {138070}
}

code_021B57 {
    COP [01] ( &asciistring_021BCE ) ; {138071}
    COP [09] ( #$8001 )   ; {138075}
    COP [17] ( &code_021B64 ) ; {138079}
    RTL                   ; {138083}
}

code_021B64 {
    COP [01] ( &asciistring_021C18 ) ; {138084}
    RTL                   ; {138088}

  loc_021B69:
    COP [01] ( &asciistring_021C24 ) ; {138089}
    RTL                   ; {138093}

  loc_021B6E:
    COP [01] ( &asciistring_021C68 ) ; {138094}
    RTL                   ; {138098}
}

asciistring_021B73 |[10]All the jockeys [N]are here and the race [N]track is finally [N]finished- [FIN]We are going to start [N]the race- Why don t [N]you come along? [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021BCE |[10]On your mark, [FIN]well everyone s on the[N]mark- [FIN]Okay, are you ready? [FIN]Get set, [N][0E:28]Go! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021C18 |[10]All right! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021C24 |[10]This is the race [N]track- [FIN]Not all the members [N]are ready, so I cannot[N]start the race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021C68 |[10]This is the race [N]track- [FIN]But the track is not [N]yet completed, so I [N]cannot start the race- [JMP:&w3_shared_02249A.asciistring_02251E]|