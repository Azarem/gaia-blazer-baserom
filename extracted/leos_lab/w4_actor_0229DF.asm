?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_pressed                    0322
!joy_block_mask                 0326

---------------------------------------------

code_0229DF {
    COP [14] ( #$010C, &code_0229E6 ) ; {141791}
    RTL                   ; {141797}
}

code_0229E6 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {141798}
    COP [17] ( &code_022A69 ) ; {141803}
    COP [15]              ; {141807}

  code_0229F1:
    COP [91]              ; {141809}
    COP [03] ( #02 )      ; {141811}
    COP [80] ( #08 )      ; {141814}
    COP [82]              ; {141817}
    LDA $joy_pressed      ; {141819}
    AND #$0200            ; {141822}
    BEQ loc_022A2E        ; {141825}
    COP [0D] ( #00, #04, #10, &code_022A0C ) ; {141827}
    BRA loc_022A2E        ; {141834}
}

code_022A0C {
    COP [04]              ; {141836}
    LDA #$2F80            ; {141838}
    TSB $joy_block_mask   ; {141841}
    COP [16]              ; {141844}
    COP [81] ( #1D, #10 ) ; {141846}
    COP [83]              ; {141850}
    COP [15]              ; {141852}
    LDA #$2F80            ; {141854}
    TRB $joy_block_mask   ; {141857}
    COP [91]              ; {141860}
    COP [0D] ( #00, #03, #10, &code_022A32 ) ; {141862}
    RTL                   ; {141869}

  loc_022A2E:
    COP [27] ( &code_0229F1 ) ; {141870}
}

code_022A32 {
    COP [07] ( #$9A06, &code_022A45 ) ; {141874}
    COP [01] ( &asciistring_022ADC ) ; {141880}
    BRK #$5E              ; {141884}
    COP [0A] ( #30 )      ; {141886}
    COP [09] ( #$9A06 )   ; {141889}
}

code_022A45 {
    COP [91]              ; {141893}
    RTL                   ; {141895}
}

code_022A48 {
    LDA #$2F80            ; {141896}
    TSB $joy_block_mask   ; {141899}
    COP [80] ( #1B )      ; {141902}
    COP [82]              ; {141905}
    COP [01] ( &asciistring_022A9D ) ; {141907}
    BRK #$5E              ; {141911}
    COP [0A] ( #0D )      ; {141913}
    COP [80] ( #1C )      ; {141916}
    COP [82]              ; {141919}
    LDA #$2F80            ; {141921}
    TRB $joy_block_mask   ; {141924}
    BRA code_0229F1       ; {141927}
}

code_022A69 {
    COP [18] ( #0D, &code_022A73 ) ; {141929}
    COP [01] ( &asciistring_022AB8 ) ; {141934}
    RTL                   ; {141938}
}

code_022A73 {
    COP [01] ( &asciistring_022A7B ) ; {141939}
    COP [27] ( &code_022A48 ) ; {141943}
}

asciistring_022A7B |[10]Take the Mystic Armor [N]from my drawer- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022A9D |[10][02:2] received [N][03:24]Mystic Armor- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022AB8 |[10]My body is made from [N]the trees in [N]GreenWood- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022ADC |[10][02:2] found [N][03:24]Master s Emblem G- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|