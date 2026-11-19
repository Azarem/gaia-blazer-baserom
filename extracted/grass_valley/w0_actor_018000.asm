?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

!joy_pressed                    0322

---------------------------------------------

code_018000 {
    COP [14] ( #$0029, &code_018007 ) ; {98304}
    RTL                   ; {98310}
}

code_018007 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {98311}
    COP [17] ( &code_018036 ) ; {98316}
    COP [15]              ; {98320}
    COP [05] ( #$0000 )   ; {98322}
    COP [8F]              ; {98326}
    COP [80] ( #02 )      ; {98328}
    COP [82]              ; {98331}
    COP [91]              ; {98333}
    LDA $joy_pressed      ; {98335}
    AND #$0030            ; {98338}
    BNE loc_018028        ; {98341}
    RTL                   ; {98343}

  loc_018028:
    LDA $joy_pressed      ; {98344}
    AND #$0F00            ; {98347}
    BNE loc_018031        ; {98350}
    RTL                   ; {98352}

  loc_018031:
    COP [17] ( &code_01803F ) ; {98353}
    RTL                   ; {98357}
}

code_018036 {
    COP [01] ( &asciistring_018044 ) ; {98358}
    COP [09] ( #$8000 )   ; {98362}
    RTL                   ; {98366}
}

code_01803F {
    COP [01] ( &asciistring_0180B7 ) ; {98367}
    RTL                   ; {98371}
}

asciistring_018044 |[10]Hey, you look like you[N]would be good at crab+[N]walking- [N]Try it- [FIN]You don t know how? [N]Just walk while [N]pressing either [N]the L or R button- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0180B7 |[10]See, I knew you could[N]do it! [FIN]This will help you [N]when you are fighting [N]or using magic- [JMP:&w0_shared_01B988.asciistring_01B988]|