?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FB8DE {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB8EC
    COP [1B] ( &code_0FB8DE, #$0010 )

  loc_0FB8EC:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FB8FF
    DEC 
    BEQ loc_0FB937
    DEC 
    BEQ loc_0FB96C
    BRL loc_0FB9A1

  loc_0FB8FF:
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [23] ( &code_0FB8DE )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #0C )
    COP [82]
    COP [A4]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #0D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRA code_0FB8DE

  loc_0FB937:
    COP [96]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #0C )
    COP [82]
    COP [A4]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #0D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRL code_0FB8DE

  loc_0FB96C:
    COP [97]
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    COP [A4]
    COP [81] ( #0A, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    BRL code_0FB8DE

  loc_0FB9A1:
    COP [97]
    COP [80] ( #00 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [A4]
    COP [81] ( #06, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #05 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    BRL code_0FB8DE
}