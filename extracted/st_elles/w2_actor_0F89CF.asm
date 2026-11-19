?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F89CF {
    COP [14] ( #$0095, &code_0F89D6 )
    RTL 
}

code_0F89D6 {
    COP [17] ( &code_0F89E4 )
    COP [15]

  loc_0F89DC:
    COP [80] ( #06 )
    COP [82]
    BRL loc_0F89DC
}

code_0F89E4 {
    COP [01] ( &asciistring_0F89E9 )
    RTL 
}

asciistring_0F89E9 |[10]Servas is the name of [N]my friend the dolphin-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|