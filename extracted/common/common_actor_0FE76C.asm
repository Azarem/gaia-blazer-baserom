?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FE76C {
    LDA $0016, X          ; {1042284}
    ORA #$2000            ; {1042287}
    STA $0016, X          ; {1042290}

  code_0FE775:
    COP [28] ( &code_0FE77B ) ; {1042293}
    BRA loc_0FE781        ; {1042297}
}

code_0FE77B {
    COP [1B] ( &code_0FE775, #$0008 ) ; {1042299}

  loc_0FE781:
    LDA $0016, X          ; {1042305}
    AND #$DFFF            ; {1042308}
    STA $0016, X          ; {1042311}

  code_0FE78A:
    COP [AD] ( #08 )      ; {1042314}
    LDA $0016, X          ; {1042317}
    ORA #$0200            ; {1042320}
    STA $0016, X          ; {1042323}
    COP [15]              ; {1042326}
    COP [97]              ; {1042328}
    COP [03] ( #32 )      ; {1042330}
    COP [0C] ( #00, #01, &code_0FE7E1 ) ; {1042333}
    COP [80] ( #25 )      ; {1042339}
    COP [82]              ; {1042342}
    COP [04]              ; {1042344}
    COP [80] ( #29 )      ; {1042346}
    COP [82]              ; {1042349}
    COP [16]              ; {1042351}
    LDA $0016, X          ; {1042353}
    AND #$FDFF            ; {1042356}
    STA $0016, X          ; {1042359}
    COP [1F]              ; {1042362}
    LDA $rng_state+1      ; {1042364}
    AND #$0003            ; {1042367}
    BEQ loc_0FE7CC        ; {1042370}
    DEC                   ; {1042372}
    BEQ loc_0FE7D3        ; {1042373}
    DEC                   ; {1042375}
    BEQ loc_0FE7DA        ; {1042376}
    COP [96]              ; {1042378}

  loc_0FE7CC:
    COP [80] ( #28 )      ; {1042380}
    COP [82]              ; {1042383}
    BRA code_0FE78A       ; {1042385}

  loc_0FE7D3:
    COP [80] ( #27 )      ; {1042387}
    COP [82]              ; {1042390}
    BRA code_0FE78A       ; {1042392}

  loc_0FE7DA:
    COP [80] ( #26 )      ; {1042394}
    COP [82]              ; {1042397}
    BRA code_0FE78A       ; {1042399}
}

code_0FE7E1 {
    COP [81] ( #25, #0A ) ; {1042401}
    COP [83]              ; {1042405}
    COP [16]              ; {1042407}
    LDA $0016, X          ; {1042409}
    AND #$FDFF            ; {1042412}
    STA $0016, X          ; {1042415}

  code_0FE7F2:
    COP [1B] ( &code_0FE7F8, #$0008 ) ; {1042418}
}

code_0FE7F8 {
    COP [9C] ( &code_0FE7FE, &code_0FE808 ) ; {1042424}
}

code_0FE7FE {
    COP [9A] ( #$0008, &code_0FE828, &code_0FE808, &code_0FE833 ) ; {1042430}
}

code_0FE808 {
    COP [9B] ( #$0008, &code_0FE812, &code_0FE7F2, &code_0FE81D ) ; {1042440}
}

code_0FE812 {
    COP [97]              ; {1042450}
    COP [9D] ( #2B )      ; {1042452}
    COP [9E] ( &code_0FE78A ) ; {1042455}

  loc_0FE81B:
    BRA code_0FE7F2       ; {1042459}
}

code_0FE81D {
    COP [97]              ; {1042461}
    COP [9D] ( #2A )      ; {1042463}
    COP [9E] ( &code_0FE78A ) ; {1042466}

  loc_0FE826:
    BRA code_0FE7F2       ; {1042470}
}

code_0FE828 {
    COP [97]              ; {1042472}
    COP [9D] ( #2C )      ; {1042474}
    COP [9E] ( &code_0FE78A ) ; {1042477}

  loc_0FE831:
    BRA code_0FE7F2       ; {1042481}
}

code_0FE833 {
    COP [96]              ; {1042483}
    COP [9D] ( #2C )      ; {1042485}
    COP [9E] ( &code_0FE78A ) ; {1042488}

  loc_0FE83C:
    BRA code_0FE7F2       ; {1042492}
}