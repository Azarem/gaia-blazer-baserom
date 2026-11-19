?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop03_LoopStart {
    TYX                   ; {22517}
    LDA [$38]             ; {22518}
    INC $38               ; {22520}
    AND #$00FF            ; {22522}
    STA $002E, X          ; {22525}
    LDA $38               ; {22528}
    STA $002C, X          ; {22530}
    STA $0018, X          ; {22533}
    BRL cop_handler_006473.loc_0064C1 ; {22536}
}