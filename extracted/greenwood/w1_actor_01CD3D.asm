?BANK 03

?INCLUDE 'engine_0026F3'

---------------------------------------------

code_01CD3D {
    COP [14] ( #$005B, &code_01CD44 )
    RTL 
}

code_01CD44 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [A4]
    COP [16]
    COP [91]
    COP [80] ( #21 )
    COP [82]
    RTL 
}