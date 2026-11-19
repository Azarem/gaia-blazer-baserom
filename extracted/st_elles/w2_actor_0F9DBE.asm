?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

!return_active                  03FB

---------------------------------------------

code_0F9DBE {
    COP [14] ( #$008C, &code_0F9DC5 )
    RTL 
}

code_0F9DC5 {
    COP [30] ( #$008C, &code_0F9E32, #1F )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [1B] ( &code_0F9DD7, #$0002 )
}

code_0F9DD7 {
    COP [07] ( #$0000, &code_0F9E0D )
    LDA #$FFFF
    STA $return_active
    COP [09] ( #$8601 )
    COP [81] ( #0E, #09 )
    COP [83]
    COP [81] ( #0C, #03 )
    COP [83]
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    STZ $return_active

  loc_0F9E04:
    COP [80] ( #17 )
    COP [82]
    BRK #$4A
    BRA loc_0F9E04
}

code_0F9E0D {
    COP [11] ( #04, #12, #0B )
    COP [97]
    COP [15]
    COP [17] ( &code_0F9E22 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F9E22 {
    COP [14] ( #$008F, &code_0F9E2D )
    COP [01] ( &asciistring_0F9E55 )
    RTL 
}

code_0F9E2D {
    COP [01] ( &asciistring_0F9E7D )
    RTL 
}

code_0F9E32 {
    COP [09] ( #$8000 )
    COP [01] ( &asciistring_0F9E3D )
    COP [86]
    RTL 
}

asciistring_0F9E3D |[10][0E:1E]Lue! I m coming! [0E:28][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F9E55 |[10]I tried hard to save [N]Lue but he is not [N]here- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9E7D |[10]Lue told me many [N]things about the [N]Queen- [FIN]I don t think she was [N]a bad person- She was [N]just attracted to the [N]jewel- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|