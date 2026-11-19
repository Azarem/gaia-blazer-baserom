?BANK 1F

?INCLUDE 'lib_014F02'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0

---------------------------------------------

code_0F82DD {
    COP [14] ( #$0084, &code_0F82E4 ) ; {1016541}
    RTL                   ; {1016547}
}

code_0F82E4 {
    COP [17] ( &code_0F82F2 ) ; {1016548}
    COP [15]              ; {1016552}
    COP [91]              ; {1016554}
    COP [80] ( #06 )      ; {1016556}
    COP [82]              ; {1016559}
    RTL                   ; {1016561}
}

code_0F82F2 {
    COP [01] ( &asciistring_0F831C ) ; {1016562}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0F8317 ) ; {1016566}
    LDA $L_choice_result  ; {1016573}
    BNE code_0F8317       ; {1016577}
    COP [18] ( #38, &code_0F830D ) ; {1016579}
    COP [01] ( &asciistring_0F836C ) ; {1016584}
    RTL                   ; {1016588}
}

code_0F830D {
    COP [01] ( &asciistring_0F8355 ) ; {1016589}
    BRK #$5E              ; {1016593}
    COP [0A] ( #38 )      ; {1016595}
    RTL                   ; {1016598}
}

code_0F8317 {
    COP [01] ( &asciistring_0F8395 ) ; {1016599}
    RTL                   ; {1016603}
}

asciistring_0F831C |[10]Hello, I have some [N]Medical Herbs made [N]from seaweed- [N]Would you like one? [END]|

asciistring_0F8355 |[10]Come back to me [N]when you don t have [N]one- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F836C |[10]Medical herbs are [N]really rare- [N]I can t give you many-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8395 |[10]Come see me when you [N]need another- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|