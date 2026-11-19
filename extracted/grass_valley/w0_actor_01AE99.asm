?BANK 03

?INCLUDE 'w0_shared_01B988'

!joy_pressed                    0322
!player_actor                   039C

---------------------------------------------

code_01AE99 {
    COP [A0] ( #$0002 )   ; {110233}

  loc_01AE9D:
    COP [91]              ; {110237}
    COP [07] ( #$8404, &code_01AEAD ) ; {110239}
    COP [0D] ( #00, #47, #38, &code_01AEFA ) ; {110245}
    RTL                   ; {110252}
}

code_01AEAD {
    LDY $player_actor     ; {110253}
    LDA $0000, Y          ; {110256}
    CMP #$04B0            ; {110259}
    BCC code_01AEC0       ; {110262}
    COP [A0] ( #$FFB0 )   ; {110264}
    COP [27] ( &code_01AEDD ) ; {110268}

  code_01AEC0:
    COP [91]              ; {110272}
    COP [0D] ( #00, #47, #38, &code_01AECA ) ; {110274}
    RTL                   ; {110281}
}

code_01AECA {
    LDA $joy_pressed      ; {110282}
    AND #$0800            ; {110285}
    BNE loc_01AED3        ; {110288}
    RTL                   ; {110290}

  loc_01AED3:
    COP [81] ( #2A, #14 ) ; {110291}
    COP [83]              ; {110295}
    COP [27] ( &code_01AEDD ) ; {110297}
}

code_01AEDD {
    COP [91]              ; {110301}
    COP [0D] ( #00, #47, #33, &code_01AEE7 ) ; {110303}
    RTL                   ; {110310}
}

code_01AEE7 {
    LDA $joy_pressed      ; {110311}
    AND #$0400            ; {110314}
    BNE loc_01AEF0        ; {110317}
    RTL                   ; {110319}

  loc_01AEF0:
    COP [81] ( #2C, #14 ) ; {110320}
    COP [83]              ; {110324}
    COP [27] ( &code_01AEC0 ) ; {110326}
}

code_01AEFA {
    COP [01] ( &asciistring_01AF0A ) ; {110330}
    COP [91]              ; {110334}
    COP [0D] ( #00, #47, #38, &code_01AF09 ) ; {110336}
    BRA loc_01AE9D        ; {110343}
}

code_01AF09 {
    RTL                   ; {110345}
}

asciistring_01AF0A |[10]I am an elevator [N]invented by Dr-Leo- [FIN]I cannot move unless [N]the water mill is [N]turning- [JMP:&w0_shared_01B988.asciistring_01B988]|