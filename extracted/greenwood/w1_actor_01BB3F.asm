?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01D49D'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01BB3F {
    COP [14] ( #$004A, &code_01BB46 ) ; {113471}
    RTL                   ; {113477}
}

code_01BB46 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {113478}
    COP [17] ( &code_01BC1C ) ; {113483}
    COP [15]              ; {113487}
    COP [91]              ; {113489}
    COP [14] ( #$005D, &code_01BB5A ) ; {113491}
    RTL                   ; {113497}
}

code_01BB5A {
    COP [14] ( #$003F, &code_01BB61 ) ; {113498}
    RTL                   ; {113504}
}

code_01BB61 {
    COP [17] ( &code_01BC21 ) ; {113505}
    COP [05] ( #$0003 )   ; {113509}
    COP [16]              ; {113513}
    COP [17] ( #$0000 )   ; {113515}
    COP [A1] ( #$0008, #$0008 ) ; {113519}
    COP [81] ( #12, #03 ) ; {113525}
    COP [83]              ; {113529}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {113531}
    COP [87]              ; {113537}
    COP [81] ( #14, #03 ) ; {113539}
    COP [83]              ; {113543}
    COP [87]              ; {113545}
    COP [A1] ( #$0008, #$0008 ) ; {113547}
    COP [81] ( #13, #03 ) ; {113553}
    COP [83]              ; {113557}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {113559}
    COP [81] ( #14, #03 ) ; {113565}
    COP [83]              ; {113569}
    COP [85] ( @engine_0026F3.code_00299D ) ; {113571}
    BRK #$4E              ; {113576}
    COP [80] ( #02 )      ; {113578}
    COP [82]              ; {113581}
    COP [1B] ( &code_01BBB5, #$003C ) ; {113583}
}

code_01BBB5 {
    COP [09] ( #$8004 )   ; {113589}
    COP [80] ( #00 )      ; {113593}
    COP [82]              ; {113596}
    COP [15]              ; {113598}
    COP [17] ( &code_01BC21 ) ; {113600}
    COP [05] ( #$0006 )   ; {113604}
    COP [16]              ; {113608}
    COP [17] ( #$0000 )   ; {113610}
    COP [81] ( #05, #03 ) ; {113614}
    COP [83]              ; {113618}
    COP [80] ( #03 )      ; {113620}
    COP [82]              ; {113623}
    COP [87]              ; {113625}
    COP [80] ( #05 )      ; {113627}
    COP [82]              ; {113630}
    COP [87]              ; {113632}
    COP [80] ( #05 )      ; {113634}
    COP [82]              ; {113637}
    COP [80] ( #04 )      ; {113639}
    COP [82]              ; {113642}
    COP [81] ( #05, #03 ) ; {113644}
    COP [83]              ; {113648}
    COP [87]              ; {113650}
    COP [81] ( #05, #06 ) ; {113652}
    COP [83]              ; {113656}
    COP [80] ( #00 )      ; {113658}
    COP [82]              ; {113661}
    COP [15]              ; {113663}
    COP [17] ( &code_01BC26 ) ; {113665}
    COP [05] ( #$0007 )   ; {113669}
    COP [85] ( @engine_0026F3.code_00299D ) ; {113673}
    BRK #$4E              ; {113678}
    COP [80] ( #12 )      ; {113680}
    COP [82]              ; {113683}
    COP [17] ( &code_01BC33 ) ; {113685}
    COP [91]              ; {113689}
    RTL                   ; {113691}
}

code_01BC1C {
    COP [01] ( &asciistring_01BC47 ) ; {113692}
    RTL                   ; {113696}
}

code_01BC21 {
    COP [01] ( &asciistring_01BCBF ) ; {113697}
    RTL                   ; {113701}
}

code_01BC26 {
    COP [01] ( &w1_shared_01D49D.asciistring_01D49D ) ; {113702}
    COP [09] ( #$8006 )   ; {113706}
    COP [09] ( #$8007 )   ; {113710}
    RTL                   ; {113714}
}

code_01BC33 {
    COP [07] ( #$8000, &code_01BC42 ) ; {113715}
    COP [01] ( &w1_shared_01D49D.asciistring_01D4BB ) ; {113721}
    COP [17] ( &code_01BC42 ) ; {113725}
    RTL                   ; {113729}
}

code_01BC42 {
    COP [01] ( &w1_shared_01D49D.asciistring_01D4D0 ) ; {113730}
    RTL                   ; {113734}
}

asciistring_01BC47 |[10]Hello, I am a member [N]of the famous [N]"Woodstin+Trio-ˮ [FIN]We usually have a [N]variety show at this [N]theater, [FIN]but I am missing my [N]two sidekicks- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01BCBF |[10]Hey, don t walk [N]around, you re [N]annoying me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|