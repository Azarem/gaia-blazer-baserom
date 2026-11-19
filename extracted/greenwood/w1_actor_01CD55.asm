?BANK 03

?INCLUDE 'engine_0026F3'

---------------------------------------------

code_01CD55 {
    COP [14] ( #$006F, &code_01CD5C )
    RTL 
}

code_01CD5C {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [A4]
    COP [16]
    COP [91]
    COP [80] ( #21 )
    COP [82]
    RTL 
}