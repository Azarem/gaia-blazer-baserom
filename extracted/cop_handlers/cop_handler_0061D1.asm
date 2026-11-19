?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_000000'

---------------------------------------------

Cop9E_AnimStepUnlessBit2 {
    TYX                   ; {25041}
    LDA $0016, X          ; {25042}
    BIT #$0004            ; {25045}
    BNE loc_0061E6        ; {25048}
    JSL $@engine_000000.code_0008F3 ; {25050}
    BCC loc_0061E3        ; {25054}
    BRL cop_handler_006473.loc_0064BB ; {25056}

  loc_0061E3:
    BRL cop_handler_006473.loc_0064C9 ; {25059}

  loc_0061E6:
    LDA [$38]             ; {25062}
    INC $38               ; {25064}
    INC $38               ; {25066}
    BRL cop_handler_006473.loc_0064C1 ; {25068}
}