?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F9AFD {
    COP [14] ( #$00BB, &code_0F9B04 )
    RTL 
}

code_0F9B04 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [17] ( &code_0F9B17 )

  loc_0F9B0F:
    COP [80] ( #11 )
    COP [82]
    BRL loc_0F9B0F
}

code_0F9B17 {
    COP [07] ( #$8506, &code_0F9B38 )
    COP [19] ( #1C, &code_0F9B33 )
    COP [01] ( &asciistring_0F9B47 )
    COP [3C] ( #04 )
    COP [10] ( #$0407, #00, #$0050, #$0200 )
    RTL 
}

code_0F9B33 {
    COP [01] ( &asciistring_0F9B3D )
    RTL 
}

code_0F9B38 {
    COP [01] ( &asciistring_0F9B69 )
    RTL 
}

asciistring_0F9B3D |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B47 |[10][02:2] touches [N]the dolphin with the [N]Dream Rod- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9B69 |[10]Hey, didn t I meet you[N]in my dream? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|