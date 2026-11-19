?BANK 1F

---------------------------------------------

code_0FDE48 {
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [A5] ( &code_0FDE5B, &code_0FDE65, &code_0FDE5B, &code_0FDE65 )
}

code_0FDE5B {
    COP [80] ( #01 )
    COP [82]
    COP [AD] ( #10 )
    BRA code_0FDE5B
}

code_0FDE65 {
    COP [96]

  loc_0FDE67:
    COP [80] ( #00 )
    COP [82]
    COP [AD] ( #10 )
    BRA loc_0FDE67
}