?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FBBA3 {
    COP [A3]              ; {1031075}
    COP [A2] ( #30 )      ; {1031077}

  loc_0FBBA8:
    COP [AD] ( #10 )      ; {1031080}
    COP [9A] ( #$0018, &code_0FBBB5, &code_0FBBC9, &code_0FBBB5 ) ; {1031083}
}

code_0FBBB5 {
    COP [9B] ( #$0018, &code_0FBBD3, &code_0FBBBF, &code_0FBBD3 ) ; {1031093}
}

code_0FBBBF {
    COP [9A] ( #$0000, &code_0FBC01, &code_0FBC09, &code_0FBC09 ) ; {1031103}
}

code_0FBBC9 {
    COP [9B] ( #$0000, &code_0FBC11, &code_0FBC19, &code_0FBC19 ) ; {1031113}
}

code_0FBBD3 {
    COP [1F]              ; {1031123}
    LDA $rng_state+1      ; {1031125}
    AND #$0003            ; {1031128}
    BEQ loc_0FBBE5        ; {1031131}
    DEC                   ; {1031133}
    BEQ loc_0FBBEC        ; {1031134}
    DEC                   ; {1031136}
    BEQ loc_0FBBF3        ; {1031137}
    BRA loc_0FBBFA        ; {1031139}

  loc_0FBBE5:
    COP [80] ( #03 )      ; {1031141}
    COP [82]              ; {1031144}
    BRA loc_0FBBA8        ; {1031146}

  loc_0FBBEC:
    COP [80] ( #2C )      ; {1031148}
    COP [82]              ; {1031151}
    BRA loc_0FBBA8        ; {1031153}

  loc_0FBBF3:
    COP [80] ( #02 )      ; {1031155}
    COP [82]              ; {1031158}
    BRA loc_0FBBA8        ; {1031160}

  loc_0FBBFA:
    COP [80] ( #01 )      ; {1031162}
    COP [82]              ; {1031165}
    BRA loc_0FBBA8        ; {1031167}
}

code_0FBC01 {
    COP [81] ( #2A, #02 ) ; {1031169}
    COP [83]              ; {1031173}
    BRA code_0FBBD3       ; {1031175}
}

code_0FBC09 {
    COP [81] ( #2B, #02 ) ; {1031177}
    COP [83]              ; {1031181}
    BRA code_0FBBD3       ; {1031183}
}

code_0FBC11 {
    COP [81] ( #29, #02 ) ; {1031185}
    COP [83]              ; {1031189}
    BRA code_0FBBD3       ; {1031191}
}

code_0FBC19 {
    COP [81] ( #28, #02 ) ; {1031193}
    COP [83]              ; {1031197}
    BRL code_0FBBD3       ; {1031199}
}