?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024416 {
    COP [14] ( #$0162, &code_02441D )
    RTL 
}

code_02441D {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0244C5 )

  loc_024426:
    COP [97]
    COP [81] ( #17, #08 )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #12 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #15, #0B )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #12 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #17, #10 )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #16, #0B )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #17, #08 )
    COP [83]
    BRL loc_024426
}

code_0244C5 {
    COP [01] ( &asciistring_0244CA )
    RTL 
}

asciistring_0244CA |[10]I am guarding [N]the castle- [N]Don t talk to me- [JMP:&w5_shared_02706C.asciistring_0270DF]|