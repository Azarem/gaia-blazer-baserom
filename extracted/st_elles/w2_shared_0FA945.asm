?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FA945 {
    COP [2E] ( #00, #$0018, &code_0FA953 ) ; {1026373}
    COP [80] ( #07 )      ; {1026380}
    COP [82]              ; {1026383}
    BRA code_0FA945       ; {1026385}
}

code_0FA953 {
    COP [80] ( #0C )      ; {1026387}
    COP [82]              ; {1026390}
    BRA code_0FA945       ; {1026392}
}

code_0FA95A {
    COP [1F]              ; {1026394}
    LDA $rng_state+1      ; {1026396}
    AND #$0003            ; {1026399}
    BEQ loc_0FA96C        ; {1026402}
    DEC                   ; {1026404}
    BEQ loc_0FA971        ; {1026405}
    COP [01] ( &asciistring_0FA976 ) ; {1026407}
    RTL                   ; {1026411}

  loc_0FA96C:
    COP [01] ( &asciistring_0FA98C ) ; {1026412}
    RTL                   ; {1026416}

  loc_0FA971:
    COP [01] ( &asciistring_0FA9A4 ) ; {1026417}
    RTL                   ; {1026421}
}

asciistring_0FA976 |[10]Please somebody help [N]me--- [JMP:&asciistring_0FAA44]|

asciistring_0FA98C |[10]I want to return to [N]myself! [JMP:&asciistring_0FAA44]|

asciistring_0FA9A4 |[10]Help! Somebody [N]please------ [JMP:&asciistring_0FAA44]|

asciistring_0FA9C5 |[10]I am watching over the[N]world- [N]Here, take this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_0FA9F0 |[10]Would you like to [N]return to the Seabed [N]Palace? [END]|

asciistring_0FAA15 |Allright, good luck- [JMP:&asciistring_0FAA44]|

asciistring_0FAA29 |Visit me again when [N]you are ready- [JMP:&asciistring_0FAA44]|

asciistring_0FAA44 |[12][::][08:408][END]|