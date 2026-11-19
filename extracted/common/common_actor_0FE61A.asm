?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FE61A {
    COP [A5] ( &code_0FE624, &code_0FE670, &code_0FE6BC, &code_0FE70A )
}

code_0FE624 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE632

  code_0FE62C:
    COP [1B] ( &code_0FE624, #$0078 )

  loc_0FE632:
    COP [0C] ( #00, #07, &code_0FE63A )
    BRA code_0FE62C
}

code_0FE63A {
    COP [9B] ( #$0010, &code_0FE62C, &code_0FE62C, &code_0FE644 )
}

code_0FE644 {
    COP [28] ( &code_0FE64C )
    COP [27] ( &code_0FE62C )
}

code_0FE64C {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1D )
    COP [82]
    COP [B2] ( @code_0FE756, #$0000, #$0010, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE62C
}

code_0FE670 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE67E

  code_0FE678:
    COP [1B] ( &code_0FE670, #$0078 )

  loc_0FE67E:
    COP [0C] ( #00, #07, &code_0FE686 )
    BRA code_0FE678
}

code_0FE686 {
    COP [9A] ( #$0010, &code_0FE690, &code_0FE678, &code_0FE678 )
}

code_0FE690 {
    COP [28] ( &code_0FE698 )
    COP [27] ( &code_0FE678 )
}

code_0FE698 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @code_0FE756, #$FFF0, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE678
}

code_0FE6BC {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE6CA

  code_0FE6C4:
    COP [1B] ( &code_0FE6BC, #$0078 )

  loc_0FE6CA:
    COP [0C] ( #00, #07, &code_0FE6D2 )
    BRA code_0FE6C4
}

code_0FE6D2 {
    COP [9A] ( #$0010, &code_0FE6C4, &code_0FE6C4, &code_0FE6DC )
}

code_0FE6DC {
    COP [28] ( &code_0FE6E4 )
    COP [27] ( &code_0FE6C4 )
}

code_0FE6E4 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @code_0FE756, #$0010, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE6C4
}

code_0FE70A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE718

  code_0FE712:
    COP [1B] ( &code_0FE70A, #$0078 )

  loc_0FE718:
    COP [0C] ( #00, #07, &code_0FE720 )
    BRA code_0FE712
}

code_0FE720 {
    COP [9B] ( #$0010, &code_0FE72A, &code_0FE712, &code_0FE712 )
}

code_0FE72A {
    COP [28] ( &code_0FE732 )
    COP [27] ( &code_0FE712 )
}

code_0FE732 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1E )
    COP [82]
    COP [B2] ( @code_0FE756, #$0000, #$FFF0, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE712
}

code_0FE756 {
    COP [A3]
    BRK #$64
    LDY #$0020
    SEP #$20
    LDA #$^common_actor_004659_part1.code_002D67
    PHA 
    REP #$20
    LDA #$&common_actor_004659_part1.code_002D67-1
    PHA 
    RTL 
}