?BANK 00

---------------------------------------------

code_004F4D {
    LDY $039A             ; {20301}
    LDA $0016, Y          ; {20304}
    BIT #$0400            ; {20307}
    BNE loc_004F59        ; {20310}
    RTL                   ; {20312}

  loc_004F59:
    STX $039A             ; {20313}
    LDA $0000, Y          ; {20316}
    STA $0000, X          ; {20319}
    LDA $0002, Y          ; {20322}
    STA $0002, X          ; {20325}
    COP [1B] ( &code_004F6E, #$00B4 ) ; {20328}
}

code_004F6E {
    LDA $0016, X          ; {20334}
    AND #$DFFF            ; {20337}
    STA $0016, X          ; {20340}
    COP [85] ( @code_004F9E ) ; {20343}

  code_004F7C:
    COP [80] ( #1F )      ; {20348}
    COP [82]              ; {20351}
    COP [08] ( #$8000, &code_004F7C ) ; {20353}
    COP [85] ( @code_004FA9 ) ; {20359}
    COP [81] ( #1F, #03 ) ; {20364}
    COP [83]              ; {20368}
    COP [10] ( #$0215, #01, #$0078, #$00C8 ) ; {20370}
    COP [91]              ; {20379}
    RTL                   ; {20381}
}

code_004F9E {
    COP [01] ( &asciistring_004FB6 ) ; {20382}
    COP [09] ( #$8000 )   ; {20386}
    COP [86]              ; {20390}
    RTL                   ; {20392}
}

code_004FA9 {
    COP [A8] ( #$8000, #0D ) ; {20393}
    COP [92] ( #48 )      ; {20398}
    COP [94]              ; {20401}
    COP [86]              ; {20403}
    RTL                   ; {20405}
}

asciistring_004FB6 |[10]Some people believe [N]being constantly [N]reincarnated means [N]everlasting suffering-[FIN]Being alive is [N]suffering for some [N]creatures- [FIN]You will find out what[N]I mean- [12][08:408][END]|