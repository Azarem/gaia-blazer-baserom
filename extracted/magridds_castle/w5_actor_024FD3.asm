?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024FD3 {
    COP [14] ( #$016B, &code_024FDA )
    RTL 
}

code_024FDA {
    COP [14] ( #$0185, &code_024FE9 )
    COP [17] ( &code_025015 )
    COP [15]
    COP [91]
    RTL 
}

code_024FE9 {
    COP [A1] ( #$0010, #$0030 )
    COP [17] ( &code_02501A )
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [91]
    COP [0D] ( #00, #1C, #33, &code_025006 )
    RTL 
}

code_025006 {
    COP [03] ( #05 )
    COP [04]
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [91]
    RTL 
}

code_025015 {
    COP [01] ( &asciistring_02501F )
    RTL 
}

code_02501A {
    COP [01] ( &asciistring_025053 )
    RTL 
}

asciistring_02501F |[10]This is the [N]soldiers  dormitory- [FIN]I am taking care of [N]them- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025053 |[10]Oh, I was just [N]removing a speck of [N]dust from his eye- [JMP:&w5_shared_02706C.asciistring_0270DF]|