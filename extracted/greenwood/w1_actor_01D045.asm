?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w0_actor_0191D2_part3'
?INCLUDE 'w1_shared_01D49D'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D045 {
    COP [3B] ( #$005D, &code_01D05B )
    COP [17] ( &w0_actor_0191D2_part3.code_01B191 )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_01D05B {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [17] ( &code_01D0DE )
    COP [91]
    COP [14] ( #$004A, &code_01D06F )
    RTL 
}

code_01D06F {
    COP [14] ( #$003F, &code_01D076 )
    RTL 
}

code_01D076 {
    COP [17] ( &code_01D0E3 )
    COP [05] ( #$0005 )
    COP [09] ( #$0005 )
    COP [16]
    COP [81] ( #04, #02 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [17] ( &code_01D0F0 )
    COP [15]
    RTL 
}

code_01D096 {
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [09] ( #$0006 )
    COP [87]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D101 )
    COP [05] ( #$0007 )
    COP [17] ( &code_01D10E )
    COP [91]
    RTL 
}

code_01D0DE {
    COP [01] ( &asciistring_01D134 )
    RTL 
}

code_01D0E3 {
    COP [01] ( &asciistring_01D174 )
    COP [17] ( #$0000 )
    COP [09] ( #$8003 )
    RTL 
}

code_01D0F0 {
    COP [01] ( &asciistring_01D1E5 )
    COP [09] ( #$8006 )
    COP [27] ( &code_01D096 )
    COP [01] ( &asciistring_01D291 )
    RTL 
}

code_01D101 {
    COP [01] ( &w1_shared_01D49D.asciistring_01D49D )
    COP [09] ( #$8000 )
    COP [09] ( #$8007 )
    RTL 
}

code_01D10E {
    COP [07] ( #$8006, &code_01D126 )
    COP [09] ( #$8006 )
    COP [01] ( &asciistring_01D291 )
    BRK #$5E
    COP [0A] ( #38 )
    COP [17] ( &code_01D12F )
    RTL 
}

code_01D126 {
    COP [01] ( &asciistring_01D2D3 )
    COP [17] ( &code_01D12F )
    RTL 
}

code_01D12F {
    COP [01] ( &w1_shared_01D49D.asciistring_01D4D0 )
    RTL 
}

asciistring_01D134 |[10]I am Billy, leader of [N]the "Woodstin+Trioˮ, -[N]Our show is really [N]exciting! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D174 |[10]The band is back [N]together, so let s [N]start the show! [FIN]Even though you are [N]our only audience we [N]will try our best- [FIN]Please watch the two [N]other guys- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D1E5 |[10]How did you like it? [FIN]For our next number [N]you must try and guess[N]the real squirrel, me-[FIN]We will move around [N]and if you choose [N]correctly, you will [N]win a prize- [FIN]Please talk with whom [N]you think the real [N]squirrel is- [FIN]Here we go! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D291 |[10]You re right!! [N]Okay, I will give you [N]a present- [FIN][02:2] received [N][03:24]the Medical Herb- [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D2D3 |[10]Too bad, but please [N]try again soon- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|