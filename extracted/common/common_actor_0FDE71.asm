?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FDE71 {
    COP [A5] ( &code_0FDE7B, &code_0FDEC7, &code_0FDF13, &code_0FDF61 ) ; {1039985}
}

code_0FDE7B {
    LDA $0016, X          ; {1039995}
    BIT #$8000            ; {1039998}
    BEQ loc_0FDE89        ; {1040001}

  code_0FDE83:
    COP [1B] ( &code_0FDE7B, #$0078 ) ; {1040003}

  loc_0FDE89:
    COP [0C] ( #00, #07, &code_0FDE91 ) ; {1040009}
    BRA code_0FDE83       ; {1040015}
}

code_0FDE91 {
    COP [9B] ( #$0010, &code_0FDE83, &code_0FDE83, &code_0FDE9B ) ; {1040017}
}

code_0FDE9B {
    COP [28] ( &code_0FDEA3 ) ; {1040027}
    COP [27] ( &code_0FDE83 ) ; {1040031}
}

code_0FDEA3 {
    LDA $0016, X          ; {1040035}
    AND #$DFFF            ; {1040038}
    STA $0016, X          ; {1040041}
    COP [80] ( #02 )      ; {1040044}
    COP [82]              ; {1040047}
    COP [B2] ( @code_0FDFAD, #$0000, #$0010, #$0200 ) ; {1040049}
    LDA $0016, X          ; {1040060}
    ORA #$2000            ; {1040063}
    STA $0016, X          ; {1040066}
    BRA code_0FDE83       ; {1040069}
}

code_0FDEC7 {
    LDA $0016, X          ; {1040071}
    BIT #$8000            ; {1040074}
    BEQ loc_0FDED5        ; {1040077}

  code_0FDECF:
    COP [1B] ( &code_0FDEC7, #$0078 ) ; {1040079}

  loc_0FDED5:
    COP [0C] ( #00, #07, &code_0FDEDD ) ; {1040085}
    BRA code_0FDECF       ; {1040091}
}

code_0FDEDD {
    COP [9A] ( #$0010, &code_0FDEE7, &code_0FDECF, &code_0FDECF ) ; {1040093}
}

code_0FDEE7 {
    COP [28] ( &code_0FDEEF ) ; {1040103}
    COP [27] ( &code_0FDECF ) ; {1040107}
}

code_0FDEEF {
    LDA $0016, X          ; {1040111}
    AND #$DFFF            ; {1040114}
    STA $0016, X          ; {1040117}
    COP [80] ( #04 )      ; {1040120}
    COP [82]              ; {1040123}
    COP [B2] ( @code_0FDFAD, #$FFF0, #$0000, #$0200 ) ; {1040125}
    LDA $0016, X          ; {1040136}
    ORA #$2000            ; {1040139}
    STA $0016, X          ; {1040142}
    BRA code_0FDECF       ; {1040145}
}

code_0FDF13 {
    LDA $0016, X          ; {1040147}
    BIT #$8000            ; {1040150}
    BEQ loc_0FDF21        ; {1040153}

  code_0FDF1B:
    COP [1B] ( &code_0FDF13, #$0078 ) ; {1040155}

  loc_0FDF21:
    COP [0C] ( #00, #07, &code_0FDF29 ) ; {1040161}
    BRA code_0FDF1B       ; {1040167}
}

code_0FDF29 {
    COP [9A] ( #$0010, &code_0FDF1B, &code_0FDF1B, &code_0FDF33 ) ; {1040169}
}

code_0FDF33 {
    COP [28] ( &code_0FDF3B ) ; {1040179}
    COP [27] ( &code_0FDF1B ) ; {1040183}
}

code_0FDF3B {
    COP [96]              ; {1040187}
    LDA $0016, X          ; {1040189}
    AND #$DFFF            ; {1040192}
    STA $0016, X          ; {1040195}
    COP [80] ( #04 )      ; {1040198}
    COP [82]              ; {1040201}
    COP [B2] ( @code_0FDFAD, #$0010, #$0000, #$0200 ) ; {1040203}
    LDA $0016, X          ; {1040214}
    ORA #$2000            ; {1040217}
    STA $0016, X          ; {1040220}
    BRA code_0FDF1B       ; {1040223}
}

code_0FDF61 {
    LDA $0016, X          ; {1040225}
    BIT #$8000            ; {1040228}
    BEQ loc_0FDF6F        ; {1040231}

  code_0FDF69:
    COP [1B] ( &code_0FDF61, #$0078 ) ; {1040233}

  loc_0FDF6F:
    COP [0C] ( #00, #07, &code_0FDF77 ) ; {1040239}
    BRA code_0FDF69       ; {1040245}
}

code_0FDF77 {
    COP [9B] ( #$0010, &code_0FDF81, &code_0FDF69, &code_0FDF69 ) ; {1040247}
}

code_0FDF81 {
    COP [28] ( &code_0FDF89 ) ; {1040257}
    COP [27] ( &code_0FDF69 ) ; {1040261}
}

code_0FDF89 {
    LDA $0016, X          ; {1040265}
    AND #$DFFF            ; {1040268}
    STA $0016, X          ; {1040271}
    COP [80] ( #03 )      ; {1040274}
    COP [82]              ; {1040277}
    COP [B2] ( @code_0FDFAD, #$0000, #$FFF0, #$0200 ) ; {1040279}
    LDA $0016, X          ; {1040290}
    ORA #$2000            ; {1040293}
    STA $0016, X          ; {1040296}
    BRA code_0FDF69       ; {1040299}
}

code_0FDFAD {
    COP [A3]              ; {1040301}
    BRK #$64              ; {1040303}
    LDY #$0005            ; {1040305}
    SEP #$20              ; {1040308}
    LDA #$^common_actor_004659_part1.code_002D67 ; {1040310}
    PHA                   ; {1040312}
    REP #$20              ; {1040313}
    LDA #$&common_actor_004659_part1.code_002D67-1 ; {1040315}
    PHA                   ; {1040318}
    RTL                   ; {1040319}
}