?BANK 1F

---------------------------------------------

code_0FAFAD {
    LDA $0016, X          ; {1028013}
    BIT #$8000            ; {1028016}
    BEQ loc_0FAFBB        ; {1028019}
    COP [1B] ( &code_0FAFAD, #$0008 ) ; {1028021}

  loc_0FAFBB:
    COP [97]              ; {1028027}
    COP [80] ( #22 )      ; {1028029}
    COP [82]              ; {1028032}
    COP [9B] ( #$0010, &code_0FAFCC, &code_0FAFD6, &code_0FAFCC ) ; {1028034}
}

code_0FAFCC {
    COP [9A] ( #$0010, &code_0FAFAD, &code_0FAFF6, &code_0FAFAD ) ; {1028044}
}

code_0FAFD6 {
    COP [9A] ( #$0000, &code_0FAFE0, &code_0FAFEA, &code_0FAFEA ) ; {1028054}
}

code_0FAFE0 {
    COP [80] ( #23 )      ; {1028064}
    COP [82]              ; {1028067}
    LDA #$0029            ; {1028069}
    BRA loc_0FB014        ; {1028072}
}

code_0FAFEA {
    COP [80] ( #23 )      ; {1028074}
    COP [82]              ; {1028077}
    COP [96]              ; {1028079}
    LDA #$0029            ; {1028081}
    BRA loc_0FB014        ; {1028084}
}

code_0FAFF6 {
    COP [9B] ( #$0000, &code_0FB000, &code_0FB00A, &code_0FB00A ) ; {1028086}
}

code_0FB000 {
    COP [80] ( #23 )      ; {1028096}
    COP [82]              ; {1028099}
    LDA #$0028            ; {1028101}
    BRA loc_0FB014        ; {1028104}
}

code_0FB00A {
    COP [80] ( #23 )      ; {1028106}
    COP [82]              ; {1028109}
    LDA #$0027            ; {1028111}
    BRA loc_0FB014        ; {1028114}

  loc_0FB014:
    PHA                   ; {1028116}
    COP [84] ( @code_0FB02F ) ; {1028117}
    PLA                   ; {1028122}
    STA $001E, Y          ; {1028123}
    LDA #$0000            ; {1028126}
    STA $0020, Y          ; {1028129}
    COP [97]              ; {1028132}
    COP [81] ( #22, #04 ) ; {1028134}
    COP [83]              ; {1028138}
    BRL code_0FAFAD       ; {1028140}
}

code_0FB02F {
    LDA #$0200            ; {1028143}
    STA $0016, X          ; {1028146}
    COP [A2] ( #30 )      ; {1028149}
    COP [A3]              ; {1028152}
    COP [A0] ( #$FFFC )   ; {1028154}
    BRK #$64              ; {1028158}
    COP [91]              ; {1028160}

  loc_0FB042:
    COP [82]              ; {1028162}
    COP [1C] ( #$8000, &code_0FB04C ) ; {1028164}
    BRA loc_0FB042        ; {1028170}
}

code_0FB04C {
    COP [86]              ; {1028172}
    RTL                   ; {1028174}
}