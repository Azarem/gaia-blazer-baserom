?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

!joy_pressed                    0322

---------------------------------------------

code_018000 {
    COP [14] ( #$0029, &code_018007 )
    RTL 
}

code_018007 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_018036 )
    COP [15]
    COP [05] ( #$0000 )
    COP [8F]
    COP [80] ( #02 )
    COP [82]
    COP [91]
    LDA $joy_pressed
    AND #$0030
    BNE loc_018028
    RTL 

  loc_018028:
    LDA $joy_pressed
    AND #$0F00
    BNE loc_018031
    RTL 

  loc_018031:
    COP [17] ( &code_01803F )
    RTL 
}

code_018036 {
    COP [01] ( &asciistring_018044 )
    COP [09] ( #$8000 )
    RTL 
}

code_01803F {
    COP [01] ( &asciistring_0180B7 )
    RTL 
}

asciistring_018044 |[10]Hey, you look like you[N]would be good at crab+[N]walking- [N]Try it- [FIN]You don t know how? [N]Just walk while [N]pressing either [N]the L or R button- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0180B7 |[10]See, I knew you could[N]do it! [FIN]This will help you [N]when you are fighting [N]or using magic- [JMP:&w0_shared_01B988.asciistring_01B988]|