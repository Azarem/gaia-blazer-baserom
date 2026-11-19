?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w0_actor_0191D2_part3'
?INCLUDE 'w1_shared_01D49D'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D2F3 {
    COP [3B] ( #$003F, &code_01D309 ) ; {119539}
    COP [17] ( &w0_actor_0191D2_part3.code_01B191 ) ; {119545}
    SEP #$20              ; {119549}
    LDA #$^engine_003005.code_00305F ; {119551}
    PHA                   ; {119553}
    REP #$20              ; {119554}
    LDA #$&engine_003005.code_00305F-1 ; {119556}
    PHA                   ; {119559}
    RTL                   ; {119560}
}

code_01D309 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {119561}
    COP [17] ( &code_01D3E5 ) ; {119566}
    COP [15]              ; {119570}
    COP [91]              ; {119572}
    COP [14] ( #$005D, &code_01D31D ) ; {119574}
    RTL                   ; {119580}
}

code_01D31D {
    COP [14] ( #$004A, &code_01D324 ) ; {119581}
    RTL                   ; {119587}
}

code_01D324 {
    COP [17] ( &code_01D3EA ) ; {119588}
    COP [05] ( #$0004 )   ; {119592}
    COP [16]              ; {119596}
    COP [17] ( #$0000 )   ; {119598}
    COP [A1] ( #$0008, #$0008 ) ; {119602}
    COP [81] ( #0C, #03 ) ; {119608}
    COP [83]              ; {119612}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {119614}
    COP [87]              ; {119620}
    COP [81] ( #0E, #03 ) ; {119622}
    COP [83]              ; {119626}
    COP [87]              ; {119628}
    COP [A1] ( #$0008, #$0008 ) ; {119630}
    COP [81] ( #0D, #03 ) ; {119636}
    COP [83]              ; {119640}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {119642}
    COP [81] ( #0E, #03 ) ; {119648}
    COP [83]              ; {119652}
    COP [9F] ( #$0010 )   ; {119654}
    COP [85] ( @engine_0026F3.code_00299D ) ; {119658}
    BRK #$4E              ; {119663}
    COP [80] ( #02 )      ; {119665}
    COP [82]              ; {119668}
    COP [1B] ( &code_01D37C, #$003C ) ; {119670}
}

code_01D37C {
    COP [09] ( #$8005 )   ; {119676}
    COP [80] ( #00 )      ; {119680}
    COP [82]              ; {119683}
    COP [15]              ; {119685}
    COP [17] ( &code_01D3EA ) ; {119687}
    COP [05] ( #$0006 )   ; {119691}
    COP [16]              ; {119695}
    COP [17] ( #$0000 )   ; {119697}
    COP [80] ( #03 )      ; {119701}
    COP [82]              ; {119704}
    COP [81] ( #05, #06 ) ; {119706}
    COP [83]              ; {119710}
    COP [80] ( #04 )      ; {119712}
    COP [82]              ; {119715}
    COP [87]              ; {119717}
    COP [81] ( #05, #03 ) ; {119719}
    COP [83]              ; {119723}
    COP [80] ( #03 )      ; {119725}
    COP [82]              ; {119728}
    COP [80] ( #05 )      ; {119730}
    COP [82]              ; {119733}
    COP [87]              ; {119735}
    COP [80] ( #05 )      ; {119737}
    COP [82]              ; {119740}
    COP [80] ( #04 )      ; {119742}
    COP [82]              ; {119745}
    COP [80] ( #00 )      ; {119747}
    COP [82]              ; {119750}
    COP [15]              ; {119752}
    COP [17] ( &code_01D3EF ) ; {119754}
    COP [05] ( #$0007 )   ; {119758}
    COP [85] ( @engine_0026F3.code_00299D ) ; {119762}
    BRK #$4E              ; {119767}
    COP [80] ( #0C )      ; {119769}
    COP [82]              ; {119772}
    COP [17] ( &code_01D3FC ) ; {119774}
    COP [91]              ; {119778}
    RTL                   ; {119780}
}

code_01D3E5 {
    COP [01] ( &asciistring_01D410 ) ; {119781}
    RTL                   ; {119785}
}

code_01D3EA {
    COP [01] ( &asciistring_01D481 ) ; {119786}
    RTL                   ; {119790}
}

code_01D3EF {
    COP [01] ( &w1_shared_01D49D.asciistring_01D49D ) ; {119791}
    COP [09] ( #$8006 )   ; {119795}
    COP [09] ( #$8007 )   ; {119799}
    RTL                   ; {119803}
}

code_01D3FC {
    COP [07] ( #$8000, &code_01D40B ) ; {119804}
    COP [01] ( &w1_shared_01D49D.asciistring_01D4BB ) ; {119810}
    COP [17] ( &code_01D40B ) ; {119814}
    RTL                   ; {119818}
}

code_01D40B {
    COP [01] ( &w1_shared_01D49D.asciistring_01D4D0 ) ; {119819}
    RTL                   ; {119823}
}

asciistring_01D410 |[10]I am a member of the [N]"Woodstin+Trio-ˮ [N]We put on a variety [N]show in this theater- [FIN]I need my other two [N]band members to start [N]the show- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D481 |[10]Hey, don t walk around[N]here- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|