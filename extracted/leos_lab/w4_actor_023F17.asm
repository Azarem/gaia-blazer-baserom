?BANK 04

?INCLUDE 'lib_027462'

---------------------------------------------

code_023F17 {
    COP [19] ( #0A, &code_023F1D )
    RTL 
}

code_023F1D {
    LDA #$00F3
    JSL $@lib_027462.code_027462
    BCS loc_023F2F
    LDA #$00E1
    JSL $@lib_027462.code_027462
    BCC loc_023F32

  loc_023F2F:
    COP [39] ( #04 )

  loc_023F32:
    RTL 
}