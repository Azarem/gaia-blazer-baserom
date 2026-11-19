?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022794 {
    COP [14] ( #$0114, &code_02279B )
    RTL 
}

code_02279B {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02282A )
    COP [07] ( #$8605, &code_022817 )
    COP [15]

  loc_0227AC:
    COP [19] ( #26, &code_0227B7 )
    COP [0C] ( #00, #02, &code_0227BE )
}

code_0227B7 {
    COP [80] ( #13 )
    COP [82]
    BRA loc_0227AC
}

code_0227BE {
    COP [91]
    COP [17] ( &code_02282F )

  code_0227C4:
    COP [0D] ( #05, #16, #10, &code_022809 )
    COP [9C] ( &code_0227D1, &code_0227ED )
}

code_0227D1 {
    COP [9A] ( #$0010, &code_0227DB, &code_0227ED, &code_0227E4 )
}

code_0227DB {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0227C4
}

code_0227E4 {
    COP [96]
    COP [80] ( #12 )
    COP [82]
    BRA code_0227C4
}

code_0227ED {
    COP [9B] ( #$0010, &code_0227F7, &code_022805, &code_0227FE )
}

code_0227F7 {
    COP [80] ( #11 )
    COP [82]
    BRA code_0227C4
}

code_0227FE {
    COP [80] ( #10 )
    COP [82]
    BRA code_0227C4
}

code_022805 {
    COP [27] ( &code_0227C4 )
}

code_022809 {
    COP [97]
    COP [81] ( #12, #02 )
    COP [83]
    COP [09] ( #$8605 )
    BRA loc_02281C
}

code_022817 {
    COP [11] ( #05, #14, #11 )

  loc_02281C:
    COP [17] ( &code_02282F )
    COP [15]
    COP [91]
    COP [80] ( #13 )
    COP [82]
    RTL 
}

code_02282A {
    COP [01] ( &asciistring_022834 )
    RTL 
}

code_02282F {
    COP [01] ( &asciistring_02286C )
    RTL 
}

asciistring_022834 |[10]We don t really [N]like to chase rats- [FIN]Cats just have to eat [N]in order to live- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02286C |[10]What a pleasant smell- [JMP:&w4_shared_023F33.asciistring_023FA3]|