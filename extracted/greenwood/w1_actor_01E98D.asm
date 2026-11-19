?BANK 03

?INCLUDE 'lib_027462'

---------------------------------------------

code_01E98D {
    COP [92] ( #3B )
    COP [94]
    COP [B0] ( @code_01E9A6, #$2040 )
    COP [1B] ( &code_01E99F, #$00F0 )
}

code_01E99F {
    COP [92] ( #3D )
    COP [94]
    BRA code_01E98D
}

code_01E9A6 {
    COP [03] ( #F0 )
    COP [19] ( #0A, &code_01E9B0 )
    BRA loc_01E9BC
}

code_01E9B0 {
    LDA #$0080
    JSL $@lib_027462.code_027462
    BCC loc_01E9BC
    COP [39] ( #01 )

  loc_01E9BC:
    COP [04]
    COP [86]
    RTL 
}