?BANK 00

?INCLUDE 'engine_004281'

---------------------------------------------

code_004248 {
    COP [A4]
    COP [16]
    COP [14] ( #$00B6, &code_00427E )

  code_004252:
    COP [9B] ( #$0030, &code_004262, &code_00425C, &code_00425C )
}

code_00425C {
    COP [1B] ( &code_004252, #$0008 )
}

code_004262 {
    BRK #$A1
    COP [B0] ( @engine_004281.code_004281, #$0200 )
    COP [B0] ( @engine_004281.code_004289, #$0200 )
    COP [B0] ( @engine_004281.code_004291, #$0200 )
    COP [15]
    COP [86]
    RTL 
}

code_00427E {
    COP [91]
    RTL 
}