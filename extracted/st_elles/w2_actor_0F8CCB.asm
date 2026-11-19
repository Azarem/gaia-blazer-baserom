?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8CCB {
    COP [14] ( #$00A4, &code_0F8CD2 ) ; {1019083}
    RTL                   ; {1019089}
}

code_0F8CD2 {
    COP [17] ( &code_0F8D02 ) ; {1019090}
    COP [11] ( #13, #35, #26 ) ; {1019094}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1019099}
    COP [15]              ; {1019104}
    COP [91]              ; {1019106}

  loc_0F8CE4:
    COP [0C] ( #00, #02, &code_0F8CF1 ) ; {1019108}

  code_0F8CEA:
    COP [80] ( #01 )      ; {1019114}
    COP [82]              ; {1019117}
    BRA loc_0F8CE4        ; {1019119}
}

code_0F8CF1 {
    COP [9B] ( #$0000, &code_0F8CEA, &code_0F8CEA, &code_0F8CFB ) ; {1019121}
}

code_0F8CFB {
    COP [80] ( #00 )      ; {1019131}
    COP [82]              ; {1019134}
    BRA loc_0F8CE4        ; {1019136}
}

code_0F8D02 {
    COP [0D] ( #00, #35, #26, &code_0F8D0E ) ; {1019138}
    COP [01] ( &asciistring_0F8D13 ) ; {1019145}
    RTL                   ; {1019149}
}

code_0F8D0E {
    COP [01] ( &asciistring_0F8D44 ) ; {1019150}
    RTL                   ; {1019154}
}

asciistring_0F8D13 |[10]Sorry, I have orders [N]from the Queen not to [N]let anyone pass- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8D44 |[10]How did you get here? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|