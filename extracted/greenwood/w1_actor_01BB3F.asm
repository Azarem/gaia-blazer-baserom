?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01D49D'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01BB3F {
    COP [14] ( #$004A, &code_01BB46 )
    RTL 
}

code_01BB46 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01BC1C )
    COP [15]
    COP [91]
    COP [14] ( #$005D, &code_01BB5A )
    RTL 
}

code_01BB5A {
    COP [14] ( #$003F, &code_01BB61 )
    RTL 
}

code_01BB61 {
    COP [17] ( &code_01BC21 )
    COP [05] ( #$0003 )
    COP [16]
    COP [17] ( #$0000 )
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #12, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [87]
    COP [81] ( #14, #03 )
    COP [83]
    COP [87]
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #13, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [81] ( #14, #03 )
    COP [83]
    COP [85] ( @engine_0026F3.code_00299D )
    BRK #$4E
    COP [80] ( #02 )
    COP [82]
    COP [1B] ( &code_01BBB5, #$003C )
}

code_01BBB5 {
    COP [09] ( #$8004 )
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01BC21 )
    COP [05] ( #$0006 )
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [87]
    COP [80] ( #05 )
    COP [82]
    COP [87]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    COP [81] ( #05, #03 )
    COP [83]
    COP [87]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01BC26 )
    COP [05] ( #$0007 )
    COP [85] ( @engine_0026F3.code_00299D )
    BRK #$4E
    COP [80] ( #12 )
    COP [82]
    COP [17] ( &code_01BC33 )
    COP [91]
    RTL 
}

code_01BC1C {
    COP [01] ( &asciistring_01BC47 )
    RTL 
}

code_01BC21 {
    COP [01] ( &asciistring_01BCBF )
    RTL 
}

code_01BC26 {
    COP [01] ( &w1_shared_01D49D.asciistring_01D49D )
    COP [09] ( #$8006 )
    COP [09] ( #$8007 )
    RTL 
}

code_01BC33 {
    COP [07] ( #$8000, &code_01BC42 )
    COP [01] ( &w1_shared_01D49D.asciistring_01D4BB )
    COP [17] ( &code_01BC42 )
    RTL 
}

code_01BC42 {
    COP [01] ( &w1_shared_01D49D.asciistring_01D4D0 )
    RTL 
}

asciistring_01BC47 |[10]Hello, I am a member [N]of the famous [N]"Woodstin+Trio-ˮ [FIN]We usually have a [N]variety show at this [N]theater, [FIN]but I am missing my [N]two sidekicks- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01BCBF |[10]Hey, don t walk [N]around, you re [N]annoying me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|