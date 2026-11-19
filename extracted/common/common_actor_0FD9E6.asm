?BANK 1F

---------------------------------------------

code_0FD9E6 {
    LDA $0016, X          ; {1038822}
    BIT #$8000            ; {1038825}
    BEQ loc_0FD9F4        ; {1038828}

  code_0FD9EE:
    COP [1B] ( &code_0FD9E6, #$0004 ) ; {1038830}

  loc_0FD9F4:
    COP [9B] ( #$0008, &code_0FD9FE, &code_0FDA18, &code_0FDA0B ) ; {1038836}
}

code_0FD9FE {
    COP [21] ( &code_0FDA5C ) ; {1038846}
    COP [97]              ; {1038850}
    COP [80] ( #07 )      ; {1038852}
    COP [82]              ; {1038855}
    BRA code_0FD9E6       ; {1038857}
}

code_0FDA0B {
    COP [22] ( &code_0FDA5C ) ; {1038859}
    COP [97]              ; {1038863}
    COP [80] ( #06 )      ; {1038865}
    COP [82]              ; {1038868}
    BRA code_0FD9E6       ; {1038870}
}

code_0FDA18 {
    COP [9A] ( #$0000, &code_0FDA22, &code_0FDA3B, &code_0FDA3B ) ; {1038872}
}

code_0FDA22 {
    COP [97]              ; {1038882}
    COP [80] ( #0D )      ; {1038884}
    COP [82]              ; {1038887}
    COP [B2] ( @code_0FDAC4, #$FFF8, #$0000, #$0200 ) ; {1038889}
    COP [80] ( #0E )      ; {1038900}
    COP [82]              ; {1038903}
    BRA code_0FDA54       ; {1038905}
}

code_0FDA3B {
    COP [96]              ; {1038907}
    COP [80] ( #0D )      ; {1038909}
    COP [82]              ; {1038912}
    COP [B2] ( @code_0FDACE, #$0008, #$0000, #$0200 ) ; {1038914}
    COP [80] ( #0E )      ; {1038925}
    COP [82]              ; {1038928}
    BRA code_0FDA54       ; {1038930}

  code_0FDA54:
    LDA $0016, X          ; {1038932}
    BIT #$8000            ; {1038935}
    BEQ loc_0FDA62        ; {1038938}
}

code_0FDA5C {
    COP [1B] ( &code_0FDA54, #$0004 ) ; {1038940}

  loc_0FDA62:
    COP [9A] ( #$0008, &code_0FDA6C, &code_0FDA86, &code_0FDA79 ) ; {1038946}
}

code_0FDA6C {
    COP [23] ( &code_0FD9EE ) ; {1038956}
    COP [97]              ; {1038960}
    COP [80] ( #08 )      ; {1038962}
    COP [82]              ; {1038965}
    BRA code_0FDA54       ; {1038967}
}

code_0FDA79 {
    COP [24] ( &code_0FD9EE ) ; {1038969}
    COP [96]              ; {1038973}
    COP [80] ( #08 )      ; {1038975}
    COP [82]              ; {1038978}
    BRA code_0FDA54       ; {1038980}
}

code_0FDA86 {
    COP [9B] ( #$0000, &code_0FDA90, &code_0FDAAA, &code_0FDAAA ) ; {1038982}
}

code_0FDA90 {
    COP [97]              ; {1038992}
    COP [80] ( #0B )      ; {1038994}
    COP [82]              ; {1038997}
    COP [B2] ( @code_0FDAD8, #$0002, #$FFF8, #$0200 ) ; {1038999}
    COP [80] ( #0C )      ; {1039010}
    COP [82]              ; {1039013}
    BRL code_0FD9E6       ; {1039015}
}

code_0FDAAA {
    COP [97]              ; {1039018}
    COP [80] ( #09 )      ; {1039020}
    COP [82]              ; {1039023}
    COP [B2] ( @code_0FDAE2, #$FFFD, #$0008, #$0200 ) ; {1039025}
    COP [80] ( #0A )      ; {1039036}
    COP [82]              ; {1039039}
    BRL code_0FD9E6       ; {1039041}
}

code_0FDAC4 {
    BRK #$5B              ; {1039044}
    COP [81] ( #11, #08 ) ; {1039046}
    COP [83]              ; {1039050}
    BRA loc_0FDAEA        ; {1039052}
}

code_0FDACE {
    BRK #$5B              ; {1039054}
    COP [81] ( #11, #08 ) ; {1039056}
    COP [83]              ; {1039060}
    BRA loc_0FDAEA        ; {1039062}
}

code_0FDAD8 {
    BRK #$5B              ; {1039064}
    COP [81] ( #10, #08 ) ; {1039066}
    COP [83]              ; {1039070}
    BRA loc_0FDAEA        ; {1039072}
}

code_0FDAE2 {
    BRK #$5B              ; {1039074}
    COP [81] ( #0F, #08 ) ; {1039076}
    COP [83]              ; {1039080}

  loc_0FDAEA:
    COP [86]              ; {1039082}
    RTL                   ; {1039084}
}