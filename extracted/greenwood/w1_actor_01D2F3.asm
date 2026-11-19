?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w0_actor_0191D2_part3'
?INCLUDE 'w1_shared_01D49D'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D2F3 {
    COP [3B] ( #$003F, &code_01D309 )
    COP [17] ( &w0_actor_0191D2_part3.code_01B191 )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_01D309 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01D3E5 )
    COP [15]
    COP [91]
    COP [14] ( #$005D, &code_01D31D )
    RTL 
}

code_01D31D {
    COP [14] ( #$004A, &code_01D324 )
    RTL 
}

code_01D324 {
    COP [17] ( &code_01D3EA )
    COP [05] ( #$0004 )
    COP [16]
    COP [17] ( #$0000 )
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #0C, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [87]
    COP [81] ( #0E, #03 )
    COP [83]
    COP [87]
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #0D, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [81] ( #0E, #03 )
    COP [83]
    COP [9F] ( #$0010 )
    COP [85] ( @engine_0026F3.code_00299D )
    BRK #$4E
    COP [80] ( #02 )
    COP [82]
    COP [1B] ( &code_01D37C, #$003C )
}

code_01D37C {
    COP [09] ( #$8005 )
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D3EA )
    COP [05] ( #$0006 )
    COP [16]
    COP [17] ( #$0000 )
    COP [80] ( #03 )
    COP [82]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    COP [87]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D3EF )
    COP [05] ( #$0007 )
    COP [85] ( @engine_0026F3.code_00299D )
    BRK #$4E
    COP [80] ( #0C )
    COP [82]
    COP [17] ( &code_01D3FC )
    COP [91]
    RTL 
}

code_01D3E5 {
    COP [01] ( &asciistring_01D410 )
    RTL 
}

code_01D3EA {
    COP [01] ( &asciistring_01D481 )
    RTL 
}

code_01D3EF {
    COP [01] ( &w1_shared_01D49D.asciistring_01D49D )
    COP [09] ( #$8006 )
    COP [09] ( #$8007 )
    RTL 
}

code_01D3FC {
    COP [07] ( #$8000, &code_01D40B )
    COP [01] ( &w1_shared_01D49D.asciistring_01D4BB )
    COP [17] ( &code_01D40B )
    RTL 
}

code_01D40B {
    COP [01] ( &w1_shared_01D49D.asciistring_01D4D0 )
    RTL 
}

asciistring_01D410 |[10]I am a member of the [N]"Woodstin+Trio-ˮ [N]We put on a variety [N]show in this theater- [FIN]I need my other two [N]band members to start [N]the show- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D481 |[10]Hey, don t walk around[N]here- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|