?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

!return_active                  03FB

---------------------------------------------

code_0F9DBE {
    COP [14] ( #$008C, &code_0F9DC5 ) ; {1023422}
    RTL                   ; {1023428}
}

code_0F9DC5 {
    COP [30] ( #$008C, &code_0F9E32, #1F ) ; {1023429}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1023436}
    COP [1B] ( &code_0F9DD7, #$0002 ) ; {1023441}
}

code_0F9DD7 {
    COP [07] ( #$0000, &code_0F9E0D ) ; {1023447}
    LDA #$FFFF            ; {1023453}
    STA $return_active    ; {1023456}
    COP [09] ( #$8601 )   ; {1023459}
    COP [81] ( #0E, #09 ) ; {1023463}
    COP [83]              ; {1023467}
    COP [81] ( #0C, #03 ) ; {1023469}
    COP [83]              ; {1023473}
    COP [80] ( #17 )      ; {1023475}
    COP [82]              ; {1023478}
    BRK #$4A              ; {1023480}
    COP [80] ( #17 )      ; {1023482}
    COP [82]              ; {1023485}
    BRK #$4A              ; {1023487}
    STZ $return_active    ; {1023489}

  loc_0F9E04:
    COP [80] ( #17 )      ; {1023492}
    COP [82]              ; {1023495}
    BRK #$4A              ; {1023497}
    BRA loc_0F9E04        ; {1023499}
}

code_0F9E0D {
    COP [11] ( #04, #12, #0B ) ; {1023501}
    COP [97]              ; {1023506}
    COP [15]              ; {1023508}
    COP [17] ( &code_0F9E22 ) ; {1023510}
    COP [91]              ; {1023514}
    COP [80] ( #11 )      ; {1023516}
    COP [82]              ; {1023519}
    RTL                   ; {1023521}
}

code_0F9E22 {
    COP [14] ( #$008F, &code_0F9E2D ) ; {1023522}
    COP [01] ( &asciistring_0F9E55 ) ; {1023528}
    RTL                   ; {1023532}
}

code_0F9E2D {
    COP [01] ( &asciistring_0F9E7D ) ; {1023533}
    RTL                   ; {1023537}
}

code_0F9E32 {
    COP [09] ( #$8000 )   ; {1023538}
    COP [01] ( &asciistring_0F9E3D ) ; {1023542}
    COP [86]              ; {1023546}
    RTL                   ; {1023548}
}

asciistring_0F9E3D |[10][0E:1E]Lue! I m coming! [0E:28][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F9E55 |[10]I tried hard to save [N]Lue but he is not [N]here- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9E7D |[10]Lue told me many [N]things about the [N]Queen- [FIN]I don t think she was [N]a bad person- She was [N]just attracted to the [N]jewel- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|