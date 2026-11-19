?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0225C4 {
    COP [14] ( #$0112, &code_0225CB ) ; {140740}
    RTL                   ; {140746}
}

code_0225CB {
    COP [85] ( @engine_0026F3.code_00299D ) ; {140747}
    COP [17] ( &code_0225FA ) ; {140752}
    BRL loc_0225DE        ; {140756}

  loc_0225D7:
    BRK #$43              ; {140759}
    COP [80] ( #02 )      ; {140761}
    COP [82]              ; {140764}

  loc_0225DE:
    COP [91]              ; {140766}
    COP [0C] ( #00, #02, &code_0225E7 ) ; {140768}
    RTL                   ; {140774}
}

code_0225E7 {
    BRK #$43              ; {140775}
    COP [80] ( #01 )      ; {140777}
    COP [82]              ; {140780}
    COP [91]              ; {140782}
    COP [0C] ( #00, #02, &code_0225F9 ) ; {140784}
    BRL loc_0225D7        ; {140790}
}

code_0225F9 {
    RTL                   ; {140793}
}

code_0225FA {
    COP [01] ( &asciistring_0225FF ) ; {140794}
    RTL                   ; {140798}
}

asciistring_0225FF |[10]--------- [JMP:&w4_shared_023F33.asciistring_023FA3]|