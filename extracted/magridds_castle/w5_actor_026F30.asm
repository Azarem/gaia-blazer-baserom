?BANK 04

?INCLUDE 'lib_027462'

---------------------------------------------

code_026F30 {
    COP [19] ( #0F, &code_026F36 )
    RTL 
}

code_026F36 {
    LDA #$0088
    JSL $@lib_027462.code_027462
    BCS loc_026F40
    RTL 

  loc_026F40:
    COP [39] ( #03 )
    RTL 
}