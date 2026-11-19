?BANK 00

---------------------------------------------

code_002678 {
    JSR $&code_0026D0
    COP [A0] ( #$FFF0 )
    COP [80] ( #30 )
    COP [82]
    COP [81] ( #31, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_00268D {
    JSR $&code_0026D0
    COP [A0] ( #$0010 )
    COP [98]
    COP [80] ( #30 )
    COP [82]
    COP [81] ( #31, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0026A4 {
    JSR $&code_0026D0
    COP [A0] ( #$FFF0 )
    COP [80] ( #2E )
    COP [82]
    COP [81] ( #2F, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0026B9 {
    JSR $&code_0026D0
    COP [96]
    COP [A0] ( #$FFF0 )
    COP [80] ( #2E )
    COP [82]
    COP [81] ( #2F, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0026D0 {
    LDA #$02A0
    STA $0016, X
    LDA #$0014
    STA $0030, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    RTS 
}