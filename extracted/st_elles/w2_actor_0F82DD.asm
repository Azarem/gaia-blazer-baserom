?BANK 1F

?INCLUDE 'lib_014F02'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0

---------------------------------------------

code_0F82DD {
    COP [14] ( #$0084, &code_0F82E4 )
    RTL 
}

code_0F82E4 {
    COP [17] ( &code_0F82F2 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F82F2 {
    COP [01] ( &asciistring_0F831C )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0F8317 )
    LDA $L_choice_result
    BNE code_0F8317
    COP [18] ( #38, &code_0F830D )
    COP [01] ( &asciistring_0F836C )
    RTL 
}

code_0F830D {
    COP [01] ( &asciistring_0F8355 )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

code_0F8317 {
    COP [01] ( &asciistring_0F8395 )
    RTL 
}

asciistring_0F831C |[10]Hello, I have some [N]Medical Herbs made [N]from seaweed- [N]Would you like one? [END]|

asciistring_0F8355 |[10]Come back to me [N]when you don t have [N]one- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F836C |[10]Medical herbs are [N]really rare- [N]I can t give you many-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8395 |[10]Come see me when you [N]need another- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|