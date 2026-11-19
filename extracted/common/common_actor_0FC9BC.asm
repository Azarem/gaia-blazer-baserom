?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FC9BC {
    COP [A5] ( &code_0FC9C6, &code_0FC9CF, &code_0FC9D6, &code_0FC9DD ) ; {1034684}
}

code_0FC9C6 {
    COP [96]              ; {1034694}
    COP [80] ( #0F )      ; {1034696}
    COP [82]              ; {1034699}
    BRA loc_0FC9E4        ; {1034701}
}

code_0FC9CF {
    COP [80] ( #10 )      ; {1034703}
    COP [82]              ; {1034706}
    BRA loc_0FC9E4        ; {1034708}
}

code_0FC9D6 {
    COP [80] ( #0F )      ; {1034710}
    COP [82]              ; {1034713}
    BRA loc_0FC9E4        ; {1034715}
}

code_0FC9DD {
    COP [96]              ; {1034717}
    COP [80] ( #10 )      ; {1034719}
    COP [82]              ; {1034722}

  loc_0FC9E4:
    COP [AD] ( #08 )      ; {1034724}
    COP [03] ( #08 )      ; {1034727}
    COP [80] ( #33 )      ; {1034730}
    COP [82]              ; {1034733}
    COP [0C] ( #00, #03, &code_0FCA05 ) ; {1034735}
    COP [04]              ; {1034741}
    COP [80] ( #11 )      ; {1034743}
    COP [82]              ; {1034746}
    COP [B0] ( @code_0FCA1F, #$0200 ) ; {1034748}
    BRA loc_0FC9E4        ; {1034755}
}

code_0FCA05 {
    COP [8F]              ; {1034757}
    COP [9B] ( #$0000, &code_0FCA11, &code_0FCA18, &code_0FCA18 ) ; {1034759}
}

code_0FCA11 {
    COP [80] ( #10 )      ; {1034769}
    COP [82]              ; {1034772}
    BRA loc_0FC9E4        ; {1034774}
}

code_0FCA18 {
    COP [80] ( #0F )      ; {1034776}
    COP [82]              ; {1034779}
    BRA loc_0FC9E4        ; {1034781}
}

code_0FCA1F {
    COP [A3]              ; {1034783}
    COP [A2] ( #30 )      ; {1034785}
    BRK #$64              ; {1034788}
    LDY #$002A            ; {1034790}
    SEP #$20              ; {1034793}
    LDA #$^common_actor_004659_part1.code_002D67 ; {1034795}
    PHA                   ; {1034797}
    REP #$20              ; {1034798}
    LDA #$&common_actor_004659_part1.code_002D67-1 ; {1034800}
    PHA                   ; {1034803}
    RTL                   ; {1034804}
}