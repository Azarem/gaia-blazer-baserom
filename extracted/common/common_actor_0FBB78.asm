?BANK 1F

---------------------------------------------

code_0FBB78 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBB86

  loc_0FBB80:
    COP [1B] ( &code_0FBB78, #$003C )

  loc_0FBB86:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #22 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [A0] ( #$0048 )
    BRA loc_0FBB80
}