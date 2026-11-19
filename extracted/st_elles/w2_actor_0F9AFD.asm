?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F9AFD {
    COP [14] ( #$00BB, &code_0F9B04 ) ; {1022717}
    RTL                   ; {1022723}
}

code_0F9B04 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1022724}
    COP [15]              ; {1022729}
    COP [17] ( &code_0F9B17 ) ; {1022731}

  loc_0F9B0F:
    COP [80] ( #11 )      ; {1022735}
    COP [82]              ; {1022738}
    BRL loc_0F9B0F        ; {1022740}
}

code_0F9B17 {
    COP [07] ( #$8506, &code_0F9B38 ) ; {1022743}
    COP [19] ( #1C, &code_0F9B33 ) ; {1022749}
    COP [01] ( &asciistring_0F9B47 ) ; {1022754}
    COP [3C] ( #04 )      ; {1022758}
    COP [10] ( #$0407, #00, #$0050, #$0200 ) ; {1022761}
    RTL                   ; {1022770}
}

code_0F9B33 {
    COP [01] ( &asciistring_0F9B3D ) ; {1022771}
    RTL                   ; {1022775}
}

code_0F9B38 {
    COP [01] ( &asciistring_0F9B69 ) ; {1022776}
    RTL                   ; {1022780}
}

asciistring_0F9B3D |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B47 |[10][02:2] touches [N]the dolphin with the [N]Dream Rod- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B69 |[10]Hey, didn t I meet you[N]in my dream? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|