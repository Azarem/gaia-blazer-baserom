?BANK 1F

---------------------------------------------

code_0FECD9 {
    LDA $001A, X          ; {1043673}
    ORA #$0200            ; {1043676}
    STA $001A, X          ; {1043679}
    COP [A5] ( &code_0FECEC, &code_0FECF9, &code_0FED06, &code_0FED06 ) ; {1043682}
}

code_0FECEC {
    COP [99]              ; {1043692}

  loc_0FECEE:
    COP [22] ( &code_0FECF9 ) ; {1043694}
    COP [80] ( #2A )      ; {1043698}
    COP [82]              ; {1043701}
    BRA loc_0FECEE        ; {1043703}
}

code_0FECF9 {
    COP [98]              ; {1043705}

  loc_0FECFB:
    COP [21] ( &code_0FECEC ) ; {1043707}
    COP [80] ( #2A )      ; {1043711}
    COP [82]              ; {1043714}
    BRA loc_0FECFB        ; {1043716}
}

code_0FED06 {
    COP [86]              ; {1043718}
    RTL                   ; {1043720}
}