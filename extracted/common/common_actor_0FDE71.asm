?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FDE71 {
    COP [A5] ( &code_0FDE7B, &code_0FDEC7, &code_0FDF13, &code_0FDF61 )
}

code_0FDE7B {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDE89

  code_0FDE83:
    COP [1B] ( &code_0FDE7B, #$0078 )

  loc_0FDE89:
    COP [0C] ( #00, #07, &code_0FDE91 )
    BRA code_0FDE83
}

code_0FDE91 {
    COP [9B] ( #$0010, &code_0FDE83, &code_0FDE83, &code_0FDE9B )
}

code_0FDE9B {
    COP [28] ( &code_0FDEA3 )
    COP [27] ( &code_0FDE83 )
}

code_0FDEA3 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$0000, #$0010, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDE83
}

code_0FDEC7 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDED5

  code_0FDECF:
    COP [1B] ( &code_0FDEC7, #$0078 )

  loc_0FDED5:
    COP [0C] ( #00, #07, &code_0FDEDD )
    BRA code_0FDECF
}

code_0FDEDD {
    COP [9A] ( #$0010, &code_0FDEE7, &code_0FDECF, &code_0FDECF )
}

code_0FDEE7 {
    COP [28] ( &code_0FDEEF )
    COP [27] ( &code_0FDECF )
}

code_0FDEEF {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$FFF0, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDECF
}

code_0FDF13 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDF21

  code_0FDF1B:
    COP [1B] ( &code_0FDF13, #$0078 )

  loc_0FDF21:
    COP [0C] ( #00, #07, &code_0FDF29 )
    BRA code_0FDF1B
}

code_0FDF29 {
    COP [9A] ( #$0010, &code_0FDF1B, &code_0FDF1B, &code_0FDF33 )
}

code_0FDF33 {
    COP [28] ( &code_0FDF3B )
    COP [27] ( &code_0FDF1B )
}

code_0FDF3B {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$0010, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDF1B
}

code_0FDF61 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDF6F

  code_0FDF69:
    COP [1B] ( &code_0FDF61, #$0078 )

  loc_0FDF6F:
    COP [0C] ( #00, #07, &code_0FDF77 )
    BRA code_0FDF69
}

code_0FDF77 {
    COP [9B] ( #$0010, &code_0FDF81, &code_0FDF69, &code_0FDF69 )
}

code_0FDF81 {
    COP [28] ( &code_0FDF89 )
    COP [27] ( &code_0FDF69 )
}

code_0FDF89 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #03 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$0000, #$FFF0, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDF69
}

code_0FDFAD {
    COP [A3]
    BRK #$64
    LDY #$0005
    SEP #$20
    LDA #$^common_actor_004659_part1.code_002D67
    PHA 
    REP #$20
    LDA #$&common_actor_004659_part1.code_002D67-1
    PHA 
    RTL 
}