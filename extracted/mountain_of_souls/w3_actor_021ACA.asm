?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021ACA {
    COP [14] ( #$00F2, &code_021AD1 )
    RTL 
}

code_021AD1 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_021B2E )
    COP [15]
    COP [05] ( #$0002 )
    COP [17] ( #$0000 )
    COP [16]
    COP [96]
    COP [81] ( #0B, #03 )
    COP [83]
    COP [81] ( #0A, #13 )
    COP [83]
    COP [97]
    COP [81] ( #0B, #03 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    COP [15]
    LDA $0016, X
    AND #$FFF7
    STA $0016, X
    COP [17] ( &code_021B57 )
    COP [05] ( #$0001 )
    COP [16]
    COP [96]
    COP [81] ( #0B, #02 )
    COP [83]
    COP [81] ( #09, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_021B2E {
    COP [14] ( #$00D4, &code_021B36 )
    BRA loc_021B69
}

code_021B36 {
    COP [14] ( #$00EF, &code_021B3E )
    BRA loc_021B69
}

code_021B3E {
    COP [14] ( #$00F0, &code_021B46 )
    BRA loc_021B69
}

code_021B46 {
    COP [14] ( #$00E9, &code_021B4E )
    BRA loc_021B6E
}

code_021B4E {
    COP [01] ( &asciistring_021B73 )
    COP [09] ( #$8002 )
    RTL 
}

code_021B57 {
    COP [01] ( &asciistring_021BCE )
    COP [09] ( #$8001 )
    COP [17] ( &code_021B64 )
    RTL 
}

code_021B64 {
    COP [01] ( &asciistring_021C18 )
    RTL 

  loc_021B69:
    COP [01] ( &asciistring_021C24 )
    RTL 

  loc_021B6E:
    COP [01] ( &asciistring_021C68 )
    RTL 
}

asciistring_021B73 |[10]All the jockeys [N]are here and the race [N]track is finally [N]finished- [FIN]We are going to start [N]the race- Why don t [N]you come along? [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021BCE |[10]On your mark, [FIN]well everyone s on the[N]mark- [FIN]Okay, are you ready? [FIN]Get set, [N][0E:28]Go! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021C18 |[10]All right! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021C24 |[10]This is the race [N]track- [FIN]Not all the members [N]are ready, so I cannot[N]start the race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021C68 |[10]This is the race [N]track- [FIN]But the track is not [N]yet completed, so I [N]cannot start the race- [JMP:&w3_shared_02249A.asciistring_02251E]|