?BANK 04

?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340

---------------------------------------------

code_026F57 {
    COP [07] ( #$8900, &code_026F69 ) ; {159575}
    COP [19] ( #23, &code_026F69 ) ; {159581}
    COP [0D] ( #00, #17, #0F, &code_026F6A ) ; {159586}
}

code_026F69 {
    RTL                   ; {159593}
}

code_026F6A {
    LDA #$2F80            ; {159594}
    TSB $joy_block_mask   ; {159597}
    COP [1B] ( &code_026F76, #$0002 ) ; {159600}
}

code_026F76 {
    LDA $0016, X          ; {159606}
    AND #$FFEF            ; {159609}
    STA $0016, X          ; {159612}
    COP [01] ( &asciistring_026FF9 ) ; {159615}
    LDA $0016, X          ; {159619}
    ORA #$0010            ; {159622}
    STA $0016, X          ; {159625}
    BRK #$4F              ; {159628}
    COP [91]              ; {159630}
    LDA $scroll_bg2_x     ; {159632}
    BEQ loc_026F99        ; {159635}
    DEC $038A             ; {159637}
    RTL                   ; {159640}

  loc_026F99:
    BRK #$4A              ; {159641}
    COP [1B] ( &code_026FA1, #$0046 ) ; {159643}
}

code_026FA1 {
    BRK #$91              ; {159649}
    COP [91]              ; {159651}
    LDA $scroll_bg2_y     ; {159653}
    BEQ loc_026FAE        ; {159656}
    DEC $038C             ; {159658}
    RTL                   ; {159661}

  loc_026FAE:
    STZ $034E             ; {159662}
    STZ $0350             ; {159665}
    LDA #$0200            ; {159668}
    STA $0346             ; {159671}
    STA $0348             ; {159674}
    LDA #$0002            ; {159677}
    STA $0030, X          ; {159680}

  loc_026FC3:
    COP [03] ( #10 )      ; {159683}
    LDA $scroll_bg2_y     ; {159686}
    SEC                   ; {159689}
    SBC $0030, X          ; {159690}
    STA $scroll_bg2_y     ; {159693}
    COP [04]              ; {159696}
    INC $0030, X          ; {159698}
    LDA $0030, X          ; {159701}
    CMP #$0010            ; {159704}
    BCC loc_026FC3        ; {159707}
    STZ $0419             ; {159709}
    COP [10] ( #$0213, #01, #$0170, #$00F0 ) ; {159712}
    COP [03] ( #10 )      ; {159721}
    LDA $scroll_bg2_y     ; {159724}
    SEC                   ; {159727}
    SBC $0030, X          ; {159728}
    STA $scroll_bg2_y     ; {159731}
    COP [04]              ; {159734}
    RTL                   ; {159736}
}

asciistring_026FF9 |[10][02:2] plugged [N]in the starting key- [JMP:&w5_shared_02706C.asciistring_0270DF]|