?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F89CF {
    COP [14] ( #$0095, &code_0F89D6 ) ; {1018319}
    RTL                   ; {1018325}
}

code_0F89D6 {
    COP [17] ( &code_0F89E4 ) ; {1018326}
    COP [15]              ; {1018330}

  loc_0F89DC:
    COP [80] ( #06 )      ; {1018332}
    COP [82]              ; {1018335}
    BRL loc_0F89DC        ; {1018337}
}

code_0F89E4 {
    COP [01] ( &asciistring_0F89E9 ) ; {1018340}
    RTL                   ; {1018344}
}

asciistring_0F89E9 |[10]Servas is the name of [N]my friend the dolphin-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|