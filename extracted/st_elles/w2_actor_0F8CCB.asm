?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8CCB {
    COP [14] ( #$00A4, &code_0F8CD2 )
    RTL 
}

code_0F8CD2 {
    COP [17] ( &code_0F8D02 )
    COP [11] ( #13, #35, #26 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [91]

  loc_0F8CE4:
    COP [0C] ( #00, #02, &code_0F8CF1 )

  code_0F8CEA:
    COP [80] ( #01 )
    COP [82]
    BRA loc_0F8CE4
}

code_0F8CF1 {
    COP [9B] ( #$0000, &code_0F8CEA, &code_0F8CEA, &code_0F8CFB )
}

code_0F8CFB {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0F8CE4
}

code_0F8D02 {
    COP [0D] ( #00, #35, #26, &code_0F8D0E )
    COP [01] ( &asciistring_0F8D13 )
    RTL 
}

code_0F8D0E {
    COP [01] ( &asciistring_0F8D44 )
    RTL 
}

asciistring_0F8D13 |[10]Sorry, I have orders [N]from the Queen not to [N]let anyone pass- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8D44 |[10]How did you get here? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|