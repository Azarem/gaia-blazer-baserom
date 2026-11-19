?BANK 04

?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340

---------------------------------------------

code_026F57 {
    COP [07] ( #$8900, &code_026F69 )
    COP [19] ( #23, &code_026F69 )
    COP [0D] ( #00, #17, #0F, &code_026F6A )
}

code_026F69 {
    RTL 
}

code_026F6A {
    LDA #$2F80
    TSB $joy_block_mask
    COP [1B] ( &code_026F76, #$0002 )
}

code_026F76 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_026FF9 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRK #$4F
    COP [91]
    LDA $scroll_bg2_x
    BEQ loc_026F99
    DEC $038A
    RTL 

  loc_026F99:
    BRK #$4A
    COP [1B] ( &code_026FA1, #$0046 )
}

code_026FA1 {
    BRK #$91
    COP [91]
    LDA $scroll_bg2_y
    BEQ loc_026FAE
    DEC $038C
    RTL 

  loc_026FAE:
    STZ $034E
    STZ $0350
    LDA #$0200
    STA $0346
    STA $0348
    LDA #$0002
    STA $0030, X

  loc_026FC3:
    COP [03] ( #10 )
    LDA $scroll_bg2_y
    SEC 
    SBC $0030, X
    STA $scroll_bg2_y
    COP [04]
    INC $0030, X
    LDA $0030, X
    CMP #$0010
    BCC loc_026FC3
    STZ $0419
    COP [10] ( #$0213, #01, #$0170, #$00F0 )
    COP [03] ( #10 )
    LDA $scroll_bg2_y
    SEC 
    SBC $0030, X
    STA $scroll_bg2_y
    COP [04]
    RTL 
}

asciistring_026FF9 |[10][02:2] plugged [N]in the starting key- [JMP:&w5_shared_02706C.asciistring_0270DF]|