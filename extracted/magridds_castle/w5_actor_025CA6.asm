?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025CA6 {
    COP [14] ( #$0181, &code_025CAD )
    RTL 
}

code_025CAD {
    COP [07] ( #$8805, &code_025D40 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [05] ( #$0001 )
    COP [03] ( #65 )
    COP [04]
    COP [16]
    COP [96]
    COP [81] ( #2A, #02 )
    COP [83]
    COP [01] ( &asciistring_025D43 )
    COP [32] ( #0D )
    COP [B2] ( @code_025DA5, #$0080, #$FFF0, #$0040 )
    COP [B2] ( @code_025DCE, #$0080, #$0000, #$0040 )
    COP [B2] ( @code_025DFD, #$0080, #$0010, #$0040 )
    COP [B2] ( @code_025E26, #$0090, #$0000, #$0040 )
    COP [05] ( #$0002 )
    COP [01] ( &asciistring_025D4D )
    COP [09] ( #$8003 )
    COP [03] ( #03 )
    COP [05] ( #$0000 )
    COP [09] ( #$0000 )
    LDA $0000, X
    SEC 
    SBC #$0002
    STA $0000, X
    BRK #$44
    COP [04]
    COP [05] ( #$0004 )
    COP [96]
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #29, #08 )
    COP [83]
    COP [09] ( #$8005 )
}

code_025D40 {
    COP [86]
    RTL 
}

asciistring_025D43 |[10]Dok!! [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025D4D |[10]You are Queen Magridd![FIN]You destroyed the [N]world! [N]Didn t you realize?! [FIN][10]Shut up wimp! [FIN]Defeat him! [JMP:&w5_shared_02706C.asciistring_0270DF]|

code_025DA5 {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @code_025E4B, #$0040 )
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025DCE {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @code_025E54, #$0040 )
    BRK #$1B
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [09] ( #$8004 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025DFD {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @code_025E4B, #$0040 )
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025E26 {
    COP [03] ( #51 )
    COP [04]
    COP [AA] ( #00 )
    COP [97]
    COP [81] ( #1A, #02 )
    COP [83]
    COP [80] ( #11 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [09] ( #$8002 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

code_025E4B {
    COP [81] ( #25, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_025E54 {
    COP [81] ( #25, #07 )
    COP [83]
    COP [09] ( #$8000 )
    COP [86]
    RTL 
}