?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w0_actor_0191D2_part3'
?INCLUDE 'w1_shared_01D49D'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D045 {
    COP [3B] ( #$005D, &code_01D05B ) ; {118853}
    COP [17] ( &w0_actor_0191D2_part3.code_01B191 ) ; {118859}
    SEP #$20              ; {118863}
    LDA #$^engine_003005.code_00305F ; {118865}
    PHA                   ; {118867}
    REP #$20              ; {118868}
    LDA #$&engine_003005.code_00305F-1 ; {118870}
    PHA                   ; {118873}
    RTL                   ; {118874}
}

code_01D05B {
    COP [85] ( @engine_0026F3.code_00299D ) ; {118875}
    COP [15]              ; {118880}
    COP [17] ( &code_01D0DE ) ; {118882}
    COP [91]              ; {118886}
    COP [14] ( #$004A, &code_01D06F ) ; {118888}
    RTL                   ; {118894}
}

code_01D06F {
    COP [14] ( #$003F, &code_01D076 ) ; {118895}
    RTL                   ; {118901}
}

code_01D076 {
    COP [17] ( &code_01D0E3 ) ; {118902}
    COP [05] ( #$0005 )   ; {118906}
    COP [09] ( #$0005 )   ; {118910}
    COP [16]              ; {118914}
    COP [81] ( #04, #02 ) ; {118916}
    COP [83]              ; {118920}
    COP [80] ( #00 )      ; {118922}
    COP [82]              ; {118925}
    COP [17] ( &code_01D0F0 ) ; {118927}
    COP [15]              ; {118931}
    RTL                   ; {118933}
}

code_01D096 {
    COP [16]              ; {118934}
    COP [17] ( #$0000 )   ; {118936}
    COP [81] ( #05, #03 ) ; {118940}
    COP [83]              ; {118944}
    COP [80] ( #03 )      ; {118946}
    COP [82]              ; {118949}
    COP [09] ( #$0006 )   ; {118951}
    COP [87]              ; {118955}
    COP [81] ( #05, #06 ) ; {118957}
    COP [83]              ; {118961}
    COP [80] ( #04 )      ; {118963}
    COP [82]              ; {118966}
    COP [87]              ; {118968}
    COP [81] ( #05, #03 ) ; {118970}
    COP [83]              ; {118974}
    COP [87]              ; {118976}
    COP [81] ( #05, #03 ) ; {118978}
    COP [83]              ; {118982}
    COP [80] ( #00 )      ; {118984}
    COP [82]              ; {118987}
    COP [15]              ; {118989}
    COP [17] ( &code_01D101 ) ; {118991}
    COP [05] ( #$0007 )   ; {118995}
    COP [17] ( &code_01D10E ) ; {118999}
    COP [91]              ; {119003}
    RTL                   ; {119005}
}

code_01D0DE {
    COP [01] ( &asciistring_01D134 ) ; {119006}
    RTL                   ; {119010}
}

code_01D0E3 {
    COP [01] ( &asciistring_01D174 ) ; {119011}
    COP [17] ( #$0000 )   ; {119015}
    COP [09] ( #$8003 )   ; {119019}
    RTL                   ; {119023}
}

code_01D0F0 {
    COP [01] ( &asciistring_01D1E5 ) ; {119024}
    COP [09] ( #$8006 )   ; {119028}
    COP [27] ( &code_01D096 ) ; {119032}
    COP [01] ( &asciistring_01D291 ) ; {119036}
    RTL                   ; {119040}
}

code_01D101 {
    COP [01] ( &w1_shared_01D49D.asciistring_01D49D ) ; {119041}
    COP [09] ( #$8000 )   ; {119045}
    COP [09] ( #$8007 )   ; {119049}
    RTL                   ; {119053}
}

code_01D10E {
    COP [07] ( #$8006, &code_01D126 ) ; {119054}
    COP [09] ( #$8006 )   ; {119060}
    COP [01] ( &asciistring_01D291 ) ; {119064}
    BRK #$5E              ; {119068}
    COP [0A] ( #38 )      ; {119070}
    COP [17] ( &code_01D12F ) ; {119073}
    RTL                   ; {119077}
}

code_01D126 {
    COP [01] ( &asciistring_01D2D3 ) ; {119078}
    COP [17] ( &code_01D12F ) ; {119082}
    RTL                   ; {119086}
}

code_01D12F {
    COP [01] ( &w1_shared_01D49D.asciistring_01D4D0 ) ; {119087}
    RTL                   ; {119091}
}

asciistring_01D134 |[10]I am Billy, leader of [N]the "Woodstin+Trioˮ, -[N]Our show is really [N]exciting! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D174 |[10]The band is back [N]together, so let s [N]start the show! [FIN]Even though you are [N]our only audience we [N]will try our best- [FIN]Please watch the two [N]other guys- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D1E5 |[10]How did you like it? [FIN]For our next number [N]you must try and guess[N]the real squirrel, me-[FIN]We will move around [N]and if you choose [N]correctly, you will [N]win a prize- [FIN]Please talk with whom [N]you think the real [N]squirrel is- [FIN]Here we go! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D291 |[10]You re right!! [N]Okay, I will give you [N]a present- [FIN][02:2] received [N][03:24]the Medical Herb- [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D2D3 |[10]Too bad, but please [N]try again soon- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|